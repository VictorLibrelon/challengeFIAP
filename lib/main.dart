import 'package:fiap_challenge_project/Login/Screen/solicitar_carona_screen.dart';
import 'package:flutter/material.dart';
import 'package:fiap_challenge_project/Login/Screen/home_screen.dart';
import 'package:fiap_challenge_project/Login/Screen/login.dart';
import 'package:fiap_challenge_project/Login/Screen/carona_screen.dart';
import 'package:fiap_challenge_project/Login/Screen/kudos_screen.dart';
import 'package:fiap_challenge_project/Login/Screen/configuracoes_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'Login/Services/carona_provider.dart'; // Importar o CaronaProvider

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    ChangeNotifierProvider(
      create: (context) =>
          CaronaProvider(), // Criar uma instância do CaronaProvider
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/home': (context) => HomeScreen(),
        '/carona': (context) => CaronaScreen(),
        '/solicitar': (context) => SolicitarCaronaScreen(),
        '/kudos': (context) => KudosScreen(),
        '/configuracoes': (context) => ConfiguracoesScreen(),
        '/login': (context) => const LoginScreen(),
      },
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeScreen();
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
