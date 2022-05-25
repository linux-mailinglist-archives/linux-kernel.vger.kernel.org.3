Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED12533F59
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239846AbiEYOjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbiEYOjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 10:39:17 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B96340F3;
        Wed, 25 May 2022 07:39:14 -0700 (PDT)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 24PEcjBp021016;
        Wed, 25 May 2022 23:38:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 24PEcjBp021016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1653489525;
        bh=Lp03uVXMPQlmSiBowOZMUCLROOhnHg+rTLt9h5CDAoY=;
        h=From:Date:Subject:To:Cc:From;
        b=0YRxdES1gpi/Wxr7oO2pZplzkux01SKoU4kQ+MrFPd/AGxWOCRh+IJhcvrZd3PaRh
         MHyH5u6Sujtt24ttWAtbI5xTa7jENrj/Qo2SkiNPPFuGUODyikE/XRLt2bA28ACbkx
         wjv5yhELfKKgS3x8dFpQ76oWpfk3o4jsY31jr+4ZcISW+sprxjIvzyQh2mCEC6Zc1Z
         ry0wJxjUwn0GiA4+08wA02gs+2u6Hv0kHI+S9nr52kOAdDCwYO3gTnl4VX8/taWvCA
         KJfDUA2cmjOjnWlrJCo/F0rrOqwIxQWI1ipcw/PAuuvLrCKhyb5W+BAschENrbpxZY
         7iDxg9sdxnOWA==
X-Nifty-SrcIP: [209.85.214.179]
Received: by mail-pl1-f179.google.com with SMTP id d22so18730060plr.9;
        Wed, 25 May 2022 07:38:45 -0700 (PDT)
X-Gm-Message-State: AOAM533Q91g7zZh6ohiqwUZ8O8aVdjF5r6mGjKaOyv3LRwllBbaShcDN
        lcxVF+pZxYidydSl0w6dvl8ebS5kIDpDEk/jTPI=
X-Google-Smtp-Source: ABdhPJzt72aesK1C/ucD/FdILkN7b5tEansPbXFJ0N3dRhffVd5O4npq/oZtCz02Diz91oql/Ut7Lh0tV5cPSkOgyCI=
X-Received: by 2002:a17:902:f68f:b0:162:23c6:e61b with SMTP id
 l15-20020a170902f68f00b0016223c6e61bmr15434702plg.136.1653489524424; Wed, 25
 May 2022 07:38:44 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 25 May 2022 23:37:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNATy1o89+KwgDmJ3tDDxnF2JvhVBm702JbRe6jREWH8MYQ@mail.gmail.com>
Message-ID: <CAK7LNATy1o89+KwgDmJ3tDDxnF2JvhVBm702JbRe6jREWH8MYQ@mail.gmail.com>
Subject: [GIT PULL] Kbuild updates for v5.19-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull Kbuild updates for v5.19-rc1.
Thank you.



The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-v5.19

for you to fetch changes up to 5ce2176b81f77366bd02c27509b83049f0020544:

  genksyms: adjust the output format to modpost (2022-05-24 16:33:20 +0900)

----------------------------------------------------------------
Kbuild updates for v5.19

 - Add HOSTPKG_CONFIG env variable to allow users to override pkg-config

 - Support W=e as a shorthand for KCFLAGS=-Werror

 - Fix CONFIG_IKHEADERS build to support toybox cpio

 - Add scripts/dummy-tools/pahole to ease distro packagers' life

 - Suppress false-positive warnings from checksyscalls.sh for W=2 build

 - Factor out the common code of arch/*/boot/install.sh into
   scripts/install.sh

 - Support 'kernel-install' tool in scripts/prune-kernel

 - Refactor module-versioning to link the symbol versions at the final
   link of vmlinux and modules

 - Remove CONFIG_MODULE_REL_CRCS because module-versioning now works in
   an arch-agnostic way

 - Refactor modpost, Makefiles

----------------------------------------------------------------
Chun-Tse Shao (1):
      kbuild: Allow kernel installation packaging to override pkg-config

Daniel Mentz (1):
      kheaders: Have cpio unconditionally replace files

Jiri Slaby (1):
      scripts: dummy-tools, add pahole

Masahiro Yamada (47):
      kbuild: factor out genksyms command from cmd_gensymtypes_{c,S}
      kbuild: do not remove empty *.symtypes explicitly
      modpost: remove useless export_from_sec()
      modpost: move export_from_secname() call to more relevant place
      modpost: remove redundant initializes for static variables
      modpost: remove annoying namespace_from_kstrtabns()
      kbuild: refactor cmd_modversions_c
      kbuild: refactor cmd_modversions_S
      kbuild: reuse suffix-search to refactor multi_depend
      kbuild: make multi_depend work with targets in subdirectory
      kbuild: reuse real-search to simplify cmd_mod
      kbuild: split the second line of *.mod into *.usyms
      kbuild: get rid of duplication in *.mod files
      kbuild: make *.mod not depend on *.o
      kbuild: read *.mod to get objects passed to $(LD) or $(AR)
      modpost: use snprintf() instead of sprintf() for safety
      modpost: do not write out any file when error occurred
      modpost: remove stale comment about sym_add_exported()
      modpost: add a separate error for exported symbols without definition
      modpost: retrieve the module dependency and CRCs in check_exports()
      modpost: move struct namespace_list to modpost.c
      kbuild: drop $(objtree)/ prefix support for clean-files
      ia64: make the install target not depend on any build artifact
      modpost: use bool type where appropriate
      modpost: change mod->gpl_compatible to bool type
      modpost: import include/linux/list.h
      modpost: traverse modules in order
      modpost: add sym_add_unresolved() helper
      modpost: traverse unresolved symbols in order
      modpost: use doubly linked list for dump_lists
      modpost: traverse the namespace_list in order
      modpost: dump Module.symvers in the same order of modules.order
      modpost: make multiple export error
      modpost: make sym_add_exported() always allocate a new symbol
      modpost: split new_symbol() to symbol allocation and hash table addition
      kbuild: factor out the common installation code into scripts/install.sh
      modpost: merge add_{intree_flag,retpoline,staging_flag} to add_header
      modpost: move *.mod.c generation to write_mod_c_files()
      kbuild: generate a list of objects in vmlinux
      kbuild: record symbol versions in *.cmd files
      modpost: remove left-over cross_compile declaration
      modpost: change the license of EXPORT_SYMBOL to bool type
      modpost: add sym_find_with_module() helper
      modpost: extract symbol versions from *.cmd files
      kbuild: link symbol CRCs at final link, removing CONFIG_MODULE_REL_CRCS
      kbuild: stop merging *.symversions
      genksyms: adjust the output format to modpost

Necip Fazil Yildiran (1):
      docs: kbuild: add references on Kconfig semantics

Nick Desaulniers (1):
      kbuild: uapi: use -fsyntax-only rather than -S

Randy Dunlap (1):
      Makefile: fix 2 typos

Reza Arbab (1):
      scripts/prune-kernel: Use kernel-install if available

Vincent Mailhol (1):
      checksyscalls: ignore -Wunused-macros

Yann Droneaud (1):
      kbuild: support W=e to make build abort in case of warning

 .gitignore                                |   1 +
 Documentation/kbuild/kconfig-language.rst |   6 +
 Makefile                                  |  16 +-
 arch/arm/Makefile                         |   4 +-
 arch/arm/boot/install.sh                  |  21 --
 arch/arm64/Makefile                       |   6 +-
 arch/arm64/boot/install.sh                |  21 --
 arch/ia64/Makefile                        |   5 +-
 arch/ia64/install.sh                      |  10 -
 arch/m68k/Makefile                        |   3 +-
 arch/m68k/include/asm/Kbuild              |   1 +
 arch/m68k/include/asm/export.h            |   2 -
 arch/m68k/install.sh                      |  22 --
 arch/nios2/Makefile                       |   3 +-
 arch/nios2/boot/install.sh                |  22 --
 arch/parisc/Makefile                      |  11 +-
 arch/parisc/install.sh                    |  28 --
 arch/powerpc/Kconfig                      |   1 -
 arch/powerpc/Makefile                     |   3 +-
 arch/powerpc/boot/Makefile                |   4 +-
 arch/powerpc/boot/install.sh              |  23 --
 arch/riscv/Makefile                       |   7 +-
 arch/riscv/boot/install.sh                |  21 --
 arch/s390/Kconfig                         |   1 -
 arch/s390/Makefile                        |   3 +-
 arch/s390/boot/install.sh                 |   6 -
 arch/sparc/Makefile                       |   3 +-
 arch/sparc/boot/install.sh                |  22 --
 arch/um/Kconfig                           |   1 -
 arch/x86/Makefile                         |   3 +-
 arch/x86/boot/install.sh                  |  22 --
 certs/Makefile                            |   4 +-
 include/asm-generic/export.h              |  22 +-
 include/linux/export-internal.h           |  17 +
 include/linux/export.h                    |  30 +-
 init/Kconfig                              |   4 -
 kernel/gen_kheaders.sh                    |   2 +-
 kernel/module.c                           |  10 +-
 scripts/Makefile                          |   4 +-
 scripts/Makefile.build                    | 133 +++-----
 scripts/Makefile.clean                    |   8 +-
 scripts/Makefile.extrawarn                |  13 +-
 scripts/Makefile.lib                      |   6 +-
 scripts/Makefile.vmlinux                  |  32 ++
 scripts/adjust_autoksyms.sh               |   2 +-
 scripts/checksyscalls.sh                  |   2 +-
 scripts/dummy-tools/pahole                |   4 +
 scripts/gen_autoksyms.sh                  |  18 +-
 scripts/genksyms/genksyms.c               |  18 +-
 scripts/install.sh                        |  40 +++
 scripts/kconfig/gconf-cfg.sh              |  12 +-
 scripts/kconfig/mconf-cfg.sh              |  16 +-
 scripts/kconfig/nconf-cfg.sh              |  16 +-
 scripts/kconfig/qconf-cfg.sh              |  14 +-
 scripts/link-vmlinux.sh                   |  40 +--
 scripts/mod/list.h                        | 213 ++++++++++++
 scripts/mod/modpost.c                     | 674
++++++++++++++++++++------------------
 scripts/mod/modpost.h                     |  31 +-
 scripts/mod/sumversion.c                  |  19 +-
 scripts/prune-kernel                      |   6 +-
 tools/objtool/Makefile                    |   4 +-
 usr/include/Makefile                      |   2 +-
 62 files changed, 874 insertions(+), 844 deletions(-)
 mode change 100644 => 100755 arch/arm/boot/install.sh
 mode change 100644 => 100755 arch/arm64/boot/install.sh
 mode change 100644 => 100755 arch/ia64/install.sh
 delete mode 100644 arch/m68k/include/asm/export.h
 mode change 100644 => 100755 arch/m68k/install.sh
 mode change 100644 => 100755 arch/nios2/boot/install.sh
 mode change 100644 => 100755 arch/parisc/install.sh
 mode change 100644 => 100755 arch/powerpc/boot/install.sh
 mode change 100644 => 100755 arch/riscv/boot/install.sh
 mode change 100644 => 100755 arch/s390/boot/install.sh
 mode change 100644 => 100755 arch/sparc/boot/install.sh
 mode change 100644 => 100755 arch/x86/boot/install.sh
 create mode 100644 include/linux/export-internal.h
 create mode 100644 scripts/Makefile.vmlinux
 create mode 100755 scripts/dummy-tools/pahole
 create mode 100755 scripts/install.sh
 create mode 100644 scripts/mod/list.h


-- 
Best Regards
Masahiro Yamada
