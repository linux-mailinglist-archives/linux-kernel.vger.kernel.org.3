Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58264CB436
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 02:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbiCCBQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 20:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbiCCBQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 20:16:55 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F97735DC7
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 17:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646270169; x=1677806169;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UeEsE5MXvt2a+QExWGeiCc4uZd8dlEmbNFn7PaKDjBk=;
  b=foVSbLrV7XeB6cMH88IroP38Uvzec6NCMLMmbmGE5k8mVRU+MY0k48D9
   KHG6cF4UbG6p5o5YhyyVRkbA4cvYMspFUqPfOTjxcsM/gF6IuSZX6fjiN
   9uNbQmMj5CS5IgN7LJXtttpM3zf7oP7D87M6bHF12IPY1e5RKqdl+5bCj
   wPzUCihJ6whPQ4BiXZ0fmLrj0VY1Vkxxe5KDet014KFpRRAJItRTr4duV
   zXBqhEHJE9EjDl7a40+q9r+PA5e00xDMEwV1JRxavF/7JG8JPWxsIqFua
   6lDpuOxYm0Gehs5l78TYVpsb7BwZmjEy78qnwKBNtj4tqyVcpt38XdILr
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="240962871"
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="240962871"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 17:16:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="535609231"
Received: from lkp-server02.sh.intel.com (HELO e9605edfa585) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 02 Mar 2022 17:16:06 -0800
Received: from kbuild by e9605edfa585 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPa4b-0002C2-LQ; Thu, 03 Mar 2022 01:16:05 +0000
Date:   Thu, 3 Mar 2022 09:15:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Hutchings <bwh@kernel.org>
Subject: [linux-stable-rc:queue/4.9 956/9999] include/linux/bits.h:6:19:
 error: initialized field overwritten
Message-ID: <202203030955.LTwFROCM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git queue/4.9
head:   443d6630b05c3eaff71448a86e4b776194f317ef
commit: b995196b9da4e2486d50e132539c848a60ea88da [956/9999] locking/atomics, asm-generic: Move some macros from <linux/bitops.h> to a new <linux/bits.h> file
config: i386-randconfig-a016-20211101 (https://download.01.org/0day-ci/archive/20220303/202203030955.LTwFROCM-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=b995196b9da4e2486d50e132539c848a60ea88da
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc queue/4.9
        git checkout b995196b9da4e2486d50e132539c848a60ea88da
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/i915/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/gpu/drm/i915/i915_pci.c:69:15: error: initialized field overwritten [-Werror=override-init]
     .num_pipes = 2, /* legal, last one wins */
                  ^
   drivers/gpu/drm/i915/i915_pci.c:69:15: note: (near initialization for 'intel_i830_info.num_pipes')
   drivers/gpu/drm/i915/i915_pci.c:79:15: error: initialized field overwritten [-Werror=override-init]
     .num_pipes = 2, /* legal, last one wins */
                  ^
   drivers/gpu/drm/i915/i915_pci.c:79:15: note: (near initialization for 'intel_i85x_info.num_pipes')
   In file included from include/linux/bitops.h:4:0,
                    from include/linux/kernel.h:10,
                    from include/asm-generic/bug.h:13,
                    from arch/x86/include/asm/bug.h:35,
                    from include/linux/bug.h:4,
                    from include/linux/io.h:23,
                    from include/video/vga.h:21,
                    from include/linux/vgaarb.h:34,
                    from drivers/gpu/drm/i915/i915_pci.c:26:
>> include/linux/bits.h:6:19: error: initialized field overwritten [-Werror=override-init]
    #define BIT(nr)   (1UL << (nr))
                      ^
   drivers/gpu/drm/i915/i915_drv.h:2732:25: note: in expansion of macro 'BIT'
    #define ENGINE_MASK(id) BIT(id)
                            ^~~
   drivers/gpu/drm/i915/i915_drv.h:2733:21: note: in expansion of macro 'ENGINE_MASK'
    #define RENDER_RING ENGINE_MASK(RCS)
                        ^~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:161:15: note: in expansion of macro 'RENDER_RING'
     .ring_mask = RENDER_RING | BSD_RING,
                  ^~~~~~~~~~~
   include/linux/bits.h:6:19: note: (near initialization for 'intel_g45_info.ring_mask')
    #define BIT(nr)   (1UL << (nr))
                      ^
   drivers/gpu/drm/i915/i915_drv.h:2732:25: note: in expansion of macro 'BIT'
    #define ENGINE_MASK(id) BIT(id)
                            ^~~
   drivers/gpu/drm/i915/i915_drv.h:2733:21: note: in expansion of macro 'ENGINE_MASK'
    #define RENDER_RING ENGINE_MASK(RCS)
                        ^~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:161:15: note: in expansion of macro 'RENDER_RING'
     .ring_mask = RENDER_RING | BSD_RING,
                  ^~~~~~~~~~~
>> include/linux/bits.h:6:19: error: initialized field overwritten [-Werror=override-init]
    #define BIT(nr)   (1UL << (nr))
                      ^
   drivers/gpu/drm/i915/i915_drv.h:2732:25: note: in expansion of macro 'BIT'
    #define ENGINE_MASK(id) BIT(id)
                            ^~~
   drivers/gpu/drm/i915/i915_drv.h:2733:21: note: in expansion of macro 'ENGINE_MASK'
    #define RENDER_RING ENGINE_MASK(RCS)
                        ^~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:170:15: note: in expansion of macro 'RENDER_RING'
     .ring_mask = RENDER_RING | BSD_RING,
                  ^~~~~~~~~~~
   include/linux/bits.h:6:19: note: (near initialization for 'intel_gm45_info.ring_mask')
    #define BIT(nr)   (1UL << (nr))
                      ^
   drivers/gpu/drm/i915/i915_drv.h:2732:25: note: in expansion of macro 'BIT'
    #define ENGINE_MASK(id) BIT(id)
                            ^~~
   drivers/gpu/drm/i915/i915_drv.h:2733:21: note: in expansion of macro 'ENGINE_MASK'
    #define RENDER_RING ENGINE_MASK(RCS)
                        ^~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:170:15: note: in expansion of macro 'RENDER_RING'
     .ring_mask = RENDER_RING | BSD_RING,
                  ^~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:248:15: error: initialized field overwritten [-Werror=override-init]
     .num_pipes = 0, /* legal, last one wins */
                  ^
   drivers/gpu/drm/i915/i915_pci.c:248:15: note: (near initialization for 'intel_ivybridge_q_info.num_pipes')
   In file included from include/linux/bitops.h:4:0,
                    from include/linux/kernel.h:10,
                    from include/asm-generic/bug.h:13,
                    from arch/x86/include/asm/bug.h:35,
                    from include/linux/bug.h:4,
                    from include/linux/io.h:23,
                    from include/video/vga.h:21,
                    from include/linux/vgaarb.h:34,
                    from drivers/gpu/drm/i915/i915_pci.c:26:
>> include/linux/bits.h:6:19: error: initialized field overwritten [-Werror=override-init]
    #define BIT(nr)   (1UL << (nr))
                      ^
   drivers/gpu/drm/i915/i915_drv.h:2732:25: note: in expansion of macro 'BIT'
    #define ENGINE_MASK(id) BIT(id)
                            ^~~
   drivers/gpu/drm/i915/i915_drv.h:2733:21: note: in expansion of macro 'ENGINE_MASK'
    #define RENDER_RING ENGINE_MASK(RCS)
                        ^~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:273:15: note: in expansion of macro 'RENDER_RING'
     .ring_mask = RENDER_RING | BSD_RING | BLT_RING | VEBOX_RING, \
                  ^~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:283:2: note: in expansion of macro 'HSW_FEATURES'
     HSW_FEATURES,
     ^~~~~~~~~~~~
   include/linux/bits.h:6:19: note: (near initialization for 'intel_haswell_info.ring_mask')
    #define BIT(nr)   (1UL << (nr))
                      ^
   drivers/gpu/drm/i915/i915_drv.h:2732:25: note: in expansion of macro 'BIT'
    #define ENGINE_MASK(id) BIT(id)
                            ^~~
   drivers/gpu/drm/i915/i915_drv.h:2733:21: note: in expansion of macro 'ENGINE_MASK'
    #define RENDER_RING ENGINE_MASK(RCS)
                        ^~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:273:15: note: in expansion of macro 'RENDER_RING'
     .ring_mask = RENDER_RING | BSD_RING | BLT_RING | VEBOX_RING, \
                  ^~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:283:2: note: in expansion of macro 'HSW_FEATURES'
     HSW_FEATURES,
     ^~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:279:14: error: initialized field overwritten [-Werror=override-init]
     .has_rc6p = 0 /* RC6p removed-by HSW */, \
                 ^
   drivers/gpu/drm/i915/i915_pci.c:283:2: note: in expansion of macro 'HSW_FEATURES'
     HSW_FEATURES,
     ^~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:279:14: note: (near initialization for 'intel_haswell_info.has_rc6p')
     .has_rc6p = 0 /* RC6p removed-by HSW */, \
                 ^
   drivers/gpu/drm/i915/i915_pci.c:283:2: note: in expansion of macro 'HSW_FEATURES'
     HSW_FEATURES,
     ^~~~~~~~~~~~
   In file included from include/linux/bitops.h:4:0,
                    from include/linux/kernel.h:10,
                    from include/asm-generic/bug.h:13,
                    from arch/x86/include/asm/bug.h:35,
                    from include/linux/bug.h:4,
                    from include/linux/io.h:23,
                    from include/video/vga.h:21,
                    from include/linux/vgaarb.h:34,
                    from drivers/gpu/drm/i915/i915_pci.c:26:
>> include/linux/bits.h:6:19: error: initialized field overwritten [-Werror=override-init]
    #define BIT(nr)   (1UL << (nr))
                      ^
   drivers/gpu/drm/i915/i915_drv.h:2732:25: note: in expansion of macro 'BIT'
    #define ENGINE_MASK(id) BIT(id)
                            ^~~
   drivers/gpu/drm/i915/i915_drv.h:2733:21: note: in expansion of macro 'ENGINE_MASK'
    #define RENDER_RING ENGINE_MASK(RCS)
                        ^~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:273:15: note: in expansion of macro 'RENDER_RING'
     .ring_mask = RENDER_RING | BSD_RING | BLT_RING | VEBOX_RING, \
                  ^~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:289:2: note: in expansion of macro 'HSW_FEATURES'
     HSW_FEATURES, \
     ^~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:294:2: note: in expansion of macro 'BDW_FEATURES'
     BDW_FEATURES,
     ^~~~~~~~~~~~
   include/linux/bits.h:6:19: note: (near initialization for 'intel_broadwell_info.ring_mask')
    #define BIT(nr)   (1UL << (nr))
                      ^
   drivers/gpu/drm/i915/i915_drv.h:2732:25: note: in expansion of macro 'BIT'
    #define ENGINE_MASK(id) BIT(id)
                            ^~~
   drivers/gpu/drm/i915/i915_drv.h:2733:21: note: in expansion of macro 'ENGINE_MASK'
    #define RENDER_RING ENGINE_MASK(RCS)
                        ^~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:273:15: note: in expansion of macro 'RENDER_RING'
     .ring_mask = RENDER_RING | BSD_RING | BLT_RING | VEBOX_RING, \
                  ^~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:289:2: note: in expansion of macro 'HSW_FEATURES'
     HSW_FEATURES, \
     ^~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:294:2: note: in expansion of macro 'BDW_FEATURES'
     BDW_FEATURES,
     ^~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:279:14: error: initialized field overwritten [-Werror=override-init]
     .has_rc6p = 0 /* RC6p removed-by HSW */, \
                 ^
   drivers/gpu/drm/i915/i915_pci.c:289:2: note: in expansion of macro 'HSW_FEATURES'
     HSW_FEATURES, \
     ^~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:294:2: note: in expansion of macro 'BDW_FEATURES'
     BDW_FEATURES,
     ^~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:279:14: note: (near initialization for 'intel_broadwell_info.has_rc6p')
     .has_rc6p = 0 /* RC6p removed-by HSW */, \
                 ^
   drivers/gpu/drm/i915/i915_pci.c:289:2: note: in expansion of macro 'HSW_FEATURES'
     HSW_FEATURES, \
     ^~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:294:2: note: in expansion of macro 'BDW_FEATURES'
     BDW_FEATURES,
     ^~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:295:9: error: initialized field overwritten [-Werror=override-init]
     .gen = 8,
            ^
   drivers/gpu/drm/i915/i915_pci.c:295:9: note: (near initialization for 'intel_broadwell_info.gen')
   In file included from include/linux/bitops.h:4:0,
                    from include/linux/kernel.h:10,
                    from include/asm-generic/bug.h:13,
                    from arch/x86/include/asm/bug.h:35,
                    from include/linux/bug.h:4,
                    from include/linux/io.h:23,
                    from include/video/vga.h:21,
                    from include/linux/vgaarb.h:34,
                    from drivers/gpu/drm/i915/i915_pci.c:26:
>> include/linux/bits.h:6:19: error: initialized field overwritten [-Werror=override-init]
    #define BIT(nr)   (1UL << (nr))
                      ^
   drivers/gpu/drm/i915/i915_drv.h:2732:25: note: in expansion of macro 'BIT'
    #define ENGINE_MASK(id) BIT(id)
                            ^~~
   drivers/gpu/drm/i915/i915_drv.h:2733:21: note: in expansion of macro 'ENGINE_MASK'
    #define RENDER_RING ENGINE_MASK(RCS)
                        ^~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:273:15: note: in expansion of macro 'RENDER_RING'
     .ring_mask = RENDER_RING | BSD_RING | BLT_RING | VEBOX_RING, \
                  ^~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:289:2: note: in expansion of macro 'HSW_FEATURES'
     HSW_FEATURES, \
     ^~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:300:2: note: in expansion of macro 'BDW_FEATURES'
     BDW_FEATURES,
     ^~~~~~~~~~~~
   include/linux/bits.h:6:19: note: (near initialization for 'intel_broadwell_gt3_info.ring_mask')
    #define BIT(nr)   (1UL << (nr))
                      ^
   drivers/gpu/drm/i915/i915_drv.h:2732:25: note: in expansion of macro 'BIT'
    #define ENGINE_MASK(id) BIT(id)
                            ^~~
   drivers/gpu/drm/i915/i915_drv.h:2733:21: note: in expansion of macro 'ENGINE_MASK'
    #define RENDER_RING ENGINE_MASK(RCS)
                        ^~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:273:15: note: in expansion of macro 'RENDER_RING'
     .ring_mask = RENDER_RING | BSD_RING | BLT_RING | VEBOX_RING, \
                  ^~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:289:2: note: in expansion of macro 'HSW_FEATURES'
     HSW_FEATURES, \
     ^~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:300:2: note: in expansion of macro 'BDW_FEATURES'
     BDW_FEATURES,
     ^~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:279:14: error: initialized field overwritten [-Werror=override-init]
     .has_rc6p = 0 /* RC6p removed-by HSW */, \
                 ^
   drivers/gpu/drm/i915/i915_pci.c:289:2: note: in expansion of macro 'HSW_FEATURES'
     HSW_FEATURES, \
     ^~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:300:2: note: in expansion of macro 'BDW_FEATURES'
     BDW_FEATURES,
     ^~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:279:14: note: (near initialization for 'intel_broadwell_gt3_info.has_rc6p')
     .has_rc6p = 0 /* RC6p removed-by HSW */, \
                 ^
   drivers/gpu/drm/i915/i915_pci.c:289:2: note: in expansion of macro 'HSW_FEATURES'
     HSW_FEATURES, \
     ^~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:300:2: note: in expansion of macro 'BDW_FEATURES'
     BDW_FEATURES,
     ^~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:301:9: error: initialized field overwritten [-Werror=override-init]
     .gen = 8,
            ^
   drivers/gpu/drm/i915/i915_pci.c:301:9: note: (near initialization for 'intel_broadwell_gt3_info.gen')
   In file included from include/linux/bitops.h:4:0,
                    from include/linux/kernel.h:10,
                    from include/asm-generic/bug.h:13,
                    from arch/x86/include/asm/bug.h:35,
                    from include/linux/bug.h:4,
                    from include/linux/io.h:23,
                    from include/video/vga.h:21,
                    from include/linux/vgaarb.h:34,
                    from drivers/gpu/drm/i915/i915_pci.c:26:
>> include/linux/bits.h:6:19: error: initialized field overwritten [-Werror=override-init]
    #define BIT(nr)   (1UL << (nr))
                      ^
   drivers/gpu/drm/i915/i915_drv.h:2732:25: note: in expansion of macro 'BIT'
    #define ENGINE_MASK(id) BIT(id)
                            ^~~
   drivers/gpu/drm/i915/i915_drv.h:2733:21: note: in expansion of macro 'ENGINE_MASK'
    #define RENDER_RING ENGINE_MASK(RCS)
                        ^~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:303:15: note: in expansion of macro 'RENDER_RING'
     .ring_mask = RENDER_RING | BSD_RING | BLT_RING | VEBOX_RING | BSD2_RING,
                  ^~~~~~~~~~~
   include/linux/bits.h:6:19: note: (near initialization for 'intel_broadwell_gt3_info.ring_mask')
    #define BIT(nr)   (1UL << (nr))
                      ^
   drivers/gpu/drm/i915/i915_drv.h:2732:25: note: in expansion of macro 'BIT'
    #define ENGINE_MASK(id) BIT(id)
                            ^~~
   drivers/gpu/drm/i915/i915_drv.h:2733:21: note: in expansion of macro 'ENGINE_MASK'
    #define RENDER_RING ENGINE_MASK(RCS)
                        ^~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:303:15: note: in expansion of macro 'RENDER_RING'
     .ring_mask = RENDER_RING | BSD_RING | BLT_RING | VEBOX_RING | BSD2_RING,
                  ^~~~~~~~~~~
>> include/linux/bits.h:6:19: error: initialized field overwritten [-Werror=override-init]
    #define BIT(nr)   (1UL << (nr))
                      ^
   drivers/gpu/drm/i915/i915_drv.h:2732:25: note: in expansion of macro 'BIT'
    #define ENGINE_MASK(id) BIT(id)
                            ^~~
   drivers/gpu/drm/i915/i915_drv.h:2733:21: note: in expansion of macro 'ENGINE_MASK'
    #define RENDER_RING ENGINE_MASK(RCS)
                        ^~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:273:15: note: in expansion of macro 'RENDER_RING'
     .ring_mask = RENDER_RING | BSD_RING | BLT_RING | VEBOX_RING, \
                  ^~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:289:2: note: in expansion of macro 'HSW_FEATURES'
     HSW_FEATURES, \
     ^~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:326:2: note: in expansion of macro 'BDW_FEATURES'
     BDW_FEATURES,
     ^~~~~~~~~~~~
   include/linux/bits.h:6:19: note: (near initialization for 'intel_skylake_info.ring_mask')
    #define BIT(nr)   (1UL << (nr))
                      ^
   drivers/gpu/drm/i915/i915_drv.h:2732:25: note: in expansion of macro 'BIT'
    #define ENGINE_MASK(id) BIT(id)
                            ^~~
   drivers/gpu/drm/i915/i915_drv.h:2733:21: note: in expansion of macro 'ENGINE_MASK'
    #define RENDER_RING ENGINE_MASK(RCS)
                        ^~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:273:15: note: in expansion of macro 'RENDER_RING'
     .ring_mask = RENDER_RING | BSD_RING | BLT_RING | VEBOX_RING, \
                  ^~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:289:2: note: in expansion of macro 'HSW_FEATURES'
     HSW_FEATURES, \
     ^~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:326:2: note: in expansion of macro 'BDW_FEATURES'
     BDW_FEATURES,
     ^~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:279:14: error: initialized field overwritten [-Werror=override-init]
     .has_rc6p = 0 /* RC6p removed-by HSW */, \
                 ^
   drivers/gpu/drm/i915/i915_pci.c:289:2: note: in expansion of macro 'HSW_FEATURES'
     HSW_FEATURES, \
     ^~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:326:2: note: in expansion of macro 'BDW_FEATURES'
     BDW_FEATURES,
     ^~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:279:14: note: (near initialization for 'intel_skylake_info.has_rc6p')
     .has_rc6p = 0 /* RC6p removed-by HSW */, \
                 ^
   drivers/gpu/drm/i915/i915_pci.c:289:2: note: in expansion of macro 'HSW_FEATURES'
     HSW_FEATURES, \
     ^~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:326:2: note: in expansion of macro 'BDW_FEATURES'
     BDW_FEATURES,
     ^~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:328:9: error: initialized field overwritten [-Werror=override-init]
     .gen = 9,
            ^
   drivers/gpu/drm/i915/i915_pci.c:328:9: note: (near initialization for 'intel_skylake_info.gen')
   In file included from include/linux/bitops.h:4:0,
                    from include/linux/kernel.h:10,
                    from include/asm-generic/bug.h:13,
                    from arch/x86/include/asm/bug.h:35,
                    from include/linux/bug.h:4,
                    from include/linux/io.h:23,
                    from include/video/vga.h:21,
                    from include/linux/vgaarb.h:34,
                    from drivers/gpu/drm/i915/i915_pci.c:26:
>> include/linux/bits.h:6:19: error: initialized field overwritten [-Werror=override-init]
    #define BIT(nr)   (1UL << (nr))
                      ^
   drivers/gpu/drm/i915/i915_drv.h:2732:25: note: in expansion of macro 'BIT'
    #define ENGINE_MASK(id) BIT(id)
                            ^~~
   drivers/gpu/drm/i915/i915_drv.h:2733:21: note: in expansion of macro 'ENGINE_MASK'
    #define RENDER_RING ENGINE_MASK(RCS)
                        ^~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:273:15: note: in expansion of macro 'RENDER_RING'
     .ring_mask = RENDER_RING | BSD_RING | BLT_RING | VEBOX_RING, \
                  ^~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:289:2: note: in expansion of macro 'HSW_FEATURES'
     HSW_FEATURES, \
     ^~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:335:2: note: in expansion of macro 'BDW_FEATURES'
     BDW_FEATURES,
     ^~~~~~~~~~~~
   include/linux/bits.h:6:19: note: (near initialization for 'intel_skylake_gt3_info.ring_mask')
    #define BIT(nr)   (1UL << (nr))
                      ^
   drivers/gpu/drm/i915/i915_drv.h:2732:25: note: in expansion of macro 'BIT'
    #define ENGINE_MASK(id) BIT(id)
                            ^~~
   drivers/gpu/drm/i915/i915_drv.h:2733:21: note: in expansion of macro 'ENGINE_MASK'
    #define RENDER_RING ENGINE_MASK(RCS)
                        ^~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:273:15: note: in expansion of macro 'RENDER_RING'
     .ring_mask = RENDER_RING | BSD_RING | BLT_RING | VEBOX_RING, \
                  ^~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:289:2: note: in expansion of macro 'HSW_FEATURES'
     HSW_FEATURES, \
     ^~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:335:2: note: in expansion of macro 'BDW_FEATURES'
     BDW_FEATURES,
     ^~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:279:14: error: initialized field overwritten [-Werror=override-init]
     .has_rc6p = 0 /* RC6p removed-by HSW */, \
                 ^
   drivers/gpu/drm/i915/i915_pci.c:289:2: note: in expansion of macro 'HSW_FEATURES'
     HSW_FEATURES, \
     ^~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:335:2: note: in expansion of macro 'BDW_FEATURES'
     BDW_FEATURES,
     ^~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:279:14: note: (near initialization for 'intel_skylake_gt3_info.has_rc6p')
     .has_rc6p = 0 /* RC6p removed-by HSW */, \
                 ^
   drivers/gpu/drm/i915/i915_pci.c:289:2: note: in expansion of macro 'HSW_FEATURES'
     HSW_FEATURES, \
     ^~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:335:2: note: in expansion of macro 'BDW_FEATURES'
     BDW_FEATURES,
     ^~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:337:9: error: initialized field overwritten [-Werror=override-init]
     .gen = 9,
            ^
   drivers/gpu/drm/i915/i915_pci.c:337:9: note: (near initialization for 'intel_skylake_gt3_info.gen')
   In file included from include/linux/bitops.h:4:0,
                    from include/linux/kernel.h:10,
                    from include/asm-generic/bug.h:13,
                    from arch/x86/include/asm/bug.h:35,
                    from include/linux/bug.h:4,
                    from include/linux/io.h:23,
                    from include/video/vga.h:21,
                    from include/linux/vgaarb.h:34,
                    from drivers/gpu/drm/i915/i915_pci.c:26:
>> include/linux/bits.h:6:19: error: initialized field overwritten [-Werror=override-init]
    #define BIT(nr)   (1UL << (nr))
                      ^
   drivers/gpu/drm/i915/i915_drv.h:2732:25: note: in expansion of macro 'BIT'
    #define ENGINE_MASK(id) BIT(id)
                            ^~~
   drivers/gpu/drm/i915/i915_drv.h:2733:21: note: in expansion of macro 'ENGINE_MASK'
    #define RENDER_RING ENGINE_MASK(RCS)
                        ^~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:341:15: note: in expansion of macro 'RENDER_RING'
     .ring_mask = RENDER_RING | BSD_RING | BLT_RING | VEBOX_RING | BSD2_RING,
                  ^~~~~~~~~~~
   include/linux/bits.h:6:19: note: (near initialization for 'intel_skylake_gt3_info.ring_mask')
    #define BIT(nr)   (1UL << (nr))
                      ^
   drivers/gpu/drm/i915/i915_drv.h:2732:25: note: in expansion of macro 'BIT'
    #define ENGINE_MASK(id) BIT(id)
                            ^~~
   drivers/gpu/drm/i915/i915_drv.h:2733:21: note: in expansion of macro 'ENGINE_MASK'
    #define RENDER_RING ENGINE_MASK(RCS)
                        ^~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:341:15: note: in expansion of macro 'RENDER_RING'
     .ring_mask = RENDER_RING | BSD_RING | BLT_RING | VEBOX_RING | BSD2_RING,
                  ^~~~~~~~~~~
>> include/linux/bits.h:6:19: error: initialized field overwritten [-Werror=override-init]
    #define BIT(nr)   (1UL << (nr))
                      ^
   drivers/gpu/drm/i915/i915_drv.h:2732:25: note: in expansion of macro 'BIT'
    #define ENGINE_MASK(id) BIT(id)
                            ^~~
   drivers/gpu/drm/i915/i915_drv.h:2733:21: note: in expansion of macro 'ENGINE_MASK'
    #define RENDER_RING ENGINE_MASK(RCS)
                        ^~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:273:15: note: in expansion of macro 'RENDER_RING'
     .ring_mask = RENDER_RING | BSD_RING | BLT_RING | VEBOX_RING, \
                  ^~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:289:2: note: in expansion of macro 'HSW_FEATURES'
     HSW_FEATURES, \
     ^~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:370:2: note: in expansion of macro 'BDW_FEATURES'
     BDW_FEATURES,
     ^~~~~~~~~~~~
   include/linux/bits.h:6:19: note: (near initialization for 'intel_kabylake_info.ring_mask')
    #define BIT(nr)   (1UL << (nr))
                      ^
   drivers/gpu/drm/i915/i915_drv.h:2732:25: note: in expansion of macro 'BIT'
    #define ENGINE_MASK(id) BIT(id)
                            ^~~
   drivers/gpu/drm/i915/i915_drv.h:2733:21: note: in expansion of macro 'ENGINE_MASK'
    #define RENDER_RING ENGINE_MASK(RCS)
                        ^~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:273:15: note: in expansion of macro 'RENDER_RING'
     .ring_mask = RENDER_RING | BSD_RING | BLT_RING | VEBOX_RING, \
                  ^~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:289:2: note: in expansion of macro 'HSW_FEATURES'
     HSW_FEATURES, \
     ^~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:370:2: note: in expansion of macro 'BDW_FEATURES'
     BDW_FEATURES,
     ^~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:279:14: error: initialized field overwritten [-Werror=override-init]
     .has_rc6p = 0 /* RC6p removed-by HSW */, \
                 ^
   drivers/gpu/drm/i915/i915_pci.c:289:2: note: in expansion of macro 'HSW_FEATURES'
     HSW_FEATURES, \
     ^~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:370:2: note: in expansion of macro 'BDW_FEATURES'
     BDW_FEATURES,
     ^~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:279:14: note: (near initialization for 'intel_kabylake_info.has_rc6p')
     .has_rc6p = 0 /* RC6p removed-by HSW */, \
                 ^
   drivers/gpu/drm/i915/i915_pci.c:289:2: note: in expansion of macro 'HSW_FEATURES'
     HSW_FEATURES, \
     ^~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:370:2: note: in expansion of macro 'BDW_FEATURES'
     BDW_FEATURES,
     ^~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:372:9: error: initialized field overwritten [-Werror=override-init]
     .gen = 9,
            ^
   drivers/gpu/drm/i915/i915_pci.c:372:9: note: (near initialization for 'intel_kabylake_info.gen')
   In file included from include/linux/bitops.h:4:0,
                    from include/linux/kernel.h:10,
                    from include/asm-generic/bug.h:13,
                    from arch/x86/include/asm/bug.h:35,
                    from include/linux/bug.h:4,
                    from include/linux/io.h:23,
                    from include/video/vga.h:21,
                    from include/linux/vgaarb.h:34,
                    from drivers/gpu/drm/i915/i915_pci.c:26:
>> include/linux/bits.h:6:19: error: initialized field overwritten [-Werror=override-init]
    #define BIT(nr)   (1UL << (nr))
                      ^
   drivers/gpu/drm/i915/i915_drv.h:2732:25: note: in expansion of macro 'BIT'
    #define ENGINE_MASK(id) BIT(id)
                            ^~~
   drivers/gpu/drm/i915/i915_drv.h:2733:21: note: in expansion of macro 'ENGINE_MASK'
    #define RENDER_RING ENGINE_MASK(RCS)
                        ^~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:273:15: note: in expansion of macro 'RENDER_RING'
     .ring_mask = RENDER_RING | BSD_RING | BLT_RING | VEBOX_RING, \
                  ^~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:289:2: note: in expansion of macro 'HSW_FEATURES'
     HSW_FEATURES, \
     ^~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:379:2: note: in expansion of macro 'BDW_FEATURES'
     BDW_FEATURES,
     ^~~~~~~~~~~~
   include/linux/bits.h:6:19: note: (near initialization for 'intel_kabylake_gt3_info.ring_mask')
    #define BIT(nr)   (1UL << (nr))
                      ^
   drivers/gpu/drm/i915/i915_drv.h:2732:25: note: in expansion of macro 'BIT'
    #define ENGINE_MASK(id) BIT(id)
                            ^~~
   drivers/gpu/drm/i915/i915_drv.h:2733:21: note: in expansion of macro 'ENGINE_MASK'
    #define RENDER_RING ENGINE_MASK(RCS)
                        ^~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:273:15: note: in expansion of macro 'RENDER_RING'
     .ring_mask = RENDER_RING | BSD_RING | BLT_RING | VEBOX_RING, \
                  ^~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:289:2: note: in expansion of macro 'HSW_FEATURES'
     HSW_FEATURES, \
     ^~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:379:2: note: in expansion of macro 'BDW_FEATURES'
     BDW_FEATURES,
     ^~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:279:14: error: initialized field overwritten [-Werror=override-init]
     .has_rc6p = 0 /* RC6p removed-by HSW */, \
                 ^
   drivers/gpu/drm/i915/i915_pci.c:289:2: note: in expansion of macro 'HSW_FEATURES'
     HSW_FEATURES, \
     ^~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:379:2: note: in expansion of macro 'BDW_FEATURES'
     BDW_FEATURES,
     ^~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:279:14: note: (near initialization for 'intel_kabylake_gt3_info.has_rc6p')
     .has_rc6p = 0 /* RC6p removed-by HSW */, \
                 ^
   drivers/gpu/drm/i915/i915_pci.c:289:2: note: in expansion of macro 'HSW_FEATURES'
     HSW_FEATURES, \
     ^~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:379:2: note: in expansion of macro 'BDW_FEATURES'
     BDW_FEATURES,
     ^~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:381:9: error: initialized field overwritten [-Werror=override-init]
     .gen = 9,
            ^
   drivers/gpu/drm/i915/i915_pci.c:381:9: note: (near initialization for 'intel_kabylake_gt3_info.gen')
   In file included from include/linux/bitops.h:4:0,
                    from include/linux/kernel.h:10,
                    from include/asm-generic/bug.h:13,
                    from arch/x86/include/asm/bug.h:35,
                    from include/linux/bug.h:4,
                    from include/linux/io.h:23,
                    from include/video/vga.h:21,
                    from include/linux/vgaarb.h:34,
                    from drivers/gpu/drm/i915/i915_pci.c:26:
>> include/linux/bits.h:6:19: error: initialized field overwritten [-Werror=override-init]
    #define BIT(nr)   (1UL << (nr))
                      ^
   drivers/gpu/drm/i915/i915_drv.h:2732:25: note: in expansion of macro 'BIT'
    #define ENGINE_MASK(id) BIT(id)
                            ^~~
   drivers/gpu/drm/i915/i915_drv.h:2733:21: note: in expansion of macro 'ENGINE_MASK'
    #define RENDER_RING ENGINE_MASK(RCS)
                        ^~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:385:15: note: in expansion of macro 'RENDER_RING'
     .ring_mask = RENDER_RING | BSD_RING | BLT_RING | VEBOX_RING | BSD2_RING,
                  ^~~~~~~~~~~
   include/linux/bits.h:6:19: note: (near initialization for 'intel_kabylake_gt3_info.ring_mask')
    #define BIT(nr)   (1UL << (nr))
                      ^
   drivers/gpu/drm/i915/i915_drv.h:2732:25: note: in expansion of macro 'BIT'
    #define ENGINE_MASK(id) BIT(id)
                            ^~~
   drivers/gpu/drm/i915/i915_drv.h:2733:21: note: in expansion of macro 'ENGINE_MASK'
    #define RENDER_RING ENGINE_MASK(RCS)
                        ^~~~~~~~~~~
   drivers/gpu/drm/i915/i915_pci.c:385:15: note: in expansion of macro 'RENDER_RING'
     .ring_mask = RENDER_RING | BSD_RING | BLT_RING | VEBOX_RING | BSD2_RING,
                  ^~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +6 include/linux/bits.h

     5	
   > 6	#define BIT(nr)			(1UL << (nr))
     7	#define BIT_ULL(nr)		(1ULL << (nr))
     8	#define BIT_MASK(nr)		(1UL << ((nr) % BITS_PER_LONG))
     9	#define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
    10	#define BIT_ULL_MASK(nr)	(1ULL << ((nr) % BITS_PER_LONG_LONG))
    11	#define BIT_ULL_WORD(nr)	((nr) / BITS_PER_LONG_LONG)
    12	#define BITS_PER_BYTE		8
    13	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
