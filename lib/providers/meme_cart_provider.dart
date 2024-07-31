import 'package:flutter/material.dart';
import 'package:meme_app/models/cart_card_model.dart';

class MemeCartProvider extends ChangeNotifier{
  final List<CartCardModel> _cartList = <CartCardModel> [];
  final List<String> _memesIdList = <String>[];

  List<CartCardModel> get getCartList => _cartList;
  List<String> get getMemesIds => _memesIdList;

  void addItem(CartCardModel addThisItem){
    _cartList.add(addThisItem);
    _memesIdList.add(addThisItem.id);
    notifyListeners();
  }


  void removeItem(String memeId){
    _cartList.removeWhere((e) => e.id == memeId);
    _memesIdList.remove(memeId);
    notifyListeners();
  }
} 
