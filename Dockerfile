# Використання образу scratch як базового образу
FROM scratch

# Визначення аргументу APP_NAME та його значення за замовчуванням
# TODO: ваш код

# Створення робочої директорії
# TODO: ваш код

# Копіювання скомпільованої програми до робочої директорії контейнера використовуючи змінну аргументу APP_NAME як вихідне імʼя файлу. В контейнері імʼя файлу повинну бути 'main'
# TODO: ваш код

# Вказати, що контейнер слухатиме на порту 8080
# TODO: ваш код

# Команда для запуску додатку при старті контейнера з робочої директорії
CMD ["./main"]