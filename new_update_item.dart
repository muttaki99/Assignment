import 'package:flutter/material.dart';

class NewUpdateItem extends StatefulWidget {
  const NewUpdateItem({super.key});

  @override
  State<NewUpdateItem> createState() => _NewUpdateItemState();
}

class _NewUpdateItemState extends State<NewUpdateItem> {
  final TextEditingController _productNameTEC = TextEditingController();
  final TextEditingController _productCodeTEC = TextEditingController();
  final TextEditingController _productPriceTEC = TextEditingController();
  final TextEditingController _quantityTEC = TextEditingController();
  final TextEditingController _totalPriceTEC = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _inProgress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text("Update Products",),
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
            child: TextField(
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
            child: TextField(
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
            child: TextField(
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
            child: TextField(
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
            child: TextField(
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
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.green,
                  backgroundColor: Colors.green[400]
              ),
              onPressed: (){},
              child: const Text("UPDATE",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),))
        ],
      ),
    );
  }


  @override
  void dispose() {
    _productNameTEC.dispose();
    _productCodeTEC.dispose();
    _totalPriceTEC.dispose();
    _quantityTEC.dispose();
    _totalPriceTEC.dispose();
    super.dispose();
  }
}
