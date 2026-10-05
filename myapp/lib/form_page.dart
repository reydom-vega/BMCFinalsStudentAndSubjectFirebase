import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController sectionController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController subject1Controller = TextEditingController();
  final TextEditingController schedule1Controller = TextEditingController();
  final TextEditingController subject2Controller = TextEditingController();
  final TextEditingController schedule2Controller = TextEditingController();
  final TextEditingController subject3Controller = TextEditingController();
  final TextEditingController schedule3Controller = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> saveData() async {
    if (nameController.text.trim().isEmpty ||
        sectionController.text.trim().isEmpty ||
        yearController.text.trim().isEmpty ||
        subject1Controller.text.trim().isEmpty ||
        schedule1Controller.text.trim().isEmpty ||
        subject2Controller.text.trim().isEmpty ||
        schedule2Controller.text.trim().isEmpty ||
        subject3Controller.text.trim().isEmpty ||
        schedule3Controller.text.trim().isEmpty) {
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
        ),
      );
      return;
    }

    await firestore.collection('biodata').add({
      'Name': nameController.text.trim(),
      'Section': sectionController.text.trim(),
      'Year': yearController.text.trim(),
      'Subject1': subject1Controller.text.trim(),
      'Schedule1': schedule1Controller.text.trim(),
      'Subject2': subject2Controller.text.trim(),
      'Schedule2': schedule2Controller.text.trim(),
      'Subject3': subject3Controller.text.trim(),
      'Schedule3': schedule3Controller.text.trim(),
      'createdAt': FieldValue.serverTimestamp(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Data Saved Successfully'),
      ),
    );
    nameController.clear();
    sectionController.clear();
    yearController.clear();
    subject1Controller.clear();
    schedule1Controller.clear();
    subject2Controller.clear();
    schedule2Controller.clear();
    subject3Controller.clear();
    schedule3Controller.clear();
  }

  @override
  void dispose() {
    nameController.dispose();
    sectionController.dispose();
    yearController.dispose();
    subject1Controller.dispose();
    schedule1Controller.dispose();
    subject2Controller.dispose();
    schedule2Controller.dispose();
    subject3Controller.dispose();
    schedule3Controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Student Registration'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            // Name
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            // Section
            TextField(
              controller: sectionController,
              decoration: const InputDecoration(
                labelText: 'Section',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            // Year
            TextField(
              controller: yearController,
              decoration: const InputDecoration(
                labelText: 'Year',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            // Next Button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecondScreen(
                      nameController: nameController,
                      sectionController: sectionController,
                      yearController: yearController,
                      subject1Controller: subject1Controller,
                      schedule1Controller: schedule1Controller,
                      subject2Controller: subject2Controller,
                      schedule2Controller: schedule2Controller,
                      subject3Controller: subject3Controller,
                      schedule3Controller: schedule3Controller,
                      saveData: saveData,
                    ),
                  ),
                );
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController sectionController;
  final TextEditingController yearController;
  final TextEditingController subject1Controller;
  final TextEditingController schedule1Controller;
  final TextEditingController subject2Controller;
  final TextEditingController schedule2Controller;
  final TextEditingController subject3Controller;
  final TextEditingController schedule3Controller;
  final Future<void> Function() saveData;

  const SecondScreen({
    super.key,
    required this.nameController,
    required this.sectionController,
    required this.yearController,
    required this.subject1Controller,
    required this.schedule1Controller,
    required this.subject2Controller,
    required this.schedule2Controller,
    required this.subject3Controller,
    required this.schedule3Controller,
    required this.saveData,
  });

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}


class _SecondScreenState extends State<SecondScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Subject Schedule'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            const SizedBox(height: 24),
            TextField(
              controller: widget.subject1Controller,
              decoration: const InputDecoration(
                labelText: 'Subject 1',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),
            TextField(
              controller: widget.schedule1Controller,
              decoration: const InputDecoration(
                labelText: 'Schedule 1',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),
            TextField(
              controller: widget.subject2Controller,
              decoration: const InputDecoration(
                labelText: 'Subject 2',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),
            TextField(
              controller: widget.schedule2Controller,
              decoration: const InputDecoration(
                labelText: 'Schedule 2',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),
            TextField(
              controller: widget.subject3Controller,
              decoration: const InputDecoration(
                labelText: 'Subject 3',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),
            TextField(
              controller: widget.schedule3Controller,
              decoration: const InputDecoration(
                labelText: 'Schedule 3',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: widget.saveData,
              child: const Text('Save to Firebase'),
            ),
          ],
        ),
      ),
    );
  }
}