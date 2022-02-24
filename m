Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1FA64C3977
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 00:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbiBXXCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 18:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiBXXCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 18:02:15 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DB24132E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 15:01:43 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id c6so4941201edk.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 15:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=X3EtjfKbehA9fHwRWa8Y/OMrArkCeB4aGDlGlg7yqZE=;
        b=EGGqn11IUoyPVh7ZX1J8KqIGXWqgP7ARc8OdnJp+yNG7aExkjOIfpv60wE5TdCK6J4
         2w4kzsZ3/Us3jfzoPonBoqnWqXO241j7d5Tz4Ys2fa59Ri9j1SyLf6upmuIoXmlAcZhI
         ZQdEfS3Yk9sJWED8XDL5i3J8JZjo6nS9A6mWLLPc/bvaF7JIk7fxjV2eY++vKrc8KtWH
         pMhnRVnObTFaC2kCu6T2Zwul7y54cTcbbQRyhd9XMmzKtVApM3mhnZtiKv+yvjo1a6OL
         lPUbVfB95VXyXmBEEK6enG4rh+/OTZ3E8oGWIrX06c5SSo/KpHZCUASLyxQodnprymMZ
         6EPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=X3EtjfKbehA9fHwRWa8Y/OMrArkCeB4aGDlGlg7yqZE=;
        b=Ni0JW/SWZX2Vdfe9xV6AVdlfrITh6c5mVZQqfDKwt4SYrU8pnmhjbNzz7YclXyf5OL
         4v2LKMATAq6NhEH+2vjmURe7PVs/p+Ak6mZrJbgT8OOlQ+MxKWkyjTF/HwgqyPTnyhfo
         V1yLamPTJIfp8rqKlx+umAlczClIu3OpMTbk00ZVYVql0kE7MynxLi3Dsqn4qOcBRsBl
         GLLI6PjlGyEgZOcYiv7P+TEtH4LfCQve4mTgE6lV39M/gOlQFuK4/PEdDXdMqe/yRKd4
         4KRNJIDj7dwHBz6Zy7oWdvvRfFz/VzQKrHKp5klHo7PNYzqvbuZ81Zj5431xVhNvHpkR
         Q7pg==
X-Gm-Message-State: AOAM530ffehAJfpdtO/w3mGXSdJOzyDbEj2wSvzf9q32LQQ8Gb+B/cGS
        p3rjJxj46qrz6rgl+2V4hL1QextBwV9uvx2oDvo=
X-Google-Smtp-Source: ABdhPJycirbyAqbZ13XeIBPPBICl1WRVjb08/FUcXd+gGs+PAjuKX/EybFir/ArHyRHz7Se4xE8DUFqGSMvDZgPQNI8=
X-Received: by 2002:aa7:d2c8:0:b0:410:e248:48eb with SMTP id
 k8-20020aa7d2c8000000b00410e24848ebmr4471404edr.325.1645743702061; Thu, 24
 Feb 2022 15:01:42 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 25 Feb 2022 09:01:30 +1000
Message-ID: <CAPM=9twsapa3kN3wkRfpqT7dZPDbFePicHm8TT8yVnwqH6aZyA@mail.gmail.com>
Subject: [git pull] drm fixes for 5.17-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

Regular drm fixes pull, i915, amdgpu and tegra mostly, all pretty small.

I'm in quarantine at home for next 7 days, shouldn't interrupt things,
but might be erratic if anyone is looking for me.

Dave.

drm-fixes-2022-02-25:
drm fixes for 5.17-rc6

core:
- edid: Always set RGB444

tegra:
- tegra186 suspend/resume fixes
- syncpoint wait fix
- build warning fix
- eDP on older devices fix

amdgpu:
- Display FP fix
- PCO powergating fix
- RDNA2 OEM SKU stability fixes
- Display PSR fix
- PCI ASPM fix
- Display link encoder fix for TEST_COMMIT
- Raven2 suspend/resume fix
- Fix a regression in virtual display support
- GPUVM eviction fix

i915:
- Fix QGV handling on ADL-P+
- Fix bw atomic check when switching between SAGV vs. no SAGV
- Disconnect PHYs left connected by BIOS on disabled ports
- Fix SAVG to no SAGV transitions on TGL+
- Print PHY name properly on calibration error (DG2)

imx:
- dcss: Select GEM CMA helpers

radeon:
- Fix some variables's type

vc4:
- Fix codec cleanup
- Fix PM reference counting
The following changes since commit cfb92440ee71adcc2105b0890bb01ac3cddb8507=
:

  Linux 5.17-rc5 (2022-02-20 13:07:20 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-02-25

for you to fetch changes up to ecf8a99f4807c17fa310a83067a95964cedd9ac1:

  Merge tag 'drm-intel-fixes-2022-02-24' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2022-02-25
05:51:04 +1000)

----------------------------------------------------------------
drm fixes for 5.17-rc6

core:
- edid: Always set RGB444

tegra:
- tegra186 suspend/resume fixes
- syncpoint wait fix
- build warning fix
- eDP on older devices fix

amdgpu:
- Display FP fix
- PCO powergating fix
- RDNA2 OEM SKU stability fixes
- Display PSR fix
- PCI ASPM fix
- Display link encoder fix for TEST_COMMIT
- Raven2 suspend/resume fix
- Fix a regression in virtual display support
- GPUVM eviction fix

i915:
- Fix QGV handling on ADL-P+
- Fix bw atomic check when switching between SAGV vs. no SAGV
- Disconnect PHYs left connected by BIOS on disabled ports
- Fix SAVG to no SAGV transitions on TGL+
- Print PHY name properly on calibration error (DG2)

imx:
- dcss: Select GEM CMA helpers

radeon:
- Fix some variables's type

vc4:
- Fix codec cleanup
- Fix PM reference counting

----------------------------------------------------------------
Bas Nieuwenhuizen (1):
      drm/amd/display: Protect update_bw_bounding_box FPU code.

Chen Gong (1):
      drm/amdgpu: do not enable asic reset for raven2

Christian K=C3=B6nig (1):
      drm/radeon: fix variable type

Dave Airlie (4):
      Merge tag 'drm-misc-fixes-2022-02-23' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm/tegra/for-5.17-rc6' of
https://gitlab.freedesktop.org/drm/tegra into drm-fixes
      Merge tag 'amd-drm-fixes-5.17-2022-02-23' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2022-02-24' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

Dmitry Osipenko (1):
      gpu: host1x: Fix hang on Tegra186+

Evan Quan (2):
      drm/amdgpu: disable MMHUB PG for Picasso
      drm/amd/pm: fix some OEM SKU specific stability issues

Guchun Chen (2):
      Revert "drm/amdgpu: add modifiers in amdgpu_vkms_plane_init()"
      drm/amdgpu: bypass tiling flag check in virtual display case (v2)

Imre Deak (1):
      drm/i915: Disconnect PHYs left connected by BIOS on disabled ports

Jon Hunter (1):
      drm/tegra: Fix cast to restricted __le32

Mario Limonciello (1):
      drm/amd: Check if ASPM is enabled from PCIe subsystem

Matt Roper (1):
      drm/i915/dg2: Print PHY name properly on calibration error

Maxime Ripard (3):
      drm/vc4: hdmi: Unregister codec device on unbind
      drm/vc4: crtc: Fix runtime_pm reference counting
      drm/edid: Always set RGB444

Michel D=C3=A4nzer (1):
      drm/amd/display: For vblank_disable_immediate, check PSR is really us=
ed

Mikko Perttunen (1):
      gpu: host1x: Always return syncpoint value when waiting

Nicholas Kazlauskas (1):
      drm/amd/display: Fix stream->link_enc unassigned during stream remova=
l

Qiang Yu (1):
      drm/amdgpu: check vm ready by amdgpu_vm->evicting flag

Rudi Heitbaum (1):
      drm/imx/dcss: i.MX8MQ DCSS select DRM_GEM_CMA_HELPER

Thierry Reding (1):
      drm/tegra: dpaux: Populate AUX bus

Ville Syrj=C3=A4l=C3=A4 (3):
      drm/i915: Widen the QGV point mask
      drm/i915: Correctly populate use_sagv_wm for all pipes
      drm/i915: Fix bw atomic check when switching between SAGV vs. no SAGV

 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c           |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  9 ++++--
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |  9 ++++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 17 ++++++-----
 .../amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c   |  2 ++
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  7 +++--
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |  4 ---
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    | 32 ++++++++++++++++++=
+-
 drivers/gpu/drm/drm_edid.c                         |  2 +-
 drivers/gpu/drm/i915/display/intel_bw.c            | 18 +++++++++--
 drivers/gpu/drm/i915/display/intel_bw.h            |  8 ++---
 drivers/gpu/drm/i915/display/intel_snps_phy.c      |  2 +-
 drivers/gpu/drm/i915/display/intel_tc.c            | 26 ++++++++++++----
 drivers/gpu/drm/i915/intel_pm.c                    | 22 +++++++-------
 drivers/gpu/drm/imx/dcss/Kconfig                   |  1 +
 drivers/gpu/drm/radeon/radeon_uvd.c                |  8 ++---
 drivers/gpu/drm/tegra/Kconfig                      |  1 +
 drivers/gpu/drm/tegra/dpaux.c                      |  7 +++++
 drivers/gpu/drm/tegra/falcon.c                     |  2 +-
 drivers/gpu/drm/vc4/vc4_crtc.c                     |  8 +++--
 drivers/gpu/drm/vc4/vc4_hdmi.c                     |  8 +++++
 drivers/gpu/drm/vc4/vc4_hdmi.h                     |  1 +
 drivers/gpu/host1x/syncpt.c                        | 35 +++++++-----------=
----
 25 files changed, 156 insertions(+), 81 deletions(-)
