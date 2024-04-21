import 'package:flutter/material.dart';

void main() {
  runApp(MedicationReminderApp());
}

class MedicationReminderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medication Reminder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MedicationList(),
    );
  }
}

class MedicationList extends StatefulWidget {
  @override
  _MedicationListState createState() => _MedicationListState();
}

class _MedicationListState extends State<MedicationList> {
  List<Medication> medications = [];

  void _addMedication(String name, String dosage, String schedule) {
    setState(() {
      medications
          .add(Medication(name: name, dosage: dosage, schedule: schedule));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medication Reminder'),
      ),
      body: ListView.builder(
        itemCount: medications.length,
        itemBuilder: (BuildContext context, int index) {
          Medication medication = medications[index];
          return ListTile(
            title: Text(medication.name),
            subtitle: Text(
                'Dosage: ${medication.dosage}, Schedule: ${medication.schedule}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showMedicationDialog(context);
        },
        tooltip: 'Add Medication',
        child: Icon(Icons.add),
      ),
    );
  }

  void _showMedicationDialog(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController dosageController = TextEditingController();
    TextEditingController scheduleController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Medication'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Medication Name'),
              ),
              TextField(
                controller: dosageController,
                decoration: InputDecoration(labelText: 'Dosage'),
              ),
              TextField(
                controller: scheduleController,
                decoration: InputDecoration(labelText: 'Schedule'),
              ),
              ElevatedButton(
                onPressed: () {
                  _addMedication(
                    nameController.text,
                    dosageController.text,
                    scheduleController.text,
                  );
                  Navigator.of(context).pop();
                },
                child: Text('Add Medication'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class Medication {
  final String name;
  final String dosage;
  final String schedule;

  Medication(
      {required this.name, required this.dosage, required this.schedule});
}
