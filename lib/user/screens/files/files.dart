import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:speed_controller/iframework/container.dart';
import 'package:speed_controller/iframework/text_widget.dart';
import 'package:speed_controller/user/screens/dashboard/top_card_tile.dart';
import 'package:speed_controller/user/screens/files/file_item.dart';
import 'package:speed_controller/user/screens/navigation_drawer.dart';
import 'package:speed_controller/widgets/loadingIndicator.dart';

class Files extends StatefulWidget {
  @override
  _FilesState createState() => _FilesState();
}

class _FilesState extends State<Files> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: NavigationDrawer(),
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
                    .where("uid", isEqualTo: "1")
                    .where("paid", isEqualTo: false)
                    .orderBy("timestamp", descending: true)
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
                            id: snapshot.data.docs[index].id,
                            address: snapshot.data.docs[index]['address'],
                            amount:
                                snapshot.data.docs[index]['amount'].toString(),
                            speed:
                                snapshot.data.docs[index]['speed'].toString(),
                            btnText: "Pay",
                            fineDate: DateFormat("dd-MM-yyyy").format(
                              snapshot.data.docs[index]['timestamp'].toDate(),
                            ),
                          ));
                }),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("fines")
                    .where("uid", isEqualTo: "1")
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
                            amount:
                                snapshot.data.docs[index]['amount'].toString(),
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
