Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D783F4671A2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 06:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238272AbhLCFbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 00:31:21 -0500
Received: from mga04.intel.com ([192.55.52.120]:63833 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229931AbhLCFbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 00:31:20 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="235649558"
X-IronPort-AV: E=Sophos;i="5.87,283,1631602800"; 
   d="scan'208";a="235649558"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 21:27:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,283,1631602800"; 
   d="scan'208";a="501054698"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 02 Dec 2021 21:27:55 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mt16w-000H6j-Qa; Fri, 03 Dec 2021 05:27:54 +0000
Date:   Fri, 3 Dec 2021 13:27:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:x86/wip.ibt 14/15] include/linux/kern_levels.h:5:18:
 warning: format '%d' expects argument of type 'int', but argument 2 has type
 'long int'
Message-ID: <202112031323.lnuwutrF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/wip.ibt
head:   80bc7f2a129848b0885cf214fda77f623ba2f5f9
commit: 5ebb27d6de4491406de69c4a35bb75d7a2b3b97e [14/15] x86/alternative: Use .ibt_endbr_sites to seal indirect calls
config: x86_64-randconfig-r003-20211203 (https://download.01.org/0day-ci/archive/20211203/202112031323.lnuwutrF-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=5ebb27d6de4491406de69c4a35bb75d7a2b3b97e
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue x86/wip.ibt
        git checkout 5ebb27d6de4491406de69c4a35bb75d7a2b3b97e
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:20,
                    from arch/x86/include/asm/percpu.h:27,
                    from arch/x86/include/asm/current.h:6,
                    from arch/x86/include/asm/processor.h:17,
                    from arch/x86/include/asm/timex.h:5,
                    from include/linux/timex.h:65,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from arch/x86/kernel/alternative.c:4:
   arch/x86/kernel/alternative.c: In function 'apply_ibt_endbr':
>> include/linux/kern_levels.h:5:18: warning: format '%d' expects argument of type 'int', but argument 2 has type 'long int' [-Wformat=]
       5 | #define KERN_SOH "\001"  /* ASCII Start Of Header */
         |                  ^~~~~~
   include/linux/printk.h:422:11: note: in definition of macro 'printk_index_wrap'
     422 |   _p_func(_fmt, ##__VA_ARGS__);    \
         |           ^~~~
   include/linux/printk.h:493:2: note: in expansion of macro 'printk'
     493 |  printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |  ^~~~~~
   include/linux/kern_levels.h:11:18: note: in expansion of macro 'KERN_SOH'
      11 | #define KERN_ERR KERN_SOH "3" /* error conditions */
         |                  ^~~~~~~~
   include/linux/printk.h:493:9: note: in expansion of macro 'KERN_ERR'
     493 |  printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~
   arch/x86/kernel/alternative.c:531:2: note: in expansion of macro 'pr_err'
     531 |  pr_err("XXX IBT: %d\n", end-start);
         |  ^~~~~~
   arch/x86/kernel/alternative.c:531:20: note: format string is defined here
     531 |  pr_err("XXX IBT: %d\n", end-start);
         |                   ~^
         |                    |
         |                    int
         |                   %ld


vim +5 include/linux/kern_levels.h

314ba3520e513a Joe Perches 2012-07-30  4  
04d2c8c83d0e3a Joe Perches 2012-07-30 @5  #define KERN_SOH	"\001"		/* ASCII Start Of Header */
04d2c8c83d0e3a Joe Perches 2012-07-30  6  #define KERN_SOH_ASCII	'\001'
04d2c8c83d0e3a Joe Perches 2012-07-30  7  

:::::: The code at line 5 was first introduced by commit
:::::: 04d2c8c83d0e3ac5f78aeede51babb3236200112 printk: convert the format for KERN_<LEVEL> to a 2 byte pattern

:::::: TO: Joe Perches <joe@perches.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
