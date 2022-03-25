Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1E14E6C97
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 03:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357790AbiCYCkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 22:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348771AbiCYCkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 22:40:19 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657DE140C1;
        Thu, 24 Mar 2022 19:38:44 -0700 (PDT)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 22P2cK5R014979;
        Fri, 25 Mar 2022 11:38:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 22P2cK5R014979
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1648175901;
        bh=1iEqKEv3p6DCYf2RjWYDPtxspYJPBn8ZyBlRSDc7814=;
        h=From:Date:Subject:To:Cc:From;
        b=ua57p8pRk1Y6W356g+iAAn3jB9YYrlzV64cIXYy7GzFsphp02V0lMYglBd9ymLRye
         cvgPH5pYSKLlhz22B0w5lV4JFnEpSNWH2RYOhPzumihXDyCcGecESPl9DpuDhs5l9j
         NpMGe94iqVMGSA2A3haBWSoABGbZpydroO10zwGhCc0JqbxO3gBaTC3kIe1n4G3ckP
         lUm8FR9G2Zr0zIvkFe2LFytf7AhaOT7nS0yPrFbwh504vdlxZH+KqdIGFCdro91cEv
         fRRDYJ5hPfHM8BGoUkLQ5rWpsSPviFM97EEPgYvdBXCYvCT7cr7dlSq2LZeEScAmDE
         dBFFyeWmEGyWg==
X-Nifty-SrcIP: [209.85.214.177]
Received: by mail-pl1-f177.google.com with SMTP id c23so6739546plo.0;
        Thu, 24 Mar 2022 19:38:21 -0700 (PDT)
X-Gm-Message-State: AOAM533FkfGDFGBF0kOdRHgLm7C0Nr3tIMr/8dtwgaUuuGGUJIaVDIYx
        rUINRQRssu1QMcModWht5D1SFqPjh2NBIv2NXcg=
X-Google-Smtp-Source: ABdhPJxY6hxpbdG+DYEBnU4ESyAp/sR3o1zix37ioauarAILO6/BeL5fv1dQWCpzON8SXiOWRIojuRQ9DPCKQAVfgD0=
X-Received: by 2002:a17:90a:ab17:b0:1b9:b61a:aadb with SMTP id
 m23-20020a17090aab1700b001b9b61aaadbmr9756259pjq.77.1648175900182; Thu, 24
 Mar 2022 19:38:20 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 25 Mar 2022 11:37:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ2HET1QHG17m1vdCGMoRm6Lj=sAe+cj2Via_LHx3xBPg@mail.gmail.com>
Message-ID: <CAK7LNAQ2HET1QHG17m1vdCGMoRm6Lj=sAe+cj2Via_LHx3xBPg@mail.gmail.com>
Subject: [GIT PULL] Kbuild -std=gnu11 updates for v5.17-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
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

This is a small patch set for -std=gnu11 migration.
As you requested, I separated this out.
I will send the second pull request later for the rest
of kbuild updates.

Thank you.





The following changes since commit 754e0b0e35608ed5206d6a67a791563c631cec07:

  Linux 5.17-rc4 (2022-02-13 12:13:30 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
kbuild-gnu11-v5.18

for you to fetch changes up to 1e24078113ae69c741cb1b03375a9f1490db7308:

  Kbuild: use -std=gnu11 for KBUILD_USERCFLAGS (2022-03-13 17:31:44 +0900)

----------------------------------------------------------------
Kbuild -std=gnu11 updates for v5.18

Linus pointed out the benefits of C99 some years ago, especially variable
declarations in loops [1]. At that time, we were not ready for the
migration due to old compilers.

Recently, Jakob Koschel reported a bug in list_for_each_entry(), which
leaks the invalid pointer out of the loop [2]. In the discussion, we
agreed that the time had come. Now that GCC 5.1 is the minimum compiler
version, there is nothing to prevent us from going to -std=gnu99, or even
straight to -std=gnu11.

Discussions for a better list iterator implementation are ongoing, but
this patch set must land first.

[1] https://lore.kernel.org/all/CAHk-=wgr12JkKmRd21qh-se-_Gs69kbPgR9x4C+Es-yJV2GLkA@mail.gmail.com/
[2] https://lore.kernel.org/lkml/86C4CE7D-6D93-456B-AA82-F8ADEACA40B7@gmail.com/

----------------------------------------------------------------
Arnd Bergmann (3):
      Kbuild: add -Wno-shift-negative-value where -Wextra is used
      Kbuild: move to -std=gnu11
      Kbuild: use -std=gnu11 for KBUILD_USERCFLAGS

Mark Rutland (1):
      Kbuild: use -Wdeclaration-after-statement

 Documentation/process/programming-language.rst                    | 6 +++---
 Documentation/translations/it_IT/process/programming-language.rst | 4 ++--
 Documentation/translations/zh_CN/process/programming-language.rst | 3 +--
 Documentation/translations/zh_TW/process/programming-language.rst | 3 +--
 Makefile                                                          | 7 ++++---
 arch/arm64/kernel/vdso32/Makefile                                 | 3 ++-
 drivers/gpu/drm/i915/Makefile                                     | 1 +
 drivers/staging/greybus/tools/Makefile                            | 3 ++-
 fs/btrfs/Makefile                                                 | 1 +
 scripts/Makefile.extrawarn                                        | 1 +
 scripts/mod/modpost.c                                             | 4 +++-
 11 files changed, 21 insertions(+), 15 deletions(-)


-- 
Best Regards
Masahiro Yamada
