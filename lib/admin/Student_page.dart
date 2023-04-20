import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StudentRayaPage extends StatefulWidget {
  const StudentRayaPage({Key? key}) : super(key: key);

  @override
  State<StudentRayaPage> createState() => _StudentRayaPageState();
}

class _StudentRayaPageState extends State<StudentRayaPage> {
  late final Query _query = FirebaseFirestore.instance.collection('Users');
  late final Stream<QuerySnapshot> _stream = _query.snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Raya'),
        centerTitle: true,
        backgroundColor: Colors.green[900],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return AnimatedList(
            initialItemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index, animation) {
              final DocumentSnapshot document = snapshot.data!.docs[index];
              final data = document.data() as Map<String, dynamic>;
              final profilePic = data.containsKey('profilePic')
                  ? data['profilePic'] as String?
                  : null;
              final name =
                  data.containsKey('name') ? data['name'] as String? : null;
              return Card(
                child: ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Colors.white,
                    )),
                    child: profilePic == null
                        ? const Icon(Icons.person)
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image(
                              fit: BoxFit.cover,
                              image: NetworkImage(profilePic),
                            ),
                          ),
                  ),
                  title: name == null ? const Text('no name') : Text(name),
                  subtitle: Text(data['email'] as String),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
