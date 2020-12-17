import 'package:deep_panel_flutter/PanelsInfo.dart';

class Panels {
  int numberOfPanels;
  List<PanelsInfo> panelsInfo;

  Panels(this.numberOfPanels, this.panelsInfo);

  factory Panels.fromJson(Map<String, dynamic> json) {
    return Panels(json['numberOfPanels'], (json['panelsInfo'] as List).map((i) => PanelsInfo.fromJson(i)).toList());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['numberOfPanels'] = this.numberOfPanels;
    if (this.panelsInfo != null) {
      data['panelsInfo'] = this.panelsInfo.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
