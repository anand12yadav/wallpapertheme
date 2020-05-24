import 'package:flutter/material.dart';
import 'package:wallpapertheme/model/wallpaper_model.dart';
import 'package:wallpapertheme/views/image_view.dart';

Widget brandName(){
  
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 16),
        children: <TextSpan>[
          TextSpan(text: 'Wallpaper', style: TextStyle(color: Colors.black)),
          TextSpan(text: 'Theme', style: TextStyle(color: Colors.blue)),
         
        ],
      ),
),
    ],
  );
}

Widget wallpapersList({List<WallpaperModel> wallpapers, context}){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
    shrinkWrap: true,
    physics: ClampingScrollPhysics(),
    crossAxisCount: 2,
    childAspectRatio: 0.6,
    mainAxisSpacing:6.0 ,
    crossAxisSpacing: 6.0,
    children: wallpapers.map((wallpaper){
      return GridTile(
        child: GestureDetector(
          onTap:() {
                 Navigator.push(context, MaterialPageRoute(
                builder: (context)=> ImageView(
                  imageUrl: wallpaper.src.portrait,
                 )
                  ));
                  },
           child: Hero(
            tag: wallpaper.src.portrait,
              child: Container(
              child: 
             ClipRRect(
               borderRadius: BorderRadius.circular(16),
               child: Image.network(wallpaper.src.portrait,fit: BoxFit.cover,))
            ),
          ),
        ),
      );
    }).toList(),
    ),
  );
}