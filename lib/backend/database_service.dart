import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseServices{
  FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;

  Future <void> storeUserInfo({required Map <String, dynamic> userInfo, required String userId})async{
    firebaseFireStore.collection('user').doc(userId).set(userInfo).catchError((error) => print(error.toString()));
  }

  Future <void> updateInfo({required collectionName, required Map <String, dynamic> userInfo, required String userId})async{
    firebaseFireStore.collection(collectionName).doc(userId).update(userInfo).catchError((error) => print(error.toString()));
  }

  Future <void> addItem({required Map <String, dynamic> itemDetails, required String docId, required String collectionName})async{
    firebaseFireStore.collection("items").doc(docId).collection(collectionName).add(itemDetails).catchError((error) => error);
  }

  Future getAllUsers()async{
    return firebaseFireStore.collection('user').orderBy("orderingDate", descending: true).snapshots();
  }

  Future getItemsForAdmin({required String docId, required String collection})async{
    return firebaseFireStore.collection('items').doc(docId).collection(collection).orderBy("ordering_date", descending: true).snapshots();
  }


  Future <void> deleteItem({required String folderId, required String collectionPath, required String docId})async{
    firebaseFireStore.collection("items").doc(folderId).collection(collectionPath).doc(docId).delete().catchError((onError) => onError);
  }

  Future getItemsForUsers({required String docId, required String collection})async{
    return firebaseFireStore.collection('items').doc(docId).collection(collection).orderBy("ordering_date", descending: true).snapshots();
  }


  Future <void> addRequests({required String collectionName, required Map <String, dynamic> itemDetails,})async{
    firebaseFireStore.collection(collectionName).add(itemDetails).catchError((error) => error);
  }

  Future <void> addHostelRules({required Map <String, dynamic> rules,})async{
    firebaseFireStore.collection("hostelRules").doc("rules").update(rules).catchError((error) => error);
  }

  Future getUserLeaveAndVisitorRequest({required String collectionName, required String userId, required String status})async{
    return firebaseFireStore.collection(collectionName).where("uid", isEqualTo: userId).where("status", isEqualTo: status).orderBy("ordering_date", descending: true).snapshots();
  }

  Future getAdminLeaveAndVisitorRequest({required String collectionName, required String status})async{
    return firebaseFireStore.collection(collectionName).where("status", isEqualTo: status).orderBy("ordering_date", descending: true).snapshots();
  }

  Future getCSE({required String collectionName, required String userId})async{
    return firebaseFireStore.collection(collectionName).where("uid", isEqualTo: userId).orderBy("ordering_date", descending: true).snapshots();
  }

  Future getCSEAdmin({required String collectionName})async{
    return firebaseFireStore.collection(collectionName).orderBy("ordering_date", descending: true).snapshots();
  }
  Future getHostelRule({required String collectionName})async{
    return firebaseFireStore.collection(collectionName).snapshots();
  }

  Future getBookingsForAdmin({required String status})async{
    return firebaseFireStore.collection('bookings').where("status", isEqualTo: status).orderBy("ordering_date", descending: true).snapshots();
  }

  Future getDocId({required String userId, required String collectionName}){
    return firebaseFireStore.collection(collectionName).where("uid", isEqualTo: userId).get().catchError((error) =>error);
  }

  Future getDocIdAdmin({required String collectionName}){
    return firebaseFireStore.collection(collectionName).get().catchError((error) =>error);
  }

  Future <void> updateStatus({required String collectionName, required Map <String, dynamic> docInfo, required String docId})async{
    firebaseFireStore.collection(collectionName).doc(docId).update(docInfo).catchError((error) => print(error.toString()));
  }

  Future getDocIdForAdmin(){
    return firebaseFireStore.collection("bookings").get().catchError((error) => error);
  }

  Future <void> updateOverStayed({required String collectionName, required Map <String, dynamic> docInfo, required String docId})async{
    firebaseFireStore.collection(collectionName).doc(docId).update(docInfo).catchError((error) => print(error.toString()));
  }

  Future <void> deleteBooking({required docId})async{
    firebaseFireStore.collection("bookings").doc(docId).delete().catchError((onError) => onError);
  }


  Future <void> addToBlacklist({required Map <String, dynamic> itemDetails,})async{
    firebaseFireStore.collection("blacklist").add(itemDetails).catchError((error) => error);
  }

  Future getAllBlacklist()async{
    return firebaseFireStore.collection('blacklist').orderBy("ordering_date", descending: true).snapshots();
  }

  Future <void> removeUserFromBlacklist({required docId})async{
    firebaseFireStore.collection("blacklist").doc(docId).delete().catchError((onError) => onError);
  }

  Future getSearch(){
    return firebaseFireStore.collection("items").doc("bookDoc").collection("books").orderBy("title").get().catchError((error) => error);
  }
}


