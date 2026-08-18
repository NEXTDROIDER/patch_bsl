# Инструкция по патчу клиента BSL (Brawl Stars Server Emulator)

Скрипт для автоматического патча клиента приватного сервера Brawl Stars от разработчика LkPrtctrd (актуальная версия сервера: [BSL.v68 на GitHub](https://github.com/LkPrtctrd/BSL.v68)).

### Зависимости
Перед запуском скрипта убедитесь, что у вас установлены:
* **Java (JDK)** — необходима для работы инструментов сборки. Скачать актуальную версию для Windows можно [здесь]([https://githubusercontent.com](https://release-assets.githubusercontent.com/github-production-release-asset/901810329/9fc13c14-cf6f-469f-b070-b539e8bd5ef0?sp=r&sv=2018-11-09&sr=b&spr=https&se=2026-08-18T08%3A06%3A40Z&rscd=attachment%3B+filename%3DOpenJDK25U-jdk_x64_windows_hotspot_25.0.4_7.msi&rsct=application%2Foctet-stream&skoid=96c2d410-5711-43a1-aedd-ab1947aa7ab0&sktid=398a6654-997b-47e9-b12b-9515b896b4de&skt=2026-08-18T07%3A06%3A39Z&ske=2026-08-18T08%3A06%3A40Z&sks=b&skv=2018-11-09&sig=HV0LsVtMCmYuKfJbAdkhSOUZz8B1ACHd6G9k8phZd3E%3D&jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmVsZWFzZS1hc3NldHMuZ2l0aHVidXNlcmNvbnRlbnQuY29tIiwia2V5Ijoia2V5MSIsImV4cCI6MTc4NzA0MTExOCwibmJmIjoxNzg3MDM3NTE4LCJwYXRoIjoicmVsZWFzZWFzc2V0cHJvZHVjdGlvbi5ibG9iLmNvcmUud2luZG93cy5uZXQifQ.1Y1P91e2DCDuKEMjO3mJDLPACPz224jYYoWVVlO3LDA&response-content-disposition=attachment%3B%20filename%3DOpenJDK25U-jdk_x64_windows_hotspot_25.0.4_7.msi&response-content-type=application%2Foctet-stream)).
* **Apktool** — утилита для декомпиляции и сборки APK-файлов.

### Подготовка оригинального файла
1. Скачайте базовый APK-файл весом 1.11 ГБ по ссылке: [Скачать с MEGA](https://mega.nz/file/rNFSwa7A#TBNCCfyVG3xUkykvnQhM77qlu63wvzGpG5W1bGjR1As).
2. Переименуйте скачанный файл в `client.apk` и положите его в корневую папку со скриптом патча.

### Инструкция по запуску

#### Для Linux / macOS:
Откройте терминал в папке со скриптом, выдайте права на исполнение и запустите его:
```bash
chmod +x patch.sh && ./patch.sh
```


#### Для Windows:
Откройте командную строку (CMD) или PowerShell в папке со скриптом и выполните:
```powershell
.\patch.bat
```

