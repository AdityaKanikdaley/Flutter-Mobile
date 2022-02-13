import 'package:expansion_tile_radio/data/advance_tiles.dart';
import 'package:expansion_tile_radio/models/advance_tile.dart';
import 'package:expansion_tile_radio/utils.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    home: new AdvancedTilePage(),
  ));
}

class AdvancedTilePage extends StatefulWidget {
  @override
  _AdvancedTilePageState createState() => _AdvancedTilePageState();
}

class _AdvancedTilePageState extends State<AdvancedTilePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text("Hii"),
      centerTitle: true,
    ),
    body: SingleChildScrollView(
      child: ExpansionPanelList.radio(
        expansionCallback: (index, isExpanded) {
          final tile = advancedTiles[index];
          setState(() => tile.isExpanded = isExpanded);

          Utils.showSnackBar(
            context,
            text: isExpanded
                ? 'Shrink ${tile.title}'
                : 'Expand ${tile.title}',
            color: Colors.green,
          );
        },
        children: advancedTiles
            .map((tile) => ExpansionPanelRadio(
          value: tile.title,
          canTapOnHeader: true,
          headerBuilder: (context, isExpanded) => buildTile(tile),
          body: Column(
            children: tile.tiles.map(buildTile).toList(),
          ),
        ))
            .toList(),
      ),
    ),
  );

  Widget buildTile(AdvancedTile tile) => ListTile(
    leading: tile.icon != null ? Icon(tile.icon) : null,
    title: Text(tile.title),
    onTap: tile.tiles.isEmpty
        ? () => Utils.showSnackBar(
      context,
      text: 'Clicked on: ${tile.title}',
      color: Colors.green,
    )
        : null,
  );
}