import 'package:clientf/enginf_clientf_service/enginf.comment.model.dart';
import 'package:clientf/enginf_clientf_service/enginf.post.model.dart';
import 'package:clientf/globals.dart';
import 'package:clientf/pages/post_list/widgets/comment_item.dart';
import 'package:flutter/material.dart';

class CommentList extends StatefulWidget {
  CommentList(this.post, {
    Key key,
  }) : super(key: key);

  final EnginePost post;
  @override
  _CommentListState createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  @override
  void initState() {
    var arr = [];
    // print('_CommentListState:initSate():: ${widget.post.comments}');
    for (var c in widget.post.comments) {

        // print('--> runType: ${c.runtimeType}, $c');
      /// 주의! 한번 파싱을 했으면, Type 이 Map<dynamic, dynamic> 에서 EngineComment 로 벼하는데,
      /// 랜더링을 다시 할 때, 또 다시 파싱하는데, 이 때, _TypeError 가 발생한다.
      if (c is EngineComment) {
        arr.add(c);
      } else {
        arr.add(EngineComment.fromEnginData(c));
      }
    }////
    widget.post.comments = arr;

    // print('------> Empty! => widget.post.comments: ${widget.post.comments}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    /// 글 하나에 달려있는 코멘트 목록을 표시한다.
    return Column(
      key: ValueKey('CommentListColumn' + randomString()),
      children: <Widget>[
        if (widget.post.comments != null)
          for (var c in widget.post.comments)
            CommentItem(
              widget.post,
              c,
              key: ValueKey(c.id ?? randomString()),
            ),
      ],
    );
  }
}
