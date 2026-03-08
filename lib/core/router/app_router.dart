import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import 'scaffold_with_nav_bar.dart';

// AUTH
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/signup_screen.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';

// HOME / PRODUCT
import '../../features/product/presentation/screens/home_screen.dart';
import '../../features/product/presentation/screens/explore_screen.dart';
import '../../features/product/presentation/screens/category_screen.dart';
import '../../features/product/presentation/screens/product_list_screen.dart';
import '../../features/product/presentation/screens/product_details_screen.dart';
import '../../features/product/presentation/screens/wishlist_screen.dart';

// CART / ORDER
import '../../features/cart/presentation/screens/cart_screen.dart';
import '../../features/cart/presentation/screens/address_list_screen.dart';
import '../../features/cart/presentation/screens/add_address_screen.dart';
import '../../features/order/presentation/screens/checkout_screen.dart';
import '../../features/order/presentation/screens/orders_history_screen.dart';

// PROFILE
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/profile/presentation/screens/settings_screen.dart';
import '../../features/profile/presentation/screens/edit_profile_screen.dart';

// NOTIFICATION
import '../../features/notification/presentation/screens/notification_screen.dart';

// ADMIN
import '../../features/admin/presentation/screens/admin_dashboard_screen.dart';
import '../../features/admin/presentation/screens/admin_products_list_screen.dart';
import '../../features/admin/presentation/screens/admin_add_edit_product_screen.dart';
import '../../features/admin/presentation/screens/admin_orders_list_screen.dart';
import '../../features/product/domain/entities/product_entity.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    // ============================================================
    // SPLASH & AUTH (NO BOTTOM NAV)
    // ============================================================
    GoRoute(path: '/', builder: (_, __) => const SplashScreen()),
    GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
    GoRoute(path: '/signup', builder: (_, __) => const SignUpScreen()),
    GoRoute(
      path: '/forgot-password',
      builder: (_, __) => const ForgotPasswordScreen(),
    ),

    // ============================================================
    // MAIN APP WITH BOTTOM NAV
    // ============================================================
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNavBar(navigationShell: navigationShell);
      },
      branches: [
        // ---------------- HOME ----------------
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (_, __) => const HomeScreen(),
              routes: [
                GoRoute(
                  path: 'product/:id',
                  builder: (_, state) => ProductDetailsScreen(
                    productId: state.pathParameters['id']!,
                  ),
                ),
                GoRoute(
                  path: 'notifications',
                  builder: (_, __) => const NotificationScreen(),
                ),
              ],
            ),
          ],
        ),

        // ---------------- EXPLORE ----------------
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/explore',
              builder: (_, __) => const ExploreScreen(),
              routes: [
                GoRoute(
                  path: 'category',
                  builder: (_, state) {
                    final category = state.extra as String?;
                    return CategoryScreen(initialCategory: category);
                  },
                ),
                GoRoute(
                  path: 'products',
                  builder: (_, __) => const ProductListScreen(),
                ),
                GoRoute(
                  name: 'productDetails',
                  path: 'product/:id',
                  builder: (_, state) => ProductDetailsScreen(
                    productId: state.pathParameters['id']!,
                  ),
                ),
                GoRoute(
                  path: 'wishlist',
                  builder: (_, __) => const WishlistScreen(),
                ),
              ],
            ),
          ],
        ),

        // ---------------- CART ----------------
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/cart',
              builder: (_, __) => const CartScreen(),
              routes: [
                GoRoute(
                  path: 'checkout',
                  builder: (_, __) => const CheckoutScreen(),
                ),
                GoRoute(
                  path: 'addresses',
                  builder: (_, __) => const AddressListScreen(),
                  routes: [
                    GoRoute(
                      path: 'add',
                      builder: (_, __) => const AddAddressScreen(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),

        // ---------------- ORDERS ----------------
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/orders',
              builder: (_, __) => const OrdersHistoryScreen(),
            ),
          ],
        ),

        // ---------------- PROFILE ----------------
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (_, __) => const ProfileScreen(),
              routes: [
                GoRoute(
                  path: 'settings',
                  builder: (_, __) => const SettingsScreen(),
                ),
                GoRoute(
                  path: 'edit',
                  builder: (_, __) => const EditProfileScreen(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),

    // ============================================================
    // ADMIN (NO BOTTOM NAV)
    // ============================================================
    GoRoute(
      path: '/admin',
      builder: (_, __) => const AdminDashboardScreen(),
      routes: [
        GoRoute(
          path: 'products',
          builder: (_, __) => const AdminProductsListScreen(),
        ),
        GoRoute(
          path: 'product/add',
          builder: (_, __) => const AdminAddEditProductScreen(),
        ),
        GoRoute(
          path: 'product/edit/:id',
          builder: (_, state) {
            final product = state.extra as ProductEntity?;
            return AdminAddEditProductScreen(product: product);
          },
        ),
        GoRoute(
          path: 'orders',
          builder: (_, __) => const AdminOrdersListScreen(),
        ),
      ],
    ),
  ],
);
