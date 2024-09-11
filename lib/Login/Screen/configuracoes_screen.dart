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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sessão Conta
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Conta',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Editar Perfil'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navegar para tela de edição de perfil
              },
            ),
            ListTile(
              leading: Icon(Icons.credit_card),
              title: Text('Assinatura'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navegar para tela de assinatura
              },
            ),
            
            // Sessão Segurança
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Segurança',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: Icon(Icons.lock),
              title: Text('Privacidade'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navegar para tela de privacidade
              },
            ),
            ListTile(
              leading: Icon(Icons.security),
              title: Text('Resetar Senha'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navegar para tela de reset de senha
              },
            ),

            // Sessão Preferências
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Preferências',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notificações'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navegar para tela de notificações
              },
            ),
            ListTile(
              leading: Icon(Icons.color_lens),
              title: Text('Tema'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navegar para tela de tema (claro/escuro)
              },
            ),

            // Sessão Sair
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Sair',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Sair da Conta'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Lógica para sair da conta
              },
            ),
          ],
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
