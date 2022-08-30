{ configuration
, robotnixPath ? ./robotnix.nix
, robotnix ? import robotnixPath
}:
robotnix { inherit configuration; }
