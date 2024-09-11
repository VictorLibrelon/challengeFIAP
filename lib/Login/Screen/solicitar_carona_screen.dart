import 'package:flutter/material.dart';
import '../Widget/bottom_navigation_bar.dart'; // O caminho do widget de navegação
import 'package:google_maps_flutter/google_maps_flutter.dart'; // Para o mapa

class SolicitarCaronaScreen extends StatefulWidget {
  @override
  _SolicitarCaronaScreenState createState() => _SolicitarCaronaScreenState();
}

class _SolicitarCaronaScreenState extends State<SolicitarCaronaScreen> {
  int _selectedIndex = 0;
  int _expandedCardIndex = -1; // Controla o índice do card expandido

  List<Map<String, dynamic>> caronas = [
    {'origem': 'A', 'destino': 'B', 'motorista': 'João', 'horario': '10:00'},
    {'origem': 'C', 'destino': 'D', 'motorista': 'Maria', 'horario': '11:00'},
    {'origem': 'E', 'destino': 'F', 'motorista': 'Carlos', 'horario': '12:00'},
    {'origem': 'G', 'destino': 'H', 'motorista': 'Ana', 'horario': '13:00'},
    {'origem': 'I', 'destino': 'J', 'motorista': 'Paulo', 'horario': '14:00'},
    {'origem': 'K', 'destino': 'L', 'motorista': 'Pedro', 'horario': '15:00'},
    {'origem': 'M', 'destino': 'N', 'motorista': 'Luiza', 'horario': '16:00'},
    {'origem': 'O', 'destino': 'P', 'motorista': 'Ricardo', 'horario': '17:00'}
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Função para expandir e mostrar detalhes do card
  void _expandCard(int index) {
    setState(() {
      _expandedCardIndex = _expandedCardIndex == index ? -1 : index;
    });
  }

  // Simulação de função de reserva
  void _reservarCarona(int index) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Carona reservada com ${caronas[index]['motorista']}!'),
    ));

    // Adicionar lógica de reserva e armazenar as informações da carona
  }

  // Simulação de entrar em contato com o motorista
  void _entrarEmContato(int index) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Entrando em contato com ${caronas[index]['motorista']}'),
    ));

    // Implementar a lógica de contato com o motorista
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Solicitar Carona'),
        backgroundColor: const Color(0xFF3cc4ef),
      ),
      body: ListView.builder(
        itemCount: caronas.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Column(
              children: [
                ListTile(
                  title: Text('${caronas[index]['origem']} ➡️ ${caronas[index]['destino']}'),
                  subtitle: Text('Motorista: ${caronas[index]['motorista']} | Horário: ${caronas[index]['horario']}'),
                  onTap: () => _expandCard(index),
                ),
                if (_expandedCardIndex == index)
                  Column(
                    children: [
                      Container(
                        height: 200,
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: LatLng(-23.5505, -46.6333), // Localização exemplo
                            zoom: 12,
                          ),
                          markers: {
                            Marker(
                              markerId: MarkerId('origem'),
                              position: LatLng(-23.5505, -46.6333), // Local de origem
                              infoWindow: InfoWindow(title: 'Origem'),
                            ),
                            Marker(
                              markerId: MarkerId('destino'),
                              position: LatLng(-23.5555, -46.6388), // Local de destino
                              infoWindow: InfoWindow(title: 'Destino'),
                            ),
                          },
                          polylines: {
                            Polyline(
                              polylineId: PolylineId('rota'),
                              color: Colors.blue,
                              points: [
                                LatLng(-23.5505, -46.6333),
                                LatLng(-23.5555, -46.6388),
                              ],
                            ),
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () => _reservarCarona(index),
                              child: Text('Reservar'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF3cc4ef),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () => _entrarEmContato(index),
                              child: Text('Entrar em contato'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF3cc4ef),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          );
        },
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
