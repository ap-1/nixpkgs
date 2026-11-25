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

  # https://github.com/cyyynthia/vite-plugin-magical-svg/pull/35
  preBuild = ''
    substituteInPlace node_modules/vite-plugin-magical-svg/dist/index.js \
      --replace-fail \
        'await transformRefs(asset.xml.svg, async (ref, isFile) => {' \
        'if (asset.xml.svg["#sprite"]) asset.xml.svg.$$.sort((a, b) => a.$.id.localeCompare(b.$.id)); await transformRefs(asset.xml.svg, async (ref, isFile) => {'
  '';

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
      herbetom
      anish
    ];
    platforms = lib.platforms.linux ++ lib.platforms.darwin;
  };
})
