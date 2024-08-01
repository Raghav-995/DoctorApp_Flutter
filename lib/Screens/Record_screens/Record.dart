import 'package:flutter/material.dart';

class Record extends StatelessWidget{
   Record({super.key, this.records});
  final Map<String,dynamic>? records ;

  @override
  Widget build(BuildContext context){
    String hospitalName = "";
    String date;
     //records!["fhirData"][0]["resourceType"] == "ExplanationOfBenefit"
      if(records!["fhirData"][0]["resourceType"] == "Encounter"){
        hospitalName = records!["fhirData"][0]["resourceType"]["location"]["location"]["display"];
        date = records!["fhirData"][0]["resourceType"]["period"]["end"];
     }
    return Scaffold(
      appBar: AppBar(
        title: Text("Records"),
        backgroundColor: Colors.white,
        ),
        body: Padding(padding: EdgeInsets.all(8.0),
        child: Column(children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0)
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Row(children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40.0),
                        color: Color.fromARGB(255, 185, 194, 245)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Image.asset('assets/Plus.png'),
                      ),
                    ),
                    Column(children: [
                      Text(hospitalName)
                    ],)
                  ],)
                ],
              ),
            ),
          )
        ],)),
    );
  }
}