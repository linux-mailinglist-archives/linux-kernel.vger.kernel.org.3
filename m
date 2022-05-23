Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46713531768
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238916AbiEWQco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 12:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238840AbiEWQcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 12:32:42 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70B7E13
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 09:32:40 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id m20so29942448ejj.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 09:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=wVr/3Du+dEKTm/WatvPzvje+/imWStWqSp1bUdVRTw4=;
        b=IgMMExdew0Z/1i8dN8gkq9EQxCCiVj4F34ugFjZWuTr0PzjD8NmKF2OrlQtUp7F1sd
         tZa3GHYtnVO8IPwJsse7KSeNigyLocUWsA5vgh0oHEluTLQm/LyAVy1qCSz5CIgQ6n4X
         AwVL6QRJsHeXHXA90j9x9kr6HU8kRJAatjNYJUBkQUhT0Pe3lbaok2xm0V87pK/o2S0Z
         t/Hb7HLzm8Rvf/aRpxI+ms4vykx+YksXYFRKnFkVRdc4Hui4CDUC26ZL7FlBAwlQi1vI
         kLaMVto39mO+eYNK6YViR+KMST0U6w+bSy4sM220Q0FC2QUABwFlp4a3EngMrvSNVP83
         KKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=wVr/3Du+dEKTm/WatvPzvje+/imWStWqSp1bUdVRTw4=;
        b=YZeAwQlFcghmg/Oh13/w5O0ePDP70SfWQQEx4uiCsbXQodr3MWJ2qLYjSufPyV4pQJ
         hMnf+HZKBLMfSnT7MA2fXGR5w4k7XoJSkb5bLbjEBoNP4+HrVpG2tvUyxuIkEo4I4XUA
         e/ZW40fVkZa5MCGbHuauA4F2mD7GAuCfj7fSlfw00R98dixuEVrTEVQIN2EazoZN5IRh
         JXhxA7JG75bZ1Y/h0ikUSS+DYR+L8fLJ3BYZ8lY1eC6k+xZvym4BIG7GCLHmR3y2wPxZ
         vL2rCuldVRYhX2jfWurk5pcChZ0i2ymZZmxCPdIiL+3ri+l8Q+lVHjcqXXy3yYeOCUIq
         WODg==
X-Gm-Message-State: AOAM533M53EiPtquXwvtnKRe8bazxCH87D+7Y+6qRFG+C1KdTK74BDaT
        GwpHyyMatENmUojkm3ewR7Q=
X-Google-Smtp-Source: ABdhPJyJX61R2HQum21ZQnceqYFnXk2duVxJKf25BAjOfrcEGIQm79kP3/NctHjslqzQZBs/UpEvFw==
X-Received: by 2002:a17:906:e11:b0:6fe:8d93:1ae7 with SMTP id l17-20020a1709060e1100b006fe8d931ae7mr19644440eji.745.1653323559275;
        Mon, 23 May 2022 09:32:39 -0700 (PDT)
Received: from gmail.com (84-236-113-78.pool.digikabel.hu. [84.236.113.78])
        by smtp.gmail.com with ESMTPSA id kl4-20020a170907994400b006feb6438264sm3539281ejc.93.2022.05.23.09.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 09:32:38 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 23 May 2022 18:32:36 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] objtool changes for v5.19
Message-ID: <You3JC/BOIyEnmQj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest objtool/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2022-05-23

   # HEAD: 22682a07acc308ef78681572e19502ce8893c4d4 objtool: Fix objtool regression on x32 systems

Objtool changes for this cycle were:

 - Comprehensive interface overhaul:
   =================================

   Objtool's interface has some issues:

     - Several features are done unconditionally, without any way to turn
       them off.  Some of them might be surprising.  This makes objtool
       tricky to use, and prevents porting individual features to other
       arches.

     - The config dependencies are too coarse-grained.  Objtool enablement is
       tied to CONFIG_STACK_VALIDATION, but it has several other features
       independent of that.

     - The objtool subcmds ("check" and "orc") are clumsy: "check" is really
       a subset of "orc", so it has all the same options.  The subcmd model
       has never really worked for objtool, as it only has a single purpose:
       "do some combination of things on an object file".

     - The '--lto' and '--vmlinux' options are nonsensical and have
       surprising behavior.

   Overhaul the interface:

      - get rid of subcmds

      - make all features individually selectable

      - remove and/or clarify confusing/obsolete options

      - update the documentation

      - fix some bugs found along the way

 - Fix x32 regression

 - Fix Kbuild cleanup bugs

 - Add scripts/objdump-func helper script to disassemble a single function from an object file.

 - Rewrite scripts/faddr2line to be section-aware, by basing it on 'readelf',
   moving it away from 'nm', which doesn't handle multiple sections well,
   which can result in decoding failure.

 - Rewrite & fix symbol handling - which had a number of bugs wrt. object files
   that don't have global symbols - which is rare but possible. Also fix a
   bunch of symbol handling bugs found along the way.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
 Thanks,

	Ingo

------------------>
Borislav Petkov (1):
      x86/cpu: Load microcode during restore_processor_state()

Dmitry Monakhov (1):
      x86/unwind/orc: Recheck address range after stack info was updated

Josh Poimboeuf (27):
      MAINTAINERS: Add x86 unwinding entry
      objtool: Enable unreachable warnings for CLANG LTO
      x86/static_call: Add ANNOTATE_NOENDBR to static call trampoline
      x86/retpoline: Add ANNOTATE_NOENDBR for retpolines
      x86/uaccess: Add ENDBR to __put_user_nocheck*()
      x86/xen: Add ANNOTATE_NOENDBR to startup_xen()
      objtool: Print data address for "!ENDBR" data warnings
      objtool: Use offstr() to print address of missing ENDBR
      libsubcmd: Fix OPTION_GROUP sorting
      objtool: Reorganize cmdline options
      objtool: Ditch subcommands
      objtool: Don't print parentheses in function addresses
      objtool: Add option to print section addresses
      objtool: Make stack validation optional
      objtool: Rework ibt and extricate from stack validation
      objtool: Extricate sls from stack validation
      objtool: Add CONFIG_OBJTOOL
      objtool: Make stack validation frame-pointer-specific
      objtool: Make static call annotation optional
      objtool: Make jump label hack optional
      objtool: Make noinstr hacks optional
      objtool: Rename "VMLINUX_VALIDATION" -> "NOINSTR_VALIDATION"
      objtool: Add HAVE_NOINSTR_VALIDATION
      objtool: Remove --lto and --vmlinux in favor of --link
      objtool: Update documentation
      scripts: Create objdump-func helper script
      scripts/faddr2line: Fix overlapping text section failures

Mikulas Patocka (1):
      objtool: Fix objtool regression on x32 systems

Nur Hussein (1):
      x86/Kconfig: fix the spelling of 'becoming' in X86_KERNEL_IBT config

Peter Zijlstra (5):
      lib/strn*,objtool: Enforce user_access_begin() rules
      x86,xen,objtool: Add UNWIND hint
      x86,objtool: Mark cpu_startup_entry() __noreturn
      x86,objtool: Explicitly mark idtentry_body()s tail REACHABLE
      objtool: Fix symbol creation

Tiezhu Yang (2):
      objtool: Remove inat-tables.c when make clean
      objtool: Remove libsubcmd.a when make clean

Tony Luck (1):
      x86/cpu: Add new Alderlake and Raptorlake CPU model numbers


 MAINTAINERS                                        |   9 +
 Makefile                                           |   2 +-
 arch/Kconfig                                       |  18 +-
 arch/x86/Kconfig                                   |  23 +-
 arch/x86/Kconfig.debug                             |   2 +-
 arch/x86/entry/entry_64.S                          |   3 +
 arch/x86/include/asm/intel-family.h                |   3 +
 arch/x86/include/asm/jump_label.h                  |   6 +-
 arch/x86/include/asm/microcode.h                   |   2 +
 arch/x86/include/asm/static_call.h                 |   1 +
 arch/x86/kernel/alternative.c                      |   6 +-
 arch/x86/kernel/cpu/microcode/core.c               |   6 +-
 arch/x86/kernel/unwind_orc.c                       |   8 +-
 arch/x86/lib/putuser.S                             |   4 +
 arch/x86/lib/retpoline.S                           |   2 +-
 arch/x86/platform/pvh/head.S                       |   1 +
 arch/x86/power/cpu.c                               |  10 +-
 arch/x86/xen/xen-head.S                            |   1 +
 include/linux/compiler.h                           |   6 +-
 include/linux/cpu.h                                |   2 +-
 include/linux/instrumentation.h                    |   6 +-
 include/linux/objtool.h                            |   6 +-
 kernel/trace/Kconfig                               |   1 +
 lib/Kconfig.debug                                  |  22 +-
 lib/Kconfig.kcsan                                  |   4 +-
 lib/Kconfig.ubsan                                  |   2 +-
 lib/strncpy_from_user.c                            |   2 +-
 lib/strnlen_user.c                                 |   2 +-
 scripts/Makefile.build                             |  23 +-
 scripts/faddr2line                                 | 150 ++++---
 scripts/link-vmlinux.sh                            |  66 +--
 scripts/objdump-func                               |  29 ++
 scripts/package/builddeb                           |   2 +-
 tools/include/linux/objtool.h                      |   6 +-
 tools/lib/subcmd/parse-options.c                   |  17 +-
 tools/objtool/Build                                |  12 +-
 .../{stack-validation.txt => objtool.txt}          | 122 +++++-
 tools/objtool/Makefile                             |  10 +-
 tools/objtool/arch/x86/decode.c                    |   2 +-
 tools/objtool/arch/x86/special.c                   |   2 +-
 tools/objtool/builtin-check.c                      | 156 +++++--
 tools/objtool/builtin-orc.c                        |  73 ----
 tools/objtool/check.c                              | 466 +++++++++++----------
 tools/objtool/elf.c                                | 211 ++++++----
 tools/objtool/include/objtool/builtin.h            |  34 +-
 tools/objtool/include/objtool/elf.h                |  16 +-
 tools/objtool/include/objtool/warn.h               |  35 +-
 tools/objtool/objtool.c                            | 103 +----
 tools/objtool/weak.c                               |   9 +-
 49 files changed, 1004 insertions(+), 700 deletions(-)
 create mode 100755 scripts/objdump-func
 rename tools/objtool/Documentation/{stack-validation.txt => objtool.txt} (80%)
 delete mode 100644 tools/objtool/builtin-orc.c

