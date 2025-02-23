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
    x86_64-linux = "0adsib4f4fp7kg0lpwp1bsih2mrid5vb8n93yqvq463lgmbfsrfr";
    armv6l-linux = "1mvf51pggb2kdqw55xk06hiz2vifwgpzbr8jw7kmpysmsb13i0y0";
    aarch64-linux = "0fdrxj9ry6f6i1rygv7l75758cv3n38q8nc9hy0xr9h22spjdaa6";
    x86_64-darwin = "11yrvsmhrbvr063kr3rjsvjbix7pqf72jbfxws3j6krkxgcgw6ia";
    aarch64-darwin = "0chy08gprc3pdvi6i3fdv6idyix8hdfx9p48bhbd3skkn5n4193x";
  };

  urlMap = {
    x86_64-linux = "https://github.com/mach-composer/mach-composer-cli/releases/download/v2.21.4/mach-composer-2.21.4-linux-amd64.tar.gz";
    armv6l-linux = "https://github.com/mach-composer/mach-composer-cli/releases/download/v2.21.4/mach-composer-2.21.4-linux-armv6.tar.gz";
    aarch64-linux = "https://github.com/mach-composer/mach-composer-cli/releases/download/v2.21.4/mach-composer-2.21.4-linux-arm64.tar.gz";
    x86_64-darwin = "https://github.com/mach-composer/mach-composer-cli/releases/download/v2.21.4/mach-composer-2.21.4-darwin-amd64.tar.gz";
    aarch64-darwin = "https://github.com/mach-composer/mach-composer-cli/releases/download/v2.21.4/mach-composer-2.21.4-darwin-arm64.tar.gz";
  };
in
stdenvNoCC.mkDerivation {
  pname = "mach-composer";
  version = "2.21.4";
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
