return
{
    {"create", {"spawn",  {x = 624, y = 304, width = 16, height = 16}}},
    {"sleep", 8},
    {"flash", {{1, 1, 1}, 4}},
    {"sleep", 4},
    {"unflash", 4},
    {"create", {"player", {x = 624, y = 304, width = 16, height = 16}}},
    {"setplayer"}
}
