let
  quentin = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID/6Oh5VLHRAzoeiC53hQzGJ3wkSR4qGR7erqlU7fpWp root@quentin";
  trinity = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILoiOewu6EAitM+VjAwZcLvM2jhLn+93dEuTe0oJcSEC root@trinity";
in
{
  "windcphpriv.age".publicKeys = [ quentin ];
  "windcphpreshared.age".publicKeys = [ quentin ];
  "windsingpriv.age".publicKeys = [ quentin ];
  "windsingpreshared.age".publicKeys = [ quentin ];
  "wghomepreshared.age".publicKeys = [ quentin ];
  "wghomepriv.age".publicKeys = [ quentin ];
  "restic_india.age".publicKeys = [ quentin trinity ];
  "restic_dk.age".publicKeys = [ quentin trinity ];
}
