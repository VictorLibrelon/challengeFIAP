import 'package:flutter/material.dart';
import '../Widget/bottom_navigation_bar.dart';

class KudosScreen extends StatefulWidget {
  @override
  _KudosScreenState createState() => _KudosScreenState();
}

class _KudosScreenState extends State<KudosScreen> {
  int _selectedIndex = 3;
  int userPoints = 1000; // Pontos iniciais do usuário

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Método para mostrar o pop-up de confirmação e subtrair os pontos
  void _redeemGift(int pointsCost) {
    if (userPoints >= pointsCost) {
      setState(() {
        userPoints -= pointsCost;
      });

      _showConfirmationDialog();
    } else {
      _showInsufficientPointsDialog();
    }
  }

  // Pop-up de confirmação
  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 60),
              SizedBox(height: 10),
              Text(
                'Brinde Resgatado!\n\nVocê receberá um e-mail com os próximos passos!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );

    // Fechar automaticamente o pop-up após 2 segundos
    Future.delayed(Duration(seconds: 2), () {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    });
  }

  // Pop-up para pontos insuficientes
  void _showInsufficientPointsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error, color: Colors.red, size: 60),
              SizedBox(height: 10),
              Text(
                'Pontos Insuficientes!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );

    // Fechar automaticamente o pop-up após 2 segundos
    Future.delayed(Duration(seconds: 2), () {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Color(0xFF3cc4ef), // Cor de fundo azul
              padding: EdgeInsets.only(top: 80.0, bottom: 20.0),
              child: Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 80.0,
                      backgroundImage: AssetImage('images/profile.png'),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Pontos: $userPoints',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Lista de brindes
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Duas colunas
                childAspectRatio: 0.75, // Proporção dos cards
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: 6, // Número de brindes
              itemBuilder: (context, index) {
                int pointsCost = (index + 1) * 100; // Custo dos brindes

                return Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Image.asset(
                            'images/brinde${index + 1}.png', // Substitua pelos nomes dos arquivos de imagem dos brindes
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Brinde ${index + 1}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text('Pontos: $pointsCost'),
                        Text('Disponível: ${10 - index}'),
                        SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () => _redeemGift(pointsCost),
                          child: Text('Resgatar'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF3cc4ef), // Cor do botão
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: const Color(0xFF3cc4ef),
        ),
        child: MyBottomNavigationBar(
          currentIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
      ),
    );
  }
}
