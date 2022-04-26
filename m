Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C746E5101BE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245232AbiDZPXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352364AbiDZPXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:23:13 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570DD369E0;
        Tue, 26 Apr 2022 08:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650986324;
        bh=E+Hg8XB0uplXpNREVgCkI8/u05xO4CQqpmVf+gTT7wY=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=bo5MO2ICe2f0JE3WvbKHu5Reo0qEuFJrDy3qzhFhqykQZp//CmngMH2g4Mz2h45l0
         PzZRoRS1cAW/OTlGbT9aGGf0qrBx2zBGiwsqjpguirMQPGwV/KW40dvuY3Zsi7oRsZ
         nymvB5JZBAM3T/Arn4EBr0euhSr+5uI90881qnhw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530 ([92.116.164.205]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3bSt-1ntEgR2owV-010ZBp; Tue, 26
 Apr 2022 17:18:44 +0200
Date:   Tue, 26 Apr 2022 17:18:42 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [GIT PULL] fbdev updates & fixes for v5.18-rc5
Message-ID: <YmgNUgK/FeNcX0MG@ls3530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:yiY1Xgsfm/t116KfFvkQOFaBDvx2+7IMm7NAfFr/xG2YuqgxNS4
 msZ6vS75sv5bAowYt1Qs2CKdelJ0gy0w44CV6mZmDUVZC59OjpObznSVs5CT3dSnZteE76u
 uyd2Hc7mVwfVT925LAeRZ8eBrRicyqAJZathX1NBGxvF+IEkfe972l0G5O+HUFdJ65ne6Ku
 R4hk2BKWUPA1tCW6FMlkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qL696Dzs5uQ=:UgDe8enbU4oVBhSd5mi6qa
 IhAkDUaWzXEfYhkhoAcnISx9WdHfpt4Sr1DHI1uuf242oyhisrzqZ4X3XIwOLGUuuupL+j17a
 JhbE+VSaXo3d3vUW44m0UVrAI2nxfrBlYJRMRbJOo/KKd5oSWH9w1MJ1qnbFStRAxbn5WHBGN
 AMpcW5HK7NJIfvSmU+jkDpW7OXCDk9tc88yY24FjIUpzjwyIHO+30G/B2Tjrm7BgYsJMV5dJv
 CONMrivpkBSt8sy/TdEpGrBXtOD6Y3ii5lv6nunFyQtqiAIDTZR4Acvlxtk8PLUxDJDI1Sbq2
 NLO1Ilpu92wzOpxIm48xuMNsSkPRs97TaU/zpIw1eyytVGfz2U8JFSh92w15cqdUGh9XQLLJ7
 uCfF5XAdbcja+eDMFzN0NdXeEmD5h39oZ8gGsDuHGea7pPOzcF/ZMRlB7CkS9TTc8Wl1sat+l
 m7OXTUjx+BqXEHJO/gJ8ZIWKp+2TW67bOdxCjJVKY3XWXWql9T3UoBONTqgUxhndpChjG4Pmy
 9L7e0HzMj/fSIv4e7E4z8hUZuJxVpgfdvTDqFOrZwFTLr++keYQgRLrznNNTWxr1KOHiYUkYA
 k/LZ0XHp3+Gwk3b2fiJfa29bQyFBcQrJnJv80FBiZZeS9zOk08Q8eemr8sA0kLGEqIll1Xi6z
 B2S+5DI98Og9LnyTHkBJCfmQ4jlK+M659NfTVQLBopHFeSHzmgIOkgl/JOIo5a9hfdX7j2LYm
 IekoV9V89QJUIzKYIskkMor7sIo5iqz8DqtTrgFMTIKlqOOyl1xfuhNdZ5VyE3cF3eDjvPJ7D
 UiFdX91QFUBCocsSREsqAT/ebGu8uoyXeqnVYHpbro4JAgGs8jpGdyI3ZOtT2apYpdiXm6uOl
 YZGDMgEqlaXabGCeyooikuoFgvTBlo4bhVU7sSUIDFc9fK0nh6s9cq3Vlm7NNLqM0lEo9mid6
 kiqEI76hJF5nBV+vxAGBF9FYGGcd93y2CnFUa6wE063hJhja71xxUF8Cfbh0Hs8lZzq13jSdF
 DsSGC6kdMMUGDmJ80QOvrfVKl6+RMhmVtk7lWY0VL9FFO+ZNV7FJ4mHTnsU2RX4WCw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I've finished checking all outstanding fbdev patches which had queued up
during the last few months. This is now the last bunch.
All are either trivial and/or small.
The changelog is below.

Please pull.

Thanks,
Helge

----------------------------------------------------------------
The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/for-5.18/fbdev-2

for you to fetch changes up to 6fbe0cc53a1b5f7abe2c44399c18e943adbebe2f:

  video: fbdev: clps711x-fb: Use syscon_regmap_lookup_by_phandle (2022-04-25 20:12:12 +0200)

----------------------------------------------------------------
fbdev fixes and updates for kernel v5.18-rc5

A bunch of outstanding fbdev patches:

neofb:
	Fix the check of 'var->pixclock'

kyro, vt8623fb, tridentfb, arkfb, s3fb, i740fb:
	Error out if 'lineclock' equals zero

sis:
	Fix potential NULL dereference in sisfb_post_sis300()

fb.h:
	Spelling fix: palette/palette/

pm2fb:
	Fix kernel-doc formatting issue

clps711x-fb:
	Use syscon_regmap_lookup_by_phandle()

of:
	display_timing: Remove a redundant zeroing of memory

aty & matrox:
	Cleanup for powerpc's asm/prom.h

sh_mobile_lcdcfb:
	Remove sh_mobile_lcdc_check_var() declaration

mmp:
	Replace usage of found with dedicated list iterator variable

omap:
	Make it CCF clk API compatible

imxfb:
	Fix missing of_node_put in imxfb_probe

i740fb:
	Use memset_io() to clear screen

udlfb:
	Properly check endpoint type

pxafb:
	Use if else instead

----------------------------------------------------------------
Alexander Shiyan (1):
      video: fbdev: clps711x-fb: Use syscon_regmap_lookup_by_phandle

Christophe JAILLET (1):
      video: fbdev: of: display_timing: Remove a redundant zeroing of memory

Christophe Leroy (1):
      video: fbdev: aty/matrox/...: Prepare cleanup of powerpc's asm/prom.h

Geert Uytterhoeven (2):
      linux/fb.h: Spelling s/palette/palette/
      video: fbdev: sh_mobile_lcdcfb: Remove sh_mobile_lcdc_check_var() declaration

Haowen Bai (2):
      video: fbdev: sis: fix potential NULL dereference in sisfb_post_sis300()
      video: fbdev: pm2fb: Fix a kernel-doc formatting issue

Jakob Koschel (1):
      video: fbdev: mmp: replace usage of found with dedicated list iterator variable

Janusz Krzysztofik (1):
      video: fbdev: omap: Make it CCF clk API compatible

Lv Ruyi (1):
      video: fbdev: imxfb: Fix missing of_node_put in imxfb_probe

Ondrej Zary (1):
      video: fbdev: i740fb: use memset_io() to clear screen

Pavel Skripkin (1):
      video: fbdev: udlfb: properly check endpoint type

Wang Qing (1):
      video: fbdev: pxafb: use if else instead

Zheyu Ma (7):
      video: fbdev: neofb: Fix the check of 'var->pixclock'
      video: fbdev: kyro: Error out if 'lineclock' equals zero
      video: fbdev: vt8623fb: Error out if 'pixclock' equals zero
      video: fbdev: tridentfb: Error out if 'pixclock' equals zero
      video: fbdev: arkfb: Error out if 'pixclock' equals zero
      video: fbdev: s3fb: Error out if 'pixclock' equals zero
      video: fbdev: i740fb: Error out if 'pixclock' equals zero

 drivers/video/fbdev/arkfb.c                |  3 +++
 drivers/video/fbdev/aty/aty128fb.c         |  1 -
 drivers/video/fbdev/aty/atyfb_base.c       |  1 -
 drivers/video/fbdev/aty/radeon_pm.c        |  1 -
 drivers/video/fbdev/aty/radeonfb.h         |  2 +-
 drivers/video/fbdev/clps711x-fb.c          |  3 +--
 drivers/video/fbdev/controlfb.c            |  3 ---
 drivers/video/fbdev/i740fb.c               |  5 ++++-
 drivers/video/fbdev/imxfb.c                |  2 ++
 drivers/video/fbdev/kyro/fbdev.c           |  2 ++
 drivers/video/fbdev/matrox/matroxfb_base.h |  1 -
 drivers/video/fbdev/mb862xx/mb862xxfbdrv.c |  2 ++
 drivers/video/fbdev/mmp/core.c             | 11 +++++------
 drivers/video/fbdev/neofb.c                |  2 +-
 drivers/video/fbdev/omap/hwa742.c          |  6 +++---
 drivers/video/fbdev/omap/lcdc.c            |  6 +++---
 drivers/video/fbdev/omap/sossi.c           |  5 +++--
 drivers/video/fbdev/platinumfb.c           |  2 +-
 drivers/video/fbdev/pm2fb.c                |  8 ++------
 drivers/video/fbdev/pxafb.c                |  4 ++--
 drivers/video/fbdev/s3fb.c                 |  3 +++
 drivers/video/fbdev/sh_mobile_lcdcfb.c     |  3 ---
 drivers/video/fbdev/sis/sis_main.c         |  2 +-
 drivers/video/fbdev/tridentfb.c            |  3 +++
 drivers/video/fbdev/udlfb.c                | 14 ++++++++++++--
 drivers/video/fbdev/valkyriefb.c           |  3 +--
 drivers/video/fbdev/vt8623fb.c             |  3 +++
 drivers/video/of_display_timing.c          |  2 +-
 include/uapi/linux/fb.h                    |  2 +-
 29 files changed, 60 insertions(+), 45 deletions(-)
