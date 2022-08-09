Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43AF458DCD2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 19:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245144AbiHIRIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 13:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245092AbiHIRIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 13:08:10 -0400
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66941DA49;
        Tue,  9 Aug 2022 10:08:07 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 279H7VxJ019248;
        Wed, 10 Aug 2022 02:07:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 279H7VxJ019248
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1660064852;
        bh=rr3DZMLkaG4oy2qKkuCOhZ3c8Lq3XQ930xsc+I0K9ew=;
        h=From:Date:Subject:To:Cc:From;
        b=qJguDYMeNsaC/InxaBEa/ZyKlgMIpwjbDS31AT0tGW6kT2aY0zbgKcOHFvIG4RqIU
         UxL8DBNAYRB3ANio722tdnab2bSE/CmPD68GVD7haQdMKyIbZ0MqGW+Bp4qdMxU/Zi
         pTuCGM1MmWbYpJMA7q04e1xN/6sOhexLFzV6bk0RUXF46pi1TzqPz6O+l7FSZo6I4n
         33D/LsTnJOAY2e2eoKkoVqPH8vb1EXVwfATNUGN2AtzawnRBVoCbZcbd4YF2qzPLD+
         8lOKp/4btXYs01TaIpr7E9sGDxfRzcOaA63lYapIHw5++d9uRp7XTIhuYIi7lv+ccj
         sh8GJtmNRM+3A==
X-Nifty-SrcIP: [209.85.221.51]
Received: by mail-wr1-f51.google.com with SMTP id p10so14995026wru.8;
        Tue, 09 Aug 2022 10:07:31 -0700 (PDT)
X-Gm-Message-State: ACgBeo2iHKPcA9t/j4n7j+UaarYXwQGE7aNTnGBhIuofoQS2rd8/feUv
        b7l/CS2igPDamg1iqHgBdO6ZWIRx3pqtxw09rkk=
X-Google-Smtp-Source: AA6agR7bSLbQfQnSdmzzw7nHJvS9NI1lXFc5N5lcXvW3wdR+L0bY5y529wqH9BxszkqPrq5v9OlXUC6v7IFrvJQezOI=
X-Received: by 2002:a5d:54cb:0:b0:220:6426:6219 with SMTP id
 x11-20020a5d54cb000000b0022064266219mr14357759wrv.461.1660064850247; Tue, 09
 Aug 2022 10:07:30 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 10 Aug 2022 02:06:51 +0900
X-Gmail-Original-Message-ID: <CAK7LNATwE1L4oS6R=7gHfiE6+9Dksvtvu-BGE07N6=JHVQ5hKQ@mail.gmail.com>
Message-ID: <CAK7LNATwE1L4oS6R=7gHfiE6+9Dksvtvu-BGE07N6=JHVQ5hKQ@mail.gmail.com>
Subject: [GIT PULL] Kbuild updates for v5.20-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Please pull Kbuild updates for v5.20-rc1.
Thank you.




The following changes since commit 32346491ddf24599decca06190ebca03ff9de7f8:

  Linux 5.19-rc6 (2022-07-10 14:40:51 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-v5.20

for you to fetch changes up to 672fb6740cbfde34f4d367ffa3c939b608a927e1:

  modpost: remove .symbol_white_list field entirely (2022-08-04 20:32:13 +0900)

----------------------------------------------------------------
Kbuild updates for v5.20

 - Remove the support for -O3 (CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3)

 - Fix error of rpm-pkg cross-builds

 - Support riscv for checkstack tool

 - Re-enable -Wformwat warnings for Clang

 - Clean up modpost, Makefiles, and misc scripts

----------------------------------------------------------------
Baruch Siach (2):
      init/Kconfig: update KALLSYMS_ALL help text
      docs: kbuild: fix typo

Justin Stitt (1):
      Makefile.extrawarn: re-enable -Wformat for clang

Masahiro Yamada (22):
      certs: move scripts/check-blacklist-hashes.awk to certs/
      certs: unify blacklist_hashes.c and blacklist_nohashes.c
      kbuild: remove sed command from cmd_ar_builtin
      Revert "scripts/mod/modpost.c: permit '.cranges' secton for sh64
architecture."
      kbuild: rpm-pkg: fix build error when _arch is undefined
      kbuild: rpm-pkg: pass 'linux' to --target option of rpmbuild
      kbuild: error out if $(KBUILD_EXTMOD) contains % or :
      kbuild: error out if $(INSTALL_MOD_PATH) contains % or :
      kconfig: shorten the temporary directory name for cc-option
      modpost: drop executable ELF support
      modpost: use sym_get_data() to get module device_table data
      kbuild: add dtbs_prepare target
      modpost: remove unused Elf_Sword macro
      kbuild: set EXIT trap before creating temporary directory
      modpost: refactor get_secindex()
      modpost: add array range check to sec_name()
      modpost: use more reliable way to get fromsec in section_rel(a)()
      Revert "Kbuild, lto, workaround: Don't warn for
initcall_reference in modpost"
      modpost: shorten warning messages in report_sec_mismatch()
      modpost: add PATTERNS() helper macro
      modpost: remove unneeded .symbol_white_list initializers
      modpost: remove .symbol_white_list field entirely

Nick Desaulniers (1):
      kbuild: drop support for CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3

Nicolas Schier (1):
      scripts: headers_install.sh: Update config leak ignore entries

Ondrej Mosnacek (1):
      kbuild: dummy-tools: avoid tmpdir leak in dummy gcc

Randy Dunlap (1):
      kconfig: Qt5: tell the user which packages are required

Wadim Mueller (1):
      checkstack: add riscv support for scripts/checkstack.pl

 Documentation/kbuild/kconfig-language.rst                     |   2 +-
 MAINTAINERS                                                   |   1 -
 Makefile                                                      |  18 ++-
 arch/arc/configs/axs101_defconfig                             |   1 -
 arch/arc/configs/axs103_defconfig                             |   1 -
 arch/arc/configs/axs103_smp_defconfig                         |   1 -
 arch/arc/configs/haps_hs_defconfig                            |   1 -
 arch/arc/configs/haps_hs_smp_defconfig                        |   1 -
 arch/arc/configs/hsdk_defconfig                               |   1 -
 arch/arc/configs/nsim_700_defconfig                           |   1 -
 arch/arc/configs/nsimosci_defconfig                           |   1 -
 arch/arc/configs/nsimosci_hs_defconfig                        |   1 -
 arch/arc/configs/nsimosci_hs_smp_defconfig                    |   1 -
 arch/arc/configs/tb10x_defconfig                              |   1 -
 arch/arc/configs/vdk_hs38_defconfig                           |   1 -
 arch/arc/configs/vdk_hs38_smp_defconfig                       |   1 -
 certs/Makefile                                                |  14 +-
 certs/blacklist_hashes.c                                      |   1 -
 certs/blacklist_nohashes.c                                    |   6 -
 {scripts => certs}/check-blacklist-hashes.awk                 |   0
 init/Kconfig                                                  |  16 +-
 scripts/Kconfig.include                                       |   2 +-
 scripts/Makefile.build                                        |   5 +-
 scripts/Makefile.compiler                                     |   2 +-
 scripts/Makefile.extrawarn                                    |   1 -
 scripts/Makefile.modinst                                      |   3 +
 scripts/Makefile.package                                      |   4 +-
 scripts/checkstack.pl                                         |   4 +
 scripts/dummy-tools/dummy-plugin-dir/include/plugin-version.h |   0
 scripts/dummy-tools/gcc                                       |   8 +-
 scripts/headers_install.sh                                    |   2 -
 scripts/kconfig/qconf-cfg.sh                                  |   1 +
 scripts/mod/file2alias.c                                      |   4 +-
 scripts/mod/modpost.c                                         | 281
++++++-----------------------------
 scripts/mod/modpost.h                                         |  33 ++--
 scripts/package/mkspec                                        |   3 +
 36 files changed, 111 insertions(+), 313 deletions(-)
 delete mode 100644 certs/blacklist_nohashes.c
 rename {scripts => certs}/check-blacklist-hashes.awk (100%)
 create mode 100644
scripts/dummy-tools/dummy-plugin-dir/include/plugin-version.h

-- 
Best Regards
Masahiro Yamada
