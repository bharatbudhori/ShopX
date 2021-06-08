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
      name: "l'oreal",
    ));
    categoryList.add(Category(
      imageURL:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1BwFxpit0KQCg-aKgHGiKXuSP6cu5rDkOvQ&usqp=CAU',
      name: "maybelline",
    ));
    categoryList.add(Category(
      imageURL:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5oV6HDuGPSR9EEmsoEwR_uquuXHVkQsi2Aw&usqp=CAU',
      name: "marcelle",
    ));
    categoryList.add(Category(
      imageURL:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ1cBRfpmO3b4a5dqLgkZF0HgV32PYNU5qupQ&usqp=CAU',
      name: "butter london",
    ));
    categoryList.add(Category(
      imageURL:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSlGzdns10F3Say74NTsl82-RIA0DmTx2anNA&usqp=CAU',
      name: "pacifica",
    ));
    categoryList.add(Category(
      imageURL:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJjqx2_A2hx2R8bDlkxhtK171Deru8seq06A&usqp=CAU',
      name: "misa",
    ));
    categoryList.add(Category(
      imageURL:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTSnxHe7x96lv8paADk3eeRDZAUcYyc0SA_5Q&usqp=CAU',
      name: "covergirl",
    ));
    categoryList.add(Category(
      imageURL:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThbovPzHyTed1eIHRAY4c8yboOYaAIN4Ml_Q&usqp=CAU',
      name: "mistura",
    ));
    categoryList.add(Category(
      imageURL:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8pC3rHrLniTTrnwfHdpZKKPxOskpA59Ltjw&usqp=CAU',
      name: "milani",
    ));
  }
}
