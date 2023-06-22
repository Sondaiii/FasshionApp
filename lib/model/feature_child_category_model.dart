

class FeatureChildCategoryModel{
  String? name;
  bool? ischeck;
  FeatureChildCategoryModel({this.name,this.ischeck});

  List<FeatureChildCategoryModel> getDataList(){
    List<FeatureChildCategoryModel> list =[];
    list.add(FeatureChildCategoryModel(name: "Basic",ischeck: false));
    list.add(FeatureChildCategoryModel(name: "Active",ischeck: false));
    list.add(FeatureChildCategoryModel(name: "Luxury",ischeck: false));
    list.add(FeatureChildCategoryModel(name: "Office",ischeck: false));
    list.add(FeatureChildCategoryModel(name: "Summer",ischeck: false));
    list.add(FeatureChildCategoryModel(name: "Sport",ischeck: false));
    list.add(FeatureChildCategoryModel(name: "Winter",ischeck: false));
    list.add(FeatureChildCategoryModel(name: "Teenager",ischeck: false));
    return list;
  }
}