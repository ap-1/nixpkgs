{
  maven,
  lib,
  stdenv,
  fetchFromGitHub,
}:
maven.buildMavenPackage rec {
  pname = "keycloak-discord";
  version = "0.6.1";

  src = fetchFromGitHub {
    owner = "wadahiro";
    repo = "keycloak-discord";
    rev = "v${version}";
    hash = "sha256-BA7x28k/aMI3VPQmEgNhKD9N34DdYqadAD/m4cxLSYg=";
  };

  mvnHash =
    if stdenv.hostPlatform.isDarwin then
      "sha256-Or7VOZwz4NfDtb0kmHbbTYE/avAc+H8+Y6JPw+HGjxs="
    else
      "sha256-uhm++MGgTN32/xbHNd+Z3Hes9Q5tl8ztIQ92LxMWKjg=";

  installPhase = ''
    runHook preInstall
    install -Dm444 target/keycloak-discord-${version}.jar "$out/keycloak-discord-${version}.jar"
    runHook postInstall
  '';

  meta = {
    homepage = "https://github.com/wadahiro/keycloak-discord";
    description = "Keycloak Identity Provider extension for Discord";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [
      mkg20001
      anish
    ];
  };
}
