import 'package:flutter/material.dart';

class hotelmodel{

  String name,type,image,rating;

  hotelmodel({this.name,this.type,this.rating,this.image});

  factory hotelmodel.fromJSON(dynamic json){
    return hotelmodel(
      name: "${json['Name']}",
      type: "${json['Type']}",
      rating: "${json['Rating']}",
      image: "${json['Image']}",
    );
  }

  Map toJson()=>{
    "Name":name,
    "Type":type,
    "Rating":rating,
    "Image":image,
  };
}