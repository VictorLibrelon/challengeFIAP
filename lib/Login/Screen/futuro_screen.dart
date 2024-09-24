import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EscolherTransporteScreen extends StatefulWidget {
  @override
  _EscolherTransporteScreenState createState() =>
      _EscolherTransporteScreenState();
}

class _EscolherTransporteScreenState extends State<EscolherTransporteScreen> {
  String _pontoPartida = '';
  String _destino = '';
  bool _exibirCards = false;
  int _expandedCardIndex = -1; // Controla qual card está expandido
  DateTime _horarioAtual = DateTime.now();

  // Calcula o horário 30 minutos após o horário atual
  String _getHorarioSaida() {
    final DateTime saida = _horarioAtual.add(Duration(minutes: 30));
    return DateFormat('HH:mm').format(saida);
  }

  // Ícones de transporte
  Widget _buildIcon(String tipo) {
    switch (tipo) {
      case 'Uber':
        return Icon(Icons.directions_car, color: Colors.black);
      case '99':
        return Icon(Icons.local_taxi, color: Colors.yellow);
      case 'Transporte Público':
        return Icon(Icons.directions_bus, color: Colors.black);
      case 'Carona':
        return Icon(Icons.directions_car, color: Colors.blue);
      default:
        return Icon(Icons.directions_car, color: Colors.grey);
    }
  }

  // Card com opções de transporte
  Widget _buildTransporteCard(String tipo, String preco, String tempo) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: ListTile(
        leading: _buildIcon(tipo),
        title: Text(tipo),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Preço: $preco', style: TextStyle(color: Colors.green)),
            Text('Tempo estimado: $tempo'),
          ],
        ),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          // Ação ao escolher o transporte
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MapaEscolhaScreen(tipo: tipo),
            ),
          );
        },
      ),
    );
  }

  // Card de saída e destino
  Widget _buildMainCard(int index) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.access_time, color: Colors.black),
            title: Text('Saída: ${_getHorarioSaida()}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Partida: $_pontoPartida'),
                Text('Destino: $_destino'),
              ],
            ),
            trailing: Icon(Icons.menu),
            onTap: () {
              setState(() {
                _expandedCardIndex = _expandedCardIndex == index ? -1 : index;
              });
            },
          ),
          if (_expandedCardIndex ==
              index) // Exibir opções de transporte se o card estiver expandido
            Column(
              children: [
                _buildTransporteCard('Carona', 'Gratuito', '30 min'),
                _buildTransporteCard('Uber', 'R\$ 25,00', '20 min'),
                _buildTransporteCard('99', 'R\$ 22,00', '18 min'),
                _buildTransporteCard(
                    'Transporte Público', 'R\$ 4,50', '45 min'),
              ],
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesquisar Transporte'),
        backgroundColor: const Color(0xFF3cc4ef),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input do ponto de partida
            TextField(
              decoration: InputDecoration(labelText: 'Ponto de partida'),
              onChanged: (value) {
                setState(() {
                  _pontoPartida = value;
                });
              },
            ),
            // Input do destino
            TextField(
              decoration: InputDecoration(labelText: 'Destino'),
              onChanged: (value) {
                setState(() {
                  _destino = value;
                });
              },
            ),
            SizedBox(height: 20),
            // Botão de pesquisa
            ElevatedButton(
              onPressed: () {
                if (_pontoPartida.isNotEmpty && _destino.isNotEmpty) {
                  setState(() {
                    _exibirCards = true; // Exibir os cards após a pesquisa
                  });
                } else {
                  // Exibe um aviso caso o usuário tente pesquisar sem preencher os campos
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Preencha ambos os campos!')),
                  );
                }
              },
              child: Text('Pesquisar', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3cc4ef),
              ),
            ),
            SizedBox(height: 20),
            // Exibir cards apenas após a pesquisa
            if (_exibirCards)
              Expanded(
                child: ListView(
                  children: [
                    _buildMainCard(0),
                    _buildMainCard(1),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class MapaEscolhaScreen extends StatelessWidget {
  final String tipo;

  MapaEscolhaScreen({required this.tipo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Escolher $tipo'),
        backgroundColor: const Color(0xFF3cc4ef),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Aqui vai o mapa com a rota escolhida para $tipo'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Ação de escolher transporte
              },
              child: Text('Escolher $tipo'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF3cc4ef),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
