import 'dart:convert';
import 'package:Seerecs/Screens/Record_screens/Allergies.dart';
import 'package:Seerecs/Screens/Record_screens/EmptyScreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:badges/badges.dart' as badges;
import '../../Assets/CustomPageRoute.dart';
import '../LoginScreen.dart';

class Records extends StatefulWidget {
  const Records({super.key});

  @override
  State<Records> createState() => _RecordsState();
}

  Items item1 = new Items(
      title: "Allergies", event: "3 new", image: "assets/allergies 1.png");

  Items item2 = new Items(
    title: "Immunization",
    event: "3 new",
    image: "assets/4190876 1.png",
  );
  Items item3 = new Items(
    title: "Test Results",
    event: "3 new",
    image: "assets/6202925 1.png",
  );
  Items item4 = new Items(
    title: "Medications",
    event: "3 new",
    image: "assets/drugs 1.png",
  );
  Items item5 = new Items(
    title: "Conditions",
    event: "3 new",
    image: "assets/healthcare 2.png",
  );
  Items item6 = new Items(
    title: "Procedure",
    event: "3 new",
    image: "assets/doctor (3) 1.png",
  );
  Items item7 = new Items(
    title: "Observation",
    event: "3 new",
    image: "assets/microscope 1.png",
  );
  Items item8 = new Items(
    title: "Claims",
    event: "3 new",
    image: "assets/contract 1.png",
  );
  Items item9 = new Items(
    title: "TBD",
    event: "3 new",
    image: "assets/megaphone 1.png",
  );

    List<Items> myList = [
      item1,
      item2,
      item3,
      item4,
      item5,
      item6,
      item7,
      item8,
      item9
    ];

class _RecordsState extends State<Records> {
  String? _firstName;
    bool isloading = false;

  Future<void> getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Use the correct key to retrieve firstName from SharedPreferences
    String? firstName = prefs.getString('firstName');
    if (firstName != null) {
      setState(() {
        _firstName = firstName;
      });
      print('Fetched firstName: $_firstName');
    } else {
      print('Failed to fetch firstName from SharedPreferences.');
      print('Keys in SharedPreferences: ${prefs.getKeys()}');
    }
  }

Future<void> getDataTypes(String dataType) async{
  setState(() {
      isloading = true;
    });
  try{ 
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String? obtainedToken = sharedPreferences.getString('token');

    //var head = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NjllNGFjYjJhYTg3ZDVkYWZlZjUyYzciLCJpYXQiOjE3MjE5MDUxMDksImV4cCI6MTcyMTk5MTUwOX0.iPdaCnQAduvA_of5XBJqSJqVTUqfXZyfOj2EMx-GVXY';
    var header = {
  'Authorization': 'Bearer ${obtainedToken}',
  'Content-Type': 'application/json'
};
//var headers = {
  //'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NjllNGFjYjJhYTg3ZDVkYWZlZjUyYzciLCJpYXQiOjE3MjIyNTEwNjgsImV4cCI6MTcyMjMzNzQ2OH0.V47FVo46ZBwJZ5HiQmzXY4ieLOqoFpllraaIHSC2CTA',
  //'Content-Type': 'application/json'
//};
print(dataType);
var data = json.encode({
  "dataTypes": [
    "${dataType}"
  ]
});
var dio = Dio();
var response = await dio.request(
  'https://seerecs.org/user/userProfile',
  options: Options(
    method: 'POST',
    headers: header,
  ),
  data: data,
);

if (response.statusCode == 200) {
  print(json.encode(response.data));
  if(response.data['fhirData'] != null){
    Navigator.of(context).push(MaterialPageRoute(builder: (_){return  Allergies(medicalType: dataType, reports: response.data);},));
  }else{
    Navigator.of(context).push(MaterialPageRoute(builder: (_){return   EmptyScreen(name: dataType);},));
  }
}
else {
  print(response.statusMessage);
}
}
finally {
      setState(() {
        isloading = false;
      });
    }
}

  @override
  void initState() {
    super.initState();
    getUserInfo();
    //GetRecordApiCall();
  }

  @override
  void dispose() {
    super.dispose();
  }
  Future<void> logout() async{
                print('LOGOUT');
                SharedPreferences prefs =
                await SharedPreferences.getInstance();
                await prefs.clear();
                Navigator.pushReplacement(context, CustomPageRoute(child: LoginScreen()));
  }


  @override
  Widget build(BuildContext context) {
  
    EdgeInsets devicePadding = MediaQuery.of(context).viewPadding;
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height) / 5.5;
    final double itemWidth = size.width / 2.5;
    return Padding(
      padding: devicePadding,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 7),
            borderRadius: BorderRadius.circular(30),
          ),
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 10, top: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              "Good Morning ${_firstName != null ? _firstName![0].toUpperCase() + _firstName!.substring(1) : ''}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF02486A),
                                fontSize: 18,
                              ),
                            ),
                           
                            Row(
                              //crossAxisAlignment: CrossAxisAlignment.center,
                              //mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                               IconButton(onPressed: (){ 
                               },
                               icon: Icon(Icons.message_outlined,color: Colors.black,)),
                                TextButton(onPressed: logout, child: badges.Badge(child: Icon(Icons.notification_important_outlined,color: Colors.black,),position: badges.BadgePosition.topEnd(top: -3, end: -3),)),                                
                                GestureDetector(
                                  onTap: logout,
                                  child:
                                       Icon(
                                        Icons.power_settings_new,
                                        color: Colors.black,
                                      )
                                ),
                              ],
                            ),
                          ],
                        )),
                    // SizedBox(
                    //   height: 5,
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(60),
                                topRight: Radius.circular(60),
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                              //borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFFFFBEBE),
                                  Color(0xFFFFD7D7),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  child: Image.asset(
                                    "assets/promo-image 1.png",
                                    height: 45.h,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Family Tree',
                                  style: TextStyle(
                                      color: Color(0xFF613700),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600),
                                ),
                              ]),
                            ),
                          ),
                          SizedBox(
                            width: 14.0,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(80),
                                topRight: Radius.circular(80),
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                              //borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFFEAADFF),
                                  Color(0xFFF6DCFF),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  child: Image.asset(
                                    "assets/patient 2.png",
                                    height: 40.h,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Patient Portal',
                                  style: TextStyle(
                                      color: Color(0xFF7B498C),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600),
                                ),
                              ]),
                            ),
                          ),
                          SizedBox(
                            width: 14.0,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(80),
                                topRight: Radius.circular(80),
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                              //borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFF8E92FF),
                                  Color(0xFFCBCEFF),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  child: Image.asset(
                                    "assets/log 1.png",
                                    height: 40.h,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Log History',
                                  style: TextStyle(
                                      color: Color(0xFF474989),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600),
                                ),
                              ]),
                            ),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Image.asset(
                            'assets/Dio-02 1.png',
                            height: 120.h,
                            //width: 50,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        //border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFFECF0FD),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 8),
                            child: Text(
                              "Medical Reports",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color(0xFF02486A),
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          // SizedBox(
                          //   height:5,
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: SizedBox(
                              height: 40,
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Search medical reports",
                                  hintStyle: TextStyle(
                                      color: Color(0xFFE1E5F5),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      height: 1.2),
                                  fillColor: Colors.white,
                                  filled: true,
                                  prefixIcon: Icon(Icons.search),
                                  //suffixIcon: Icon(Icons.filter_list),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:
                                        BorderSide(color: Color(0xFFE1E5F5)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GridView.count(
                           shrinkWrap: true,
                           childAspectRatio: (itemWidth / itemHeight),
                           padding: EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                           crossAxisCount: 3,
                           crossAxisSpacing: 10,
                           mainAxisSpacing: 10,
                            children: //myList.map((data) {
                             List.generate(myList.length, (index) {
                                return GestureDetector(
                                  onTap: (){
                                    
                                    String dataType = myList[index].title;
                                    
                                      getDataTypes(dataType);
                                      
                                      },
                                  child: Container(
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.white, width: 2),
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: RadialGradient(
                                      colors: [
                                        Color(0xFFDAE1F7),
                                        Color(0xFFFFFFFF),
                                      ],
                                      center: Alignment.center,
                                      radius: 0.8,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(myList[index].image, width: 40),
                                      SizedBox(height: 5),
                                      Text(
                                        myList[index].title,
                                        style: TextStyle(
                                          color: Color(0xFF374572),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      //(height: 8),
                                  
                                      SizedBox(height: 5),
                                      Container(
                                        //width: 160,
                                        height: 18,
                                        child: TextButton(
                                            child: Text(myList[index].event,
                                                style: TextStyle(fontSize: 11)),
                                            style: ButtonStyle(
                                                padding: WidgetStateProperty
                                                    .all<EdgeInsets>(
                                                        EdgeInsets.all(1)),
                                                backgroundColor:
                                                    WidgetStateProperty.all<Color>(
                                                        Colors.white),
                                                foregroundColor:
                                                    WidgetStateProperty.all<Color>(
                                                        Color(0xFFF96A68)),
                                                shape: WidgetStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(18.0),
                                                ))),
                                            onPressed: (){
                                              //String dataType = myList[index].title;
                                              //getDataTypes(dataType);
                                            // Navigator.of(context).push(MaterialPageRoute(builder: (_){return  Allergies(medicalType: data.title, reports: Immnunization,);},));
                                            }),
                                      ),
                                 
                                    ],
                                  ),
                                 ),
                                );
                             }),
                             
                           
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 5,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Lets find your doctor",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                          //Icon(Icons.line)
                          SvgPicture.asset(
                            'icons/Vector.svg',
                            // ignore: deprecated_member_use
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          CardWidget(
                            title: 'Heart surgeon',
                            image: 'assets/heart (2) 1.png',
                          ),
                          CardWidget(
                            title: 'Psychologist',
                            image: 'assets/capsule (3) 1.png',
                          ),
                          CardWidget(
                            title: 'Dentist',
                            image: 'assets/tooth (1) 1.png',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    if (isloading)
          Center(
            child: CircularProgressIndicator(),
          ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}

class Items {
  String title;

  String event;
  String image;
  Items({required this.title, required this.event, required this.image});
}

class CardWidget extends StatelessWidget {
  CardWidget({super.key, required this.image, required this.title});
      
  final String image;
  final String title;
  
  
  @override
  Widget build(BuildContext context) {
    bool selectedIndex = false;
    return Card(
      color: Colors.white,
      //borderOnForeground: true,
      child: SizedBox(
        height: 50,
        width: 200,
        child: Center(
          child: ListTile(
            //selected: true,
            leading: Image.asset(image),
            //selectedTileColor: Colors.black,
            //selectedColor: Colors.black,
            //style: Border.all(),
            // onTap:(){
            //         setState(() {
            //        selectedIndex=index;
            //        }),
            selectedTileColor: selectedIndex ? Colors.blue : Colors.black,
            onTap: () {
              selectedIndex = !selectedIndex;
            },
            title: Text(
              title,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
          ),
        ),
      ),
    );
  }
}


Widget row(int index) {//GridView.count(
                           // shrinkWrap: true,
                           // childAspectRatio: (itemWidth / itemHeight),
                           // padding: EdgeInsets.only(
                              //  left: 20, right: 20, top: 10, bottom: 10),
                          //  crossAxisCount: 3,
                           // crossAxisSpacing: 10,
                           // mainAxisSpacing: 10,
                            //children: myList.map((data) {
                              //return 
                             return Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: RadialGradient(
                                    colors: [
                                      Color(0xFFDAE1F7),
                                      Color(0xFFFFFFFF),
                                    ],
                                    center: Alignment.center,
                                    radius: 0.8,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset(myList[index].image, width: 40),
                                    SizedBox(height: 5),
                                    Text(
                                      myList[index].title,
                                      style: TextStyle(
                                        color: Color(0xFF374572),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    //(height: 8),

                                    SizedBox(height: 5),
                                    Container(
                                      //width: 160,
                                      height: 18,
                                      child: TextButton(
                                          child: Text(myList[index].event,
                                              style: TextStyle(fontSize: 11)),
                                          style: ButtonStyle(
                                              padding: WidgetStateProperty
                                                  .all<EdgeInsets>(
                                                      EdgeInsets.all(1)),
                                              backgroundColor:
                                                  WidgetStateProperty.all<Color>(
                                                      Colors.white),
                                              foregroundColor:
                                                  WidgetStateProperty.all<Color>(
                                                      Color(0xFFF96A68)),
                                              shape: WidgetStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                              ))),
                                          onPressed: (){
                                            
                                          //String n = myList[1].title;
                                          // Navigator.of(context).push(MaterialPageRoute(builder: (_){return  Allergies(medicalType: data.title, reports: Immnunization,);},));
                                          }),
                                    ),
                                  ],
                                ),
                              );}
                           // }).toList(),
                          //),