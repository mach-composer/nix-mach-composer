# This file was generated by GoReleaser. DO NOT EDIT.
# vim: set ft=nix ts=2 sw=2 sts=2 et sta
{
system ? builtins.currentSystem
, lib
, fetchurl
, installShellFiles
, stdenvNoCC
, git
, terraform
, makeWrapper
}:
let
  shaMap = {
    x86_64-linux = "17rybcfmhvh1gl3zx27h5hjbl4qyhjlvqj3s821pfna77qvpi981";
    armv6l-linux = "1q61sxg180fm3qjp30rxi6s1cpxq12kja39hxs562wyjb15rcbqw";
    aarch64-linux = "032nhrlnqgnbdhhy0fbhsq61ixwxxj9kw7iqcwr17rjbianzpvbv";
    x86_64-darwin = "07jzvl6qayx09jdkn6q82xwhh48bjawi2ckf3vrxmnl7xayr1ali";
    aarch64-darwin = "0mvp4rfb2pqs8ikjn5mxd6sldgwfhlnkav1f3y1z6dc87lp5q2qm";
  };

  urlMap = {
    x86_64-linux = "https://github.com/mach-composer/mach-composer-cli/releases/download/v2.24.1/mach-composer-2.24.1-linux-amd64.tar.gz";
    armv6l-linux = "https://github.com/mach-composer/mach-composer-cli/releases/download/v2.24.1/mach-composer-2.24.1-linux-armv6.tar.gz";
    aarch64-linux = "https://github.com/mach-composer/mach-composer-cli/releases/download/v2.24.1/mach-composer-2.24.1-linux-arm64.tar.gz";
    x86_64-darwin = "https://github.com/mach-composer/mach-composer-cli/releases/download/v2.24.1/mach-composer-2.24.1-darwin-amd64.tar.gz";
    aarch64-darwin = "https://github.com/mach-composer/mach-composer-cli/releases/download/v2.24.1/mach-composer-2.24.1-darwin-arm64.tar.gz";
  };
in
stdenvNoCC.mkDerivation {
  pname = "mach-composer";
  version = "2.24.1";
  src = fetchurl {
    url = urlMap.${system};
    sha256 = shaMap.${system};
  };

  sourceRoot = ".";

  nativeBuildInputs = [ installShellFiles makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin
    cp -vr ./bin/mach-composer $out/bin/mach-composer
    wrapProgram $out/bin/mach-composer --prefix PATH : ${lib.makeBinPath ([ git terraform ])}
  '';
  postInstall = ''
    installShellCompletion --cmd mach-composer \
    --bash <($out/bin/mach-composer completion bash) \
    --fish <($out/bin/mach-composer completion fish) \
    --zsh <($out/bin/mach-composer completion zsh)
  '';

  system = system;

  meta = {
    description = "Orchestration tool for modern MACH ecosystems, powered by Terraform infrastructure-as-code underneath";
    homepage = "https://www.machcomposer.io/";
    license = lib.licenses.mit;

    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];

    platforms = [
      "aarch64-darwin"
      "aarch64-linux"
      "armv6l-linux"
      "x86_64-darwin"
      "x86_64-linux"
    ];
  };
}
