import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  static const screenRoute = '/filters';
  final Function saveFilters;
  final Map<String, bool> currentFilters;
  const FiltersScreen(this.saveFilters, this.currentFilters, {super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var summer = false;
  var winter = false;
  var family = false;
  @override
  void initState() {
    summer = widget.currentFilters['summer']!;
    winter = widget.currentFilters['winter']!;
    family = widget.currentFilters['family']!;
    super.initState();
  }

  Widget buildSwitchListTitle(String title, String subtitle, var currentValue,
      void Function(bool)? updateValue) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: currentValue,
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الفلترة'),
        actions: [
          IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                final selectedFiliters = {
                  'summer': summer,
                  'winter': winter,
                  'family': family,
                };
                widget.saveFilters(selectedFiliters);
              })
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 50),
          Expanded(
            child: ListView(
              children: [
                buildSwitchListTitle(
                    'الرحلات الصيفية فقط', 'اظهار الرحلات في فصل الصيف', summer,
                    (newValue) {
                  setState(() {
                    summer = newValue;
                  });
                }),
                buildSwitchListTitle('الرحلات الشتوية فقط',
                    'اظهار الرحلات في فصل الشتاء', winter, (newValue) {
                  setState(() {
                    winter = newValue;
                  });
                }),
                buildSwitchListTitle(
                    'الرحلات للعائلات فقط', 'اظهار الرحلات للعائلات', family,
                    (newValue) {
                  setState(() {
                    family = newValue;
                  });
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
