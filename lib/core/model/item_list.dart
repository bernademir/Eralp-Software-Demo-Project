import 'list_model.dart';

class ItemList {
  List<ListModel> products = [];
  ItemList.fromJsonList(Map value) {
    value.forEach((dataID, value) {
      var product = ListModel.fromJson(value);
      product.dataID = dataID;
      products.add(product);
    });
  }
}
