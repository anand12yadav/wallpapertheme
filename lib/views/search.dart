import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpapertheme/data/data.dart';
import 'package:wallpapertheme/model/wallpaper_model.dart';
import 'package:wallpapertheme/widget/widget.dart';
import 'package:http/http.dart' as http;


class Search extends StatefulWidget {
  final String searchQuery;
  Search({this.searchQuery});
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
 
 TextEditingController searchController=new TextEditingController();
 List<WallpaperModel> wallpapers=new List();

 getSearchWallpapers(String query) async{
  
   var response=await http.get("https://api.pexels.com/v1/search?query=$query&per_page=15&page=1",
   headers: {
     "Authorization" : apiKey
   });
   //print(response.body.toString());
    Map<String,dynamic> jsonData=jsonDecode(response.body);
    jsonData["photos"].forEach((element){
      WallpaperModel wallpaperModel=new WallpaperModel();
      wallpaperModel=WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });

    setState(() {
      
    });
 }
  @override
  void initState() {
    // TODO: implement initState
    getSearchWallpapers(widget.searchQuery);
    searchController.text=widget.searchQuery;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
         child: Container(
          child: Column(
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                    color: Color(0xfff5f8fd),
                    borderRadius: BorderRadius.circular(30)
                  ),
                  margin: EdgeInsets.symmetric(horizontal:24),
                  padding: EdgeInsets.symmetric(horizontal:24),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: TextField(
                            controller: searchController,
                          decoration: InputDecoration(
                            hintText: "Search wallpaper",
                            border: InputBorder.none
                          ),
                        ),
                      ),
                      InkWell(
                        onTap:() {
                          getSearchWallpapers(searchController.text);
                        },
                         child: Container(
                          child: Icon(
                            Icons.search),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 16,),
                wallpapersList(wallpapers: wallpapers,context: context),
            ],
          ),
        ),
      ),
    );
  }
}