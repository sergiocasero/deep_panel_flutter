class PanelsInfo {
  int bottom;
  int height;
  int left;
  int panelNumberInPage;
  int right;
  int top;
  int width;

  PanelsInfo(
      {this.bottom = 0,
        this.height = 0,
        this.left = 0,
        this.panelNumberInPage = 0,
        this.right = 0,
        this.top = 0,
        this.width = 0});

  factory PanelsInfo.fromJson(Map<String, dynamic> json) {
    return PanelsInfo(
      bottom: json['bottom'],
      height: json['height'],
      left: json['left'],
      panelNumberInPage: json['panelNumberInPage'],
      right: json['right'],
      top: json['top'],
      width: json['width'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bottom'] = this.bottom;
    data['height'] = this.height;
    data['left'] = this.left;
    data['panelNumberInPage'] = this.panelNumberInPage;
    data['right'] = this.right;
    data['top'] = this.top;
    data['width'] = this.width;
    return data;
  }
}
