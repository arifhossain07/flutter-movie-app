import 'package:flutter/material.dart';
import '../model/cast_model.dart';
import '../service/api_service.dart';
import 'cast_list_item.dart';

class CastPage extends StatefulWidget {
  final int id;
  final ProgramType type;
  const CastPage({super.key, required this.id, required this.type});

  @override
  State<CastPage> createState() => _CastPageState();
}

class _CastPageState extends State<CastPage> {
  ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<CastModel> castlist = snapshot.data ?? [];
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return CastListItem(castModel: castlist[index]);
            },
            itemCount: castlist.length,
          );
        }
        return Center(child: CircularProgressIndicator());
      },
      future: apiService.getCastList(widget.id, widget.type),
    );
  }
}
