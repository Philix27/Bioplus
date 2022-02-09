class AppUser {
  final String uid;
  final String username;
  final String phoneNumber;
  final String profilePic;
  final String email;
  final bool verified;
  final List<String> adminTypes;
  final List<String> groupKeys;
  final List<String> access;
  final List<String> cartList;

  AppUser({
    required this.uid,
    required this.username,
    required this.verified,
    required this.cartList,
    required this.email,
    required this.access,
    required this.phoneNumber,
    required this.profilePic,
    required this.adminTypes,
    required this.groupKeys,
  });

  factory AppUser.fromMap(Map<String, dynamic> doc) {
    return AppUser(
      uid: doc['uid'].toString(),
      verified: doc['verified'] as bool,
      phoneNumber: doc['phoneNumber'].toString(),
      email: doc['email'].toString(),
      profilePic: doc['profilePic'].toString(),
      username: doc['username'].toString(),
      adminTypes: List<String>.from(doc['adminTypes'] as Iterable<dynamic>),
      access: List<String>.from(doc['access'] as Iterable<dynamic>),
      groupKeys: doc.containsKey('groupKeys')
          ? List<String>.from(doc['groupKeys'] as Iterable<dynamic>)
          : [],
      cartList: doc.containsKey('cartList')
          ? List<String>.from(doc['cartList'] as Iterable<dynamic>)
          : [],
    );
  }
}
