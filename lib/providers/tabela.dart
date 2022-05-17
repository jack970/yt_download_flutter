class Tabela {
  static const tableVideoContents = """  
    CREATE TABLE VideoContents(
      videoId TEXT PRIMARY KEY,
      kind TEXT,
      title TEXT,
      description TEXT,
      channelTitle TEXT,
      url TEXT,
      width INTEGER,
      height INTEGER
    );
  """;
}