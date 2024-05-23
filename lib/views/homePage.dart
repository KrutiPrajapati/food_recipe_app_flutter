import 'package:flutter/material.dart';
import 'package:foodrecipeapp/colors.dart';
import 'package:foodrecipeapp/components/recipeTile.dart';
import 'package:foodrecipeapp/models/recipeModel.dart';
import 'package:foodrecipeapp/services/foodrecipeservices.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController ingredients = TextEditingController();

  String applicationid = 'b94a16e9';
  String applicationkey = 'de3f764e7e469e202951f6abf2e8a873';

  final _foodRecipeServices = FoodRecipeServices();

  List<RecipeModel> _recipes = [];


  void _serach() async {

    final List<RecipeModel> response = await _foodRecipeServices.getRecipeData(ingredients.text);
    setState(() {
      _recipes = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      extendBodyBehindAppBar: true,

      body: Stack(
        children: [

          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),

          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // title text 'CookItEasy'
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('CookItEasy',
                        style: GoogleFonts.alata(
                            fontSize: 26,
                            color: AppColors.black1,
                            letterSpacing: 3
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30,),

                  // what's on the menu text
                  Container(
                    //height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.darkgrey,
                      borderRadius: BorderRadius.circular(27)
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 17.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('What’s on the menu today?',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.7
                            ),
                          ),

                          SizedBox(height: 10,),

                          Text('Enter what ingredients you have, and we’ll recommend a recipe.',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                letterSpacing: 0.5
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30,),

                  Row(
                    children: [

                      //textfield
                      Expanded(
                        child: TextField(
                          controller: ingredients,
                          decoration: InputDecoration(
                            hintText:'Enter ingredients..',
                              hintStyle: TextStyle(
                                color: AppColors.lightgrey.withOpacity(0.5),
                                fontSize: 18,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.w400,
                              ),
                              contentPadding: const EdgeInsets.all(20),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(17),
                                borderSide: const BorderSide(
                                  width: 1,
                                  style: BorderStyle.solid,
                                  strokeAlign: BorderSide.strokeAlignCenter,
                                  color: AppColors.black1
                                )
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(17),
                                  borderSide: BorderSide(
                                      width: 2,
                                      style: BorderStyle.solid,
                                      strokeAlign: BorderSide.strokeAlignCenter,
                                      color: AppColors.black1.withOpacity(0.9)
                                  ),
                              ) ,
                          ),
                          cursorColor: AppColors.lightgrey.withOpacity(0.8),
                          //style: ,
                        ),

                      ),

                      const SizedBox(width: 10,),

                      InkWell(
                        onTap: (){
                          if(ingredients.text.isNotEmpty){
                            _serach();
                          }
                          else{
                            print('there is some error!');
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.accentColor,
                            borderRadius: BorderRadius.circular(17)
                          ),
                            child: const Padding(
                              padding: EdgeInsets.all(13.0),
                              child: Icon(Icons.search_rounded,
                                size: 40,
                              ),
                            )
                        ),
                      ),

                    ],
                  ),

                  const SizedBox(height: 10,),

                  GridView.builder(
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200.0,
                          mainAxisSpacing: 50.0,
                      ),
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: _recipes.length,
                      itemBuilder: (context, index) {
                        final recipe = _recipes[index];
                        return GridTile(
                            child: RecipeTile(
                                title: recipe.label,
                                desc: recipe.source,
                                imgurl: recipe.image,
                                url: recipe.url
                            ),
                        );
                      },
                  ),

                  const SizedBox(height: 50,),

                ],
              ),
            ),
          ),

        ],
      ),

    );
  }
}
