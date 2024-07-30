import 'package:flutter/material.dart';

class EmptyScreen extends StatelessWidget{
  const EmptyScreen({super.key, this.name});
  final String? name;
  @override
  Widget build(BuildContext context)
{
  return Scaffold(
    backgroundColor: Color(0xFFECEFFC),
    appBar: AppBar(title: Text(name!,style: TextStyle(color: Colors.black,fontSize: 24.0,fontWeight:FontWeight.bold),),),
    body: Center(child: Text("Oops! the data is empty",style: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight:FontWeight.bold)),),
    
    );
}}