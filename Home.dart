import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Clientes extends StatefulWidget {
  @override
  _ClientesState createState() => _ClientesState();
}

class _ClientesState extends State<Clientes> {

  
  Future getClientes() async {
    var firestore = Firestore.instance;

    QuerySnapshot qn = await firestore.collection("clientes").getDocuments();

    return qn.documents;
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.blue,
              actions: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Icon(Icons.search),
                )
              ],
              title: Center(
                child: Text("Clientes"),
              )),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: FutureBuilder(
                    future: getClientes(),
                    builder: (_, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return new Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (_, index) {
                              return Container(
                                height: 60,
                                margin: EdgeInsets.fromLTRB(20, 0, 20, 15),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    stops: [0.015, 0.015],
                                    colors: [Colors.purple, Colors.purple],
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5.0),
                                  ),
                                ),
                                child: Card(
                                  child: ListTile(
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(snapshot.data[index].data["nome"]),
                                        Text(snapshot
                                            .data[index].data["telefone"]),
                                      ],
                                    ),
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Image.network(
                                          "https://cdn2.iconfinder.com/data/icons/ios-7-icons/50/user_male2-128.png"),
                                    ),
                                  ),
                                ),
                              );
                            });
                      }
                    }),
              ),
              )
            ],
          )),
    );
  }
}






