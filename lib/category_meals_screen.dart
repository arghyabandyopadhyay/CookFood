import 'package:flutter/material.dart';
import './categories_screen.dart';
import './meal_item.dart';
import './dummy_data.dart';
import '../models/meals.dart';
class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';
  @override
  State<CategoryMealsScreen> createState()=> _CategoryMealsScreenState();
}
class _CategoryMealsScreenState extends State<CategoryMealsScreen>{
  String categoryTitle="";
  List<Meal> displayedMeals=[];
  var _loadedInitData=false;
  @override
  void initState(){
    //...
    super.initState();
  }
  @override
  void didChangeDependencies() {
    if(!_loadedInitData) {
      final routeArgs = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      final categoryId = routeArgs['id'];
      categoryTitle = routeArgs['title']!;
      displayedMeals = DUMMY_MEALS.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadedInitData=true;
    }
    super.didChangeDependencies();
  }
  void _removeMeal(String mealId){
    setState((){
      displayedMeals.removeWhere((meal) => meal.id==mealId);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar:AppBar(title: Text(categoryTitle),),
    body: ListView.builder(itemBuilder: (ctx,index){
      return MealItem(
          id: displayedMeals[index].id,
          title: displayedMeals[index].title,
          imageUrl: displayedMeals[index].imageUrl,
          duration: displayedMeals[index].duration,
          affordability: displayedMeals[index].affordability,
          complexity: displayedMeals[index].complexity,
          removeItem: _removeMeal,
      );
    },itemCount: displayedMeals.length,),
    );
  }
}
