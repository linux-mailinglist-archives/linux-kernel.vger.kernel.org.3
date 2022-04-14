Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741B9501D84
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 23:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244340AbiDNVfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 17:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiDNVfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 17:35:40 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EDB2E68A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 14:33:14 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id v4so7938558edl.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 14:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=SdaPBTjjB0WeNdV957shheo3t5GkE9UUUWqWlLgChQA=;
        b=iyvty8hJJGC0yB3coux5aqsfjgazdShEQfSPUEfssjrt9Ef8MXvis67tJhUz2BGo6+
         G6/FLG5+3Hkb1lJkQdjacq+4a1fBHLq7zJPRgqf4hCsTg3n8XNcVw4S2VIEcImDRRShH
         zGHYXJtnzbEr+I2hDM3kkErAVW0WNbwjetRS6Na8/rEetKe8AjfQt50cQ7HITrp8MAYD
         o46ViW7NFTKOARjbNPhQwAuvZrWdHzjOsB8IdYNpVmWvuXdgjh0wPQnmNeqlhYNk0ryZ
         UYTBoXxP+Gjb1Ne79FPoddZODLiSyErIGJpUr58k73vQgsXpOutoxOtgdKNODpWBOMkE
         uf+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=SdaPBTjjB0WeNdV957shheo3t5GkE9UUUWqWlLgChQA=;
        b=fhSk+kVwO3tAFEBaz/PgadN8dYLTgkuoWSVbvIgu5g8S0W4cEYl4i74uWWFzOL44Vc
         ihHwCkE9PoCd4rGdNFHLP5wyjYpU0GS1l4aiZWJe2f6gp40uoM8EN/2Q2FnMccsSijvu
         Dp+2gUrgr7U978Gv8Sy5Dr0ZLlbiSU0wdISZr31gKiZcS2LD4jIJLMJRx1fYq2IAxyYz
         v67WSyW1FQJpH7QXpoHvSRxlov4VuOvx6rAq6Zh03lea8zAv30KAe/McFCF7sXnF+NnC
         MOyl2PinCnFrigqFp2B9Jb/d292qt1B7qes4bO2o97lHICJ+boG74MgcG/lx4nt8Mh7X
         AMkw==
X-Gm-Message-State: AOAM530CRsZgA2xVEJLxP3Lh6Sv8k/lC2rKVux0vlDnN77h6x9scmMF5
        yxnOMsq83nAwjK7Bv1aKRGkqkmjdIwtSRhmJswAy3Q0a+3JFiQ==
X-Google-Smtp-Source: ABdhPJyYTr3zIx8iXuB6Suqq2nF67E32UesNhw9ppUpy6UwDhip3h0iJ3LObPwP9vurlHdGaAhvbj4idt6RJeVZZqCg=
X-Received: by 2002:a05:6402:36d:b0:41d:7a5f:8393 with SMTP id
 s13-20020a056402036d00b0041d7a5f8393mr5075133edw.277.1649971992769; Thu, 14
 Apr 2022 14:33:12 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 15 Apr 2022 07:33:01 +1000
Message-ID: <CAPM=9tzmeDfgQ3VhutQWLcgVhodHJhGmzrjMTB=yvXOhwnw0CA@mail.gmail.com>
Subject: [git pull] drm fixes for 5.18-rc3
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

Eggs season holidays are among us, and I think I'd expect some smaller
pulls for 2 weeks then, rc5 having a blow out, as this seems eerily
quiet. One i915 fix, amdgpu has a bunch and msm. I didn't see a misc
pull this week, so I expect that will catch up next week.

Dave.

drm-fixes-2022-04-15:
drm fixes for 5.18-rc3

i915:
- Correct legacy mmap disabling to use GRAPHICS_VER_FULL

msm:
- system suspend fix
- kzalloc return checks
- misc display fix
- iommu_present removal

amdgpu:
- Fix for alpha properly in pre-multiplied mode
- Fix VCN 3.1.2 firmware name
- Suspend/resume fix
- Add a gfxoff quirk for Mac vega20 board
- DCN 3.1.6 spread spectrum fix
The following changes since commit ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e=
:

  Linux 5.18-rc2 (2022-04-10 14:21:36 -1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-04-15

for you to fetch changes up to 8e401ff5380a921c309d4c73cacf27b0bdb5f168:

  Merge tag 'amd-drm-fixes-5.18-2022-04-13' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes (2022-04-15
07:14:20 +1000)

----------------------------------------------------------------
drm fixes for 5.18-rc3

i915:
- Correct legacy mmap disabling to use GRAPHICS_VER_FULL

msm:
- system suspend fix
- kzalloc return checks
- misc display fix
- iommu_present removal

amdgpu:
- Fix for alpha properly in pre-multiplied mode
- Fix VCN 3.1.2 firmware name
- Suspend/resume fix
- Add a gfxoff quirk for Mac vega20 board
- DCN 3.1.6 spread spectrum fix

----------------------------------------------------------------
Alex Deucher (1):
      drm/amdgpu: fix VCN 3.1.2 firmware name

Charlene Liu (1):
      drm/amd/display: remove dtbclk_ss compensation for dcn316

Dave Airlie (3):
      Merge tag 'drm-intel-fixes-2022-04-13' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'drm-msm-fixes-2022-04-13' of
https://gitlab.freedesktop.org/drm/msm into drm-fixes
      Merge tag 'amd-drm-fixes-5.18-2022-04-13' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes

Dmitry Baryshkov (1):
      dt-bindings: display/msm: another fix for the dpu-qcm2290 example

Kai-Heng Feng (1):
      drm/amdgpu: Ensure HDA function is suspended before ASIC reset

Kuogee Hsieh (1):
      drm/msm/dp: add fail safe mode outside of event_mutex context

Marijn Suijten (1):
      drm/msm/dpu: Use indexed array initializer to prevent mismatches

Matt Roper (1):
      drm/i915: Sunset igpu legacy mmap support based on GRAPHICS_VER_FULL

Melissa Wen (1):
      drm/amd/display: don't ignore alpha property on pre-multiplied mode

Nathan Chancellor (1):
      drm/msm/gpu: Avoid -Wunused-function with !CONFIG_PM_SLEEP

Rob Clark (5):
      drm/msm/gpu: Rename runtime suspend/resume functions
      drm/msm/gpu: Park scheduler threads for system suspend
      drm/msm/gpu: Remove mutex from wait_event condition
      drm/msm: Add missing put_task_struct() in debugfs path
      drm/msm: Fix range size vs end confusion

Robin Murphy (1):
      drm/msm: Stop using iommu_present()

Stephen Boyd (1):
      drm/msm/dsi: Use connector directly in msm_dsi_manager_connector_init=
()

Tomasz Mo=C5=84 (1):
      drm/amdgpu: Enable gfxoff quirk on MacBook Pro

Xiaoke Wang (2):
      drm/msm/disp: check the return value of kzalloc()
      drm/msm/mdp5: check the return of kzalloc()

 .../bindings/display/msm/dpu-qcm2290.yaml          |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            | 18 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |  2 +
 .../amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c    |  2 +-
 .../amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c |  4 +-
 drivers/gpu/drm/amd/display/dc/dc.h                |  2 +-
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  | 14 ++--
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 14 ++--
 drivers/gpu/drm/i915/gem/i915_gem_mman.c           |  2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              |  2 +-
 drivers/gpu/drm/msm/adreno/adreno_device.c         | 80 +++++++++++++++++-=
----
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c  | 34 ++++-----
 drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c         |  3 +
 drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c  |  2 +
 drivers/gpu/drm/msm/dp/dp_display.c                |  6 ++
 drivers/gpu/drm/msm/dp/dp_panel.c                  | 20 +++---
 drivers/gpu/drm/msm/dp/dp_panel.h                  |  1 +
 drivers/gpu/drm/msm/dsi/dsi_manager.c              |  2 +-
 drivers/gpu/drm/msm/msm_drv.c                      |  2 +-
 drivers/gpu/drm/msm/msm_gem.c                      |  1 +
 21 files changed, 147 insertions(+), 70 deletions(-)
