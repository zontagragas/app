import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarApp extends StatefulWidget {
  @override
  _CalendarAppState createState() => _CalendarAppState();
}

class _CalendarAppState extends State<CalendarApp> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Takvim'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat('dd/MM/yyyy').format(_selectedDate),
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _selectDate(context);
              },
              child: Text('Tarih Seç'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
}
