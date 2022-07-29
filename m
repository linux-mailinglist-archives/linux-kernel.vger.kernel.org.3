Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0715584A33
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 05:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbiG2Db0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 23:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234046AbiG2DbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 23:31:22 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4F432EF7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 20:31:16 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id l23so6306596ejr.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 20:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=pJ4ZUNG6LxmawDqEhLdtSFr1ngQQv8SUwuZZJONKqlk=;
        b=a3RvweEzgjIpWRMXKG/5emZwl5y7xuQha54CpE3QKGBJjg9mdwZIwIIwRm+D+qdKxH
         5v5bU7EAiBeG8iRUUmi0qalXbma8j5z9AldHGGVrgcsa4vTWOcACG5fRUwUpy6Pc3FOS
         uGGyxEFovHOxzpBn2keHGzI7MbXGBD04e35e4O2QoMTCU//RIYihivc89s/05z6c7che
         38Gkol416Ub6BspeO4GOL4O8jlCuoeeXhq/ItQ79zAh4SBPRUhlHYjLXXa5xXLYps/Xa
         77lWkCp7dsOOFwfKYQhEmlm75qMGalH+Rqvf194+ltCrsBF0eQd9l6KQ0G4Ra+JBPtKq
         TDhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=pJ4ZUNG6LxmawDqEhLdtSFr1ngQQv8SUwuZZJONKqlk=;
        b=pbgJ877tzWAHmhgcTucDWVg1GF2Blcoi/zgW2/aKynS5AcdFbI2ynqdSz3siEizCgo
         j10lqLdGSv3agq6DyHOtzufbzkGVT6d116OtkQ9z0b+vOBbRiNeT8Xv2SbU7b5udqGUQ
         PlNh2zUF6FXUuMne0Tr0Z7XpexnsKUAoxoWnStnfSjlfktwDSbNS7cYj3g2wdNtPXk+a
         6Pv6Vk4ieV90THHOqmTZ2KEmCSy6a5rDvxm2nwea889qgmBF3Z+4N4pq8cOyie6T+bIg
         pedgTnDiDylmjwpL7obcXUd+GhH129bMuKIyTrl74na5HfBc9OBDJk0c/bFuuEa7+A1t
         PKuQ==
X-Gm-Message-State: AJIora+1K9R6eFZn/Q0uP/jbkbVfBjspSOewFZ0ZS+qk2RNTej0Q9sv0
        FWSJ+OZBl/QGCqOMJ6/nH1GcdAbIwTJd8Ejo/Wg=
X-Google-Smtp-Source: AGRyM1u1wBoESmd8bswYQncgE9pmBLhDJETi3dXUVLdy6xWjU+oeob04bHDcARbgnSkosnR8Ud/APH0SBGAfnk7xQ2Q=
X-Received: by 2002:a17:907:7f9f:b0:72f:11fc:86bc with SMTP id
 qk31-20020a1709077f9f00b0072f11fc86bcmr1312411ejc.770.1659065474730; Thu, 28
 Jul 2022 20:31:14 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 29 Jul 2022 13:31:03 +1000
Message-ID: <CAPM=9txsRyEJWjrTsha6wkqcdTM5MmTqRVns5b9eQCaQAwJpNg@mail.gmail.com>
Subject: [git pull] drm fixes for 5.19 final
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

Quiet extra week, just a single fix for i915 workaround with execlist backend.

Regards,
Dave.

drm-fixes-2022-07-29:
drm fixes for 5.19 final

i915:
- Further reset robustness improvements for execlists [Wa_22011802037]
The following changes since commit e0dccc3b76fb35bb257b4118367a883073d7390e:

  Linux 5.19-rc8 (2022-07-24 13:26:27 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-07-29

for you to fetch changes up to f16a2f593d0095e82e6b7f9d776f869c8ab45952:

  Merge tag 'drm-intel-fixes-2022-07-28-1' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2022-07-29
11:39:13 +1000)

----------------------------------------------------------------
drm fixes for 5.19 final

i915:
- Further reset robustness improvements for execlists [Wa_22011802037]

----------------------------------------------------------------
Dave Airlie (1):
      Merge tag 'drm-intel-fixes-2022-07-28-1' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

Umesh Nerlige Ramappa (1):
      drm/i915/reset: Add additional steps for Wa_22011802037 for
execlist backend

 drivers/gpu/drm/i915/gt/intel_engine.h             |  2 +
 drivers/gpu/drm/i915/gt/intel_engine_cs.c          | 88 +++++++++++++++++++++-
 .../gpu/drm/i915/gt/intel_execlists_submission.c   |  7 ++
 drivers/gpu/drm/i915/gt/uc/intel_guc.c             |  4 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c  | 81 ++------------------
 5 files changed, 103 insertions(+), 79 deletions(-)
