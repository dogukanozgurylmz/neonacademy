import 'package:flutter/material.dart';
import 'package:travel_ease_app/hotel_reservation_view.dart';
import 'package:travel_ease_app/models/hotel_model.dart';
import 'package:travel_ease_app/models/touristic_model.dart';
import 'package:travel_ease_app/planning_view.dart';
import 'package:travel_ease_app/touristic_detail_view.dart';
import 'package:travel_ease_app/touristic_view.dart';

import 'models/holiday_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController cityEditingController = TextEditingController();
  final List<HolidayModel> holidays = [];
  final List<TouristicModel> touristics = [
    TouristicModel(
      name: "Ayder Yaylası",
      address: "Çamlıhemşin/Rize",
      description:
          "Hem Türkiye’nin hem de Rize’nin en önemli turistik yerleri arasında yer alan Ayder Yaylası, mis gibi havası ve doğal güzellikleri ile herkeste büyüleyici bir etki yaratıyor. Türkiye’de gezilecek şehirler listelerinin vazgeçilmezlerinden olan Rize’nin simgesine dönüşen Ayder Yaylası’nda şelalelerin ihtişamı ve görkemli dağların gölgesi görülmeye değer.",
    ),
    TouristicModel(
      name: "Göbeklitepe",
      address: "Haliliye/Şanlıurfa",
      description:
          "Geçmişi Mısır piramitlerinden 7 bin 500 yıl öncesine dayanan Göbeklitepe, yerleşik hayata geçişin ilk izlerinin en somut örneği. Şanlıurfa’nın dünya çapında bilinirliğe sahip olmasına aracılık eden bu eşsiz tarihî yapı bilinen ilk ibadet merkezi olma özelliği taşıyor. Haliyle Türkiye gezilecek yerler dendiğinde Göbeklitepe’nin akıllara gelmesi şaşırtıcı olmuyor.",
    ),
    TouristicModel(
      name: "Kazdağları",
      address: "Balıkesir – Çanakkale",
      description:
          "Balıkesir ve Çanakkale illeri arasında muazzam bir yeşillik, tertemiz hava ve eşsiz bir doğal güzellik sunan Kazdağları, Türkiye’nin en sakin ve en popüler turistik yerleri arasında yer alıyor. Şelaleleri, dereleri, tarihi kalıntıları ile benzersiz bir tatil deneyimi sunan Kazdağları’nın mutlaka gezi rotalarına eklenmesi gerekiyor.",
    ),
    TouristicModel(
      name: "Şirince",
      address: "Selçuk/İzmir",
      description:
          "Türkiye’nin en güzel köyleri sıralamasında yer alan Şirince, İzmir’in Selçuk ilçesine bağlıdır. Daracık sokakları, muhteşem manzarası, kendine özgü mimarisi ve şarap evleri ile herkesi kendine hayran bırakan bu köy Meryem Ana Kilisesi ve Efes Antik Kenti’ne de oldukça yakındır.",
    ),
    TouristicModel(
      name: "Efes Antik Kenti",
      address: "Selçuk/İzmir",
      description:
          "1995 yılında Dünya Mirası olarak tescillenen Efes Antik Kenti, Türkiye turistik yerler dendiğinde akla ilk gelenlerdendir. İzmir’in Selçuk ilçesi sınırlarında bulunan bu muhteşem tarihi yapıyı ziyaret ederek Artemis Tapınağı kalıntılarını, Celsus Kütüphanesi’ni, Yamaç Evleri ve daha nicesini görebilirsiniz. Bölgeye çok yakın olan Yedi Uyurlar’ı gezinize dahil ederek geçmişe yolculuk yapabilirsiniz.",
    ),
  ];
  final List<HotelModel> hotels = [
    HotelModel(
      hotelName: "XXX Hotel",
      address: "Rize",
      phoneNumber: "05535535353",
      isReserved: false,
    ),
    HotelModel(
      hotelName: "YYY Hotel",
      address: "Trabzon",
      phoneNumber: "05615616161",
      isReserved: false,
    ),
  ];
  int order = 0;

  void addHoliday(HolidayModel model) {
    holidays.add(model);
  }

  void showDialogAddHoliday() {
    order++;
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Tatil planına ekle"),
        actions: <Widget>[
          TextField(
            controller: cityEditingController,
            decoration: const InputDecoration(
              label: Text("Şehir"),
            ),
          ),
          TextButton(
            onPressed: () {
              if (cityEditingController.text.isNotEmpty) {
                setState(
                  () {
                    addHoliday(
                      HolidayModel(
                        city: cityEditingController.text.trim(),
                        order: order,
                      ),
                    );
                  },
                );
                cityEditingController.clear();
              }
              Navigator.of(context).pop();
            },
            child: const Text("Ekle"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TravelEase"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialogAddHoliday();
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text("Tatil Planım"),
          ),
          PlanningView(holidays: holidays),
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text("Oteller"),
          ),
          HotelReservationView(hotels: hotels),
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text("Turistik yerler"),
          ),
          TouristicView(touristics: touristics),
        ],
      ),
    );
  }
}
