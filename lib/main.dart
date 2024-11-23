// Import Flutter Material package
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Data Hewan',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: AnimalListPage(),
    );
  }
}

class Animal {
  String species;
  String indonesianName;
  String description;
  String imageUrl;

  Animal({
    required this.species,
    required this.indonesianName,
    required this.description,
    required this.imageUrl,
  });
}

class AnimalListPage extends StatefulWidget {
  @override
  _AnimalListPageState createState() => _AnimalListPageState();
}

class _AnimalListPageState extends State<AnimalListPage> {
  List<Animal> animals = [
    Animal(
      species: 'Panthera tigris',
      indonesianName: 'Harimau',
      description: 'Harimau adalah kucing terbesar di dunia.',
      imageUrl: 'https://example.com/tiger.jpg',
    ),
    Animal(
      species: 'Elephas maximus',
      indonesianName: 'Gajah',
      description: 'Gajah adalah hewan darat terbesar.',
      imageUrl: 'https://example.com/elephant.jpg',
    ),
  ];

  void _addAnimal(Animal animal) {
    setState(() {
      animals.add(animal);
    });
  }

  void _editAnimal(int index, Animal updatedAnimal) {
    setState(() {
      animals[index] = updatedAnimal;
    });
  }

  void _deleteAnimal(int index) {
    setState(() {
      animals.removeAt(index);
    });
  }

  void _showAnimalForm({Animal? animal, int? index}) {
    final speciesController = TextEditingController(text: animal?.species);
    final indonesianNameController = TextEditingController(text: animal?.indonesianName);
    final descriptionController = TextEditingController(text: animal?.description);
    final imageUrlController = TextEditingController(text: animal?.imageUrl);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(animal == null ? 'Tambah Hewan' : 'Edit Hewan'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: speciesController,
                  decoration: InputDecoration(labelText: 'Nama Spesies'),
                ),
                TextField(
                  controller: indonesianNameController,
                  decoration: InputDecoration(labelText: 'Nama Indonesia'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: 'Deskripsi'),
                ),
                TextField(
                  controller: imageUrlController,
                  decoration: InputDecoration(labelText: 'URL Gambar'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                final newAnimal = Animal(
                  species: speciesController.text,
                  indonesianName: indonesianNameController.text,
                  description: descriptionController.text,
                  imageUrl: imageUrlController.text,
                );
                if (animal == null) {
                  _addAnimal(newAnimal);
                } else if (index != null) {
                  _editAnimal(index, newAnimal);
                }
                Navigator.pop(context);
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Hewan'),
      ),
      body: ListView.builder(
        itemCount: animals.length,
        itemBuilder: (context, index) {
          final animal = animals[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              leading: Image.network(
                animal.imageUrl,
                width: 50,
                height: 50,
                errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image),
              ),
              title: Text(animal.indonesianName),
              subtitle: Text(animal.description),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => _showAnimalForm(animal: animal, index: index),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteAnimal(index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAnimalForm(),
        child: Icon(Icons.add),
      ),
    );
  }
}
