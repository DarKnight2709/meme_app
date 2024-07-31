import 'dart:convert';

import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meme_app/models/cart_card_model.dart';
import 'package:meme_app/models/meme_model.dart';
import 'package:meme_app/providers/cart_counter_provider.dart';
import 'package:meme_app/providers/meme_cart_provider.dart';
import 'package:meme_app/screens/cart_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late Future<MemeModel> memes;

  Future<MemeModel> fetchMemes() async{
    http.Response response = await http.get(Uri.parse('https://api.imgflip.com/get_memes'));

    var data = jsonDecode(response.body);

    if(response.statusCode == 200){
      return MemeModel.fromJson(data  as Map<String, dynamic>);
    }
    else{
      return MemeModel.fromJson(data);
    }    
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    memes = fetchMemes();

    

    

  }

  @override
  Widget build(BuildContext context) {
    var cartCounter = context.watch<CartCounterProvider>();
    var memeCartProvider = context.watch<MemeCartProvider>();
    return Scaffold(
      backgroundColor: const Color(0xffEFE9FF),
      appBar: AppBar(
        title: const Text("Memes App", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueGrey,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15, top: 5),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                    size: 25,
                  ),
                  onPressed: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const CartPage())
                    );
                  },
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.orange,
                      maxRadius: 10,
                    ),
                    Text("${cartCounter.getCartCount}")

                  ]
                )

              ],
            )
          )
        ]
      ),
      body: FutureBuilder<MemeModel>(
        future: memes,
        builder: (context, snapshot) {
          return Scrollbar(
            radius: const Radius.circular(10),
            thumbVisibility: true,
            thickness: 5,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: DynamicHeightGridView(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 10,
                  itemCount:
                      //nullcheck operator
                      snapshot.hasData ? snapshot.data!.data.memes.length : 1,
                  builder: (context, index) {
                    if (snapshot.hasData) {
                      String memeId =
                          snapshot.data!.data.memes[index].id.toString();
                      String memeName =
                          snapshot.data!.data.memes[index].name.toString();
                      String memeImageUrl =
                          snapshot.data!.data.memes[index].url.toString();

                      CartCardModel addCartItem = CartCardModel(
                          id: memeId,
                          nameCart: memeName,
                          imageUrlCart: memeImageUrl);
                      return Card(
                          elevation: 10,
                          child: SizedBox(
                            child: Column(
                                // mainAxisSize: MainAxisSize.max
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(memeImageUrl)),
                                  const SizedBox(height: 5),
                                 Row(children: [
                                   IconButton(onPressed: (){
                                    


                                   }, icon: const Icon(Icons.share)),
                                   

                                   memeCartProvider.getCartList.contains(addCartItem)
                                    ? const SizedBox(height: 2, width: 2)

                                  
                                    : IconButton(onPressed: (){
                                    var memeCartProvider = context.read<MemeCartProvider>();
                                    if(!memeCartProvider.getMemesIds.contains(addCartItem.id)) {cartCounter.increment();}
                                    memeCartProvider.addItem(addCartItem);

                                   }, icon: const Icon(Icons.download))

                                 ],)

                                
                                ]),
                          ));
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text("Error Occured : ${snapshot.error}"),
                      );
                    } else {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: Colors.teal,
                      ));
                    }
                  }),
            ),
          );
        },
      ),
    );
  }
}

