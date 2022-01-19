Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28BC4494221
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 21:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242646AbiASUyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 15:54:52 -0500
Received: from mga01.intel.com ([192.55.52.88]:47390 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245276AbiASUyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 15:54:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642625686; x=1674161686;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ISpKOIpZwlrTJOcJB1gzYZxHJ1Ed3uzU5eT6nLXOfjI=;
  b=X+wkktfII/V+ku4BI2K8CER4dkoBC+nI1DzscAmn1Rilq8u8cEDyz4OG
   PZi7uqmuXJQCoJl3OY+orFbe1EWe2GuzILxFx/I2Xxt8sNShCiaeOJFcU
   XFD+dqUbSWMddAFvlTUY3XznTwfiDu3m6WRd9QBnSNevF2aT+HnffWO3+
   3w8QU5dCjLlLML9L4zFIJPpdA5YvUF+K56KAiUH8D4NBt/GPITbkdF5UE
   iq1fMJNInMfNPvFf3SsD9GnEC5jVp5Ty2PwzabsskMHX8NpvoffZAKLgO
   SWX7KofW2lwcGyrs3YQIt8l7OURILSBbfNLlw0As8tUDn7hvHyYmhHPYv
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="269585086"
X-IronPort-AV: E=Sophos;i="5.88,300,1635231600"; 
   d="scan'208";a="269585086"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 12:54:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,300,1635231600"; 
   d="scan'208";a="532475084"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 19 Jan 2022 12:54:41 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nAHya-000Dkc-OE; Wed, 19 Jan 2022 20:54:40 +0000
Date:   Thu, 20 Jan 2022 04:54:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: include/linux/compiler_types.h:319:45: error: call to
 '__compiletime_assert_242' declared with attribute error: BUILD_BUG_ON
 failed: FIX_KMAP_SLOTS > PTRS_PER_PTE
Message-ID: <202201200455.gDoPashc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1d1df41c5a33359a00e919d54eaebfb789711fdc
commit: 39cac191ff37939544af80d5d2af6b870fd94c9b arc/mm/highmem: Use generic kmap atomic implementation
date:   1 year, 2 months ago
config: arc-randconfig-r033-20220118 (https://download.01.org/0day-ci/archive/20220120/202201200455.gDoPashc-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=39cac191ff37939544af80d5d2af6b870fd94c9b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 39cac191ff37939544af80d5d2af6b870fd94c9b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash arch/arc/mm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   arch/arc/mm/highmem.c: In function 'kmap_init':
>> include/linux/compiler_types.h:319:45: error: call to '__compiletime_assert_242' declared with attribute error: BUILD_BUG_ON failed: FIX_KMAP_SLOTS > PTRS_PER_PTE
     319 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:300:25: note: in definition of macro '__compiletime_assert'
     300 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:319:9: note: in expansion of macro '_compiletime_assert'
     319 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   arch/arc/mm/highmem.c:69:9: note: in expansion of macro 'BUILD_BUG_ON'
      69 |         BUILD_BUG_ON(FIX_KMAP_SLOTS > PTRS_PER_PTE);
         |         ^~~~~~~~~~~~


vim +/__compiletime_assert_242 +319 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  305  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  306  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  307  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  308  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  309  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  310   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  311   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  312   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  313   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  314   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  315   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  316   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  317   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  318  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @319  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  320  

:::::: The code at line 319 was first introduced by commit
:::::: eb5c2d4b45e3d2d5d052ea6b8f1463976b1020d5 compiler.h: Move compiletime_assert() macros into compiler_types.h

:::::: TO: Will Deacon <will@kernel.org>
:::::: CC: Will Deacon <will@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
