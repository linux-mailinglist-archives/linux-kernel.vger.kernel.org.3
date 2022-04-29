Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC77D513FCB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 02:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353577AbiD2Ax7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 20:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353264AbiD2Axz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 20:53:55 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550F8762AB
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 17:50:38 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id p4so7416319edx.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 17:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=HLS85NRqZtg3G9bQ44dtccEj9xPw7oZObAgscfsjMGw=;
        b=SINyaraVZu6iC+jg6TL6Kzx7o+y6TwZra23I3BUJytk6wYDmi2i6XYBxVKL9lmo4LR
         /6JpU+uQL9XUo/aR1P9+FXPxxSegSoqx6IHNeT34LuP6/iI/87ffvUJtR/4ACmqd5Plx
         c4tpd4zmhusjVflGHOItNy9cK7kmbNp8YfBfBVAwvuvkuTRXAdColv1aCQEZ/f5jXRqN
         oBlsa90MtgCRQMQw3LpwPk3ipxyyLEKu8KJiMCL8g8soqSVCRtw6jKl7+vMCj4ZqNXB1
         whow6oBH1/fGrJAmoYMBXb2If97/wGcSvzY4pyoPGYwFX825VHDbsyrDY712AgyVYL6G
         ou5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=HLS85NRqZtg3G9bQ44dtccEj9xPw7oZObAgscfsjMGw=;
        b=VeGPHRo3t/GCQOo72DpPzIm13wAzvhTo8tRsJAtYZCGSKxLdowwNusFkKybSpU4yO2
         aKi2ZlMBEb8+oQFpswPOjVe5ZKRIzwRU/HBwPXtxGaKBCpG7EysV52fdd9YoGckgrBnv
         emLzGpzNfQSw0NHFFryjSofQCBTLmQKm5r+wWiAl4CmVWI3+kYA9QqzIEcO7BIk514bB
         y187SfDcK5YNV56v4b2XNugNALvhbhQcYFtiXnDTTeeaUPBPxTnh4EgVdfF9GSyXqZMg
         NVhCAZ5M+jdrAjiVPkCtxc5ftPEUVQz3kB3XfueJ48TVRG+0aipimSOYHnp5X7S/rV4Z
         B6dQ==
X-Gm-Message-State: AOAM531PWTOG7thPvxfVhzRv6V/pAIFiYFxL7X6cKR6vt3KaxKNgUkpA
        LnN3N/ruHkMD+Q8HnoqpKoS14dGZ2C4a4J7uu8FTYR/ZgDC0IA==
X-Google-Smtp-Source: ABdhPJx86rlEa4DQbr5QeLvqbLOWqZwLZTyMJSUQoHynW2rxORE9FON12/AmJf9h9pwBmeC1S3DV9MIatBt5M6zS8Y4=
X-Received: by 2002:a05:6402:42d4:b0:416:5cac:a9a0 with SMTP id
 i20-20020a05640242d400b004165caca9a0mr38753482edc.86.1651193436699; Thu, 28
 Apr 2022 17:50:36 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 29 Apr 2022 10:50:25 +1000
Message-ID: <CAPM=9tydvfoBFBAY_Vba2vX=26ePwBZumRxnKWA7Lj5+G+tr5g@mail.gmail.com>
Subject: [git pull] drm fixes for 5.18-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Another relatively quiet week, amdgpu leads the way, some i915 display
fixes, and a single sunxi fix.

Regards,
Dave.

drm-fixes-2022-04-29:
drm fixes for 5.18-rc5

amdgpu:
- Runtime pm fix
- DCN memory leak fix in error path
- SI DPM deadlock fix
- S0ix fix

amdkfd:
- GWS fix
- GWS support for CRIU

i915:
- Fix #5284: Backlight control regression on XMG Core 15 e21
- Fix black display plane on Acer One AO532h
- Two smaller display fixes

sunxi:
- Single fix removing applying PHYS_OFFSET twice
The following changes since commit af2d861d4cd2a4da5137f795ee3509e6f944a25b=
:

  Linux 5.18-rc4 (2022-04-24 14:51:22 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-04-29

for you to fetch changes up to 9d9f720733b7e8d11e4cc53b53f461b117dab839:

  Merge tag 'amd-drm-fixes-5.18-2022-04-27' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes (2022-04-29
10:27:05 +1000)

----------------------------------------------------------------
drm fixes for 5.18-rc5

amdgpu:
- Runtime pm fix
- DCN memory leak fix in error path
- SI DPM deadlock fix
- S0ix fix

amdkfd:
- GWS fix
- GWS support for CRIU

i915:
- Fix #5284: Backlight control regression on XMG Core 15 e21
- Fix black display plane on Acer One AO532h
- Two smaller display fixes

sunxi:
- Single fix removing applying PHYS_OFFSET twice

----------------------------------------------------------------
Alex Deucher (1):
      drm/amdgpu: don't runtime suspend if there are displays attached (v3)

Dave Airlie (3):
      Merge tag 'drm-misc-fixes-2022-04-27' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2022-04-28' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'amd-drm-fixes-5.18-2022-04-27' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes

David Yat Sin (2):
      drm/amdkfd: Fix GWS queue count
      drm/amdkfd: CRIU add support for GWS queues

Evan Quan (1):
      drm/amd/pm: fix the deadlock issue observed on SI

Hans de Goede (1):
      drm/i915: Fix DISP_POS_Y and DISP_HEIGHT defines

Imre Deak (1):
      drm/i915: Fix SEL_FETCH_PLANE_*(PIPE_B+) register addresses

Jouni H=C3=B6gander (1):
      drm/i915: Check EDID for HDR static metadata when choosing blc

Miaoqian Lin (1):
      drm/amd/display: Fix memory leak in dcn21_clock_source_create

Prike Liang (1):
      drm/amdgpu: keep mmhub clock gating being enabled during s2idle suspe=
nd

Samuel Holland (1):
      drm/sun4i: Remove obsolete references to PHYS_OFFSET

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915/fbc: Consult hw.crtc instead of uapi.crtc

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            | 105 ++++++++++++++---=
----
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c             |  10 ++
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |  83 ++++++++--------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |   2 +-
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |  10 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_resource.c  |   1 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                |  39 ++++++++
 drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c     |  10 --
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c         |  35 -------
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c   |  10 --
 .../gpu/drm/i915/display/intel_dp_aux_backlight.c  |  34 +++++--
 drivers/gpu/drm/i915/display/intel_fbc.c           |   2 +-
 drivers/gpu/drm/i915/i915_reg.h                    |   6 +-
 drivers/gpu/drm/sun4i/sun4i_frontend.c             |   3 -
 14 files changed, 195 insertions(+), 155 deletions(-)
