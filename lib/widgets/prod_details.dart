// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduate_work/constants.dart';

class ProductDetails extends StatefulWidget {
  String? id_prod;
  String? name;
  int? price;
  String? des;

  ProductDetails({Key? key, this.name, this.des, this.id_prod, this.price}) : super(key: key);
  
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  Color _favIcon = login_bg;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(234, 253, 251, 251),
      appBar: AppBar(
        elevation: 0,
        foregroundColor: login_bg,
        backgroundColor: Colors.transparent,
        actions: [IconButton(color: _favIcon,
          onPressed: (){
          FirebaseFirestore.instance.collection('FavoriteProd').add({'idprod': widget.id_prod, 'iduser': 1});
          setState(() {
            _favIcon = Colors.red;
          });
        }, icon: const Icon(Icons.favorite))],),
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
          Image.asset("assets/logo.png", height: MediaQuery.of(context).size.height * 0.3, fit: BoxFit.cover,),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            ),
            child: SingleChildScrollView(
              child: Column(children: [
                Row(
                  children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.63,
                    child: Text('${widget.name}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.1,
                    width: MediaQuery.of(context).size.width * 0.06,
                    child: const Text('|', style: TextStyle(fontSize: 36),),),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: Text('${widget.price} P', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                ],),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text('${widget.des}', style: const TextStyle(color: Colors.grey),),),
              SizedBox( height: MediaQuery.of(context).size.height * 0.01,),
              SizedBox(
                height: 50,
                width: 200,
                child: ElevatedButton(
                  onPressed: (){
                    FirebaseFirestore.instance.collection('Cart').add({'totalsum': widget.price, 'idprod': widget.id_prod, 'iduser': 1});
                  }, 
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(btn_color),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
                  ),
                  child: const Text('Добавить в корзину'),))
              ]
              ),
            ),
          ),
          ),
        ],
      ),
    );
  }
}