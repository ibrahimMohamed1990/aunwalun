import 'package:Aunwanlun/features/orders/presentation/screens/order_form_screen.dart';
import 'package:Aunwanlun/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/storage/local_storage.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/screens/splash_screen.dart';
import 'features/auth/presentation/screens/welcome_screen.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/auth/presentation/screens/otp_screen.dart';
import 'features/auth/presentation/screens/register_screen.dart';
import 'features/home/presentation/screens/home_screen.dart';
import 'features/home/presentation/screens/search_results_screen.dart';
import 'features/profile/presentation/screens/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [localStorageProvider.overrideWithValue(LocalStorage(prefs))],
      child: const AunwalunApp(),
    ),
  );
}

class AunwalunApp extends ConsumerWidget {
  const AunwalunApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'عون ولون',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          locale: const Locale('ar', 'SA'),
          supportedLocales: const [Locale('ar', 'SA'), Locale('en', 'US')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          builder: (context, widget) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: widget!,
            );
          },
          initialRoute: '/',
          routes: {
            '/': (context) => const SplashScreen(),
            '/welcome': (context) => const WelcomeScreen(),
            '/login': (context) => const LoginScreen(),
            '/otp': (context) => const OtpScreen(),
            '/register': (context) => const RegisterScreen(),
            '/home': (context) => const HomeScreen(),
            '/search-results': (context) => const SearchResultsScreen(),
            '/profile': (context) => const ProfileScreen(),
            '/edit-profile': (context) => const EditProfileScreen(),
            '/order-form': (context) => const OrderFormScreen(),
          },
        );
      },
    );
  }
}
