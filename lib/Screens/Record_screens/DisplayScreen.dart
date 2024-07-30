import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DisplayScreen extends StatelessWidget{
  const DisplayScreen({super.key, this.reports,this.title, this.date,this.status});
  final  reports;
  final String? title;
  final date;
  final String? status;
  @override
  Widget build(BuildContext context){
    var system = reports!["fhirData"][0]["resourceType"] == "Immunization" ? reports!["fhirData"][0]["vaccineCode"]['coding'][0]['system'] :  reports!["fhirData"][0]["code"]['coding'][0]['system'];
    var code = reports!["fhirData"][0]["resourceType"] == "Immunization" ? reports!["fhirData"][0]["vaccineCode"]['coding'][0]['code'] :  reports!["fhirData"][0]["code"]['coding'][0]['code'];
    var display = reports!["fhirData"][0]["resourceType"] == "Immunization" ? reports!["fhirData"][0]["vaccineCode"]['coding'][0]['display'] :  reports!["fhirData"][0]["code"]['coding'][0]['display'];
    var appbar = reports!["fhirData"][0]["resourceType"];
    Uri url =Uri.parse(system) ;
  Future<void> _launchUrl() async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $system');
  }
}

Widget report = Column(
  children: [
    SizedBox(height: 20.0,),
    Container(
                  color:  Colors.white,
                  child: Table(
                        border: TableBorder.all(),
                        columnWidths: const <int, TableColumnWidth>{
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(2),
                         
                        },
                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                        children: [
                          
                          TableRow(
                            children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "ID",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                 Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      code,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ), 
                            ],
                          ),
                          TableRow(
                            children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Date of issue",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      date,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                            ],
                          ),
                          TableRow(
                            children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Status",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      status!,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                            ],
                          ),
                          TableRow(
                            children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Report",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      title!,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                            ],
                          ),
                          TableRow(
                            children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Final report",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      display,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                            ],
                          ),
                           TableRow(
                            children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Url",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: _launchUrl,
                      child: Text(
                        system,
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                            ],
                          ),
                        ],
                      ),
                ),
  ],
);

    return Scaffold(
      backgroundColor:Color(0xFFECEFFC),
      appBar: AppBar(title: Text(appbar,),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(height: 20.0,),
              for(int i=0; i<2;i++) report,
            ],
          ),
        ),
      ),
    );
  }
}

