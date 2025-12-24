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
    let
      platform = stdenv.hostPlatform;
      key =
        if platform.isDarwin && platform.isAarch64 then
          "aarch64-darwin"
        else if platform.isDarwin && platform.isx86_64 then
          "x86_64-darwin"
        else if platform.isLinux && platform.isAarch64 then
          "aarch64-linux"
        else if platform.isLinux && platform.isx86_64 then
          "x86_64-linux"
        else
          throw "unsupported platform: ${platform.system}";
    in
    {
      aarch64-darwin = "sha256-Or7VOZwz4NfDtb0kmHbbTYE/avAc+H8+Y6JPw+HGjxs=";
      x86_64-darwin = lib.fakeHash;
      aarch64-linux = "sha256-I5qjhfAXPXMb+1SPG29t/IKH/zBQqdnu3U7dYSQhTL8=";
      x86_64-linux = "sha256-uhm++MGgTN32/xbHNd+Z3Hes9Q5tl8ztIQ92LxMWKjg=";
    }
    .${key};

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
