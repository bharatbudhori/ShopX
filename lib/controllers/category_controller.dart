import 'package:get/get.dart';
import 'package:shop_x/models/categories.dart';

class CategoryController extends GetxController {
  var categoryList = List<Category>().obs;

  @override
  void onInit() {
    addDummyData();
    super.onInit();
  }

  void addDummyData() {
    categoryList.add(Category(
      imageURL:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSiCMIh6OoUQVjvCIJUAXvNZOTgHeD6L8OcxQ&usqp=CAU',
      name: "L'OREAL",
    ));
    categoryList.add(Category(
      imageURL:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSiCMIh6OoUQVjvCIJUAXvNZOTgHeD6L8OcxQ&usqp=CAU',
      name: "L'OREAL",
    ));
    categoryList.add(Category(
      imageURL:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSiCMIh6OoUQVjvCIJUAXvNZOTgHeD6L8OcxQ&usqp=CAU',
      name: "L'OREAL",
    ));
    categoryList.add(Category(
      imageURL:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSiCMIh6OoUQVjvCIJUAXvNZOTgHeD6L8OcxQ&usqp=CAU',
      name: "L'OREAL",
    ));
    categoryList.add(Category(
      imageURL:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSiCMIh6OoUQVjvCIJUAXvNZOTgHeD6L8OcxQ&usqp=CAU',
      name: "L'OREAL",
    ));
    categoryList.add(Category(
      imageURL:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSiCMIh6OoUQVjvCIJUAXvNZOTgHeD6L8OcxQ&usqp=CAU',
      name: "L'OREAL",
    ));
    categoryList.add(Category(
      imageURL:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSiCMIh6OoUQVjvCIJUAXvNZOTgHeD6L8OcxQ&usqp=CAU',
      name: "L'OREAL",
    ));
    categoryList.add(Category(
      imageURL:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSiCMIh6OoUQVjvCIJUAXvNZOTgHeD6L8OcxQ&usqp=CAU',
      name: "L'OREAL",
    ));
    categoryList.add(Category(
      imageURL:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSiCMIh6OoUQVjvCIJUAXvNZOTgHeD6L8OcxQ&usqp=CAU',
      name: "L'OREAL",
    ));
  }
}
