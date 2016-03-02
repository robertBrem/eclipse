#!/usr/bin/jjs -fv

installPlugins();
setUpLombok();

function installPlugins() {
  var result = load("eclipseInput.json");

  for(key in result) {
    var command = './eclipse -nosplash -application org.eclipse.equinox.p2.director -repository ' + result[key][0] + ' -installIU ' + result[key][1];
    print(command);
    $EXEC(command)
    print($OUT);
  }
}

function setUpLombok() {
  var envs = $ENV;
  var doLombok = envs['LOMBOK'] == 1
  print('doLombok: ' + doLombok);
  if(doLombok) {
    var downloadCommand = 'curl -O https://projectlombok.org/downloads/lombok.jar'
    var addToEclipseIniCommand = 'echo "-javaagent:/opt/eclipse/lombok.jar" >> eclipse.ini'
    print(downloadCommand);
    $EXEC(downloadCommand);
    print(addToEclipseIniCommand);
    $EXEC(addToEclipseIniCommand);
  }
}
