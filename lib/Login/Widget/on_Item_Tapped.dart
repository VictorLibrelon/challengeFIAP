import 'package:flutter/material.dart';

import '../Screen/solicitar_carona_screen.dart';

void handleItemTapped(
    BuildContext context, int index, ValueChanged<int> onItemTapped) {
  // Atualize o índice selecionado
  onItemTapped(index);

  // Navegação para as telas específicas
  switch (index) {
    case 0:
      Navigator.pushReplacementNamed(context, '/home');
      break;
    case 1:
      Navigator.pushReplacementNamed(context, '/carona');
      break;
    case 2:
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SolicitarCaronaScreen()),
      );
      break;
    case 3:
      Navigator.pushReplacementNamed(context, '/kudos');
      break;
    case 4:
      Navigator.pushReplacementNamed(context, '/configuracoes');
      break;
  }
}
