import 'package:Seerecs/Screens/BottomNavigation/Records.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Predictions extends StatelessWidget{
  const Predictions({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
        backgroundColor: Color(0xFFECEFFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Observations",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24.0),), 
        centerTitle: true,
        leading: BackButton(onPressed: (){Navigator.pop(context);},),
        actions: [
          Row(children: [
            IconButton(onPressed: (){}, icon: Icon(Icons.search_outlined,size: 30,),),
            IconButton(onPressed: (){}, icon: Icon(Icons.filter_alt_outlined,size: 30,)),
          ],)
        ],
        ),
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Container(
          
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
          ),
          child: Column(children: [
            SizedBox(height: 20.0,),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0),color: Color(0xFFB2A0FB),),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("We Have A Prediction",style: TextStyle(color: Colors.black,fontSize: 16.0,fontWeight: FontWeight.bold)),
                        Image.asset("assets/whiteDragon.png")
                      ],),
                  ),
                  ),
              ),
            ),
            SizedBox(height: 10.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              BackButton(onPressed: (){},),
              Text('09/07/2024',style: TextStyle(color: Color.fromARGB(255, 170, 167, 167)),),
              Text('09/07/2024',style: TextStyle(color: Color.fromARGB(255, 52, 38, 93),fontSize: 18, fontWeight: FontWeight.bold),),
              Text('09/07/2024',style: TextStyle(color: Color.fromARGB(255, 170, 167, 167)),),
              IconButton(onPressed: (){}, icon: FaIcon(FontAwesomeIcons.greaterThan)),
            ],),
            SizedBox(height: 10.0,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text("Test Name",style: TextStyle(color: Color.fromARGB(255, 52, 38, 93),fontSize: 16, fontWeight: FontWeight.bold),),
                Text("Result",style: TextStyle(color: Color.fromARGB(255, 52, 38, 93),fontSize: 16, fontWeight: FontWeight.bold),),
                Text("Normal Range",style: TextStyle(color: Color.fromARGB(255, 52, 38, 93),fontSize: 16, fontWeight: FontWeight.bold),),
              ],),
            ),
            Container(
              decoration: BoxDecoration(color: Color.fromARGB(255, 14, 5, 189),border: Border(bottom: BorderSide(width: 1.0))),
            ),
            SizedBox(height: 16.0,),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("179",style: TextStyle(color: Color.fromARGB(255, 52, 38, 93),fontSize: 16, fontWeight: FontWeight.bold)),
                      Text(''),
                      Text('')
                    ],
                  ),
            ),
                SizedBox(height: 12.0,),
            Padding(padding: EdgeInsets.only(left: 8.0,right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Albumin",style: TextStyle(color: Colors.grey),),
                    SizedBox(height: 8.0,),
                    Text('Direct Bilirubin',style: TextStyle(color: Colors.grey),),
                    SizedBox(height: 8.0,),
                    Text('A / G Ratio',style: TextStyle(color: Colors.grey)),
                    SizedBox(height: 8.0,),
                    Text('Calcium',style: TextStyle(color: Colors.grey)),
                    SizedBox(height: 8.0,),
                    Text('Phosphorous',style: TextStyle(color: Colors.grey)),
                  ],
                ),
                Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("4.200 G/DL",style: TextStyle(color: Colors.grey),),
                    SizedBox(height: 8.0,),
                    Text('0.100 Mg/DL',style: TextStyle(color: Colors.grey),),
                    SizedBox(height: 8.0,),
                    Text('1.61538 Ratio',style: TextStyle(color: Colors.grey),),
                    SizedBox(height: 8.0,),
                    Text('8.800 Mg/DL',style: TextStyle(color: Colors.grey),),
                    SizedBox(height: 8.0,),
                    Text('3.900 Mg/DL',style: TextStyle(color: Colors.grey),),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("3.2-4.8 G/DI",style: TextStyle(color: Colors.grey),),
                    SizedBox(height: 8.0,),
                    Text('<0.3 Mg/DL',style: TextStyle(color: Colors.grey),),
                    SizedBox(height: 8.0,),
                    Text('1.2-2.2 Ratio',style: TextStyle(color: Colors.grey),),
                    SizedBox(height: 8.0,),
                    Text('8.7-10.4 Mg/DL',style: TextStyle(color: Colors.grey),),
                    SizedBox(height: 8.0,),
                    Text('2.4-5.1 Mg/DI',style: TextStyle(color: Colors.grey),),
                  ],
                ),
              ],
            ),),
            SizedBox(height: 12.0,),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("180",style: TextStyle(color: Color.fromARGB(255, 52, 38, 93),fontSize: 16, fontWeight: FontWeight.bold)),
                      Text(''),
                      Text('')
                    ],
                  ),
            ),
            SizedBox(height: 12.0,),
            Padding(padding: EdgeInsets.only(left: 8.0,right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Sodium (Na)",style: TextStyle(color: Colors.grey),),
                    SizedBox(height: 8.0,),
                    Text('Potassium (k)',style: TextStyle(color: Colors.grey),),
                    SizedBox(height: 8.0,),
                    Text('Chloride (Cl-)',style: TextStyle(color: Colors.grey)),
                    SizedBox(height: 8.0,),
                    Text('Uric Acid',style: TextStyle(color: Colors.grey)),
                  ],
                ),
                Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("140 Mmol/L",style: TextStyle(color: Colors.grey),),
                    SizedBox(height: 8.0,),
                    Text('4.100 Mmol/L',style: TextStyle(color: Colors.grey),),
                    SizedBox(height: 8.0,),
                    Text('106 Mmol/L',style: TextStyle(color: Colors.grey),),
                    SizedBox(height: 8.0,),
                    Text('6.500 Mg/DL',style: TextStyle(color: Colors.grey),),
                
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("132 - 146 Mmol/L",style: TextStyle(color: Colors.grey),),
                    SizedBox(height: 8.0,),
                    Text('3.5 - 5.5 Mmol/L',style: TextStyle(color: Colors.grey),),
                    SizedBox(height: 8.0,),
                    Text('99 - 109 Mmol/L',style: TextStyle(color: Colors.grey),),
                    SizedBox(height: 8.0,),
                    Text('3.1 - 7.8 Mg/DL',style: TextStyle(color: Colors.grey),),
                    
                  ],
                ),
              ],
            ),),
             SizedBox(height: 12.0,),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("181",style: TextStyle(color: Color.fromARGB(255, 52, 38, 93),fontSize: 16, fontWeight: FontWeight.bold)),
                      Text(''),
                      Text('')
                    ],
                  ),
            ),
            SizedBox(height: 12.0,),
            Padding(padding: EdgeInsets.only(left: 8.0,right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Albumin",style: TextStyle(color: Colors.grey),),
                    SizedBox(height: 8.0,),
                    Text('Direct Bilirubin',style: TextStyle(color: Colors.grey),),
                    SizedBox(height: 8.0,),
                    Text('A / G Ratio',style: TextStyle(color: Colors.grey)),
                    SizedBox(height: 8.0,),
                    Text('Calcium',style: TextStyle(color: Colors.grey)),
                    SizedBox(height: 8.0,),
                    Text('Phosphorous',style: TextStyle(color: Colors.grey)),
                  ],
                ),
                Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("4.200 G/DL",style: TextStyle(color: Colors.grey),),
                    SizedBox(height: 8.0,),
                    Text('0.100 Mg/DL',style: TextStyle(color: Colors.grey),),
                    SizedBox(height: 8.0,),
                    Text('1.61538 Ratio',style: TextStyle(color: Colors.grey),),
                    SizedBox(height: 8.0,),
                    Text('8.800 Mg/DL',style: TextStyle(color: Colors.grey),),
                    SizedBox(height: 8.0,),
                    Text('3.900 Mg/DL',style: TextStyle(color: Colors.grey),),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("3.2-4.8 G/DI",style: TextStyle(color: Colors.grey),),
                    SizedBox(height: 8.0,),
                    Text('<0.3 Mg/DL',style: TextStyle(color: Colors.grey),),
                    SizedBox(height: 8.0,),
                    Text('1.2-2.2 Ratio',style: TextStyle(color: Colors.grey),),
                    SizedBox(height: 8.0,),
                    Text('8.7-10.4 Mg/DL',style: TextStyle(color: Colors.grey),),
                    SizedBox(height: 8.0,),
                    Text('2.4-5.1 Mg/DI',style: TextStyle(color: Colors.grey),),
                  ],
                ),
              ],
            ),),
          ],),
        ),),
    );
  }
}