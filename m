Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BC853D8AA
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 23:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242184AbiFDVpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 17:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234967AbiFDVpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 17:45:07 -0400
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB28E222B0;
        Sat,  4 Jun 2022 14:45:05 -0700 (PDT)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 254LiQQn016626;
        Sun, 5 Jun 2022 06:44:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 254LiQQn016626
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1654379066;
        bh=TZswrXPSsYEQPy7kKbDkBP6yUSxmUy7eNLA/GDSXu9w=;
        h=From:Date:Subject:To:Cc:From;
        b=r5JWkUFCjrvCJQqGLskt4jHL/05dztGHE31ewDvuQTu98c7pmGgsFaceBKMdvjVxf
         j8t0WGE2VvwxgAZf+fwH3HjvgfY70lTnymqQQJsp5GDVTR7V/zc0lfL2/uduCA99D8
         Cdg/J++7o/zrazNc2RFP8UFMZycHSMyiBcqauyeeIE8XPWyORaS5vjzaHfQif8/0/D
         4cgbKajqFlGw12NH4ZAC5SL6MFVX3gtzxWg5UosCzBbjmpKCPc6VqJ9kKAAFsIna1D
         tj28/Jw0LHcgZGNbQDZMyt4/cToeOTfM6sB6sFo7BELjOH1mQuZWZTZHMgH8SH+tt2
         7Om0lK8p5cSIQ==
X-Nifty-SrcIP: [209.85.214.175]
Received: by mail-pl1-f175.google.com with SMTP id q18so9309711pln.12;
        Sat, 04 Jun 2022 14:44:26 -0700 (PDT)
X-Gm-Message-State: AOAM531tq3ATMw68zshBRVx5hxt4qPy4NG8x2tXpyudzlqDvlH0SwQa1
        Jo6WKq4czrmM2hm5a68MSLKLU99du7/PgP7HMXE=
X-Google-Smtp-Source: ABdhPJx/UR1b6zk2T/FQGZUUiRhGt8bLbo1lmPWdIW1p+bHc4D6HLD+U2kk//mgOeuSyQwRloSU8pVhD/cfFlzoLbPA=
X-Received: by 2002:a17:90a:9b08:b0:1e2:837f:bcce with SMTP id
 f8-20020a17090a9b0800b001e2837fbccemr17919872pjp.144.1654379065586; Sat, 04
 Jun 2022 14:44:25 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 5 Jun 2022 06:43:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQsyk-bGm82PgbHtJmxgoJVhYtM9T6PMm6BD1vuHbwL6g@mail.gmail.com>
Message-ID: <CAK7LNAQsyk-bGm82PgbHtJmxgoJVhYtM9T6PMm6BD1vuHbwL6g@mail.gmail.com>
Subject: [GIT PULL v2] More Kbuild updates for v5.19-rc1
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

Please pull some more Kbuild updates for v5.19-rc1.

In v2, I dropped the modpost check, so this pull request
will not introduce new warnings.

(I will fix all the EXPORT_SYMBOL marked as __init later.
I will have a chance to get them in before -rc2 or -rc3
because it is really a bug.)


Thanks.




The following changes since commit 7e284070abe53d448517b80493863595af4ab5f0:

  Merge tag 'for-5.19/dm-changes' of
git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm
(2022-05-26 21:13:45 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-v5.19-3

for you to fetch changes up to 42ce60aa5aa46ae00f71aa806a11510b6db6d1a7:

  kbuild: Allow to select bash in a modified environment (2022-06-05
06:20:58 +0900)

----------------------------------------------------------------
Kbuild updates for v5.19 (2nd)

 - Fix build regressions for parisc, csky, nios2, openrisc

 - Simplify module builds for CONFIG_LTO_CLANG and CONFIG_X86_KERNEL_IBT

 - Remove arch/parisc/nm, which was presumably a workaround for old tools

 - Check the odd combination of EXPORT_SYMBOL and 'static' precisely

 - Make external module builds robust against "too long argument error"

 - Support j, k keys for moving the cursor in nconfig

----------------------------------------------------------------
Alexander Lobakin (1):
      modpost: fix removing numeric suffixes

Isak Ellmer (1):
      scripts: kconfig: nconf: make nconfig accept jk keybindings

Jing Leng (1):
      kbuild: Fix include path in scripts/Makefile.modpost

Masahiro Yamada (20):
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
      modpost: simplify mod->name allocation
      modpost: use fnmatch() to simplify match()

Schspa Shi (1):
      kbuild: Allow to select bash in a modified environment

Yuntao Wang (1):
      scripts/kallsyms: update usage message of the kallsyms program

 Makefile                   |   4 +--
 arch/parisc/Makefile       |   1 -
 arch/parisc/nm             |   6 ----
 scripts/Kbuild.include     |  10 ++++--
 scripts/Makefile.build     | 110
+++++++++++++++++++++++------------------------------------------
 scripts/Makefile.lib       |  31 +++++++++++++++----
 scripts/Makefile.modfinal  |   5 ++-
 scripts/Makefile.modpost   |  12 ++------
 scripts/Makefile.vmlinux_o |  87
+++++++++++++++++++++++++++++++++++++++++++++++++++
 scripts/check-local-export |  65 ++++++++++++++++++++++++++++++++++++++
 scripts/kallsyms.c         |   2 +-
 scripts/kconfig/nconf.c    |   8 +++--
 scripts/link-vmlinux.sh    | 126
++++++--------------------------------------------------------------------
 scripts/mod/file2alias.c   |   2 --
 scripts/mod/modpost.c      | 161
++++++++++++++++++++++-------------------------------------------------------------------------
 scripts/mod/modpost.h      |   3 ++
 scripts/objdiff            |   6 ++--
 17 files changed, 289 insertions(+), 350 deletions(-)
 delete mode 100644 arch/parisc/nm
 create mode 100644 scripts/Makefile.vmlinux_o
 create mode 100755 scripts/check-local-export


--
Best Regards
Masahiro Yamada
