Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079074B3C51
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 17:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237142AbiBMQyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 11:54:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbiBMQyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 11:54:05 -0500
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54B75B8A2;
        Sun, 13 Feb 2022 08:53:59 -0800 (PST)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 21DGrZBa021369;
        Mon, 14 Feb 2022 01:53:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 21DGrZBa021369
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1644771215;
        bh=+Gu+J7mpzu4zj8D3U0/ldielOugTejawUk0SIIRLLo8=;
        h=From:Date:Subject:To:Cc:From;
        b=xMnKIGbWLKeLUCUerR4+DlAwnoaMGoV3P0UzSF+4QUW5/L0fQIzyErwWErGbZpj5V
         o00syuK9O2DGGCifAWV/O5pfFbuz1VI6z+34H7bMwm9e24cwWxaBti6qPN8t9FPXUn
         jV/L2bts0quBsIKMYF0b+Exwf3vCuG1yT+syDYWx1EjROs0mbl95+rhIrMnMLmd+6b
         ONAYRAb8pE5mn4gKevpVknqprXgA6VpAyWFsrQXlCeDWozWZ5kPijMcjI9yDMtYpkN
         uoLWWX/oD2DUZRrRccsU61udrOJfROg6iEbRmBqg7N/2Oe1Dgsfo/RiuQjwn/VuGxV
         mMSVVDmD01QdQ==
X-Nifty-SrcIP: [209.85.210.180]
Received: by mail-pf1-f180.google.com with SMTP id z16so3317004pfh.3;
        Sun, 13 Feb 2022 08:53:35 -0800 (PST)
X-Gm-Message-State: AOAM531iWAm3lgii+yBUSVLibqUx/izJ3Cv8y9th9EqAUtOViZExC1TF
        vMJib+3FE2snvQgaFOC7yJ6wsDgUu0s8Al7Rkbw=
X-Google-Smtp-Source: ABdhPJwdHRdwc0VNZSrKWfiIqsTQQzypsaoaXI1wC1/d2WtS04xaCXFwbH3M3Y3hDdEGTmLtsCMeA2cTWuDqjmqeZEs=
X-Received: by 2002:a63:9307:: with SMTP id b7mr8826126pge.616.1644771214741;
 Sun, 13 Feb 2022 08:53:34 -0800 (PST)
MIME-Version: 1.0
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 14 Feb 2022 01:53:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNARgx5NDHT0RdLpogXRQadn8cZYw=D_kQ1jpC0ftJH1eyw@mail.gmail.com>
Message-ID: <CAK7LNARgx5NDHT0RdLpogXRQadn8cZYw=D_kQ1jpC0ftJH1eyw@mail.gmail.com>
Subject: [GIT PULL] Kbuild fixes for v5.17-rc4
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

Hi Linus,

Please pull Kbuild fixes.
Thanks.



The following changes since commit dfd42facf1e4ada021b939b4e19c935dcdd55566:

  Linux 5.17-rc3 (2022-02-06 12:20:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-fixes-v5.17-2

for you to fetch changes up to 1b9e740a81f91ae338b29ed70455719804957b80:

  kconfig: fix failing to generate auto.conf (2022-02-12 23:24:19 +0900)

----------------------------------------------------------------
 - Fix the truncated path issue for HAVE_GCC_PLUGINS test in Kconfig

 - Move -Wunsligned-access to W=1 builds to avoid sprinkling warnings for
   the latest Clang

 - Fix missing fclose() in Kconfig

 - Fix Kconfig to touch dep headers correctly when KCONFIG_AUTOCONFIG is
   overridden.

----------------------------------------------------------------
Brenda Streiff (1):
      kconfig: let 'shell' return enough output for deep path names

Jing Leng (1):
      kconfig: fix failing to generate auto.conf

Masahiro Yamada (1):
      kconfig: fix missing fclose() on error paths

Nathan Chancellor (1):
      Makefile.extrawarn: Move -Wunaligned-access to W=1

 scripts/Makefile.extrawarn   |  1 +
 scripts/kconfig/confdata.c   | 25 +++++++++++++++----------
 scripts/kconfig/preprocess.c |  2 +-
 3 files changed, 17 insertions(+), 11 deletions(-)

-- 
Best Regards
Masahiro Yamada
