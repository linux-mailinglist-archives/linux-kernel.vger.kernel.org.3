Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8103154F005
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 06:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379915AbiFQEOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 00:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbiFQEN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 00:13:57 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC2865D25
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 21:13:54 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id fu3so6437799ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 21:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=MjbVE20S3qu8gYoRUcT9DaTHPrRc+KU19/yYOvnNiNw=;
        b=jCHMvuN/ftN05EQta/ACsyjK5DBeZbWH7sqdlr5GgBZ4E68PuT3q6D9BIgy2C5xLiA
         Z5cHbbz0xLVuPuuK80hp5/Uy7yNtk3owcx31Kpyw+8wvs1o1AnFq/UzBeYvSzu8Lirfx
         JstvYW0pulf1imRJEVXQAlAwT5RooNnVNJucHV3LEQ7ZU0SYNhvJEfGuNcra7g+ar6fa
         Wo28f2s1/osmb0Towsnt0nmTnyeX3uAy5EkWw7qUEHr9STXeSIhUCWXwOnmdZAW1U4f/
         p3cpG4SeEwxC8hnp990ZczXKO1Vs7fv3SRpFrcVtAToL181MQlQCFY2vL+7x7KTSD5Z+
         rEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=MjbVE20S3qu8gYoRUcT9DaTHPrRc+KU19/yYOvnNiNw=;
        b=IR//c0ByY9eXs5KNUgPurlUnCGI7OGdCoeS02tEHN5xsjxxi6o5RazzyQRVByhi8T7
         IzFUFUCziG+/4mLBx2f3mfwrU7+s6df/rxjBaeY1IZ6Wef+1irsIR0sv/7XaYfbRBd5c
         fyAYiCgiAGYiJUYoSExhuUoP74rcBq7ee//I+vhT47xr4wLZTXeFyzmiVJK8iS6ghCST
         1McRAbPQXHlpyw/BMPOMFj5abB0gtJEGOWVTrf2wjek5CfU6bYat/GoA8zCkNCKVPdbF
         trzrTK/YCIF9hKL3Vi3gZfjkDoVooQmZ9yKwKx6yuV8hJ/ULigTPuoCokk5f41mo5mOM
         Viag==
X-Gm-Message-State: AJIora/Zwqq138Ypqyb+/Ifttc8vt8ZVll/Zs3NBzZw95bbgBdfsjtLo
        7CaiA2ulkoi/kmqGBr9FQz9h4yrW596av/gsCE0=
X-Google-Smtp-Source: AGRyM1tK6PF/PK/vLjlN9Eud6B6YF77e91UMiWvQZYlQS+8pE3oEqsVt/e3BdltY/BtSHFuS5MlGqdb+aBQ/Dvq7aak=
X-Received: by 2002:a17:906:149:b0:712:502:bc62 with SMTP id
 9-20020a170906014900b007120502bc62mr7490981ejh.720.1655439233122; Thu, 16 Jun
 2022 21:13:53 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 17 Jun 2022 14:13:41 +1000
Message-ID: <CAPM=9twTA=AXfjj=eq558KLmE_TfmkoRsm6Sm5MUB0zCZ174Wg@mail.gmail.com>
Subject: [git pull] drm fixes for 5.19-rc3
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

Regular drm fixes for rc3. Nothing too serious, i915, amdgpu and
exynos all have a few small driver fixes, and two ttm fixes, and one
compiler warning.

Dave.

drm-fixes-2022-06-17:
drm fixes for 5.19-rc3

atomic:
- fix spurious compiler warning

ttm:
- add NULL ptr check in swapout code
- fix bulk move handling

i915:
- Fix page fault on error state read
- Fix memory leaks in per-gt sysfs
- Fix multiple fence handling
- Remove accidental static from a local variable

amdgpu:
- Fix regression in GTT size reporting
- OLED backlight fix

exynos:
- Check a null pointer instead of IS_ERR().
- Rework initialization code of Exynos MIC driver.
The following changes since commit b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3=
:

  Linux 5.19-rc2 (2022-06-12 16:11:37 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-06-17

for you to fetch changes up to 65cf7c02cfc7c36a3e86f3da5818dabc32c270ff:

  Merge tag 'exynos-drm-fixes-v5.19-rc3' of
git://git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm-exynos into
drm-fixes (2022-06-17 11:32:35 +1000)

----------------------------------------------------------------
drm fixes for 5.19-rc3

atomic:
- fix spurious compiler warning

ttm:
- add NULL ptr check in swapout code
- fix bulk move handling

i915:
- Fix page fault on error state read
- Fix memory leaks in per-gt sysfs
- Fix multiple fence handling
- Remove accidental static from a local variable

amdgpu:
- Fix regression in GTT size reporting
- OLED backlight fix

exynos:
- Check a null pointer instead of IS_ERR().
- Rework initialization code of Exynos MIC driver.

----------------------------------------------------------------
Alan Previn (1):
      drm/i915/reset: Fix error_state_read ptr + offset use

Ashutosh Dixit (1):
      drm/i915/gt: Fix memory leaks in per-gt sysfs

Christian K=C3=B6nig (2):
      drm/ttm: fix missing NULL check in ttm_device_swapout
      drm/ttm: fix bulk move handling v2

Dan Carpenter (1):
      drm/exynos: fix IS_ERR() vs NULL check in probe

Dave Airlie (4):
      Merge tag 'drm-misc-fixes-2022-06-16' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2022-06-16' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'amd-drm-fixes-5.19-2022-06-15' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'exynos-drm-fixes-v5.19-rc3' of
git://git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm-exynos into
drm-fixes

GONG, Ruiqi (1):
      drm/atomic: fix warning of unused variable

Jani Nikula (1):
      drm/i915/uc: remove accidental static from a local variable

Marek Szyprowski (1):
      drm/exynos: mic: Rework initialization

Michel D=C3=A4nzer (1):
      drm/amdgpu: Fix GTT size reporting in amdgpu_ioctl

Nirmoy Das (1):
      drm/i915: Individualize fences before adding to dma_resv obj

Roman Li (1):
      drm/amd/display: Cap OLED brightness per max frame-average luminance

 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c           |  2 -
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  8 ++--
 drivers/gpu/drm/exynos/exynos_drm_drv.c           |  6 +--
 drivers/gpu/drm/exynos/exynos_drm_mic.c           | 42 ++++++------------
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c    |  3 +-
 drivers/gpu/drm/i915/gt/intel_gt.c                |  1 +
 drivers/gpu/drm/i915/gt/intel_gt_sysfs.c          | 29 ++++++-------
 drivers/gpu/drm/i915/gt/intel_gt_sysfs.h          |  6 +--
 drivers/gpu/drm/i915/gt/intel_gt_types.h          |  3 ++
 drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c          |  2 +-
 drivers/gpu/drm/i915/i915_sysfs.c                 | 17 ++++++--
 drivers/gpu/drm/i915/i915_vma.c                   | 48 ++++++++++++-------=
--
 drivers/gpu/drm/ttm/ttm_bo.c                      | 22 ++++++----
 drivers/gpu/drm/ttm/ttm_device.c                  |  6 ++-
 drivers/gpu/drm/ttm/ttm_resource.c                | 52 ++++++++++++++++---=
----
 include/drm/drm_atomic.h                          |  1 +
 include/drm/ttm/ttm_resource.h                    |  8 ++--
 17 files changed, 141 insertions(+), 115 deletions(-)
