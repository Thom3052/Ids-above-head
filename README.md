# IDs Above Head

This script displays player IDs above their heads in a FiveM server when you press the **Z key**. Below you will find instructions for installation and configuration.

## Installation

1. Place the folder **`idsabovehead`** in the `resources` folder of your FiveM server.
2. Add the following line to your `server.cfg` to start the resource:á
   ```
   ensure idsabovehead
   ```

## Configuration

The configuration of the script is located in the `client.lua` file. Below are the main settings explained:

### 1. **Toggle Key**
The key used to toggle the display of IDs is set in the `config` table. By default, this is the **Z key** (keycode `20`).

```lua
local config = {
    toggleKey = 20 -- Default Z key (keycode 20)
}
```

#### Adjust:
- Look up the keycode of your desired key in the [FiveM Key Mapping Reference](https://docs.fivem.net/docs/game-references/controls/).
- Replace `20` with the keycode of your desired key.

### 2. **Maximum Distance for IDs**
The maximum distance at which IDs are visible is set with the variable `disPlayerNames`. By default, this is `20` meters.

```lua
local disPlayerNames = 20
```

#### Adjust:
- Change the value `20` to your desired maximum distance in meters.

### 3. **Colors of the IDs**
The colors of the IDs are set in the `DrawText3D` function. By default:
- **Talking players**: Orange (`247, 124, 24`)
- **Non-talking players**: White (`255, 255, 255`)

```lua
DrawText3D(targetPedCords, GetPlayerServerId(id), 247, 124, 24) -- Orange
DrawText3D(targetPedCords, GetPlayerServerId(id), 255, 255, 255) -- White
```

#### Adjust:
- Change the RGB values to your desired color. Use an [RGB color picker](https://www.w3schools.com/colors/colors_picker.asp) to find the correct values.

### 4. **Marker Under Talking Players**
A marker is displayed under talking players. You can adjust the color and size of this marker in the following line:

```lua
DrawMarker(27, targetPedCords.x, targetPedCords.y, targetPedCords.z - 0.97, 0, 0, 0, 0, 0, 0, 1.001, 1.0001, 0.5001, 173, 216, 230, 100, 0, 0, 0, 0)
```

#### Adjust:
- **Color**: Change the RGB values (`173, 216, 230`).
- **Size**: Adjust the scale values (`1.001, 1.0001, 0.5001`).

## Usage

- Press the configured key (default **Z**) to display player IDs.
- Release the key to hide the IDs.

## Support

For questions or issues, you can contact the author: **Thom Walnoot**.

You can also join my **[Discord server](https://discord.gg/KBvNkunj)** for support. The server is in Dutch, but if you create a ticket, I can provide support in English.
