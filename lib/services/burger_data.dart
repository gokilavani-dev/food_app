import 'package:food_delivery_app/model/burger_model.dart';

List<BurgerModel> getBurger() {
  List<BurgerModel> burger = [];

  BurgerModel burgerModel = BurgerModel();

  burgerModel.name = "Cheese Burger";
  burgerModel.image = "images/burger1.png";
  burgerModel.price = "399";
  burgerModel.description =
      "Cheeseburgers are a celebration of rich flavours, with gooey cheese perfectly complementing the patty. These burgers have a universal appeal, making them a staple on any burger menu. ";
  burger.add(burgerModel);
  burgerModel = new BurgerModel();

  burgerModel.name = "Veggie Burger";
  burgerModel.image = "images/burger2.png";
  burgerModel.price = "299";
  burgerModel.description =
      "For vegetarians,These burgers are a testament to how creative and delicious vegetarian food can be.";
  burger.add(burgerModel);
  burgerModel = new BurgerModel();

  burgerModel.name = "Cheese Burger";
  burgerModel.image = "images/burger1.png";
  burgerModel.price = "399";
  burgerModel.description =
      "Cheeseburgers are a celebration of rich flavours, with gooey cheese perfectly complementing the patty. These burgers have a universal appeal, making them a staple on any burger menu. ";
  burger.add(burgerModel);
  burgerModel = new BurgerModel();

  burgerModel.name = "Veggie Burger";
  burgerModel.image = "images/burger2.png";
  burgerModel.price = "299";
  burgerModel.description =
      "For vegetarians,These burgers are a testament to how creative and delicious vegetarian food can be.";
  burger.add(burgerModel);
  burgerModel = new BurgerModel();

  return burger;
}
