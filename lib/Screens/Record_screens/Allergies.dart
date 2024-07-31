import 'package:Seerecs/Screens/BottomNavigation/Records.dart';
import 'package:Seerecs/Screens/Record_screens/DisplayScreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

var icons = [
"Vectorglucose.png","Vector.png","Hib.png","DTaP.png","Vectorcreatinine.png","Vheart.png","VVomiting.png","VectorWheal.png","DTaP.png","Vector.png"
];

class Allergies extends StatelessWidget{
   const Allergies({super.key, this.medicalType, this.image,this.reports});
   final String? medicalType;
   final String? image;
   final Map<String,dynamic>? reports;
  
  @override
 Widget build(BuildContext context){
  String isoDate = reports!["fhirData"][0]["occurrenceDateTime"]?? "12:30";
  //String result ;
  DateTime parsedDate;
  String formattedDate = reports!["fhirData"][0]["occurrenceDateTime"] ?? '12:30';
  String link = reports!["fhirData"][0]["meta"]["profile"][0] ?? '';
  Uri url;
  if(reports!["fhirData"]!= null){
    if(reports!["fhirData"][0]["resourceType"]== "Observation"){
      isoDate =   reports!["fhirData"][0]["effectiveDateTime"] ; 
    }if(reports!["fhirData"][0]["resourceType"]=="Procedure"){
isoDate =   reports!["fhirData"][0]["performedPeriod"]["end"]  ; 
    }
    

parsedDate = DateTime.parse(isoDate);
  // Format the parsed date to get just the date part
   formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);

   link = reports!["fhirData"][0]["meta"]["profile"][0];
     
  }else{
  print('object');
}
    url =Uri.parse(link) ;

Future<void> _launchUrl() async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}
 
  // Parse the ISO 8601 date string
   
 
  return Scaffold(
    backgroundColor: Color(0xFFECEFFC),
appBar: AppBar(
  leading: BackButton(color: Colors.black,onPressed: (){
    Navigator.of(context).pop();
  },),
  backgroundColor: Colors.white,
  centerTitle: true,
  title: Text(medicalType!,style: TextStyle(color: Colors.black,fontSize: 24.0,fontWeight:FontWeight.bold),),
  actions: [
    IconButton(onPressed: (){}, icon: Icon(Icons.search_outlined,size: 30,),color: Colors.black,),
    IconButton(onPressed: (){}, icon: Icon(Icons.filter_alt_outlined,size: 30.0,color: Colors.black,)),
  ],
),body: Padding(
  padding: const EdgeInsets.symmetric(vertical:10.0,horizontal: 10.0),
  child: Column(
    children: [
      Expanded(
        child: ListView.builder(
        itemCount: reports!["fhirData"].length,
        itemBuilder: (context, index) {
          var result = reports!["fhirData"][0]["resourceType"]=="Immunization"? reports!["fhirData"][index]["vaccineCode"]["text"]: reports!["fhirData"][index]["code"]["text"];
          String stat = reports!['fhirData'][index]['status'];
          var icon ;
          if(index> myList.length){
            icon = icons[icons.length-5];
          }else {
            icon = icons[index];
          }
          return 
        GestureDetector(
          onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (_){return DisplayScreen(reports: reports,title: result,date: formattedDate,status: stat,);}));},
          child: Padding(
            padding: const EdgeInsets.only(top:8.0),
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Row(children: [
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50.0),color:  Color(0xFFECEFFC),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(backgroundImage: AssetImage('assets/${icon}',),),
                      ),
                    ),
                    SizedBox(width: 10.0,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                      SizedBox(width:MediaQuery.of(context).size.width/2.5, child: Text(result,overflow: TextOverflow.ellipsis,maxLines: 1,softWrap: true,style: TextStyle(color: Colors.black,fontSize: 14.0,fontWeight: FontWeight.bold),)),
                      SizedBox(height: 3.0,),
                      Text(stat,style: TextStyle(color: Colors.grey,fontSize: 16.0),),
                    ],)
                  ],),
                  Text(formattedDate,style: TextStyle(color: Colors.grey,fontSize: 16.0),)
                ],),
              ),
            ),
          ),
        );},),
      ),
    ],
  ),
),
  );
 }
}