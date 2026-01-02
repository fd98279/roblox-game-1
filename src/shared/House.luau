-- House builder module
local House = {}

function House.create(position)
    position = position or Vector3.new(0, 0, 0)
    
    local houseModel = Instance.new("Model")
    houseModel.Name = "House"
    
    -- Floor
    local floor = Instance.new("Part")
    floor.Name = "Floor"
    floor.Size = Vector3.new(20, 1, 20)
    floor.Position = position + Vector3.new(0, 0.5, 0)
    floor.Anchored = true
    floor.BrickColor = BrickColor.new("Medium stone grey")
    floor.Parent = houseModel
    
    -- Walls
    local function createWall(name, size, offset, color)
        local wall = Instance.new("Part")
        wall.Name = name
        wall.Size = size
        wall.Position = position + offset
        wall.Anchored = true
        wall.BrickColor = BrickColor.new(color or "Bright red")
        wall.Parent = houseModel
        return wall
    end
    
    -- Front wall (with door opening)
    local frontLeft = createWall("FrontWallLeft", Vector3.new(7, 8, 1), Vector3.new(-6.5, 5, -10))
    local frontRight = createWall("FrontWallRight", Vector3.new(7, 8, 1), Vector3.new(6.5, 5, -10))
    local frontTop = createWall("FrontWallTop", Vector3.new(6, 3, 1), Vector3.new(0, 9.5, -10))
    
    -- Back wall
    createWall("BackWall", Vector3.new(20, 8, 1), Vector3.new(0, 5, 10))
    
    -- Left wall
    createWall("LeftWall", Vector3.new(1, 8, 20), Vector3.new(-10, 5, 0))
    
    -- Right wall
    createWall("RightWall", Vector3.new(1, 8, 20), Vector3.new(10, 5, 0))
    
    -- Roof
    local function createRoofPart(offset)
        local roofPart = Instance.new("WedgePart")
        roofPart.Size = Vector3.new(1, 8, 22)
        roofPart.Position = position + offset
        roofPart.Anchored = true
        roofPart.BrickColor = BrickColor.new("Dark orange")
        roofPart.Parent = houseModel
        return roofPart
    end
    
    local roofLeft = createRoofPart(Vector3.new(-6, 13, 0))
    roofLeft.Orientation = Vector3.new(0, 90, -45)
    
    local roofRight = createRoofPart(Vector3.new(6, 13, 0))
    roofRight.Orientation = Vector3.new(0, -90, 45)
    
    -- Windows
    local function createWindow(offset)
        local window = Instance.new("Part")
        window.Name = "Window"
        window.Size = Vector3.new(3, 3, 0.2)
        window.Position = position + offset
        window.Anchored = true
        window.BrickColor = BrickColor.new("Light blue")
        window.Material = Enum.Material.Glass
        window.Transparency = 0.5
        window.Parent = houseModel
    end
    
    createWindow(Vector3.new(-6, 5, -10.4))  -- Front left window
    createWindow(Vector3.new(6, 5, -10.4))   -- Front right window
    createWindow(Vector3.new(-10.4, 5, -5))  -- Left wall window
    createWindow(Vector3.new(10.4, 5, -5))   -- Right wall window
    
    -- Door
    local door = Instance.new("Part")
    door.Name = "Door"
    door.Size = Vector3.new(4, 5, 0.2)
    door.Position = position + Vector3.new(0, 3.5, -10.4)
    door.Anchored = true
    door.BrickColor = BrickColor.new("CGA brown")
    door.Parent = houseModel
    
    return houseModel
end

return House
