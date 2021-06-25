import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:speed_controller/admin/adminNavBar.dart';
import 'package:speed_controller/iframework/text_widget.dart';
import 'package:speed_controller/user/screens/files/file_item.dart';
import 'package:speed_controller/widgets/loadingIndicator.dart';

class AdminFines extends StatefulWidget {
  @override
  _AdminFinesState createState() => _AdminFinesState();
}

class _AdminFinesState extends State<AdminFines> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: AdminNavigationDrawer(),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue[900],
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Pending",
              ),
              Tab(
                text: "Paid",
              ),
            ],
          ),
          title: Text('Fines'),
        ),
        body: TabBarView(
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("fines")
                    .where("paid", isEqualTo: false)
                    .orderBy("timestamp", descending: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return LoadingIndicator();
                  if (snapshot.data.docs.length == 0)
                    return Center(
                      child: IText(
                        text: "No Fines",
                      ),
                    );
                  return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => FileItem(
                            id: snapshot.data.docs[index]['address'],
                            address: snapshot.data.docs[index]['uid'],
                            amount: snapshot.data.docs[index]['uid'].toString(),
                            speed:
                                snapshot.data.docs[index]['speed'].toString(),
                            btnText:
                                snapshot.data.docs[index]['amount'].toString() +
                                    " /-",
                            fineDate: DateFormat("dd-MM-yyyy").format(
                              snapshot.data.docs[index]['timestamp'].toDate(),
                            ),
                          ));
                }),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("fines")
                    .where("paid", isEqualTo: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return LoadingIndicator();

                  if (snapshot.data.size == 0)
                    return Center(
                      child: IText(
                        text: "No Fines",
                      ),
                    );
                  return ListView.builder(
                      itemCount: snapshot.data.size,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => FileItem(
                            address: snapshot.data.docs[index]['address'],
                            id: snapshot.data.docs[index].id,
                            amount: snapshot.data.docs[index]['uid'].toString(),
                            speed:
                                snapshot.data.docs[index]['speed'].toString(),
                            btnText: "Paid",
                            fineDate: DateFormat("dd-MM-yyyy").format(
                              snapshot.data.docs[index]['timestamp'].toDate(),
                            ),
                          ));
                }),
          ],
        ),
      ),
    );
  }
}
