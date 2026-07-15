class DisplayDataModel {
  final String blogText;
  final String sender;
  DisplayDataModel({required this.blogText, required this.sender});
  factory DisplayDataModel.fromMap(Map<String, dynamic> map) {
    return DisplayDataModel(blogText: map['blog'] ?? '', sender: map['sender'] ?? '');
  }

  Map<String, dynamic> toMap() {
    return {'blog': blogText, 'sender': sender};
  }
}
