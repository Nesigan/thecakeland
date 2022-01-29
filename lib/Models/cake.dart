import 'package:cloud_firestore/cloud_firestore.dart';

class Cake {
  String? cakeName;
  String? flavour;
  String? sizes;
  String? shapes;
  String? catagory;

  Cake({this.cakeName, this.flavour, this.sizes, this.shapes, this.catagory});

  Cake.fromFirebaseDoc(QueryDocumentSnapshot doc) {
    this.cakeName = doc.get('cakeName');
    this.flavour = doc.get('flavour');
    this.sizes = doc.get('sizes');
    this.shapes = doc.get('shapes');
    this.catagory = doc.get('catagory');
  }
}
