Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED34471F17
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 02:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhLMBMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 20:12:38 -0500
Received: from mga14.intel.com ([192.55.52.115]:60492 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230473AbhLMBMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 20:12:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639357955; x=1670893955;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gWc2wEfJyAoA6CSladvKSLEBAB1oaD/4D+aGqHBG1hc=;
  b=bCbOOB+Vf/V5Rp9EC+eFS+qigZUQFY3NcoaSiNMlvWBvv4q0bi56P9W5
   GwJQ0DyHn5FZZ4S6Ww+4ITWnVpl23EGWPptkA0a6oAfmLg+Zx6jpnuhxD
   CaxO5R2sI0LmXu+vRAM+ForFej3iWm2h4yow2ljLnehu0tu9yd3eSW5SO
   bGrjeNnioErux1rje/6tICZeqo00WSnMHz7ljMpHjNnDj3tCoXddDZ3Jy
   6dbVibuURTc3dOXLEZdKTFVfbf2K2O0KFnYBB5dVKDi1McFiuNG2AOIzJ
   TwvoHRLd23qnPL0+Qz2PeSSfVImnlcvVUBHOATwtlmgj3PqoF/tJEmdnl
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10195"; a="238865422"
X-IronPort-AV: E=Sophos;i="5.88,201,1635231600"; 
   d="scan'208";a="238865422"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2021 17:12:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,201,1635231600"; 
   d="scan'208";a="517549187"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 12 Dec 2021 17:12:33 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mwZtI-000688-Nw; Mon, 13 Dec 2021 01:12:32 +0000
Date:   Mon, 13 Dec 2021 09:12:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: include/linux/compiler_types.h:319:45: error: call to
 '__compiletime_assert_224' declared with attribute error: BUILD_BUG_ON
 failed: FIX_KMAP_SLOTS > PTRS_PER_PTE
Message-ID: <202112130903.XTxjLBdl-lkp@intel.com>
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
head:   2585cf9dfaaddf00b069673f27bb3f8530e2039c
commit: 6e799cb69a70eedbb41561b750f7180c12cff280 mm/highmem: Provide and use CONFIG_DEBUG_KMAP_LOCAL
date:   1 year, 1 month ago
config: arc-randconfig-r011-20211212 (https://download.01.org/0day-ci/archive/20211213/202112130903.XTxjLBdl-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6e799cb69a70eedbb41561b750f7180c12cff280
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 6e799cb69a70eedbb41561b750f7180c12cff280
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash arch/arc/mm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   arch/arc/mm/highmem.c: In function 'kmap_init':
>> include/linux/compiler_types.h:319:45: error: call to '__compiletime_assert_224' declared with attribute error: BUILD_BUG_ON failed: FIX_KMAP_SLOTS > PTRS_PER_PTE
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


vim +/__compiletime_assert_224 +319 include/linux/compiler_types.h

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
