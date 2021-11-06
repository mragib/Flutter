import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function _saveFilters;
  final Map<String, bool> currentFilter;

  FiltersScreen(this.currentFilter, this._saveFilters);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegen = false;
  bool _vegetarian = false;
  bool _latoFree = false;

  @override
  initState() {
    _glutenFree = widget.currentFilter['gluten'];
    _vegen = widget.currentFilter['vegan'];
    _latoFree = widget.currentFilter['lactog'];
    _vegetarian = widget.currentFilter['vegeterian'];
    super.initState();
  }

  Widget _buildList(
      String title, String subtitle, bool currentValue, Function updateValue) {
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
          title: Text('your Filters'),
          actions: [
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                final selectedFilters = {
                  'gluten': _glutenFree,
                  'lactog': _latoFree,
                  'vegan': _vegen,
                  'vegeterian': _vegetarian,
                };
                widget._saveFilters(selectedFilters);
              },
            )
          ],
        ),
        drawer: MainDrawer(),
        body: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Filter your Food',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    _buildList(
                        'Gluten-Free',
                        'Only Gluten Free Food will be Listed',
                        _glutenFree, (value) {
                      setState(() {
                        _glutenFree = value;
                      });
                    }),
                    _buildList(
                        'Lactog-Free',
                        'Only Lactog Free Food will be Listed',
                        _latoFree, (value) {
                      setState(() {
                        _latoFree = value;
                      });
                    }),
                    _buildList(
                        'Vegen', 'Only Vegen Food will be Listed', _vegen,
                        (value) {
                      setState(() {
                        _vegen = value;
                      });
                    }),
                    _buildList(
                        'Vegetarian',
                        'Only Vegetarian Food will be Listed',
                        _vegetarian, (value) {
                      setState(() {
                        _vegetarian = value;
                      });
                    }),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
