// pizza restaurant ordering system
import 'dart:io';

enum pizzaSize { Small, Medium, Large }

abstract class Pizza {
  String? name;
  pizzaSize? size;
  double price;
  List<String> toppings;

  Pizza(this.name, this.size, this.price, this.toppings);

  double calculatePrice();

  @override
  String toString() {
    return 'Pizza{name: $name, size: $size, price: $price, toppings: $toppings}';
  }
}

class MargheritaPizza extends Pizza {
  MargheritaPizza(pizzaSize size, List<String> toppings)
    : super("Margherita", size, 8.0, toppings);

  @override
  double calculatePrice() {
    double totalPrice = price;
    if (size == pizzaSize.Small) {
      totalPrice += 0.0;
    } else if (size == pizzaSize.Medium) {
      totalPrice += 2.0;
    } else if (size == pizzaSize.Large) {
      totalPrice += 4.0;
    }
    return totalPrice;
  }
}

class PepperoniPizza extends Pizza {
  PepperoniPizza(pizzaSize size, List<String> toppings)
    : super("Pepperoni", size, 10.0, toppings);

  @override
  double calculatePrice() {
    double totalPrice = price;
    if (size == pizzaSize.Small) {
      totalPrice += 0.0;
    } else if (size == pizzaSize.Medium) {
      totalPrice += .0;
    } else if (size == pizzaSize.Large) {
      totalPrice += 6.0;
    }
    if (toppings.contains("Extra Pepperoni")) {
      totalPrice += 2.0;
    }
    return totalPrice;
  }
}

class VeggiePizza extends Pizza {
  VeggiePizza(pizzaSize size, List<String> toppings)
    : super("Veggie", size, 9.0, toppings);

  @override
  double calculatePrice() {
    double totalPrice = price;
    if (size == pizzaSize.Small) {
      totalPrice += 0.0;
    } else if (size == pizzaSize.Medium) {
      totalPrice += 2.5;
    } else if (size == pizzaSize.Large) {
      totalPrice += 5.0;
    }
    totalPrice += toppings.length * 1.0;
    return totalPrice;
  }
}

class orderPizza {
  String? orderId;
  String? customerId;
  Pizza? pizza;
  double? price;

  orderPizza(this.orderId, this.customerId, this.pizza, this.price) {
    price = pizza!.calculatePrice();
  }

  void payOrder() {
    print("Processing payment of \$${price?.toStringAsFixed(2)}...");
    print("Payment successful!");
  }

  @override
  String toString() {
    return 'Order ID: $orderId\nCustomer ID: $customerId\nPizza: ${pizza.toString()}\nTotal Price: \$${price?.toStringAsFixed(2)}';
  }
}

displayPizzaOrder(String size, String type, int numToppings) {
  print("Pizza Order:");
  print("Size: $size");
  print("Type: $type");
  print("Number of Toppings: $numToppings");
}

void main() {
  print("🍕 Welcome to the Pizza Ordering System 🍕");

  while (true) {
    print("\nMain Menu:");
    print("1. Order a Pizza");
    print("2. Exit");
    stdout.write("Enter your choice: ");
    String choice = stdin.readLineSync()!;

    if (choice == "1") {
      print("\nSelect Pizza Type:");
      print("1. Margherita Pizza");
      print("2. Pepperoni Pizza");
      print("3. Veggie Pizza");
      stdout.write("Enter your choice: ");
      String pizzaChoice = stdin.readLineSync()!;

      print("\nSelect Pizza Size:");
      print("1. Small");
      print("2. Medium");
      print("3. Large");
      stdout.write("Enter your choice: ");
      String sizeChoice = stdin.readLineSync()!;
      pizzaSize size = pizzaSize.values[int.parse(sizeChoice) - 1];

      List<String> toppings = [];
      print("\nAdd Toppings (comma-separated, e.g., Cheese, Mushrooms):");
      print("Available Toppings: Cheese, Mushrooms, Olives, Extra Pepperoni");
      stdout.write("Enter toppings (or leave blank): ");
      String toppingsInput = stdin.readLineSync()!;
      if (toppingsInput.isNotEmpty) {
        toppings = toppingsInput.split(',').map((e) => e.trim()).toList();
      }
      Pizza pizza;
      switch (pizzaChoice) {
        case "1":
          pizza = MargheritaPizza(size, toppings);
          break;
        case "2":
          pizza = PepperoniPizza(size, toppings);
          break;
        case "3":
          pizza = VeggiePizza(size, toppings);
          break;
        default:
          print("Invalid choice. Please try again.");
          continue;
      }
      orderPizza order = orderPizza("123", "456", pizza, pizza.price);
      print("\nYour Order:");
      print(order.toString());
      stdout.write("Confirm and pay? (Y/N): ");
      String confirm = stdin.readLineSync()!;
      if (confirm.toLowerCase() == "y") {
        order.payOrder();
        print("Thank you for your order!");
      } else {
        print("Order canceled.");
      }
    } else if (choice == "2") {
      print("Exiting the Pizza Ordering System. Goodbye!");
      break;
    } else {
      print("Invalid choice. Please try again.");
    }
  }
}