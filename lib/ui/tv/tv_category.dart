import 'package:flutter/material.dart';
import 'package:movies_app/model/tv_model.dart';
import '../../service/api_service.dart';
import 'component/tv_list_item.dart';

class TvCategory extends StatefulWidget {
  final TvType tvType;
  final int tvId;
  const TvCategory({super.key, required this.tvType, this.tvId = 0});

  @override
  State<TvCategory> createState() => _TvCategoryState();
}

class _TvCategoryState extends State<TvCategory> {
  ApiService apiService = ApiService();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<TvModel> tvlist = snapshot.data ?? [];
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return TvListItem(tvModel: tvlist[index]);
            },
            itemCount: tvlist.length,
          );
        }
        return Center(child: CircularProgressIndicator());
      },
      future: apiService.getTvData(widget.tvType, tvId: widget.tvId),
    );
  }
}
