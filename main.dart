import 'dart:convert';

import 'package:assingments/Modals/products.dart';
import 'package:assingments/Screen/update_item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:http/http.dart';
import 'Screen/product_item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyBagScreen(),
    );
  }
}

class MyBagScreen extends StatefulWidget {
   const MyBagScreen({super.key});

  @override
  _MyBagScreenState createState() => _MyBagScreenState();
}

class _MyBagScreenState extends State<MyBagScreen> {

  List<Products>productsItemList = [];
  bool _inProgress = false;

  @override
  void initState() {
    super.initState();
    getProductApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            getProductApi();
          }, icon: Icon(Icons.refresh_rounded))
        ],
        backgroundColor: Colors.cyan,
        title: const Text("API Integrate"),
        centerTitle: true,
      ),
      body:_inProgress ? Center(child: CircularProgressIndicator(),) : Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(itemBuilder: (context,index){
          return ProductItem(
            products: productsItemList[index],
          );
        },
            separatorBuilder: (context,index){
          return const SizedBox(height: 16,);
            },
            itemCount: productsItemList.length)
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return const AddItem();
        }));
      },
        child: const Icon(Icons.add_circle),),
    );
  }

  Future<void> getProductApi() async {
    productsItemList.clear();
    _inProgress = true;
    setState(() {
    });
    Uri uri = Uri.parse("http://164.68.107.70:6060/api/v1/ReadProduct");
    Response response = await get(uri);
    if(response.statusCode==200) {
      productsItemList.clear();
      Map<String, dynamic>jsonResponse = jsonDecode(response.body);
      for(var item in jsonResponse["data"] ){
        Products products = Products(id: item["_id"] ?? '',
            ProductName: item["ProductName"] ?? '',
            ProductCode: item["ProductCode"] ?? '',
            Img: item["Img"] ?? '',
            UnitPrice: item["UnitPrice"] ?? '',
            Qty: item["Qty"] ?? '',
            TotalPrice: item["TotalPrice"] ?? '',
            CreatedDate: item["CreatedDate"] ?? '');
        productsItemList.add(products);
      }
    }
    _inProgress = false;
    setState(() {
    });
  }

}

