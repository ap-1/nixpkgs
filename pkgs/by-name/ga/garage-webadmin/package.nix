{
  lib,
  buildNpmPackage,
  fetchFromGitea,
  nix-update-script,
}:
buildNpmPackage (finalAttrs: {
  pname = "garage-webadmin";
  version = "0.2.2";

  src = fetchFromGitea {
    domain = "git.deuxfleurs.fr";
    owner = "Deuxfleurs";
    repo = "garage-webadmin";
    tag = "v${finalAttrs.version}";
    hash = "sha256-8Q4Pc1XKXK86kG2o1MAvgdmAzOpzIpq5Kg2iiJIAN2I=";
  };

  npmDepsHash = "sha256-G/ODrxE87F2aS3l0ypLIQC6hvgCFOmm5oo+aQNvJbnc=";

  npmBuildScript = "build:integrated";

  installPhase = ''
    runHook preInstall
    cp -r dist $out
    runHook postInstall
  '';

  passthru.updateScript = nix-update-script { };

  __structuredAttrs = true;

  meta = {
    description = "Web admin UI for Garage";
    changelog = "https://git.deuxfleurs.fr/Deuxfleurs/garage-webadmin/releases/tag/${finalAttrs.src.tag}";
    homepage = "https://git.deuxfleurs.fr/Deuxfleurs/garage-webadmin";
    license = lib.licenses.agpl3Only;
    maintainers = with lib.maintainers; [
      nickcao
      _0x4A6F
      teutat3s
      herbetom
      anish
    ];
  };
  platforms = lib.platforms.linux ++ lib.platforms.darwin;
})
