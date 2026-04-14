import 'package:flutter/material.dart';
import '../model/app_model.dart';

class PlacesService {
  static List<PlaceModel> getAllPlaces() {
    return [

      // ─────────────────────────────────────────────────────────────
      // 1. قرية تونس
      // ─────────────────────────────────────────────────────────────
      PlaceModel(
        id: '1',
        name: 'قرية تونس',
        location: 'مركز يوسف الصديق، محافظة الفيوم',
        images: [
          'assets/images/tunis/1.jpg',
          'assets/images/tunis/2.jpg',
          'assets/images/tunis/3.jpg',
          'assets/images/tunis/4.jpg',
          'assets/images/tunis/5.jpg',
          'assets/images/tunis/6.jpg',
          'assets/images/tunis/7.jpg',
          'assets/images/tunis/8.jpg',
          'assets/images/tunis/9.jpg',
          'assets/images/tunis/10.jpg',
        ],
        rating: 4.7,
        price: 'إقامة تبدأ من 700 جنيه',
        description:
        'قرية سياحية ريفية بطابع فني وثقافي مميز على ضفاف بحيرة قارون',
        description2:
        'قرية تونس جوهرة خفية على ضفاف بحيرة قارون، تتميز بهدوئها الريفي الساحر بعيداً عن صخب المدن. '
            'تشتهر بكونها عاصمة الفخار والخزف اليدوي في مصر، حيث يمكنك مشاهدة الحرفيين وهم يشكّلون الطين بأيديهم في ورش عمل مفتوحة. '
            'تمتد على تلة مشرفة على البحيرة مما يمنح زوارها مناظر بانورامية لا تُنسى، خاصة وقت الغروب حين تتحول البحيرة إلى مرآة ذهبية. '
            'تُقام فيها مهرجانات فنية وثقافية سنوية وأسواق حرفية يعرض فيها الفنانون المحليون أعمالهم المميزة. '
            'مثالية للعائلات ومحبي التصوير الفوتوغرافي وعشاق الفن والطبيعة الريفية الهادئة.',
        category: 'قرى سياحية - ثقافية',
        latitude: 29.4667,
        longitude: 30.5833,
        googleMapsUrl: 'https://www.google.com/maps/place/%D9%82%D8%B1%D9%8A%D8%A9+%D8%AA%D9%88%D9%86%D8%B3+%D8%A7%D9%84%D8%B3%D9%8A%D8%A7%D8%AD%D9%8A%D8%A9+%D8%A8%D8%A7%D9%84%D9%81%D9%8A%D9%88%D9%85%E2%80%AD/@29.3997894,30.4877075,17z/data=!3m1!4b1!4m9!3m8!1s0x14595d910358676d:0x4c34fc58a2ec8b5a!5m2!4m1!1i2!8m2!3d29.3997894!4d30.4902824!16s%2Fg%2F11j4dzb3xj!17m2!4m1!1e3!18m1!1e1?entry=ttu&g_ep=EgoyMDI2MDMwOC4wIKXMDSoASAFQAw%3D%3D',
        videos: {'general': ['assets/images/magic/video/1.mp4']},
        nearbyRestaurants: [
          Restaurant(
              name: 'مطعم بلو دونكي',
              distance: 'داخل فندق الزيب إن',
              rating: 4.6,
              phone: '01070781164 – 01010032662 – 01070781165',
              image: 'https://safarin.net/wp-content/uploads/2016/11/16-11-20_09-38-56-850x531.jpg'),
          Restaurant(
            name: 'مطعم إل الغو',
            distance: 'داخل فندق الزيب إن',
            rating: 4.4,
            phone: '01070781164 – 01010032662 – 01070781165',
            image: 'https://cdn.kimkim.com/files/a/images/2a015d2f15c41696054ed3cd6763abd2f979240c/original-24be721976df5f9b44dd64e9927cbf06.jpg',
          ),
          Restaurant(
            name: 'مطعم تونسيا',
            distance: 'داخل القرية',
            rating: 4.5,
            phone: '01092911515',
            image: 'https://cf.bstatic.com/xdata/images/hotel/max500/87120430.jpg?k=50591633154659b4ec252d384d89557893ced50cf4a48ec7f340f084e6606f9c&o=&hp=1',
          ),
          Restaurant(
            name: 'كروان تونس',
            distance: 'داخل القرية',
            rating: 4.5,
            image: 'https://media-cdn.tripadvisor.com/media/photo-s/05/ee/ab/69/symphony-restaurant.jpg',
          ),
          Restaurant(
            name: 'مطعم قرية تونس',
            distance: 'داخل القرية',
            rating: 4.3,
            image: 'https://tse4.mm.bing.net/th/id/OIP.dz42awdalq1f9VJ_twRcXgHaFj?w=1200&h=900&rs=1&pid=ImgDetMain&o=7&rm=3',
          ),
        ],
        nearbyHotels: [
          Hotel(
            name: 'فندق الزيب إن',
            distance: 'داخل القرية',
            rating: 4.4,
            pricePerNight: '800–1500 جنيه',
            phone: '01070781164 – 01010032662 – 01070781165',
            image: 'https://content.tui.co.uk/adamtui/2023_11/27_9/007b2acc-36e4-463f-b3e1-b0c700973fde/ACC_009334_EGY_34_DD05WebOriginalCompressed.jpg?i10c=img.resize(width:658);img.crop(width:658%2Cheight:370)',
            images: [
              'https://media-cdn.tripadvisor.com/media/photo-s/03/b3/0b/fa/yadis-oasis-kebili.jpg',
              'https://tse2.mm.bing.net/th/id/OIP.KCPUFfAQVKvg5BB42lCUbQAAAA?rs=1&pid=ImgDetMain&o=7&rm=3',
              'https://www.boulevardpalacelib.com/uploadImages/DocumentImages/Doc-P-11-637566056031245734.JPG',
            ],
            description:
            'فندق بيئي هادئ داخل قرية تونس بإطلالة على بحيرة قارون، يوفر غرفاً مريحة وأجواء ريفية أصيلة مناسبة للعائلات. يضم حمام سباحة ووجبة إفطار.',
          ),
          Hotel(
            name: 'زاد المسافر',
            distance: 'داخل القرية',
            rating: 4.2,
            pricePerNight: '500–1000 جنيه',
            phone: '01070781164 – 01010032662 – 01070781165',
            image: 'https://tse2.mm.bing.net/th/id/OIP.b_9BttwfVOPknhTuknexwAHaFj?rs=1&pid=ImgDetMain&o=7&rm=3',
            images: [
              'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/27/e8/92/98/villa-zad-elmosafer.jpg?w=900&h=500&s=1',
              'https://tse4.mm.bing.net/th/id/OIP.j2qv9WGbwNDy7sGXDXcslwHaFj?rs=1&pid=ImgDetMain&o=7&rm=3',
              'https://tse4.mm.bing.net/th/id/OIP.EAsUEQM62dOjWtICk7NC5QHaEO?w=870&h=496&rs=1&pid=ImgDetMain&o=7&rm=3',
              'https://tse2.mm.bing.net/th/id/OIP.AwNVytpppRnebq5QBXK80QHaE8?rs=1&pid=ImgDetMain&o=7&rm=3',
            ],
            description:
            'منزل ضيافة بأسلوب ريفي تقليدي وسط القرية، يقدم خدمة دافئة وأجواء أسرية مميزة.',
          ),
          Hotel(
            name: 'شاليه لاليجار اليومي (غرفتان + حمام سباحة خاص)',
            distance: 'داخل القرية',
            rating: 4.3,
            pricePerNight: 'يومي',
            phone: '01113681037',
            image: 'https://tse2.mm.bing.net/th/id/OIP.wkG2C8jA-_57brD0MCvjPwHaFj?rs=1&pid=ImgDetMain&o=7&rm=',
            images: [
              'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/2b/6b/da/2a/caption.jpg?w=700&h=-1&s=1',
            ],
            description:
            'شاليه يومي بغرفتي نوم وحمام سباحة خاص ومطبخ وحديقة ومكان للشواء.',
          ),
        ],
        activities: [
          Activity(
            name: 'صناعة الفخار والخزف',
            icon: '🏺',
            description: 'ورش عمل تفاعلية ومتحف الكاريكاتير',
            image: 'https://amwalna.net/wp-content/uploads/2024/04/%D8%B5%D9%86%D8%A7%D8%B9%D8%A9-%D8%A7%D9%84%D9%81%D8%AE%D8%A7%D8%B15.jpg',
          ),
          Activity(
            name: 'ركوب الخيل',
            icon: '🐎',
            description: 'جولات في الطبيعة المطلة على بحيرة قارون',
            image: 'https://tse3.mm.bing.net/th/id/OIP.8sbfZ6kHdiT5y5-2d_G4AgHaEK?rs=1&pid=ImgDetMain&o=7&rm=3',
          ),
          Activity(
            name: 'التنزه والمشي',
            icon: '🚶',
            description: 'مسارات طبيعية خضراء على ضفاف البحيرة',
            image: 'https://www.lifelinesmobile.org/uploads/l_familywoods.jpg',
          ),
          Activity(
            name: 'مقاهي ريفية بإطلالة',
            icon: '☕',
            description: 'جلسات هادئة مع إطلالة على البحيرة',
            image: 'https://tse4.mm.bing.net/th/id/OIP.cqU7wuHuEm5-if9JzF2vAwHaFA?rs=1&pid=ImgDetMain&o=7&rm=3',
          ),
          Activity(
            name: 'أسواق الحرف اليدوية',
            icon: '🛍️',
            description: 'تذكارات فخارية يدوية صنعتها أيدي أهل القرية',
            image: 'https://tse1.mm.bing.net/th/id/OIP.09Q1MG6z_k6Z5Fr62bp5HgHaE8?rs=1&pid=ImgDetMain&o=7&rm=3',
          ),
          Activity(
            name: 'مخيّم ماجيك ليك',
            icon: '🏕️',
            description:
            'مغامرات السفاري وركوب الرمال وجولات بالقارب – هاتف: 01026122999 / 01025220255',
            image: 'https://tse2.mm.bing.net/th/id/OIP.MXGT0WAaygn4wHonJ9xwRgHaEK?rs=1&pid=ImgDetMain&o=7&rm=3',
          ),
        ],
        services: [
          ServiceItem(
              icon: Icons.local_parking,
              name: 'مواقف سيارات مجانية',
              color: const Color(0xFF6B8E23)),
          ServiceItem(
              icon: Icons.wc,
              name: 'دورات مياه نظيفة',
              color: const Color(0xFFD2B48C)),
          ServiceItem(
              icon: Icons.restaurant_menu,
              name: 'مطاعم وكافيهات متنوعة',
              color: const Color(0xFF4682B4)),
          ServiceItem(
              icon: Icons.store,
              name: 'ورش فخار ومحلات تذكارات',
              color: const Color(0xFF8B4513)),
          ServiceItem(
              icon: Icons.local_hospital,
              name: 'خدمات صحية قريبة',
              color: Colors.redAccent),
          ServiceItem(
              icon: Icons.water,
              name: 'ريف تونس – استراحة ريفية',
              color: const Color(0xFF2E8B57)),
          ServiceItem(
              icon: Icons.waves,
              name: 'تونس فيو – شاطئ وخيام وكافيهات',
              color: const Color(0xFF1E90FF)),
        ],
        contacts: [
          Contact(type: 'هاتف رئيسي', value: '01001985481', icon: Icons.phone),
          Contact(
              type: 'هاتف إضافي',
              value: '01070781164 – 01010032662',
              icon: Icons.phone),
          Contact(
              type: 'البريد الإلكتروني',
              value: 'tunis.village.fayuom@gmail.com',
              icon: Icons.email),
          Contact(
              type: 'ريف تونس (استراحة)',
              value: '01004796167',
              icon: Icons.phone),
          Contact(
              type: 'تونس فيو (شاطئ وخيام)',
              value: '01018152018',
              icon: Icons.phone),
          Contact(
              type: 'الحريف للرحلات',
              value: '01026704717',
              icon: Icons.phone),
        ],
      ),

      // ─────────────────────────────────────────────────────────────
      // 2. البحيرة المسحورة
      // ─────────────────────────────────────────────────────────────
      PlaceModel(
        id: '2',
        name: 'البحيرة المسحورة',
        location: 'محمية وادي الريان، جنوب غرب الفيوم',
        images: [
          'assets/images/magic/mean.jpg',
          'assets/images/magic/3.jpg',
          'assets/images/magic/4.jpg',
          'assets/images/magic/5.jpg',
          'assets/images/magic/6.jpg',
          'assets/images/magic/7.jpg',
          'assets/images/magic/8.jpg',
          'assets/images/magic/9.jpg',
        ],
        rating: 4.8,
        price: 'رسوم دخول محمية بسيطة',
        description:
        'بحيرة ساحرة تتغير ألوانها مع حركة الشمس – وجهة طبيعية فريدة من نوعها',
        description2:
        'البحيرة المسحورة ظاهرة طبيعية نادرة تأخذ الأنفاس، تتغير ألوان مياهها على مدار اليوم بين الأخضر الزمردي والأزرق السماوي والفيروزي الساحر، تبعاً لزاوية الشمس وعمق المياه. '
            'تحتضنها الكثبان الرملية الذهبية والصخور البيضاء في قلب الصحراء، مما يخلق تناقضاً بصرياً مذهلاً يجعلها وجهة أحلام المصورين. '
            'تقع داخل محمية وادي الريان على بعد 70 كم من مدينة الفيوم، وتحيط بها بيئة صحراوية خلابة تضم كثباناً رملية مثالية للتزلج والسفاري. '
            'أفضل أوقات الزيارة هي الصباح الباكر حين تتلألأ المياه بلون فيروزي نقي، أو قبيل الغروب حين تكتسي البحيرة بدرجات البرتقالي والذهبي. '
            'تُعد تجربة التخييم الليلي بجوارها من أكثر التجارب الحياتية تأثيراً، حيث يمكنك مشاهدة مجرة درب التبانة في سماء خالية تماماً من تلوث الضوء.',
        category: 'محميات طبيعية - بحيرات صحراوية',
        latitude: 29.1908915,
        longitude: 30.4011911,
        googleMapsUrl: 'https://www.google.com/maps/place/Wadi+Al+Raian,+Qesm+Al+Fayoum,+Second+Al+Faiyum,+Faiyum+Governorate/@29.3024755,30.8512262,17z/data=!3m1!4b1!4m6!3m5!1s0x145978d69c48cd59:0xa9992f48be8c101a!8m2!3d29.3024755!4d30.8538011!16s%2Fg%2F1tg4hpcj?entry=ttu&g_ep=EgoyMDI2MDMxNS4wIKXMDSoASAFQAw%3D%3D',
        videos: {
          'general': [
            'assets/images/magic/video/1.mp4',
            'assets/images/magic/video/2.mp4',
          ]
        },
        nearbyRestaurants: [
          Restaurant(
            name: 'كافيتريا المحمية (1)',
            distance: 'عند منطقة الشلالات / البحيرات السفلية',
            rating: 4.0,
            image: 'https://tse2.mm.bing.net/th/id/OIP.OF6q-O67EqSd2hwLZ87mjgHaFj?rs=1&pid=ImgDetMain&o=7&rm=3',
          ),
          Restaurant(
            name: 'كافيتريا المحمية (2)',
            distance: 'داخل المنطقة السياحية',
            rating: 4.0,
            image: 'https://tse1.mm.bing.net/th/id/OIP.ADNhPGv-KE1C_Jbple6_2gHaEK?w=2016&h=1134&rs=1&pid=ImgDetMain&o=7&rm=3',
          ),
          Restaurant(
            name: 'كافيتريا المحمية (3)',
            distance: 'داخل المنطقة السياحية',
            rating: 4.0,
            image: 'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/09/47/2c/1a/the-chocolate-bar.jpg?w=600&h=400&s=1',
          ),
        ],
        nearbyHotels: [
          Hotel(
            name: 'ريان الرمال – جلامبينج',
            distance: 'داخل المحمية',
            rating: 4.6,
            pricePerNight: '1500–3000 جنيه',
            phone: '01010915469',
            image: 'https://www.urtrips.com/wp-content/uploads/2018/08/Fayoum-hotels2.jpg',
            images: [
              'https://i.pinimg.com/736x/da/f5/09/daf509c9485e778c3896b69f566ddfca.jpg',
              'https://th.bing.com/th/id/R.d5efcdd3282eddde03c959547e6c82b5?rik=MIhh0Fm5g5p7Nw&pid=ImgRaw&r=0',
            ],
            description:
            'تجربة تخييم فاخرة (جلامبينج) وسط الصحراء بإطلالة على البحيرة المسحورة، مع كافة وسائل الراحة.',
          ),
        ],
        activities: [
          Activity(
            name: 'التخييم تحت النجوم',
            icon: '⛺',
            description: 'تخييم فاخر أو عادي وسط الطبيعة الصحراوية',
            image: 'https://tse2.mm.bing.net/th/id/OIP.X3BXXtD_J9sEN1jJmNCdbAHaE8?rs=1&pid=ImgDetMain&o=7&rm=3',
          ),
          Activity(
            name: 'التزلج على الرمال',
            icon: '🏂',
            description: 'منحدرات رملية ممتعة للمغامرين',
            image: 'https://watanimg.elwatannews.com/image_archive/840x473/17757496711701161840.jpg',
          ),
          Activity(
            name: 'رحلات السفاري',
            icon: '🏜️',
            description: 'جولات صحراوية بسيارات 4x4',
            image: 'https://th.bing.com/th/id/OIP.otLO1JEBVj2Z42JsxmMZGQHaDF?o=7rm=3&rs=1&pid=ImgDetMain&o=7&rm=3',
          ),
          Activity(
            name: 'السباحة في البحيرة',
            icon: '🏊',
            description: 'مياه عذبة صافية',
            image: 'hthttps://d3rr2gvhjw0wwy.cloudfront.net/uploads/activity_teasers/311623/600x400-1-50-c8e3d22270668f903ec930726ca0ff9b.jpg',
          ),
          Activity(
            name: 'تصوير تغير ألوان البحيرة',
            icon: '🌅',
            description: 'ألوان ساحرة وقت الشروق والغروب',
            image: 'https://cdn.getyourguide.com/img/tour/64aeff3d155d6.png/97.jpg',
          ),
          Activity(
            name: 'ركوب القوارب والكاياك',
            icon: '🚣',
            description: 'جولات قصيرة بالقوارب داخل بحيرات الريان',
            image: 'https://pix10.agoda.net/geo/city/78541/1_78541_04.jpg?ca=7&ce=1&s=1920x822',
          ),
          Activity(
            name: 'مشاهدة الشلالات',
            icon: '💦',
            description:
            'الشلالات الطبيعية بين البحيرتين – ضمن مسار الزيارة الرسمي',
            image: 'https://tse4.mm.bing.net/th/id/OIP.6Ox_EqteWnWfTY0mbVRO9AHaFj?rs=1&pid=ImgDetMain&o=7&rm=3',
          ),
          Activity(
            name: 'العيون الكبريتية',
            icon: '♨️',
            description: '3–4 ينابيع حرارية كبريتية جنوب البحيرة السفلى',
            image: 'https://1.bp.blogspot.com/-v8Z1dRkIU7M/XyCAuiFV1cI/AAAAAAAAA-k/o21Pa2W4NYod5LKwEG967eHk-WaAlAWGQCLcBGAsYHQ/s1080/Screenshot_20200728_214444.jpg',
          ),
          Activity(
            name: 'جبل المدورة (نقطة مشاهدة)',
            icon: '🏔️',
            description: 'نقطة تصويرية شهيرة على حافة البحيرة السفلية',
            image: 'https://tse3.mm.bing.net/th/id/OIP.Y4Hp9yyAc1O7kgdi1H33sgHaEI?rs=1&pid=ImgDetMain&o=7&rm=3',
          ),
        ],
        services: [
          ServiceItem(
              icon: Icons.info,
              name: 'مركز الزوار',
              color: const Color(0xFF4682B4)),
          ServiceItem(
              icon: Icons.local_parking,
              name: 'مواقف سيارات',
              color: const Color(0xFF6B8E23)),
          ServiceItem(
              icon: Icons.wc,
              name: 'دورات مياه',
              color: const Color(0xFFD2B48C)),
          ServiceItem(
              icon: Icons.security,
              name: 'نقطة أمن',
              color: const Color(0xFF2F4F4F)),
          ServiceItem(
              icon: Icons.mosque,
              name: 'مسجد داخل المنطقة السياحية',
              color: const Color(0xFF008080)),
        ],
        contacts: [
          Contact(
              type: 'هاتف المحمية', value: '0842830535', icon: Icons.phone),
          Contact(
              type: 'موبايل المحمية', value: '01028502461', icon: Icons.phone),
          Contact(
              type: 'حجز جلامبينج', value: '01010915469', icon: Icons.phone),
          Contact(
              type: 'Egypt Online Tour',
              value: '+20127450364',
              icon: Icons.phone),
          Contact(
              type: 'Vibes Travel', value: '+20127111915', icon: Icons.phone),
        ],
      ),

      // ─────────────────────────────────────────────────────────────
      // 3. وادي الحيتان
      // ─────────────────────────────────────────────────────────────
      PlaceModel(
        id: '3',
        name: 'وادي الحيتان',
        location: 'محمية وادي الريان، الفيوم – 150 كم من القاهرة',
        images: [
          'assets/images/hatan/mean.jpg',
          'assets/images/hatan/1.jpg',
          'assets/images/hatan/2.jpg',
          'assets/images/hatan/3.jpg',
          'assets/images/hatan/4.jpg',
          'assets/images/hatan/5.jpg',
          'assets/images/hatan/6.jpg',
          'assets/images/hatan/7.jpg',
          'assets/images/hatan/8.jpg',
          'assets/images/hatan/9.jpg',
          'assets/images/hatan/10.jpg',
          'assets/images/hatan/11.jpg',
          'assets/images/hatan/12.jpg',
          'assets/images/hatan/13.jpg',
          'assets/images/hatan/14.jpg',
          'assets/images/hatan/15.jpg',
          'assets/images/hatan/16.jpg',
          'assets/images/hatan/17.jpg',
          'assets/images/hatan/18.jpg',
        ],
        rating: 4.9,
        price: '35 جنيه للمصريين – 15 دولار للأجانب',
        description:
        'أول موقع تراث طبيعي عالمي في مصر – متحف مفتوح يحكي تطور الحياة منذ 40 مليون سنة',
        description2:
        'وادي الحيتان كتاب مفتوح كتبته الطبيعة على مدى 40 مليون سنة، يحتضن أكثر من 400 حفرية كاملة لهياكل عظمية لحيتان بدائية نادرة تمشي على الأرض قبل أن تعود إلى البحر، وهي شاهد فريد على أحد أعظم التحولات في تاريخ الحياة على الأرض. '
            'صنّفته منظمة اليونسكو عام 2005 ليكون أول موقع تراث طبيعي عالمي في مصر، وذلك لقيمته العلمية الاستثنائية التي لا مثيل لها في العالم. '
            'يمتد الوادي وسط صحراء هادئة تزيد روعتها في الفجر والغروب، حين تتحول الرمال إلى ألوان دهبية وبرتقالية تضيء الهياكل العظمية القديمة بضوء سحري. '
            'تسكنه حيوانات برية مهددة بالانقراض كثعلب الفنك والغزال المصري الأبيض وصقر شاهين، مما يجعله وجهة مثالية لعشاق الطبيعة والتصوير البري. '
            'تحذير مهم: يحتاج زيارته سيارة دفع رباعي ومؤونة كافية من الماء، ولا تتوفر شبكة محمول داخله، لذا يُنصح بالتخطيط المسبق الجيد.',
        category: 'تراث عالمي – محميات طبيعية',
        latitude: 29.2667,
        longitude: 30.0333,
        googleMapsUrl: 'https://maps.app.goo.gl/y6pZ52w2KFyBeQno6',
        videos: {
          'general': [
            'assets/images/haten/vedio/1.mp4',
            'assets/images/haten/vedio/2.mp4',
            'assets/images/haten/vedio/3.mp4',
            'assets/images/haten/vedio/4.mp4',
          ]
        },
        nearbyRestaurants: [
          Restaurant(
            name: 'كافيتريا وادي الحيتان',
            distance: 'عند مدخل المحمية',
            rating: 3.8,
            image: 'https://th.bing.com/th/id/OIP.ATDhO7JKXSltMs_5jaaTawHaFj?o=7rm=3&rs=1&pid=ImgDetMain&o=7&rm=3',
          ),
        ],
        nearbyHotels: [
          Hotel(
            name: 'مخيم وادي الحيتان (تخييم صحراوي)',
            distance: 'داخل المحمية',
            rating: 4.3,
            pricePerNight: 'تبدأ من 50 جنيه للمصريين',
            phone: '0842830535',
            image: 'https://tse2.mm.bing.net/th/id/OIP.6w9-owo_a0nMRzEPAm2gzwHaEK?rs=1&pid=ImgDetMain&o=7&rm=3',
            images: [
              'https://tse2.mm.bing.net/th/id/OIP.Ymi7kVBXh2_9ecO762qm7QHaDw?rs=1&pid=ImgDetMain&o=7&rm=3',
              'https://tse2.mm.bing.net/th/id/OIP.jBgAbawdq80EMmagJfZfngHaE8?w=3402&h=2268&rs=1&pid=ImgDetMain&o=7&rm=',
            ],
            description:
            'تجربة تخييم صحراوية أصيلة داخل محمية وادي الحيتان مع خدمات أساسية وليالٍ ساحرة لمراقبة النجوم.',
          ),
        ],
        activities: [
          Activity(
            name: 'متحف الحفريات وتغير المناخ',
            icon: '🦕',
            description: 'أكثر من 400 حفرية في المتحف المفتوح',
            image: 'https://img.youm7.com/ArticleImgs/2020/9/22/57884-%D9%85%D8%AA%D8%AD%D9%81-%D8%A7%D9%84%D8%AD%D9%81%D8%B1%D9%8A%D8%A7%D8%AA-%D9%88%D8%AA%D8%BA%D9%8A%D8%B1-%D8%A7%D9%84%D9%85%D9%86%D8%A7%D8%AE.jpg',
          ),
          Activity(
            name: 'مراقبة النجوم والمجرات',
            icon: '🔭',
            description: 'سماء صافية بعيدة عن تلوث الضوء',
            image: 'https://images.unsplash.com/photo-1446776877081-d282a0f896e2?w=500&q=80',
          ),
          Activity(
            name: 'التخييم الصحراوي',
            icon: '⛺',
            description: 'قضاء الليل وسط الصحراء مع جلسات شواء',
            image: 'https://tse3.mm.bing.net/th/id/OIP.VSR3vEIyNLZyg2LoUbl9nQHaD4?rs=1&pid=ImgDetMain&o=7&rm=3',
          ),
          Activity(
            name: 'مشاهدة الحيوانات البرية',
            icon: '🦊',
            description: 'ثعلب الفنك والغزال الأبيض وصقر شاهين',
            image: 'https://tse3.mm.bing.net/th/id/OIP.Go3FuX-soQTO9WGKm5omlAHaE8?rs=1&pid=ImgDetMain&o=7&rm=3',
          ),
          Activity(
            name: 'رحلات سفاري 4x4',
            icon: '🏜️',
            description: 'استكشاف الوادي بسيارات دفع رباعي',
            image: 'https://tse1.mm.bing.net/th/id/OIP.BGrF2xpYYheNLD7GaTAjwgHaE8?rs=1&pid=ImgDetMain&o=7&rm=3',
          ),
        ],
        services: [
          ServiceItem(
              icon: Icons.museum,
              name: 'متحف مفتوح وقاعة عرض',
              color: const Color(0xFF8B4513)),
          ServiceItem(
              icon: Icons.info,
              name: 'مركز الزوار ومرشد سياحي',
              color: const Color(0xFF4682B4)),
          ServiceItem(
              icon: Icons.local_parking,
              name: 'مواقف سيارات',
              color: const Color(0xFF6B8E23)),
          ServiceItem(
              icon: Icons.security,
              name: 'نقطة أمن',
              color: const Color(0xFF2F4F4F)),
          ServiceItem(
              icon: Icons.warning_amber,
              name: 'لا يوجد شبكة محمول داخل الوادي',
              color: Colors.orange),
        ],
        contacts: [
          Contact(
              type: 'هاتف المحمية', value: '084-2830535', icon: Icons.phone),
          Contact(
              type: 'هاتف إضافي', value: '01028502461', icon: Icons.phone),
          Contact(
              type: 'موقع اليونسكو',
              value: 'whc.unesco.org/en/list/1186',
              icon: Icons.language),
        ],
      ),

      // ─────────────────────────────────────────────────────────────
      // 4. المسجد المعلق
      // ─────────────────────────────────────────────────────────────
      PlaceModel(
        id: '4',
        name: 'المسجد المعلق',
        location: 'شارع بورسعيد، بندر مدينة الفيوم',
        images: [
          'assets/images/moalq/1.jpg',
          'assets/images/moalq/2.jpg',
          'assets/images/moalq/3.jpeg',
        ],
        rating: 4.6,
        price: 'مجاني',
        description:
        'تحفة معمارية عثمانية عمرها يتخطى 460 عاماً – بُني فوق ربوة على ضفاف بحر يوسف',
        description2:
        'المسجد المعلق درة العمارة الإسلامية في الفيوم، شُيِّد عام 1560م بأمر الأمير سليمان بن حاتم في العهد العثماني، وسُمِّي بالمعلق لارتفاعه الشامخ فوق ربوة مطلة على بحر يوسف، ويُصعد إليه بدرج مستدير أسطوري يضفي عليه طابعاً معمارياً فريداً. '
            'يبهر الزائر بزخارفه الكتابية المنقوشة على السقف والجدران بدقة متناهية، وبأعمدته البازلتية الأسطوانية ذات التيجان الكورنثية التي تشهد على براعة فنانيه. '
            'تخطيطه الداخلي على شكل مدرسة ذات أربعة إيوانات يُذكِّر بكبرى المدارس الأيوبية والمملوكية، وهو وصف يُقل للغاية في عمارة العصر العثماني بمصر. '
            'رُمِّم المسجد عام 2012 وأعيد له بهاؤه، وبات اليوم معلماً حضارياً يزوره المؤرخون والمعماريون والسياح من شتى أنحاء العالم. '
            'يُعرف بين أبناء الفيوم بأنه مكان يمنح زائره سكينة روحية عميقة، حيث تتناغم همسات الماء من بحر يوسف مع هدوء الجو الإسلامي الأصيل.',
        category: 'آثار إسلامية – مساجد تاريخية',
        latitude: 29.3084,
        longitude: 30.8428,
        googleMapsUrl: 'https://maps.app.goo.gl/P1qj1o9Hqqj3yeVA9',
        videos: {'general': []},
        nearbyRestaurants: [
          Restaurant(
            name: 'مطاعم الميدان المركزي',
            distance: '5 دقائق سيراً',
            rating: 4.0,
            image: 'https://tse2.mm.bing.net/th/id/OIP.d9qRHvbL1vO0KE_Vr8siuwHaHa?rs=1&pid=ImgDetMain&o=7&rm=3',
          ),
          Restaurant(
            name: 'مطعم ليالي العرب',
            distance: '10 دقائق',
            rating: 4.3,
            image: 'https://tse1.mm.bing.net/th/id/OIP.uK5JKF93ovpSWDfxIabhHAHaHa?w=700&h=700&rs=1&pid=ImgDetMain&o=7&rm=3',
          ),
        ],
        nearbyHotels: [
          Hotel(
            name: 'فندق تاش بوتيك الفيوم',
            distance: 'مركز المدينة',
            rating: 4.3,
            pricePerNight: '1200–2500 جنيه',
            image: 'https://www.arabtravelers.com/wp-content/uploads/2022/08/Fayoum-hotels5.jpg',
            images: [
              'https://tse3.mm.bing.net/th/id/OIP.UyRoavLN0iP9M90XLNxXMwHaE8?rs=1&pid=ImgDetMain&o=7&rm=3',
              'https://th.bing.com/th/id/R.71e55f1762243a5724f727e0f8498762?rik=wNvCEf21H%2b7bhA&riu=http%3a%2f%2fwww.visitfayoum.net%2fHotelImg%2f85_n.jpg&ehk=f15dMzn5S%2bm2UDV1NK3i3ik0AumzMWrKzogn8LlTrLQ%3d&risl=&pid=ImgRaw&r=0',
            ],
            description:
            'فندق بوتيك في مركز الفيوم على بعد 87 كم من مطار سفنكس، مناسب للعائلات.',
          ),
        ],
        activities: [
          Activity(
            name: 'التصوير المعماري',
            icon: '📸',
            description: 'زخارف وعمارة إسلامية نادرة',
            image: 'https://res.cloudinary.com/dw4e01qx8/f_auto,q_auto/images/tzkyseie8dp0dln7tojp',
          ),
          Activity(
            name: 'التأمل والصلاة',
            icon: '🕌',
            description: 'مسجد أثري يمنح السكينة والراحة النفسية',
            image: 'https://i.redd.it/40md6egn3ed91.png',
          ),
          Activity(
            name: 'جولة في حي المبيضة',
            icon: '🚶',
            description: 'استكشاف الحي الشعبي القديم المحيط بالمسجد',
            image: 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=500&q=80',
          ),
          Activity(
            name: 'زيارة سواقي الفيوم',
            icon: '💧',
            description: 'على بُعد دقائق من المسجد',
            image: 'https://tse2.mm.bing.net/th/id/OIP.oNxegwCCeQkb4oKuQrQhHQHaE8?rs=1&pid=ImgDetMain&o=7&rm=3',
          ),
        ],
        services: [
          ServiceItem(
              icon: Icons.accessible,
              name: 'زيارة مجانية للجميع',
              color: Colors.green),
          ServiceItem(
              icon: Icons.local_parking,
              name: 'مواقف قريبة',
              color: const Color(0xFF6B8E23)),
          ServiceItem(
              icon: Icons.restaurant_menu,
              name: 'مطاعم قريبة',
              color: const Color(0xFF4682B4)),
          ServiceItem(
              icon: Icons.tour, name: 'مرشد سياحي متاح', color: Colors.amber),
        ],
        contacts: [
          Contact(
              type: 'وزارة الآثار الإسلامية',
              value: '084-2321414',
              icon: Icons.phone),
          Contact(
              type: 'السياحة والآثار الفيوم',
              value: '084-6360050',
              icon: Icons.phone),
        ],
      ),

      // ─────────────────────────────────────────────────────────────
      // 5. سواقي الفيوم
      // ─────────────────────────────────────────────────────────────
      PlaceModel(
        id: '5',
        name: 'سواقي الفيوم',
        location: 'شارع الجمهورية، ضفاف بحر يوسف، مدينة الفيوم',
        images: [
          'assets/images/sawqi/1.jpg',
          'assets/images/sawqi/2.jpg',
          'assets/images/sawqi/3.jpg',
          'assets/images/sawqi/4.jpg',
          'assets/images/sawqi/5.jpg',
          'assets/images/sawqi/6.jpg',
          'assets/images/sawqi/7.jpg',
          'assets/images/sawqi/8.jpg',
        ],
        rating: 4.4,
        price: 'دخول مجاني – رسوم رمزية 5 جنيه',
        description:
        'شعار الفيوم الأثري – نحو 200 ساقية مائية خشبية دوارة على ضفاف بحر يوسف',
        description2:
        'سواقي الفيوم هي روح المحافظة ورمزها الخالد، وهي عجلات خشبية دوارة بُنيت منذ آلاف السنين لرفع مياه النيل عبر بحر يوسف إلى الأراضي الزراعية المرتفعة، وما زالت تدور حتى اليوم بنفس المبدأ الهندسي العبقري القديم. '
            'تضم الفيوم نحو 200 ساقية منتشرة على طول القناة، وتُشكِّل مع أصوات خرير المياه وخضرة الضفاف لوحةً بصرية وسمعية ريفية ساحرة لا تجدها في مكان آخر. '
            'تقع أشهرها على شارع الجمهورية في قلب المدينة، بجوار المسجد المعلق مباشرةً، مما يجعل زيارة المعلمين معاً في جولة واحدة أمراً ممتعاً وسهلاً. '
            'تُعد نقطة انطلاق مثالية لاستكشاف الموروث العمراني والتاريخي لمدينة الفيوم العريقة، وتستقطب المصورين وعشاق التراث طوال العام. '
            'جماليتها لا تقتصر على المنظر، بل تمتد إلى الأثر النفسي العميق الذي يتركه صوت الماء المتدفق في نفس الزائر.',
        category: 'تراث أثري – معالم تاريخية',
        latitude: 29.3082,
        longitude: 30.8434,
        googleMapsUrl: 'https://www.google.com/maps/place/Water-wheels+of+Faiyum/@29.3085509,30.8416916,17z/data=!3m1!4b1!4m6!3m5!1s0x14597928c70b7b25:0x7d91ef7da4cdfbbc!8m2!3d29.3085509!4d30.8442665!16s%2Fg%2F11c74gw70v?entry=ttu&g_ep=EgoyMDI2MDMwOC4wIKXMDSoASAFQAw%3D%3D',
        videos: {'general': ['assets/images/sawqi/vedio/1.mp4']},
        nearbyRestaurants: [
          Restaurant(
            name: 'كشري السواقي',
            distance: 'ميدان السواقي',
            rating: 4.4,
            phone: '01025555462 – 0842147772',
            image: 'https://th.bing.com/th/id/R.ced9dce50f88d0bd964279bc7478fa4e?rik=4ssZTvvS3g0edA&pid=ImgRaw&r=0',
          ),
          Restaurant(
            name: 'مطعم وكافيه فندق قارون',
            distance: 'إطلالة مباشرة على السواقي',
            rating: 4.3,
            phone: '0842163155 – 01017366662',
            image: 'https://tse4.mm.bing.net/th/id/OIP.3lPN4PdfvP50CFwPWFe1IgHaDQ?rs=1&pid=ImgDetMain&o=7&rm=3',
          ),
          Restaurant(
            name: 'بروست وكبابجي الطيب',
            distance: 'منطقة دلة',
            rating: 4.5,
            phone: '01022204902 – 01022204901',
            image: 'https://tse3.mm.bing.net/th/id/OIP.MPvjyIQoDn9owAocfS2dDQHaEc?rs=1&pid=ImgDetMain&o=7&rm=3',
          ),
          Restaurant(
            name: 'مطعم أوزي (Oozy) – مشويات ومندي',
            distance: 'شارع المأمون',
            rating: 4.4,
            phone: '01016624444 – 01090151111',
            image: 'https://tse3.mm.bing.net/th/id/OIP.MVy5ZAqw202mBXCy7ICjvQHaGi?rs=1&pid=ImgDetMain&o=7&rm=3',
          ),
          Restaurant(
            name: 'أسماك شكشوك',
            distance: 'فرع السواقي',
            rating: 4.3,
            phone: '01000788344 – 01022223781',
            image: 'https://tse1.mm.bing.net/th/id/OIP.Vqs4Z2InZDd8DCLfljAweAHaDM?rs=1&pid=ImgDetMain&o=7&rm=3',
          ),
          Restaurant(
            name: 'بيانكي (Pianky) – بيتزا وباستا',
            distance: 'منطقة المسلة',
            rating: 4.3,
            phone: '01013444494 – 01013444464',
            image: 'https://tse2.mm.bing.net/th/id/OIP.2MHzCZywZjjWEbcPh_zbTQHaJ5?rs=1&pid=ImgDetMain&o=7&rm=3',
          ),
          Restaurant(
            name: 'قشطوطة',
            distance: 'بجوار مطعم حجاج',
            rating: 4.4,
            phone: '15594',
            image: 'https://www.light-dark.net/wp-content/uploads/2023/07/2ashtotaa.jpg',
          ),
          Restaurant(
            name: 'كازوزا ميكس – شاورما وحواوشي',
            distance: 'ميدان السواقي',
            rating: 4.2,
            phone: '0101234022 – 01012340333',
            image: 'https://tse1.mm.bing.net/th/id/OIP.q5-s-1R9mXje634be5_cOAHaGL?rs=1&pid=ImgDetMain&o=7&rm=3',
          ),
          Restaurant(
            name: 'مزاج كافيه (Mazag)',
            distance: 'منطقة دلة / السواقي',
            rating: 4.5,
            phone: '01010344415 – 01010344414',
            image: 'https://tse1.mm.bing.net/th/id/OIP.a33vUzXuJ-9aW_y_nIkL-QAAAA?rs=1&pid=ImgDetMain&o=7&rm=3',
          ),
          Restaurant(
            name: 'دارك كافيه',
            distance: 'منطقة المسلة',
            rating: 4.3,
            image: 'https://th.bing.com/th/id/R.35b75ce366879fd30b93974b9fe136c4?rik=oVzjKVGbIelL1g&riu=http%3a%2f%2fcafesriyadh.com%2fwp-content%2fuploads%2f2023%2f04%2f%d8%af%d8%a7%d8%b1%d9%83-%d9%84%d9%84%d9%82%d9%87%d9%88%d8%a9-%d8%a7%d9%84%d9%85%d8%ae%d8%aa%d8%b5%d8%a9-%d8%b9%d9%81%d9%8a%d9%81.jpg&ehk=RPm7H%2be96SVqS08bRL8%2bR%2b5W97FNpAO7LueFh%2fu4KVY%3d&risl=&pid=ImgRaw&r=0',
          ),
        ],
        nearbyHotels: [
          Hotel(
            name: 'فندق تاش بوتيك الفيوم',
            distance: 'مركز المدينة',
            rating: 4.3,
            pricePerNight: '1200–2500 جنيه',
            image: 'https://usercontent.one/wp/www.miksimons.com/wp-content/uploads/2022/11/Embrace-Hotel-500x300.jpg',
            images: [
              'https://tse2.mm.bing.net/th/id/OIP.zPxFpSSeHTaELJzKwMqmIAHaEK?rs=1&pid=ImgDetMain&o=7&rm=3',
            ],
            description:
            'فندق بوتيك في مركز الفيوم يناسب الباحثين عن الراحة والقرب من المعالم السياحية.',
          ),
          Hotel(
            name: 'فندق قارون',
            distance: 'ميدان السواقي',
            rating: 4.0,
            pricePerNight: 'اتصل للاستفسار',
            phone: '0842163155 – 01017366662',
            image: 'https://tse1.mm.bing.net/th/id/OIP.yJ9Pa4HsCBeYd36h-OHbiwHaHa?rs=1&pid=ImgDetMain&o=7&rm=3',
            images: [
              'https://images.unsplash.com/photo-1584132967334-10e028bd69f7?w=600&q=80',
            ],
            description:
            'فندق بإطلالة مباشرة على سواقي الفيوم وبحر يوسف، موقع مميز في قلب المدينة.',
          ),
        ],
        activities: [
          Activity(
            name: 'التصوير الفوتوغرافي',
            icon: '📸',
            description: 'لقطات ريفية تقليدية مع صوت خرير المياه',
            image: 'https://images.unsplash.com/photo-1433360405326-e50f909805b3?w=500&q=80',
          ),
          Activity(
            name: 'الاستماع لخرير المياه',
            icon: '💧',
            description: 'تجربة حسية ريفية فريدة وسط المدينة',
            image: 'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?w=500&q=80',
          ),
          Activity(
            name: 'زيارة المسجد المعلق',
            icon: '🕌',
            description: 'أثر إسلامي قريب جداً من السواقي',
            image: 'https://images.unsplash.com/photo-1542379653-b926a529191d?w=500&q=80',
          ),
          Activity(
            name: 'التسوق في سوق الناصر',
            icon: '🛍️',
            description: 'سوق شعبي قريب بمنتجات محلية',
            image: 'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=500&q=80',
          ),
        ],
        services: [
          ServiceItem(
              icon: Icons.accessible,
              name: 'دخول مجاني تقريباً',
              color: Colors.green),
          ServiceItem(
              icon: Icons.local_parking,
              name: 'مواقف قريبة',
              color: const Color(0xFF6B8E23)),
          ServiceItem(
              icon: Icons.restaurant_menu,
              name: 'مطاعم سريعة بالميدان',
              color: const Color(0xFF4682B4)),
        ],
        contacts: [
          Contact(
              type: 'السياحة والآثار الفيوم',
              value: '084-6360050',
              icon: Icons.phone),
        ],
      ),

      // ─────────────────────────────────────────────────────────────
      // 6. شلالات وادي الريان
      // ─────────────────────────────────────────────────────────────
      PlaceModel(
        id: '6',
        name: 'شلالات وادي الريان',
        location: 'محمية وادي الريان، جنوب غرب الفيوم – 70 كم عن المدينة',
        images: [
          'assets/images/magic/2.jpg',
          'assets/images/rayen/2.jpg',
          'assets/images/rayen/3.jpg',
          'assets/images/rayen/4.jpg',
          'assets/images/rayen/6.jpg',
        ],
        rating: 4.8,
        price: 'رسوم دخول محمية بسيطة',
        description:
        'شلالات طبيعية فريدة تربط بين بحيرتي وادي الريان في قلب الصحراء',
        description2:
        'شلالات وادي الريان ظاهرة طبيعية مذهلة تجمع بين تناقض الماء والصحراء في مشهد خيالي نادر، حيث تتهاوى المياه العذبة من البحيرة العليا إلى السفلى عبر منحدر صخري محاط بكثبان رملية ذهبية. '
            'تقع على بعد 70 كم جنوب غرب مدينة الفيوم داخل محمية وادي الريان، وتُعد نقطة الجذب الرئيسية في المحمية التي تمتد على مساحة 1759 كم². '
            'تتشكل الشلالات من مياه الصرف الزراعي التي تحولت بفعل الزمن إلى بيئة مائية طبيعية غنية بالطيور والأسماك، في مشهد يصعب تصديقه وسط الصحراء القاحلة. '
            'تُحيط بها الكثبان الرملية المثالية للتزلج والتخييم، وتنتثر حولها العيون الكبريتية الدافئة التي تُضاف إلى تجربة لا تُنسى. '
            'أفضل وقت لزيارتها الصباح الباكر حين تلمع المياه بلون فيروزي ويبدو المشهد كلوحة تشكيلية رسمها الخالق بيده.',
        category: 'محميات طبيعية - شلالات',
        latitude: 29.1908915,
        longitude: 30.4011911,
        googleMapsUrl: 'https://www.google.com/maps/place/Wadi+Al+Raian,+Qesm+Al+Fayoum,+Second+Al+Faiyum,+Faiyum+Governorate/@29.3024755,30.8512262,17z/data=!3m1!4b1!4m6!3m5!1s0x145978d69c48cd59:0xa9992f48be8c101a!8m2!3d29.3024755!4d30.8538011!16s%2Fg%2F1tg4hpcj?entry=ttu&g_ep=EgoyMDI2MDMxNS4wIKXMDSoASAFQAw%3D%3D',
        videos: {'general': ['assets/images/rayen/vedio/1.mp4']},
        nearbyRestaurants: [
          Restaurant(
            name: 'كافيتريا المحمية',
            distance: 'عند مدخل المنطقة',
            rating: 4.0,
            image: 'https://tse2.mm.bing.net/th/id/OIP.0URMJ8i_wjBtYNLamw483AHaHa?rs=1&pid=ImgDetMain&o=7&rm=3',
          ),
        ],
        nearbyHotels: [
          Hotel(
            name: 'ريان الرمال – جلامبينج',
            distance: 'داخل المحمية',
            rating: 4.6,
            pricePerNight: '1500–3000 جنيه',
            phone: '01010915469',
            image: 'https://tse1.mm.bing.net/th/id/OIP.x7ryM9yNqRgfmcW2Hz4ISQHaFj?rs=1&pid=ImgDetMain&o=7&rm=3',
            images: [
              'https://coupletraveltheworld.com/wp-content/uploads/2020/11/hot-tub-hotels-brooklyn-1024x682.jpg',
              'https://tse2.mm.bing.net/th/id/OIP.X7nV6lwBf1iOXl0xsKphngHaEK?w=2400&h=1350&rs=1&pid=ImgDetMain&o=7&rm=3',
            ],
            description:
            'تجربة تخييم فاخرة (جلامبينج) وسط الصحراء بإطلالة على الشلالات والبحيرات.',
          ),
        ],
        activities: [
          Activity(
            name: 'التخييم تحت النجوم',
            icon: '⛺',
            description: 'تخييم فاخر أو عادي وسط الطبيعة الصحراوية',
            image: 'https://images.unsplash.com/photo-1504280390367-361c6d9f38f4?w=500&q=80',
          ),
          Activity(
            name: 'التزلج على الرمال',
            icon: '🏂',
            description: 'منحدرات رملية ممتعة للمغامرين',
            image: 'https://images.unsplash.com/photo-1519985176271-4f4d827c9f87?w=500&q=80',
          ),
          Activity(
            name: 'رحلات السفاري',
            icon: '🏜️',
            description: 'جولات صحراوية بسيارات 4x4',
            image: 'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?w=500&q=80',
          ),
          Activity(
            name: 'السباحة في البحيرة',
            icon: '🏊',
            description: 'مياه عذبة صافية',
            image: 'https://images.unsplash.com/photo-1560272564-c83b19b38190?w=500&q=80',
          ),
          Activity(
            name: 'تصوير الشلالات والبحيرات',
            icon: '🌅',
            description: 'مناظر ساحرة وقت الشروق والغروب',
            image: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=500&q=80',
          ),
        ],
        services: [
          ServiceItem(
              icon: Icons.info,
              name: 'مركز الزوار',
              color: const Color(0xFF4682B4)),
          ServiceItem(
              icon: Icons.local_parking,
              name: 'مواقف سيارات',
              color: const Color(0xFF6B8E23)),
          ServiceItem(
              icon: Icons.wc,
              name: 'دورات مياه',
              color: const Color(0xFFD2B48C)),
          ServiceItem(
              icon: Icons.security,
              name: 'نقطة أمن',
              color: const Color(0xFF2F4F4F)),
        ],
        contacts: [
          Contact(
              type: 'هاتف المحمية', value: '0842830535', icon: Icons.phone),
          Contact(
              type: 'حجز جلامبينج', value: '01010915469', icon: Icons.phone),
        ],
      ),

      // ─────────────────────────────────────────────────────────────
      // 7. قرية ليالي العرب
      // ─────────────────────────────────────────────────────────────
      PlaceModel(
        id: '7',
        name: 'قرية ليالي العرب',
        location: 'طريق القاهرة–الفيوم الصحراوي، الكيلو 48، الفيوم',
        images: [
          'assets/images/arab/mean.jpeg',
          'assets/images/arab/2.jpeg',
          'assets/images/arab/3.jpeg',
          'assets/images/arab/4.jpeg',
          'assets/images/arab/5.jpeg',
          'assets/images/arab/6.jpeg',
          'assets/images/arab/7.jpeg',
          'assets/images/arab/8.jpeg',
          'assets/images/arab/9.jpeg',
          'assets/images/arab/10.jpeg',
          'assets/images/arab/11.jpeg',
          'assets/images/arab/12.jpeg',
          'assets/images/arab/13.jpeg',
        ],
        rating: 4.5,
        price: 'يوم كامل يبدأ من 4000 جنيه',
        description:
        'قرية سياحية متكاملة بطابع بدوي وعربي أصيل – الترفيه والطبيعة في مكان واحد',
        description2:
        'قرية ليالي العرب وجهة ترفيهية متكاملة تنقلك إلى عالم البداوة والأصالة العربية، تقع على الطريق الصحراوي القاهرة-الفيوم عند الكيلو 48، وتُرحب بك بأجواء بدوية دافئة وبُساط رمالي ممتد. '
            'تتميز بمساحتها الشاسعة التي تحتضن تراك خيل دولي وسطبلاً عريقاً ومسارات للبيتش باجي ورحلات سفاري صحراوية تأخذك في مغامرة لا تُنسى. '
            'تنبسط فيها جلسات بدوية أصيلة مع الشاي العربي والمعسل تحت سماء مفتوحة، وتُقدَّم فيها وجبات مطبخ عربي تقليدي بنكهات تُذكرك بحفلات الكرم الأصيل. '
            'تتوفر فيها أيضاً حمامات سباحة متعددة وملاهي كهربائية ومناطق خاصة للأطفال وملاعب متنوعة، مما يجعلها وجهة عائلية مثالية لقضاء يوم كامل. '
            'تستضيف كذلك حفلات الأعراس والمناسبات الكبرى في قاعات مجهزة تجمع بين الفخامة والطابع البدوي الأصيل.',
        category: 'قرى سياحية – ترفيه وعائلة',
        latitude: 29.4000,
        longitude: 30.7000,
        googleMapsUrl: 'https://www.google.com/maps/place/Arabian+Nights+Country+Club+And+Resort/@29.5811561,30.315426,9z/data=!4m10!1m2!2m1!1z2YTZitin2YQg2KfZhNi52LHYqA!3m6!1s0x1459a0509d038393:0x886c87fa52dd43f9!8m2!3d29.5631368!4d30.9330937!15sChPZhNmK2KfZhCDYp9mE2LnYsdioWhUiE9mE2YrYp9mEINin2YTYudix2KiSAQxyZXNvcnRfaG90ZWyaASRDaGREU1VoTk1HOW5TMFZKUTBGblNVTktibkF0TUdoUlJSQULgAQD6AQQIABBF!16s%2Fg%2F1hm2q_gzn?entry=ttu&g_ep=EgoyMDI2MDMxNS4wIKXMDSoASAFQAw%3D%3D',
        videos: {'general': ['assets/images/arab/1.mp4']},
        nearbyRestaurants: [
          Restaurant(
            name: 'مطعم ليالي العرب',
            distance: 'داخل القرية',
            rating: 4.3,
            image: 'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=600&q=80',
          ),
        ],
        nearbyHotels: [
          Hotel(
            name: 'شاليهات ليالي العرب',
            distance: 'داخل القرية',
            rating: 4.4,
            pricePerNight: '2000–5000 جنيه',
            phone: '+20653380021',
            image: 'https://tse2.mm.bing.net/th/id/OIP.X7nV6lwBf1iOXl0xsKphngHaEK?w=2400&h=1350&rs=1&pid=ImgDetMain&o=7&rm=3',
            images: [
              'https://coupletraveltheworld.com/wp-content/uploads/2020/11/hot-tub-hotels-brooklyn-1024x682.jpg',
              'https://tse1.mm.bing.net/th/id/OIP.x7ryM9yNqRgfmcW2Hz4ISQHaFj?rs=1&pid=ImgDetMain&o=7&rm=3',
              'https://tse2.mm.bing.net/th/id/OIP.SnHgDyMfwEkWblyz0dSpZAHaE8?w=700&h=467&rs=1&pid=ImgDetMain&o=7&rm=3',
            ],
            description:
            'شاليهات فاخرة بتصميم عربي أصيل داخل القرية السياحية مع إطلالات جميلة وخدمات متكاملة.',
          ),
        ],
        activities: [
          Activity(
            name: 'حمامات السباحة',
            icon: '🏊',
            description: 'حمامات متعددة للكبار والأطفال',
            image: 'https://images.unsplash.com/photo-1561501878-aabd62634533?w=500&q=80',
          ),
          Activity(
            name: 'ركوب الخيل والبيتش باجي',
            icon: '🐎',
            description: 'تراك دولي وسفاري بدوية مميزة',
            image: 'https://images.unsplash.com/photo-1553284965-83fd3e82fa5a?w=500&q=80',
          ),
          Activity(
            name: 'الملاهي والألعاب',
            icon: '🎡',
            description: 'ملاهي كهربائية وفيديو جيم وبلياردو وبينج بونج',
            image: 'https://images.unsplash.com/photo-1531259683007-016a7b628fc3?w=500&q=80',
          ),
          Activity(
            name: 'جلسات بدوية وشاي عربي',
            icon: '☕',
            description: 'أجواء بدوية دافئة مع الشاي والمعسل',
            image: 'https://images.unsplash.com/photo-1445116572660-236099ec97a0?w=500&q=80',
          ),
          Activity(
            name: 'قاعات الأفراح والمناسبات',
            icon: '🎊',
            description: 'قاعات مجهزة لحفلات الأعراس والمناسبات',
            image: 'https://images.unsplash.com/photo-1519225421980-715cb0215aed?w=500&q=80',
          ),
        ],
        services: [
          ServiceItem(icon: Icons.pool, name: 'حمامات سباحة', color: Colors.blue),
          ServiceItem(
              icon: Icons.local_parking,
              name: 'مواقف سيارات',
              color: const Color(0xFF6B8E23)),
          ServiceItem(
              icon: Icons.restaurant_menu,
              name: 'مطعم داخل القرية',
              color: const Color(0xFF4682B4)),
          ServiceItem(
              icon: Icons.hotel, name: 'شاليهات للإقامة', color: Colors.amber),
          ServiceItem(
              icon: Icons.wc,
              name: 'دورات مياه',
              color: const Color(0xFFD2B48C)),
          ServiceItem(
              icon: Icons.sports, name: 'ملاعب وألعاب', color: Colors.green),
        ],
        contacts: [
          Contact(
              type: 'هاتف القرية', value: '+20653380021', icon: Icons.phone),
        ],
      ),

      // ─────────────────────────────────────────────────────────────
      // 8. بحيرة قارون
      // ─────────────────────────────────────────────────────────────
      PlaceModel(
        id: '8',
        name: 'بحيرة قارون',
        location: 'شمال محافظة الفيوم، مركز إبشواي ومركز يوسف الصديق',
        images: [
          'assets/images/quro/mean.jpg',
          'assets/images/quro/2.jpg',
          'assets/images/quro/3.jpg',
          'assets/images/quro/4.jpg',
          'assets/images/quro/5.jpg',
          'assets/images/quro/6.jpg',
          'assets/images/quro/7.jpg',
          'assets/images/quro/8.jpg',
          'assets/images/quro/9.jpg',
          'assets/images/quro/10.jpg',
          'assets/images/quro/11.jpg',
        ],
        rating: 4.6,
        price: 'دخول مجاني – رسوم رمزية للأنشطة',
        description:
        'أقدم بحيرة طبيعية في العالم وأكبر بحيرة طبيعية في مصر – جوهرة الفيوم',
        description2:
        'بحيرة قارون كنز طبيعي عريق تضرب جذوره في أعماق التاريخ، فهي من أقدم البحيرات الطبيعية في العالم وأكبرها في مصر بمساحة تتجاوز 233 كم²، وقد عرفها الفراعنة باسم "مي-ور" أي البحر العظيم. '
            'تتميز بشواطئها الهادئة وصفحتها المائية الفضية التي تنعكس عليها السماء الزرقاء، وتُحيط بها حقول خضراء وواحات نخيل في مشهد يجمع الصحراء والماء والخضرة معاً. '
            'تُعد محطة موسمية لأكثر من 100 نوع من الطيور المهاجرة القادمة من أوروبا وآسيا، مما يجعلها جنة للمراقبين والمصورين الطبيعيين طوال فصلي الخريف والشتاء. '
            'تزخر مياهها المالحة بأسماك البوري والبلطي والقاروص التي تجذب الصيادين وعشاق الرياضات المائية الهادئة. '
            'تُطل عليها قرية تونس الشهيرة من الجهة الجنوبية الشرقية، وتمتد على ضفافها الشمالية منشآت سياحية ومطاعم تقدم ألذ أسماك بحيرة قارون الطازجة.',
        category: 'بحيرات طبيعية – محميات',
        latitude: 29.4703,
        longitude: 30.5625,
        googleMapsUrl: 'https://www.google.com/maps/place/Qarun+Lake/@29.4719422,30.450432,11z/data=!3m1!4b1!4m6!3m5!1s0x145968cde9c10527:0xf5824db951045a46!8m2!3d29.4840214!4d30.6545022!16zL20vMDl4anM2?entry=ttu&g_ep=EgoyMDI2MDMxNS4wIKXMDSoASAFQAw%3D%3D',
        videos: {'general': []},
        nearbyRestaurants: [
          Restaurant(
            name: 'مطعم لوتس (Lotus)',
            distance: 'شاطئ بحيرة قارون',
            rating: 4.3,
            phone: '0846800002',
            image: 'https://tse4.mm.bing.net/th/id/OIP.3lPN4PdfvP50CFwPWFe1IgHaDQ?rs=1&pid=ImgDetMain&o=7&rm=3',
          ),
          Restaurant(
            name: 'مطعم الباشا',
            distance: 'كورنيش البحيرة',
            rating: 4.2,
            image: 'https://tse4.mm.bing.net/th/id/OIP.sXIaDKZpKRqIEgpJfCpxIAHaHZ?rs=1&pid=ImgDetMain&o=7&rm=3',
          ),
          Restaurant(
            name: 'كافيتريا قارون فيو',
            distance: 'ساحل البحيرة الشمالي',
            rating: 4.0,
            image: 'https://images.unsplash.com/photo-1445116572660-236099ec97a0?w=600&q=80',
          ),
        ],
        nearbyHotels: [
          Hotel(
            name: 'فندق أوبروي سهل حشيش – قارون',
            distance: 'ساحل البحيرة',
            rating: 4.7,
            pricePerNight: '2000–5000 جنيه',
            phone: '0846800002',
            image: 'https://th.bing.com/th/id/OIP.yJ9Pa4HsCBeYd36h-OHbiwHaHa?o=7rm=3&rs=1&pid=ImgDetMain&o=7&rm=3',
            images: [
              'https://tse3.mm.bing.net/th/id/OIP.5IVqI59aLWrT2jopNGTCKQHaE7?w=1280&h=853&rs=1&pid=ImgDetMain&o=7&rm=3',
              'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/07/38/21/55/sahul-hotel-recption.jpg?w=800&h=500&s=1',
            ],
            description:
            'فندق فاخر على ضفاف بحيرة قارون بإطلالات بانورامية رائعة، يوفر غرفاً فاخرة وأنشطة مائية متنوعة.',
          ),
          Hotel(
            name: 'إستراحة قارون السياحية',
            distance: 'كورنيش البحيرة',
            rating: 4.1,
            pricePerNight: '600–1200 جنيه',
            image: 'https://th.bing.com/th/id/R.71e55f1762243a5724f727e0f8498762?rik=wNvCEf21H%2b7bhA&riu=http%3a%2f%2fwww.visitfayoum.net%2fHotelImg%2f85_n.jpg&ehk=f15dMzn5S%2bm2UDV1NK3i3ik0AumzMWrKzogn8LlTrLQ%3d&risl=&pid=ImgRaw&r=0',
            images: [
              'https://res.klook.com/klook-hotel/image/upload/travelapi/8000000/7350000/7340200/7340108/0a27cc44_z.jpg',
            ],
            description:
            'إستراحة سياحية بأسعار مناسبة على ضفاف البحيرة مناسبة للعائلات.',
          ),
        ],
        activities: [
          Activity(
            name: 'صيد الأسماك',
            icon: '🎣',
            description: 'البحيرة غنية بأسماك البوري والبلطي والقاروص',
            image: 'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?w=500&q=80',
          ),
          Activity(
            name: 'ركوب القوارب والعبّارات',
            icon: '🚣',
            description: 'جولات بحرية حول البحيرة ومشاهدة الطيور',
            image: 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=500&q=80',
          ),
          Activity(
            name: 'مشاهدة الطيور المهاجرة',
            icon: '🦅',
            description: 'أكثر من 100 نوع من الطيور تتوقف بالبحيرة موسمياً',
            image: 'https://images.unsplash.com/photo-1446776877081-d282a0f896e2?w=500&q=80',
          ),
          Activity(
            name: 'التصوير الفوتوغرافي',
            icon: '📸',
            description: 'غروب شمس ساحر على صفحة البحيرة',
            image: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=500&q=80',
          ),
          Activity(
            name: 'الاسترخاء على الشاطئ',
            icon: '🏖️',
            description: 'شواطئ رملية هادئة على ضفاف البحيرة',
            image: 'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?w=500&q=80',
          ),
          Activity(
            name: 'زيارة قرية تونس',
            icon: '🏺',
            description: 'قرية الفخار والخزف اليدوي على ضفاف البحيرة',
            image: 'https://images.unsplash.com/photo-1565193566173-7a0ee3dbe261?w=500&q=80',
          ),
        ],
        services: [
          ServiceItem(
              icon: Icons.local_parking,
              name: 'مواقف سيارات',
              color: const Color(0xFF6B8E23)),
          ServiceItem(
              icon: Icons.restaurant_menu,
              name: 'مطاعم وكافيهات ساحلية',
              color: const Color(0xFF4682B4)),
          ServiceItem(
              icon: Icons.directions_boat,
              name: 'قوارب وأنشطة مائية',
              color: Colors.blueAccent),
          ServiceItem(
              icon: Icons.security,
              name: 'نقطة أمن وإنقاذ',
              color: const Color(0xFF2F4F4F)),
          ServiceItem(
              icon: Icons.wc,
              name: 'دورات مياه',
              color: const Color(0xFFD2B48C)),
        ],
        contacts: [
          Contact(
              type: 'محمية قارون', value: '084-6820025', icon: Icons.phone),
          Contact(
              type: 'السياحة والآثار الفيوم',
              value: '084-6360050',
              icon: Icons.phone),
          Contact(
              type: 'فندق لوتس قارون',
              value: '0846800002',
              icon: Icons.phone),
        ],
      ),
    ];
  }

  static List<PlaceModel> getPopularPlaces() => getAllPlaces().take(4).toList();

  static List<PlaceModel> searchPlaces(String query) {
    if (query.trim().isEmpty) return getAllPlaces();
    final q = query.trim().toLowerCase();
    return getAllPlaces()
        .where((p) =>
    p.name.toLowerCase().contains(q) ||
        p.location.toLowerCase().contains(q) ||
        p.category.toLowerCase().contains(q) ||
        p.description.toLowerCase().contains(q))
        .toList();
  }
}