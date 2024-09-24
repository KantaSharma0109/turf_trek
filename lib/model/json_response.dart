class JsonResponse {
  final int customerId;
  final String customerName;
  final String mobileNum;

  JsonResponse({
    required this.customerId,
    required this.customerName,
    required this.mobileNum,
  });
  factory JsonResponse.fromJson(Map<String, dynamic> json) {
    return JsonResponse(
      customerId: json['customer_id'],
      customerName: json['customer_name'],
      mobileNum: json['mobile_num'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customerId': customerId,
      'customerName': customerName,
      'mobileNum': mobileNum,
    };
  }
}
