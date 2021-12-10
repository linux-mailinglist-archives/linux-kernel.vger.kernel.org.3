Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53A8146F9DA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 05:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbhLJEcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 23:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbhLJEck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 23:32:40 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF166C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 20:29:05 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id y13so25707641edd.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 20:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=7+XHAAFmJnNl1N/GcfKeTFDv+qRmpgDkY8DdxjU6bmQ=;
        b=RxoDd64XcVniZSqcVST6h7cqygZDN5yBunUjq80zbK7DNNZaGzapKz5d7mVDCk9Pp1
         ne3H8PQs01rUiqOkGcJADEy+hTeLNuQlSxSp6AxKQmDhxwohfnkUfLe3UauCFq5chb7d
         Oz2Z1VzU3ZS1KfORPkC1fCcMKUIHfZzQrotFe5TsmyQN2vMGf3KPls7rt+mUy7tvLbQw
         Fm/uUK1A3+hKCPUD3xU+mouj38Cz9W4AErybkY8Rsgr2AZStiY6iKjIyv4MUIPE1uLd8
         yrfgcUl2gtIwyuz0Qc5ydPUtJWorZeiFWLv59n6rDiMrNo1c7HEdHdngQ+7M8HdMTsRy
         pxzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=7+XHAAFmJnNl1N/GcfKeTFDv+qRmpgDkY8DdxjU6bmQ=;
        b=ZZ1L1bukeVK3M09d7ZlaMKDJ1zm1eSdRIvU7fBMveHFIP8IDuLeLH59viVy85CW9DZ
         n+hwETjL+ijMzLjTJjWSfJOuFjSFJxwfO5W8N3T5oURYpMmFUFD+qyWvqQlrfJKnYSh/
         0YfIFe+ABlZ6ijrA6gS8Nw6QVERwgYKEFR8jgihsRpP+A3x3YmuETBGN9/M579+AdGBA
         e7Go7mxcOwofFBJqPaOAPaOvFHPkRTzeg8s43w1EEqUdlH418ieP/8xMXGp5B7Y7Le7n
         wR6rXVHJzRyp5TEOcsLzR1OJqghE1TDQZtqIvX3f52o1Bbxi1UJw4aQRJDdB/O+gJ/af
         dZrA==
X-Gm-Message-State: AOAM531WArTvulKpvhR5Z/0OwBeUb/cvjo36gnPCt6ql674pAjrdLfjR
        IKIJQUXMbUp5b6P7s5aq7mgJ0Lnp1AQzMpgSMfZxRab06aY=
X-Google-Smtp-Source: ABdhPJy0OB5y1/KcoN9bnIp2xLAcsnL9ImmLkuy1mY/2SKgheN6NQi1j5pUXtlJ8hsXauOLRuANG4miFvINfVhAX68g=
X-Received: by 2002:a17:906:5d09:: with SMTP id g9mr21621955ejt.3.1639110544364;
 Thu, 09 Dec 2021 20:29:04 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 10 Dec 2021 14:28:53 +1000
Message-ID: <CAPM=9twm_TjmNrr7VELofghf58qpo=-1VmFf_pNr6tBNKZL-aw@mail.gmail.com>
Subject: [git pull] drm fixes for 5.16-rc5
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

Regular fixes, pretty small overall, couple of core fixes, two i915
and two amdgpu, hopefully it stays this quiet.

Regards,
Dave.

drm-fixes-2021-12-10:
drm fixes for 5.16-rc5

ttm:
- fix ttm_bo_swapout

syncobj:
- fix fence find bug with signalled fences

i915:
- fix error pointer deref in gem execbuffer
- fix for GT init with GuC/HuC on ICL

amdgpu:
- DPIA fix
- eDP fix
The following changes since commit 0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1=
:

  Linux 5.16-rc4 (2021-12-05 14:08:22 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-12-10

for you to fetch changes up to 675a095789a2663fe02fdebd6023e29d7f1f51ac:

  Merge tag 'amd-drm-fixes-5.16-2021-12-08' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes (2021-12-10
14:10:55 +1000)

----------------------------------------------------------------
drm fixes for 5.16-rc5

ttm:
- fix ttm_bo_swapout

syncobj:
- fix fence find bug with signalled fences

i915:
- fix error pointer deref in gem execbuffer
- fix for GT init with GuC/HuC on ICL

amdgpu:
- DPIA fix
- eDP fix

----------------------------------------------------------------
Bas Nieuwenhuizen (1):
      drm/syncobj: Deal with signalled fences in drm_syncobj_find_fence.

Christian K=C3=B6nig (1):
      drm/ttm: fix ttm_bo_swapout

Dan Carpenter (1):
      drm/i915: Fix error pointer dereference in i915_gem_do_execbuffer()

Dave Airlie (3):
      Merge tag 'drm-misc-fixes-2021-12-09' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2021-12-09' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'amd-drm-fixes-5.16-2021-12-08' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes

Mikita Lipski (1):
      drm/amd/display: prevent reading unitialized links

Nicholas Kazlauskas (1):
      drm/amd/display: Fix DPIA outbox timeout after S3/S4/reset

Raviteja Goud Talla (1):
      drm/i915/gen11: Moving WAs to icl_gt_workarounds_init()

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  7 ++++++-
 drivers/gpu/drm/amd/display/dc/dc_link.h          |  2 ++
 drivers/gpu/drm/drm_syncobj.c                     | 11 ++++++++++-
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c    |  1 +
 drivers/gpu/drm/i915/gt/intel_workarounds.c       | 18 +++++++++---------
 drivers/gpu/drm/ttm/ttm_bo.c                      |  3 ++-
 6 files changed, 30 insertions(+), 12 deletions(-)
