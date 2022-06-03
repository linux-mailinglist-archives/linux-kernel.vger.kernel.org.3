Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6DD853CD62
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 18:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344018AbiFCQmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 12:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344016AbiFCQm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 12:42:28 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4603C20F59;
        Fri,  3 Jun 2022 09:42:24 -0700 (PDT)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 253GgCmp011652;
        Sat, 4 Jun 2022 01:42:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 253GgCmp011652
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1654274532;
        bh=yeHGROGgbK4ZtRP+aoNmEv3uwEdHyworLe+EdpnLaBU=;
        h=From:Date:Subject:To:Cc:From;
        b=zyRdKRiYx5cNZ4ObzshnjPL8qhVw/KWy1FgTTeWLXepbfA07VLVV+IuiW868k1ZTn
         6Xfc6BDq4Dv09Qx2/DTvQ4aAoswbPXXNpSPPh7V8g+lXxGy+fe95oqMHm2CW9onW0A
         L8h3Gtfqpm/8g7ro3vKRgfj5TkpbYJ28HO31IG1YmWbzFxbMOzvHw66khRiMK3XiQa
         AIF8EGDiysSt4CettB9tenSWdu3nwu3WBlzt95fKfVW6TCNWBlqCq8je72fM2TLoUB
         cxBbOcNtZSOkICSsjftK7fCOiUX4W/2z2PEWCdTezJdsarlN1TN5iiDnLKnhbNWPwU
         YLcLeyLWliDUw==
X-Nifty-SrcIP: [209.85.216.41]
Received: by mail-pj1-f41.google.com with SMTP id mh16-20020a17090b4ad000b001e8313301f1so1364522pjb.1;
        Fri, 03 Jun 2022 09:42:12 -0700 (PDT)
X-Gm-Message-State: AOAM531namLTXVMkdXjMO7iyQbgFz0B3N4TMv07RW3q8MHkV0UBPqwi7
        i4mjZbISYrpiWa6QbXqniRfpDkAXBkZYHvgN4XQ=
X-Google-Smtp-Source: ABdhPJxHo6VZqqWkDO+TDZ4O9ktUO8dFFGtstq27pXaTfQ1g9JAElmHPT8dkuyO8E7sOYpBCzMeCAZd4Vqf8N3XrffM=
X-Received: by 2002:a17:902:f687:b0:167:58bb:c43f with SMTP id
 l7-20020a170902f68700b0016758bbc43fmr1121607plg.136.1654274531556; Fri, 03
 Jun 2022 09:42:11 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 4 Jun 2022 01:41:35 +0900
X-Gmail-Original-Message-ID: <CAK7LNATHyNjCaK+agk=DOTR8sPaOP9kBvS_xYaBUHfF+5Fzftg@mail.gmail.com>
Message-ID: <CAK7LNATHyNjCaK+agk=DOTR8sPaOP9kBvS_xYaBUHfF+5Fzftg@mail.gmail.com>
Subject: [GIT PULL] More Kbuild updates for v5.19-rc1
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

Please pull some more Kbuild updates for v5.19-rc1.
Thanks.




The following changes since commit 7e284070abe53d448517b80493863595af4ab5f0:

  Merge tag 'for-5.19/dm-changes' of
git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm
(2022-05-26 21:13:45 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-v5.19-2

for you to fetch changes up to 37447c4c4735ea34c7388217da2f4c160b4366ca:

  scripts: objdiff: fix stale comments about .tmp_objdiff (2022-06-04
01:30:10 +0900)

----------------------------------------------------------------
Kbuild updates for v5.19 (2nd)

 - Fix build regressions for parisc, csky, nios2, openrisc

 - Simplify module builds for CONFIG_LTO_CLANG and CONFIG_X86_KERNEL_IBT

 - Remove arch/parisc/nm, which was presumably a workaround for old tools

 - Check the odd combination of EXPORT_SYMBOL and 'static' precisely

 - Make external module builds robust against "too long argument error"

 - Fix modpost to detect EXPORT_SYMBOL marked as __init or__exit
   (This uncovered a couple of potential issues of exported symbols)

 - Support j, k keys for moving the cursor in nconfig

----------------------------------------------------------------
Alexander Lobakin (1):
      modpost: fix removing numeric suffixes

Isak Ellmer (1):
      scripts: kconfig: nconf: make nconfig accept jk keybindings

Jing Leng (1):
      kbuild: Fix include path in scripts/Makefile.modpost

Masahiro Yamada (22):
      modpost: fix undefined behavior of is_arm_mapping_symbol()
      modpost: remove the unused argument of check_sec_ref()
      modpost: reuse ARRAY_SIZE() macro for section_mismatch()
      modpost: squash if...else-if in find_elf_symbol2()
      kbuild: replace $(if A,A,B) with $(or A,B) in scripts/Makefile.modpost
      kbuild: do not try to parse *.cmd files for objects provided by compiler
      kbuild: replace $(linked-object) with CONFIG options
      kbuild: do not create *.prelink.o for Clang LTO or IBT
      parisc: remove arch/parisc/nm
      kbuild: check static EXPORT_SYMBOL* by script instead of modpost
      kbuild: make built-in.a rule robust against too long argument error
      kbuild: make *.mod rule robust against too long argument error
      kbuild: add cmd_and_savecmd macro
      kbuild: rebuild multi-object modules when objtool is updated
      kbuild: remove redundant cleanups in scripts/link-vmlinux.sh
      kbuild: clean .tmp_* pattern by make clean
      kbuild: move vmlinux.o link to scripts/Makefile.vmlinux_o
      kbuild: factor out the common objtool arguments
      modpost: fix section mismatch check for exported init/exit sections
      modpost: simplify mod->name allocation
      modpost: use fnmatch() to simplify match()
      scripts: objdiff: fix stale comments about .tmp_objdiff

Schspa Shi (1):
      kbuild: Allow to select bash in a modified environment

Yuntao Wang (1):
      scripts/kallsyms: update usage message of the kallsyms program

 Makefile                   |   4 +-
 arch/parisc/Makefile       |   1 -
 arch/parisc/nm             |   6 ---
 scripts/Kbuild.include     |  10 ++++-
 scripts/Makefile.build     | 110
++++++++++++++++++----------------------------------
 scripts/Makefile.lib       |  31 ++++++++++++---
 scripts/Makefile.modfinal  |   5 +--
 scripts/Makefile.modpost   |  12 ++----
 scripts/Makefile.vmlinux_o |  87 ++++++++++++++++++++++++++++++++++++++++++
 scripts/check-local-export |  65 +++++++++++++++++++++++++++++++
 scripts/kallsyms.c         |   2 +-
 scripts/kconfig/nconf.c    |   8 +++-
 scripts/link-vmlinux.sh    | 126
+++++-------------------------------------------------------
 scripts/mod/file2alias.c   |   2 -
 scripts/mod/modpost.c      | 163
++++++++++++++++++------------------------------------------------------------
 scripts/mod/modpost.h      |   3 ++
 scripts/objdiff            |   6 +--
 17 files changed, 290 insertions(+), 351 deletions(-)
 delete mode 100644 arch/parisc/nm
 create mode 100644 scripts/Makefile.vmlinux_o
 create mode 100755 scripts/check-local-export


-- 
Best Regards
Masahiro Yamada
