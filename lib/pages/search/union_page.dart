import 'package:donation_tracker/pages/model/union_model.dart';
import 'package:donation_tracker/pages/search/union_controlller.dart';
import 'package:donation_tracker/pages/search/union_search_list.dart';
import 'package:donation_tracker/utils/hexcolor.dart';
import 'package:donation_tracker/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:get/get.dart';

class UnionPage extends StatefulWidget {
  const UnionPage({super.key});

  @override
  State<UnionPage> createState() => _UnionPageState();
}

class _UnionPageState extends State<UnionPage> {
  final controller = Get.put(UnionController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 147, 192, 244),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Search By Union",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: controller.obx(
        (content) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: DropdownSearch<Union>(
                validator: (value) {
                  if (value == null) {
                    return "Select";
                  }
                  return null;
                },
                items: content!,
                onChanged: (item) {
                  controller.unionId.value = item!.id.toString();
                },
                itemAsString: (item) => item.enName.toString(),
                filterFn: (element, search) {
                  if (search.isEmpty) return true;
                  return element.enName!
                          .toLowerCase()
                          .contains(search.toLowerCase()) ||
                      element.enName!
                          .toLowerCase()
                          .contains(search.toLowerCase());
                },
                popupProps: PopupPropsMultiSelection.modalBottomSheet(
                    showSelectedItems: true,
                    showSearchBox: true,
                    itemBuilder: (context, item, isSelected) => Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          decoration: !isSelected
                              ? null
                              : BoxDecoration(
                                  border: Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                          child: ListTile(
                            selected: isSelected,
                            title: Text(item.enName ?? ''),
                          ),
                        )),
                compareFn: (item, sItem) => item.id == sItem.id,
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                      hintText: "Select",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#C4C4C4")),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#C4C4C4")),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 16)),
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Obx(
              () => Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  txtClr: Colors.white,
                  loading: controller.isLoading.value,
                  onClick: () {
                    controller.FatchuUionContactData();
                    Get.to(UnionContactShowPage());
                  },
                  islog: false,
                  title: 'Search ',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
