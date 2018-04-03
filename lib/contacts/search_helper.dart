import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_flutter_chat/contacts/contacts.dart';

typedef String FormFieldFormatter<T>(T v);
typedef bool MaterialSearchFilter<T>(T v, String c);
typedef int MaterialSearchSort<T>(T a, T b, String c);
typedef Future<List<MaterialSearchResult>> MaterialResultsFinder(String c);

class MaterialSearch<T> extends StatefulWidget {
  MaterialSearch({
    Key key,
    this.placeholder,
    this.results,
    this.getResults,
    this.filter,
    this.sort,
    this.limit: 3000,
    this.onSelect,
  })  : assert(() {
          if (results == null && getResults == null ||
              results != null && getResults != null) {
            throw new AssertionError(
                'Either provide a function to get the results, or the results.');
          }

          return true;
        }()),
        super(key: key);

  final String placeholder;

  final List<MaterialSearchResult<T>> results;
  final MaterialResultsFinder getResults;
  final MaterialSearchFilter<T> filter;
  final MaterialSearchSort<T> sort;
  final int limit;
  final ValueChanged<T> onSelect;

  @override
  _MaterialSearchState<T> createState() => new _MaterialSearchState<T>();
}

class _MaterialSearchState<T> extends State<MaterialSearch> {
  bool _loading = false;
  List<MaterialSearchResult<T>> _results = [];

  String _criteria = '';
  TextEditingController _controller = new TextEditingController();

  _filter(String v, String c) {
    return v
        .toString()
        .toLowerCase()
        .trim()
        .contains(new RegExp(r'' + c.toLowerCase().trim() + ''));
  }

  @override
  void initState() {
    super.initState();

    if (widget.getResults != null) {
      _getResultsDebounced();
    }

    _controller.addListener(() {
      setState(() {
        _criteria = _controller.value.text;
        if (widget.getResults != null) {
          _getResultsDebounced();
        }
      });
    });
  }

  Timer _resultsTimer;

  Future _getResultsDebounced() async {
    if (_results.length == 0) {
      setState(() {
        _loading = true;
      });
    }

    if (_resultsTimer != null && _resultsTimer.isActive) {
      _resultsTimer.cancel();
    }

    _resultsTimer = new Timer(new Duration(milliseconds: 400), () async {
      if (!mounted) {
        return;
      }

      setState(() {
        _loading = true;
      });

      //TODO: debounce widget.results too
      var results = await widget.getResults(_criteria);

      if (!mounted) {
        return;
      }

      setState(() {
        _loading = false;
        _results = results;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _resultsTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    var results =
        (widget.results ?? _results).where((MaterialSearchResult result) {
      if (widget.filter != null) {
        return widget.filter(result.value, _criteria);
      }
      //only apply default filter if used the `results` option
      //because getResults may already have applied some filter if `filter` option was omited.
      else if (widget.results != null) {
        return _filter(result.value.name, _criteria);
      }

      return true;
    }).toList();

    if (widget.sort != null) {
      results.sort((a, b) => widget.sort(a.value, b.value, _criteria));
    }

    results = results.take(widget.limit).toList();

    IconThemeData iconTheme =
        Theme.of(context).iconTheme.copyWith(color: Colors.black);

    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white,
        iconTheme: iconTheme,
        title: new TextField(
          controller: _controller,
          autofocus: true,
          decoration:
              new InputDecoration.collapsed(hintText: widget.placeholder),
          style: Theme.of(context).textTheme.title,
        ),
        actions: _criteria.length == 0
            ? []
            : [
                new IconButton(
                    icon: new Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        _controller.text = _criteria = '';
                      });
                    }),
              ],
      ),
      body: _loading
          ? new Center(
              child: new Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: new CircularProgressIndicator()),
            )
          : new SingleChildScrollView(
              child: new Column(
                children: results.map((MaterialSearchResult result) {
                  return new InkWell(
                    onTap: () => widget.onSelect(result.value),
                    child: result,
                  );
                }).toList(),
              ),
            ),
    );
  }
}

class MaterialSearchResult<T> extends StatelessWidget {
  const MaterialSearchResult({
    Key key,
    this.value,
  }) : super(key: key);

  final Contacts value;

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Row(
        children: <Widget>[
          new Container(
              width: 70.0,
              padding: new EdgeInsets.all(15.0),
              child: new CircleAvatar(
                backgroundImage: new NetworkImage(value.avatar),
              )),
          new Expanded(
              child: new Column(
            children: <Widget>[
              new Text(value.name + ", " + value.location,
                  style: Theme.of(context).textTheme.subhead),
              new Text(value.email, style: Theme.of(context).textTheme.body1)
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
          )),
        ],
      ),
      height: 70.0,
    );
  }
}
