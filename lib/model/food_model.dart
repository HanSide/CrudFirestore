class Makanan {
  String? key;
  String nama;
  String harga;

  Makanan({this.key, required this.nama, required this.harga});

  factory Makanan.fromMap(String key, Map<dynamic, dynamic> map) {
    return Makanan(
      key: key,
      nama: map['nama'] ?? '',
      harga: map['harga'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'nama': nama, 'harga': harga};
  }
}
