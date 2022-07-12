Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4324D570F87
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 03:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiGLBcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 21:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbiGLBcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 21:32:46 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12BF8D5E4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 18:32:44 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id u12so11755064eja.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 18:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=sKmlJNbOCxxGu2qoEpBgoFbduYBXC63XtKF5C6TRjl4=;
        b=NyKa32/ZEaCGrRikTeghU9YrYFt7yToYrMdISiP/VYrKCVmwHMdSqH7HuqAuI/2dz/
         2K7XfDGwwVnOMR/zv8TwExlwddpTDupWPw10vDpmRJiSMtdISF0hDpvW3385pgEBj2vQ
         7Awb7iPaIkXg5ct35tLHRcL6NeB5sD75obZyHdi3ilAYxZA09wtt0NSgkuJX33TnIemH
         Y8bufO5ezLAYzTaFNFGmIO3XrxZGTifDUNLX27QtuY7/qWbgfTdMr5TGFb5ZdsrhB0Rn
         T6KjJzg0BnuLTU60j0IW8xF0vLqjW/PBGwnxx9yAjDyhqypOc3IB6+2hYAoGtbNKsal3
         ambg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=sKmlJNbOCxxGu2qoEpBgoFbduYBXC63XtKF5C6TRjl4=;
        b=akxBezXcFcEAu7uBEJbYX8aOiKpBR1Y7P0z/Yyo2soPzZtY5ojI4ZCs7GMr2agadkA
         vH+A8KM2ErX1fNtpxvRq2Qn29Ka2vie+oIps9OTbe4bNfQ/OM9pkYQuLPxU6UFszgW+e
         iDAvjpuIKA9iGY5l7OsNz0SnyQp/TOUg0SUi3jaQ7lfcOm4d5OQ4HLp5BMwuxtfEo5FZ
         aUMUokeU4RSf693bXPeSELVT+8tSjeW3geUHEs40YLQsQWcwGP8kcACwDBov6GbGcsBh
         A7KSRjxmYzYkKO72KqpaQJ+TlpzbtYdZ0HOFkziNYCrQAkBaq/Bk6SGCAdA3SN3d7ZP+
         /O6w==
X-Gm-Message-State: AJIora9T/CEWPw3EGgKimDgiol9GG+wCKZppVpbTDuVEggdXdn/clELZ
        WiGZYmZX1c4go7fR1yr6UC6p8rvYuhj/h84q+60=
X-Google-Smtp-Source: AGRyM1vzvH3Y7oBxzCV9ARzK4CnIUVERGfxjpQPtCysIILmYPTc7fbrhvhWhCj73MmPCtxSeHf//ydZySTDY1JSCsjE=
X-Received: by 2002:a17:906:149:b0:712:502:bc62 with SMTP id
 9-20020a170906014900b007120502bc62mr21783814ejh.720.1657589562490; Mon, 11
 Jul 2022 18:32:42 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Tue, 12 Jul 2022 11:32:31 +1000
Message-ID: <CAPM=9tyJzO0bwtopJsfkZ6FRjkk9EghPzhBOQ-_9qQAALvOq+A@mail.gmail.com>
Subject: [git pull] drm fixes for 5.19-rc7 (late rc6)
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

Hey Linus,

back from holidays, delayed by a day due to airline craziness, I see
you picked up one of the fbdev fixes, this is the other stuff that was
queued up last week.

I just noticed I got the rc? in the signed tag wrong, I've fixed them
in this email, but not sure if you care.

A bit of a scattering of fixes, 3 for i915, one amdgpu, and a couple
of panfrost, rockchip, panel and bridge ones.

If I have anything else at the end of the week I'll send a regular pull req=
.

Dave.


drm-fixes-2022-07-12:
drm fixes for 5.19-rc7 (well rc6 but late).

amdgpu:
- Hibernation fix

dma-buf:
- fix use after free of fence

i915:
- Fix a possible refcount leak in DP MST connector (Hangyu)
- Fix on loading guc on ADL-N (Daniele)
- Fix vm use-after-free in vma destruction (Thomas)

bridge:
- fsl-ldb : 3 LVDS modesetting fixes

rockchip:
- iommu domain fix

panfrost:
- fix memory corruption
- error path fix

panel:
- orientation quirk fix for Yoga tablet 2

ssd130x:
- fix pre-charge period setting
The following changes since commit 32346491ddf24599decca06190ebca03ff9de7f8=
:

  Linux 5.19-rc6 (2022-07-10 14:40:51 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-07-12

for you to fetch changes up to 3590b44b9434af1b9c81c3f40189087ed4fe3635:

  Merge tag 'drm-misc-fixes-2022-07-07-1' of
ssh://git.freedesktop.org/git/drm/drm-misc into drm-fixes (2022-07-12
10:44:40 +1000)

----------------------------------------------------------------
drm fixes for 5.19-rc7 (well rc6 but late).

amdgpu:
- Hibernation fix

dma-buf:
- fix use after free of fence

i915:
- Fix a possible refcount leak in DP MST connector (Hangyu)
- Fix on loading guc on ADL-N (Daniele)
- Fix vm use-after-free in vma destruction (Thomas)

bridge:
- fsl-ldb : 3 LVDS modesetting fixes

rockchip:
- iommu domain fix

panfrost:
- fix memory corruption
- error path fix

panel:
- orientation quirk fix for Yoga tablet 2

ssd130x:
- fix pre-charge period setting

----------------------------------------------------------------
Alex Deucher (2):
      drm/amdgpu: keep fbdev buffers pinned during suspend
      drm/amdgpu/display: disable prefer_shadow for generic fb helpers

Daniele Ceraolo Spurio (1):
      drm/i915/guc: ADL-N should use the same GuC FW as ADL-S

Dave Airlie (3):
      Merge tag 'amd-drm-fixes-5.19-2022-07-06' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2022-07-07' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'drm-misc-fixes-2022-07-07-1' of
ssh://git.freedesktop.org/git/drm/drm-misc into drm-fixes

Dmitry Osipenko (2):
      drm/panfrost: Put mapping instead of shmem obj on
panfrost_mmu_map_fault_addr() error
      drm/panfrost: Fix shrinker list corruption by madvise IOCTL

Ezequiel Garcia (1):
      drm/ssd130x: Fix pre-charge period setting

Hangyu Hua (1):
      drm/i915: fix a possible refcount leak in intel_dp_add_mst_connector(=
)

Hans de Goede (1):
      drm: panel-orientation-quirks: Add quirk for the Lenovo Yoga Tablet 2=
 830

Liu Ying (3):
      drm/bridge: fsl-ldb: Fix mode clock rate validation
      drm/bridge: fsl-ldb: Enable split mode for LVDS dual link
      drm/bridge: fsl-ldb: Drop DE signal polarity inversion

Steven Price (1):
      drm/rockchip: Detach from ARM DMA domain in attach_device

Thomas Hellstr=C3=B6m (1):
      drm/i915: Fix vm use-after-free in vma destruction

Thomas Zimmermann (1):
      drm/aperture: Run fbdev removal before internal helpers

xinhui pan (1):
      dma-buf: Fix one use-after-free of fence

 drivers/dma-buf/dma-resv.c                        |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c       | 25 +++++++++++++++++++=
----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c          |  3 ++-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c            |  3 ++-
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c            |  3 ++-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c             |  3 ++-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c             |  3 ++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  3 ++-
 drivers/gpu/drm/bridge/fsl-ldb.c                  | 21 ++-----------------
 drivers/gpu/drm/drm_panel_orientation_quirks.c    | 15 ++++++++++++++
 drivers/gpu/drm/i915/display/intel_dp_mst.c       |  1 +
 drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c          |  9 ++++++++
 drivers/gpu/drm/i915/i915_vma.c                   | 12 +++++++----
 drivers/gpu/drm/panfrost/panfrost_drv.c           |  4 ++--
 drivers/gpu/drm/panfrost/panfrost_mmu.c           |  2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c       | 17 +++++++++++++++
 drivers/gpu/drm/solomon/ssd130x.c                 |  2 +-
 17 files changed, 90 insertions(+), 38 deletions(-)
