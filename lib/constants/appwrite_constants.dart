class AppwriteConstants {
  static const String databaseId = '64ef1174a443b1c45a0b';
  static const String projectId = '64e1db63df0354c2f3c6';
  static const String endPoint =
      'http://192.168.151.196:80/v1'; //this helps flutter communicate with appwrite
  static const String usersCollection = '651238192ad37ed98e84';
  static const String tweetsCollection = '65185f7f1adbc9bcdea7';
  static const String imagesBucket = '651ae8155e91cec899e8';

  static String imageUrl(String imageId) =>
      '$endPoint/v1/storage/buckets/$imagesBucket/files/$imageId/view?project=$projectId&mode=admin';
}
