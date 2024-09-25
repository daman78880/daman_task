class SaveDataModel {
  String? _userId;
  String? _recordName;
  List<String>? _imageUrls;

  SaveDataModel({String? userId, String? recordName, List<String>? imageUrls}) {
    if (userId != null) {
      this._userId = userId;
    }
    if (recordName != null) {
      this._recordName = recordName;
    }
    if (imageUrls != null) {
      this._imageUrls = imageUrls;
    }
  }

  String? get userId => _userId;
  set userId(String? userId) => _userId = userId;
  String? get recordName => _recordName;
  set recordName(String? recordName) => _recordName = recordName;
  List<String>? get imageUrls => _imageUrls;
  set imageUrls(List<String>? imageUrls) => _imageUrls = imageUrls;

  SaveDataModel.fromJson(Map<String, dynamic> json) {
    _userId = json['user_id'];
    _recordName = json['record_name'];
    _imageUrls = json['image_urls'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this._userId;
    data['record_name'] = this._recordName;
    data['image_urls'] = this._imageUrls;
    return data;
  }
}
