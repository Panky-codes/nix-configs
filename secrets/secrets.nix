let
  quentin = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID/6Oh5VLHRAzoeiC53hQzGJ3wkSR4qGR7erqlU7fpWp root@quentin";
in
{
  "sohowgpriv.age".publicKeys = [ quentin ];
}
