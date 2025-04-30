import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'bloc/loyalty_card_bloc.dart';
import 'models/loyalty_card.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/loading_screen.dart';
import 'services/storage_service.dart';
import 'services/firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print('Firebase initialization error: $e');
    // Handle the error appropriately
  }
  
  // Initialize services
  final storageService = StorageService();
  final firebaseService = FirebaseService();
  
  try {
    await storageService.init();
  } catch (e) {
    print('Storage service initialization error: $e');
    // Handle the error appropriately
  }

  runApp(MyApp(
    storageService: storageService,
    firebaseService: firebaseService,
  ));
}

class MyApp extends StatelessWidget {
  final StorageService storageService;
  final FirebaseService firebaseService;

  const MyApp({
    Key? key,
    required this.storageService,
    required this.firebaseService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoyaltyCardBloc(storageService),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Loyalty Card Wallet',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.light,
          ),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            elevation: 0,
          ),
          cardTheme: CardTheme(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            elevation: 0,
          ),
          cardTheme: CardTheme(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingScreen();
            }
            
            if (snapshot.hasData) {
              return const HomeScreen();
            }
            
            return const LoginScreen();
          },
        ),
        routes: {
          '/home': (context) => const HomeScreen(),
          '/login': (context) => const LoginScreen(),
        },
      ),
    );
  }
}
