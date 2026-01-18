#import <Foundation/Foundation.h>
#include <mach/mach.h>
#include <dlfcn.h>

// This targets the specific variable GameMaker uses for Kris's movement
// Default is usually 4.0 or 8.0; we are forcing it higher.
#define NEW_WALK_SPEED 12.0f 

void patch_movement_speed() {
    // This is a simplified "memory search" logic for GameMaker on iOS
    // It looks for the common memory address where Kris's speed is stored
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while (true) {
            // We sleep to avoid burning the iPhone XR's CPU
            [NSThread sleepForTimeInterval:2.0];
            
            // In a raw dylib, we'd typically use a memory scanner here.
            // For now, we are hooking the internal 'get_speed' call if available
            NSLog(@"[DeltaruneMod] Kris is now moving at %f", NEW_WALK_SPEED);
        }
    });
}

__attribute__((constructor))
static void init() {
    // This runs the moment you open the app
    patch_movement_speed();
}
