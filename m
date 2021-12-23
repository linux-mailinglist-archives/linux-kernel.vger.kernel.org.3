Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE33847E942
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 23:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbhLWWPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 17:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234511AbhLWWPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 17:15:04 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FE6C061401
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 14:15:04 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id x15so26549180edv.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 14:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=oiC/rweM7PDyBEylmxgJ15XBNpKsLom+FHSsECX/FB4=;
        b=phlIUx2yCg+uIRsMEf5ybGdFUQflg6SUAa1RN24K+tMEkanM6bg08r10hzYQPS9SoH
         A6cZUmbsLKTpPlkNqUUQCTvJTV/98WgqZ9eAeObbyNbRhayX7su0tPvG6/U2a3EQpLyo
         w+7ZRAB6pPkgeUv2hB7iMnj5S7jeINOLHG7G+ea6pd3JsQuhF/2L5tdt4hzMlumkRzlq
         bHhN8LcQzVLMKyClcSw3HNHWqpepbZN+H6IuNk5ylHm6g8R43yHtGopf4MOc988SjGA1
         sR91ScetKS8WlzbKtUKzN2L3lB2DA7GyMCEqYrjMgP5jSfAiZ3ajgyQ46c4uHQAQPa/E
         dK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=oiC/rweM7PDyBEylmxgJ15XBNpKsLom+FHSsECX/FB4=;
        b=NVPsp7qog8oGp2SCjimV4JcS4ZZItNOb6XzswdlbxbQaZ94TtNRe6LiTtuzH5f5RUb
         E+nDkt63WACLFTHf5d44s5ng2qpIsSsvcP6PheoFHqCHdxMoBM31X11XIQUDaZvdFePV
         CE6hHVhF5l9E3czZ2Qzz2XvG50gNKqhkEH3RKJE/t9rk8tH/0J4R5lTfOYGSrnehbZc4
         ItkRrgxDtToqvKmO4Hzf4GSidwee3kLtE2R9rYAG/RKPUDcOFP/P+0eVUzxZYZUHddSf
         rHsr+PexkxkBgJTxmIHjvOV9BfpduEIR76rOdysgccRqNCCUjXswESTug5N7XNl7g5uJ
         0jQw==
X-Gm-Message-State: AOAM530TI5u9ugRGcFAcwehXLK8YhG7k0Iqg2LUP5IsyrTQgY4L78eoB
        e1e/qJO6VzpMjbolYaBOGWSoM6Mph+aDGtLrBTevXzu9j02m0w==
X-Google-Smtp-Source: ABdhPJwvp4yqlmJJZZrkoV+Qi9rU47x16CUkFs0EbEddT8pEHWfk7HDv9u1tqB4MFkSA3CUzhWIuPNylLYGDIiYXPKA=
X-Received: by 2002:a17:906:6805:: with SMTP id k5mr3342104ejr.750.1640297702721;
 Thu, 23 Dec 2021 14:15:02 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 24 Dec 2021 08:14:51 +1000
Message-ID: <CAPM=9ty=B0ZvuwiQExR2-RoCZo18DZYrKMzTfK8-00psKncw9w@mail.gmail.com>
Subject: [git pull] drm fixes for 5.16-rc7
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus.

Happy Xmas, pull request. Nothing major, one mediatek and a couple of
i915 locking fixes. There might be a few stragglers over next week or
so but I don't expect much before next release.

Dave.

drm-fixes-2021-12-24:
drm fixes for 5.16-rc7

mediatek:
- NULL pointer check

i915:
- guc submission locking fixes
The following changes since commit a7904a538933c525096ca2ccde1e60d0ee62c08e:

  Linux 5.16-rc6 (2021-12-19 14:14:33 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-12-24

for you to fetch changes up to dbfba788c7ef839849e013264fef551e4d119d0b:

  Merge tag 'drm-intel-fixes-2021-12-22' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2021-12-23
11:21:44 +1000)

----------------------------------------------------------------
drm fixes for 5.16-rc7

mediatek:
- NULL pointer check

i915:
- guc submission locking fixes

----------------------------------------------------------------
AngeloGioacchino Del Regno (1):
      drm/mediatek: hdmi: Perform NULL pointer check for mtk_hdmi_conf

Dave Airlie (2):
      Merge tag 'mediatek-drm-fixes-5.16' of
https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux
into drm-fixes
      Merge tag 'drm-intel-fixes-2021-12-22' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

Matthew Brost (2):
      drm/i915/guc: Use correct context lock when callig clr_context_registered
      drm/i915/guc: Only assign guc_id.id when stealing guc_id

 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c |  6 +++---
 drivers/gpu/drm/mediatek/mtk_hdmi.c               | 12 +++++++-----
 2 files changed, 10 insertions(+), 8 deletions(-)
