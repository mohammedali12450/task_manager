import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final String url;
  final String firstName;
  final String lastName;
  final String email;

  CustomContainer(
      {required this.url,
      required this.firstName,
      required this.lastName,
      required this.email});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(15)),
      padding: EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.11,
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(url),
            radius: MediaQuery.of(context).size.height * 0.07,
          ),
          Column(
            children: [
              Text(firstName,style: TextStyle(fontSize: 20),),
              Text(lastName,style: TextStyle(fontSize: 20)),
              Text(email,style:TextStyle(fontSize: 20)),
            ],
          )
        ],
      ),
    );
  }
}
