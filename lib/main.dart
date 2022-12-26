import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Expandable Grid Issue'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool seeAll = false;
  double fullGridHeight = 0;
  double shortGridHeight = 0;
  int shorGridItems = 2;
  double gridColumnLength = 0;
  List<Widget> productCards = [];
  @override
  void initState() {
    for (int i = 0; i < 7; i++) {
      productCards.add(Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.blue,
        ),
      ));
    }
    gridColumnLength = (productCards.length / 2).roundToDouble();
    fullGridHeight = gridColumnLength * 200 + gridColumnLength * 25;
    shortGridHeight = shorGridItems * 200 + shorGridItems * 25;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                height: seeAll ? fullGridHeight : shortGridHeight,
                child: DynamicHeightGridView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    builder: ((context, index) {
                      return productCards[index];
                    }),
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 25,
                    itemCount: productCards.length,
                    crossAxisCount: 2),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    seeAll = !seeAll;
                  });
                },
                child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: GestureDetector(
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              seeAll ? 'Show less' : 'Show more',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ));
  }
}
