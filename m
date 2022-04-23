Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E2650C78E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 07:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbiDWFWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 01:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbiDWFVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 01:21:51 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BFB90CCB
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 22:18:55 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id ks6so20030567ejb.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 22:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=FSLBd1Ysis1ZqaWu6Zoyxjq+Ki98jPbY3SmhIZw4EwE=;
        b=IV4z1ZP/uQ3FlyiVUNFu/3mdSaYgUs3AVLD2EJxXOf10Lg0S7d+77yfrxIgXsvuUwI
         lLWLdJzEjCZh/wIRJKdnkQzZ6/zf1P5NTRXokPdvMGcqN3Sl1SU5UFqgoHw473PAU6+I
         3ydQyK3XcT4yu5SnyaLktw9DBCLcVQh/hjCR5KhVEDIylFrmKHSWM70YeGPCPywt9bwc
         6GwJJR2halIn7NhwGBihFo7CmLlA6QUJ26SOeK4liFx3K9He1jRWt84r6LAX4CNm8MuS
         gH515uA9JvcPUHb26ubw4w0NAxlQ+xd87GQ+9fYch8bUGM/R+b4Lt638OI4/0SMXzuTJ
         9edA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=FSLBd1Ysis1ZqaWu6Zoyxjq+Ki98jPbY3SmhIZw4EwE=;
        b=NbeBZ9xybHz1PWDAJwwBlo9ZOiXW4a78RDYBMYR+hClgVei1YQfN+IGgjzn74Zasc1
         WwLFGw5TzMsJTcoe8uUy9uNbNgJOlJl3KoWNl7quJrunQw/c5La9MX5/9HIqfAyfsCcF
         8sBvP6JT0MkcL3lWdgkVTnETKeB38vIORG/t9XAcsvfiJe4zbzyMKOGitd4f5uLE+Wsi
         4+gkqNnw3ZZUOrCo8QM/d5TUc+yIfpdMzLLKZjTq3fz1LQAXl1G0DG8pbuXDXVs6AcXd
         gXEstl7uAhy0wI6G6zygdxO8VVgQQ9Vh43TbZhGVU6OR8TbRKgYrAy95e4ab20o53EDY
         ZEjg==
X-Gm-Message-State: AOAM531DaXYr7BkQaaHOsXohNjvEll+KmGqh4QZDsg7Uw2zfc9Vm+dQu
        G8UlUk3tzNGlO7wezpcR5dIf/zZBG7Ahg5Rxxwe8AyrYpjqhKg==
X-Google-Smtp-Source: ABdhPJyvc8cz+2ghAyYyfb1+6ZWEzgPG15m+aRsXu6N6K2pkN+1K5j3DYFhxq1eACxb4Nvjpu0UN2IlcK4p4T8n9gHU=
X-Received: by 2002:a17:906:4794:b0:6f3:7569:77fd with SMTP id
 cw20-20020a170906479400b006f3756977fdmr829165ejc.266.1650691134325; Fri, 22
 Apr 2022 22:18:54 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Sat, 23 Apr 2022 15:18:43 +1000
Message-ID: <CAPM=9tx4wRuT7J7ZxVeqQNWYdti8=_x3aPURRFPX1qrjWAw09A@mail.gmail.com>
Subject: [git pull] drm fixes for 5.18-rc4 (part 2)
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Maarten was away, so Maxine stepped up and sent me the drm-fixes
merge, so no point leaving it for another week. The big change is an
OF revert around bridge/panels, it may have some driver fallout, but
hopefully this revert gets them shook out in the next week easier.
Otherwise it's a bunch of locking/refcounts across drivers, a radeon
dma_resv logic fix and some raspberry pi panel fixes.

Regards,
Dave.

drm-fixes-2022-04-23:
drm fixes for 5.18-rc4 - 2nd part

panel:
- revert of patch that broke panel/bridge issues

dma-buf:
- remove unused header file.

amdgpu:
- partial revert of locking change

radeon:
- fix dma_resv logic inversion

panel:
- pi touchscreen panel init fixes

vc4:
- build fix
- runtime pm refcount fix

vmwgfx:
- refcounting fix
The following changes since commit 70da382e1c5b9b2049c10abfd4489a40c1b60df0=
:

  Merge tag 'drm-msm-fixes-2022-04-20' of
https://gitlab.freedesktop.org/drm/msm into drm-fixes (2022-04-22
09:25:47 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-04-23

for you to fetch changes up to c18a2a280c073f70569a91ef0d7434d12e66e200:

  Merge tag 'drm-misc-fixes-2022-04-22' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes (2022-04-23
15:00:44 +1000)

----------------------------------------------------------------
drm fixes for 5.18-rc4 - 2nd part

panel:
- revert of patch that broke panel/bridge issues

dma-buf:
- remove unused header file.

amdgpu:
- partial revert of locking change

radeon:
- fix dma_resv logic inversion

panel:
- pi touchscreen panel init fixes

vc4:
- build fix
- runtime pm refcount fix

vmwgfx:
- refcounting fix

----------------------------------------------------------------
Bjorn Andersson (2):
      Revert "drm: of: Properly try all possible cases for
bridge/panel detection"
      Revert "drm: of: Lookup if child node has panel or bridge"

Christian K=C3=B6nig (2):
      drm/radeon: fix logic inversion in radeon_sync_resv
      drm/amdgpu: partial revert "remove ctx->lock" v2

Dave Airlie (1):
      Merge tag 'drm-misc-fixes-2022-04-22' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes

Dave Stevenson (2):
      drm/panel/raspberrypi-touchscreen: Avoid NULL deref if not initialise=
d
      drm/panel/raspberrypi-touchscreen: Initialise the bridge in prepare

Karol Herbst (1):
      dma-buf-map: remove renamed header file

Miaoqian Lin (1):
      drm/vc4: Use pm_runtime_resume_and_get to fix pm_runtime_get_sync() u=
sage

Zack Rusin (1):
      drm/vmwgfx: Fix gem refcounting and memory evictions

Zheng Bin (1):
      drm/vc4: Fix build error when CONFIG_DRM_VC4=3Dy &&
CONFIG_RASPBERRYPI_FIRMWARE=3Dm

 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |  21 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c            |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h            |   1 +
 drivers/gpu/drm/drm_of.c                           |  84 +++----
 .../gpu/drm/panel/panel-raspberrypi-touchscreen.c  |  13 +-
 drivers/gpu/drm/radeon/radeon_sync.c               |   2 +-
 drivers/gpu/drm/vc4/Kconfig                        |   3 +
 drivers/gpu/drm/vc4/vc4_dsi.c                      |   2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c                 |  43 ++--
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                |   8 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c            |   7 +-
 include/linux/dma-buf-map.h                        | 266 -----------------=
----
 12 files changed, 94 insertions(+), 358 deletions(-)
 delete mode 100644 include/linux/dma-buf-map.h
