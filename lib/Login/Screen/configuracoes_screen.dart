import 'package:flutter/material.dart';
import '../Widget/bottom_navigation_bar.dart'; // Corrija o caminho se necessário

class ConfiguracoesScreen extends StatefulWidget {
  @override
  _ConfiguracoesScreenState createState() => _ConfiguracoesScreenState();
}

class _ConfiguracoesScreenState extends State<ConfiguracoesScreen> {
  int _selectedIndex = 4;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
        backgroundColor: const Color(0xFF3cc4ef),
      ),
      body: const Center(
        child: Text(
          'Você está na tela de Configurações',
          style: TextStyle(fontSize: 24),
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: const Color(0xFF3cc4ef), // Cor de fundo azul
        ),
        child: MyBottomNavigationBar(
          currentIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
      ),
    );
  }
}
