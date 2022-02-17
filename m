Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577434BAA89
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 21:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245626AbiBQUCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 15:02:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237756AbiBQUCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 15:02:52 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A736432ECD
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 12:02:37 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a8so9822852ejc.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 12:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=zwB/h69xW9yj6Ty8TGYAgMTvzI7yKl/J6os7tmVG8hk=;
        b=Z6IM4n7D7BR9Azbk64T0ST0aio5CB7tJz7DsneFlHEelJGIhtviGck7LlX1t3tlagp
         ymZ5jSHPl6DTKnZzFJbpeyCIKJjUn9gdwqQ15NRowfE9gclPXyZ0RCOmhhKYAQLQeGAd
         73QJABrkI53ibMqiZehK3/n4+KHh9f8HQjODcZUHsHUnzGADQndVAlQJb5YVCQiDbEfk
         YzjjLLxw/Kl33ZQ9TEIdYKZ5VghGZjKM1wDRSH5WpQ63oGKcddP9RhmFGqhhWrPs1S+Q
         +orA1dgQwJKv0l38Nw38C2H8jAmGffJelzJX819WGYePjuQOBJLlKnBgDdm80OAZcKyL
         yNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=zwB/h69xW9yj6Ty8TGYAgMTvzI7yKl/J6os7tmVG8hk=;
        b=wf5bawCyP5WwAEAXUAP9R0Teji8Z8bx67TlgpNVVd3jKCdzES0K9+zM67JxJuNqU1F
         RnDRDoMSs4cYpfwyq1Nf1LBl4rW7Q3UIqxvz2yhN4LdpX8Dp1cqxPapQvpwpyUKIycB7
         +U3dNCEwXkqKULS0fWdxx0202IC02qdp6JZkC0EStIAHn7c/E0CgTSlz6aQXTaQu0lEf
         MtAnKRs0pj1Ub/Npjb8Zq0y0NmKp/gumJB36avqdHQtoq/1a6sELomlvTkU8rn6egatL
         svhKAHExdfjh5KG6uT9VORPpGUsyKhXwayRNtiQrqtxAzd0tpdxM88YoBoLlNpcPVS7N
         xWow==
X-Gm-Message-State: AOAM5325QfhgG32kAIwnK0fiNTgEDu34rkl1QlmQswbytOfHBjf/x4dV
        H9PYXF58U1yPWoY2W/qBUXFjH85zhp5bJe5oJWg=
X-Google-Smtp-Source: ABdhPJxOTCX50FPYU2SSNKeEDAse+q/1hNmgI0XWl4xuaRlfsPIq7hYUBJcblG+UZyKb12ZIri+Xv87Nht0LBXJ64B4=
X-Received: by 2002:a17:906:cd17:b0:6ce:3727:65f2 with SMTP id
 oz23-20020a170906cd1700b006ce372765f2mr3743532ejb.720.1645128156006; Thu, 17
 Feb 2022 12:02:36 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 18 Feb 2022 06:02:24 +1000
Message-ID: <CAPM=9txai3TyGC3KHjkjLi6UMC-vKRoPJ8p+UpNKXy6Km=1jNQ@mail.gmail.com>
Subject: [git pull] drm fixes for 5.17-rc5
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

Regular fixes for rc5, nothing really stands out, mostly some amdgpu
and i915 fixes with mediatek, radeon and some misc fixes.

Dave.

drm-fixes-2022-02-18:
drm fixes for 5.17-rc5

cma-helper:
- set VM_DONTEXPAND

atomic:
- error handling fix.

mediatek:
- fix probe defer loop with external bridge

amdgpu:
- Stable pstate clock fixes for Dimgrey Cavefish and Beige Goby
- S0ix SDMA fix
- Yellow Carp GPU reset fix

radeon:
- Backlight fix for iMac 12,1

i915:
- GVT kerneldoc cleanup.
- GVT Kconfig should depend on X86
- Prevent out of range access in SWSCI display code.
- Fix mbus join and dbuf slice config lookup.
- Fix inverted priority selection in the TTM backend.
- Fix FBC plane end Y offset check.
The following changes since commit 754e0b0e35608ed5206d6a67a791563c631cec07=
:

  Linux 5.17-rc4 (2022-02-13 12:13:30 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-02-18

for you to fetch changes up to 5666b610194705587807a1078753eadc007b9d79:

  Merge tag 'drm-intel-fixes-2022-02-17' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2022-02-18
05:44:45 +1000)

----------------------------------------------------------------
drm fixes for 5.17-rc5

cma-helper:
- set VM_DONTEXPAND

atomic:
- error handling fix.

mediatek:
- fix probe defer loop with external bridge

amdgpu:
- Stable pstate clock fixes for Dimgrey Cavefish and Beige Goby
- S0ix SDMA fix
- Yellow Carp GPU reset fix

radeon:
- Backlight fix for iMac 12,1

i915:
- GVT kerneldoc cleanup.
- GVT Kconfig should depend on X86
- Prevent out of range access in SWSCI display code.
- Fix mbus join and dbuf slice config lookup.
- Fix inverted priority selection in the TTM backend.
- Fix FBC plane end Y offset check.

----------------------------------------------------------------
AngeloGioacchino Del Regno (1):
      drm/mediatek: mtk_dsi: Avoid EPROBE_DEFER loop with external bridge

Dave Airlie (4):
      Merge tag 'mediatek-drm-fixes-5.17' of
https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux
into drm-fixes
      Merge tag 'amd-drm-fixes-5.17-2022-02-16' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2022-02-17' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2022-02-17' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

Evan Quan (1):
      drm/amd/pm: correct UMD pstate clocks for Dimgrey Cavefish and Beige =
Goby

Jani Nikula (1):
      drm/i915/opregion: check port number bounds for SWSCI display power s=
tate

Matthew Auld (1):
      drm/i915/ttm: tweak priority hint selection

Nicholas Bishop (1):
      drm/radeon: Fix backlight control on iMac 12,1

Rajib Mahapatra (1):
      drm/amdgpu: skipping SDMA hw_init and hw_fini for S0ix.

Randy Dunlap (1):
      drm/i915/gvt: clean up kernel-doc in gtt.c

Robin Murphy (1):
      drm/cma-helper: Set VM_DONTEXPAND for mmap

Siva Mullati (1):
      drm/i915/gvt: Make DRM_I915_GVT depend on X86

Tvrtko Ursulin (1):
      Merge tag 'gvt-fixes-2022-01-13' of
https://github.com/intel/gvt-linux into drm-intel-fixes

Ville Syrj=C3=A4l=C3=A4 (4):
      drm/i915: Fix dbuf slice config lookup
      drm/i915: Fix mbus join config lookup
      drm/i915/fbc: Fix the plane end Y offset check
      drm/atomic: Don't pollute crtc_state->mode_blob with error pointers

Yifan Zhang (1):
      drm/amd/pm: correct the sequence of sending gpu reset msg

 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |   8 +
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |  26 +++-
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.h    |   8 +
 .../gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c   |   9 +-
 drivers/gpu/drm/drm_atomic_uapi.c                  |  14 +-
 drivers/gpu/drm/drm_gem_cma_helper.c               |   1 +
 drivers/gpu/drm/i915/Kconfig                       |   1 +
 drivers/gpu/drm/i915/display/intel_fbc.c           |   3 +-
 drivers/gpu/drm/i915/display/intel_opregion.c      |  15 ++
 drivers/gpu/drm/i915/gem/i915_gem_ttm.c            |   6 +-
 drivers/gpu/drm/i915/gvt/gtt.c                     |   4 +-
 drivers/gpu/drm/i915/intel_pm.c                    |   4 +-
 drivers/gpu/drm/mediatek/mtk_dsi.c                 | 167 +++++++++++------=
----
 drivers/gpu/drm/radeon/atombios_encoders.c         |   3 +-
 14 files changed, 158 insertions(+), 111 deletions(-)
