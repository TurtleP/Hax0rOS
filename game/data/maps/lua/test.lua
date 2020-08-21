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
  nextobjectid = 6,
  properties = {
    ["matrix"] = true
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
      name = "Tile Layer 1",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "base64",
      compression = "zstd",
      data = "KLUv/WBgDd0CAFgBAAAAAQEBAQEBACigoK8A4IKaMR6ZRRUfqXLTT0ggjMxVucW4SRbENY+SIqAXc7IC6wqJSDkXsxzYZUeigINHrONu0CdpxPyvWy+4QJeJ1pLwI1WllO5M5R8="
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 2,
      name = "Object Layer 1",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      objects = {
        {
          id = 1,
          name = "player",
          type = "",
          shape = "rectangle",
          x = 608,
          y = 320,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 32,
          y = 0,
          width = 1216,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 32,
          y = 704,
          width = 1216,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 32,
          height = 736,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "tile",
          type = "",
          shape = "rectangle",
          x = 1248,
          y = 0,
          width = 32,
          height = 736,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
