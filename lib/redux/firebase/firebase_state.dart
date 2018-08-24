import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';

@immutable
class FirebaseState{
  FirebaseState({
    @required this.firebaseUser,
    @required this.mainReference,
  });

  FirebaseUser firebaseUser;
  final DatabaseReference mainReference;

  factory FirebaseState.initial(){
    return FirebaseState(
      firebaseUser: null,
      mainReference: null,
    );
  }

  FirebaseState copyWith({
    FirebaseUser firebaseUser,
    DatabaseReference mainReference,
  }){
    return FirebaseState(
      firebaseUser: firebaseUser ?? this.firebaseUser,
      mainReference: mainReference ?? this.mainReference,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
        other is FirebaseState &&
          runtimeType == other.runtimeType &&
          firebaseUser == other.firebaseUser &&
          mainReference == other.mainReference;

  @override
  int get hashCode =>
      firebaseUser.hashCode ^
      mainReference.hashCode;
}