#!/usr/bin/jjs -fv

init();

function init() {
  var result = load("eclipseInput.json");

  for(key in result) {
    var command = './eclipse -nosplash -application org.eclipse.equinox.p2.director -repository ' + result[key][0] + ' -installIU ' + result[key][1];
    print(command);
    $EXEC(command)
    print($OUT);
  }
}
