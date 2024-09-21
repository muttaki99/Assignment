import 'dart:convert';

import 'package:assingments/Modals/products.dart';
import 'package:assingments/Screen/new_update_item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:http/http.dart';

class ProductItem extends StatefulWidget {
   ProductItem({
    super.key, required this.products,
  });

  final Products products;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  List<Products>productsDeleteItemList = [];
  bool _inProgress = false;

  @override
  Widget build(BuildContext context) {
    return _inProgress ? Center(child: CircularProgressIndicator()): ListTile(
      tileColor: Colors.white,
      title: Text("Product Name : ${widget.products.ProductName}",
        style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text("Product Code : ${widget.products.ProductCode}"),
           Text("Price : \$${widget.products.UnitPrice}"),
           Text("Quantity : ${widget.products.Qty}"),
           Text("Total Price : \$${widget.products.TotalPrice}"),
           SizedBox(height: 16,),
           Divider(thickness: 2,
            color: Colors.black54,
          ),
          ButtonBar(
            children: [
              TextButton.icon(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return const NewUpdateItem();
                }));
              },
                icon: const Icon(Icons.edit,color: Colors.green,),
                label: const Text("Edit",style: TextStyle(color: Colors.green),),),
              TextButton.icon(onPressed: (){
                deleteProduct(widget.products.id.toString());
              },
                icon: const Icon(Icons.delete_outline,color: Colors.red,),
                label: const Text("Delete",style: TextStyle(color: Colors.red),),)
            ],
          )
        ],
      ),
    );
  }

  Future<void> getProductApi() async {
    productsDeleteItemList.clear();
    _inProgress = true;
    setState(() {
    });
    Uri uri = Uri.parse("http://164.68.107.70:6060/api/v1/ReadProduct");
    Response response = await get(uri);
    if(response.statusCode==200) {
      productsDeleteItemList.clear();
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
        productsDeleteItemList.add(products);
      }
    }
    _inProgress = false;
    setState(() {});
  }

  Future<void> deleteProduct(String id) async {
    _inProgress = true;
    final url = "http://164.68.107.70:6060/api/v1/DeleteProduct/$id";
    final uri = Uri.parse(url);

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Deleted Successfully"),
          ),
        );
        getProductApi();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: ${response.statusCode}"),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to delete product: $e"),
        ),
      );
    }
      _inProgress = false; // Ensure this runs in both success and error cases
      setState(() {});
    }

}

