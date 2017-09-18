var gulp = require('gulp');
var elm = require('gulp-elm');
var nodemon = require('gulp-nodemon');
var livereload = require('gulp-livereload');
var sass = require('gulp-sass');

gulp.task('elm-init', elm.init);

gulp.task('elm', ['elm-init'], function(){
  return gulp.src('src/front/*.elm')
    .pipe(elm.bundle('bundle.js'))
    .pipe(gulp.dest('dist/'))
    .pipe(livereload());
});

gulp.task('styles', () => {
  return gulp.src('src/front/styles/*.scss')
    .pipe(sass().on('error', sass.logError))
    .pipe(gulp.dest('dist/css'));
});

gulp.task('build', ['elm', 'styles']);

gulp.task('server', () => {
  nodemon({
    'script': 'server.js',
    'ignore': ['src/front/*', 'dist/*']
  });
});

gulp.task('watch', () => {
  livereload.listen();
  gulp.watch('src/front/*.elm', ['elm']);
  gulp.watch('src/front/**/*.scss', ['styles']);
});

gulp.task('default', ['build', 'server', 'watch']);
