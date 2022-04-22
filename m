Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1A850AE47
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 04:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443634AbiDVDAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 23:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443681AbiDVC7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 22:59:53 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757434EA02
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 19:56:39 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g20so8824218edw.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 19:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=I6Rk2jsbXOAIxG1A5lmiEupjlgITDVei+c3ecVf7c6I=;
        b=mfV9T4S5I5l4rgMoG1OpPRftD54XDgGTf9QNYQEiUbUTkDY2te8HSfF6N8cSqtsf+r
         TDzwAkkKyJtPg35vRjz096lcBqDWCJ8gW5hdtx+mbeIQjJSH+zpI+7eNyKwH1MTsF3hq
         MpgSYNHwL7XRGTngrV3cCq6nbX16lzyztdaeN3W+oMpr31v2UugssKeQNa9AVY1Jsb1G
         1p6nTKqlWZBaFxJEgfxANEqh+FayQkhY/Rx83SoEQWnJ/UkUGp9MncVz3QTfVab5p+fJ
         0dIaIWY0TZw9UiLC0yTP0+WMJbR13dbWZteU0qqEqod1n2CMKiyYxxSnrwliEzixdJf+
         tP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=I6Rk2jsbXOAIxG1A5lmiEupjlgITDVei+c3ecVf7c6I=;
        b=jz2VGFRT3QdaQjtVBu55Qze3pOd74eXh+odNaDS6LgwQxbCKISxXk5ZyN7r3krPykC
         jKbvfaviwdQ/RS/U7559wfOBn1KYTYGs0wXDDPzCW3anMYEPVoe1Zv8AsYeOPfR4ByHe
         KBXwITrpulCHTKgFW3FZ9ceF6GakRCXRNnPasrNSo0klw5IRvxav2jlNBKDObiBVVON4
         EpqsnG7WEdcFvWWwygMoHFUKCbAHnDHF96hjggrY4AIvErN7RC952p35DBNPXoxuQG2p
         ak2AnXJQi8TsOpZLH2VKFJ+2F5awckdhnxeRIOh6/yx8nn+6KmotLIkCj28or3aUZiqq
         jksg==
X-Gm-Message-State: AOAM5300+IDMS25HKRRpZ4KxnfXMKPyXd10WIbzBcXWBqxLKeb75zd3A
        zFaiu4L8fmxk1iVCj7vHEQ/rCNyLPQzGK/8NaSg=
X-Google-Smtp-Source: ABdhPJz8Bnz3N7vJ3BCNH4L2dNjA5ebD4y5+mbWIZJ04x6ANdJyIesUHyouSxmjOWo9H7LFKWPhHZh4uQzF8O9xzK2E=
X-Received: by 2002:a05:6402:1cc1:b0:413:2cfb:b6ca with SMTP id
 ds1-20020a0564021cc100b004132cfbb6camr2546390edb.265.1650596189459; Thu, 21
 Apr 2022 19:56:29 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 22 Apr 2022 12:56:18 +1000
Message-ID: <CAPM=9tzQpOnBBNNYWDaJRBztOCVM-PmprHHWZnr2yLh2rb2Y8g@mail.gmail.com>
Subject: [git pull] drm fixes for 5.18-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
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

Extra quiet after Easter, only have minor i915 and msm pulls. However
I haven't seen a PR from our misc tree in a little while, I've cc'ed
all the suspects. Once that unblocks I expect a bit larger bunch of
patches to arrive.

Otherwise as I said, one msm revert and two i915 fixes.

Regards,
Dave.

drm-fixes-2022-04-22:
drm-fixes for 5.18-rc4

msm:
- revert iommu change that broke some platforms.

i915:
- Unset enable_psr2_sel_fetch if PSR2 detection fails
- Fix to detect when VRR is turned off from panel settings
The following changes since commit b2d229d4ddb17db541098b83524d901257e93845=
:

  Linux 5.18-rc3 (2022-04-17 13:57:31 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-04-22

for you to fetch changes up to 70da382e1c5b9b2049c10abfd4489a40c1b60df0:

  Merge tag 'drm-msm-fixes-2022-04-20' of
https://gitlab.freedesktop.org/drm/msm into drm-fixes (2022-04-22
09:25:47 +1000)

----------------------------------------------------------------
drm-fixes for 5.18-rc4

msm:
- revert iommu change that broke some platforms.

i915:
- Unset enable_psr2_sel_fetch if PSR2 detection fails
- Fix to detect when VRR is turned off from panel settings

----------------------------------------------------------------
Dave Airlie (2):
      Merge tag 'drm-intel-fixes-2022-04-20' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'drm-msm-fixes-2022-04-20' of
https://gitlab.freedesktop.org/drm/msm into drm-fixes

Dmitry Baryshkov (1):
      drm/msm: Revert "drm/msm: Stop using iommu_present()"

Jos=C3=A9 Roberto de Souza (1):
      drm/i915/display/psr: Unset enable_psr2_sel_fetch if other
checks in intel_psr2_config_valid() fails

Manasi Navare (1):
      drm/i915/display/vrr: Reset VRR capable property on a long hpd

 drivers/gpu/drm/i915/display/intel_dp.c  | 17 +++++++++-----
 drivers/gpu/drm/i915/display/intel_psr.c | 38 ++++++++++++++++++----------=
----
 drivers/gpu/drm/msm/msm_drv.c            |  2 +-
 3 files changed, 33 insertions(+), 24 deletions(-)
