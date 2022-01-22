Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5E7496CCD
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 16:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234113AbiAVPSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 10:18:51 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:50789 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233950AbiAVPSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 10:18:49 -0500
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 20MFIZF3021588;
        Sun, 23 Jan 2022 00:18:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 20MFIZF3021588
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1642864716;
        bh=vtxhSxgWZauK31VQ+JzIFDuJH0VqZNP5FvASN3RMRQE=;
        h=From:Date:Subject:To:Cc:From;
        b=AbQB+MPC7aybdHZgGMC99Y2NFTphZI1AY1q+pr2X+lXK3lpHtB0xp4AcG9QtdKYAo
         L8K+OOQHhdc6g+tXFXi8NkfbkAoJ1/Vvfnmt8Gv9pWHca6UppZ4pRl2HiUrMoB4i3p
         YliduxpbGniFUhcN7aT0jvZ3kZotrSdgFZeqDB2xMBUvWI7x0mufAXrzOXBhWXzSTa
         B4eUvd10nhwaX7W03KcxKgXunHZsfbHcWk8jCZ3XSKNU6ENL1FCPPG9NupyB8tMcdn
         anYZR6LSsFmOD9qRq3ZcYj+sdWXOpGK5ED/ThWwFezFkFW69XOl43B87IMaAulqXsK
         n2/DSuIfRmQYQ==
X-Nifty-SrcIP: [209.85.215.181]
Received: by mail-pg1-f181.google.com with SMTP id e16so1497238pgn.4;
        Sat, 22 Jan 2022 07:18:36 -0800 (PST)
X-Gm-Message-State: AOAM532a5Tu1e/Ve80juj9i61pbKTBOnFHxy4BJjOdras32cl1x1g42J
        Y+X7KTGgqoIiKUrlFSoVTIlgIonM6Ng3IsVNgAY=
X-Google-Smtp-Source: ABdhPJycp1naosm2wQCbiCmcaaIi5n3CRrIFf5KBwH5N+y9k3UimPFBiyAliLFeaSLQF9McXng3zTTZLTxbQqGDTU68=
X-Received: by 2002:a63:7148:: with SMTP id b8mr6359140pgn.616.1642864715434;
 Sat, 22 Jan 2022 07:18:35 -0800 (PST)
MIME-Version: 1.0
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 23 Jan 2022 00:17:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNASs0jntOj63GoE9Lhasb-7zmVzBcq35CDeKnBqjG_v+kw@mail.gmail.com>
Message-ID: <CAK7LNASs0jntOj63GoE9Lhasb-7zmVzBcq35CDeKnBqjG_v+kw@mail.gmail.com>
Subject: [GIT PULL] Kbuild fixes for v5.17-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull Kbuild fixes.
Thanks.



The following changes since commit 1c52283265a462a100ae63ddf58b4e5884acde86:

  Merge branch 'akpm' (patches from Andrew) (2022-01-22 11:28:23 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-fixes-v5.17

for you to fetch changes up to e6340b6526eeec5a00fe26a6ff515afe7d0affa4:

  certs: Fix build error when CONFIG_MODULE_SIG_KEY is empty
(2022-01-23 00:08:44 +0900)

----------------------------------------------------------------
Kbuild fixes for v5.17

 - Bring include/uapi/linux/nfc.h into the UAPI compile-test coverage

 - Revert the workaround of CONFIG_CC_IMPLICIT_FALLTHROUGH

 - Fix build errors in certs/Makefile

----------------------------------------------------------------
Dmitry V. Levin (1):
      usr/include/Makefile: add linux/nfc.h to the compile-test coverage

Masahiro Yamada (3):
      Revert "Makefile: Do not quote value for CONFIG_CC_IMPLICIT_FALLTHROUGH"
      certs: Fix build error when CONFIG_MODULE_SIG_KEY is PKCS#11 URI
      certs: Fix build error when CONFIG_MODULE_SIG_KEY is empty

 Makefile             | 2 +-
 certs/Makefile       | 4 ++--
 usr/include/Makefile | 1 -
 3 files changed, 3 insertions(+), 4 deletions(-)

-- 
Best Regards
Masahiro Yamada
