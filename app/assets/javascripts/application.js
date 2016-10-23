// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require chardinjs.min
//= require js.storage.min
//= require bootstrap
//= require theme/custom

// This object will help us calling a callback depending on wether or not
// it has been called before. For this it uses a key, if the key is set
// then the callback will not be called.
NotificationsHelper = (function(){
  var $storage = null;

  function never_called(key){
    return $storage.get(key) === false ||
      $storage.get(key) === undefined ||
      $storage.get(key) == null;
  }

  function init(key, callback){
    $storage = Storages.localStorage;

    // checks if the key is set
    if(never_called(key)){
      callback.call();
      $storage.set(key, true);
    }
  }

  function mami(){
    console.log("que quieres mijo?");
  }

  return {
    init: init,
    mami: mami
  }
})();
