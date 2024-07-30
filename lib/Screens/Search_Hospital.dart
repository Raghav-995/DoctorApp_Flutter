import 'package:flutter/material.dart';
import '../Assets/Messages.dart' as message;

class SearchHospital extends StatefulWidget {
  const SearchHospital({super.key});

  @override
  State<SearchHospital> createState() => _SearchHospitalState();
}

class _SearchHospitalState extends State<SearchHospital> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey[700],
        ),
        title: Text(
          "Add Hospital",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.grey[700], fontSize: 25),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_outlined,
              color: Colors.grey[700],
              size: 30,
            ),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    elevation: 5,
                    margin: const EdgeInsets.all(2),
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: ListTile(
                          title: TextFormField(
                            decoration: InputDecoration(
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              hintStyle: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Colors.grey[400]),
                              hintText: message.Search,
                              prefixIcon: Icon(Icons.search,color: Colors.grey[700],),
                              suffixIcon: Icon(Icons.close,color: Colors.grey[700]),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget HospitalCard() {
    return Container();
  }
}
