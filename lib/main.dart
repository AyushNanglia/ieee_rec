import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ieeerec/hotels_model.dart';
import 'dart:convert' as convert;
import 'package:connectivity/connectivity.dart';

void main() {
  runApp(MaterialApp(
    home: cards() ,
  ));
}

class cards extends StatefulWidget {

  @override
  _cardsState createState() => _cardsState();
}

class build_card extends StatelessWidget {
  String name, type, image,rating; //Values won't change, hence 'Final'
  build_card({this.name,this.rating,this.type,this.image});  //A constructor to initialize


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      height: MediaQuery.of(context).size.height*0.3,
      child:Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        elevation: 10.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(flex:6,child: Container(color: Colors.blueGrey[500],child: Image(image: NetworkImage(image),fit: BoxFit.fitWidth,))),
            Expanded(flex:4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(flex:11,
                      child: Container(
                        color: Colors.black87,
                        padding: EdgeInsets.symmetric(horizontal: 7.0,vertical: 3.0),
                        child: Text(name,style: TextStyle(color: Colors.white,fontSize: 20.0,),),),
                    ),
                    Expanded(flex:9,
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(flex:2,
                            child: Container(
                              alignment: Alignment.topLeft,
                              color: Colors.black87,
                              padding: EdgeInsets.symmetric(horizontal: 7.0,vertical: 3.0),
                              child: Text(type,style: TextStyle(color: Colors.grey,fontSize: 15.0),),
                            ),
                          ),
                          Expanded(flex:1,
                            child: Container(
                              alignment: Alignment.topLeft,
                              color: Colors.black87,
                              padding: EdgeInsets.symmetric(horizontal: 0.0,vertical: 3.0),
                              child: Text(rating,style: TextStyle(color: Colors.white,fontSize: 15.0),),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ],
        ),

      ) ,
    );
  }

 /* Widget build(BuildContext context){
    return Container(
      child: Column(
        children: [
          Text(name,style: TextStyle(fontSize: 20.0, color: Colors.black),),
          Text(type,style: TextStyle(fontSize: 20.0, color: Colors.black),),
        ],
      ),
    );
  }*/
}


/*Widget build_card(BuildContext context, String name, String type, String rating, String img_url){
  return Container(
    margin: EdgeInsets.all(5.0),
    height: MediaQuery.of(context).size.height*0.3,
    child:Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 10.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(flex:6,child: Container(color: Colors.blueGrey[500],child: Image(image: NetworkImage("$img_url"),fit: BoxFit.fitWidth,))),
          Expanded(flex:4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(flex:11,
                    child: Container(
                      color: Colors.black87,
                      padding: EdgeInsets.symmetric(horizontal: 5.0,vertical: 3.0),
                      child: Text("$name",style: TextStyle(color: Colors.white,fontSize: 20.0),),),
                  ),
                  Expanded(flex:9,
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(flex:1,
                          child: Container(
                            alignment: Alignment.topLeft,
                            color: Colors.black87,
                            padding: EdgeInsets.symmetric(horizontal: 5.0,vertical: 3.0),
                            child: Text("$type",style: TextStyle(color: Colors.grey,fontSize: 15.0),),
                          ),
                        ),
                        Expanded(flex:1,
                          child: Container(
                            alignment: Alignment.topLeft,
                            color: Colors.black87,
                            padding: EdgeInsets.symmetric(horizontal: 5.0,vertical: 3.0),
                            child: Text("Rating: $rating",style: TextStyle(color: Colors.grey,fontSize: 15.0),),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ],
      ),

    ) ,
  );
}*/

class _cardsState extends State<cards> {

  List<hotelmodel> hotelMetadata=List<hotelmodel>();


  getHoteldata()async{

    var rawData=await http.get("https://script.google.com/a/pilani.bits-pilani.ac.in/macros/s/AKfycbw28KDNpu-BuT0GDfK9qeA-O7KHrviM4Lk7eVB0vg/exec");   //Importing Raw Data
    var jsonHotelData=convert.jsonDecode(rawData.body);
    //print("${jsonHotelData}");

    jsonHotelData.forEach((element){
      //print(element);

      hotelmodel HotelModel=new hotelmodel();
      HotelModel.name=element['Name'];
      HotelModel.rating=element['Rating'];
      HotelModel.type=element['Type'];
      HotelModel.image=element['Image'];

      hotelMetadata.add(HotelModel);
    }
      );

  }

  @override
  void initState(){
    getHoteldata();
        super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Column(
        children: [
          Expanded(flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              color: Color.fromRGBO(60, 63, 65, 100),
              child: Text("SASTA TRIVAGO", style:
                TextStyle(
                  fontSize: 29.0,
                  color: Colors.white,
                  //fontFamily: "Quicksand",
                  //fontWeight: FontWeight.w500,
                  //fontWeight: Quic,

                ),),
            ),
          ),
          Expanded(flex: 9,
            child: Container(
              color: Color.fromRGBO(60, 63, 65, 100),
              child: ListView.builder(
                itemCount: hotelMetadata.length,
                //addAutomaticKeepAlives: false,
                itemBuilder: (BuildContext context,int index)=> build_card(
                    name: hotelMetadata[index].name,
                    rating: hotelMetadata[index].rating,
                    type: hotelMetadata[index].type,
                    image: hotelMetadata[index].image,
                )


              ),


            ),
          )
        ],
      ),
    );
  }
}

