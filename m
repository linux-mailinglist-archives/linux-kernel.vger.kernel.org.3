Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B785467781
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 13:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380413AbhLCMkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 07:40:42 -0500
Received: from mga07.intel.com ([134.134.136.100]:47353 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351732AbhLCMki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 07:40:38 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="300352403"
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="300352403"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 04:37:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="678086079"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 03 Dec 2021 04:37:09 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mt7oK-000HZJ-Na; Fri, 03 Dec 2021 12:37:08 +0000
Date:   Fri, 3 Dec 2021 20:36:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:x86/wip.ibt 11/15] arch/x86/kernel/traps.c:647:7:
 error: implicit declaration of function 'x86_feature_enabled'; did you mean
 'cpu_feature_enabled'?
Message-ID: <202112032046.J9J12rUt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/wip.ibt
head:   80bc7f2a129848b0885cf214fda77f623ba2f5f9
commit: 715bf971dc2ec830ebcc60df3edcc7935d04332a [11/15] x86: Add IBT feature, MSR and #CP handling
config: x86_64-randconfig-r003-20211203 (https://download.01.org/0day-ci/archive/20211203/202112032046.J9J12rUt-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=715bf971dc2ec830ebcc60df3edcc7935d04332a
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue x86/wip.ibt
        git checkout 715bf971dc2ec830ebcc60df3edcc7935d04332a
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the peterz-queue/x86/wip.ibt HEAD 80bc7f2a129848b0885cf214fda77f623ba2f5f9 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   arch/x86/kernel/traps.c: In function '__exc_control_protection':
>> arch/x86/kernel/traps.c:647:7: error: implicit declaration of function 'x86_feature_enabled'; did you mean 'cpu_feature_enabled'? [-Werror=implicit-function-declaration]
     647 |  if (!x86_feature_enabled(X86_FEATURE_IBT)) {
         |       ^~~~~~~~~~~~~~~~~~~
         |       cpu_feature_enabled
   In file included from include/linux/kernel.h:20,
                    from arch/x86/include/asm/percpu.h:27,
                    from arch/x86/include/asm/current.h:6,
                    from include/linux/sched.h:12,
                    from include/linux/context_tracking.h:5,
                    from arch/x86/kernel/traps.c:15:
   include/linux/kern_levels.h:5:18: warning: format '%p' expects argument of type 'void *', but argument 2 has type 'long unsigned int' [-Wformat=]
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
   arch/x86/kernel/traps.c:655:2: note: in expansion of macro 'pr_err'
     655 |  pr_err("Missing ENDBR: %pS\n", instruction_pointer(regs));
         |  ^~~~~~
   cc1: some warnings being treated as errors


vim +647 arch/x86/kernel/traps.c

   643	
   644	#ifdef CONFIG_X86_IBT
   645	DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
   646	{
 > 647		if (!x86_feature_enabled(X86_FEATURE_IBT)) {
   648			pr_err("Whaaa?!?!\n");
   649			return;
   650		}
   651	
   652		if (WARN_ON_ONCE(user_mode(regs) || error_code != 3))
   653			return;
   654	
   655		pr_err("Missing ENDBR: %pS\n", instruction_pointer(regs));
   656		return;
   657	}
   658	#endif
   659	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
