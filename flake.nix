{
  description = ''Simple plugin implementation'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."pluginmanager-master".dir   = "master";
  inputs."pluginmanager-master".owner = "nim-nix-pkgs";
  inputs."pluginmanager-master".ref   = "master";
  inputs."pluginmanager-master".repo  = "pluginmanager";
  inputs."pluginmanager-master".type  = "github";
  inputs."pluginmanager-master".inputs.nixpkgs.follows = "nixpkgs";
  inputs."pluginmanager-master".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}