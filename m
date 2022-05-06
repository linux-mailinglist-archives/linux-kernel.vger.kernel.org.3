Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D1B51CFFA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 06:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388890AbiEFELS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 00:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351670AbiEFELP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 00:11:15 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676964B1DD
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 21:07:33 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id p4so7352080edx.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 21:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=cLcttw2920SMZ2n3SvaPxUs5yeqm04dyc2xN9TwYgGg=;
        b=H0rUhC/o61g+LPERuMJDEwuzobWN7hEXMEAVbqwLU4GgZXPU4LVCQOQi+4GEah1j+Z
         PkzTBpYrAdApKrKW1U8j7bVri8W2sY2DAsBEHHFFmj89FB5ICYNuCn0GXYpeuoxDmlZ0
         u0emupYpj0g5LSKXIsbZ5LII/5KSKEW2nXlenDvUT+HFuGVuSRu8dGvicLCC1hXofx65
         gh051ykeIndWqX3fhshCr/aM5gFpclqai00hmokkPAKHic3iycx2Z+vJuzdAuDVgWUFn
         MgV60H62Zjy9WRcEoVIpwzX/FmB5Hz3tA5+Kql1s2rQa1FP5sXTFgPJveJOlo36oicuE
         uL3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=cLcttw2920SMZ2n3SvaPxUs5yeqm04dyc2xN9TwYgGg=;
        b=OxTTGDgm0kOTizCgeyV8I/kul3f+CgRNF4iwwjYxn5TeOdEB3kZNyyj2/kqte6Br5C
         EmlGtf0T1/TFB3byWmnAiU76/R4G42WVgcGhIG5fmSF/iRCXiwxIARDiD9z5nQjIdQ9m
         IGa7B4l91jiAuEiTcIRaWtOrRgwHfJK600taKO6o9daYT4x1YaWxekP+Kr2kLsBVkEd9
         fVVD+4M/0JCCGLjhZ6d5CJG/S37Ao9IT/pYkj3W2V7vIQWVcrgQ5qf7WFowujgs80N2i
         uB19lQlLKj5kKGmhdn4Pl99WXrl04twBIciALKc9lKEz1y0XFg28dKTDEdz8WU5PY7cf
         Ns+A==
X-Gm-Message-State: AOAM532FvWZydTWqPNbBOyvdljhnu+dBTBn+XkgTLjaMlW61PMQG0S+z
        O6vdcHKEg6AO0KLeDELF/cxIwexnrgJEc2TkaPx2nIYizWW5/g==
X-Google-Smtp-Source: ABdhPJwFg74w+azIwCGOdyFimmGh1zS5rojdBALGCLHvuKbQPhMvOvqk0h/4nvErkuD3/hrSDWlOAhxQxnRUd2jxy5o=
X-Received: by 2002:aa7:dd91:0:b0:427:b2c4:1c7a with SMTP id
 g17-20020aa7dd91000000b00427b2c41c7amr1540787edv.91.1651810051855; Thu, 05
 May 2022 21:07:31 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 6 May 2022 14:07:20 +1000
Message-ID: <CAPM=9tyaQ8RSYwuh4muEefV3fbjio5gVvYipWVaKjqUycRkS+A@mail.gmail.com>
Subject: 
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

pretty quiet week, one fbdev, msm, kconfig, and 2 amdgpu fixes, about
what I'd expect for rc6.

Regards,
Dave.

drm-fixes-2022-05-06:
drm fixes for 5.18-rc6

fbdev:
- hotunplugging fix

amdgpu:
- Fix a xen dom0 regression on APUs
- Fix a potential array overflow if a receiver were to
  send an erroneous audio channel count

msm:
- lockdep fix.

it6505:
- kconfig fix
The following changes since commit 672c0c5173427e6b3e2a9bbb7be51ceeec78093a=
:

  Linux 5.18-rc5 (2022-05-01 13:57:58 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-05-06

for you to fetch changes up to 5727375215b0915f28806c337a7ba9835efd340b:

  Merge tag 'drm-msm-fixes-2022-04-30' of
https://gitlab.freedesktop.org/drm/msm into drm-fixes (2022-05-06
11:22:03 +1000)

----------------------------------------------------------------
drm fixes for 5.18-rc6

fbdev:
- hotunplugging fix

amdgpu:
- Fix a xen dom0 regression on APUs
- Fix a potential array overflow if a receiver were to
  send an erroneous audio channel count

msm:
- lockdep fix.

it6505:
- kconfig fix

----------------------------------------------------------------
Dave Airlie (3):
      Merge tag 'amd-drm-fixes-5.18-2022-05-04' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2022-05-05' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-msm-fixes-2022-04-30' of
https://gitlab.freedesktop.org/drm/msm into drm-fixes

Fabien Parent (1):
      drm/bridge: ite-it6505: add missing Kconfig option select

Harry Wentland (1):
      drm/amd/display: Avoid reading audio pattern past AUDIO_CHANNELS_COUN=
T

Javier Martinez Canillas (1):
      fbdev: Make fb_release() return -ENODEV if fbdev was unregistered

Kuogee Hsieh (1):
      drm/msm/dp: remove fail safe mode related code

Marek Marczykowski-G=C3=B3recki (1):
      drm/amdgpu: do not use passthrough mode in Xen dom0

 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c         |  4 +++-
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c |  2 +-
 drivers/gpu/drm/bridge/Kconfig                   |  1 +
 drivers/gpu/drm/msm/dp/dp_display.c              |  6 ------
 drivers/gpu/drm/msm/dp/dp_panel.c                | 11 -----------
 drivers/gpu/drm/msm/dp/dp_panel.h                |  1 -
 drivers/video/fbdev/core/fbmem.c                 |  5 ++++-
 7 files changed, 9 insertions(+), 21 deletions(-)
