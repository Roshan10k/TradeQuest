class DemoStock {
  const DemoStock({
    required this.symbol,
    required this.name,
    required this.exchange,
    required this.price,
    required this.change,
    required this.isUp,
    this.subtitle,
  });

  final String symbol;
  final String name;
  final String exchange;
  final String price;
  final String change;
  final bool isUp;
  final String? subtitle;
}

class DemoNewsItem {
  const DemoNewsItem({
    required this.headline,
    required this.source,
    required this.timeAgo,
  });

  final String headline;
  final String source;
  final String timeAgo;
}

const demoHomeWatchlist = <DemoStock>[
  DemoStock(
    symbol: 'TSLA',
    name: 'Tesla, Inc.',
    exchange: '',
    price: '\$175.40',
    change: '-1.24%',
    isUp: false,
  ),
  DemoStock(
    symbol: 'ENPH',
    name: 'Enphase Energy',
    exchange: '',
    price: '\$122.15',
    change: '+4.12%',
    isUp: true,
  ),
];

const demoTrendingStocks = <DemoStock>[
  DemoStock(
    symbol: 'AAPL',
    name: 'Apple Inc.',
    exchange: 'NASDAQ',
    price: '\$189.43',
    change: '+1.24%',
    isUp: true,
  ),
  DemoStock(
    symbol: 'MSFT',
    name: 'Microsoft Corp.',
    exchange: '',
    price: '\$415.10',
    change: '+0.85%',
    isUp: true,
  ),
  DemoStock(
    symbol: 'TSLA',
    name: 'Tesla, Inc.',
    exchange: '',
    price: '\$175.22',
    change: '-2.41%',
    isUp: false,
  ),
  DemoStock(
    symbol: 'NVDA',
    name: 'NVIDIA Corp.',
    exchange: '',
    price: '\$875.38',
    change: '+5.12%',
    isUp: true,
  ),
];

const demoSearchResults = <DemoStock>[
  DemoStock(
    symbol: 'AAPL',
    name: 'Apple Inc.',
    exchange: 'NASDAQ',
    price: '\$189.43',
    change: '+1.24%',
    isUp: true,
  ),
  DemoStock(
    symbol: 'AMAT',
    name: 'Applied Materials',
    exchange: '',
    price: '\$204.12',
    change: '+0.85%',
    isUp: true,
  ),
  DemoStock(
    symbol: 'APP',
    name: 'AppLovin Corp',
    exchange: '',
    price: '\$68.91',
    change: '-2.14%',
    isUp: false,
  ),
];

const demoRecentNews = <DemoNewsItem>[
  DemoNewsItem(
    headline: 'Apple announces major AI expansion in latest update...',
    source: 'REUTERS',
    timeAgo: '2 HOURS AGO',
  ),
];
