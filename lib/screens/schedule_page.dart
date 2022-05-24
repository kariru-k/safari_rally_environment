import 'package:flutter/material.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Safari Rally 2022 Schedule'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) => EntryItem(
          data[index]
        ),
        itemCount: data.length,
      ),
    );
  }
}

class Entry {
  late final String title;
  late final List<Entry>
  children;

  Entry(this.title, [this.children = const <Entry>[]]);
}

final List<Entry> data =
<Entry>[
  Entry(
    'Wednesday 22nd June 2022',
    <Entry>[
      Entry(
      '10:01 a.m.: Shakedown => Loldia',
      )
    ]
  ),
  Entry(
    'Thursday 23rd June 2022',
    <Entry>[
      Entry('12:46 p.m.: Ceremonial Start at KICC'),
      Entry('2:08 p.m.: SS1 => Kasarani')
    ]
  ),
  Entry(
    'Friday 24th June 2022',
    <Entry>[
      Entry(
        'Morning Session',
        <Entry>[
          Entry('8:00 a.m.: SS2 => Loldia'),
          Entry('9:18 a.m.: SS3 => Geothermal'),
          Entry('10:11 a.m.: SS4 => Kedong')
        ]
      ),
      Entry(
          'Afternoon Session',
          <Entry>[
            Entry('1:14 p.m.: SS5 => Loldia'),
            Entry('2:32 p.m.: SS6 => Geothermal'),
            Entry('3:25 p.m.: SS7 => Kedong')
          ]
      )
    ],

  ),
  Entry(
    'Saturday 25th June 2022',
    <Entry>[
      Entry(
          'Morning Session',
          <Entry>[
            Entry('8:11 a.m.: SS8 => Soysambu'),
            Entry('9:08 a.m.: SS9 => Elementaita'),
            Entry('10:06 a.m.: SS10 => Sleeping Warrior')
          ]
      ),
      Entry(
          'Afternoon Session',
          <Entry>[
            Entry('2:14 p.m.: SS11 => Soysambu'),
            Entry('3:08 p.m.: SS12 => Elementaita'),
            Entry('4:06 p.m.: SS13 => Sleeping Warrior')
          ]
      )
    ],

  ),
  Entry(
    'Sunday 26th June 2022',
    <Entry>[
      Entry(
          'Morning Session',
          <Entry>[
            Entry('7:05 a.m.: SS14 => Oserian'),
            Entry('8:12 a.m.: SS15 => Narasha'),
            Entry("9:08 a.m.: SS16 => Hell's Gate")
          ]
      ),
      Entry(
          'Afternoon Session',
          <Entry>[
            Entry('11:29 a.m.: SS17 => Oserian'),
            Entry('12:36 p.m.: SS18 => Narasha'),
            Entry("2:18 p.m.: SS19 => Hell's Gate")
          ]
      )
    ],

  )
];

class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);
  final Entry entry;

  Widget _buildSchedule(Entry root){
    if(root.children.isEmpty){
      return ListTile(
        title: Text(root.title),
      );
    }
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title),
      children: root.children.map<Widget>(_buildSchedule).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildSchedule(entry);
  }
}
