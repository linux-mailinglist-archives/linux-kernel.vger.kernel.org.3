Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AE158A4B7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 04:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235255AbiHEC3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 22:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiHEC3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 22:29:45 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC446D9C7
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 19:29:44 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d16so1184881qtw.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 19:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=bh1RttnD1I6sfF95mvQBjS34lsetRFZd3BR7/2DRDPE=;
        b=B+UW7/1+sPJTmUfaM7VH0UF+2rkSZOSrTYuoDQfW7ar7oh+XsI2bJWxP77j7kjEG1Z
         iBQXu3dV4/XPRMkcw5lly0vd6wvTrJvlaKqX+XeE9tVPU38/Baz2mmY8M5OlTzJIax+Y
         KypmhfNK+ILtmkiAG+HCGaB9m4zOctm0peJ6h2tleRI9G8QChbUzknsNzkl4TAmwC6C3
         FZ8GhU5C87u32RSiJstH2Mf5Sdh4cL6mjJUiSoD8BYKu0sbdy0Ut/I8deE/4YqICCjvG
         6sbbdqWa25MBSIFRsg4529ZmsVZRE7ty1VHruPtp3yHrfLuHOO6d+pVorYFcileks3WJ
         cZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=bh1RttnD1I6sfF95mvQBjS34lsetRFZd3BR7/2DRDPE=;
        b=4JeMYmhQTHx4E5C0aIu3PYttGKbkhcH/TP67ZQYabajHJphjtvM2Ofn2W0v/V4XbiD
         AST2V2mIuDYED7F8Gd4XPAj2VNiVfnbJ2e8j3mLWMdC3J2ZO1/OHtTa5PUsDXPaCYKfH
         bekdY1gKwQ0XN93ELVdHk6T4C2sy+dvq18SHiQUdV3dMdcP8zUfvK54oOZ0FSVkBM08g
         7nH2R6ZBA6lKDZ2xWk5r4nyIxVL8MSHyWcy+Ey56jEeZ0QauG91wWu7ATqP61RA0brAq
         24tteLJ55kh52RrTSbYXNYVrlyGUKAkaNl8lVKH6y95md0U/ij3Gmyf1ybX2RLUXc9Sb
         KcXg==
X-Gm-Message-State: ACgBeo2G16sWWqCpZwoOvfObQK8hVkFklKnrRwenF4K5Ra9MHc/k8OnV
        HjIMxygrIYW1pQZP0tpU2CXnspjQy8Q=
X-Google-Smtp-Source: AA6agR59BZ3Jru7bdfTGpFUWGlAHi6rKZwH0kwgJIO96jobtiNJHSgIwNS4syyGlr05MahCCg2l9cg==
X-Received: by 2002:ac8:5843:0:b0:31e:f855:5a7a with SMTP id h3-20020ac85843000000b0031ef8555a7amr4218577qth.307.1659666582944;
        Thu, 04 Aug 2022 19:29:42 -0700 (PDT)
Received: from localhost ([2601:c4:c432:612:7698:fa8f:b615:9fbc])
        by smtp.gmail.com with ESMTPSA id r7-20020ae9d607000000b006b89b9024ddsm1964763qkk.24.2022.08.04.19.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 19:29:42 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [GIT PULL] Bitmap patches for v6.0-rc1
Date:   Thu,  4 Aug 2022 19:29:40 -0700
Message-Id: <20220805022940.1637978-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a111daf0c53ae91e71fd2bfe7497862d14132e3e:

  Linux 5.19-rc3 (2022-06-19 15:06:47 -0500)

are available in the Git repository at:

  https://github.com/norov/linux.git/ tags/bitmap-6.0-rc1

for you to fetch changes up to 36d4b36b69590fed99356a4426c940a253a93800:

  lib/nodemask: inline next_node_in() and node_random() (2022-08-01 08:13:21 -0700)

----------------------------------------------------------------
Bitmap patches for v6.0-rc1

This branch includes:

Qu Wenruo:
lib: bitmap: fix the duplicated comments on bitmap_to_arr64()
https://lore.kernel.org/lkml/0d85e1dbad52ad7fb5787c4432bdb36cbd24f632.1656063005.git.wqu@suse.com/

Alexander Lobakin:
bitops: let optimize out non-atomic bitops on compile-time constants
https://lore.kernel.org/lkml/20220624121313.2382500-1-alexandr.lobakin@intel.com/T/

Yury Norov:
lib: cleanup bitmap-related headers
https://lore.kernel.org/linux-arm-kernel/YtCVeOGLiQ4gNPSf@yury-laptop/T/#m305522194c4d38edfdaffa71fcaaf2e2ca00a961

Alexander Lobakin:
x86/olpc: fix 'logical not is only applied to the left hand side'
https://www.spinics.net/lists/kernel/msg4440064.html

Yury Norov:
lib/nodemask: inline wrappers around bitmap
https://lore.kernel.org/all/20220723214537.2054208-1-yury.norov@gmail.com/

----------------------------------------------------------------
Hi Linus,

Resending the pull request from Aug 02. I forgot to add GIT PULL tag, and
that's why it may not pass your filters.

The patch "headers/deps: mm: Split <linux/gfp_types.h> out of <linux/gfp.h>"
conflicts with 70c248aca9e7e ("mm: kasan: Skip unpoisoning of user pages").

The gfp_types patch moves macros from gfp.h to gfp_types.h, but the
70c248aca9e7e modifies original gfp.h, and therefore git can't apply
gfp_types patch cleanly. The solution is to propagate the following 
change from gfp.h to new gfp_types.h:

 #define GFP_DMA32      __GFP_DMA32
 #define GFP_HIGHUSER   (GFP_USER | __GFP_HIGHMEM)
 #define GFP_HIGHUSER_MOVABLE   (GFP_HIGHUSER | __GFP_MOVABLE | \
-                        __GFP_SKIP_KASAN_POISON)
+                        __GFP_SKIP_KASAN_POISON | __GFP_SKIP_KASAN_UNPOISON)
 #define GFP_TRANSHUGE_LIGHT    ((GFP_HIGHUSER_MOVABLE | __GFP_COMP | \
                         __GFP_NOMEMALLOC | __GFP_NOWARN) & ~__GFP_RECLAIM)
 #define GFP_TRANSHUGE  (GFP_TRANSHUGE_LIGHT | __GFP_DIRECT_RECLAIM)

Thanks,
Yury
---

Alexander Lobakin (13):
      ia64, processor: fix -Wincompatible-pointer-types in ia64_get_irr()
      bitops: always define asm-generic non-atomic bitops
      bitops: unify non-atomic bitops prototypes across architectures
      bitops: define const_*() versions of the non-atomics
      bitops: wrap non-atomic bitops with a transparent macro
      bitops: let optimize out non-atomic bitops on compile-time constants
      net/ice: fix initializing the bitmap in the switch code
      bitmap: don't assume compiler evaluates small mem*() builtins calls
      lib: test_bitmap: add compile-time optimization/evaluations assertions
      lib/bitmap: fix off-by-one in bitmap_to_arr64()
      lib/test_bitmap: test the tail after bitmap_to_arr64()
      iommu/vt-d: avoid invalid memory access via node_online(NUMA_NO_NODE)
      x86/olpc: fix 'logical not is only applied to the left hand side'

Ingo Molnar (2):
      headers/deps: mm: Optimize <linux/gfp.h> header dependencies
      headers/deps: mm: Split <linux/gfp_types.h> out of <linux/gfp.h>

Qu Wenruo (1):
      lib: bitmap: fix the duplicated comments on bitmap_to_arr64()

Yury Norov (10):
      arm: align find_bit declarations with generic kernel
      lib/bitmap: change return types to bool where appropriate
      lib/bitmap: change type of bitmap_weight to unsigned long
      cpumask: change return types to bool where appropriate
      lib/cpumask: change return types to unsigned where appropriate
      lib/cpumask: move trivial wrappers around find_bit to the header
      headers/deps: mm: align MANITAINERS and Docs with new gfp.h structure
      lib/cpumask: move some one-line wrappers to header file
      powerpc: drop dependency on <asm/machdep.h> in archrandom.h
      lib/nodemask: inline next_node_in() and node_random()

 Documentation/core-api/mm-api.rst                  |   8 +-
 MAINTAINERS                                        |   2 +-
 arch/alpha/include/asm/bitops.h                    |  32 +-
 arch/arm/include/asm/bitops.h                      |  18 +-
 arch/hexagon/include/asm/bitops.h                  |  24 +-
 arch/ia64/include/asm/bitops.h                     |  42 +--
 arch/ia64/include/asm/processor.h                  |   2 +-
 arch/m68k/include/asm/bitops.h                     |  49 ++-
 arch/powerpc/include/asm/archrandom.h              |   9 +-
 arch/powerpc/kernel/setup-common.c                 |  12 +
 arch/s390/include/asm/bitops.h                     |  61 ++--
 arch/sh/include/asm/bitops-op32.h                  |  34 +-
 arch/sparc/include/asm/bitops_32.h                 |  18 +-
 arch/sparc/lib/atomic32.c                          |  12 +-
 arch/x86/include/asm/bitops.h                      |  22 +-
 arch/x86/platform/olpc/olpc-xo1-sci.c              |   2 +-
 drivers/dma/ti/k3-udma.c                           |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |   2 +-
 drivers/gpu/drm/i915/display/intel_display_power.c |   2 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c           |   2 +-
 drivers/iommu/intel/dmar.c                         |   2 +-
 drivers/iommu/intel/iommu.c                        |   2 +-
 drivers/net/ethernet/intel/ice/ice_switch.c        |   2 +-
 drivers/net/ethernet/mellanox/mlx4/fw.c            |   2 +-
 drivers/net/wireless/ath/ath9k/htc_drv_debug.c     |   2 +-
 drivers/net/wireless/ath/carl9170/debug.c          |   2 +-
 include/asm-generic/bitops/generic-non-atomic.h    | 161 ++++++++++
 .../asm-generic/bitops/instrumented-non-atomic.h   |  35 ++-
 include/asm-generic/bitops/non-atomic.h            | 121 +------
 .../bitops/non-instrumented-non-atomic.h           |  16 +
 include/linux/bitmap.h                             |  37 ++-
 include/linux/bitops.h                             |  50 +++
 include/linux/cpumask.h                            | 125 ++++++--
 include/linux/gfp.h                                | 348 +--------------------
 include/linux/gfp_types.h                          | 348 +++++++++++++++++++++
 include/linux/nodemask.h                           |  24 +-
 lib/Makefile                                       |   2 +-
 lib/bitmap.c                                       |  11 +-
 lib/cpumask.c                                      |  97 +-----
 lib/nodemask.c                                     |   8 -
 lib/test_bitmap.c                                  |  68 ++++
 tools/include/asm-generic/bitops/non-atomic.h      |  34 +-
 tools/include/linux/bitmap.h                       |  12 +-
 tools/include/linux/bitops.h                       |  16 +
 tools/lib/bitmap.c                                 |   6 +-
 45 files changed, 1091 insertions(+), 799 deletions(-)
 create mode 100644 include/asm-generic/bitops/generic-non-atomic.h
 create mode 100644 include/asm-generic/bitops/non-instrumented-non-atomic.h
 create mode 100644 include/linux/gfp_types.h
