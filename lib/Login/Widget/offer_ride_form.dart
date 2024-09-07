import 'package:flutter/material.dart';

class OfferRideForm extends StatefulWidget {
  final Function(String, String, DateTime) onOffer;
  final String? initialDepartureLocation;
  final String? initialDestinationLocation;
  final DateTime? initialDateTime;

  OfferRideForm({
    required this.onOffer,
    this.initialDepartureLocation,
    this.initialDestinationLocation,
    this.initialDateTime,
  });

  @override
  _OfferRideFormState createState() => _OfferRideFormState();
}

class _OfferRideFormState extends State<OfferRideForm> {
  final _formKey = GlobalKey<FormState>();
  late String _departureLocation;
  late String _destinationLocation;
  late DateTime _dateTime;

  @override
  void initState() {
    super.initState();
    _departureLocation = widget.initialDepartureLocation ?? '';
    _destinationLocation = widget.initialDestinationLocation ?? '';
    _dateTime = widget.initialDateTime ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            initialValue: _departureLocation,
            decoration: InputDecoration(labelText: 'Local de Partida'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, informe o local de partida';
              }
              return null;
            },
            onChanged: (value) {
              _departureLocation = value;
            },
          ),
          TextFormField(
            initialValue: _destinationLocation,
            decoration: InputDecoration(labelText: 'Local de Destino'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, informe o local de destino';
              }
              return null;
            },
            onChanged: (value) {
              _destinationLocation = value;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Data'),
            keyboardType: TextInputType.datetime,
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: _dateTime,
                firstDate: DateTime.now(),
                lastDate: DateTime(2101),
              );
              if (pickedDate != null && pickedDate != _dateTime) {
                setState(() {
                  _dateTime = DateTime(
                    pickedDate.year,
                    pickedDate.month,
                    pickedDate.day,
                    _dateTime.hour,
                    _dateTime.minute,
                  );
                });
              }
            },
            controller: TextEditingController(
              text: '${_dateTime.day}/${_dateTime.month}/${_dateTime.year}',
            ),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Hora'),
            keyboardType: TextInputType.datetime,
            readOnly: true,
            onTap: () async {
              TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.fromDateTime(_dateTime),
              );
              if (pickedTime != null) {
                setState(() {
                  _dateTime = DateTime(
                    _dateTime.year,
                    _dateTime.month,
                    _dateTime.day,
                    pickedTime.hour,
                    pickedTime.minute,
                  );
                });
              }
            },
            controller: TextEditingController(
              text: '${_dateTime.hour}:${_dateTime.minute.toString().padLeft(2, '0')}',
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                widget.onOffer(
                  _departureLocation,
                  _destinationLocation,
                  _dateTime,
                );
              }
            },
            child: Text('Salvar'),
          ),
        ],
      ),
    );
  }
}
