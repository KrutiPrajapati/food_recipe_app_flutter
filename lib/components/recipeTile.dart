import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foodrecipeapp/colors.dart';
import 'package:foodrecipeapp/views/recipeView.dart';
import 'package:url_launcher/url_launcher.dart';

class RecipeTile extends StatefulWidget {

  final String title, desc, imgurl, url;

  const RecipeTile({
    super.key,
    required this.title,
    required this.desc,
    required this.imgurl,
    required this.url,
  });

  @override
  State<RecipeTile> createState() => _RecipeTileState();
}

class _RecipeTileState extends State<RecipeTile> {

  _launchURL(String url) async{

    final uri = Uri.parse(url); // Convert URL Stirng to a Uri object

    if(await canLaunchUrl(uri)){
      await launchUrl(uri);
    }
    else{
      throw 'could not launch this url: $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [

        GestureDetector(

        onTap: () {

          if(kIsWeb){
            _launchURL(widget.url);
          }
          else{

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecipeViewPage(postUrl: widget.url,)
              )
            );

          }

        },

          child: Container(

          margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(

                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  spreadRadius: 2,
                  offset: const Offset(0, 2),

                ),
              ],

            ),

            child: Stack(
            children: [

              Image.network(
                widget.imgurl,
                height: 200,
                width: 200,
                fit: BoxFit.cover,
                          ),

             Positioned(
               bottom: 0,
               left: 0,
               child: Container(
                  width: 200,
                  alignment: Alignment.bottomLeft,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),

                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // title
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.black1,
                        ),
                      ),

                      // description
                      Text(
                        widget.desc,
                        style: const TextStyle(
                          fontSize: 10,
                          color: AppColors.black1,
                        ),
                      ),

                  ],
                ),
                ),
                           ),
             ),

            ],
          ),
        ),
        ),

      ],
    );
  }
}
