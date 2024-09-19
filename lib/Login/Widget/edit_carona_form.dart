import 'package:flutter/material.dart';
import '../Model/carona_model.dart';

class EditCaronaForm extends StatefulWidget {
  final Carona carona;
  final Function(Carona) onEdit;

  EditCaronaForm({
    required this.carona,
    required this.onEdit,
  });

  @override
  _EditCaronaFormState createState() => _EditCaronaFormState();
}

class _EditCaronaFormState extends State<EditCaronaForm> {
  late TextEditingController _departureController;
  late TextEditingController _destinationController;
  late DateTime _selectedDateTime;

  @override
  void initState() {
    super.initState();
    _departureController =
        TextEditingController(text: widget.carona.departureLocation);
    _destinationController =
        TextEditingController(text: widget.carona.destinationLocation);
    _selectedDateTime = widget.carona.dateTime;
  }

  @override
  void dispose() {
    _departureController.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDateTime) {
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
      );
      if (time != null) {
        setState(() {
          _selectedDateTime = DateTime(
              picked.year, picked.month, picked.day, time.hour, time.minute);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Editar Carona'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _departureController,
            decoration: InputDecoration(labelText: 'Local de Partida'),
          ),
          TextField(
            controller: _destinationController,
            decoration: InputDecoration(labelText: 'Destino'),
          ),
          SizedBox(height: 16.0),
          Row(
            children: [
              Text(
                  'Horário: ${_selectedDateTime.hour}:${_selectedDateTime.minute.toString().padLeft(2, '0')}'),
              Spacer(),
              TextButton(
                onPressed: () => _selectDateTime(context),
                child: Text('Selecionar Horário'),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Salvar'),
          onPressed: () {
            final editedCarona = Carona(
              departureLocation: _departureController.text,
              destinationLocation: _destinationController.text,
              dateTime: _selectedDateTime,
              motoristaNome: 'Victor Librelon', profileImageUrl: 'images/profile.png',
            );
            widget.onEdit(editedCarona);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
