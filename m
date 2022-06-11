Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC71547752
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 21:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbiFKTkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 15:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiFKTkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 15:40:10 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B5F41F9C;
        Sat, 11 Jun 2022 12:40:09 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 25BJdrR9003088;
        Sun, 12 Jun 2022 04:39:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 25BJdrR9003088
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1654976394;
        bh=wXwin4eZEHI5KNc+Fb0GU/Ziv0HhoN29n1d+kI7kS0w=;
        h=From:Date:Subject:To:Cc:From;
        b=Szb/DGpO95ucjbFGmdNlPoM+S9a565QVlQciS7vQWVv9xvkq/za1ltLH8LZTjdUzq
         oBF07fEjfnAmvcn49qI771/jC24QWAhyB0wFHFSbD0Qj613WBAKkyBF/3VfTa0+vkP
         QxYUv3rugVvKApqvQAnkhzEdzo/wUyYDG9HVrbiJ+zpB7SXM3lliI00sG+R19OGkME
         t3vqr1HizQjcwTMCYp7gmK4vdHttWtLoZh+LRybfRHW1ZqnJCwPXSBTcVapkSI0F6f
         faSPDMPYMDg7bxxg+YWGCiYP/nlNorV7mC1+dl5mPIUhkjpuBs9s1FKwEXxfloXjE7
         kNBA6ZwxweqTw==
X-Nifty-SrcIP: [209.85.221.50]
Received: by mail-wr1-f50.google.com with SMTP id p10so2463602wrg.12;
        Sat, 11 Jun 2022 12:39:54 -0700 (PDT)
X-Gm-Message-State: AOAM530ASsHm90DK06uGul6plZUdXLReX1QiwoYIMDg+OHWjlqRQIlr4
        ayqfw1R3x61zWWx0RA/IyG9PCzgM0VReoLF89p0=
X-Google-Smtp-Source: ABdhPJxisRLn831bDoEEmivhcqtYmtpUx1HQs3fIaaEGBuody5EYkkwkU1LB971PD+IyZrq9GIWlmDIGAvfNf/cIk+0=
X-Received: by 2002:a5d:584f:0:b0:219:e106:3e02 with SMTP id
 i15-20020a5d584f000000b00219e1063e02mr11839388wrf.461.1654976392863; Sat, 11
 Jun 2022 12:39:52 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 12 Jun 2022 04:39:16 +0900
X-Gmail-Original-Message-ID: <CAK7LNASHyyT+tw-G8iNWt0sHmMUKr816sCXKfLpo-_GhVa=9WQ@mail.gmail.com>
Message-ID: <CAK7LNASHyyT+tw-G8iNWt0sHmMUKr816sCXKfLpo-_GhVa=9WQ@mail.gmail.com>
Subject: [GIT PULL] Kbuild fixes for v5.19-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

Please pull Kbuild fixes.
Thank you.




The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-fixes-v5.19

for you to fetch changes up to 1f7a6cf6b07c74a17343c2559cd5f5018a245961:

  scripts/gdb: change kernel config dumping method (2022-06-11 18:31:53 +0900)

----------------------------------------------------------------
Kbuild fixes for v5.19

 - Make the *.mod build rule portable for POSIX awk

 - Fix regression of 'make nsdeps'

 - Make scripts/check-local-export working for older bash versions

 - Fix scripts/gdb to extract the .config data from vmlinux

----------------------------------------------------------------
Kevin Locke (1):
      kbuild: avoid regex RS for POSIX awk

Kuan-Ying Lee (1):
      scripts/gdb: change kernel config dumping method

Masahiro Yamada (2):
      scripts/nsdeps: adjust to the format change of *.mod files
      scripts/check-local-export: avoid 'wait $!' for process substitution

 Documentation/process/changes.rst | 12 ++++++++++++
 scripts/Makefile.build            |  4 ++--
 scripts/check-local-export        | 36 +++++++++++++++++++++---------------
 scripts/gdb/linux/config.py       |  6 +++---
 scripts/nsdeps                    |  5 ++---
 5 files changed, 40 insertions(+), 23 deletions(-)


-- 
Best Regards
Masahiro Yamada
