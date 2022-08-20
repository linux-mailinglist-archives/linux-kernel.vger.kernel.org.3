Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FB759AF60
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 20:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiHTSII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 14:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiHTSIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:08:05 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEE333409;
        Sat, 20 Aug 2022 11:08:04 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 27KI7p6l015563;
        Sun, 21 Aug 2022 03:07:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 27KI7p6l015563
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1661018872;
        bh=FeKZHjTdfUk4w1z7Mg9u17SjMLtylIKx4GxJxFhubsI=;
        h=From:Date:Subject:To:Cc:From;
        b=iQHvwLiJ6H+FnXnJy6H7RWbreVoh89NfucfaSFJ4HS+KqU6qd8kghgeOt/D/myYaP
         V9DcAwpo0JeoaArrL422LeE6mKykmaMW60oVgnZDyL7yuZhwGAyRNYeXLTdlhokq9X
         CUZT2KOISImFSF6bAEFbp6LXCqaJA577czMZ+pGMTrTTHqewdb98/8DANqfcH9dQOJ
         97cnqM/u7jLXi6GnEr2hLXXBBMNC6pN3RKmJe7bw3m8D7sIEM49fd4ILpipjmWE8sh
         BY4h24rS+sbTZivhhfkleVIG/0atqluT2XXMTpiyzASIu0B3q2keHUstWE6YUK546R
         +589/DSjMqg1A==
X-Nifty-SrcIP: [209.85.221.52]
Received: by mail-wr1-f52.google.com with SMTP id h24so8559518wrb.8;
        Sat, 20 Aug 2022 11:07:51 -0700 (PDT)
X-Gm-Message-State: ACgBeo1Ik4c5eKHELOuZZ1TD7RFQFFO9UY5v0h2+XeOo2prmJE2Ls6fK
        8azEyXfM0JVeLFBkNsbq1AqSA2hMaUVJh3EXWOY=
X-Google-Smtp-Source: AA6agR4TasFP18ZxhVawsw1UwGnDki15bB7tF77Y96KPQcoE6yovSm6Sya5lA2Lg29iUTaLPAX71nUQQjP/u9X4Ulx0=
X-Received: by 2002:a5d:6248:0:b0:222:cd3b:94c8 with SMTP id
 m8-20020a5d6248000000b00222cd3b94c8mr7118916wrv.97.1661018870405; Sat, 20 Aug
 2022 11:07:50 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 21 Aug 2022 03:07:03 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS55=qvacmoL3Ooio3yqYR9PLBjRjyp=ZWgdHojO1meoQ@mail.gmail.com>
Message-ID: <CAK7LNAS55=qvacmoL3Ooio3yqYR9PLBjRjyp=ZWgdHojO1meoQ@mail.gmail.com>
Subject: [GIT PULL] Kbuild fixes for v6.0-rc2
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

Please pull some Kbuild fixes.
Thanks.





The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-fixes-v6.0

for you to fetch changes up to 4be72c1b9f298b4ad42391322eaddef64b282716:

  scripts/clang-tools: Remove DeprecatedOrUnsafeBufferHandling check
(2022-08-21 02:47:49 +0900)

----------------------------------------------------------------
Kbuild fixes for v6.0

 - Fix module versioning broken on some architectures

 - Make dummy-tools enable CONFIG_PPC_LONG_DOUBLE_128

 - Remove -Wformat-zero-length, which has no warning instance

 - Fix the order between drivers and libs in modules.order

 - Fix false-positive warnings in clang-analyzer

----------------------------------------------------------------
Guru Das Srinagesh (1):
      scripts/clang-tools: Remove DeprecatedOrUnsafeBufferHandling check

Jiri Slaby (1):
      kbuild: dummy-tools: pretend we understand __LONG_DOUBLE_128__

Masahiro Yamada (2):
      modpost: fix module versioning when a symbol lacks valid CRC
      kbuild: fix the modules order between drivers and libs

Nathan Chancellor (1):
      scripts/Makefile.extrawarn: Do not disable clang's -Wformat-zero-length

 Makefile                               | 6 ++----
 scripts/Makefile.extrawarn             | 1 -
 scripts/clang-tools/run-clang-tools.py | 1 +
 scripts/dummy-tools/gcc                | 2 +-
 scripts/mod/modpost.c                  | 4 +---
 5 files changed, 5 insertions(+), 9 deletions(-)

-- 
Best Regards
Masahiro Yamada
