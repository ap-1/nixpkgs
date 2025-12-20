{ callPackage, fetchMavenArtifact }:

{
  scim-for-keycloak = callPackage ./scim-for-keycloak { };
  scim-keycloak-user-storage-spi = callPackage ./scim-keycloak-user-storage-spi { };
  keycloak-discord = callPackage ./keycloak-discord { };
  keycloak-magic-link = callPackage ./keycloak-magic-link { };
  keycloak-metrics-spi = callPackage ./keycloak-metrics-spi { };
  keycloak-restrict-client-auth = callPackage ./keycloak-restrict-client-auth { };
  keycloak-remember-me-authenticator = callPackage ./keycloak-remember-me-authenticator { };

  # junixsocket provides Unix domain socket support for JDBC connections,
  # which is required for connecting to PostgreSQL via Unix socket.
  junixsocket-common =
    (fetchMavenArtifact {
      groupId = "com.kohlschutter.junixsocket";
      artifactId = "junixsocket-common";
      version = "2.10.1";
      hash = "sha256-GeX3YVrSKT81Mrw/mRsxOWwRYYNOidmmqgx975OcZyk=";
    }).passthru.jar;

  junixsocket-native-common =
    (fetchMavenArtifact {
      groupId = "com.kohlschutter.junixsocket";
      artifactId = "junixsocket-native-common";
      version = "2.10.1";
      hash = "sha256-ASbOC68c61de9ReAfU0rFLnzLwYYAgThLsc6tKdyVno=";
    }).passthru.jar;

  # These could theoretically be used by something other than Keycloak, but
  # there are no other quarkus apps in nixpkgs (as of 2023-08-21)
  quarkus-systemd-notify =
    (fetchMavenArtifact {
      groupId = "io.quarkiverse.systemd.notify";
      artifactId = "quarkus-systemd-notify";
      version = "1.0.1";
      hash = "sha256-3I4j22jyIpokU4kdobkt6cDsALtxYFclA+DV+BqtmLY=";
    }).passthru.jar;

  quarkus-systemd-notify-deployment =
    (fetchMavenArtifact {
      groupId = "io.quarkiverse.systemd.notify";
      artifactId = "quarkus-systemd-notify-deployment";
      version = "1.0.1";
      hash = "sha256-xHxzBxriSd/OU8gEcDG00VRkJYPYJDfAfPh/FkQe+zg=";
    }).passthru.jar;
}
