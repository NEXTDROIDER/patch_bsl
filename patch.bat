@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul

:: --- НАСТРОЙКИ ---
set "APK_NAME=client.apk"
set "OUTPUT_APK=client_patched.apk"
set "TEMP_DIR=temp_apk"
set "CONFIG_PATH=%TEMP_DIR%\lib\arm64-v8a\libBSL.c.so"
set "OLD_IP=127.0.0.1"
:: -----------------

del /f /q "%OUTPUT_APK%"

echo [1/4] Поиск локального IP-адреса ПК...
set "PC_IP="
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /i "IPv4"') do (
    if not defined PC_IP (
        set "temp_ip=%%a"
        set "temp_ip=!temp_ip: =!"
        set "PC_IP=!temp_ip!"
    )
)

if not defined PC_IP (
    echo [ОШИБКА] Не удалось автоматически определить IP-адрес ПК.
    pause
    exit /b
)
echo Ваш IP-адрес: !PC_IP!

if not exist "%APK_NAME%" (
    echo [ОШИБКА] Файл %APK_NAME% не найден в текущей папке.
    pause
    exit /b
)

if not exist "apktool.jar" (
    echo [ОШИБКА] Утилита apktool.jar не найдена в текущей папке.
    pause
    exit /b
)

echo [2/4] Декомпиляция APK через Apktool (это может занять время)...
if exist "%TEMP_DIR%" rmdir /s /q "%TEMP_DIR%"
"C:\Program Files\Eclipse Adoptium\jdk-25.0.4.7-hotspot\bin\javaw.exe" -jar apktool.jar d "%APK_NAME%" -o "%TEMP_DIR%" --no-src

if not exist "%CONFIG_PATH%" (
    echo [ОШИБКА] Файл конфигурации не найден по пути: %CONFIG_PATH%
    rmdir /s /q "%TEMP_DIR%"
    pause
    exit /b
)

echo [3/4] Модификация IP-адреса на !PC_IP!...
powershell -Command "$path='%CONFIG_PATH%'; $text=[System.IO.File]::ReadAllText($path); $newText=$text.Replace('%OLD_IP%', '%PC_IP%'); [System.IO.File]::WriteAllText($path, $newText)"

echo [4/4] Сборка модифицированного APK обратно...
if exist "%OUTPUT_APK%" del /f /q "%OUTPUT_APK%"
"C:\Program Files\Eclipse Adoptium\jdk-25.0.4.7-hotspot\bin\javaw.exe" -jar apktool.jar b "%TEMP_DIR%" -o "%OUTPUT_APK%"

echo Очистка временных папок...
rmdir /s /q "%TEMP_DIR%"

echo ===================================================
echo [УСПЕХ] Новый файл %OUTPUT_APK% успешно создан!
echo IP изменен на !PC_IP!
echo ===================================================
pause
