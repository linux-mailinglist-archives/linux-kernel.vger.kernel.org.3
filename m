Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57185495746
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 01:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378379AbiAUAR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 19:17:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbiAUART (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 19:17:19 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850DDC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 16:17:18 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id m11so35648679edi.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 16:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=I9viqpO6auKcSCT1TCANj8QL/mwnoErD38GKR+I2UBQ=;
        b=OAq1lmsOGVWdBdRHaUKwZbRm80b3SBv2hRX2HW+5UbwGjts3PFuGYE9zOXumwr2qFx
         +WAhLEmpw5/37z/7ifxANkepop967nkBCkwdH05oPGV0RBFZ5bvJ/fcC97s0avQgv+K1
         JAJsjiToTjCuORpDagXxvR62sNZrSIOsdYpWaVEDxlxZZ/viwVW30ePQpcCBhFPj60Cj
         U1GYL0I6zVyX0cCn57LfoyrioNC/Dfpg8REsG4e218Ql9yJhKj3KlJK0OBmJaySuyole
         eBw8UfS7X3CSDc1kMgQpQxhCID7hTS73DS4HOz50bCMQvfMQjo/zTHHcpCPCzh6Vz85i
         cqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=I9viqpO6auKcSCT1TCANj8QL/mwnoErD38GKR+I2UBQ=;
        b=D+WFdaMRueehM0s+Zri62DYkjycQbIUFlm8x5aD1EPh5OUq5j4xe25zqipwxBConbD
         ynZDXkcUwaaeCttldUnHHKm7yX8pvekXCmDDuS/GHi3CJRwd1idBcKABwR9+N/ztIrvp
         FztSCPWyCxyk9REhkd87a9BvOqJ0/+xZOg1jQ0wIad1K/dprqcZovHynpS7x1JZZzUzb
         Ksxs1a3YWg9FC0fpZUj4mUR6xOMklKtValn5RIgKEMGERhZd7/2IEheI3m2diX0jRD7M
         7ZGUDXzpg2d9yY6mxVFU9kWisL0+PBy1tl/dARlRE92pO4ZS2ycE8JZVwGT1nRowxEty
         vleQ==
X-Gm-Message-State: AOAM532ZB3el5Z61qZzgG82/Qz8DxloANsZyii7G2w26MzrY0zboGFMy
        lgIUd7qOXhwnyaWXLCJPMFsT2UMsKrb/4RCJnS7kspgVSNY=
X-Google-Smtp-Source: ABdhPJyvwjlGCqiLtgCsE5gczG/HwTPFx+w0Jo9NolFqyPm8GfnCfOSEuwpYmObpCqCUQ3nkh0CaBMXTCteQznGyqHA=
X-Received: by 2002:a17:906:d554:: with SMTP id cr20mr1205318ejc.770.1642724237001;
 Thu, 20 Jan 2022 16:17:17 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 21 Jan 2022 10:17:05 +1000
Message-ID: <CAPM=9txt8OsBJJBzCYXMgMC8T=yKTWz9MYA3osB93EqMk5vBGg@mail.gmail.com>
Subject: [git pull] drm fixes for 5.17-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Thanks to Daniel for taking care of things while I was out, just a set
of merge window fixes that came in this week, two i915 display fixes
and a bunch of misc amdgpu, along with a radeon regression fix.

Regards,
Dave.


drm-next-2022-01-21:
drm fixes for 5.17-rc1

amdgpu:
- SR-IOV fix
- VCN harvest fix
- Suspend/resume fixes
- Tahiti fix
- Enable GPU recovery on yellow carp

radeon:
- Fix error handling regression in radeon_driver_open_kms

i915:
- Update EHL display voltage swing table
- Fix programming the ADL-P display TC voltage swing
The following changes since commit 4efdddbce7c1329f00c458e85dcaf105aebdc0ed=
:

  Merge tag 'amd-drm-next-5.17-2022-01-12' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next (2022-01-14
15:42:28 +0100)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-next-2022-01-21

for you to fetch changes up to ccf34586758cf00c0934e48f6ef6d688f01d7b19:

  Merge tag 'amd-drm-fixes-5.17-2022-01-19' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next (2022-01-21
08:37:56 +1000)

----------------------------------------------------------------
drm fixes for 5.17-rc1

amdgpu:
- SR-IOV fix
- VCN harvest fix
- Suspend/resume fixes
- Tahiti fix
- Enable GPU recovery on yellow carp

radeon:
- Fix error handling regression in radeon_driver_open_kms

i915:
- Update EHL display voltage swing table
- Fix programming the ADL-P display TC voltage swing

----------------------------------------------------------------
Alex Deucher (3):
      drm/amdgpu: invert the logic in amdgpu_device_should_recover_gpu()
      drm/amdgpu: don't do resets on APUs which don't support it
      drm/amdgpu: drop flags check for CHIP_IP_DISCOVERY

CHANDAN VURDIGERE NATARAJ (1):
      drm/amdgpu: Enable recovery on yellow carp

Christian K=C3=B6nig (1):
      drm/radeon: fix error handling in radeon_driver_open_kms

Dave Airlie (2):
      Merge tag 'drm-intel-next-fixes-2022-01-20' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'amd-drm-fixes-5.17-2022-01-19' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next

Guchun Chen (1):
      drm/amdgpu: apply vcn harvest quirk

Jingwen Chen (1):
      drm/amd/amdgpu: fixing read wrong pf2vf data in SRIOV

Jos=C3=A9 Roberto de Souza (2):
      drm/i915/display/ehl: Update voltage swing table
      drm/i915/display/adlp: Implement new step in the TC voltage
swing prog sequence

Lukas Fink (1):
      drm/amdgpu: Fix rejecting Tahiti GPUs

Mario Limonciello (1):
      drm/amd/display: Revert W/A for hard hangs on DCN20/DCN21

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         | 45 +++++++++---------=
----
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      | 32 ++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  5 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c           | 20 ++++------
 drivers/gpu/drm/amd/amdgpu/cik.c                   |  4 ++
 drivers/gpu/drm/amd/amdgpu/vi.c                    |  4 ++
 .../amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c   | 11 +-----
 .../drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c  | 11 +-----
 .../amd/display/dc/irq/dcn20/irq_service_dcn20.c   | 25 ------------
 .../amd/display/dc/irq/dcn20/irq_service_dcn20.h   |  2 -
 .../amd/display/dc/irq/dcn21/irq_service_dcn21.c   | 25 ------------
 .../amd/display/dc/irq/dcn21/irq_service_dcn21.h   |  2 -
 drivers/gpu/drm/amd/display/dc/irq/irq_service.c   |  2 +-
 drivers/gpu/drm/amd/display/dc/irq/irq_service.h   |  4 --
 drivers/gpu/drm/i915/display/intel_ddi.c           | 22 +++++++++++
 drivers/gpu/drm/i915/display/intel_ddi_buf_trans.c | 10 ++---
 drivers/gpu/drm/i915/i915_reg.h                    |  8 +++-
 drivers/gpu/drm/radeon/radeon_kms.c                | 22 ++++++-----
 18 files changed, 108 insertions(+), 146 deletions(-)
