class VivaWallet {
  int orderCode;
  int errorCode;
  String errorText;
  String timeStamp;
  int correlationId;
  int eventId;
  bool success;

  VivaWallet(
      {this.orderCode,
      this.errorCode,
      this.errorText,
      this.timeStamp,
      this.correlationId,
      this.eventId,
      this.success});

  VivaWallet.fromJson(Map<String, dynamic> json) {
    orderCode = json['OrderCode'];
    errorCode = json['ErrorCode'];
    errorText = json['ErrorText'];
    timeStamp = json['TimeStamp'];
    correlationId = json['CorrelationId'];
    eventId = json['EventId'];
    success = json['Success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OrderCode'] = this.orderCode;
    data['ErrorCode'] = this.errorCode;
    data['ErrorText'] = this.errorText;
    data['TimeStamp'] = this.timeStamp;
    data['CorrelationId'] = this.correlationId;
    data['EventId'] = this.eventId;
    data['Success'] = this.success;
    return data;
  }
}
