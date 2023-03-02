import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_ordering/food.dart';

void main() {
  runApp(MaterialApp(
    home: const FoodOrderPage(),
    theme: lightTheme,
    darkTheme: darkTheme,
  ));
}

final _lightColorScheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFFF87A24), brightness: Brightness.light);
final lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: _lightColorScheme,
);

final _darkColorScheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFFF87A24), brightness: Brightness.dark);
final darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: _darkColorScheme,
);

class FoodOrderPage extends StatefulWidget {
  const FoodOrderPage({super.key});

  @override
  State<FoodOrderPage> createState() => _FoodOrderPageState();
}

final food = [
  Food(
      title: "Classic Pizza",
      price: 12.0,
      imagePath: "assets/pizza.jpg",
      rating: 4),
  Food(
      title: "Green Salad",
      price: 5.5,
      imagePath: "assets/green_salad.jpg",
      rating: 5),
  Food(
      title: "Tomato Pasta",
      price: 13.75,
      imagePath: "assets/tomato_pasta.jpg",
      rating: 5),
];

class _FoodOrderPageState extends State<FoodOrderPage> {
  var totalCost = 0.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu_outlined),
          onPressed: () {},
        ),
        title: const Text("Menu"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.account_circle_outlined),
          )
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            ListView.separated(
              padding: const EdgeInsets.all(20),
              itemBuilder: (context, index) {
                final eachItem = food[index];
                return Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        eachItem.imagePath,
                        height: 120,
                        width: 120,
                        fit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            eachItem.title,
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "\$${eachItem.price.toStringAsFixed(2)}",
                            style: TextStyle(
                                fontSize: 16,
                                color: theme.colorScheme.onSurfaceVariant),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          RatingBarIndicator(
                            itemBuilder: ((context, index) {
                              return Icon(
                                Icons.star,
                                color: theme.colorScheme.primary,
                              );
                            }),
                            itemSize: 20,
                            rating: eachItem.rating.toDouble(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Center(
                        child: !eachItem.isSelected
                            ? IconButton(
                                icon: const Icon(Icons.add_outlined),
                                onPressed: () {
                                  eachItem.isSelected = true;
                                  totalCost += eachItem.price;
                                  setState(() {});
                                },
                                style: IconButton.styleFrom(
                                  foregroundColor: theme.colorScheme.onPrimary,
                                  backgroundColor: theme.colorScheme.primary,
                                ))
                            : IconButton(
                                icon: const Icon(Icons.delete_forever_outlined),
                                onPressed: () {
                                  eachItem.isSelected = false;
                                  totalCost -= eachItem.price;
                                  setState(() {});
                                },
                                style: IconButton.styleFrom(
                                  foregroundColor:
                                      theme.colorScheme.onSecondaryContainer,
                                  backgroundColor:
                                      theme.colorScheme.secondaryContainer,
                                ),
                              ),
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 20,
              ),
              itemCount: food.length,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: theme.colorScheme.primaryContainer,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Cost: \$${totalCost.toStringAsFixed(2)}",
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: theme.colorScheme.onPrimary),
                      child: const Text("View Cart"),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
