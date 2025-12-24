import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:pinput/pinput.dart';
import 'package:go_router/go_router.dart';

import '../controllers/auth_controller.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _obscure = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      ref
          .read(authControllerProvider.notifier)
          .login(_emailController.text.trim(), _passwordController.text);
    }
  }

  Future<void> _handleGoogleLogin() async {
    await ref.read(authControllerProvider.notifier).signInWithGoogle();
  }

  void _startPhoneAuth() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        String countryCode = '+91';
        final phoneCtrl = TextEditingController();

        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 24,
            right: 24,
            top: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Phone Login',
                style: AppTextStyles.headingMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  CountryCodePicker(
                    onChanged: (country) {
                      countryCode = country.dialCode ?? '+91';
                    },
                    initialSelection: 'IN',
                    favorite: const ['+91', 'US'],
                    showCountryOnly: false,
                    showOnlyCountryWhenClosed: false,
                    alignLeft: false,
                  ),
                  Expanded(
                    child: TextField(
                      controller: phoneCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (phoneCtrl.text.isNotEmpty) {
                    Navigator.pop(context);
                    final fullNumber = '$countryCode${phoneCtrl.text.trim()}';
                    _verifyPhone(fullNumber);
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Send Code'),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  void _verifyPhone(String phone) {
    ref
        .read(authControllerProvider.notifier)
        .verifyPhoneNumber(
          phone,
          onCodeSent: (verId) {
            _showOtpDialog(verId, phone);
          },
          onVerificationFailed: (err) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(err), backgroundColor: Colors.red),
            );
          },
        );
  }

  void _showOtpDialog(String verId, String phoneNumber) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final otpCtrl = TextEditingController();
        final defaultPinTheme = PinTheme(
          width: 56,
          height: 56,
          textStyle: const TextStyle(
            fontSize: 20,
            color: Color.fromRGBO(30, 60, 87, 1),
            fontWeight: FontWeight.w600,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
            borderRadius: BorderRadius.circular(20),
          ),
        );

        final focusedPinTheme = defaultPinTheme.copyDecorationWith(
          border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
          borderRadius: BorderRadius.circular(8),
        );

        final submittedPinTheme = defaultPinTheme.copyWith(
          decoration: defaultPinTheme.decoration?.copyWith(
            color: const Color.fromRGBO(234, 239, 243, 1),
          ),
        );

        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 24,
            right: 24,
            top: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Verification', style: AppTextStyles.headingMedium),
              const SizedBox(height: 8),
              Text(
                'Enter the code sent to $phoneNumber',
                style: AppTextStyles.bodySecondary,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Pinput(
                length: 6,
                controller: otpCtrl,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                showCursor: true,
                onCompleted: (pin) {
                  Navigator.pop(context);
                  ref
                      .read(authControllerProvider.notifier)
                      .signInWithPhone(verId, pin);
                },
              ),
              const SizedBox(height: 32),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Logic to resend could be added here if supported
                  _verifyPhone(phoneNumber);
                },
                child: const Text('Resend Code'),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    ref.listen(authControllerProvider, (_, next) {
      if (next.hasValue && next.value != null) {
        context.go('/home');
      }
      if (next.hasError) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.error.toString())));
      }
    });

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary, Color(0xFF3949AB)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 8),

                        /// LOGO / ICON
                        const Icon(
                          Icons.rocket_launch_rounded,
                          size: 64,
                          color: AppColors.primary,
                        ),

                        const SizedBox(height: 16),

                        Text(
                          'Welcome Back',
                          style: AppTextStyles.headingLarge,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Login to continue shopping',
                          style: AppTextStyles.bodySecondary,
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 32),

                        /// EMAIL
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                          validator: (v) =>
                              v == null || v.isEmpty ? 'Email required' : null,
                        ),

                        const SizedBox(height: 16),

                        /// PASSWORD
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscure,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock_outline_rounded),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscure
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () =>
                                  setState(() => _obscure = !_obscure),
                            ),
                          ),
                          validator: (v) => v == null || v.isEmpty
                              ? 'Password required'
                              : null,
                        ),

                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () => context.push('/forgot-password'),
                            child: const Text('Forgot password?'),
                          ),
                        ),

                        const SizedBox(height: 16),

                        /// LOGIN BUTTON
                        SizedBox(
                          height: 52,
                          child: ElevatedButton(
                            onPressed: authState.isLoading ? null : _submit,
                            child: authState.isLoading
                                ? const SizedBox(
                                    height: 22,
                                    width: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text(
                                    'Login',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        const Row(
                          children: [
                            Expanded(child: Divider()),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text('OR'),
                            ),
                            Expanded(child: Divider()),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _SocialButton(
                              icon: Icons.g_mobiledata,
                              label: 'Google',
                              onPressed: authState.isLoading
                                  ? null
                                  : _handleGoogleLogin,
                            ),
                            _SocialButton(
                              icon: Icons.phone,
                              label: 'Phone',
                              onPressed: authState.isLoading
                                  ? null
                                  : _startPhoneAuth,
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        /// SIGN UP
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('New here?'),
                            TextButton(
                              onPressed: () => context.push('/signup'),
                              child: const Text('Create Account'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;

  const _SocialButton({
    required this.icon,
    required this.label,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    );
  }
}
