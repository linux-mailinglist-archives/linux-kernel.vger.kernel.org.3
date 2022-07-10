Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FA356CF0A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 14:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiGJMe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 08:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiGJMez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 08:34:55 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6048B10FD4;
        Sun, 10 Jul 2022 05:34:54 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 26ACYVGp013659;
        Sun, 10 Jul 2022 21:34:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 26ACYVGp013659
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1657456472;
        bh=B2JTrFJTTdFfRiEQWLxjG92WpQ+NN8/ex/zjlQ5UzQQ=;
        h=From:Date:Subject:To:Cc:From;
        b=svZSzdI7CMecciwzPU/eLLXAUC/ZO3wkmACMX2gUTU4E0behpynjoWAFKWuzjQ4Uu
         wES0z5XfiARD5+0Ru1QhSSu01pMBKmYyc//DrsMi75ggRkZL1TUYy1swxw7BQDdX6u
         mAXRMCHOVrIU0abEk123qtFLYJE/k/rA4UqfoTKLecFJDJqo0uvuQ9H6Catgnv4tNa
         lktuyqt4lGU8weJI+vf2XzsskQowpQyFFTj6R1a+ml7JTifKF6iqg56tx3+GM3EjBM
         tx37CTgcaavEZqa7sGzWAsAOqUvEuxOiOWTm2igYhHGAcRw4AbBftfsndhLY29wD23
         Mfm+oODHBlilQ==
X-Nifty-SrcIP: [209.85.221.42]
Received: by mail-wr1-f42.google.com with SMTP id q9so3828229wrd.8;
        Sun, 10 Jul 2022 05:34:31 -0700 (PDT)
X-Gm-Message-State: AJIora9VMezEi6ajCldTYNLZOy/FBOO1Dr0sxYCd9HMxMVXmQZn5hrnc
        0fxKxa3l2abQZL20qtR00+MdJ7k7EbZyBIWe2sc=
X-Google-Smtp-Source: AGRyM1tHqIO9l40jo4uaZ0NIOAzYYnLNgFoLh08igUollBZVuxHvOsLrkCB6gIP20AM3ooZ57xg+vU/rAogbC2LkDl8=
X-Received: by 2002:a5d:4e08:0:b0:21d:a689:7dd1 with SMTP id
 p8-20020a5d4e08000000b0021da6897dd1mr554603wrt.477.1657456470327; Sun, 10 Jul
 2022 05:34:30 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 10 Jul 2022 21:33:42 +0900
X-Gmail-Original-Message-ID: <CAK7LNATwuZpJNN1hwmb==yBXs9msh+Yc7pCVMxujsB1885QakQ@mail.gmail.com>
Message-ID: <CAK7LNATwuZpJNN1hwmb==yBXs9msh+Yc7pCVMxujsB1885QakQ@mail.gmail.com>
Subject: [GIT PULL] Kbuild fixes for v5.19-rc6
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

Please pull Kbuild fixes.
Thanks.



The following changes since commit 03c765b0e3b4cb5063276b086c76f7a612856a9a:

  Linux 5.19-rc4 (2022-06-26 14:22:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-fixes-v5.19-3

for you to fetch changes up to f5a4618587fb5c5eb5fec3dcce165ca8fd7d7f91:

  kbuild: remove unused cmd_none in scripts/Makefile.modinst
(2022-07-10 21:25:15 +0900)

----------------------------------------------------------------
Kbuild fixes for v5.19 (3rd)

 - Adjust gen_compile_commands.py to the format change of *.mod files

 - Remove unused macro in scripts/Makefile.modinst

----------------------------------------------------------------
John Hubbard (1):
      gen_compile_commands: handle multiple lines per .mod file

Masahiro Yamada (1):
      kbuild: remove unused cmd_none in scripts/Makefile.modinst

 scripts/Makefile.modinst                    | 3 ---
 scripts/clang-tools/gen_compile_commands.py | 6 +++---
 2 files changed, 3 insertions(+), 6 deletions(-)


-- 
Best Regards
Masahiro Yamada
