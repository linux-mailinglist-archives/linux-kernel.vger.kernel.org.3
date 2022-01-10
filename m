Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB53C489D57
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 17:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237215AbiAJQSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 11:18:07 -0500
Received: from mga12.intel.com ([192.55.52.136]:36468 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237046AbiAJQSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 11:18:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641831486; x=1673367486;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cwPgUeAziCfWOBUPx8MZTKkOs4N32EdvmU8/uIxAgn0=;
  b=A+3H4uyL2mqk811GkefMUdiuFBZgH7OpwL+38BDTLeihEysVqRn8HSbZ
   XTjfvZiTUwmAG9sWt7xbijClK9F58X25BGtDuiLE1DGes+fGqwk+sct2S
   jLlirgOFAnXjv9roRmjGAPrcu/VtVC1x0Lx/YyhfsixRg77rot8rmrSm1
   3nd/d2/9i0fLoaHl9TIJkujApHyOGtFCYSsNjzDsCOWuqfuBgKiMqPYbP
   cm6mYbh53xHu6f6pEYf7NMhTeg5oC44I09z6vE2xl7Fe56LSNpvspV3hf
   LMFtScxoJYO3D2INKWBqzh0kC5SGwXswMuzXZMNRLhvdJcU6JqFxTDAZ2
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10222"; a="223241563"
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="223241563"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 08:18:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="575865957"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 10 Jan 2022 08:18:04 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6xMy-0003iv-0U; Mon, 10 Jan 2022 16:18:04 +0000
Date:   Tue, 11 Jan 2022 00:17:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2357/2380]
 drivers/sbus/char/envctrl.c:1001:57: error: invalid use of undefined type
 'struct task_struct'
Message-ID: <202201110001.jDRoBKcb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   351bfbf7f1e8dce84b605c8007c98dd603c4ca4d
commit: 61ea5a6fab5c8fae043a02a100970041dc6a877e [2357/2380] headers/deps: delay: Optimize <linux/delay.h> dependencies, remove <linux/sched.h> inclusion
config: sparc64-buildonly-randconfig-r003-20220109 (https://download.01.org/0day-ci/archive/20220111/202201110001.jDRoBKcb-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=61ea5a6fab5c8fae043a02a100970041dc6a877e
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 61ea5a6fab5c8fae043a02a100970041dc6a877e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:22,
                    from arch/sparc/include/asm/bug.h:25,
                    from include/linux/bug.h:5,
                    from include/linux/kernfs.h:9,
                    from include/linux/kobject_api.h:20,
                    from include/linux/of_api.h:26,
                    from drivers/sbus/char/envctrl.c:22:
   drivers/sbus/char/envctrl.c: In function 'kenvctrld':
>> drivers/sbus/char/envctrl.c:1001:57: error: invalid use of undefined type 'struct task_struct'
    1001 |         printk(KERN_INFO PFX "%s starting...\n", current->comm);
         |                                                         ^~
   include/linux/printk.h:419:33: note: in definition of macro 'printk_index_wrap'
     419 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   drivers/sbus/char/envctrl.c:1001:9: note: in expansion of macro 'printk'
    1001 |         printk(KERN_INFO PFX "%s starting...\n", current->comm);
         |         ^~~~~~
   drivers/sbus/char/envctrl.c:1016:56: error: invalid use of undefined type 'struct task_struct'
    1016 |                                                 current->comm, whichcpu,
         |                                                        ^~
   include/linux/printk.h:419:33: note: in definition of macro 'printk_index_wrap'
     419 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   drivers/sbus/char/envctrl.c:1013:41: note: in expansion of macro 'printk'
    1013 |                                         printk(KERN_CRIT
         |                                         ^~~~~~
   drivers/sbus/char/envctrl.c:1023:56: error: invalid use of undefined type 'struct task_struct'
    1023 |         printk(KERN_INFO PFX "%s exiting...\n", current->comm);
         |                                                        ^~
   include/linux/printk.h:419:33: note: in definition of macro 'printk_index_wrap'
     419 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   drivers/sbus/char/envctrl.c:1023:9: note: in expansion of macro 'printk'
    1023 |         printk(KERN_INFO PFX "%s exiting...\n", current->comm);
         |         ^~~~~~
   In file included from drivers/sbus/char/envctrl.c:26:
   drivers/sbus/char/envctrl.c: In function 'envctrl_probe':
>> include/linux/kthread.h:58:17: error: implicit declaration of function 'wake_up_process' [-Werror=implicit-function-declaration]
      58 |                 wake_up_process(__k);                                      \
         |                 ^~~~~~~~~~~~~~~
   drivers/sbus/char/envctrl.c:1085:26: note: in expansion of macro 'kthread_run'
    1085 |         kenvctrld_task = kthread_run(kenvctrld, NULL, "kenvctrld");
         |                          ^~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   drivers/sbus/char/bbc_envctrl.c:569:5: warning: no previous prototype for 'bbc_envctrl_init' [-Wmissing-prototypes]
     569 | int bbc_envctrl_init(struct bbc_i2c_bus *bp)
         |     ^~~~~~~~~~~~~~~~
   In file included from drivers/sbus/char/bbc_envctrl.c:10:
   drivers/sbus/char/bbc_envctrl.c: In function 'bbc_envctrl_init':
>> include/linux/kthread.h:58:17: error: implicit declaration of function 'wake_up_process' [-Werror=implicit-function-declaration]
      58 |                 wake_up_process(__k);                                      \
         |                 ^~~~~~~~~~~~~~~
   drivers/sbus/char/bbc_envctrl.c:583:34: note: in expansion of macro 'kthread_run'
     583 |                 kenvctrld_task = kthread_run(kenvctrld, NULL, "kenvctrld");
         |                                  ^~~~~~~~~~~
   drivers/sbus/char/bbc_envctrl.c: At top level:
   drivers/sbus/char/bbc_envctrl.c:597:6: warning: no previous prototype for 'bbc_envctrl_cleanup' [-Wmissing-prototypes]
     597 | void bbc_envctrl_cleanup(struct bbc_i2c_bus *bp)
         |      ^~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +1001 drivers/sbus/char/envctrl.c

^1da177e4c3f41 Linus Torvalds      2005-04-16   985  
^1da177e4c3f41 Linus Torvalds      2005-04-16   986  static int kenvctrld(void *__unused)
^1da177e4c3f41 Linus Torvalds      2005-04-16   987  {
^1da177e4c3f41 Linus Torvalds      2005-04-16   988  	int poll_interval;
^1da177e4c3f41 Linus Torvalds      2005-04-16   989  	int whichcpu;
^1da177e4c3f41 Linus Torvalds      2005-04-16   990  	char tempbuf[10];
^1da177e4c3f41 Linus Torvalds      2005-04-16   991  	struct i2c_child_t *cputemp;
^1da177e4c3f41 Linus Torvalds      2005-04-16   992  
^1da177e4c3f41 Linus Torvalds      2005-04-16   993  	if (NULL == (cputemp = envctrl_get_i2c_child(ENVCTRL_CPUTEMP_MON))) {
6b8c90f24e2450 David S. Miller     2008-08-29   994  		printk(KERN_ERR  PFX
6b8c90f24e2450 David S. Miller     2008-08-29   995  		       "kenvctrld unable to monitor CPU temp-- exiting\n");
^1da177e4c3f41 Linus Torvalds      2005-04-16   996  		return -ENODEV;
^1da177e4c3f41 Linus Torvalds      2005-04-16   997  	}
^1da177e4c3f41 Linus Torvalds      2005-04-16   998  
cb39d263e751f9 Nishanth Aravamudan 2005-07-24   999  	poll_interval = 5000; /* TODO env_mon_interval */
^1da177e4c3f41 Linus Torvalds      2005-04-16  1000  
6b8c90f24e2450 David S. Miller     2008-08-29 @1001  	printk(KERN_INFO PFX "%s starting...\n", current->comm);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1002  	for (;;) {
218b29e0c3995e Christoph Hellwig   2005-08-09  1003  		msleep_interruptible(poll_interval);
218b29e0c3995e Christoph Hellwig   2005-08-09  1004  
218b29e0c3995e Christoph Hellwig   2005-08-09  1005  		if (kthread_should_stop())
^1da177e4c3f41 Linus Torvalds      2005-04-16  1006  			break;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1007  		
^1da177e4c3f41 Linus Torvalds      2005-04-16  1008  		for (whichcpu = 0; whichcpu < ENVCTRL_MAX_CPU; ++whichcpu) {
^1da177e4c3f41 Linus Torvalds      2005-04-16  1009  			if (0 < envctrl_read_cpu_info(whichcpu, cputemp,
^1da177e4c3f41 Linus Torvalds      2005-04-16  1010  						      ENVCTRL_CPUTEMP_MON,
^1da177e4c3f41 Linus Torvalds      2005-04-16  1011  						      tempbuf)) {
^1da177e4c3f41 Linus Torvalds      2005-04-16  1012  				if (tempbuf[0] >= shutdown_temperature) {
^1da177e4c3f41 Linus Torvalds      2005-04-16  1013  					printk(KERN_CRIT 
^1da177e4c3f41 Linus Torvalds      2005-04-16  1014  						"%s: WARNING: CPU%i temperature %i C meets or exceeds "\
^1da177e4c3f41 Linus Torvalds      2005-04-16  1015  						"shutdown threshold %i C\n", 
^1da177e4c3f41 Linus Torvalds      2005-04-16  1016  						current->comm, whichcpu, 
^1da177e4c3f41 Linus Torvalds      2005-04-16  1017  						tempbuf[0], shutdown_temperature);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1018  					envctrl_do_shutdown();
^1da177e4c3f41 Linus Torvalds      2005-04-16  1019  				}
^1da177e4c3f41 Linus Torvalds      2005-04-16  1020  			}
^1da177e4c3f41 Linus Torvalds      2005-04-16  1021  		}
^1da177e4c3f41 Linus Torvalds      2005-04-16  1022  	}
6b8c90f24e2450 David S. Miller     2008-08-29  1023  	printk(KERN_INFO PFX "%s exiting...\n", current->comm);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1024  	return 0;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1025  }
^1da177e4c3f41 Linus Torvalds      2005-04-16  1026  

:::::: The code at line 1001 was first introduced by commit
:::::: 6b8c90f24e24505f97efaef1a46572d6b45929b9 envctrl: Convert to pure OF driver.

:::::: TO: David S. Miller <davem@davemloft.net>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
