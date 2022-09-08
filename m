Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0705B28C1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 23:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiIHVzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 17:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiIHVzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 17:55:09 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FE757883
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 14:55:08 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-348608c1cd3so52985517b3.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 14:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:from:to:cc:subject:date;
        bh=PjZoN0zzjSIW43FuU+XJrggTAtHpxYpR0s4G6xQsp2I=;
        b=C2IeInb5KVLYbFKBLliSgdegP+4juJgwCRO9LH2caulegUYXK+hAEP6NI/Hf0gajYi
         xQmZl5rLmzgeYji4pbhB4lZ8rFDTC0/i5WnyF615dgJtYzODUVvnpdWQwkJKAIBBKbTs
         BirsChmdH3tbfPYxdwjJrEy+tyh/cp/CRBC7q6FuWsrFV815zaNgieP8HZENfYl1Ku/s
         v4+yMoDciwiVg05vkdrzVkqTx2PmtAxJFICGvwW2i5vcVKlU4YugMktGTDxNHAo4doDh
         AgZDQxi++ZTvSTU+LxlSYM8+aOp3lFc2uoAZjYVTBF14rB11022nNBoUyFn1ittnAvV8
         cBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:x-gm-message-state:from:to:cc:subject:date;
        bh=PjZoN0zzjSIW43FuU+XJrggTAtHpxYpR0s4G6xQsp2I=;
        b=NpBhZrthPQcH+sRoNLIyKJniuv+74HSW/Zv7+uX+1Kgu/MLLF5tNVKs2C/QOmGd7/n
         Iu5iAQ/VAg5HbDiEnSQKezdDAbsCLmI7S2YJWppGvRNvMPLWjyRJaHjpoBq8XpWJqIqh
         vrOA6XgeOPNyPYJTlFESVVlBM7GhnkCDSiUsDAXFn0J3cedk/RW8sfGJf1VyyyN2ZCVe
         Iuc97KdpHjWLnarbmwEGerb9WgejzEN5Ku3vVgweG1Cj0cL0ygLhGVdCys0+/KEIDJD2
         K1nKvo0GYcyVNt4fCIp7BQY1DPlACN1B1Xg5XLRSQVa81aGL1Eq6+q8z35AXRv3qC7/f
         hYyA==
X-Gm-Message-State: ACgBeo3BFUnRzpD6UfVPtxwxuONDMkJqRkvn9KsFc6O3YS/7Nl2iR2Cp
        Tyns37At9KLyPnYh8n5Dstl33fU40YJzykSYKo1kUZ8dx1ZldWyGuTJTHbqH+h7bFY8aeh48Zhz
        ZK9IYhLlpGu0xQ5+NeXk3qvYflDlSv5XNQCE+SmVwhtoYlryPjOOvjD+Q8jX6k8BH7h2Sm89BwB
        ZcNeDto0q7DA==
X-Google-Smtp-Source: AA6agR6WKViRAKX8D6OrP4sbMJ6SXPUOM73Ukc28rexcSIqiE2/BBpmzkRf/7abUu538j464KaDZCMLU8oVoWy+xq1Y=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:a4e4:e6ec:9fdd:1bdd])
 (user=samitolvanen job=sendgmr) by 2002:a25:2d6:0:b0:6a8:f106:4410 with SMTP
 id 205-20020a2502d6000000b006a8f1064410mr9088381ybc.623.1662674107088; Thu,
 08 Sep 2022 14:55:07 -0700 (PDT)
Date:   Thu,  8 Sep 2022 14:54:42 -0700
Message-Id: <20220908215504.3686827-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=8135; i=samitolvanen@google.com;
 h=from:subject; bh=YeT75pOWqGcFfk/+R15Lxw9MsGMMMZ6nF27yRoOQ1Fc=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBjGmSyhKNovD8eEU0MWcLuyb+PgKPYMvYYauM7wa16
 RKJ7oBqJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYxpksgAKCRBMtfaEi7xW7tWODA
 CFx66OK95Ec9B0+NLJPpsup3+p3TsFTQh1PZqhTeXAM/gr6DXVdeblqA5EpvFtkbtHlOvmUXL6h9qX
 oyWEDFl6s3OVtpfGf+E6HG73bERohpK3KW+4/xFKrMlK1aEwDNe2kzCDcmUE+Q3aboNA2gAX31AqQR
 sDMOSXZhXVaJE/8stH6zN+BDCs46tCichw9NtM2TZbRYsbPkyNW9b6GE8fWZ5n38RAY8MnOcwt0Nvd
 RweQ7yd1LvOI6QJaFvC/UsahmVzyenbp9HV0dzdKh7y5EHKnQevXv7KFNZMtuN45p0cdaL2VaBChYW
 3uGQZnTBOiDz9IMq38O9FBDmxIAJhL5J0QBKKNnFU1X9O6lFoou6AZJ12WEZmu8IoQb6OfXTentvYY
 ffWunmjcCPqfw4r7O3eYMuxWj8U42Ib7uCEQNj7EV6ID4ZuSS0BYgnDo65wnKqIgyKoLTOHkEjLe0N
 boZZMOw9lyt6n8ouEr8AC38jsmUeHS8Y0SjW0x1lLDIiQ=
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Subject: [PATCH v5 00/22] KCFI support
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
for annotating functions, and patches 9 and 20 add annotations.

In case of a type mismatch, KCFI always traps. To support error
handling, the compiler generates a .kcfi_traps section for x86_64,
which contains the locations of each trap, and for arm64, encodes
the necessary register information to the ESR. Patches 10 and 22 add
arch-specific error handlers.

To test this series, you'll need a ToT Clang toolchain. The series
is also available pn GitHub:

  https://github.com/samitolvanen/linux/commits/kcfi-v5

---
Changes in v5:
- Cleaned up the manual CFI type annotation macros, and ensured
  the IBT/BTI landing pads are correctly emitted.

- Added a patch to fix an objtool issue in elf_update_symbol, which
  could end up marking __kcfi_typeid_ SHN_ABS symbols undefined.

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


Sami Tolvanen (22):
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
  objtool: Preserve special st_shndx indexes in elf_update_symbol
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
 arch/arm64/include/asm/linkage.h          |   4 +
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
 arch/x86/include/asm/linkage.h            |  12 +
 arch/x86/kernel/Makefile                  |   2 +
 arch/x86/kernel/cfi.c                     |  86 ++++++
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
 include/linux/cfi_types.h                 |  45 +++
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
 tools/objtool/elf.c                       |   7 +-
 53 files changed, 425 insertions(+), 554 deletions(-)
 create mode 100644 arch/x86/include/asm/cfi.h
 create mode 100644 arch/x86/kernel/cfi.c
 create mode 100644 include/linux/cfi_types.h


base-commit: 506357871c18e06565840d71c2ef9f818e19f460
--=20
2.37.2.789.g6183377224-goog

