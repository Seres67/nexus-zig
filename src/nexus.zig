const std = @import("std");

pub const HWND = std.os.windows.HWND;
pub const UINT = std.os.windows.UINT;
pub const WPARAM = std.os.windows.WPARAM;
pub const LPARAM = std.os.windows.LPARAM;
pub const LPVOID = std.os.windows.LPVOID;
pub const HMODULE = std.os.windows.HMODULE;
pub const LRESULT = std.os.windows.LRESULT;
pub const BOOL = std.os.windows.BOOL;
pub const DWORD = std.os.windows.DWORD;

pub const AddonVersion = extern struct {
    Major: i16 = 0,
    Minor: i16 = 0,
    Build: i16 = 0,
    Revision: i16 = 0,
};

pub const ELogLevel = enum(c_int) { Off, Critical, Warning, Info, Debug, Trace, All };
pub const LOGGER_LOG2 = ?*const fn (ELogLevel, [*c]const u8, [*c]const u8) callconv(.C) void;

pub const RenderType = enum(c_int) { PreRender, Render, PostRender, OptionsRender };
pub const RenderCallback = *const fn () callconv(.C) void;
pub const RegisterRenderFn = *const fn (RenderType, RenderCallback) callconv(.C) void;
pub const UnregisterRenderFn = *const fn (RenderCallback) callconv(.C) void;
pub const RendererInterface = extern struct {
    register: ?RegisterRenderFn = null,
    unregister: ?UnregisterRenderFn = null,
};

pub const UPDATER_REQUESTUPDATE = ?*const fn (c_int, [*c]const u8) callconv(.C) void;

pub const ALERTS_NOTIFY = ?*const fn ([*c]const u8) callconv(.C) void;
pub const GUI_REGISTERCLOSEONESCAPE = ?*const fn ([*c]const u8, [*c]bool) callconv(.C) void;
pub const GUI_DEREGISTERCLOSEONESCAPE = ?*const fn ([*c]const u8) callconv(.C) void;
pub const UIVT = extern struct {
    SendAlert: ALERTS_NOTIFY = std.mem.zeroes(ALERTS_NOTIFY),
    RegisterCloseOnEscape: GUI_REGISTERCLOSEONESCAPE = std.mem.zeroes(GUI_REGISTERCLOSEONESCAPE),
    DeregisterCloseOnEscape: GUI_DEREGISTERCLOSEONESCAPE = std.mem.zeroes(GUI_DEREGISTERCLOSEONESCAPE),
};

pub const PATHS_GETGAMEDIR = ?*const fn () callconv(.C) [*c]const u8;
pub const PATHS_GETADDONDIR = ?*const fn ([*c]const u8) callconv(.C) [*c]const u8;
pub const PATHS_GETCOMMONDIR = ?*const fn () callconv(.C) [*c]const u8;
pub const PathsVT = extern struct {
    GetGameDirectory: PATHS_GETGAMEDIR = std.mem.zeroes(PATHS_GETGAMEDIR),
    GetAddonDirectory: PATHS_GETADDONDIR = std.mem.zeroes(PATHS_GETADDONDIR),
    GetCommonDirectory: PATHS_GETCOMMONDIR = std.mem.zeroes(PATHS_GETCOMMONDIR),
};
pub const EMHStatus = enum(c_int) {
    UNKNOWN,
    OK,
    MH_ERROR_ALREADY_INITIALIZED,
    MH_ERROR_NOT_INITIALIZED,
    MH_ERROR_ALREADY_CREATED,
    MH_ERROR_NOT_CREATED,
    MH_ERROR_ENABLED,
    MH_ERROR_DISABLED,
    MH_ERROR_NOT_EXECUTABLE,
    MH_ERROR_UNSUPPORTED_FUNCTION,
    MH_ERROR_MEMORY_ALLOC,
    MH_ERROR_MEMORY_PROTECT,
    MH_ERROR_MODULE_NOT_FOUND,
    MH_ERROR_FUNCTION_NOT_FOUND,
};
pub const MINHOOK_CREATE = ?*const fn (LPVOID, LPVOID, [*c]LPVOID) callconv(.C) EMHStatus;
pub const MINHOOK_REMOVE = ?*const fn (LPVOID) callconv(.C) EMHStatus;
pub const MINHOOK_ENABLE = ?*const fn (LPVOID) callconv(.C) EMHStatus;
pub const MINHOOK_DISABLE = ?*const fn (LPVOID) callconv(.C) EMHStatus;
pub const MinHookVT = extern struct {
    Create: MINHOOK_CREATE = std.mem.zeroes(MINHOOK_CREATE),
    Remove: MINHOOK_REMOVE = std.mem.zeroes(MINHOOK_REMOVE),
    Enable: MINHOOK_ENABLE = std.mem.zeroes(MINHOOK_ENABLE),
    Disable: MINHOOK_DISABLE = std.mem.zeroes(MINHOOK_DISABLE),
};
pub const EVENTS_RAISE = ?*const fn ([*c]const u8, ?*anyopaque) callconv(.C) void;
pub const EVENTS_RAISENOTIFICATION = ?*const fn ([*c]const u8) callconv(.C) void;
pub const EVENTS_RAISE_TARGETED = ?*const fn (c_int, [*c]const u8, ?*anyopaque) callconv(.C) void;
pub const EVENTS_RAISENOTIFICATION_TARGETED = ?*const fn (c_int, [*c]const u8) callconv(.C) void;
pub const EVENT_CONSUME = ?*const fn (?*anyopaque) callconv(.C) void;
pub const EVENTS_SUBSCRIBE = ?*const fn ([*c]const u8, EVENT_CONSUME) callconv(.C) void;
pub const EventsVT = extern struct {
    Raise: EVENTS_RAISE = std.mem.zeroes(EVENTS_RAISE),
    RaiseNotification: EVENTS_RAISENOTIFICATION = std.mem.zeroes(EVENTS_RAISENOTIFICATION),
    RaiseTargeted: EVENTS_RAISE_TARGETED = std.mem.zeroes(EVENTS_RAISE_TARGETED),
    RaiseNotificationTargeted: EVENTS_RAISENOTIFICATION_TARGETED = std.mem.zeroes(EVENTS_RAISENOTIFICATION_TARGETED),
    Subscribe: EVENTS_SUBSCRIBE = std.mem.zeroes(EVENTS_SUBSCRIBE),
    Unsubscribe: EVENTS_SUBSCRIBE = std.mem.zeroes(EVENTS_SUBSCRIBE),
};
pub const WNDPROC_CALLBACK = ?*const fn (HWND, UINT, WPARAM, LPARAM) callconv(.C) UINT;
pub const WNDPROC_ADDREM = ?*const fn (WNDPROC_CALLBACK) callconv(.C) void;
pub const WNDPROC_SENDTOGAME = ?*const fn (HWND, UINT, WPARAM, LPARAM) callconv(.C) LRESULT;
pub const WndProcVT = extern struct {
    Register: WNDPROC_ADDREM = std.mem.zeroes(WNDPROC_ADDREM),
    Deregister: WNDPROC_ADDREM = std.mem.zeroes(WNDPROC_ADDREM),
    SendToGameOnly: WNDPROC_SENDTOGAME = std.mem.zeroes(WNDPROC_SENDTOGAME),
};
pub const KEYBINDS_INVOKE = ?*const fn ([*c]const u8, bool) callconv(.C) void;
pub const KEYBINDS_PROCESS = ?*const fn ([*c]const u8, bool) callconv(.C) void;
pub const KEYBINDS_REGISTERWITHSTRING = ?*const fn ([*c]const u8, KEYBINDS_PROCESS, [*c]const u8) callconv(.C) void;
pub const Keybind = extern struct {
    Key: c_ushort = std.mem.zeroes(c_ushort),
    Alt: bool = std.mem.zeroes(bool),
    Ctrl: bool = std.mem.zeroes(bool),
    Shift: bool = std.mem.zeroes(bool),
};
pub const KEYBINDS_REGISTERWITHSTRUCT = ?*const fn ([*c]const u8, KEYBINDS_PROCESS, Keybind) callconv(.C) void;
pub const KEYBINDS_DEREGISTER = ?*const fn ([*c]const u8) callconv(.C) void;
pub const InputBindsVT = extern struct {
    Invoke: KEYBINDS_INVOKE = std.mem.zeroes(KEYBINDS_INVOKE),
    RegisterWithString: KEYBINDS_REGISTERWITHSTRING = std.mem.zeroes(KEYBINDS_REGISTERWITHSTRING),
    RegisterWithStruct: KEYBINDS_REGISTERWITHSTRUCT = std.mem.zeroes(KEYBINDS_REGISTERWITHSTRUCT),
    Deregister: KEYBINDS_DEREGISTER = std.mem.zeroes(KEYBINDS_DEREGISTER),
};
pub const EGameBinds = enum(c_int) {
    EGameBinds_MoveForward = 0,
    EGameBinds_MoveBackward = 1,
    EGameBinds_MoveLeft = 2,
    EGameBinds_MoveRight = 3,
    EGameBinds_MoveTurnLeft = 4,
    EGameBinds_MoveTurnRight = 5,
    EGameBinds_MoveDodge = 6,
    EGameBinds_MoveAutoRun = 7,
    EGameBinds_MoveWalk = 8,
    EGameBinds_MoveJump_SwimUp_FlyUp = 9,
    EGameBinds_MoveSwimDown_FlyDown = 11,
    EGameBinds_MoveAboutFace = 12,
    EGameBinds_SkillWeaponSwap = 17,
    EGameBinds_SkillWeapon1 = 18,
    EGameBinds_SkillWeapon2 = 19,
    EGameBinds_SkillWeapon3 = 20,
    EGameBinds_SkillWeapon4 = 21,
    EGameBinds_SkillWeapon5 = 22,
    EGameBinds_SkillHeal = 23,
    EGameBinds_SkillUtility1 = 24,
    EGameBinds_SkillUtility2 = 25,
    EGameBinds_SkillUtility3 = 26,
    EGameBinds_SkillElite = 27,
    EGameBinds_SkillProfession1 = 28,
    EGameBinds_SkillProfession2 = 29,
    EGameBinds_SkillProfession3 = 30,
    EGameBinds_SkillProfession4 = 31,
    EGameBinds_SkillProfession5 = 79,
    EGameBinds_SkillProfession6 = 201,
    EGameBinds_SkillProfession7 = 202,
    EGameBinds_SkillSpecialAction = 82,
    EGameBinds_TargetAlert = 131,
    EGameBinds_TargetCall = 32,
    EGameBinds_TargetTake = 33,
    EGameBinds_TargetCallLocal = 199,
    EGameBinds_TargetTakeLocal = 200,
    EGameBinds_TargetEnemyNearest = 34,
    EGameBinds_TargetEnemyNext = 35,
    EGameBinds_TargetEnemyPrev = 36,
    EGameBinds_TargetAllyNearest = 37,
    EGameBinds_TargetAllyNext = 38,
    EGameBinds_TargetAllyPrev = 39,
    EGameBinds_TargetLock = 40,
    EGameBinds_TargetSnapGroundTarget = 80,
    EGameBinds_TargetSnapGroundTargetToggle = 115,
    EGameBinds_TargetAutoTargetingDisable = 116,
    EGameBinds_TargetAutoTargetingToggle = 117,
    EGameBinds_TargetAllyTargetingMode = 197,
    EGameBinds_TargetAllyTargetingModeToggle = 198,
    EGameBinds_UiCommerce = 41,
    EGameBinds_UiContacts = 42,
    EGameBinds_UiGuild = 43,
    EGameBinds_UiHero = 44,
    EGameBinds_UiInventory = 45,
    EGameBinds_UiKennel = 46,
    EGameBinds_UiLogout = 47,
    EGameBinds_UiMail = 71,
    EGameBinds_UiOptions = 48,
    EGameBinds_UiParty = 49,
    EGameBinds_UiPvp = 73,
    EGameBinds_UiPvpBuild = 75,
    EGameBinds_UiScoreboard = 50,
    EGameBinds_UiSeasonalObjectivesShop = 209,
    EGameBinds_UiInformation = 51,
    EGameBinds_UiChatToggle = 70,
    EGameBinds_UiChatCommand = 52,
    EGameBinds_UiChatFocus = 53,
    EGameBinds_UiChatReply = 54,
    EGameBinds_UiToggle = 55,
    EGameBinds_UiSquadBroadcastChatToggle = 85,
    EGameBinds_UiSquadBroadcastChatCommand = 83,
    EGameBinds_UiSquadBroadcastChatFocus = 84,
    EGameBinds_CameraFree = 13,
    EGameBinds_CameraZoomIn = 14,
    EGameBinds_CameraZoomOut = 15,
    EGameBinds_CameraReverse = 16,
    EGameBinds_CameraActionMode = 78,
    EGameBinds_CameraActionModeDisable = 114,
    EGameBinds_ScreenshotNormal = 56,
    EGameBinds_ScreenshotStereoscopic = 57,
    EGameBinds_MapToggle = 59,
    EGameBinds_MapFocusPlayer = 60,
    EGameBinds_MapFloorDown = 61,
    EGameBinds_MapFloorUp = 62,
    EGameBinds_MapZoomIn = 63,
    EGameBinds_MapZoomOut = 64,
    EGameBinds_SpumoniToggle = 152,
    EGameBinds_SpumoniMovement = 130,
    EGameBinds_SpumoniSecondaryMovement = 153,
    EGameBinds_SpumoniMAM01 = 155,
    EGameBinds_SpumoniMAM02 = 156,
    EGameBinds_SpumoniMAM03 = 157,
    EGameBinds_SpumoniMAM04 = 158,
    EGameBinds_SpumoniMAM05 = 159,
    EGameBinds_SpumoniMAM06 = 161,
    EGameBinds_SpumoniMAM07 = 169,
    EGameBinds_SpumoniMAM08 = 170,
    EGameBinds_SpumoniMAM09 = 203,
    EGameBinds_SpectatorNearestFixed = 102,
    EGameBinds_SpectatorNearestPlayer = 103,
    EGameBinds_SpectatorPlayerRed1 = 104,
    EGameBinds_SpectatorPlayerRed2 = 105,
    EGameBinds_SpectatorPlayerRed3 = 106,
    EGameBinds_SpectatorPlayerRed4 = 107,
    EGameBinds_SpectatorPlayerRed5 = 108,
    EGameBinds_SpectatorPlayerBlue1 = 109,
    EGameBinds_SpectatorPlayerBlue2 = 110,
    EGameBinds_SpectatorPlayerBlue3 = 111,
    EGameBinds_SpectatorPlayerBlue4 = 112,
    EGameBinds_SpectatorPlayerBlue5 = 113,
    EGameBinds_SpectatorFreeCamera = 120,
    EGameBinds_SpectatorFreeCameraMode = 127,
    EGameBinds_SpectatorFreeMoveForward = 121,
    EGameBinds_SpectatorFreeMoveBackward = 122,
    EGameBinds_SpectatorFreeMoveLeft = 123,
    EGameBinds_SpectatorFreeMoveRight = 124,
    EGameBinds_SpectatorFreeMoveUp = 125,
    EGameBinds_SpectatorFreeMoveDown = 126,
    EGameBinds_SquadMarkerPlaceWorld1 = 86,
    EGameBinds_SquadMarkerPlaceWorld2 = 87,
    EGameBinds_SquadMarkerPlaceWorld3 = 88,
    EGameBinds_SquadMarkerPlaceWorld4 = 89,
    EGameBinds_SquadMarkerPlaceWorld5 = 90,
    EGameBinds_SquadMarkerPlaceWorld6 = 91,
    EGameBinds_SquadMarkerPlaceWorld7 = 92,
    EGameBinds_SquadMarkerPlaceWorld8 = 93,
    EGameBinds_SquadMarkerClearAllWorld = 119,
    EGameBinds_SquadMarkerSetAgent1 = 94,
    EGameBinds_SquadMarkerSetAgent2 = 95,
    EGameBinds_SquadMarkerSetAgent3 = 96,
    EGameBinds_SquadMarkerSetAgent4 = 97,
    EGameBinds_SquadMarkerSetAgent5 = 98,
    EGameBinds_SquadMarkerSetAgent6 = 99,
    EGameBinds_SquadMarkerSetAgent7 = 100,
    EGameBinds_SquadMarkerSetAgent8 = 101,
    EGameBinds_SquadMarkerClearAllAgent = 118,
    EGameBinds_MasteryAccess = 196,
    EGameBinds_MasteryAccess01 = 204,
    EGameBinds_MasteryAccess02 = 205,
    EGameBinds_MasteryAccess03 = 206,
    EGameBinds_MasteryAccess04 = 207,
    EGameBinds_MasteryAccess05 = 208,
    EGameBinds_MasteryAccess06 = 211,
    EGameBinds_MiscAoELoot = 74,
    EGameBinds_MiscInteract = 65,
    EGameBinds_MiscShowEnemies = 66,
    EGameBinds_MiscShowAllies = 67,
    EGameBinds_MiscCombatStance = 68,
    EGameBinds_MiscToggleLanguage = 69,
    EGameBinds_MiscTogglePetCombat = 76,
    EGameBinds_MiscToggleFullScreen = 160,
    EGameBinds_MiscToggleDecorationMode = 210,
    EGameBinds_ToyUseDefault = 162,
    EGameBinds_ToyUseSlot1 = 163,
    EGameBinds_ToyUseSlot2 = 164,
    EGameBinds_ToyUseSlot3 = 165,
    EGameBinds_ToyUseSlot4 = 166,
    EGameBinds_ToyUseSlot5 = 167,
    EGameBinds_Loadout1 = 171,
    EGameBinds_Loadout2 = 172,
    EGameBinds_Loadout3 = 173,
    EGameBinds_Loadout4 = 174,
    EGameBinds_Loadout5 = 175,
    EGameBinds_Loadout6 = 176,
    EGameBinds_Loadout7 = 177,
    EGameBinds_Loadout8 = 178,
    EGameBinds_Loadout9 = 179,
    EGameBinds_GearLoadout1 = 182,
    EGameBinds_GearLoadout2 = 183,
    EGameBinds_GearLoadout3 = 184,
    EGameBinds_GearLoadout4 = 185,
    EGameBinds_GearLoadout5 = 186,
    EGameBinds_GearLoadout6 = 187,
    EGameBinds_GearLoadout7 = 188,
    EGameBinds_GearLoadout8 = 189,
    EGameBinds_GearLoadout9 = 190,
};
pub const GAMEBINDS_PRESSASYNC = ?*const fn (EGameBinds) callconv(.C) void;
pub const GAMEBINDS_RELEASEASYNC = ?*const fn (EGameBinds) callconv(.C) void;
pub const GAMEBINDS_INVOKEASYNC = ?*const fn (EGameBinds, c_int) callconv(.C) void;
pub const GAMEBINDS_PRESS = ?*const fn (EGameBinds) callconv(.C) void;
pub const GAMEBINDS_RELEASE = ?*const fn (EGameBinds) callconv(.C) void;
pub const GAMEBINDS_ISBOUND = ?*const fn (EGameBinds) callconv(.C) bool;
pub const GameBindsVT = extern struct {
    PressAsync: GAMEBINDS_PRESSASYNC = std.mem.zeroes(GAMEBINDS_PRESSASYNC),
    ReleaseAsync: GAMEBINDS_RELEASEASYNC = std.mem.zeroes(GAMEBINDS_RELEASEASYNC),
    InvokeAsync: GAMEBINDS_INVOKEASYNC = std.mem.zeroes(GAMEBINDS_INVOKEASYNC),
    Press: GAMEBINDS_PRESS = std.mem.zeroes(GAMEBINDS_PRESS),
    Release: GAMEBINDS_RELEASE = std.mem.zeroes(GAMEBINDS_RELEASE),
    IsBound: GAMEBINDS_ISBOUND = std.mem.zeroes(GAMEBINDS_ISBOUND),
};
pub const DATALINK_GETRESOURCE = ?*const fn ([*c]const u8) callconv(.C) ?*anyopaque;
pub const DATALINK_SHARERESOURCE = ?*const fn ([*c]const u8, usize) callconv(.C) ?*anyopaque;
pub const DataLinkVT = extern struct {
    Get: DATALINK_GETRESOURCE = std.mem.zeroes(DATALINK_GETRESOURCE),
    Share: DATALINK_SHARERESOURCE = std.mem.zeroes(DATALINK_SHARERESOURCE),
};
pub const Texture = extern struct {
    Width: c_uint = std.mem.zeroes(c_uint),
    Height: c_uint = std.mem.zeroes(c_uint),
    Resource: ?*anyopaque = std.mem.zeroes(?*anyopaque),
};
pub const TEXTURES_GET = ?*const fn ([*c]const u8) callconv(.C) [*c]Texture;
pub const TEXTURES_GETORCREATEFROMFILE = ?*const fn ([*c]const u8, [*c]const u8) callconv(.C) [*c]Texture;
pub const TEXTURES_GETORCREATEFROMRESOURCE = ?*const fn ([*c]const u8, c_uint, HMODULE) callconv(.C) [*c]Texture;
pub const TEXTURES_GETORCREATEFROMURL = ?*const fn ([*c]const u8, [*c]const u8, [*c]const u8) callconv(.C) [*c]Texture;
pub const TEXTURES_GETORCREATEFROMMEMORY = ?*const fn ([*c]const u8, ?*anyopaque, usize) callconv(.C) [*c]Texture;
pub const TEXTURES_RECEIVECALLBACK = ?*const fn ([*c]const u8, [*c]Texture) callconv(.C) void;
pub const TEXTURES_LOADFROMFILE = ?*const fn ([*c]const u8, [*c]const u8, TEXTURES_RECEIVECALLBACK) callconv(.C) void;
pub const TEXTURES_LOADFROMRESOURCE = ?*const fn ([*c]const u8, c_uint, HMODULE, TEXTURES_RECEIVECALLBACK) callconv(.C) void;
pub const TEXTURES_LOADFROMURL = ?*const fn ([*c]const u8, [*c]const u8, [*c]const u8, TEXTURES_RECEIVECALLBACK) callconv(.C) void;
pub const TEXTURES_LOADFROMMEMORY = ?*const fn ([*c]const u8, ?*anyopaque, usize, TEXTURES_RECEIVECALLBACK) callconv(.C) void;
pub const TexturesVT = extern struct {
    Get: TEXTURES_GET = std.mem.zeroes(TEXTURES_GET),
    GetOrCreateFromFile: TEXTURES_GETORCREATEFROMFILE = std.mem.zeroes(TEXTURES_GETORCREATEFROMFILE),
    GetOrCreateFromResource: TEXTURES_GETORCREATEFROMRESOURCE = std.mem.zeroes(TEXTURES_GETORCREATEFROMRESOURCE),
    GetOrCreateFromURL: TEXTURES_GETORCREATEFROMURL = std.mem.zeroes(TEXTURES_GETORCREATEFROMURL),
    GetOrCreateFromMemory: TEXTURES_GETORCREATEFROMMEMORY = std.mem.zeroes(TEXTURES_GETORCREATEFROMMEMORY),
    LoadFromFile: TEXTURES_LOADFROMFILE = std.mem.zeroes(TEXTURES_LOADFROMFILE),
    LoadFromResource: TEXTURES_LOADFROMRESOURCE = std.mem.zeroes(TEXTURES_LOADFROMRESOURCE),
    LoadFromURL: TEXTURES_LOADFROMURL = std.mem.zeroes(TEXTURES_LOADFROMURL),
    LoadFromMemory: TEXTURES_LOADFROMMEMORY = std.mem.zeroes(TEXTURES_LOADFROMMEMORY),
};
pub const QUICKACCESS_ADDSHORTCUT = ?*const fn ([*c]const u8, [*c]const u8, [*c]const u8, [*c]const u8, [*c]const u8) callconv(.C) void;
pub const QUICKACCESS_GENERIC = ?*const fn ([*c]const u8) callconv(.C) void;
pub const QUICKACCESS_ADDSIMPLE2 = ?*const fn ([*c]const u8, [*c]const u8, RenderCallback) callconv(.C) void;
pub const QuickAccessVT = extern struct {
    Add: QUICKACCESS_ADDSHORTCUT = std.mem.zeroes(QUICKACCESS_ADDSHORTCUT),
    Remove: QUICKACCESS_GENERIC = std.mem.zeroes(QUICKACCESS_GENERIC),
    Notify: QUICKACCESS_GENERIC = std.mem.zeroes(QUICKACCESS_GENERIC),
    AddContextMenu: QUICKACCESS_ADDSIMPLE2 = std.mem.zeroes(QUICKACCESS_ADDSIMPLE2),
    RemoveContextMenu: QUICKACCESS_GENERIC = std.mem.zeroes(QUICKACCESS_GENERIC),
};
pub const LOCALIZATION_TRANSLATE = ?*const fn ([*c]const u8) callconv(.C) [*c]const u8;
pub const LOCALIZATION_TRANSLATETO = ?*const fn ([*c]const u8, [*c]const u8) callconv(.C) [*c]const u8;
pub const LOCALIZATION_SET = ?*const fn ([*c]const u8, [*c]const u8, [*c]const u8) callconv(.C) void;
pub const LocalizationVT = extern struct {
    Translate: LOCALIZATION_TRANSLATE = std.mem.zeroes(LOCALIZATION_TRANSLATE),
    TranslateTo: LOCALIZATION_TRANSLATETO = std.mem.zeroes(LOCALIZATION_TRANSLATETO),
    Set: LOCALIZATION_SET = std.mem.zeroes(LOCALIZATION_SET),
};
pub const FONTS_RECEIVECALLBACK = ?*const fn ([*c]const u8, ?*anyopaque) callconv(.C) void;
pub const FONTS_GETRELEASE = ?*const fn ([*c]const u8, FONTS_RECEIVECALLBACK) callconv(.C) void;
pub const FONTS_ADDFROMFILE = ?*const fn ([*c]const u8, f32, [*c]const u8, FONTS_RECEIVECALLBACK, ?*anyopaque) callconv(.C) void;
pub const FONTS_ADDFROMRESOURCE = ?*const fn ([*c]const u8, f32, c_uint, HMODULE, FONTS_RECEIVECALLBACK, ?*anyopaque) callconv(.C) void;
pub const FONTS_ADDFROMMEMORY = ?*const fn ([*c]const u8, f32, ?*anyopaque, usize, FONTS_RECEIVECALLBACK, ?*anyopaque) callconv(.C) void;
pub const FONTS_RESIZE = ?*const fn ([*c]const u8, f32) callconv(.C) void;
pub const FontsVT = extern struct {
    Get: FONTS_GETRELEASE = std.mem.zeroes(FONTS_GETRELEASE),
    Release: FONTS_GETRELEASE = std.mem.zeroes(FONTS_GETRELEASE),
    AddFromFile: FONTS_ADDFROMFILE = std.mem.zeroes(FONTS_ADDFROMFILE),
    AddFromResource: FONTS_ADDFROMRESOURCE = std.mem.zeroes(FONTS_ADDFROMRESOURCE),
    AddFromMemory: FONTS_ADDFROMMEMORY = std.mem.zeroes(FONTS_ADDFROMMEMORY),
    Resize: FONTS_RESIZE = std.mem.zeroes(FONTS_RESIZE),
};
pub const AddonAPI = extern struct {
    SwapChain: ?*anyopaque = std.mem.zeroes(?*anyopaque),
    ImguiContext: ?*anyopaque = std.mem.zeroes(?*anyopaque),
    ImguiMalloc: ?*anyopaque = std.mem.zeroes(?*anyopaque),
    ImguiFree: ?*anyopaque = std.mem.zeroes(?*anyopaque),
    Renderer: RendererInterface = std.mem.zeroes(RendererInterface),
    RequestUpdate: UPDATER_REQUESTUPDATE = std.mem.zeroes(UPDATER_REQUESTUPDATE),
    Log: LOGGER_LOG2 = std.mem.zeroes(LOGGER_LOG2),
    UI: UIVT = std.mem.zeroes(UIVT),
    Paths: PathsVT = std.mem.zeroes(PathsVT),
    MinHook: MinHookVT = std.mem.zeroes(MinHookVT),
    Events: EventsVT = std.mem.zeroes(EventsVT),
    WndProc: WndProcVT = std.mem.zeroes(WndProcVT),
    InputBinds: InputBindsVT = std.mem.zeroes(InputBindsVT),
    GameBinds: GameBindsVT = std.mem.zeroes(GameBindsVT),
    DataLink: DataLinkVT = std.mem.zeroes(DataLinkVT),
    Textures: TexturesVT = std.mem.zeroes(TexturesVT),
    QuickAccess: QuickAccessVT = std.mem.zeroes(QuickAccessVT),
    Localization: LocalizationVT = std.mem.zeroes(LocalizationVT),
    Fonts: FontsVT = std.mem.zeroes(FontsVT),
};
pub const AddonLoadFn = *const fn (api: *AddonAPI) callconv(.C) void;
pub const AddonUnloadFn = *const fn () callconv(.C) void;
pub const EAddonFlags = enum(c_int) { None, IsVolatile, DisableHotloading, OnlyLoadDuringGameLaunchSequence };
pub const EUpdateProvider = enum(c_int) { None, Raidcore, GitHub, Direct, Self };
pub const AddonDefinition = extern struct {
    Signature: i32 = 0,
    APIVersion: i32 = 0,
    Name: [*:0]const u8 = "",
    Version: AddonVersion = .{},
    Author: [*:0]const u8 = "",
    Description: [*:0]const u8 = "",
    Load: ?AddonLoadFn = null,
    Unload: ?AddonUnloadFn = null,
    Flags: EAddonFlags = .None,
    Provider: EUpdateProvider = .None,
    UpdateLink: [*:0]const u8 = "",
};
pub extern fn GetAddonDef() *AddonDefinition;
pub const QUICKACCESS_ADDSIMPLE = ?*const fn ([*c]const u8, RenderCallback) callconv(.C) void;
pub const NexusLinkData = extern struct {
    Width: c_uint = std.mem.zeroes(c_uint),
    Height: c_uint = std.mem.zeroes(c_uint),
    Scaling: f32 = std.mem.zeroes(f32),
    IsMoving: bool = std.mem.zeroes(bool),
    IsCameraMoving: bool = std.mem.zeroes(bool),
    IsGameplay: bool = std.mem.zeroes(bool),
    Font: ?*anyopaque = std.mem.zeroes(?*anyopaque),
    FontBig: ?*anyopaque = std.mem.zeroes(?*anyopaque),
    FontUI: ?*anyopaque = std.mem.zeroes(?*anyopaque),
};
pub const NEXUS_API_VERSION = 6;
