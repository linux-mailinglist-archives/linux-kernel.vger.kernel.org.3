Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD08525AF4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 07:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377055AbiEMFIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 01:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351159AbiEMFIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 01:08:10 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5BB66F86
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 22:08:07 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id g6so14070431ejw.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 22:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Sz00vPcQHDBQVtuU0sPD4tpJzhuX360WEPKPVTTI6mM=;
        b=NxCRYfUET+ljK8C7QT/Zi2kIk6j7cFOFyBLhaSlkWgWvemYExHG8cFawL7rZZ7fIzR
         /4CRl9A2wU1sb8qtzpEjoDQSL0KhMeJ8i5d3NYeawooZ8OVAsKIRT17jq4IZPe0R/mX1
         80Os4YjeHH9bAXE6nuuZPJEDZ4/dNN3hLAALv/DGiCZ11bVI49U49EqWw4RjqfWuwOjB
         sBcB0O9+W24fWEUj79dCjayULaO24c2oNFjzieGLadHOYX/7CKk2lEHq0hf+IAcUSXfw
         pXtdeh2ZSpg+s2x3x/CfM1Rndz2WTLC2WSkDjKkCOVuxx37fiKfN/l09VtSWVlo6+d1Z
         ITow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Sz00vPcQHDBQVtuU0sPD4tpJzhuX360WEPKPVTTI6mM=;
        b=5kBpEw4cqrmN1YwFPbvyH8Wzc3yjwKqbEA4WqcqfkbXvL4YAklqlNmQY3hA12aonRn
         FVhqiZEKT9zxmvUSrLizhP8GCAy/tWxPJtkGR+iVBwpdGK/ZNtmqM5xZ1++9Ey2rIDrk
         0e+XCoONa8YxsuqRyWR5R260V+SnldWpmp2AHyrx3SxpQBA2qPFSvY7lnls1gyHgkw90
         VNQFFNrciK31NaSxXRhfU+oPEa2n9gmxQiF48IM1mXji8ivGCvVL322eTLcyGX8qE01H
         I+pgbiR5gjAmjsfFy0hfUdxdCp7hRIfcU7B+VcSWhc90u3ysGrB0yWzVNAwXiI0c+a0o
         esgA==
X-Gm-Message-State: AOAM533Z2+D9jGlPZkuPQF1PLSv7QnJmFmyS9pmK4RmvTGSb7fzgutz6
        4U027iyIU89nOjpSWT0VaATtZvW73vuYYCLI2k0=
X-Google-Smtp-Source: ABdhPJzi7zabwbrDmSfS0Dx8bhCJ47/rHtiPXNIVl3rCexpbkpUcW1dks+I5Y3JDMnhaqPlj/GxztJOk5s5m/7acUVQ=
X-Received: by 2002:a17:907:1c0b:b0:6f5:64f4:91df with SMTP id
 nc11-20020a1709071c0b00b006f564f491dfmr2740216ejc.750.1652418486338; Thu, 12
 May 2022 22:08:06 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 13 May 2022 15:07:55 +1000
Message-ID: <CAPM=9twJK9u=8+8UMtTRvxe4yUkSQBcOLa_gzB+Me3W=qoOv4A@mail.gmail.com>
Subject: [git pull] drm fixes for 5.18-rc7
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
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

Pretty quiet week on the fixes front, 4 amdgpu and one i915 fix.

I think there might be a few misc fbdev ones outstanding, but I'll see
if they are necessary and pass them on if so.

Dave.

drm-fixes-2022-05-13:
drm fixes for 5.18-rc7

amdgpu:
- Disable ASPM for VI boards on ADL platforms
- S0ix DCN3.1 display fix
- Resume regression fix
- Stable pstate fix

i915:
- fix for kernel memory corruption when running a lot of OpenCL tests
in parallel
The following changes since commit c5eb0a61238dd6faf37f58c9ce61c9980aaffd7a:

  Linux 5.18-rc6 (2022-05-08 13:54:17 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-05-13

for you to fetch changes up to 5005e9814698f47c5a3698fcc56c9f5e6f1d4644:

  Merge tag 'amd-drm-fixes-5.18-2022-05-11' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes (2022-05-13
10:40:56 +1000)

----------------------------------------------------------------
drm fixes for 5.18-rc7

amdgpu:
- Disable ASPM for VI boards on ADL platforms
- S0ix DCN3.1 display fix
- Resume regression fix
- Stable pstate fix

i915:
- fix for kernel memory corruption when running a lot of OpenCL tests
in parallel

----------------------------------------------------------------
Alex Deucher (2):
      Revert "drm/amd/pm: keep the BACO feature enabled for suspend"
      drm/amdgpu/ctx: only reset stable pstate if the user changed it (v2)

Dave Airlie (2):
      Merge tag 'drm-intel-fixes-2022-05-12' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'amd-drm-fixes-5.18-2022-05-11' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes

Eric Yang (1):
      drm/amd/display: undo clearing of z10 related function pointers

Karol Herbst (1):
      drm/i915: Fix race in __i915_vma_remove_closed

Richard Gong (1):
      drm/amdgpu: vi: disable ASPM on Intel Alder Lake based systems

 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c           |  5 +++++
 drivers/gpu/drm/amd/amdgpu/vi.c                   | 17 ++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c |  5 -----
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c         |  8 +-------
 drivers/gpu/drm/i915/i915_vma.c                   | 11 +++++++----
 5 files changed, 29 insertions(+), 17 deletions(-)
