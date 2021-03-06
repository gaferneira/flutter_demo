import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterdemo/data/entities/Categories.dart';
import 'package:flutterdemo/data/repositories/CategoriesRepository.dart';

class CategoriesPage extends StatefulWidget {
  CategoriesPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CategoriesPage();
  }
}

class _CategoriesPage extends State<CategoriesPage> {
  CategoriesRepository categoriesRepository = CategoriesRepository();
  StreamSubscription streamSubscription;

  int categoriesSize = 0;

  List<Categories> categoriesList = List();

  @override
  void initState() {
    streamSubscription =
        categoriesRepository.fetchCategories().listen((newList) {
      setState(() {
        categoriesSize = newList.length;
        categoriesList = newList;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          title: Text("Explore"),
        ),
        body: new Center(
          child: GridView.count(
              crossAxisCount: 2,
              children: List.generate(categoriesSize,
                  (index) => _buildItemCategory(categoriesList[index]))),
        ));
  }

  Widget _buildItemCategory(Categories category) {
    return new Center(
      child: Column(
        children: [
          FadeInImage.assetNetwork(
            placeholder: "assets/globant_placeholder.png",
            image: category.image,
            fit: BoxFit.fill,
            placeholderCacheHeight: 90,
            placeholderCacheWidth: 120,
            height: 120,
            width: 150,
          ),
          Text(
            category.name,
            maxLines: 2,
            style: Theme.of(context).textTheme.subtitle1,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    streamSubscription?.cancel();
    super.dispose();
  }
}
