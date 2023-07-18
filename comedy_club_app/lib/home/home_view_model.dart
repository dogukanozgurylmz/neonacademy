import 'package:comedy_club_app/models/activity_model.dart';
import 'package:comedy_club_app/models/ticket_model.dart';

class HomeViewModel {
  List<ActivityModel> activities = [
    ActivityModel(
      name: "Güldür Güldür",
      description: "asdsad asdasd sadas dasd",
      date: DateTime(2023, 7, 25),
      image: "https://cdn.karar.com/news/1578380.jpg",
      tickets: [
        TicketModel(
          title: "VIP",
          price: "500₺",
          ticketNumbers: [
            "V1",
            "V2",
            "V3",
            "V4",
            "V5",
            "V6",
            "V7",
            "V8",
            "V9",
            "V0",
          ],
        ),
        TicketModel(
          title: "Standard",
          price: "200₺",
          ticketNumbers: [
            "S1",
            "S2",
            "S3",
            "S4",
            "S5",
            "S6",
            "S7",
            "S8",
            "S9",
            "S0",
          ],
        ),
      ],
    ),
    ActivityModel(
      name: "ÇGHB",
      description: "dsfnj sdjk sdkjsd dsjknjk",
      date: DateTime(2023, 8, 10),
      image:
          "https://i.hbrcdn.com/haber/2021/02/14/cok-guzel-hareketler-bunlar-canli-izle-kanal-d-13926938_145_amp.jpg",
      tickets: [
        TicketModel(
          title: "Vip",
          price: "600₺",
          ticketNumbers: [
            "V1",
            "V2",
            "V3",
            "V4",
            "V5",
            "V6",
            "V7",
            "V8",
            "V9",
            "V0",
          ],
        ),
        TicketModel(
          title: "Standard",
          price: "300₺",
          ticketNumbers: [
            "S1",
            "S2",
            "S3",
            "S4",
            "S5",
            "S6",
            "S7",
            "S8",
            "S9",
            "S0",
          ],
        ),
      ],
    ),
  ];

  List<String> activityImages = [
    "https://www.gazetekadikoy.com.tr/Uploads/gazetekadikoy.com.tr/202207021113471-img.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a9/Maly_Theatre_foto_2.jpg/640px-Maly_Theatre_foto_2.jpg",
    "https://blog.biletino.com/file/2022/07/stand-up-biletino-blog-24524.jpg",
    "https://trthaberstatic.cdn.wp.trt.com.tr/resimler/1848000/tiyatro-aa-1848773.jpg",
    "https://media-cdn.t24.com.tr/media/library/2020/12/1607718688816-eniz-ozturhan.jpg",
    "https://media-cdn.t24.com.tr/media/library/2020/07/1595338549435-tiyatro-2-bant-kibarlik.jpg",
    "https://i4.hurimg.com/i/hurriyet/75/750x422/5f8a04157af50710d0229bad.jpg",
    "https://www2.denizli.bel.tr/userfiles/image/r221115131756463.jpg",
    "https://cdnuploads.aa.com.tr/uploads/sirkethaberleri/Contents/2022/01/18/thumbs_b_c_28a2b9b9b6fd3d92e9f0615e5a616950.jpg",
    "https://sinemaakademi.com.tr/uploads/2021/07/tiyatro-kursu.jpeg",
    "https://www.datocms-assets.com/64859/1653029862-gecmisten-gunumuze-tiyatro.jpg",
    "https://www.umaylayasam.com/wp-content/uploads/elementor/thumbs/tiyatro-ve-dogaclamanin-duygularini-ifade-etmek-ve-iletisimi-duzeltmek-uzerine-etkisi-p9ftyxmmvz7p36ol28jh3uc85k65m2wkr98aycgewg.jpg",
  ];
}
