Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4D85A71D0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 01:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiH3Xbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 19:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiH3Xbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 19:31:34 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240E572B77
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:31:33 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 184-20020a2507c1000000b00696056767cfso880565ybh.22
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:from:to:cc:subject:date;
        bh=wxlH8xA4LQR+FV13439fFhyozXQfxG9gvwfZcr+I1X0=;
        b=POkRmE8aafNm3/PH1cboLlP54QAN+TftgHR2R3yH3TEjt/IbATtHEOBs2o7UdzeK17
         kbSiAnR1xP4j8t5uhQfvb1HlcNbqpBy1lytzSHagEtln9V/DUFfo86yfLMiRSoGAztfo
         6go6vl5eC3Rny22uzHfnw3KDRWxub0NmRUzqi30P62k7CkKWhUyc3/JIqbEZytQHEkoP
         ITbmIQ10Mi+p+M3Hsi34M205D5kGCpDCNmmig9PSsef8dERWCQngnBFI/g+j2AmzRDsy
         FiKEGHBBOA+eXFtB24NUPB9SMT38hcAm2PpHziHG8SOIhNX6xmE3e7QZTFcoph+B538p
         iP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:x-gm-message-state:from:to:cc:subject:date;
        bh=wxlH8xA4LQR+FV13439fFhyozXQfxG9gvwfZcr+I1X0=;
        b=YjbdT+kStxhVroQOGXcb0UM9/ixMbWyV7hyvQkdyGWw/RgtLtV1RW7J8YhC5VstEzB
         szEFOWco68n+a5S+9UYhV64gGURUW5UtRL77U66sfThcUuXlh031BwbB8qBcecW2FyFA
         VAm0EMBIR0n+vrQ13uIPkUzJRGozdvxI5MX96ojWP9nGuYD8/AWeei1iEzMhpRUB8cy0
         uzIo1nHbfBalWDBRbN+fsM7Aho1v9gsCune6OJxpZ9W/g97u8B0PmfvkRUKiOWYZBDUH
         jKaMfCDxDlbHq89owv38bwKE5nmwkYTRF2CBT6nz0LtRXqFbhC+hlVeUYHGO6WD5HLlT
         8lyQ==
X-Gm-Message-State: ACgBeo0x9I9EXgh9eUZLPw8xNcfwAMXWIoejf0+t4H5jcUpTkJdVyqK7
        tfJ+WjHbYvJHRIYio76nE2ndp1A/tjOlXYIvEs94LbO58jXUePFcaS3SZYR2qR0R9WQ+IoGBXMn
        wrRL2a8/k4PMWy3cSb3MqWS85SU2JDfm7gmzxzV5e6MXZweTFJG5bSvJVPJqap8RitJyBJGNsJ5
        gi1uT/b0zriw==
X-Google-Smtp-Source: AA6agR4v2PVJmqWWFyBdaFu4zQQGW908XZpcVafT7sRMHM37DM1+c6YtP3ux8jCwgh/EkSwhtoz8ePlg9kkGk0yAPLk=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:54d9:7143:6a7d:91d])
 (user=samitolvanen job=sendgmr) by 2002:a81:77c4:0:b0:33f:20dc:e694 with SMTP
 id s187-20020a8177c4000000b0033f20dce694mr15958230ywc.395.1661902292327; Tue,
 30 Aug 2022 16:31:32 -0700 (PDT)
Date:   Tue, 30 Aug 2022 16:31:08 -0700
Message-Id: <20220830233129.30610-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=7686; i=samitolvanen@google.com;
 h=from:subject; bh=9FeElwC34gkH48qe7/HORXxbE8G1sjqjDa+3EzwhFyw=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBjDp3Lx50pzG9GxQ7I/Weg1LhkuJn0JlTvJ2dPDsbI
 VH+16Q+JAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYw6dywAKCRBMtfaEi7xW7usrC/
 49i1iNgi+cLrnUgBqADncpVCZSjFRHwv3rMy/FjWehIMep/CKfe2q5s2Afdeh1WtEw3+a7p8J5sU5e
 /DgnzJAggkEFoJujwMm6VWjBB5nmjtwLnhGaLyXN36Pg0dE2f/M+pj63IQ6rb4hYGORpB1RTj6yuJG
 392x9DetVVk6S8dn/1gkTA1MbqYS0m41SbI+F5vZ5ZF9lmQkezM0+jeBBPJ0ycOL+WEMMDFg8IxqGH
 twbJSMEWigzxECjQBdOCV5YAoS1+zaRKSOQMeCUjEUfr7tf/gCT083hUgvrX+pU+t6aE014nXa15n9
 BNONcGdJmLf25s9hLZbr3HcC56vbUNqZ1tta/9evYmfz981PfPF09+/mNnMJPtJzfuLAWxHKM9LPTj
 QxQDIHHYBPVptznB4ihLnrtJE6BA1VLAL7l7B4HSSPmZeubsCsGTh7FLoJb6MJQgjeRH5H8jVi0Nop
 P6S1XaUMHURYhJgn10atIHGAUQLkCCoTpIjWl/B7dBXu0=
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v4 00/21] KCFI support
From:   Sami Tolvanen <samitolvanen@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KCFI is a forward-edge control-flow integrity scheme in the upcoming
Clang 16 release, which is more suitable for kernel use than the
existing CFI scheme used by CONFIG_CFI_CLANG. KCFI doesn't require
LTO, doesn't alter function references to point to a jump table, and
won't break function address equality.

This series replaces the current arm64 CFI implementation with KCFI
and adds support for x86_64.

KCFI requires assembly functions that are indirectly called from C
code to be annotated with type identifiers. As type information is
only available in C, the compiler emits expected type identifiers
into the symbol table, so they can be referenced from assembly
without having to hardcode type hashes. Patch 6 adds helper macros
for annotating functions, and patches 9 and 19 add annotations.

In case of a type mismatch, KCFI always traps. To support error
handling, the compiler generates a .kcfi_traps section for x86_64,
which contains the locations of each trap, and for arm64, encodes
the necessary register information to the ESR. Patches 10 and 21 add
arch-specific error handlers.

To test this series, you'll a ToT Clang toolchain. The series is
also available in GitHub:

  https://github.com/samitolvanen/linux/commits/kcfi-v4

---
Changes in v4:
- Dropped the RFC now that Clang support is merged.

- Changed the x86_64 function preamble to match the the preamble
  generated by the compiler, and fixed a code generation issue,
  which Peter pointed out.

- Added a patch to fix arm64 psci_initcall_t type mismatch based
  on Mark's suggestion.

Changes in v3:
- Merged the patches that split CC_FLAGS_CFI from CC_FLAGS_LTO.

- Dropped the psci_initcall_t patch as Mark volunteered to send a
  patch for this. Note that this patch is still needed to boot a
  CFI kernel on certain arm64 systems:
  https://lore.kernel.org/lkml/YoNhKaTT3EDukxXY@FVFF77S0Q05N/

- Added a patch to remove the now unnecessary workarounds with
  CFI+ThinLTO in kallsyms.

- Added an lkdtm patch to ensure the test actually generates an
  indirect call.

- Changed report_cfi_failure to clearly indicate if we failed to
  decode target address.

- Switched to relative offsets for .kcfi_traps.

- On x86_64, moved CFI error handling from traps.c to cfi.c, and
  as we only call memcpy indirectly w/ CONFIG_MODULES, ensured that
  the compiler emits __kcfi_typeid_memcpy also without modules.

- On x86_64, added a check for the cmpl REX prefix to handle the
  case where the compiler might not use r8-r15 registers for the
  call target.

- On the compiler side, ensured that on x86_64 calls are emitted
  immediately after the CFI check, fixed the __cfi_ preamble
  linkage, and changed the compiler to emit relative offsets in
  .kcfi_traps.

Changes in v2:
- Changed the compiler patch to encode arm64 target and type details
  in the ESR, and updated the kernel error handling patch accordingly.

- Changed the compiler patch to embed the x86_64 type hash in a valid
  instruction to avoid special casing objtool instruction decoding, and
  added a __cfi_ symbol for the preamble. Changed the kernel error
  handling and manual type annotations to match.

- Dropped the .kcfi_types section as that=E2=80=99s no longer needed by
  objtool, and changed the objtool patch to simply ignore the __cfi_
  preambles falling through.

- Dropped the .kcfi_traps section on arm64 as it=E2=80=99s no longer needed=
,
  and moved the trap look-up code behind CONFIG_ARCH_USES_CFI_TRAPS,
  which is selected only for x86_64.

- Dropped __nocfi attributes from arm64 code where CFI was disabled
  due to address space confusion issues, and added type annotations to
  relevant assembly functions.

- Dropped __nocfi from __init.

Sami Tolvanen (21):
  treewide: Filter out CC_FLAGS_CFI
  scripts/kallsyms: Ignore __kcfi_typeid_
  cfi: Remove CONFIG_CFI_CLANG_SHADOW
  cfi: Drop __CFI_ADDRESSABLE
  cfi: Switch to -fsanitize=3Dkcfi
  cfi: Add type helper macros
  lkdtm: Emit an indirect call for CFI tests
  psci: Fix the function type for psci_initcall_t
  arm64: Add types to indirect called assembly functions
  arm64: Add CFI error handling
  arm64: Drop unneeded __nocfi attributes
  init: Drop __nocfi from __init
  treewide: Drop function_nocfi
  treewide: Drop WARN_ON_FUNCTION_MISMATCH
  treewide: Drop __cficanonical
  objtool: Disable CFI warnings
  kallsyms: Drop CONFIG_CFI_CLANG workarounds
  x86/tools/relocs: Ignore __kcfi_typeid_ relocations
  x86: Add types to indirectly called assembly functions
  x86/purgatory: Disable CFI
  x86: Add support for CONFIG_CFI_CLANG

 Makefile                                  |  13 +-
 arch/Kconfig                              |  18 +-
 arch/arm64/crypto/ghash-ce-core.S         |   5 +-
 arch/arm64/crypto/sm3-ce-core.S           |   3 +-
 arch/arm64/include/asm/brk-imm.h          |   6 +
 arch/arm64/include/asm/ftrace.h           |   2 +-
 arch/arm64/include/asm/mmu_context.h      |   4 +-
 arch/arm64/kernel/acpi_parking_protocol.c |   2 +-
 arch/arm64/kernel/alternative.c           |   2 +-
 arch/arm64/kernel/cpu-reset.S             |   5 +-
 arch/arm64/kernel/cpufeature.c            |   4 +-
 arch/arm64/kernel/ftrace.c                |   2 +-
 arch/arm64/kernel/machine_kexec.c         |   2 +-
 arch/arm64/kernel/psci.c                  |   2 +-
 arch/arm64/kernel/smp_spin_table.c        |   2 +-
 arch/arm64/kernel/traps.c                 |  47 ++-
 arch/arm64/kernel/vdso/Makefile           |   3 +-
 arch/arm64/mm/proc.S                      |   5 +-
 arch/x86/Kconfig                          |   2 +
 arch/x86/crypto/blowfish-x86_64-asm_64.S  |   5 +-
 arch/x86/entry/vdso/Makefile              |   3 +-
 arch/x86/include/asm/cfi.h                |  22 ++
 arch/x86/include/asm/linkage.h            |   9 +
 arch/x86/kernel/Makefile                  |   2 +
 arch/x86/kernel/cfi.c                     |  85 ++++++
 arch/x86/kernel/traps.c                   |   4 +-
 arch/x86/lib/memcpy_64.S                  |   3 +-
 arch/x86/purgatory/Makefile               |   4 +
 arch/x86/tools/relocs.c                   |   1 +
 drivers/firmware/efi/libstub/Makefile     |   2 +
 drivers/firmware/psci/psci.c              |  12 +-
 drivers/misc/lkdtm/cfi.c                  |  15 +-
 drivers/misc/lkdtm/usercopy.c             |   2 +-
 include/asm-generic/bug.h                 |  16 -
 include/asm-generic/vmlinux.lds.h         |  37 +--
 include/linux/cfi.h                       |  59 ++--
 include/linux/cfi_types.h                 |  57 ++++
 include/linux/compiler-clang.h            |  14 +-
 include/linux/compiler.h                  |  16 +-
 include/linux/compiler_types.h            |   4 -
 include/linux/init.h                      |   6 +-
 include/linux/module.h                    |  10 +-
 include/linux/pci.h                       |   4 +-
 kernel/cfi.c                              | 352 ++++------------------
 kernel/kallsyms.c                         |  17 --
 kernel/kthread.c                          |   3 +-
 kernel/module/main.c                      |  50 +--
 kernel/workqueue.c                        |   2 +-
 scripts/kallsyms.c                        |   1 +
 scripts/module.lds.S                      |  23 +-
 tools/objtool/check.c                     |   7 +-
 51 files changed, 423 insertions(+), 553 deletions(-)
 create mode 100644 arch/x86/include/asm/cfi.h
 create mode 100644 arch/x86/kernel/cfi.c
 create mode 100644 include/linux/cfi_types.h


base-commit: dcf8e5633e2e69ad60b730ab5905608b756a032f
--=20
2.37.2.672.g94769d06f0-goog

