Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11FBD48DA45
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 15:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235882AbiAMO6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 09:58:54 -0500
Received: from mga09.intel.com ([134.134.136.24]:45230 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232357AbiAMO6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 09:58:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642085933; x=1673621933;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QdalcrLT+EXEFCP4SwYxznovdQL1Uvdbiea5hcb4Qoc=;
  b=EoBkgmEWWgRQp/MikOgcDuaefaOpXJkU7GnmXRf4ScM61bPoesWyBMU+
   RZyGMF2C9PrV00NtYh/WqZHnnae27pG6QYx9YcQLjV/4HYO9L7n9UyfEP
   jWa4/xRXkJJ5VAGHESs5Q55zrpH6FnLs7tPQWT51LPSdSx/W5JaBAkf4j
   y9p1zrzrqBm+TSsbsn10iUrk2k7ujgrgDR3NrrKJrRK73s5Wl69B8lm4h
   9e8BZGw1nRkarzT5Lm6ir5ykWvXbtdv1B4Q4PD9QMWQx9zv5BsNnICDN6
   QoRQ+lgGNnQT208B6mwU0dv0VPlJCCasZnB8ULVujVCmsC8xLDDKL9zxL
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="243820689"
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="243820689"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 06:58:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="593364567"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 13 Jan 2022 06:58:51 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n81Yw-0007Jl-Ri; Thu, 13 Jan 2022 14:58:50 +0000
Date:   Thu, 13 Jan 2022 22:58:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: include/linux/compiler_types.h:319:45: error: call to
 '__compiletime_assert_221' declared with attribute error: BUILD_BUG_ON
 failed: FIX_KMAP_SLOTS > PTRS_PER_PTE
Message-ID: <202201132244.7zrKls77-lkp@intel.com>
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
head:   455e73a07f6e288b0061dfcf4fcf54fa9fe06458
commit: 6e799cb69a70eedbb41561b750f7180c12cff280 mm/highmem: Provide and use CONFIG_DEBUG_KMAP_LOCAL
date:   1 year, 2 months ago
config: arc-randconfig-r024-20220113 (https://download.01.org/0day-ci/archive/20220113/202201132244.7zrKls77-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
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
>> include/linux/compiler_types.h:319:45: error: call to '__compiletime_assert_221' declared with attribute error: BUILD_BUG_ON failed: FIX_KMAP_SLOTS > PTRS_PER_PTE
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


vim +/__compiletime_assert_221 +319 include/linux/compiler_types.h

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
