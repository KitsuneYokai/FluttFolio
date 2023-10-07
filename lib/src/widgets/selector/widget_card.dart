import 'package:flutter/material.dart';

class WidgetCard extends StatelessWidget {
  final String name;
  final String description;
  final dynamic icon;
  final Map<String, dynamic> jsonWidget;

  const WidgetCard(
      {super.key,
      required this.name,
      required this.description,
      required this.icon,
      required this.jsonWidget});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: Colors.black,
      color: Theme.of(context).primaryColor,
      child: SizedBox(
        width: 400,
        height: 250,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              icon,
              Text(
                description,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, jsonWidget);
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green)),
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
