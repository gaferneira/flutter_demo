import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterdemo/data/entities/Book.dart';
import 'package:flutterdemo/data/repositories/BooksRepository.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BooksRepository booksRepository = BooksRepository();
  StreamSubscription streamSubscription;

  List<Book> books = List();

  @override
  void initState() {
    streamSubscription = booksRepository.fetchAllBooks().listen((newList) {
      setState(() {
        books = newList;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final key = new GlobalKey<ScaffoldState>();
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text("Books list"),
      ),
      body: new ListView(
        children: books.map(_buildItem).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          key.currentState.showSnackBar(new SnackBar(
            content: new Text("//TODO Implement"),
          ));
        },
        tooltip: 'Add Book',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildItem(Book book) {
    return new ListTile(
      title: new Text(book.name),
      subtitle: new Text('Author: ${book.author}'),
      leading: Image.network(book.coverUrl),
      onTap: () {
        //TODO Implement see details
      },
    );
  }

  @override
  void dispose() {
    streamSubscription?.cancel();
    super.dispose();
  }
}
