{ pkgs
}:

with pkgs;

mkShell {
  packages = [
    bc
    clang-tools
    bear
    ssmem
    sspfd
    raplread
  ];
}
