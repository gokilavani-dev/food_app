import 'package:food_delivery_app/model/pizza_model.dart';

List<PizzaModel> getPizza() {
  List<PizzaModel> pizza = [];

  PizzaModel pizzaModel = new PizzaModel();

  pizzaModel.name = "Cheese Pizza";
  pizzaModel.image = "images/pizza1.png";
  pizzaModel.price = "399";
  pizzaModel.description =
      "We've established that most cheeses will melt when baked on atop pizza.But which will not only melt but stretch into those gooey,messy strands that can make pizza eating a dlightfully challenging endeavour?";
  pizza.add(pizzaModel);
  pizzaModel = new PizzaModel();

  pizzaModel.name = "Margherita Pizza";
  pizzaModel.image = "images/pizza2.png";
  pizzaModel.price = "299";
  pizzaModel.description =
      "We've established that most cheeses will melt when baked on atop pizza.But which will not only melt but stretch into those gooey,messy strands that can make pizza eating a dlightfully challenging endeavour?";
  pizza.add(pizzaModel);
  pizzaModel = new PizzaModel();

  pizzaModel.name = "Cheese Pizza";
  pizzaModel.image = "images/pizza1.png";
  pizzaModel.price = "399";
  pizzaModel.description =
      "We've established that most cheeses will melt when baked on atop pizza.But which will not only melt but stretch into those gooey,messy strands that can make pizza eating a dlightfully challenging endeavour?";
  pizza.add(pizzaModel);
  pizzaModel = new PizzaModel();

  pizzaModel.name = "Margherita Pizza";
  pizzaModel.image = "images/pizza2.png";
  pizzaModel.price = "299";
  pizzaModel.description =
      "We've established that most cheeses will melt when baked on atop pizza.But which will not only melt but stretch into those gooey,messy strands that can make pizza eating a dlightfully challenging endeavour?";
  pizza.add(pizzaModel);
  pizzaModel = new PizzaModel();

  return pizza;
}
