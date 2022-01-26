Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE4849D621
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 00:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbiAZX22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 18:28:28 -0500
Received: from mga11.intel.com ([192.55.52.93]:21204 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229825AbiAZX21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 18:28:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643239707; x=1674775707;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wvS3o9vBC7NMaabk9opR9P9vuwG6Vn6iM1gKnaiUnCA=;
  b=DWp+L4PkMEZxjD1htoJwIYhjP3xwsdeBAF/chJB+7KKNGydMEdGDaOcA
   D6yrRoIV56Dn2aXlFjRh76byyWWJ/ZXeJnHEKGrbRd0GkLirs5OctNVWX
   iuUf1q3cDGnqg53utBrBYQgU2eg1IWgoak8LzvWIIkD27cgAxpNUMufXI
   twV1tWDLcXx5ALry7xwSZ3GSD8PhAmiwGC8JR8VaV/RzSOsd7A+gaAbUd
   GSWDXUr7st57RiP8lQJfd+FTOFTA48qOkKCJSs1caIm2KQ1tjYWzp5iDN
   n7d7RqV5qHse28DD2mzlhHg0g7YtfSNlZAXpAjfkemm5D62bqdFO41Xos
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="244284035"
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="244284035"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 15:28:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="480064951"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 26 Jan 2022 15:28:25 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCriC-000Lm1-C7; Wed, 26 Jan 2022 23:28:24 +0000
Date:   Thu, 27 Jan 2022 07:27:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Ekstrand <jason@jlekstrand.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [mlankhorst:xe 77/165] drivers/gpu/drm/xe/xe_lrc.c:13:10: error: no
 previous prototype for 'lrc_size'
Message-ID: <202201270706.80lF6UDa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://people.freedesktop.org/~mlankhorst/linux xe
head:   4bc3039b4403c76a13d58f7ac1f7c07dca6f88d8
commit: 9e4950525545d1028bf188a5d700b743ecbb9be6 [77/165] xe/hw_engine: Move context size function to lrc
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220127/202201270706.80lF6UDa-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        git remote add mlankhorst git://people.freedesktop.org/~mlankhorst/linux
        git fetch --no-tags mlankhorst xe
        git checkout 9e4950525545d1028bf188a5d700b743ecbb9be6
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/xe/xe_lrc.c:13:10: error: no previous prototype for 'lrc_size' [-Werror=missing-prototypes]
      13 | uint32_t lrc_size(struct xe_device *xe, enum xe_engine_class class)
         |          ^~~~~~~~
   In file included from drivers/gpu/drm/xe/xe_lrc.c:9:
   drivers/gpu/drm/xe/xe_lrc.c: In function 'set_context_control':
   drivers/gpu/drm/xe/xe_lrc.c:583:27: error: 'CTX_CTRL_INHIBIT_SYN_CTX_SWITCH' undeclared (first use in this function)
     583 |  ctl = _MASKED_BIT_ENABLE(CTX_CTRL_INHIBIT_SYN_CTX_SWITCH);
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/xe/../i915/i915_reg.h:189:41: note: in definition of macro '_MASKED_BIT_ENABLE'
     189 | #define _MASKED_BIT_ENABLE(a) ({ typeof(a) _a = (a); _MASKED_FIELD(_a, _a); })
         |                                         ^
   drivers/gpu/drm/xe/xe_lrc.c:583:27: note: each undeclared identifier is reported only once for each function it appears in
     583 |  ctl = _MASKED_BIT_ENABLE(CTX_CTRL_INHIBIT_SYN_CTX_SWITCH);
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/xe/../i915/i915_reg.h:189:41: note: in definition of macro '_MASKED_BIT_ENABLE'
     189 | #define _MASKED_BIT_ENABLE(a) ({ typeof(a) _a = (a); _MASKED_FIELD(_a, _a); })
         |                                         ^
   drivers/gpu/drm/xe/xe_lrc.c:584:29: error: 'CTX_CTRL_ENGINE_CTX_RESTORE_INHIBIT' undeclared (first use in this function)
     584 |  ctl |= _MASKED_BIT_DISABLE(CTX_CTRL_ENGINE_CTX_RESTORE_INHIBIT);
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/xe/../i915/i915_reg.h:181:27: note: in definition of macro '_MASKED_FIELD'
     181 |  if (__builtin_constant_p(mask))        \
         |                           ^~~~
   drivers/gpu/drm/xe/xe_lrc.c:584:9: note: in expansion of macro '_MASKED_BIT_DISABLE'
     584 |  ctl |= _MASKED_BIT_DISABLE(CTX_CTRL_ENGINE_CTX_RESTORE_INHIBIT);
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/xe/xe_lrc.c:588:30: error: 'CTX_CTRL_ENGINE_CTX_SAVE_INHIBIT' undeclared (first use in this function)
     588 |   ctl |= _MASKED_BIT_DISABLE(CTX_CTRL_ENGINE_CTX_SAVE_INHIBIT |
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/xe/../i915/i915_reg.h:181:27: note: in definition of macro '_MASKED_FIELD'
     181 |  if (__builtin_constant_p(mask))        \
         |                           ^~~~
   drivers/gpu/drm/xe/xe_lrc.c:588:10: note: in expansion of macro '_MASKED_BIT_DISABLE'
     588 |   ctl |= _MASKED_BIT_DISABLE(CTX_CTRL_ENGINE_CTX_SAVE_INHIBIT |
         |          ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/xe/xe_lrc.c:589:9: error: 'CTX_CTRL_RS_CTX_ENABLE' undeclared (first use in this function)
     589 |         CTX_CTRL_RS_CTX_ENABLE);
         |         ^~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/xe/../i915/i915_reg.h:181:27: note: in definition of macro '_MASKED_FIELD'
     181 |  if (__builtin_constant_p(mask))        \
         |                           ^~~~
   drivers/gpu/drm/xe/xe_lrc.c:588:10: note: in expansion of macro '_MASKED_BIT_DISABLE'
     588 |   ctl |= _MASKED_BIT_DISABLE(CTX_CTRL_ENGINE_CTX_SAVE_INHIBIT |
         |          ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/xe/xe_lrc.c: In function 'xe_lrc_init':
   drivers/gpu/drm/xe/xe_lrc.c:706:23: error: implicit declaration of function 'RING_CTL_SIZE' [-Werror=implicit-function-declaration]
     706 |  regs[CTX_RING_CTL] = RING_CTL_SIZE(lrc->ring_size) | RING_VALID;
         |                       ^~~~~~~~~~~~~
   drivers/gpu/drm/xe/xe_lrc.c:706:55: error: 'RING_VALID' undeclared (first use in this function)
     706 |  regs[CTX_RING_CTL] = RING_CTL_SIZE(lrc->ring_size) | RING_VALID;
         |                                                       ^~~~~~~~~~
   In file included from arch/x86/include/asm/bug.h:84,
                    from include/linux/bug.h:5,
                    from include/drm/drm_mm.h:40,
                    from drivers/gpu/drm/xe/xe_bo.h:10,
                    from drivers/gpu/drm/xe/xe_lrc.h:9,
                    from drivers/gpu/drm/xe/xe_lrc.c:7:
   drivers/gpu/drm/xe/xe_lrc.c: In function 'xe_lrc_assert_ring_space':
   drivers/gpu/drm/xe/xe_lrc.c:751:21: error: format '%lu' expects argument of type 'long unsigned int', but argument 2 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
     751 |  WARN(size > space, "Insufficient ring space: %lu > %u", size, space);
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  ~~~~
         |                                                          |
         |                                                          size_t {aka unsigned int}
   include/asm-generic/bug.h:99:17: note: in definition of macro '__WARN_printf'
      99 |   __warn_printk(arg);     \
         |                 ^~~
   drivers/gpu/drm/xe/xe_lrc.c:751:2: note: in expansion of macro 'WARN'
     751 |  WARN(size > space, "Insufficient ring space: %lu > %u", size, space);
         |  ^~~~
   drivers/gpu/drm/xe/xe_lrc.c:751:49: note: format string is defined here
     751 |  WARN(size > space, "Insufficient ring space: %lu > %u", size, space);
         |                                               ~~^
         |                                                 |
         |                                                 long unsigned int
         |                                               %u
   cc1: all warnings being treated as errors


vim +/lrc_size +13 drivers/gpu/drm/xe/xe_lrc.c

    12	
  > 13	uint32_t lrc_size(struct xe_device *xe, enum xe_engine_class class)
    14	{
    15		switch (class) {
    16		case XE_ENGINE_CLASS_RENDER:
    17			switch (GRAPHICS_VER(xe)) {
    18			case 12:
    19			case 11:
    20				return 14 * SZ_4K;
    21			case 9:
    22				return 22 * SZ_4K;
    23			case 8:
    24				return 20 * SZ_4K;
    25			default:
    26				WARN(1, "Unknown GFX version: %d", GRAPHICS_VER(xe));
    27				return 22 * SZ_4K;
    28			}
    29		default:
    30			WARN(1, "Unknown engine class: %d", class);
    31			fallthrough;
    32		case XE_ENGINE_CLASS_COPY:
    33		case XE_ENGINE_CLASS_VIDEO_DECODE:
    34		case XE_ENGINE_CLASS_VIDEO_ENHANCE:
    35			return 2 * SZ_4K;
    36		}
    37	}
    38	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
