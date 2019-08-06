
function initThemeChooser(settings) {
  var isInitialized = false;
  var $currentStylesheet = $();
  var $loading = $('#loading');

  setThemeSystem($systemSelect.val());


  function setThemeSystem(themeSystem) {
    setTheme(themeSystem, 'minty');
  }


  function setTheme(themeSystem, themeName) {
    var stylesheetUrl = '../bootstrap/css/bootstrap-minty.min.css';
    var $stylesheet;

    function done() {
      if (!isInitialized) {
        isInitialized = true;
        settings.init(themeSystem);
      }
      else {
        settings.change(themeSystem);
      }

    }

    if (stylesheetUrl) {
      $stylesheet = $('<link rel="stylesheet" type="text/css" href="' + stylesheetUrl + '"/>').appendTo('head');
      $loading.show();

      whenStylesheetLoaded($stylesheet[0], function() {
        $currentStylesheet.remove();
        $currentStylesheet = $stylesheet;
        $loading.hide();
        done();
      });
    } else {
      $currentStylesheet.remove();
      $currentStylesheet = $();
      done();
    }
  }

  function whenStylesheetLoaded(linkNode, callback) {
    var isReady = false;

    function ready() {
      if (!isReady) { // avoid double-call
        isReady = true;
        callback();
      }
    }

    linkNode.onload = ready; // does not work cross-browser
    setTimeout(ready, 2000); // max wait. also handles browsers that don't support onload
  }
}
