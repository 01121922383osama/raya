import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late TextEditingController seachtf;
  late Stream<QuerySnapshot> _usersStream;

  @override
  void initState() {
    super.initState();
    seachtf = TextEditingController();
    _usersStream = FirebaseFirestore.instance
        .collection('DataOfUsers')
        .where(
          'name',
          isEqualTo: seachtf.text,
        )
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.only(
            left: 20,
            right: 10,
          ),
          child: TextField(
            controller: seachtf,
            decoration: const InputDecoration(
              hintText: 'Search',
            ),
            onChanged: (value) {
              setState(() {
                _usersStream = FirebaseFirestore.instance
                    .collection('DataOfUsers')
                    .where(
                      'name',
                      isEqualTo: seachtf.text,
                    )
                    .snapshots();
              });
            },
          ),
        ),
      ),
      body: StreamBuilder(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong.");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (_, index) {
                return Card(
                  child: ListTile(
                    title: Text(
                      snapshot.data!.docs[index]['name'],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
