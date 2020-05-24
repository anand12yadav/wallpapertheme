import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpapertheme/data/data.dart';
import 'package:wallpapertheme/model/categories_model.dart';
import 'package:wallpapertheme/model/wallpaper_model.dart';
import 'package:wallpapertheme/views/categorie.dart';
import 'package:wallpapertheme/views/image_view.dart';
import 'package:wallpapertheme/views/search.dart';
import 'package:wallpapertheme/widget/widget.dart';
import 'package:http/http.dart' as http;


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

List<CategoriesModel> categories=new List();
List<WallpaperModel> wallpapers=new List();

TextEditingController searchController=new TextEditingController();
 
 getTrendingWallpapers() async{
  
   var response=await http.get("https://api.pexels.com/v1/curated?per_page=15&page=1",
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
    getTrendingWallpapers();
    categories=getcaregories();
    super.initState();
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
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context)=> Search(
                            searchQuery: searchController.text,
                          )
                        ));
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                height: 50,
                child: ListView.builder(
                  itemCount: categories.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder:(context,index){
                    return CategorieTile(
                      imgUrl: categories[index].imgUrl,
                      title: categories[index].categorieName,
                    );
                  }),
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

class CategorieTile extends StatelessWidget {
 final String imgUrl,title;

 CategorieTile({@required this.imgUrl,@required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){Navigator.push(context, MaterialPageRoute(
        builder: (context)=>Categorie(
          categorieName: title.toLowerCase(),
        )
        ));
        } ,
      child: Container(
        margin: EdgeInsets.only(right: 4),
        child: Stack(
          children: <Widget>[
            ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(imgUrl,height: 50,width: 100,fit: BoxFit.cover,)),
            Container(
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(8),
              ),
              
              alignment: Alignment.center,
              height: 50,
              width: 100,
              child: Text(title,style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 15
              ),),
            )
          ],
        ),
      ),
    );
  }
}

