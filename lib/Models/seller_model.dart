class SellerModel {
  String? sellerName;
  String? profileImage;
  String? sellerCNIC;
  String? sellerAddress;
  String? sellerEmail;
  String? sellerPhoneNumber;
  String? sellerCNICImage1;
  String? sellerCNICImage2;
  String? sellerShopImage;
  String? uId;
  bool? verification;

  SellerModel({
    required this.profileImage,
    required this.uId,
    required this.sellerEmail,
    required this.verification,
    required this.sellerAddress,
    this.sellerCNIC,
    required this.sellerCNICImage1,
    required this.sellerCNICImage2,
    required this.sellerName,
    required this.sellerPhoneNumber,
    required this.sellerShopImage,
  });
}
