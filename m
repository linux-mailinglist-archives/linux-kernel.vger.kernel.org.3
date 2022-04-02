Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97684F0565
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 20:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244934AbiDBSba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 14:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbiDBSb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 14:31:28 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2301FCCC;
        Sat,  2 Apr 2022 11:29:35 -0700 (PDT)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 232IT7Js009212;
        Sun, 3 Apr 2022 03:29:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 232IT7Js009212
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1648924148;
        bh=Oa7oBLuRLvD/B7fBD4A000HXNjk6EOGgj48TivDZZhY=;
        h=From:Date:Subject:To:Cc:From;
        b=2oGfyH3YM4bnjNI1QwZuCo7SvRcGN5MbaRsi4cX3CMl7dwxLSJv2f3h/6QBR7Mg6O
         e50y7KYhpZ0xPq5WkGOAA7Ghb+8qfEWhwhRf1Vi1AG8FrFDTNpdzHD4F5V7D0N5p/z
         L98mUPNzFdtxG6BJYdPbDrqPZAalszOCYzSe0XkdLnXjdkjPtdmSrT+o9tMUqLRFKf
         JUO59R8PFOMhNK8iAd1TZIDRa9YD01HEJRSD74nqwgxnRWphl5DJWstebZHYcrk/pa
         c2vzVDdtHYDnrWCw/W0ywsObVe9bsmK3jaYQKMxIoKeSM+xLgkJqFUWgp+89/BuQDh
         AKhDoghVmgUmA==
X-Nifty-SrcIP: [209.85.216.50]
Received: by mail-pj1-f50.google.com with SMTP id o3-20020a17090a3d4300b001c6bc749227so5349271pjf.1;
        Sat, 02 Apr 2022 11:29:07 -0700 (PDT)
X-Gm-Message-State: AOAM531Oc8wI+LjN8LJgqmFTU3sMLmjxdyH51eopjHIKkpOx1bDvwk6q
        ZbJ88fmLUZNT6PN8awt+DJ0b1OTNEGO/yFvUP6Y=
X-Google-Smtp-Source: ABdhPJz4kNlWZBvw0huT8+eWzttVQiQiFECQGXxgdgQFtP4Ii8nFHk/bSvJJ1YP5irmZvarnbSecgAxunGxY2/3ya6g=
X-Received: by 2002:a17:902:b183:b0:14f:c266:20d5 with SMTP id
 s3-20020a170902b18300b0014fc26620d5mr16203020plr.136.1648924147091; Sat, 02
 Apr 2022 11:29:07 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 3 Apr 2022 03:28:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNASN9Q40P6dUGSidT5=y0FA4pd+U93L17r8sH0j3VPum4A@mail.gmail.com>
Message-ID: <CAK7LNASN9Q40P6dUGSidT5=y0FA4pd+U93L17r8sH0j3VPum4A@mail.gmail.com>
Subject: [GIT PULL] Kbuild fixes for v5.18-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Please pull a couple of Kbuild fixes.
Thanks.



The following changes since commit e8b767f5e04097aaedcd6e06e2270f9fe5282696:

  Merge tag 'for-linus-5.18-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml (2022-03-31
16:16:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-fixes-v5.18

for you to fetch changes up to bf5c0c2231bcab677e5cdfb7f73e6c79f6d8c2d4:

  modpost: restore the warning message for missing symbol versions
(2022-04-03 03:11:51 +0900)

----------------------------------------------------------------
Kbuild fixes for v5.18

 - Fix empty $(PYTHON) expansion.

 - Fix UML, which got broken by the attempt to suppress Clang warnings.

 - Fix warning message in modpost.

----------------------------------------------------------------
Masahiro Yamada (3):
      kconfig: remove stale comment about removed kconfig_print_symbol()
      kbuild: fix empty ${PYTHON} in scripts/link-vmlinux.sh
      modpost: restore the warning message for missing symbol versions

Nathan Chancellor (2):
      kbuild: Remove '-mno-global-merge'
      Revert "um: clang: Strip out -mno-global-merge from USER_CFLAGS"

 Makefile                   | 4 ----
 arch/um/Makefile           | 4 ----
 scripts/kconfig/confdata.c | 7 -------
 scripts/link-vmlinux.sh    | 2 +-
 scripts/mod/modpost.c      | 2 +-
 5 files changed, 2 insertions(+), 17 deletions(-)


-- 
Best Regards
Masahiro Yamada
