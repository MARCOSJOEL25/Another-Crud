import 'dart:io';

import 'package:crud/pages/CreateOrUpdate.dart';
import 'package:crud/provider/provider_crud.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/product.dart';

Future<void> main() async {
  // Required for background service
  WidgetsFlutterBinding.ensureInitialized();
  // await initializeService(); // Do this later when all permissions are initialized
  HttpOverrides.global = DevHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => provider_crud()),
        ],
        child: MyHomePage(title: 'C R U D'),
      ),
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
  @override
  Widget build(BuildContext context) {
    final List<Product> productList =
        Provider.of<provider_crud>(context).ListProduct;

    if (productList.isEmpty) {
      return Scaffold(
        body: Container(
          child: Center(child: Text('No hay productos')),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CreateOrEdit()));
          },
          tooltip: 'Agregar',
          child: const Icon(Icons.add),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        width: double.infinity,
        child: ListView(
          children: [for (var item in productList) cardCustom(product: item)],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Agregar',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class cardCustom extends StatefulWidget {
  final Product product;
  const cardCustom({super.key, required this.product});

  @override
  State<cardCustom> createState() => _cardCustomState();
}

class _cardCustomState extends State<cardCustom> {
  @override
  Widget build(BuildContext context) {
    final productAction = Provider.of<provider_crud>(context);

    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: Icon(Icons.create),
            onPressed: () {
              // print('Clicked on delete icon');
            },
          ),
        ),
        title: Text(
          widget.product.productName,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black12,
          ),
        ),
        trailing: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: Icon(Icons.delete),
            onPressed: () {
              setState(() {
                productAction.deleteProduct(widget.product.productId);
              });
              print('eliminado');
            },
          ),
        ),
      ),
    );
  }
}

class DevHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
