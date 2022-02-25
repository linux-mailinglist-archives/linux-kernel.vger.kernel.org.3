Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0271B4C3EA2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 07:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237956AbiBYGyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 01:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiBYGyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 01:54:01 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C903199D58
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 22:53:28 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id p9so2930482wra.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 22:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LO0+bCnVGptPqMMucKWss47ziwXQa5mIZcwtJ8NqCeA=;
        b=JR05pJZkULpDqNBtpmwPKS36guzPPZetir1SJznULdwcFKuXgUVj9XM0TFbU8/afX0
         Zlfy6ZYJcHr/mxE1+VDqJMptO0buhVKnlbpGyVBkojzIZ8zbnQDyqdzKFrY2bCxuWUp4
         LTw/uyCsfT5yQPdj06mWmsK8lxceOYowjpahNwef7VDikMQ6lyAslejS2eaR/XWRpMdu
         mh+l8OAQWRaq3XCWgRl+ihBrWEbglTHzKdJm0jo5bzcq+R5kJut11jayXXGSYFyPtBfo
         T9eFQjIoY+k0ueO6c4tYyJRkzsr7wJKhWps+mZssjJI4TJeqsNq5NdA3TiVSRcE8GyO9
         f6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LO0+bCnVGptPqMMucKWss47ziwXQa5mIZcwtJ8NqCeA=;
        b=x/5OWr7z8ltN4/RMjaxxFtympG5UFvt3tpSIRKdTh4ZsWKDy+IUABOWv3HbWxAxVlZ
         MZVq/eEvn7lXGtydlgGDs65KvhakMoIik+dILRLMtE5QJ1iOz+NUkVLxBg/OWVgl5wV3
         FX9n6zagqXMOwbWXGawCbTPedtFWZ4d8OBe/z18QDHatx2KiukK/0AD+yp3wdFxMZSfa
         BW4x6QUGZ7MbBi/TWAiTDI+cdbouYBV/71utFnOrUgOABOWkwwVSKr3ObirG8aCroqbO
         zqys30CW86MG285wLAyeZ0fpAAOFIokR6eJzEqW/HeCfX1c2hTp41XMFExZPVDuL+O0T
         APcQ==
X-Gm-Message-State: AOAM5325RVUYRAI4uFM6P+DFwLUvn+8FaG9v7CejYl2BYMNivWoidkED
        ux++HwegSHUULTNTuvYYNXkUSfem8kohaycuJvU+yQ==
X-Google-Smtp-Source: ABdhPJx3GSx9C2BQixJgAyjPQqlFVFLGcMw70nOrSTgtThIbmUTNuXL5taV2h3RX5GiPM3LG8ZarJfYq32ZWiocw70c=
X-Received: by 2002:a5d:6346:0:b0:1ef:bde:17e0 with SMTP id
 b6-20020a5d6346000000b001ef0bde17e0mr3124844wrw.395.1645772006675; Thu, 24
 Feb 2022 22:53:26 -0800 (PST)
MIME-Version: 1.0
References: <20220224055145.1853657-1-keescook@chromium.org>
In-Reply-To: <20220224055145.1853657-1-keescook@chromium.org>
From:   David Gow <davidgow@google.com>
Date:   Fri, 25 Feb 2022 14:53:15 +0800
Message-ID: <CABVgOSkUb4wbyMnwsdO5AmEz31q_adJ2enaPuo8SkgbLTsgCTg@mail.gmail.com>
Subject: Re: [PATCH] lib: stackinit: Convert to KUnit
To:     Kees Cook <keescook@chromium.org>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000de7df105d8d22711"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000de7df105d8d22711
Content-Type: text/plain; charset="UTF-8"

On Thu, Feb 24, 2022 at 1:51 PM Kees Cook <keescook@chromium.org> wrote:
>
> Convert to running under Kunit (and retain being able to run stand-alone
> too). Building under Clang (or GCC 12) with CONFIG_INIT_STACK_ALL_ZERO=y,
> this now passes as expected:
>
> $ ./tools/testing/kunit/kunit.py config --make_option LLVM=1
> $ ./tools/testing/kunit/kunit.py run overflow --make_option LLVM=1 \
>         --kconfig_add CONFIG_INIT_STACK_ALL_ZERO=y

Should this be "...kunit.py run 'stackinit'...", not overflow?

> ...
> [09:47:28] ================= stackinit (65 subtests) ==================
> [09:47:28] [PASSED] test_u8_zero
> [09:47:28] [PASSED] test_u16_zero
> [09:47:28] [PASSED] test_u32_zero
> [09:47:28] [PASSED] test_u64_zero
> [09:47:28] [PASSED] test_char_array_zero
> [09:47:28] [PASSED] test_small_hole_zero
> [09:47:28] [PASSED] test_big_hole_zero
> [09:47:28] [PASSED] test_trailing_hole_zero
> [09:47:28] [PASSED] test_packed_zero
> [09:47:28] [PASSED] test_small_hole_dynamic_partial
> [09:47:28] [PASSED] test_big_hole_dynamic_partial
> [09:47:28] [PASSED] test_trailing_hole_dynamic_partial
> [09:47:28] [PASSED] test_packed_dynamic_partial
> [09:47:28] [PASSED] test_small_hole_assigned_dynamic_partial
> [09:47:28] [PASSED] test_big_hole_assigned_dynamic_partial
> [09:47:28] [PASSED] test_trailing_hole_assigned_dynamic_partial
> [09:47:28] [PASSED] test_packed_assigned_dynamic_partial
> [09:47:28] [PASSED] test_small_hole_static_partial
> [09:47:28] [PASSED] test_big_hole_static_partial
> [09:47:28] [PASSED] test_trailing_hole_static_partial
> [09:47:28] [PASSED] test_packed_static_partial
> [09:47:28] [PASSED] test_small_hole_static_all
> [09:47:28] [PASSED] test_big_hole_static_all
> [09:47:28] [PASSED] test_trailing_hole_static_all
> [09:47:28] [PASSED] test_packed_static_all
> [09:47:28] [PASSED] test_small_hole_dynamic_all
> [09:47:28] [PASSED] test_big_hole_dynamic_all
> [09:47:28] [PASSED] test_trailing_hole_dynamic_all
> [09:47:28] [PASSED] test_packed_dynamic_all
> [09:47:28] [PASSED] test_small_hole_runtime_partial
> [09:47:28] [PASSED] test_big_hole_runtime_partial
> [09:47:28] [PASSED] test_trailing_hole_runtime_partial
> [09:47:28] [PASSED] test_packed_runtime_partial
> [09:47:28] [PASSED] test_small_hole_runtime_all
> [09:47:28] [PASSED] test_big_hole_runtime_all
> [09:47:28] [PASSED] test_trailing_hole_runtime_all
> [09:47:28] [PASSED] test_packed_runtime_all
> [09:47:28] [PASSED] test_small_hole_assigned_static_partial
> [09:47:28] [PASSED] test_big_hole_assigned_static_partial
> [09:47:28] [PASSED] test_trailing_hole_assigned_static_partial
> [09:47:28] [PASSED] test_packed_assigned_static_partial
> [09:47:28] [PASSED] test_small_hole_assigned_static_all
> [09:47:28] [PASSED] test_big_hole_assigned_static_all
> [09:47:28] [PASSED] test_trailing_hole_assigned_static_all
> [09:47:28] [PASSED] test_packed_assigned_static_all
> [09:47:28] [PASSED] test_small_hole_assigned_dynamic_all
> [09:47:28] [PASSED] test_big_hole_assigned_dynamic_all
> [09:47:28] [PASSED] test_trailing_hole_assigned_dynamic_all
> [09:47:28] [PASSED] test_packed_assigned_dynamic_all
> [09:47:28] [SKIPPED] test_small_hole_assigned_copy
> [09:47:28] [SKIPPED] test_big_hole_assigned_copy
> [09:47:28] [SKIPPED] test_trailing_hole_assigned_copy
> [09:47:28] [PASSED] test_packed_assigned_copy
> [09:47:28] [PASSED] test_u8_none
> [09:47:28] [PASSED] test_u16_none
> [09:47:28] [PASSED] test_u32_none
> [09:47:28] [PASSED] test_u64_none
> [09:47:28] [PASSED] test_char_array_none
> [09:47:28] [SKIPPED] test_switch_1_none
> [09:47:28] [SKIPPED] test_switch_2_none
> [09:47:28] [PASSED] test_small_hole_none
> [09:47:28] [PASSED] test_big_hole_none
> [09:47:28] [PASSED] test_trailing_hole_none
> [09:47:28] [PASSED] test_packed_none
> [09:47:28] [PASSED] test_user
> [09:47:28] ==================== [PASSED] stackinit ====================
> [09:47:28] ============================================================
> [09:47:28] Testing complete. Passed: 60, Failed: 0, Crashed: 0, Skipped: 5, Errors: 0
> [09:47:28] Elapsed time: 4.192s total, 0.001s configuring, 4.070s building, 0.102s running
>
> Cc: David Gow <davidgow@google.com>
> Cc: Daniel Latypov <dlatypov@google.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

This looks pretty good as a KUnit test overall, even if it does some
unusual (but cool!) things with the userland version.

A few comments inline.

Cheers,
-- David

>  lib/Kconfig.debug                           |  26 +-
>  lib/Makefile                                |   4 +-
>  lib/{test_stackinit.c => stackinit_kunit.c} | 249 ++++++++++++--------
>  3 files changed, 168 insertions(+), 111 deletions(-)
>  rename lib/{test_stackinit.c => stackinit_kunit.c} (73%)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 14d90d03bc8d..ea4415275563 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2511,6 +2511,21 @@ config OVERFLOW_KUNIT_TEST
>
>           If unsure, say N.
>
> +config STACKINIT_KUNIT_TEST
> +       tristate "Test level of stack variable initialization" if !KUNIT_ALL_TESTS
> +       depends on KUNIT
> +       default KUNIT_ALL_TESTS

We probably don't want to enable this test by default (with
KUNIT_ALL_TESTS) if we don't have CONFIG_INIT_STACK_ALL_ZERO=y, as
that'll result in a number of failures for any "all tests"
configuration.

Does it make sense to either:
1. Make this test depend on INIT_STACK_ALL_ZERO?
2. Just change the default, so that KUNIT_ALL_TESTS doesn't trigger it
(or doesn't trigger it unless INIT_STACK_ALL_ZERO is also enabled), so
people can force it to build/run and see the failures?
3. Make it run, but mark some or all tests as SKIPPED if
INIT_STACK_ALL_ZERO is not set (as a failure here is expected)?

> +       help
> +         Test if the kernel is zero-initializing stack variables and
> +         padding. Coverage is controlled by compiler flags,
> +         CONFIG_GCC_PLUGIN_STRUCTLEAK, CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF,
> +         or CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL.
> +
> +         For more information on KUnit and unit tests in general please refer
> +         to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
> +         If unsure, say N.
> +
>  config TEST_UDELAY
>         tristate "udelay test driver"
>         help
> @@ -2602,17 +2617,6 @@ config TEST_OBJAGG
>           Enable this option to test object aggregation manager on boot
>           (or module load).
>
> -
> -config TEST_STACKINIT
> -       tristate "Test level of stack variable initialization"
> -       help
> -         Test if the kernel is zero-initializing stack variables and
> -         padding. Coverage is controlled by compiler flags,
> -         CONFIG_GCC_PLUGIN_STRUCTLEAK, CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF,
> -         or CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL.
> -
> -         If unsure, say N.
> -
>  config TEST_MEMINIT
>         tristate "Test heap/page initialization"
>         help
> diff --git a/lib/Makefile b/lib/Makefile
> index fdfcbfaff32f..353bc09ce38d 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -93,8 +93,6 @@ obj-$(CONFIG_TEST_KMOD) += test_kmod.o
>  obj-$(CONFIG_TEST_DEBUG_VIRTUAL) += test_debug_virtual.o
>  obj-$(CONFIG_TEST_MEMCAT_P) += test_memcat_p.o
>  obj-$(CONFIG_TEST_OBJAGG) += test_objagg.o
> -CFLAGS_test_stackinit.o += $(call cc-disable-warning, switch-unreachable)
> -obj-$(CONFIG_TEST_STACKINIT) += test_stackinit.o
>  obj-$(CONFIG_TEST_BLACKHOLE_DEV) += test_blackhole_dev.o
>  obj-$(CONFIG_TEST_MEMINIT) += test_meminit.o
>  obj-$(CONFIG_TEST_LOCKUP) += test_lockup.o
> @@ -363,6 +361,8 @@ obj-$(CONFIG_CMDLINE_KUNIT_TEST) += cmdline_kunit.o
>  obj-$(CONFIG_SLUB_KUNIT_TEST) += slub_kunit.o
>  obj-$(CONFIG_MEMCPY_KUNIT_TEST) += memcpy_kunit.o
>  obj-$(CONFIG_OVERFLOW_KUNIT_TEST) += overflow_kunit.o

FYI: Due to this context line, this patch only applies cleanly if the
overflow test port patch is applied first.

> +CFLAGS_stackinit_kunit.o += $(call cc-disable-warning, switch-unreachable)
> +obj-$(CONFIG_STACKINIT_KUNIT_TEST) += stackinit_kunit.o
>
>  obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
>
> diff --git a/lib/test_stackinit.c b/lib/stackinit_kunit.c
> similarity index 73%
> rename from lib/test_stackinit.c
> rename to lib/stackinit_kunit.c
> index a3c74e6a21ff..72c7d4cb8ed2 100644
> --- a/lib/test_stackinit.c
> +++ b/lib/stackinit_kunit.c
> @@ -2,14 +2,23 @@
>  /*
>   * Test cases for compiler-based stack variable zeroing via
>   * -ftrivial-auto-var-init={zero,pattern} or CONFIG_GCC_PLUGIN_STRUCTLEAK*.
> + * For example, see:
> + * https://www.kernel.org/doc/html/latest/dev-tools/kunit/kunit-tool.html#configuring-building-and-running-tests
> + *     ./tools/testing/kunit/kunit.py config --make_option LLVM=1
> + *     ./tools/testing/kunit/kunit.py run overflow [--raw_output] \

As above, this should probably be 'stackinit', not 'overflow'.

> + *             --make_option LLVM=1 \
> + *             --kconfig_add CONFIG_INIT_STACK_ALL_ZERO=y
>   *
>   * External build example:
>   *     clang -O2 -Wall -ftrivial-auto-var-init=pattern \
> - *             -o test_stackinit test_stackinit.c
> + *             -o stackinit_kunit stackinit_kunit.c
> + *     ./stackinit_kunit
> + *
>   */
>  #ifdef __KERNEL__
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
> +#include <kunit/test.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> @@ -18,21 +27,55 @@
>  #else
>
>  /* Userspace headers. */
> +#define _GNU_SOURCE
>  #include <stdio.h>
>  #include <stdint.h>
> +#include <stdlib.h>
>  #include <string.h>
>  #include <stdbool.h>
>  #include <errno.h>
>  #include <sys/types.h>
>
>  /* Linux kernel-ism stubs for stand-alone userspace build. */
> -#define KBUILD_MODNAME         "stackinit"
> -#define pr_fmt(fmt)            KBUILD_MODNAME ": " fmt
> -#define pr_err(fmt, ...)       fprintf(stderr, pr_fmt(fmt), ##__VA_ARGS__)
> -#define pr_warn(fmt, ...)      fprintf(stderr, pr_fmt(fmt), ##__VA_ARGS__)
> -#define pr_info(fmt, ...)      fprintf(stdout, pr_fmt(fmt), ##__VA_ARGS__)
> -#define __init                 /**/
> -#define __exit                 /**/
> +#define TEST_PASS      0
> +#define TEST_SKIP      1
> +#define TEST_FAIL      2
> +struct kunit {
> +       int status;
> +       char *msg;
> +};
> +struct kunit_case {
> +        void (*run_case)(struct kunit *test);
> +        const char *name;
> +};
> +struct kunit_suite {
> +       const char *name;
> +       const struct kunit_case *test_cases;
> +};
> +#define KUNIT_CASE(test_name) { .run_case = test_name, .name = #test_name }
> +
> +#define KUNIT_ASSERT_TRUE_MSG(test, expr, fmt, ...)                    \
> +do {                                                                   \
> +       if (!(expr)) {                                                  \
> +               if (test->status != TEST_SKIP)                          \
> +                       test->status = TEST_FAIL;                       \
> +               if (test->msg)                                          \
> +                       free(test->msg);                                \
> +               asprintf(&test->msg, fmt, ##__VA_ARGS__);               \
> +       }                                                               \
> +} while (0)
> +
> +#define KUNIT_ASSERT_EQ_MSG(test, left, right, fmt, ...)               \
> +       KUNIT_ASSERT_TRUE_MSG(test, (left) == (right), fmt, ##__VA_ARGS__)
> +
> +#define kunit_skip(test, fmt, ...)                                     \
> +do {                                                                   \
> +       test->status = TEST_SKIP;                                       \
> +       if (test->msg)                                                  \
> +               free(test->msg);                                        \
> +       asprintf(&test->msg, fmt, ##__VA_ARGS__);                       \
> +} while (0)
> +
>  #define __user                 /**/
>  #define noinline               __attribute__((__noinline__))
>  #define __aligned(x)           __attribute__((__aligned__(x)))
> @@ -59,16 +102,44 @@ typedef uint16_t           u16;
>  typedef uint32_t               u32;
>  typedef uint64_t               u64;
>
> -#define module_init(func)      static int (*do_init)(void) = func
> -#define module_exit(func)      static void (*do_exit)(void) = func
> -#define MODULE_LICENSE(str)    int main(void) {                \
> -                                       int rc;                 \
> -                                       /* License: str */      \
> -                                       rc = do_init();         \
> -                                       if (rc == 0)            \
> -                                               do_exit();      \
> -                                       return rc;              \
> -                               }
> +#define MODULE_LICENSE(str)    /* */
> +
> +int do_kunit_test_suite(struct kunit_suite *suite)
> +{
> +       const struct kunit_case *test_case;
> +       int rc = 0;
> +
> +       for (test_case = suite->test_cases; test_case->run_case; test_case++) {
> +               struct kunit test = { };
> +
> +               test_case->run_case(&test);
> +               switch (test.status) {
> +               default:
> +               case TEST_FAIL:
> +                       fprintf(stderr, "FAIL: %s%s%s", test_case->name,
> +                               test.msg ? ": " : "",
> +                               test.msg ?: "\n");
> +                       rc = 1;
> +                       break;
> +               case TEST_SKIP:
> +                       fprintf(stdout, "XFAIL: %s%s%s", test_case->name,
> +                               test.msg ? ": " : "",
> +                               test.msg ?: "\n");
> +                       break;
> +               case TEST_PASS:
> +                       fprintf(stdout, "ok: %s\n", test_case->name);
> +                       break;
> +               }
> +               if (test.msg)
> +                       free(test.msg);
> +       }
> +       return rc;
> +}

This whole userspace mini-kunit thing is very neat. Daniel makes some
good points about how it could be extended and made to match KUnit
more (though I don't think we need to make a perfect userland KUnit
for just this test). The one other thing I'll ask is if it makes sense
to have this output something more similar to KTAP. If the target of
the userspace version isn't kernel developers, I don't think it's
necessary, but if there's no reason _not_ to, it'd be nice for it to
be consistent with the kernel version.

> +
> +#define kunit_test_suite(suite)                                        \
> +int main(void) {                                               \
> +       return do_kunit_test_suite(&(suite));                   \
> +}
>
>  #endif /* __KERNEL__ */
>
> @@ -201,7 +272,7 @@ static bool range_contains(char *haystack_start, size_t haystack_size,
>   */
>  #define DEFINE_TEST_DRIVER(name, var_type, which, xfail)       \
>  /* Returns 0 on success, 1 on failure. */                      \
> -static noinline __init int test_ ## name (void)                        \
> +static noinline void test_ ## name (struct kunit *test)                \
>  {                                                              \
>         var_type zero INIT_CLONE_ ## which;                     \
>         int ignored;                                            \
> @@ -220,10 +291,8 @@ static noinline __init int test_ ## name (void)                    \
>         /* Verify all bytes overwritten with 0xFF. */           \
>         for (sum = 0, i = 0; i < target_size; i++)              \
>                 sum += (check_buf[i] != 0xFF);                  \
> -       if (sum) {                                              \
> -               pr_err(#name ": leaf fill was not 0xFF!?\n");   \
> -               return 1;                                       \
> -       }                                                       \
> +       KUNIT_ASSERT_EQ_MSG(test, sum, 0,                       \
> +                           "leaf fill was not 0xFF!?\n");      \

As Daniel noted, this is a behaviour change for the userspace version,
as its implementation of KUNIT_ASSERT_EQ_MSG() doesn't exit the test
early. So earlier errors will be overwritten with later ones, akin to
KUNIT_EXPECT_EQ_MSG().

In general, KUnit tests will often use the EXPECT variant where
possible, as KUnit will print all failed expectations out, not just
the last one, so ASSERT is usually reserved for things like memory
allocation failures where continuing is no longer safe. That being
said, it can get a bit spammy, so I'm happy with it either way.

>         /* Clear entire check buffer for later bit tests. */    \
>         memset(check_buf, 0x00, sizeof(check_buf));             \
>         /* Extract stack-defined variable contents. */          \
> @@ -231,32 +300,29 @@ static noinline __init int test_ ## name (void)                   \
>                                 FETCH_ARG_ ## which(zero));     \
>                                                                 \
>         /* Validate that compiler lined up fill and target. */  \
> -       if (!range_contains(fill_start, fill_size,              \
> -                           target_start, target_size)) {       \
> -               pr_err(#name ": stack fill missed target!?\n"); \
> -               pr_err(#name ": fill %zu wide\n", fill_size);   \
> -               pr_err(#name ": target offset by %d\n", \
> -                       (int)((ssize_t)(uintptr_t)fill_start -  \
> -                       (ssize_t)(uintptr_t)target_start));     \
> -               return 1;                                       \
> -       }                                                       \
> +       KUNIT_ASSERT_TRUE_MSG(test,                             \
> +               range_contains(fill_start, fill_size,           \
> +                           target_start, target_size),         \
> +               "stack fill missed target!? "                   \
> +               "(fill %zu wide, target offset by %d)\n",       \
> +               fill_size,                                      \
> +               (int)((ssize_t)(uintptr_t)fill_start -          \
> +                     (ssize_t)(uintptr_t)target_start));       \
>                                                                 \
>         /* Look for any bytes still 0xFF in check region. */    \
>         for (sum = 0, i = 0; i < target_size; i++)              \
>                 sum += (check_buf[i] == 0xFF);                  \
>                                                                 \
> -       if (sum == 0) {                                         \
> -               pr_info(#name " ok\n");                         \
> -               return 0;                                       \
> -       } else {                                                \
> -               pr_warn(#name " %sFAIL (uninit bytes: %d)\n",   \
> -                       (xfail) ? "X" : "", sum);               \
> -               return (xfail) ? 0 : 1;                         \
> -       }                                                       \
> +       if (sum != 0 && xfail)                                  \
> +               kunit_skip(test,                                \
> +                          "XFAIL uninit bytes: %d\n",          \
> +                          sum);                                \
> +       KUNIT_ASSERT_EQ_MSG(test, sum, 0,                       \
> +               "uninit bytes: %d\n", sum);                     \
>  }
>  #define DEFINE_TEST(name, var_type, which, init_level, xfail)  \
>  /* no-op to force compiler into ignoring "uninitialized" vars */\
> -static noinline __init DO_NOTHING_TYPE_ ## which(var_type)     \
> +static noinline DO_NOTHING_TYPE_ ## which(var_type)            \
>  do_nothing_ ## name(var_type *ptr)                             \
>  {                                                              \
>         /* Will always be true, but compiler doesn't know. */   \
> @@ -265,9 +331,8 @@ do_nothing_ ## name(var_type *ptr)                          \
>         else                                                    \
>                 return DO_NOTHING_RETURN_ ## which(ptr + 1);    \
>  }                                                              \
> -static noinline __init int leaf_ ## name(unsigned long sp,     \
> -                                        bool fill,             \
> -                                        var_type *arg)         \
> +static noinline int leaf_ ## name(unsigned long sp, bool fill, \
> +                                 var_type *arg)                \
>  {                                                              \
>         char buf[VAR_BUFFER];                                   \
>         var_type var                                            \
> @@ -398,7 +463,7 @@ static int noinline __leaf_switch_none(int path, bool fill)
>                  * This is intentionally unreachable. To silence the
>                  * warning, build with -Wno-switch-unreachable
>                  */
> -               uint64_t var;
> +               uint64_t var[10];
>
>         case 1:
>                 target_start = &var;
> @@ -423,19 +488,19 @@ static int noinline __leaf_switch_none(int path, bool fill)
>                 memcpy(check_buf, target_start, target_size);
>                 break;
>         default:
> -               var = 5;
> -               return var & forced_mask;
> +               var[1] = 5;
> +               return var[1] & forced_mask;
>         }
>         return 0;
>  }
>
> -static noinline __init int leaf_switch_1_none(unsigned long sp, bool fill,
> +static noinline int leaf_switch_1_none(unsigned long sp, bool fill,
>                                               uint64_t *arg)
>  {
>         return __leaf_switch_none(1, fill);
>  }
>
> -static noinline __init int leaf_switch_2_none(unsigned long sp, bool fill,
> +static noinline int leaf_switch_2_none(unsigned long sp, bool fill,
>                                               uint64_t *arg)
>  {
>         return __leaf_switch_none(2, fill);
> @@ -450,65 +515,53 @@ static noinline __init int leaf_switch_2_none(unsigned long sp, bool fill,
>  DEFINE_TEST_DRIVER(switch_1_none, uint64_t, SCALAR, XFAIL);
>  DEFINE_TEST_DRIVER(switch_2_none, uint64_t, SCALAR, XFAIL);
>
> -static int __init test_stackinit_init(void)
> -{
> -       unsigned int failures = 0;
> -
> -#define test_scalars(init)     do {                            \
> -               failures += test_u8_ ## init ();                \
> -               failures += test_u16_ ## init ();               \
> -               failures += test_u32_ ## init ();               \
> -               failures += test_u64_ ## init ();               \
> -               failures += test_char_array_ ## init ();        \
> -       } while (0)
> +#define KUNIT_test_scalars(init)                       \
> +               KUNIT_CASE(test_u8_ ## init),           \
> +               KUNIT_CASE(test_u16_ ## init),          \
> +               KUNIT_CASE(test_u32_ ## init),          \
> +               KUNIT_CASE(test_u64_ ## init),          \
> +               KUNIT_CASE(test_char_array_ ## init)
>
> -#define test_structs(init)     do {                            \
> -               failures += test_small_hole_ ## init ();        \
> -               failures += test_big_hole_ ## init ();          \
> -               failures += test_trailing_hole_ ## init ();     \
> -               failures += test_packed_ ## init ();            \
> -       } while (0)
> +#define KUNIT_test_structs(init)                       \
> +               KUNIT_CASE(test_small_hole_ ## init),   \
> +               KUNIT_CASE(test_big_hole_ ## init),     \
> +               KUNIT_CASE(test_trailing_hole_ ## init),\
> +               KUNIT_CASE(test_packed_ ## init)        \
>
> +static struct kunit_case stackinit_test_cases[] = {
>         /* These are explicitly initialized and should always pass. */
> -       test_scalars(zero);
> -       test_structs(zero);
> +       KUNIT_test_scalars(zero),
> +       KUNIT_test_structs(zero),
>         /* Padding here appears to be accidentally always initialized? */
> -       test_structs(dynamic_partial);
> -       test_structs(assigned_dynamic_partial);
> +       KUNIT_test_structs(dynamic_partial),
> +       KUNIT_test_structs(assigned_dynamic_partial),
>         /* Padding initialization depends on compiler behaviors. */
> -       test_structs(static_partial);
> -       test_structs(static_all);
> -       test_structs(dynamic_all);
> -       test_structs(runtime_partial);
> -       test_structs(runtime_all);
> -       test_structs(assigned_static_partial);
> -       test_structs(assigned_static_all);
> -       test_structs(assigned_dynamic_all);
> +       KUNIT_test_structs(static_partial),
> +       KUNIT_test_structs(static_all),
> +       KUNIT_test_structs(dynamic_all),
> +       KUNIT_test_structs(runtime_partial),
> +       KUNIT_test_structs(runtime_all),
> +       KUNIT_test_structs(assigned_static_partial),
> +       KUNIT_test_structs(assigned_static_all),
> +       KUNIT_test_structs(assigned_dynamic_all),
>         /* Everything fails this since it effectively performs a memcpy(). */
> -       test_structs(assigned_copy);
> -
> +       KUNIT_test_structs(assigned_copy),
>         /* STRUCTLEAK_BYREF_ALL should cover everything from here down. */
> -       test_scalars(none);
> -       failures += test_switch_1_none();
> -       failures += test_switch_2_none();
> -
> +       KUNIT_test_scalars(none),
> +       KUNIT_CASE(test_switch_1_none),
> +       KUNIT_CASE(test_switch_2_none),
>         /* STRUCTLEAK_BYREF should cover from here down. */
> -       test_structs(none);
> -
> +       KUNIT_test_structs(none),
>         /* STRUCTLEAK will only cover this. */
> -       failures += test_user();
> -
> -       if (failures == 0)
> -               pr_info("all tests passed!\n");
> -       else
> -               pr_err("failures: %u\n", failures);
> +       KUNIT_CASE(test_user),
> +       {}
> +};
>
> -       return failures ? -EINVAL : 0;
> -}
> -module_init(test_stackinit_init);
> +static struct kunit_suite stackinit_test_suite = {
> +       .name = "stackinit",
> +       .test_cases = stackinit_test_cases,
> +};
>
> -static void __exit test_stackinit_exit(void)
> -{ }
> -module_exit(test_stackinit_exit);
> +kunit_test_suite(stackinit_test_suite);
>
>  MODULE_LICENSE("GPL");
> --
> 2.30.2
>

--000000000000de7df105d8d22711
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
G7p3AiuB2sgfq6cOpbO5MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQBsL34EJkCtu9Nu
2+R6l1Qzno5Gl+N2Cm6/YLujukDGYa1JW27txXiilR9dGP7yl60HYyG2Exd5i6fiLDlaNEw0SqzE
dw9ZSIak3Qvm2UybR8zcnB0deCUiwahqh7ZncEPlhnPpB08ETEUtwBEqCEnndNEkIN67yz4kniCZ
jZstNF/BUnI3864fATiXSbnNqBwlJS3YkoaCTpbI9qNTrf5VIvnbryT69xJ6f25yfmxrXNJJe5OG
ncB34Cwnb7xQyk+uRLZ465yUBkbjk9pC/yamL0O7SOGYUclrQl2c5zzGuVBD84YcQGDOK6gSPj6w
QuBfOooZPOyZZZ8AMih7J980MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABQeVybOOpR4bOOXZYL5T3MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBo
fELKiqrNn7bjWrc3WMCcDF/1SYwM4fDK02QyVJcpbjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjAyMjUwNjUzMjdaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAPUzUBLI1IA3pXvKa4/5d
7WjbULhpmcRQherk683yrZOwQ5xe4QjRedRCHt6m2ifa7wdOw7npwsWfqj3c/mmwvo5bTs/WKJvn
0f/4PrRenBpafDxlc+UMm72f0Jzpj+/PKQr1pRHIJ2G27+PWb1IkALgu/ZueB3FMcCOzEumKx/6h
V5lNbtJ5KRZK3oRJ2eJ1Wy1TcwqlOa7x+0V4bjl09iWokH9W+dB3Orpe7xfSImZkXQvvhAalREae
UIkjNZ/31cXAhCOooAK1v50LlNycFo+8xIX7v4Y+qk5DX0Ii8x3q0DyVtp/yKpdI3QDR3F1xQxY7
90zDHWgS4ZswGrd7dA==
--000000000000de7df105d8d22711--
