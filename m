Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72DD54E6C6C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 03:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354529AbiCYCPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 22:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346712AbiCYCPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 22:15:06 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FB94CD5D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 19:13:33 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id a17so7668603edm.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 19:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=x/SKwnS2wQi9dJJ6CWGROEW1ewpvhEn8StiIdhWUEWI=;
        b=iDMYY7FwsUa++dMovFKpAJmACqJEFzXM6eEjeuDTd0+cClHJfPUKyh7ELo3liADDQ0
         /NBQ9+Cu+un/PYWM8BKpXk7Kq/DoKsnMSDekvfwW9Yqu4XEfEAM0r6Ga8Qp0fauo5zq4
         3ZtUSOqkOR5ovCNp4c1IE55cdeco21MLx9T1SKyW8RqP9FzjiAEFlNRYMz5rEj94b0o+
         6M1sLAGijkffXKrDHia5CctnMQlNPjA1HT8ZMZEMpFO3n74T8TBzvbw1zeUQHupzneRD
         0CysiYfcjx9NUGxEV1mIZJ63WEan1TDEEzitAKRafWOve4KAvJIwNfJQ7JITKVEmL16W
         caQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=x/SKwnS2wQi9dJJ6CWGROEW1ewpvhEn8StiIdhWUEWI=;
        b=YpnVp711H/Ay89QXZNkFxZV2wE2/nAg84V2ukuh6GHTzrFZJECOn1h7nAOCx4DV8Lj
         z6oAJFl/TB9V/wKWQiMD6TPdmw+HLd0e15fl1J59kDY4GJOozNcKqAC123FZbswClaT8
         TsAGH9NO0klLxkci+eKUAFxN95Tqa1ZPIkY7yTY/4I8eTi5MfAu3mGjAyePTvpaJxzMc
         EzVHNPYslM8qckmTp4vPookVRBOtEh6jCCI1/7zvIryZBQPbugYhjsLLd5FkLzgR1x1g
         DRbo55YWty6DiZjrn44pWNC0SrWRum9nTqJl12GQBar+PxBDOkFD6f1218ieXftzIoNt
         ac8Q==
X-Gm-Message-State: AOAM533OCj75GjMIlCHRIOlzEryPMXcj5te+aNVX8FOiwQRnXhgnjEog
        5+P5OG4Kvw06OwxP5PFzwMoP1qrZfLWWchi8nzIgYuWOlFc=
X-Google-Smtp-Source: ABdhPJyOinrH+nfJItL/ZWM2gMcQcwufOzrDZXE42o6EdU71rXSuPvg6bKQEeYRFLPshtt3PqR1zwwOFW1hzs85F9tA=
X-Received: by 2002:a05:6402:354b:b0:419:4af8:c5c9 with SMTP id
 f11-20020a056402354b00b004194af8c5c9mr10326050edd.91.1648174411417; Thu, 24
 Mar 2022 19:13:31 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 25 Mar 2022 12:13:20 +1000
Message-ID: <CAPM=9ty8CYpuQ05BjgB9_CBRUjiL5PMTF-irHRXKOWtOrgxxZA@mail.gmail.com>
Subject: [git pull] drm fixes for 5.18-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
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

Some fixes were queued up in and in light of the fbdev regressions,
I've pulled those in as well,
I think the mediatek one is going to be a bit more painful, since now
you have a merge and I need to have the mediatek stuff get rebased and
retested onto that merge point, but I'll make sure they get to you
ASAP.

Thomas, cc'ed, I pulled your fbdev fixes from patchwork, since they
were a clear regression fix, don't bother queueing them up in our
trees now.

Dave.

drm-next-2022-03-25:
drm fixes for 5.18-rc1

core:
- Make audio and color plane support checking only happen
  when a CEA extension block is found.
- Small selftest fix.

fbdev:
- two regressions fixes from speedup patches.

ttm:
- Fix a small regression from ttm_resource_fini()

i915:
- Reject unsupported TMDS rates on ICL+
- Treat SAGV block time 0 as SAGV disabled
- Fix PSF GV point mask when SAGV is not possible
- Fix renamed INTEL_INFO->media.arch/ver field
The following changes since commit c6e90a1c660874736bd09c1fec6312b4b4c2ff7b=
:

  Merge tag 'amd-drm-next-5.18-2022-03-18' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next (2022-03-21
13:48:20 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-next-2022-03-25

for you to fetch changes up to 2a81dba4b577099717cea86d429f053e85e74d96:

  fbdev: Fix cfb_imageblit() for arbitrary image widths (2022-03-25
09:55:54 +1000)

----------------------------------------------------------------
drm fixes for 5.18-rc1

core:
- Make audio and color plane support checking only happen
  when a CEA extension block is found.
- Small selftest fix.

fbdev:
- two regressions fixes from speedup patches.

ttm:
- Fix a small regression from ttm_resource_fini()

i915:
- Reject unsupported TMDS rates on ICL+
- Treat SAGV block time 0 as SAGV disabled
- Fix PSF GV point mask when SAGV is not possible
- Fix renamed INTEL_INFO->media.arch/ver field

----------------------------------------------------------------
Cooper Chiou (1):
      drm/edid: check basic audio support on CEA extension block

Dave Airlie (2):
      Merge tag 'drm-intel-next-fixes-2022-03-24' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'drm-misc-next-fixes-2022-03-24-1' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next

Jani Nikula (1):
      drm/edid: fix CEA extension byte #3 parsing

Lucas De Marchi (1):
      drm/i915: Fix renamed struct field

Nathan Chancellor (1):
      drm/selftest: plane_helper: Put test structures in static storage

Thomas Zimmermann (2):
      fbdev: Fix sys_imageblit() for arbitrary image widths
      fbdev: Fix cfb_imageblit() for arbitrary image widths

Ville Syrj=C3=A4l=C3=A4 (3):
      drm/i915: Reject unsupported TMDS rates on ICL+
      drm/i915: Treat SAGV block time 0 as SAGV disabled
      drm/i915: Fix PSF GV point mask when SAGV is not possible

Zack Rusin (1):
      drm/ttm: Fix a kernel oops due to an invalid read

 drivers/gpu/drm/drm_edid.c                        | 15 ++++++++----
 drivers/gpu/drm/i915/display/intel_bw.c           |  3 ++-
 drivers/gpu/drm/i915/display/intel_hdmi.c         |  9 +++++++
 drivers/gpu/drm/i915/i915_drv.h                   |  2 +-
 drivers/gpu/drm/i915/intel_pm.c                   | 10 ++++----
 drivers/gpu/drm/selftests/test-drm_plane_helper.c |  8 +++----
 drivers/gpu/drm/ttm/ttm_range_manager.c           |  2 +-
 drivers/video/fbdev/core/cfbimgblt.c              | 28 ++++++++++++++++++-=
---
 drivers/video/fbdev/core/sysimgblt.c              | 29 +++++++++++++++++++=
----
 9 files changed, 82 insertions(+), 24 deletions(-)
