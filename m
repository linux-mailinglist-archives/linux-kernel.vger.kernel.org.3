Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A544157B4C3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 12:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238260AbiGTKug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 06:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234060AbiGTKud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 06:50:33 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2333D5BA
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 03:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658314232; x=1689850232;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Xm77q96bGoNzmNsm9j2oGlalxx2l2cUexc+fIevfeMI=;
  b=mNOvI4g1BIYGsj1wnnePetgvG7+m09FGSSUKNzqsV09ZJtq0WMyIv/+s
   /KqMb/ahLLgwgotptxMAU4+3Q1IXZCFxKvrj39S08BZ8NEhvCYycSVKI5
   YSUFoy+GImhU2pX16lubKe+BHzgzbIX/ik19v9w8RsXJ87Gbw0SiLgwqp
   PTMVM/UAzUFpNtUTZ+BLm8j6rjKS+ZNKX1/VGxztpsfR1pGRfGyD0BEbf
   KImwJPLWIg/akRbfX9lZQEmntMy0gAWgP9y6TA2IU2x80dbXiH8+vd8rf
   P9QxxrHqybnYLiPiE2vDD2BCkooPSDiFTbDGX1n006NHoEUjYy4BBxuF3
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="266520261"
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="266520261"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 03:50:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="665813866"
Received: from lkp-server01.sh.intel.com (HELO 7dfbdc7c7900) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 20 Jul 2022 03:50:30 -0700
Received: from kbuild by 7dfbdc7c7900 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oE7Hh-0000PR-MY;
        Wed, 20 Jul 2022 10:50:29 +0000
Date:   Wed, 20 Jul 2022 18:49:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michel Thierry <michel.thierry@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Nathan Ciobanu <nathan.d.ciobanu@intel.com>
Subject: [jsarha:topic/cros-sof-v4.14 1739/9354]
 include/asm-generic/bug.h:58:35: error: this statement may fall through
Message-ID: <202207201854.HVbv5g7g-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michel,

FYI, the error/warning still remains.

tree:   https://github.com/jsarha/linux topic/cros-sof-v4.14
head:   6f750b16c322c9191168a3a97c427c90581d9144
commit: a0825191170f9ec92c030c4682b1d5b6b0c99071 [1739/9354] UPSTREAM: drm/i915: Add a default case in gen7 hwsp switch-case
config: i386-randconfig-a002-20220718 (https://download.01.org/0day-ci/archive/20220720/202207201854.HVbv5g7g-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build):
        # https://github.com/jsarha/linux/commit/a0825191170f9ec92c030c4682b1d5b6b0c99071
        git remote add jsarha https://github.com/jsarha/linux
        git fetch --no-tags jsarha topic/cros-sof-v4.14
        git checkout a0825191170f9ec92c030c4682b1d5b6b0c99071
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/i915/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/x86/include/asm/bug.h:82:0,
                    from include/linux/bug.h:5,
                    from include/linux/debug_locks.h:7,
                    from include/linux/lockdep.h:28,
                    from include/linux/spinlock_types.h:18,
                    from include/linux/mutex.h:16,
                    from include/linux/kernfs.h:13,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:21,
                    from include/linux/cdev.h:5,
                    from include/drm/drmP.h:36,
                    from drivers/gpu/drm/i915/intel_ringbuffer.c:31:
   drivers/gpu/drm/i915/intel_ringbuffer.c: In function 'intel_ring_setup_status_page':
>> include/asm-generic/bug.h:58:35: error: this statement may fall through [-Werror=implicit-fallthrough=]
    #define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
                                      ^
   drivers/gpu/drm/i915/i915_gem.h:31:26: note: in expansion of macro 'BUG_ON'
    #define GEM_BUG_ON(expr) BUG_ON(expr)
                             ^~~~~~
   drivers/gpu/drm/i915/intel_ringbuffer.c:410:4: note: in expansion of macro 'GEM_BUG_ON'
       GEM_BUG_ON(engine->id);
       ^~~~~~~~~~
   drivers/gpu/drm/i915/intel_ringbuffer.c:411:3: note: here
      case RCS:
      ^~~~
   cc1: all warnings being treated as errors


vim +58 include/asm-generic/bug.h

^1da177e4c3f41 Linus Torvalds  2005-04-16  56  
^1da177e4c3f41 Linus Torvalds  2005-04-16  57  #ifndef HAVE_ARCH_BUG_ON
2a41de48b81e61 Alexey Dobriyan 2007-07-17 @58  #define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
^1da177e4c3f41 Linus Torvalds  2005-04-16  59  #endif
^1da177e4c3f41 Linus Torvalds  2005-04-16  60  

:::::: The code at line 58 was first introduced by commit
:::::: 2a41de48b81e61fbe260ae5031ebcb6f935f35fb Fix sparse false positives re BUG_ON(ptr)

:::::: TO: Alexey Dobriyan <adobriyan@sw.ru>
:::::: CC: Linus Torvalds <torvalds@woody.linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
