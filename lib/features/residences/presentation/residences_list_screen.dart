import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh_panel/core/constants/colors.dart';
import 'package:safar_khaneh_panel/core/utils/number_formater.dart';
import 'package:safar_khaneh_panel/data/models/residence_model.dart';

final List<ResidenceModel> residences = [
  ResidenceModel(
    id: 1,
    title: 'خانه بزرگ',
    city: 'کاشان',
    province: 'مرکز',
    price: 120000,
    rating: 4.5,
    latitude: 35.6895,
    longitude: 51.3892,
    manager: 'مهدی حسامی',
    roomCount: 4,
    description:
        'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد، کتابهای زیادی در شصت و سه درصد گذشته حال و آینده، شناخت فراوان جامعه و متخصصان را می طلبد، تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی، و فرهنگ پیشرو در زبان فارسی ایجاد کرد، در این صورت می توان امید داشت که تمام و دشواری موجود در ارائه راهکارها، و شرایط سخت تایپ به پایان رسد و زمان مورد نیاز شامل حروفچینی دستاوردهای اصلی، و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد.',
    facilities: ['استخر', 'دختر', 'بازم دختر', 'عدم وجود پسر'],
    backgroundImage: 'assets/images/Residences/3.jpg',
    capacity: 4,
    cleaningFee: 20000,
    serviceFee: 20000,
    startDate: '1400/01/01',
    endDate: '1400/01/01',
    phoneNumber: 912345678,
  ),
  ResidenceModel(
    id: 2,
    title: 'ویلا کوهستانی',
    city: 'قم',
    province: 'قم',
    price: 150000,
    rating: 4.7,
    latitude: 35.6895,
    longitude: 51.3892,
    manager: 'مهدی حسامی',
    roomCount: 4,
    description:
        'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد، کتابهای زیادی در شصت و سه درصد گذشته حال و آینده، شناخت فراوان جامعه و متخصصان را می طلبد، تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی، و فرهنگ پیشرو در زبان فارسی ایجاد کرد، در این صورت می توان امید داشت که تمام و دشواری موجود در ارائه راهکارها، و شرایط سخت تایپ به پایان رسد و زمان مورد نیاز شامل حروفچینی دستاوردهای اصلی، و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد.',
    facilities: ['استخر', 'پسر', 'بازم پسر', 'عدم وجود دختر'],
    backgroundImage: 'assets/images/Residences/1.jpg',
    capacity: 3,
    cleaningFee: 10000,
    serviceFee: 30000,
    startDate: '1400/01/01',
    endDate: '1400/01/01',
    phoneNumber: 912345678,
  ),
  ResidenceModel(
    id: 3,
    title: 'آپارتمان لوکس',
    city: 'تهران',
    province: 'سعادت آباد',
    price: 200000,
    rating: 4.8,
    latitude: 35.6895,
    longitude: 51.3892,
    manager: 'مهدی حسومی',
    roomCount: 4,
    description:
        'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد، کتابهای زیادی در شصت و سه درصد گذشته حال و آینده، شناخت فراوان جامعه و متخصصان را می طلبد، تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی، و فرهنگ پیشرو در زبان فارسی ایجاد کرد، در این صورت می توان امید داشت که تمام و دشواری موجود در ارائه راهکارها، و شرایط سخت تایپ به پایان رسد و زمان مورد نیاز شامل حروفچینی دستاوردهای اصلی، و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد.',
    facilities: ['استخر', 'غذا', 'حسوم', 'عدم وجود پسر'],
    backgroundImage: 'assets/images/Residences/2.jpg',
    capacity: 1,
    cleaningFee: 50000,
    serviceFee: 20000,
    startDate: '1400/01/01',
    endDate: '1400/01/01',
    phoneNumber: 912345678,
  ),
  ResidenceModel(
    id: 4,
    title: 'خانه سنتی',
    city: 'کاشان',
    province: 'مرکز',
    price: 100000,
    rating: 4.3,
    latitude: 35.6895,
    longitude: 51.3892,
    manager: 'مهدی حسومی',
    roomCount: 4,
    description:
        'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد، کتابهای زیادی در شصت و سه درصد گذشته حال و آینده، شناخت فراوان جامعه و متخصصان را می طلبد، تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی، و فرهنگ پیشرو در زبان فارسی ایجاد کرد، در این صورت می توان امید داشت که تمام و دشواری موجود در ارائه راهکارها، و شرایط سخت تایپ به پایان رسد و زمان مورد نیاز شامل حروفچینی دستاوردهای اصلی، و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد.',
    facilities: ['استخر', 'غذا', 'حسوم', 'عدم وجود پسر'],
    backgroundImage: 'assets/images/Residences/4.jpg',
    capacity: 5,
    cleaningFee: 15000,
    serviceFee: 20000,
    startDate: '1400/01/01',
    endDate: '1400/01/01',
    phoneNumber: 912345678,
  ),
  ResidenceModel(
    id: 5,
    title: 'ویلا کوهستانی',
    city: 'کاشان',
    province: 'مرکز',
    price: 100000,
    rating: 4.3,
    latitude: 35.6895,
    longitude: 51.3892,
    manager: 'مهدی حسومی',
    roomCount: 4,
    description:
        'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد، کتابهای زیادی در شصت و سه درصد گذشته حال و آینده، شناخت فراوان جامعه و متخصصان را می طلبد، تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی، و فرهنگ پیشرو در زبان فارسی ایجاد کرد، در این صورت می توان امید داشت که تمام و دشواری موجود در ارائه راهکارها، و شرایط سخت تایپ به پایان رسد و زمان مورد نیاز شامل حروفچینی دستاوردهای اصلی، و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد.',
    facilities: ['استخر', 'غذا', 'حسوم', 'عدم وجود پسر'],
    backgroundImage: 'assets/images/Residences/4.jpg',
    capacity: 8,
    cleaningFee: 25000,
    serviceFee: 20000,
    startDate: '1400/01/01',
    endDate: '1400/01/01',
    phoneNumber: 912345678,
  ),
  ResidenceModel(
    id: 6,
    title: 'ویلا کویری',
    city: 'قم',
    province: 'قم',
    price: 100000,
    rating: 4.3,
    latitude: 35.6895,
    longitude: 51.3892,
    manager: 'مهدی حسومی',
    roomCount: 4,
    description:
        'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد، کتابهای زیادی در شصت و سه درصد گذشته حال و آینده، شناخت فراوان جامعه و متخصصان را می طلبد، تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی، و فرهنگ پیشرو در زبان فارسی ایجاد کرد، در این صورت می توان امید داشت که تمام و دشواری موجود در ارائه راهکارها، و شرایط سخت تایپ به پایان رسد و زمان مورد نیاز شامل حروفچینی دستاوردهای اصلی، و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد.',
    facilities: ['استخر', 'غذا', 'حسوم', 'عدم وجود پسر'],
    backgroundImage: 'assets/images/Residences/2.jpg',
    capacity: 4,
    cleaningFee: 50000,
    serviceFee: 20000,
    startDate: '1400/01/01',
    endDate: '1400/01/01',
    phoneNumber: 912345678,
  ),
];

class ResidencesListScreen extends StatelessWidget {
  const ResidencesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'لیست اقامتگاه ها',
          style: TextStyle(color: AppColors.secondary500),
        ),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.arrow_left, color: AppColors.secondary500),
            onPressed: () {
              context.pop();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: residences.length,
        itemBuilder: (context, index) {
          final residence = residences[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.secondary400,
              child: Text(
                formatNumberToPersian(residence.id),
                style: const TextStyle(color: AppColors.white),
              ),
            ),
            title: Text(residence.title),
            subtitle: Row(
              children: [
                Text(
                  'مدیر: ${residence.manager}',
                  style: const TextStyle(
                    color: AppColors.grey700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  '${residence.city}، ${residence.province}',
                  style: const TextStyle(
                    color: AppColors.grey500,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            trailing: const Icon(Iconsax.edit),
            onTap: () {
              context.push('/residence/${residence.id}', extra: residence);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.secondary500,
        foregroundColor: AppColors.white,
        onPressed: () {},
        child: const Icon(Iconsax.add, size: 32),
      ),
    );
  }
}
