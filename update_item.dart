import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../Modals/products.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final TextEditingController _productNameTEC = TextEditingController();
  final TextEditingController _productCodeTEC = TextEditingController();
  final TextEditingController _productPriceTEC = TextEditingController();
  final TextEditingController _quantityTEC = TextEditingController();
  final TextEditingController _totalPriceTEC = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  bool _inProgress = false;

  void _showSnackBar(BuildContext context) {
    const snackBar = SnackBar(
      content: Text('Product Added.!'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text("Add Products"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  const EdgeInsets.all(16.0),
          child: _buildNewProductForm(),
        ),
      ),
    );
  }

  Widget _buildNewProductForm() {
    return Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 55,
                child: TextFormField(
                  validator: (String? value){
                    if(value == null || value.isEmpty){
                      return "Enter Valid Value";
                    }
                    return null;
                  },
                  controller: _productNameTEC,
                    decoration: InputDecoration(
                      hintText: "Product Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)
                      )
                    ),
                  ),
              ),
              const SizedBox(height: 18,),
              SizedBox(
                height: 55,
                child: TextFormField(
                  validator: (String? value){
                    if(value == null || value.isEmpty){
                      return "Enter Valid Value";
                    }
                    return null;
                  },
                  controller: _productCodeTEC,
                  decoration: InputDecoration(
                    hintText: "Product Code",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)
                      )
                  ),
                ),
              ),
              const SizedBox(height: 18,),
              SizedBox(
                height: 55,
                child: TextFormField(
                  validator: (String? value){
                    if(value == null || value.isEmpty){
                      return "Enter Valid Value";
                    }
                    return null;
                  },
                  controller: _productPriceTEC,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Price",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)
                      )
                  ),
                ),
              ),
              const SizedBox(height: 18,),
              SizedBox(
                height: 55,
                child: TextFormField(
                  validator: (String? value){
                    if(value == null || value.isEmpty){
                      return "Enter Valid Value";
                    }
                    return null;
                  },
                  controller: _quantityTEC,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Quantity",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)
                      )
                  ),
                ),
              ),
              const SizedBox(height: 18,),
              SizedBox(
                height: 55,
                child: TextFormField(
                  validator: (String? value){
                    if(value == null || value.isEmpty){
                      return "Enter Valid Value";
                    }
                    return null;
                  },
                  controller: _totalPriceTEC,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Total Price",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)
                      )
                  ),
                ),
              ),
              const SizedBox(height: 36,),
              _inProgress ? Center(child: CircularProgressIndicator()) : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.green,
                  backgroundColor: Colors.green[400]
                ),
                  onPressed: _onTabAddProductBtn,
                  child: const Text("ADD PRODUCT",style: TextStyle(
                      fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),))
            ],
          ),
        );
  }

  void _onTabAddProductBtn(){
    if(_formKey.currentState!.validate()){
      addNewProduct();
    }
  }

  Future<void> addNewProduct() async {
    _inProgress = true;
    setState(() {});
    Uri uri = Uri.parse("http://164.68.107.70:6060/api/v1/CreateProduct");
    Map<String,dynamic> requestBody = {
          "ProductCode":_productCodeTEC.text,
          "ProductName":_productNameTEC.text,
          "Qty":_quantityTEC.text,
          "TotalPrice":_totalPriceTEC.text,
          "UnitPrice":_productPriceTEC.text,
    };
    Response response = await post(uri,
        headers: {
          'Content-Type': 'application/json'
        },
        body: jsonEncode(requestBody));
    if(response.statusCode==200) {
      _clearText();
      _showSnackBar(context);
    }
    _inProgress = false;
    setState(() {});
  }


  void _clearText(){
    _productNameTEC.clear();
    _productCodeTEC.clear();
    _productPriceTEC.clear();
    _quantityTEC.clear();
    _totalPriceTEC.clear();
  }

  @override
  void dispose() {
    _productNameTEC.dispose();
    _productCodeTEC.dispose();
    _productPriceTEC.dispose();
    _quantityTEC.dispose();
    _totalPriceTEC.dispose();
    super.dispose();
  }
}
