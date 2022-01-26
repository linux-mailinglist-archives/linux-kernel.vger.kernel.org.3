Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD0049D17A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 19:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244138AbiAZSMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 13:12:13 -0500
Received: from mga02.intel.com ([134.134.136.20]:21554 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242522AbiAZSML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 13:12:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643220731; x=1674756731;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=az5Wt9xCsorUJWjt8307al+UFuZjWk8jDEINqzSSdKo=;
  b=Hzh/C7q0DJC//H0cozNhIrru6tnShP4Pm7TJXxO85lADGfPPuw/xLMlV
   ZeWxFw70l5c1q/29uKaYQQvC7W2HKSU0lcDtWorBEaL2Pjf2gqXWzJ97g
   O0zkO8DzuRSCwSrKQL+/BgeYak1c/cslgENVVUAPDCUli1IqevSl10y45
   yXsxzLjay4ntk1EHEH7dlPYFPzlbfi10JFwxL6AfE0D2PMvdP05remjhs
   Ls7+VpKLwclBXEVDFfw9+AuDyVkQllVEKr792YWUElBOG1bJj63QL7XXv
   uc2IwU6PeA6wVGGtfvudB/885UuhU0aegTSG7Jbf5Rwqb3TkRR9dyiwxY
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="233989449"
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="233989449"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 10:12:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="479968611"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 26 Jan 2022 10:12:09 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCmm8-000LUW-Qb; Wed, 26 Jan 2022 18:12:08 +0000
Date:   Thu, 27 Jan 2022 02:11:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Ekstrand <jason@jlekstrand.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [mlankhorst:xe 73/165] drivers/gpu/drm/xe/xe_lrc.c:699:21: error:
 format '%lu' expects argument of type 'long unsigned int', but argument 2
 has type 'size_t' {aka 'unsigned int'}
Message-ID: <202201270258.G5cjI9fM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://people.freedesktop.org/~mlankhorst/linux xe
head:   4bc3039b4403c76a13d58f7ac1f7c07dca6f88d8
commit: 042df60b091fb02d7761297f9db6cfdaf1be7be1 [73/165] xe/lrc: Improve the ring space check
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220127/202201270258.G5cjI9fM-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        git remote add mlankhorst git://people.freedesktop.org/~mlankhorst/linux
        git fetch --no-tags mlankhorst xe
        git checkout 042df60b091fb02d7761297f9db6cfdaf1be7be1
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/xe/xe_lrc.c:9:
   drivers/gpu/drm/xe/xe_lrc.c: In function 'set_context_control':
   drivers/gpu/drm/xe/xe_lrc.c:557:27: error: 'CTX_CTRL_INHIBIT_SYN_CTX_SWITCH' undeclared (first use in this function)
     557 |  ctl = _MASKED_BIT_ENABLE(CTX_CTRL_INHIBIT_SYN_CTX_SWITCH);
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/xe/../i915/i915_reg.h:189:41: note: in definition of macro '_MASKED_BIT_ENABLE'
     189 | #define _MASKED_BIT_ENABLE(a) ({ typeof(a) _a = (a); _MASKED_FIELD(_a, _a); })
         |                                         ^
   drivers/gpu/drm/xe/xe_lrc.c:557:27: note: each undeclared identifier is reported only once for each function it appears in
     557 |  ctl = _MASKED_BIT_ENABLE(CTX_CTRL_INHIBIT_SYN_CTX_SWITCH);
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/xe/../i915/i915_reg.h:189:41: note: in definition of macro '_MASKED_BIT_ENABLE'
     189 | #define _MASKED_BIT_ENABLE(a) ({ typeof(a) _a = (a); _MASKED_FIELD(_a, _a); })
         |                                         ^
   drivers/gpu/drm/xe/xe_lrc.c:558:29: error: 'CTX_CTRL_ENGINE_CTX_RESTORE_INHIBIT' undeclared (first use in this function)
     558 |  ctl |= _MASKED_BIT_DISABLE(CTX_CTRL_ENGINE_CTX_RESTORE_INHIBIT);
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/xe/../i915/i915_reg.h:181:27: note: in definition of macro '_MASKED_FIELD'
     181 |  if (__builtin_constant_p(mask))        \
         |                           ^~~~
   drivers/gpu/drm/xe/xe_lrc.c:558:9: note: in expansion of macro '_MASKED_BIT_DISABLE'
     558 |  ctl |= _MASKED_BIT_DISABLE(CTX_CTRL_ENGINE_CTX_RESTORE_INHIBIT);
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/xe/xe_lrc.c:562:30: error: 'CTX_CTRL_ENGINE_CTX_SAVE_INHIBIT' undeclared (first use in this function)
     562 |   ctl |= _MASKED_BIT_DISABLE(CTX_CTRL_ENGINE_CTX_SAVE_INHIBIT |
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/xe/../i915/i915_reg.h:181:27: note: in definition of macro '_MASKED_FIELD'
     181 |  if (__builtin_constant_p(mask))        \
         |                           ^~~~
   drivers/gpu/drm/xe/xe_lrc.c:562:10: note: in expansion of macro '_MASKED_BIT_DISABLE'
     562 |   ctl |= _MASKED_BIT_DISABLE(CTX_CTRL_ENGINE_CTX_SAVE_INHIBIT |
         |          ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/xe/xe_lrc.c:563:9: error: 'CTX_CTRL_RS_CTX_ENABLE' undeclared (first use in this function)
     563 |         CTX_CTRL_RS_CTX_ENABLE);
         |         ^~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/xe/../i915/i915_reg.h:181:27: note: in definition of macro '_MASKED_FIELD'
     181 |  if (__builtin_constant_p(mask))        \
         |                           ^~~~
   drivers/gpu/drm/xe/xe_lrc.c:562:10: note: in expansion of macro '_MASKED_BIT_DISABLE'
     562 |   ctl |= _MASKED_BIT_DISABLE(CTX_CTRL_ENGINE_CTX_SAVE_INHIBIT |
         |          ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/xe/xe_lrc.c: In function 'xe_lrc_init':
   drivers/gpu/drm/xe/xe_lrc.c:654:23: error: implicit declaration of function 'RING_CTL_SIZE' [-Werror=implicit-function-declaration]
     654 |  regs[CTX_RING_CTL] = RING_CTL_SIZE(lrc->ring_size) | RING_VALID;
         |                       ^~~~~~~~~~~~~
   drivers/gpu/drm/xe/xe_lrc.c:654:55: error: 'RING_VALID' undeclared (first use in this function)
     654 |  regs[CTX_RING_CTL] = RING_CTL_SIZE(lrc->ring_size) | RING_VALID;
         |                                                       ^~~~~~~~~~
   In file included from arch/x86/include/asm/bug.h:84,
                    from include/linux/bug.h:5,
                    from include/drm/drm_mm.h:40,
                    from drivers/gpu/drm/xe/xe_bo.h:10,
                    from drivers/gpu/drm/xe/xe_lrc.h:9,
                    from drivers/gpu/drm/xe/xe_lrc.c:7:
   drivers/gpu/drm/xe/xe_lrc.c: In function 'xe_lrc_assert_ring_space':
>> drivers/gpu/drm/xe/xe_lrc.c:699:21: error: format '%lu' expects argument of type 'long unsigned int', but argument 2 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
     699 |  WARN(size > space, "Insufficient ring space: %lu > %u", size, space);
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  ~~~~
         |                                                          |
         |                                                          size_t {aka unsigned int}
   include/asm-generic/bug.h:99:17: note: in definition of macro '__WARN_printf'
      99 |   __warn_printk(arg);     \
         |                 ^~~
   drivers/gpu/drm/xe/xe_lrc.c:699:2: note: in expansion of macro 'WARN'
     699 |  WARN(size > space, "Insufficient ring space: %lu > %u", size, space);
         |  ^~~~
   drivers/gpu/drm/xe/xe_lrc.c:699:49: note: format string is defined here
     699 |  WARN(size > space, "Insufficient ring space: %lu > %u", size, space);
         |                                               ~~^
         |                                                 |
         |                                                 long unsigned int
         |                                               %u
   cc1: all warnings being treated as errors


vim +699 drivers/gpu/drm/xe/xe_lrc.c

   692	
   693	static void xe_lrc_assert_ring_space(struct xe_lrc *lrc, size_t size)
   694	{
   695	#if XE_EXTRA_DEBUG
   696		uint32_t space = xe_lrc_ring_space(lrc);
   697	
   698		BUG_ON(size > lrc->ring_size);
 > 699		WARN(size > space, "Insufficient ring space: %lu > %u", size, space);
   700	#endif
   701	}
   702	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
