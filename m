Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE78F47BE5D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 11:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbhLUKq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 05:46:56 -0500
Received: from mga07.intel.com ([134.134.136.100]:63071 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231523AbhLUKqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 05:46:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640083615; x=1671619615;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pjRFMk7WKO1ICd6qxstX01wYCkdvmQVl4OiV2DiXEQQ=;
  b=UgGwh+ndOdmTCmh7p2Bg8+jJqR31TdH97wy+lPnlo3ZIOaRh8W5HcUWV
   yJzCi066QTqlrxpEKvEz2VQK3pNY6iS9/VHkPg/10p1mx2SQV1HLrsJIt
   TGnK/1cVfXqIBzB3YQHIFk8RUWhFxVDz8DkDjzm66tH6S16WRrFbOqDut
   nC3uOJB20jywGh7V1QoFrteCpPb8slxZgduLalFPp8GHSHwF9EH932vxe
   crvJsisAXkMv4OK0/sVeCo7z9QWlu1KGAgjPmHiwp+ChVC1wAgyOjeXz2
   JGn1e2dx6ZcDyZdk4VJz3kTqMHCnqu/GzBopl7ZCqmzlKaFEZiCY7tpzy
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="303741704"
X-IronPort-AV: E=Sophos;i="5.88,223,1635231600"; 
   d="scan'208";a="303741704"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 02:46:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,223,1635231600"; 
   d="scan'208";a="616725537"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 21 Dec 2021 02:46:53 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzcfU-000909-U0; Tue, 21 Dec 2021 10:46:52 +0000
Date:   Tue, 21 Dec 2021 18:46:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [andrea-aa:main 22/46] include/linux/compiler_types.h:335:45: error:
 call to '__compiletime_assert_426' declared with attribute error:
 BUILD_BUG_ON failed: (long) &mm_check->page_table_lock - (long)
 &mm_check->mmap_lock < L1_CACHE_BYTES
Message-ID: <202112211850.LkEJiilF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/andrea/aa.git main
head:   9571e82616c7501d7cc5a590c12e467ed14e31ff
commit: 181520af2b00728d6bb76d98d5a531c7853333b2 [22/46] mm: cacheline alignment for page_table_lock and mmap_lock
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20211221/202112211850.LkEJiilF-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/andrea/aa.git/commit/?id=181520af2b00728d6bb76d98d5a531c7853333b2
        git remote add andrea-aa https://git.kernel.org/pub/scm/linux/kernel/git/andrea/aa.git
        git fetch --no-tags andrea-aa main
        git checkout 181520af2b00728d6bb76d98d5a531c7853333b2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/fork.c:763:20: warning: no previous prototype for 'arch_task_cache_init' [-Wmissing-prototypes]
     763 | void __init __weak arch_task_cache_init(void) { }
         |                    ^~~~~~~~~~~~~~~~~~~~
   In file included from <command-line>:
   kernel/fork.c: In function 'proc_caches_init':
>> include/linux/compiler_types.h:335:45: error: call to '__compiletime_assert_426' declared with attribute error: BUILD_BUG_ON failed: (long) &mm_check->page_table_lock - (long) &mm_check->mmap_lock < L1_CACHE_BYTES
     335 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:316:25: note: in definition of macro '__compiletime_assert'
     316 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:335:9: note: in expansion of macro '_compiletime_assert'
     335 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   kernel/fork.c:2938:9: note: in expansion of macro 'BUILD_BUG_ON'
    2938 |         BUILD_BUG_ON((long) &mm_check->page_table_lock -
         |         ^~~~~~~~~~~~


vim +/__compiletime_assert_426 +335 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  321  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  322  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  323  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  324  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  325  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  326   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  327   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  328   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  329   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  330   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  331   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  332   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  333   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  334  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @335  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  336  

:::::: The code at line 335 was first introduced by commit
:::::: eb5c2d4b45e3d2d5d052ea6b8f1463976b1020d5 compiler.h: Move compiletime_assert() macros into compiler_types.h

:::::: TO: Will Deacon <will@kernel.org>
:::::: CC: Will Deacon <will@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
