import 'package:food_delivery_app/model/burger_model.dart';

List<BurgerModel> getBurger() {
  List<BurgerModel> burger = [];

  BurgerModel burgerModel = BurgerModel();

  burgerModel.name = "Cheese Burger";
  burgerModel.image = "images/burger1.png";
  burgerModel.price = "399";
  burger.add(burgerModel);
  burgerModel = new BurgerModel();

  burgerModel.name = "Veggie Burger";
  burgerModel.image = "images/burger2.png";
  burgerModel.price = "299";
  burger.add(burgerModel);
  burgerModel = new BurgerModel();

  burgerModel.name = "Cheese Burger";
  burgerModel.image = "images/burger1.png";
  burgerModel.price = "399";
  burger.add(burgerModel);
  burgerModel = new BurgerModel();

  burgerModel.name = "Veggie Burger";
  burgerModel.image = "images/burger2.png";
  burgerModel.price = "299";
  burger.add(burgerModel);
  burgerModel = new BurgerModel();

  return burger;
}
