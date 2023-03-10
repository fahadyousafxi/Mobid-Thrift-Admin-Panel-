class SellerModel {
  String? sellerName;
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
    this.uId,
    this.sellerEmail,
    this.verification,
    this.sellerAddress,
    this.sellerCNIC,
    this.sellerCNICImage1,
    this.sellerCNICImage2,
    this.sellerName,
    this.sellerPhoneNumber,
    this.sellerShopImage,
});

}