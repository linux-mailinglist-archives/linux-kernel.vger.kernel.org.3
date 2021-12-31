Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF544825A9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 20:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbhLaTlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 14:41:14 -0500
Received: from mga06.intel.com ([134.134.136.31]:18648 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231589AbhLaTlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 14:41:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640979672; x=1672515672;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aM1sDLD9EtFNe42N+cP2CC84m3uQjpOPQvKIn4XwDN4=;
  b=C7nUtkCQ796PvMpWyieV05Stln6nZbTcx/LL1+XFDtyrAcgjv958d9Bf
   JQeTWiygtjHDuhP4BVkugZjS4wR/RFQ/utQ2QhSQS8tNC0PMlrkQHu6Jb
   X225ESD0s9v4s5KpKQAwLSu8oEQtgbNzN+SWnagfZym51eeWdsHHkPdko
   mGphLEvBgnQmqv5iItP2o/gHurQj+pArGs5pXOe/Qkg7kl+ZSDUiyraCO
   /Njw/19KTPZSA1+DPU2WtiwxbnOzjzBaEVHqWGHjCr4hLLP3E1XhgWcYv
   Mg1QPua8T1ItCuNKzXC4K6lD/H8+NzLs1LaOuJ/00pOz5uXrIYS/htDox
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10213"; a="302591308"
X-IronPort-AV: E=Sophos;i="5.88,252,1635231600"; 
   d="scan'208";a="302591308"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2021 11:41:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,252,1635231600"; 
   d="scan'208";a="471013480"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 31 Dec 2021 11:41:10 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n3Nm1-000Bcc-Nm; Fri, 31 Dec 2021 19:41:09 +0000
Date:   Sat, 1 Jan 2022 03:40:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [dlemoal-libata:for-5.17-logging 46/79]
 include/linux/libata.h:1493:23: warning: format '%x' expects argument of
 type 'unsigned int', but argument 4 has type 'dma_addr_t' {aka 'long long
 unsigned int'}
Message-ID: <202201010316.Xs1Xbwjo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata.git for-5.17-logging
head:   fc730a4198504b83666da816eea7cb582fd9ae01
commit: 65625c4d468ec05a28451701b5808ea6400db5f5 [46/79] sata_fsl: convert VPRINTK() calls to ata_port_dbg()
config: powerpc64-randconfig-r036-20211231 (https://download.01.org/0day-ci/archive/20220101/202201010316.Xs1Xbwjo-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata.git/commit/?id=65625c4d468ec05a28451701b5808ea6400db5f5
        git remote add dlemoal-libata git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata.git
        git fetch --no-tags dlemoal-libata for-5.17-logging
        git checkout 65625c4d468ec05a28451701b5808ea6400db5f5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/ata/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/printk.h:559,
                    from include/linux/kernel.h:20,
                    from drivers/ata/sata_fsl.c:13:
   drivers/ata/sata_fsl.c: In function 'fsl_sata_set_irq_coalescing':
   drivers/ata/sata_fsl.c:316:17: error: passing argument 2 of '__dynamic_dev_dbg' from incompatible pointer type [-Werror=incompatible-pointer-types]
     316 |         dev_dbg(&host->dev, "interrupt coalescing, count = 0x%x, ticks = %x\n",
         |                 ^~~~~~~~~~
         |                 |
         |                 struct device **
   include/linux/dynamic_debug.h:134:29: note: in definition of macro '__dynamic_func_call'
     134 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:166:9: note: in expansion of macro '_dynamic_func_call'
     166 |         _dynamic_func_call(fmt,__dynamic_dev_dbg,               \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_dbg'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   drivers/ata/sata_fsl.c:316:9: note: in expansion of macro 'dev_dbg'
     316 |         dev_dbg(&host->dev, "interrupt coalescing, count = 0x%x, ticks = %x\n",
         |         ^~~~~~~
   include/linux/dynamic_debug.h:73:73: note: expected 'const struct device *' but argument is of type 'struct device **'
      73 | void __dynamic_dev_dbg(struct _ddebug *descriptor, const struct device *dev,
         |                                                    ~~~~~~~~~~~~~~~~~~~~~^~~
   drivers/ata/sata_fsl.c:318:17: error: passing argument 2 of '__dynamic_dev_dbg' from incompatible pointer type [-Werror=incompatible-pointer-types]
     318 |         dev_dbg(&host->dev, "ICC register status: (hcr base: 0x%x) = 0x%x\n",
         |                 ^~~~~~~~~~
         |                 |
         |                 struct device **
   include/linux/dynamic_debug.h:134:29: note: in definition of macro '__dynamic_func_call'
     134 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:166:9: note: in expansion of macro '_dynamic_func_call'
     166 |         _dynamic_func_call(fmt,__dynamic_dev_dbg,               \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_dbg'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   drivers/ata/sata_fsl.c:318:9: note: in expansion of macro 'dev_dbg'
     318 |         dev_dbg(&host->dev, "ICC register status: (hcr base: 0x%x) = 0x%x\n",
         |         ^~~~~~~
   include/linux/dynamic_debug.h:73:73: note: expected 'const struct device *' but argument is of type 'struct device **'
      73 | void __dynamic_dev_dbg(struct _ddebug *descriptor, const struct device *dev,
         |                                                    ~~~~~~~~~~~~~~~~~~~~~^~~
   drivers/ata/sata_fsl.c:318:29: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'void *' [-Wformat=]
     318 |         dev_dbg(&host->dev, "ICC register status: (hcr base: 0x%x) = 0x%x\n",
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:134:29: note: in definition of macro '__dynamic_func_call'
     134 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:166:9: note: in expansion of macro '_dynamic_func_call'
     166 |         _dynamic_func_call(fmt,__dynamic_dev_dbg,               \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_dbg'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:30: note: in expansion of macro 'dev_fmt'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                              ^~~~~~~
   drivers/ata/sata_fsl.c:318:9: note: in expansion of macro 'dev_dbg'
     318 |         dev_dbg(&host->dev, "ICC register status: (hcr base: 0x%x) = 0x%x\n",
         |         ^~~~~~~
   drivers/ata/sata_fsl.c:318:65: note: format string is defined here
     318 |         dev_dbg(&host->dev, "ICC register status: (hcr base: 0x%x) = 0x%x\n",
         |                                                                ~^
         |                                                                 |
         |                                                                 unsigned int
         |                                                                %p
   In file included from include/linux/kernel.h:20,
                    from drivers/ata/sata_fsl.c:13:
   drivers/ata/sata_fsl.c: In function 'sata_fsl_port_start':
>> include/linux/libata.h:1493:23: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'dma_addr_t' {aka 'long long unsigned int'} [-Wformat=]
    1493 |         pr_ ## level ("ata%u: " fmt, (ap)->print_id, ##__VA_ARGS__)
         |                       ^~~~~~~~~
   include/linux/printk.h:340:21: note: in definition of macro 'pr_fmt'
     340 | #define pr_fmt(fmt) fmt
         |                     ^~~
   include/linux/dynamic_debug.h:152:9: note: in expansion of macro '__dynamic_func_call'
     152 |         __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:162:9: note: in expansion of macro '_dynamic_func_call'
     162 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/printk.h:574:9: note: in expansion of macro 'dynamic_pr_debug'
     574 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~
   include/linux/libata.h:1493:9: note: in expansion of macro 'pr_debug'
    1493 |         pr_ ## level ("ata%u: " fmt, (ap)->print_id, ##__VA_ARGS__)
         |         ^~~
   include/linux/libata.h:1504:9: note: in expansion of macro 'ata_port_printk'
    1504 |         ata_port_printk(debug, ap, fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   drivers/ata/sata_fsl.c:734:9: note: in expansion of macro 'ata_port_dbg'
     734 |         ata_port_dbg(ap, "CHBA = 0x%x, cmdentry_phys = 0x%x\n",
         |         ^~~~~~~~~~~~
   include/linux/libata.h:1493:23: warning: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'dma_addr_t' {aka 'long long unsigned int'} [-Wformat=]
    1493 |         pr_ ## level ("ata%u: " fmt, (ap)->print_id, ##__VA_ARGS__)
         |                       ^~~~~~~~~
   include/linux/printk.h:340:21: note: in definition of macro 'pr_fmt'
     340 | #define pr_fmt(fmt) fmt
         |                     ^~~
   include/linux/dynamic_debug.h:152:9: note: in expansion of macro '__dynamic_func_call'
     152 |         __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:162:9: note: in expansion of macro '_dynamic_func_call'
     162 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/printk.h:574:9: note: in expansion of macro 'dynamic_pr_debug'
     574 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~
   include/linux/libata.h:1493:9: note: in expansion of macro 'pr_debug'
    1493 |         pr_ ## level ("ata%u: " fmt, (ap)->print_id, ##__VA_ARGS__)
         |         ^~~
   include/linux/libata.h:1504:9: note: in expansion of macro 'ata_port_printk'
    1504 |         ata_port_printk(debug, ap, fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   drivers/ata/sata_fsl.c:734:9: note: in expansion of macro 'ata_port_dbg'
     734 |         ata_port_dbg(ap, "CHBA = 0x%x, cmdentry_phys = 0x%x\n",
         |         ^~~~~~~~~~~~
   In file included from include/linux/printk.h:559,
                    from include/linux/kernel.h:20,
                    from drivers/ata/sata_fsl.c:13:
   drivers/ata/sata_fsl.c: In function 'sata_fsl_init_controller':
   drivers/ata/sata_fsl.c:1345:22: error: 'ap' undeclared (first use in this function); did you mean 'up'?
    1345 |         ata_port_dbg(ap, "icc = 0x%x\n", ioread32(hcr_base + ICC));
         |                      ^~
   include/linux/dynamic_debug.h:134:29: note: in definition of macro '__dynamic_func_call'
     134 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:162:9: note: in expansion of macro '_dynamic_func_call'
     162 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/printk.h:574:9: note: in expansion of macro 'dynamic_pr_debug'
     574 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~
   include/linux/libata.h:1493:9: note: in expansion of macro 'pr_debug'
    1493 |         pr_ ## level ("ata%u: " fmt, (ap)->print_id, ##__VA_ARGS__)
         |         ^~~
   include/linux/libata.h:1504:9: note: in expansion of macro 'ata_port_printk'
    1504 |         ata_port_printk(debug, ap, fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   drivers/ata/sata_fsl.c:1345:9: note: in expansion of macro 'ata_port_dbg'
    1345 |         ata_port_dbg(ap, "icc = 0x%x\n", ioread32(hcr_base + ICC));
         |         ^~~~~~~~~~~~
   drivers/ata/sata_fsl.c:1345:22: note: each undeclared identifier is reported only once for each function it appears in
    1345 |         ata_port_dbg(ap, "icc = 0x%x\n", ioread32(hcr_base + ICC));
         |                      ^~
   include/linux/dynamic_debug.h:134:29: note: in definition of macro '__dynamic_func_call'
     134 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:162:9: note: in expansion of macro '_dynamic_func_call'
     162 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/printk.h:574:9: note: in expansion of macro 'dynamic_pr_debug'
     574 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~
   include/linux/libata.h:1493:9: note: in expansion of macro 'pr_debug'
    1493 |         pr_ ## level ("ata%u: " fmt, (ap)->print_id, ##__VA_ARGS__)
         |         ^~~
   include/linux/libata.h:1504:9: note: in expansion of macro 'ata_port_printk'
    1504 |         ata_port_printk(debug, ap, fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   drivers/ata/sata_fsl.c:1345:9: note: in expansion of macro 'ata_port_dbg'
    1345 |         ata_port_dbg(ap, "icc = 0x%x\n", ioread32(hcr_base + ICC));
         |         ^~~~~~~~~~~~
   drivers/ata/sata_fsl.c: At top level:
   drivers/ata/sata_fsl.c:1383:22: warning: initialized field overwritten [-Woverride-init]
    1383 |         .can_queue = SATA_FSL_QUEUE_DEPTH,
         |                      ^~~~~~~~~~~~~~~~~~~~
   drivers/ata/sata_fsl.c:1383:22: note: (near initialization for 'sata_fsl_sht.can_queue')
   In file included from include/linux/printk.h:559,
                    from include/linux/kernel.h:20,


vim +1493 include/linux/libata.h

071f44b1d2c051 Tejun Heo       2008-04-07  1491  
c6cf72be22beb4 Hannes Reinecke 2021-12-21  1492  #define ata_port_printk(level, ap, fmt, ...)			\
c6cf72be22beb4 Hannes Reinecke 2021-12-21 @1493  	pr_ ## level ("ata%u: " fmt, (ap)->print_id, ##__VA_ARGS__)
a9a79dfec23956 Joe Perches     2011-04-15  1494  

:::::: The code at line 1493 was first introduced by commit
:::::: c6cf72be22beb4f0dfeedcf34ffc0926b2df61b5 libata: move ata_{port,link,dev}_dbg to standard pr_XXX() macros

:::::: TO: Hannes Reinecke <hare@suse.de>
:::::: CC: Damien Le Moal <damien.lemoal@opensource.wdc.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
