import 'package:flutter/material.dart';
import 'on_item_tapped.dart'; // Importe a função handleItemTapped

class MyBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onItemTapped;

  const MyBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    print('Building MyBottomNavigationBar'); // Depuração

    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.directions_car),
          label: 'Oferecer Carona',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_box),
          label: 'Solicitar Carona',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.card_giftcard),
          label: 'Kudos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Configurações',
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white.withOpacity(0.7),
      backgroundColor: const Color(0xFF3cc4ef), // Cor de fundo azul
      onTap: (index) {
        handleItemTapped(context, index, onItemTapped);
      },
    );
  }
}
