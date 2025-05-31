#define WIN32_LEAN_AND_MEAN
#include <windows_stub.h> // Will use mingw's version

// Forward declarations for C++ classes
#ifdef __cplusplus
extern "C" {
#endif

typedef struct AddonDefinition AddonDefinition;
typedef struct AddonAPI AddonAPI;

// List all functions you need to expose
AddonDefinition *GetAddonDef();

typedef struct RendererVT RendererVT;
typedef struct UIVT UIVT;
typedef struct PathsVT PathsVT;
typedef struct MinHookVT MinHookVT;
typedef struct EventsVT EventsVT;
typedef struct WndProcVT WndProcVT;
typedef struct InputBindsVT InputBindsVT;
typedef struct GameBindsVT GameBindsVT;
typedef struct DataLinkVT DataLinkVT;
typedef struct TexturesVT TexturesVT;
typedef struct QuickAccessVT QuickAccessVT;
typedef struct LocalizationVT LocalizationVT;
typedef struct FontsVT FontsVT;

#ifdef __cplusplus
}
#endif

// Include the actual Nexus header
#include "Nexus.h"
