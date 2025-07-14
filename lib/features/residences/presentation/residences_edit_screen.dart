import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh_panel/config/router/app_router.dart';
import 'package:safar_khaneh_panel/core/constants/colors.dart';
import 'package:safar_khaneh_panel/core/utils/validators.dart';
import 'package:safar_khaneh_panel/data/api/feature_service.dart';
import 'package:safar_khaneh_panel/data/api/geo_service.dart';
import 'package:safar_khaneh_panel/data/api/residence_services.dart';
import 'package:safar_khaneh_panel/data/models/feature_model.dart';
import 'package:safar_khaneh_panel/data/models/residence_model.dart';
import 'package:safar_khaneh_panel/widgets/button.dart';
import 'package:safar_khaneh_panel/widgets/feature_selector.dart';
import 'package:safar_khaneh_panel/widgets/inputs/image_input.dart';
import 'package:safar_khaneh_panel/widgets/inputs/text_form_field.dart';
import 'package:safar_khaneh_panel/widgets/map_picker.dart';

class ResidencesEditScreen extends StatefulWidget {
  final ResidenceModel residence;

  const ResidencesEditScreen({super.key, required this.residence});

  @override
  State<ResidencesEditScreen> createState() => _ResidencesEditScreenState();
}

class _ResidencesEditScreenState extends State<ResidencesEditScreen> {
  final GlobalKey<FormState> _updateMyResidenceFormKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController roomCountController = TextEditingController();
  TextEditingController capacityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController maxDaysController = TextEditingController();
  TextEditingController cleaningFeeController = TextEditingController();
  TextEditingController serviceFeeController = TextEditingController();
  File? imageFile;
  List<FeatureModel> features = [];
  List<FeatureModel> allFeatures = [];
  String? latitude;
  String? longitude;

  final geoService = GeoService();

  final FeatureService featureService = FeatureService();
  Future<void> _loadFeatures() async {
    try {
      final fetchedFeatures = await featureService.fetchFeatures();
      setState(() {
        allFeatures = fetchedFeatures;
      });
    } catch (e) {
      throw Exception('خطا در دریافت امکانات: $e');
    }
  }

  Future<void> _loadProvincesAndCities() async {
    try {
      final fetchedProvinces = await geoService.fetchProvinces();

      List<City> fetchedCities = [];
      if (widget.residence.location?.city?.province != null) {
        final provinceId = widget.residence.location!.city!.province!.id!;
        fetchedCities = await geoService.fetchCitiesByProvince(provinceId);
      }

      setState(() {
        provinces = fetchedProvinces;
        selectedProvince = fetchedProvinces.firstWhere(
          (p) => p.id == widget.residence.location?.city?.province?.id,
        );

        cities = fetchedCities;
        selectedCity = widget.residence.location?.city;
      });
    } catch (e) {
      throw Exception('خطا در دریافت اطلاعات: $e');
    }
  }

  Province? selectedProvince;
  City? selectedCity;
  List<Province> provinces = [];
  List<City> cities = [];
  List<String> types = ['villa'];
  String? selectedType;

  @override
  void initState() {
    titleController.text = widget.residence.title!;
    descriptionController.text = widget.residence.description.toString();
    roomCountController.text = widget.residence.roomCount != null
        ? widget.residence.roomCount.toString()
        : '0';
    capacityController.text = widget.residence.capacity.toString();
    priceController.text = widget.residence.pricePerNight.toString();
    maxDaysController.text = widget.residence.maxNightsStay.toString();
    cleaningFeeController.text = widget.residence.cleaningPrice.toString();
    serviceFeeController.text = widget.residence.servicesPrice.toString();
    addressController.text =
        widget.residence.location?.address.toString() ?? '';
    features = widget.residence.features ?? [];
    latitude = widget.residence.location?.lat.toString();
    longitude = widget.residence.location?.lng.toString();
    selectedType = widget.residence.type;
    selectedProvince = widget.residence.location?.city?.province;
    selectedCity = widget.residence.location?.city;
    imageFile = File(widget.residence.imageUrl.toString());
    _loadProvincesAndCities();
    _loadFeatures();
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    roomCountController.dispose();
    capacityController.dispose();
    priceController.dispose();
    maxDaysController.dispose();
    cleaningFeeController.dispose();
    serviceFeeController.dispose();
    features.clear();
    latitude = null;
    longitude = null;
    selectedProvince = null;
    selectedCity = null;
    provinces.clear();
    cities.clear();
    super.dispose();
  }

  bool _isLoading = false;
  final ResidenceServices _residenceServices = ResidenceServices();

  void handleUpdateResidence(context) async {
    if (!_updateMyResidenceFormKey.currentState!.validate()) return;
    setState(() {
      _isLoading = true;
    });
    try {
      await _residenceServices.updateResidence(
        id: widget.residence.id!,
        title: titleController.text,
        description: descriptionController.text,
        type: selectedType!,
        capacity: int.parse(capacityController.text),
        maxNightsStay: int.parse(maxDaysController.text),
        pricePerNight: int.parse(priceController.text),
        cleaningPrice: int.parse(cleaningFeeController.text),
        servicesPrice: int.parse(serviceFeeController.text),
        roomCount: int.parse(roomCountController.text),
        address: addressController.text,
        lat: double.parse(latitude!).toStringAsFixed(6),
        lng: double.parse(longitude!).toStringAsFixed(6),
        cityId: selectedCity?.id ?? 0,
        isActive: widget.residence.isActive!,
        featureIds: features.map((e) => e.id).toList(),
        imageFile: imageFile?.path != widget.residence.imageUrl
            ? imageFile
            : null,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Text(
            'ویرایش با موفقیت انجام شد',
            textDirection: TextDirection.rtl,
          ),
          backgroundColor: AppColors.success200,
          duration: const Duration(milliseconds: 1800),
        ),
      );
      Future.delayed(const Duration(milliseconds: 1900), () {
        GoRouter.of(navigatorKey.currentContext!).go('/residences');
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Text(e.toString(), textDirection: TextDirection.rtl),
          backgroundColor: AppColors.error200,
          duration: const Duration(seconds: 3),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _handleDeleteResidence(context) async {
    try {
      await _residenceServices.deleteResidence(widget.residence.id!);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Text(
            'حذف با موفقیت انجام شد',
            textDirection: TextDirection.rtl,
          ),
          backgroundColor: AppColors.success200,
          duration: const Duration(milliseconds: 1800),
        ),
      );

      Future.delayed(const Duration(milliseconds: 1900), () {
        GoRouter.of(navigatorKey.currentContext!).go('/residences');
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Text(
            'خطا در حذف اقامتگاه',
            textDirection: TextDirection.rtl,
          ),
          backgroundColor: AppColors.error200,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.secondary500,
            automaticallyImplyLeading: false,
            leading: Padding(
              padding: const EdgeInsets.only(right: 7.1),
              child: PopupMenuButton(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  side: BorderSide(color: AppColors.white, width: 2),
                ),
                elevation: 8,
                offset: const Offset(0, 48),
                icon: const Icon(Iconsax.menu, color: AppColors.white),
                onSelected: (value) {
                  if (value == 'deleteResidence') {
                    _handleDeleteResidence(context);
                  }
                },
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      value: 'deleteResidence',
                      child: Text(
                        'حذف اقامتگاه',
                        style: TextStyle(
                          color: AppColors.error300,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ];
                },
              ),
            ),
            title: Text(
              widget.residence.title!,
              style: const TextStyle(color: AppColors.white),
            ),
            actions: [
              IconButton(
                icon: const Icon(Iconsax.arrow_left, color: AppColors.white),
                onPressed: () => context.pop(),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _updateMyResidenceFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InputTextFormField(
                      label: 'عنوان',
                      controller: titleController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        return AppValidator.userName(value);
                      },
                    ),
                    const SizedBox(height: 16),
                    FeaturesSelector(
                      allFeatures: allFeatures,
                      selectedFeatures: features,
                      onChanged: (selectedFeatures) {
                        setState(() {
                          features = selectedFeatures;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    InputTextFormField(
                      label: 'توضیحات',
                      controller: descriptionController,
                      keyboardType: TextInputType.multiline,
                      maxLines: 6,
                      validator: (value) {
                        return AppValidator.userName(value);
                      },
                    ),
                    const SizedBox(height: 16),
                    InputTextFormField(
                      label: 'آدرس',
                      controller: addressController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        return AppValidator.userName(value);
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 0,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.grey600,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                            ),
                            child: DropdownButtonFormField<Province>(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              isExpanded: true,
                              validator: (value) {
                                return AppValidator.province(value);
                              },
                              icon: const Icon(
                                Icons.keyboard_arrow_down_rounded,
                              ),
                              dropdownColor: Colors.white,
                              value:
                                  provinces.any(
                                    (p) => p.id == selectedProvince?.id,
                                  )
                                  ? selectedProvince
                                  : null,
                              hint: const Text(
                                'انتخاب استان',
                                style: TextStyle(
                                  fontFamily: 'Vazir',
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              items: provinces.map((province) {
                                return DropdownMenuItem<Province>(
                                  value: province,
                                  child: Text(
                                    province.name ?? '',
                                    style: const TextStyle(
                                      fontFamily: 'Vazir',
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (Province? newProvince) async {
                                setState(() {
                                  selectedProvince = newProvince;
                                  selectedCity = null;
                                  cities = [];
                                });
                                if (newProvince != null) {
                                  final fetchedCities = await geoService
                                      .fetchCitiesByProvince(newProvince.id!);
                                  setState(() {
                                    cities = fetchedCities;
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 0,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.grey600,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                            ),
                            child: DropdownButtonFormField<City>(
                              isExpanded: true,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              validator: (value) {
                                return AppValidator.city(value);
                              },
                              icon: const Icon(
                                Icons.keyboard_arrow_down_rounded,
                              ),
                              dropdownColor: Colors.white,
                              value: cities.any((c) => c.id == selectedCity?.id)
                                  ? selectedCity
                                  : null,
                              hint: const Text(
                                'انتخاب شهر',
                                style: TextStyle(
                                  fontFamily: 'Vazir',
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              items: cities.map((city) {
                                return DropdownMenuItem<City>(
                                  value: city,
                                  child: Text(
                                    city.name ?? '',
                                    style: const TextStyle(
                                      fontFamily: 'Vazir',
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (City? newCity) {
                                setState(() {
                                  selectedCity = newCity;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: InputTextFormField(
                            label: 'ظرفیت نفرات',
                            controller: capacityController,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: InputTextFormField(
                            label: 'تعداد اتاق خواب',
                            controller: roomCountController,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.grey600,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: DropdownButtonFormField<String>(
                        isExpanded: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          return AppValidator.type(value);
                        },
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        dropdownColor: Colors.white,
                        value: types.contains(selectedType)
                            ? selectedType
                            : null,
                        hint: const Text(
                          'انتخاب نوع',
                          style: TextStyle(
                            fontFamily: 'Vazir',
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        items: types.map((type) {
                          return DropdownMenuItem<String>(
                            value: type,
                            child: Text(
                              type == 'villa' ? 'ویلا' : '',
                              style: const TextStyle(
                                fontFamily: 'Vazir',
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newType) {
                          setState(() {
                            selectedType = newType;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: InputTextFormField(
                            label: 'حداکثر تعداد روز',
                            controller: maxDaysController,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: InputTextFormField(
                            label: 'قیمت هر شب',
                            controller: priceController,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: InputTextFormField(
                            label: 'قیمت نظافت',
                            controller: cleaningFeeController,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: InputTextFormField(
                            label: 'قیمت خدمات',
                            controller: serviceFeeController,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    MapPicker(
                      initialLatitude: widget.residence.location?.lat,
                      initialLongitude: widget.residence.location?.lng,
                      onLocationSelected: (latitude, longitude) {
                        setState(() {
                          this.latitude = latitude.toString();
                          this.longitude = longitude.toString();
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    ImageUploadInput(
                      initialImageUrl: widget.residence.imageUrl,
                      onImageSelected: (file) {
                        setState(() {
                          imageFile = file;
                        });
                      },
                    ),
                    const SizedBox(height: 24),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'مستندات اقامتگاه',
                          style: TextStyle(
                            fontFamily: 'Vazir',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.grey500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: widget.residence.documentUrl != null
                              ? Image.asset(
                                  'assets/images/Residences/Not-Found.jpg',
                                  fit: BoxFit.cover,
                                  height: 200,
                                  width: double.infinity,
                                )
                              : Image.network(
                                  widget.residence.documentUrl!,
                                  fit: BoxFit.cover,
                                  height: 200,
                                  width: double.infinity,
                                ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    CheckboxListTile(
                      title: const Text(
                        'فعال کردن اقامتگاه',
                        style: TextStyle(
                          fontFamily: 'Vazir',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      value: widget.residence.isActive,
                      onChanged: (value) {
                        setState(() {
                          widget.residence.isActive = value!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      visualDensity: const VisualDensity(
                        horizontal: -4,
                        vertical: -4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 20,
              top: 12,
            ),
            decoration: const BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, -4),
                  blurRadius: 12,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Button(
              backgroundColor: AppColors.secondary500,
              onPressed: () {
                handleUpdateResidence(context);
              },
              label: 'ویرایش اقامتگاه',
              width: double.infinity,
              isLoading: _isLoading,
              enabled: !_isLoading,
            ),
          ),
        ),
      ),
    );
  }
}
