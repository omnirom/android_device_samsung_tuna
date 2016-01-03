/*
 * Copyright (C) 2011 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <stdio.h>
#include <errno.h>
#include <stdarg.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

#include "edify/expr.h"
#include "recovery_updater.h"

int read_whole_file(const char* fname,
                    char* buffer,
                    const int buffer_size) {
    memset(buffer, 0, buffer_size);

    FILE* f = fopen(fname, "rb");
    if (f == NULL) {
        fprintf(stderr, "Cannot open %s!\n", fname);
        return -1;
    }

    int read_byte_count = fread(buffer, 1, buffer_size - 1, f);
    fclose(f);
    if (read_byte_count < 0) {
        fprintf(stderr, "Couldn't read %s\n", fname);
        return -1;
    }

    // Remove any newlines at the end.
    while (buffer[read_byte_count - 1] == '\n') {
        buffer[--read_byte_count] = 0;
    }

    return 0;
}

enum variant_type {
    VARIANT_INIT,
    VARIANT_MAGURO,
    VARIANT_TORO,
    VARIANT_TOROPLUS,
    VARIANT_UNKNOWN
};

Value* GetTunaVariant(const char* name, State* state, int argc, Expr* argv[] __unused)
{
    /* cache the result for subsequent calls */
    static int variant = VARIANT_INIT;

    /* longest cmdline I've seen still has plenty of headroom with this size */
    const int buffer_size = 512;
    char cmdline[buffer_size];

    if (argc != 0) {
        return ErrorAbort(state, "%s() expects 0 args, got %d", name, argc);
    }

    if (variant != VARIANT_INIT) {
        /* we've got a cached result; reuse it and skip ahead. */
        goto out;
    }

    if (read_whole_file("/proc/cmdline", cmdline, buffer_size) == 0) {
        /* /proc/cmdline should contain the radio image version;
         * all the radio versions start with a number related to the
         * specific model. This is done by the bootloader, so it should
         * be trustworthy and independent of the kernel.
         * While we could attempt to check e.x. the ro.product.device prop,
         * there's nothing stopping somebody from installing a toroplus-built
         * recovery on maguro or something like that! */

        if (strstr(cmdline, "I9250") != NULL || /* Most maguro variants. */
            strstr(cmdline, "M420")  != NULL || /* South Korea / East Asia? */
            strstr(cmdline, "SC04D") != NULL    /* Japan / Pacific Asia? */
            ) {
            variant = VARIANT_MAGURO;
            goto out;
        } else if (strstr(cmdline, "I515") != NULL) {
            variant = VARIANT_TORO;
            goto out;
        } else if (strstr(cmdline, "L700") != NULL) {
            variant = VARIANT_TOROPLUS;
            goto out;
        }
    }

    /* this check is technically unnecessary, the only way we should get here
     * is if this statement is true, but let's just be defensive here. */
    if (variant == VARIANT_INIT) {
        /* unable to determine variant; let the tunasetup.sh script
         * try to figure it out on first boot instead. the kernel in
         * recovery is not the same as the ROM, so maybe the ROM kernel
         * will end up with a different cmdline somehow. */
        variant = VARIANT_UNKNOWN;
    }

out:
    switch (variant) {
        case VARIANT_MAGURO:
            return StringValue(strdup("maguro"));
        case VARIANT_TORO:
            return StringValue(strdup("toro"));
        case VARIANT_TOROPLUS:
            return StringValue(strdup("toroplus"));
    }
    return StringValue(strdup("unknown"));
}

void Register_librecovery_updater_tuna() {
    fprintf(stderr, "installing samsung updater extensions\n");

    fprintf(stderr, "installing device variant extensions\n");
    RegisterFunction("tuna.get_variant", GetTunaVariant);
}
