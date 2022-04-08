Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E0E4F9CBE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 20:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238735AbiDHSdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 14:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238760AbiDHScj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 14:32:39 -0400
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B2E165A5;
        Fri,  8 Apr 2022 11:30:31 -0700 (PDT)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 238IUDMY015234;
        Sat, 9 Apr 2022 03:30:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 238IUDMY015234
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1649442614;
        bh=TX19SmYcBgrhln/xEfA13JqQ3e/LU5fKae7tjKKfgxI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MZPHjPLXxQhqpOdzWcTU4BKpd075LcGc9JrDx2hrsf1a4zHUSL5XtMjRNVGT5b3Vu
         vDj/eyKB+ltEoz0HwAok3t+QkDyhFoxD0+cJSfpgJsXmGSToF2uOkUTZzXAr+TW5hy
         pV/QMUCvGm4HeuQV1eZSvLkf+5lpfT42liSgRuhz0D81r27x/WrnCg8xbWEG4CErIX
         rBW2hmQrySIKmTGusMJQgvSLTOq3BOeKNOfbBj3y2Lh64bajOJPqBokwU0DlpSQ2n2
         Dwp9/4rY8shR5SL4Ta8cg+r7FTm6W3+lM39MEdcyru36lN2dXU4w8gdmb5JDO1uKbU
         L35lXzSwuPI6Q==
X-Nifty-SrcIP: [209.85.210.173]
Received: by mail-pf1-f173.google.com with SMTP id x16so9040527pfa.10;
        Fri, 08 Apr 2022 11:30:14 -0700 (PDT)
X-Gm-Message-State: AOAM5325ThW5H4aV9td0SoAn4Dbp1v6wDimGcWlB01R1lpm9jXbRn8AW
        BqJXTuK6LV47XaxCoIDqXCFyY4+PwwIFQEcqYs8=
X-Google-Smtp-Source: ABdhPJzhaTpIrY9mfQG6kDakQjZ80/5EUYChcALDjHgzIufzL8fKxfMXUxNj28U0UN0F5iUWiNN7v6npLlRGffHaq10=
X-Received: by 2002:a63:2544:0:b0:39d:1173:148 with SMTP id
 l65-20020a632544000000b0039d11730148mr1461716pgl.352.1649442612827; Fri, 08
 Apr 2022 11:30:12 -0700 (PDT)
MIME-Version: 1.0
References: <7fad83ecde03540e65677959034315f8fbb3755e.1649434832.git.jpoimboe@redhat.com>
In-Reply-To: <7fad83ecde03540e65677959034315f8fbb3755e.1649434832.git.jpoimboe@redhat.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 9 Apr 2022 03:29:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNARvFcQgEB1b0L6giwx0vD7wU9L-OZ5jvm1c5+StLjeOYQ@mail.gmail.com>
Message-ID: <CAK7LNARvFcQgEB1b0L6giwx0vD7wU9L-OZ5jvm1c5+StLjeOYQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Remove CONFIG_DEBUG_SECTION_MISMATCH
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Changbin Du <changbin.du@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+CC: Changbin Du, Arnd Bergmann, who were working on the -Og builds)


On Sat, Apr 9, 2022 at 1:23 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> Modpost's section mismatch detection warns when a non-init function
> references an __init function or __initdata.  Those warnings are very
> useful, because __init memory is freed during boot, so the non-init
> function might end up referencing or calling into some random memory.
>
> CONFIG_DEBUG_SECTION_MISMATCH is intended to root out even more of these
> issues by adding the -fno-inline-functions-called-once compiler flag,
> which forces once-called static functions to not be inlined.  As
> described in the option's help description:
>
>   - Add the option -fno-inline-functions-called-once to gcc commands.
>     When inlining a function annotated with __init in a non-init
>     function, we would lose the section information and thus
>     the analysis would not catch the illegal reference.
>     This option tells gcc to inline less (but it does result in
>     a larger kernel).
>
> So it's basically a debug (non-production) option, which has the goal of
> rooting out potential issues which might exist on *other* configs which
> might somehow trigger different inlining decisions, without having to
> build all those other configs to see the warnings directly.
>
> But with -O2, once-called static functions are almost always inlined, so


"always inlined" per GCC manual.
 -O2, -O3, -O3 enables  -finline-functions-called-once

Clang does not enable this flag because
DEBUG_SECTION_MISMATCH depends on CC_IS_GCC




> its usefulness for rooting out mismatch warnings on other configs is
> somewhere between extremely limited and non-existent.  And nowadays we
> have build bots everywhere doing randconfigs continuously, which are
> great for rooting out such edge cases.
>
> Somewhat ironically, the existence of those build bots means we get a
> lot of unrealistic objtool warnings being reported, due to unrealistic
> inlines caused by CONFIG_DEBUG_SECTION_MISMATCH, where the only way to
> silence the warnings is to force a single-called function to be inlined
> with '__always_inline'.
>
> So the limited, hypothetical benefit of "rooting out configs with
> section mismatches" is outweighed by the very real downside of "adding
> lots of unnecessary '__always_inline' annotations".


I am confused with the description because
you are talking about two different warnings.

[1]  modpost warning  (section mismatch)
[2]  objtool warnings



For [1], you can add __init marker to the callers,
and that is the right thing to do.


Is [2] caused by dead code that was not optimized out
due to the unusual inlining decisions by the compiler ?


If the issues are all about objtool,
"depends on !STACK_VALIDATION" might be
an alternative approach?

config DEBUG_SECTION_MISMATCH
           bool "Enable full Section mismatch analysis"
           depends on CC_IS_GCC
           depends on !STACK_VALIDATION        # do not confuse objtool





>
> In fact I suspect this option has been responsible for dozens of
> "convert inline to __always_inline" patches over the years.  Such
> patches usually complain about the compiler's inlining decisions being
> unpredictable.  It turns out this config option is the main culprit.
>
> So considering the drawbacks of this option significantly outweigh the
> benefits, especially now in the age of randconfig build bots, remove it.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>



In the old days, CONFIG_DEBUG_SECTION_MISMATCH was controlling
more features of modpost, but all of them were just annoying and useless.

They were killed by these commits:

b7dca6dd1e591ad19a9aae716f3898be8063f880
46c7dd56d54133e3fb9414844d90e563627f3feb
7657f60e8ffad587fabc74873b5f42083a60c3cf


Only the remaining part is enabling
the -fno-inline-functions-called-once flag.


Testing this flag more actively was proposed as a part of work
of CONFIG_CC_OPTIMIZE_FOR_DEBUGGING  (-Og).    [1]

I thought -Og was useful for debugging, but Linus rejected it.  [2]


GCC manual says:

  "-finline-functions-called-once

      Consider all static functions called once for inlining into
their caller even if they are not marked inline.
      If a call to a given function is integrated, then the function
is not output as assembler code in its own right.

      Enabled at levels -O1, -O2, -O3 and -Os, but not -Og."


Now that -Og was already rejected, the possible flag for building the kernel is
-O2, O3, -Os.
All of them enable -finline-functions-called-once.

So, there is no practical case for -fno-inline-functions-called-once
unless we explicitly enable it.


I am OK with this patch, I am still wondering if this could be useful
to detect missing __init markers.


[1] https://lore.kernel.org/linux-kbuild/1528186420-6615-3-git-send-email-changbin.du@intel.com/
[2] https://lore.kernel.org/linux-kbuild/CAHk-=wiLt3rgeyM3BWAd5VJrKcnxxuHybwoQiDGMgyspo6oXDg@mail.gmail.com/










> ---
>  .../media/maintainer-entry-profile.rst        |  2 +-
>  Makefile                                      |  5 -----
>  arch/arc/configs/tb10x_defconfig              |  1 -
>  arch/s390/configs/debug_defconfig             |  1 -
>  arch/s390/configs/defconfig                   |  1 -
>  kernel/configs/debug.config                   |  1 -
>  lib/Kconfig.debug                             | 22 -------------------
>  .../selftests/wireguard/qemu/debug.config     |  1 -
>  8 files changed, 1 insertion(+), 33 deletions(-)
>
> diff --git a/Documentation/driver-api/media/maintainer-entry-profile.rst b/Documentation/driver-api/media/maintainer-entry-profile.rst
> index ffc712a5f632..06106d7e7fae 100644
> --- a/Documentation/driver-api/media/maintainer-entry-profile.rst
> +++ b/Documentation/driver-api/media/maintainer-entry-profile.rst
> @@ -123,7 +123,7 @@ Those tests need to pass before the patches go upstream.
>
>  Also, please notice that we build the Kernel with::
>
> -       make CF=-D__CHECK_ENDIAN__ CONFIG_DEBUG_SECTION_MISMATCH=y C=1 W=1 CHECK=check_script
> +       make CF=-D__CHECK_ENDIAN__ C=1 W=1 CHECK=check_script
>
>  Where the check script is::
>
> diff --git a/Makefile b/Makefile
> index 8c7de9a72ea2..3d7ea1a23558 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -871,11 +871,6 @@ KBUILD_CFLAGS      += $(CC_FLAGS_FTRACE) $(CC_FLAGS_USING)
>  KBUILD_AFLAGS  += $(CC_FLAGS_USING)
>  endif
>
> -# We trigger additional mismatches with less inlining
> -ifdef CONFIG_DEBUG_SECTION_MISMATCH
> -KBUILD_CFLAGS += -fno-inline-functions-called-once
> -endif
> -
>  ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
>  KBUILD_CFLAGS_KERNEL += -ffunction-sections -fdata-sections
>  LDFLAGS_vmlinux += --gc-sections
> diff --git a/arch/arc/configs/tb10x_defconfig b/arch/arc/configs/tb10x_defconfig
> index a12656ec0072..5acf8cc3e7b0 100644
> --- a/arch/arc/configs/tb10x_defconfig
> +++ b/arch/arc/configs/tb10x_defconfig
> @@ -96,7 +96,6 @@ CONFIG_STRIP_ASM_SYMS=y
>  CONFIG_DEBUG_FS=y
>  CONFIG_HEADERS_INSTALL=y
>  CONFIG_HEADERS_CHECK=y
> -CONFIG_DEBUG_SECTION_MISMATCH=y
>  CONFIG_MAGIC_SYSRQ=y
>  CONFIG_DEBUG_MEMORY_INIT=y
>  CONFIG_DEBUG_STACKOVERFLOW=y
> diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
> index 498bed9b261b..66a4c65a4bd8 100644
> --- a/arch/s390/configs/debug_defconfig
> +++ b/arch/s390/configs/debug_defconfig
> @@ -791,7 +791,6 @@ CONFIG_DEBUG_INFO_DWARF4=y
>  CONFIG_DEBUG_INFO_BTF=y
>  CONFIG_GDB_SCRIPTS=y
>  CONFIG_HEADERS_INSTALL=y
> -CONFIG_DEBUG_SECTION_MISMATCH=y
>  CONFIG_MAGIC_SYSRQ=y
>  CONFIG_DEBUG_PAGEALLOC=y
>  CONFIG_PAGE_OWNER=y
> diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
> index 61e36b999f67..0e6ae36cf401 100644
> --- a/arch/s390/configs/defconfig
> +++ b/arch/s390/configs/defconfig
> @@ -776,7 +776,6 @@ CONFIG_DEBUG_INFO=y
>  CONFIG_DEBUG_INFO_DWARF4=y
>  CONFIG_DEBUG_INFO_BTF=y
>  CONFIG_GDB_SCRIPTS=y
> -CONFIG_DEBUG_SECTION_MISMATCH=y
>  CONFIG_MAGIC_SYSRQ=y
>  CONFIG_DEBUG_WX=y
>  CONFIG_PTDUMP_DEBUGFS=y
> diff --git a/kernel/configs/debug.config b/kernel/configs/debug.config
> index e8db8d938661..0c1a5d64febb 100644
> --- a/kernel/configs/debug.config
> +++ b/kernel/configs/debug.config
> @@ -18,7 +18,6 @@ CONFIG_SYMBOLIC_ERRNAME=y
>  #
>  CONFIG_DEBUG_INFO=y
>  CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
> -CONFIG_DEBUG_SECTION_MISMATCH=y
>  CONFIG_FRAME_WARN=2048
>  CONFIG_SECTION_MISMATCH_WARN_ONLY=y
>  #
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 075cd25363ac..e52f851e9e3b 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -425,28 +425,6 @@ config HEADERS_INSTALL
>           user-space program samples. It is also needed by some features such
>           as uapi header sanity checks.
>
> -config DEBUG_SECTION_MISMATCH
> -       bool "Enable full Section mismatch analysis"
> -       depends on CC_IS_GCC
> -       help
> -         The section mismatch analysis checks if there are illegal
> -         references from one section to another section.
> -         During linktime or runtime, some sections are dropped;
> -         any use of code/data previously in these sections would
> -         most likely result in an oops.
> -         In the code, functions and variables are annotated with
> -         __init,, etc. (see the full list in include/linux/init.h),
> -         which results in the code/data being placed in specific sections.
> -         The section mismatch analysis is always performed after a full
> -         kernel build, and enabling this option causes the following
> -         additional step to occur:
> -         - Add the option -fno-inline-functions-called-once to gcc commands.
> -           When inlining a function annotated with __init in a non-init
> -           function, we would lose the section information and thus
> -           the analysis would not catch the illegal reference.
> -           This option tells gcc to inline less (but it does result in
> -           a larger kernel).
> -
>  config SECTION_MISMATCH_WARN_ONLY
>         bool "Make section mismatch errors non-fatal"
>         default y
> diff --git a/tools/testing/selftests/wireguard/qemu/debug.config b/tools/testing/selftests/wireguard/qemu/debug.config
> index 2b321b8a96cf..e737ce3b324e 100644
> --- a/tools/testing/selftests/wireguard/qemu/debug.config
> +++ b/tools/testing/selftests/wireguard/qemu/debug.config
> @@ -57,7 +57,6 @@ CONFIG_USER_STACKTRACE_SUPPORT=y
>  CONFIG_DEBUG_SG=y
>  CONFIG_DEBUG_NOTIFIERS=y
>  CONFIG_X86_DEBUG_FPU=y
> -CONFIG_DEBUG_SECTION_MISMATCH=y
>  CONFIG_DEBUG_PAGEALLOC=y
>  CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT=y
>  CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
> --
> 2.34.1
>


-- 
Best Regards
Masahiro Yamada
