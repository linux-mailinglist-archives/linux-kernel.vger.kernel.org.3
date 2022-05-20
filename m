Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1547252F459
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 22:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353452AbiETUZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 16:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352457AbiETUY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 16:24:56 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF27318540A
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 13:24:51 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id kq17so17610095ejb.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 13:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=6rMPX8mUsyo3iaheF+6iJz3U2Wf9KckgyYK/6DZ7bVw=;
        b=JTZwG5H239H50Auny8sNxLSLFj9utsy568CrStcW2vVJCujdFakU2ugWfxbuD95qqi
         pg1Y2gg0OGy8O3b+LCN60H1hLNAao4OE8K2E6uIIOPeDXPvspEa7EmOOhbQuHeJ6d1CS
         SByq7ZEYpzqdV5beTQpLjvmpc4dfsc5tkJ+/2ZAGBzCaGLLRotPeMcgD/FF5TCglf0J8
         nhJfXh4ctlqezf6h6TTCoZXaPfsVFhh9hXZ2Vfe6+sv/sASXpSkw0JRlf0RvbuTENdBT
         ggPCsXvcvddoukjxikTBz4+kjEqHJbt/T+h+ICWXPiZ7FSPlOOf4KHHtV55zpr6hYMyY
         RRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=6rMPX8mUsyo3iaheF+6iJz3U2Wf9KckgyYK/6DZ7bVw=;
        b=6QOR5fVW78/ikIfRy2A/gJSlyE4e4pFGPs5CAJ+eOWjU6zKHAB4fh/X68fuWNjBxGB
         rQMg5o8gXciU9c64NGF7dvW6e3pqtTcPJD5WdDrh/vbSSuoYhL2XNlCv9C8q7qe2VORa
         bE/2+v+iYEtgCcex+uYkUX55lV0Hmh/6mrZm/LfTSvSEGnFzVRVP0PQktZvS8d2mvSA4
         c0tQR1xRGEpeDUMAcYuW0X0/sb2q2YusZApx8SyN7CUUC8UWtBqVPcXHupw8I8rH0B9U
         TEhUq0otkM9fIns4OexLcftn8nXh/GyTaVARBDE0/aXs1GzoZKY83VzFKbterao3WV7T
         c6bg==
X-Gm-Message-State: AOAM533g1j3ZBCfnaB8ALTavOA8nY7JrkyfEjX7bQDJIfpyyMn6vuJRy
        aldqvUb5Xcyy1q7bBepzBiDBUfdJrlm8dxIhO1k=
X-Google-Smtp-Source: ABdhPJxE1rbJtMSc/HTu9HH6yTuwqBnYws4BvdrX//bs1Hp4U0bTuoPHYgYaDuuR4vTjvOGErcSSeKbZoUz+LdxJPdw=
X-Received: by 2002:a17:907:1c0b:b0:6f5:64f4:91df with SMTP id
 nc11-20020a1709071c0b00b006f564f491dfmr10461256ejc.750.1653078290185; Fri, 20
 May 2022 13:24:50 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Sat, 21 May 2022 06:24:38 +1000
Message-ID: <CAPM=9tzncFLvW9htq+=r=BRT=2AiU58MEpvO0JikaBoUy3Kebw@mail.gmail.com>
Subject: [git pull] drm fixes for 5.18 final
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

Hi Linus,

Few final fixes for 5.18, one amdgpu, core dp mst leak fix, dma-buf
two fixes, and i915 has a few fixes, one for a regression on older
GM45 chipsets,

Regards,
Dave.

drm-fixes-2022-05-21:
drm fixes for 5.18 final

dma-buf:
- ioctl userspace use fix
- fix dma-buf sysfs name generation

core:
- dp/mst leak fix

amdgpu:
- suspend/resume regression fix

i915:
- fix for #5806: GPU hangs and display artifacts on 5.18-rc3 on Intel GM45
- reject DMC with out-of-spec MMIO
- correctly mark guilty contexts on GuC reset.
The following changes since commit 42226c989789d8da4af1de0c31070c96726d990c=
:

  Linux 5.18-rc7 (2022-05-15 18:08:58 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-05-21

for you to fetch changes up to 64eea6805ecf7092a113bdb4cb73860430d39de6:

  Merge tag 'drm-intel-fixes-2022-05-20' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2022-05-21
06:01:57 +1000)

----------------------------------------------------------------
drm fixes for 5.18 final

dma-buf:
- ioctl userspace use fix
- fix dma-buf sysfs name generation

core:
- dp/mst leak fix

amdgpu:
- suspend/resume regression fix

i915:
- fix for #5806: GPU hangs and display artifacts on 5.18-rc3 on Intel GM45
- reject DMC with out-of-spec MMIO
- correctly mark guilty contexts on GuC reset.

----------------------------------------------------------------
Anusha Srivatsa (1):
      drm/i915/dmc: Add MMIO range restrictions

Charan Teja Kalla (1):
      dma-buf: ensure unique directory name for dmabuf stats

Dave Airlie (3):
      Merge tag 'amd-drm-fixes-5.18-2022-05-18' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2022-05-20' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2022-05-20' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

Hangyu Hua (1):
      drm/dp/mst: fix a possible memory leak in fetch_monitor_name()

J=C3=A9r=C3=B4me Pouiller (1):
      dma-buf: fix use of DMA_BUF_SET_NAME_{A,B} in userspace

Maarten Lankhorst (1):
      drm/i915: Use i915_gem_object_ggtt_pin_ww for reloc_iomap

Mario Limonciello (1):
      drm/amd: Don't reset dGPUs if the system is going to s2idle

Umesh Nerlige Ramappa (1):
      i915/guc/reset: Make __guc_reset_context aware of guilty engines

 drivers/dma-buf/dma-buf.c                         |  8 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu.h               |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c          | 14 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c           |  2 +-
 drivers/gpu/drm/dp/drm_dp_mst_topology.c          |  1 +
 drivers/gpu/drm/i915/display/intel_dmc.c          | 44 +++++++++++++++++++=
++++
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c    |  6 ++--
 drivers/gpu/drm/i915/gt/intel_reset.c             |  2 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc.h            |  2 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c | 16 ++++-----
 drivers/gpu/drm/i915/gt/uc/intel_uc.c             |  2 +-
 drivers/gpu/drm/i915/gt/uc/intel_uc.h             |  2 +-
 drivers/gpu/drm/i915/i915_reg.h                   | 16 +++++++++
 include/uapi/linux/dma-buf.h                      |  4 +--
 14 files changed, 102 insertions(+), 19 deletions(-)
