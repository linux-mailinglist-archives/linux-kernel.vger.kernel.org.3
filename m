Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CFE526D34
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 00:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbiEMW40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 18:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384919AbiEMW4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 18:56:16 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8390C36B58
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 15:56:14 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id ks9so18821852ejb.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 15:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=yHYjKyDImi3l5dDyx9DR+vuao9yWufvS15O7CLzoC40=;
        b=cZh8FuRrzbQ1mOiYZTVxKh0ixLrtkMDJFWe6Sw1usjrJiAl5VRA0sAKlrUSLyc/QLx
         ADCbPxnI7oAyAwl//Ks/Iop8AnNmLxW2msVsfk950kX8BNheJhferrNLXBBPt6B7UADW
         gln+ly61FX3/OPch/MOjKDSVn2w+h8EJRJmJV4wAtQOkQ/eceKgidFphTwG8JygwCqH7
         m2bJckksP0ymgFooHLSBl9T8Pk7ehWILO65+5H/HuGKgNMSThraC44B/T5VSOywvVJYl
         rTdShpbqsux2Nruse0Hz42OOt0SEiO2jqfKsk7j0y22gbkr1za+20yMoHyr+7aWTix6A
         WmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=yHYjKyDImi3l5dDyx9DR+vuao9yWufvS15O7CLzoC40=;
        b=20dPzkXOPTueJlG2IxDBWUmHLkYwydCCNTLlo+fSKVMZsseJk11AgOC6JYrnJ6UGOD
         xost2vdlwQrUQqJk6g6/M3Ky+tQTew3+0lJ0jdDhsGPM/Ul8dcnhQGOn3nOynpX6qC2d
         XsYmPm/2hdbkYq7Oo7EA9VQOQUBbodbxsfkNFq75viywe6bTFms2UdOSxAeoTPv/u/+8
         BFqi92b0WOF2TKFF3n746vW7tAxpZfNpB9f2W4TTuIMyXTiOF9fsk7q0TzN5lBOnMiPO
         p6BHXXvnvU/dLN9lM6Jj63rhbg843HV628KxXo1FIFO3wY+4bVWLGaXAnQuaY1288gQo
         gQJw==
X-Gm-Message-State: AOAM5330D4w9gppxTZBotcSPomQQSmlB74ierWRcFvePqXHBfGKuDKit
        jMfRMad6p01wpl+OmB/fUWrZAzLYITRQlqY/dtI=
X-Google-Smtp-Source: ABdhPJwJz/KBfqCWxJah+sFmFhNu0NNxcgima/D1cUeGVRvZtfdArdmTyYR5uMA5inyXdFvXN46H3XZNY9BtKBg9lDE=
X-Received: by 2002:a17:906:6bd7:b0:6f4:e6e4:1d41 with SMTP id
 t23-20020a1709066bd700b006f4e6e41d41mr6295534ejs.770.1652482572925; Fri, 13
 May 2022 15:56:12 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Sat, 14 May 2022 08:56:01 +1000
Message-ID: <CAPM=9txpYhzyZtd60LEuBYYN+AVyeEQ8=h43bK=ZY8QCQpY5mg@mail.gmail.com>
Subject: [git pull] drm fixes for 5.18-rc7 (follow up)
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

Turns out I was right, some fixes hadn't made it to me yet. The vmwgfx
ones also popped up later, but all seem like bad enough things to fix.
The dma-buf, vc4 and nouveau ones are all pretty small.

The fbdev fixes are a bit more complicated, a fix to cleanup fbdev
devices properly, uncovered some use-after-free bugs in existing
drivers. Then the fix for those bugs wasn't correct. This reverts that
fix, and puts the proper fixes in place in the drivers to avoid the
use-after-frees. This has had a fair number of eyes on it at this
stage, and I'm confident enough that it puts things in the right
place, and is less dangerous than reverting our way out of the initial
change at this stage.

Let me know if you want more details, the commit msgs are quite verbose.

Dave.

drm-fixes-2022-05-14:
drm fixes for 5.18-rc7 (part two)

fbdev:
- revert NULL deref fix that turned into a use-after-free
- prevent use-after-free in fbdev
- efifb/simplefb/vesafb: fix cleanup paths to avoid use-after-frees

dma-buf:
- fix panic in stats setup

vc4:
- fix hdmi build

nouveau:
- tegra iommu present fix
- fix leak in backlight name

vmwgfx:
- Black screen due to fences using FIFO checks on SVGA3
- Random black screens on boot due to uninitialized drm_mode_fb_cmd2
- Hangs on SVGA3 due to command buffers being used with gbobjects
The following changes since commit 5005e9814698f47c5a3698fcc56c9f5e6f1d4644:

  Merge tag 'amd-drm-fixes-5.18-2022-05-11' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes (2022-05-13
10:40:56 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-05-14

for you to fetch changes up to eb7bac3973d209e5227d1783676362ee5a8a7127:

  Merge tag 'drm-misc-fixes-2022-05-13' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes (2022-05-14
08:34:07 +1000)

----------------------------------------------------------------
drm fixes for 5.18-rc7 (part two)

fbdev:
- revert NULL deref fix that turned into a use-after-free
- prevent use-after-free in fbdev
- efifb/simplefb/vesafb: fix cleanup paths to avoid use-after-frees

dma-buf:
- fix panic in stats setup

vc4:
- fix hdmi build

nouveau:
- tegra iommu present fix
- fix leak in backlight name

vmwgfx:
- Black screen due to fences using FIFO checks on SVGA3
- Random black screens on boot due to uninitialized drm_mode_fb_cmd2
- Hangs on SVGA3 due to command buffers being used with gbobjects

----------------------------------------------------------------
Charan Teja Reddy (1):
      dma-buf: call dma_buf_stats_setup after dmabuf is in valid list

Christophe JAILLET (1):
      drm/nouveau: Fix a potential theorical leak in
nouveau_get_backlight_name()

Daniel Vetter (1):
      fbdev: Prevent possible use-after-free in fb_release()

Dave Airlie (2):
      Merge tag 'vmwgfx-drm-fixes-5.18-2022-05-13' of
https://gitlab.freedesktop.org/zack/vmwgfx into drm-fixes
      Merge tag 'drm-misc-fixes-2022-05-13' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes

Hui Tang (1):
      drm/vc4: hdmi: Fix build error for implicit function declaration

Javier Martinez Canillas (5):
      Revert "fbdev: Make fb_release() return -ENODEV if fbdev was unregistered"
      fbdev: simplefb: Cleanup fb_info in .fb_destroy rather than .remove
      fbdev: efifb: Cleanup fb_info in .fb_destroy rather than .remove
      fbdev: vesafb: Cleanup fb_info in .fb_destroy rather than .remove
      fbdev: efifb: Fix a use-after-free due early fb_info cleanup

Maarten Lankhorst (1):
      Merge remote-tracking branch 'drm/drm-fixes' into drm-misc-fixes

Robin Murphy (1):
      drm/nouveau/tegra: Stop using iommu_present()

Zack Rusin (3):
      drm/vmwgfx: Fix fencing on SVGAv3
      drm/vmwgfx: Initialize drm_mode_fb_cmd2
      drm/vmwgfx: Disable command buffers on svga3 without gbobjects

 drivers/dma-buf/dma-buf.c                          |  8 +++----
 drivers/gpu/drm/nouveau/nouveau_backlight.c        |  9 +++----
 drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c |  2 +-
 drivers/gpu/drm/vc4/vc4_hdmi.c                     |  1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_cmd.c                | 13 ++++++----
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                |  8 +++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_fb.c                 |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_fence.c              | 28 ++++++++++++++++------
 drivers/gpu/drm/vmwgfx/vmwgfx_irq.c                | 26 +++++++++++++-------
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                |  8 ++++---
 drivers/video/fbdev/core/fbmem.c                   |  5 +---
 drivers/video/fbdev/core/fbsysfs.c                 |  4 ++++
 drivers/video/fbdev/efifb.c                        |  9 ++++++-
 drivers/video/fbdev/simplefb.c                     |  8 ++++++-
 drivers/video/fbdev/vesafb.c                       |  8 ++++++-
 15 files changed, 99 insertions(+), 40 deletions(-)
