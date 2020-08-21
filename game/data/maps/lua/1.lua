return {
  version = "1.4",
  luaversion = "5.1",
  tiledversion = "1.4.1",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 40,
  height = 23,
  tilewidth = 32,
  tileheight = 32,
  nextlayerid = 3,
  nextobjectid = 3,
  properties = {
    ["background"] = "menu",
    ["script"] = "start"
  },
  tilesets = {
    {
      name = "tiles",
      firstgid = 1,
      filename = "../tiles.tsx",
      tilewidth = 32,
      tileheight = 32,
      spacing = 1,
      margin = 0,
      columns = 1,
      image = "../../../graphics/game/tiles.png",
      imagewidth = 32,
      imageheight = 32,
      objectalignment = "unspecified",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 32,
        height = 32
      },
      properties = {},
      terrains = {},
      tilecount = 1,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 40,
      height = 23,
      id = 1,
      name = "Tiles",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "base64",
      compression = "zstd",
      data = "KLUv/WBgDX0AABgAAAEDAB2DH3bN3fgHWA=="
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 2,
      name = "Entities",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      objects = {
        {
          id = 2,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 512,
          y = 352,
          width = 256,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["reveal"] = true
          }
        }
      }
    }
  }
}
