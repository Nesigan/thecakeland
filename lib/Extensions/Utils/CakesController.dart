import 'package:the_cake_land/Models/cake.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CakesController {
  Future<List<Cake>> getCakeByCatagory(cakeCatagories Catagory) async {
    FirebaseFirestore _db = FirebaseFirestore.instance;
    List<QueryDocumentSnapshot> docs = (await _db
            .collection('Cakes')
            .where('Catagory', isEqualTo: Catagory)
            .get())
        .docs;

    return docs.map((e) => Cake.fromFirebaseDoc(e)).toList();
  }
}

enum cakeCatagories { Birthday, Wedding, Party, Costomize }
