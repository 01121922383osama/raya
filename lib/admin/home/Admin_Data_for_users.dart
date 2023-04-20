import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:raya/Features/constens/conestans.dart';

class AdminDataForUsers extends StatefulWidget {
  const AdminDataForUsers({super.key});

  @override
  State<AdminDataForUsers> createState() => _AdminDataForUsersState();
}

class _AdminDataForUsersState extends State<AdminDataForUsers> {
  late final Query _query =
      FirebaseFirestore.instance.collection('DataOfUsers');
  late final Stream<QuerySnapshot> _stream = _query.snapshots();
  late String _searchQuery = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KAppBarColors,
        title: StreamBuilder<QuerySnapshot>(
          stream: _stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Text('Data');
            }
            final totalData = snapshot.data!.docs.length;
            return Text('Raya  Students ( $totalData )');
          },
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              cursorColor: Colors.red,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: '...البحث',
                hintStyle: const TextStyle(color: Colors.black),
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.grey[600]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.white),
                ),
              ),
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              style: const TextStyle(color: Colors.black),
              enableSuggestions: true,
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _query
                  .where('name', isGreaterThanOrEqualTo: _searchQuery)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final List<Map<String, dynamic>> dataList = [];
                for (var document in snapshot.data!.docs) {
                  final data = document.data() as Map<String, dynamic>;
                  dataList.add(data);
                }
                return ListView.builder(
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    final data = dataList[index];
                    final age = data['age'] as String?;
                    final code = data['code'] as String?;
                    final division = data['division'] as String?;
                    final name = data['name'] as String?;
                    final squad = data['squad'] as String?;
                    final payments = data['payments'] as String?;
                    return SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Card(
                        color: Colors.orange,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '( ${index + 1} )',
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              Text('الاسم: $name',
                                  style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 8.0),
                              Text(
                                'العمر:  $age',
                                style: const TextStyle(fontSize: 16.0),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                'الشعبه:  $division',
                                style: const TextStyle(fontSize: 16.0),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                'الفرقه:  $squad',
                                style: const TextStyle(fontSize: 16.0),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                'المدفوعات : $payments',
                                style: const TextStyle(fontSize: 16.0),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                'الكود الخاص بالطالب:   $code',
                                style: const TextStyle(fontSize: 16.0),
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      _showConfirmationDialog(data['code']);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showConfirmationDialog(String? code) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      title: 'هل انت متأكد؟',
      desc: 'هل تريد حقًا حذف هذه البيانات؟',
      btnOk: ElevatedButton(
        onPressed: () {
          // Delete the data from Firestore using the code field as the identifier
          FirebaseFirestore.instance
              .collection('DataOfUsers')
              .where('code', isEqualTo: code)
              .get()
              .then((snapshot) {
            snapshot.docs.first.reference.delete();
          });

          Navigator.pop(context);
        },
        child: const Text('نعم'),
      ),
      btnCancel: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('لا'),
      ),
    ).show();
  }
}
