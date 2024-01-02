import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pageinfo1/constants.dart';
import 'package:pageinfo1/models/medicine_type.dart';
import 'package:sizer/sizer.dart';

import '../../common/convert_time.dart';

class NewEntryPage extends StatefulWidget {
  const NewEntryPage({super.key});

  @override
  State<NewEntryPage> createState() => _NewEntryPageState();
}

class _NewEntryPageState extends State<NewEntryPage> {
  late TextEditingController nameController;
  late TextEditingController dosageController;

  late GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    dosageController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController = TextEditingController();
    dosageController = TextEditingController();
    _scaffoldKey = GlobalKey<ScaffoldState>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Add new'),
      ),
      body: Padding(
        padding: EdgeInsets.all(2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PanelTitle(
              title: 'Medicine name',
              isRequired: true,
            ),
            TextFormField(
              maxLength: 12,
              controller: nameController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
              ),
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: KOtherColor),
            ),
            const PanelTitle(
              title: 'Dosage in mg',
              isRequired: false,
            ),
            TextFormField(
              maxLength: 12,
              controller: dosageController,
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
              ),
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: KOtherColor),
            ),
            SizedBox(
              height: 2.h,
            ),
            const PanelTitle(title: 'Medicine ype', isRequired: false),
            Padding(
                padding: EdgeInsets.only(top: 1.h),
                child: StreamBuilder(
                  //stream: ,
                  builder: (context, snapshot) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MedicineTypeColumn(
                            medicineType: MedicineType.bottle,
                            name: 'Bottle',
                            iconValue: 'assets/icons/bottle.svg',
                            isSelected: snapshot.data == MedicineType.bottle
                                ? true
                                : false),
                        MedicineTypeColumn(
                            medicineType: MedicineType.pill,
                            name: 'Pill',
                            iconValue: 'assets/icons/pill.svg',
                            isSelected: snapshot.data == MedicineType.pill
                                ? true
                                : false),
                        MedicineTypeColumn(
                            medicineType: MedicineType.syringe,
                            name: 'Syringe',
                            iconValue: 'assets/icons/syringe.svg',
                            isSelected: snapshot.data == MedicineType.syringe
                                ? true
                                : false),
                        MedicineTypeColumn(
                            medicineType: MedicineType.bottle,
                            name: 'Tablet',
                            iconValue: 'assets/icons/bottle.svg',
                            isSelected: snapshot.data == MedicineType.bottle
                                ? true
                                : false),
                      ],
                    );
                  },
                  stream: null,
                )),
            const PanelTitle(title: 'Interval Selection', isRequired: true),
            const IntervalSelection(),
            const PanelTitle(title: 'Starting time', isRequired: true),
            const SelectTime(),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 40.w,
                right: 8.w,
              ),
              child: SizedBox(
                width: 30.w,
                height: 10.h,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    shape: const StadiumBorder(),
                  ),
                  child:Center(
                    child:Text('Confirm',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color:KScaffoldColor,
                    ),),
                  ),
                  onPressed: (){
                    //medicine gula add hobe
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectTime extends StatefulWidget {
  const SelectTime({super.key});

  @override
  State<SelectTime> createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
 TimeOfDay _time=const TimeOfDay(hour: 0, minute: 00);
  bool _clicked=false;

  Future<TimeOfDay> _selectTime()async{
    final TimeOfDay?picked=await showTimePicker(
        context: context,
        initialTime: _time);

    if(picked!=null && picked!=_time)
      {
        setState(() {
          _time=picked;
          _clicked=true;
          //update korbe state
        });
      }
    return picked!;
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 8.h,
      child: Padding(
        padding: EdgeInsets.only(top: 2.h),
        child: TextButton(
          style: TextButton.styleFrom(
              backgroundColor: kPrimaryColor, shape: const StadiumBorder()),
          onPressed: () {

            _selectTime();
          },
          child: Center(
            child: Text(
              _clicked==false
              ? "Select Time":
                 "${convertTime(_time.hour.toString())}:${convertTime(_time.minute.toString())}",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: KScaffoldColor),
            ),
          ),
        ),
      ),
    );
  }
}

class IntervalSelection extends StatefulWidget {
  const IntervalSelection({super.key});

  @override
  State<IntervalSelection> createState() => _IntervalSelectionState();
}

class _IntervalSelectionState extends State<IntervalSelection> {
  final _intervals = [6, 8, 12, 24];
  var _selected = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Remind me every',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          DropdownButton(
            iconEnabledColor: KOtherColor,
            dropdownColor: KScaffoldColor,
            itemHeight: 8.h,
            hint: _selected == 0
                ? Text(
                    'select an interval',
                    style: Theme.of(context).textTheme.labelMedium,
                  )
                : null,
            elevation: 4,
            value: _selected == 0 ? null : _selected,
            items: _intervals.map(
              (int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(
                    value.toString(),
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                );
              },
            ).toList(),
            onChanged: (newVal) {
              setState(
                () {
                  _selected = newVal!;
                },
              );
            },
          ),
          Text(
            _selected == 1 ? "hour" : "hours",
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
    );
  }
}

class MedicineTypeColumn extends StatelessWidget {
  const MedicineTypeColumn(
      {super.key,
      required this.medicineType,
      required this.name,
      required this.iconValue,
      required this.isSelected});
  final MedicineType medicineType;
  final String name;
  final String iconValue;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //medicine type select  jonno
      },
      child: Column(
        children: [
          Container(
            width: 20.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.h),
                color: isSelected ? KOtherColor : Colors.white),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 1.h,
                  bottom: 1.h,
                ),
                child: SvgPicture.asset(
                  iconValue,
                  height: 7.h,
                  color: isSelected ? Colors.white : KOtherColor,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 1.h),
            child: Container(
              width: 20.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: isSelected ? KOtherColor : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  name,
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(color: isSelected ? Colors.white : KOtherColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PanelTitle extends StatelessWidget {
  const PanelTitle({super.key, required this.title, required this.isRequired});
  final String title;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: Text.rich(
        TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: title,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            TextSpan(
              text: isRequired ? "*" : " ",
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: kPrimaryColor,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
