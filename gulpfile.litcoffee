Новый вариант
==============================
, с использование ds-gulp-builder (https://www.npmjs.com/package/ds-gulp-builder,  https://github.com/delightsoft/DSGulpBuilder)

    {task, async, sync, go, gutil, errorHandler} = require('ds-gulp-builder')(gulp = require('gulp'))

Для gulp-задач, которых нет в ds-gulp-builder подключаем необходимые npm-пакеты

    path = require 'path'
    jade = require 'gulp-jade'
    include = require 'gulp-include'
    changed = require 'gulp-changed'
    (notify = require 'gulp-notify').logger (->)
    rename = require 'gulp-rename'
    uglify = require 'gulp-uglify'

В clearFolders пишем все задачи очистки папок.  Папку ./build чистим сохраняя директорию .git, чтоб не терять
настройки публикации в ветку gh-pages (https://github.com/webprofyru/rms/tree/gh-pages).

    clearFolders = [
      task('clear-build').clearFolder('./build').keep('.git')]

Собираем все задачи в спискок задач

    tasks = []


Файлы для правильной работы GitHub Pages (gh-pages)
------------------------------

    tasks.push task('gh-CNAME').copy('./src/CNAME').dest('./build')
    tasks.push task('gh-nojekyll').copy('./src/.nojekyll').dest('./build')
    tasks.push task('js-copy').copy('./static/*.js').dest('./build')
    tasks.push task('css-copy').copy('./static/*.css').dest('./build')

Основное приложение
------------------------------

JS

    tasks.push task('app-js').browserify('./src/app/app.coffee').dest('./build')

HTML

    tasks.push task('app-html').jade('./src/app').dest('./build')

CSS

    tasks.push task('app-css').sass('./src/sass').dest('./build')

Images

    tasks.push task('app-images').copy('./static/images').dest('./build/images')

Fonts

    # tasks.push task('app-fonts').copy('./static/fonts').dest('./build/fonts')

Data

    # tasks.push task('app-data').copy('./data').dest('./build/data')

browserSync
------------------------------

Чтобы было удобно работать с кодом, мы запускаем browserSync

    browserSync = task('browserSync').browserSync('./build', port: 3000, debug: false)

И всё запускаем :)
------------------------------

    go sync [clearFolders, tasks, browserSync]
