# flutter_mcumgr
Flutter package for using mcu manager on ios and android. Specifically the FOTA part


Android lib:
https://github.com/NordicSemiconductor/Android-nRF-Connect-Device-Manager

ios lib:
https://github.com/NordicSemiconductor/IOS-nRF-Connect-Device-Manager

Android import:
implementation 'no.nordicsemi.android:mcumgr-ble:1.3.1'

ios pod:
pod 'iOSMcuManagerLibrary', '~> 1.2.0'


React native port:
https://github.com/PlayerData/react-native-mcu-manager/blob/main/android/build.gradle


https://codelabs.developers.google.com/codelabs/write-flutter-plugin#6


flutter create --org com.riftlabs --template=plugin --platforms=android,ios -i objc -a kotlin  .