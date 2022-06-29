class HaberModel {
  String? icerikTitle;
  String? icerikContent;
  String? icerikCover;
  String? icerikUrl;
  String? icerikDate;

  HaberModel(
      {this.icerikTitle,
        this.icerikContent,
        this.icerikCover,
        this.icerikUrl,
        this.icerikDate});

  HaberModel.fromJson(Map<String, dynamic> json) {
    icerikTitle = json['icerikTitle'];
    icerikContent = json['icerikContent'];
    icerikCover = json['icerikCover'];
    icerikUrl = json['icerikUrl'];
    icerikDate = json['icerikDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icerikTitle'] = this.icerikTitle;
    data['icerikContent'] = this.icerikContent;
    data['icerikCover'] = this.icerikCover;
    data['icerikUrl'] = this.icerikUrl;
    data['icerikDate'] = this.icerikDate;
    return data;
  }
}
