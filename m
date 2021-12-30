Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA7C9481E00
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 17:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241206AbhL3QPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 11:15:18 -0500
Received: from mga12.intel.com ([192.55.52.136]:22703 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239436AbhL3QPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 11:15:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640880914; x=1672416914;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aKbaO83kDU1JpFW7H8vQMdbx0qz0JoqZQ29w6/prqw4=;
  b=ObYGNPNdmFZBBO11/r7fWIdsnx6iUeiljrPswo3Ned3MGx9RbiFeavcO
   dK8t80vh0vzQRAk1QaLr5Jq+8GNieYbfsYAbL63MzMsNJoVW2W5dRAv/K
   Yez5nkA/ouhn2GKTClIXlA4F3XIaMe+T8yAf/9BHnRVZvCoRRBn/8jPFf
   uUmuc106soSM7U/VZrJviH+fHK7nCcrSpGDoO9szgdjA93i9fnfmQLYMY
   r1smaQnSraf9SmfYhm0G+FVAAB/WvQ9JaPRizfJoDbuUWQkwWCqsMfOvx
   tCqMDJ0rp7wO3245nHkw/I/+bGtIXF+1FrnZN9Pi23Oo6Y1wXxJKZBvlv
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10212"; a="221696040"
X-IronPort-AV: E=Sophos;i="5.88,248,1635231600"; 
   d="scan'208";a="221696040"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2021 08:15:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,248,1635231600"; 
   d="scan'208";a="510938653"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 30 Dec 2021 08:15:13 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2y5A-000AN4-Ai; Thu, 30 Dec 2021 16:15:12 +0000
Date:   Fri, 31 Dec 2021 00:14:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [dlemoal-libata:for-5.17-logging 59/79]
 drivers/ata/pata_atp867x.c:313:17: warning: cast from pointer to integer of
 different size
Message-ID: <202112310016.xsD8Sx2Y-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata.git for-5.17-logging
head:   7830f5151b3b153a04daec48653458c9a2db7b16
commit: 3b60e5b29fdcba235efeb62418b785c0d1ce4a99 [59/79] pata_atp867x: convert printk() calls
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20211231/202112310016.xsD8Sx2Y-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata.git/commit/?id=3b60e5b29fdcba235efeb62418b785c0d1ce4a99
        git remote add dlemoal-libata git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata.git
        git fetch --no-tags dlemoal-libata for-5.17-logging
        git checkout 3b60e5b29fdcba235efeb62418b785c0d1ce4a99
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash drivers/ata/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/printk.h:559,
                    from include/linux/kernel.h:20,
                    from drivers/ata/pata_atp867x.c:15:
   drivers/ata/pata_atp867x.c: In function 'atp867x_check_ports':
>> drivers/ata/pata_atp867x.c:313:17: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     313 |                 (unsigned long long)ioaddr->cmd_addr,
         |                 ^
   include/linux/dynamic_debug.h:134:29: note: in definition of macro '__dynamic_func_call'
     134 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:166:9: note: in expansion of macro '_dynamic_func_call'
     166 |         _dynamic_func_call(fmt,__dynamic_dev_dbg,               \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_dbg'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/libata.h:1452:9: note: in expansion of macro 'dev_dbg'
    1452 |         dev_dbg(&ap->tdev, "%s: " fmt, __func__, ##__VA_ARGS__)
         |         ^~~~~~~
   drivers/ata/pata_atp867x.c:293:9: note: in expansion of macro 'ata_port_dbg'
     293 |         ata_port_dbg(ap, "ATP867X: port[%d] addresses\n"
         |         ^~~~~~~~~~~~
   drivers/ata/pata_atp867x.c:314:17: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     314 |                 (unsigned long long)ATP867X_IO_PORTBASE(ap, port),
         |                 ^
   include/linux/dynamic_debug.h:134:29: note: in definition of macro '__dynamic_func_call'
     134 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:166:9: note: in expansion of macro '_dynamic_func_call'
     166 |         _dynamic_func_call(fmt,__dynamic_dev_dbg,               \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_dbg'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/libata.h:1452:9: note: in expansion of macro 'dev_dbg'
    1452 |         dev_dbg(&ap->tdev, "%s: " fmt, __func__, ##__VA_ARGS__)
         |         ^~~~~~~
   drivers/ata/pata_atp867x.c:293:9: note: in expansion of macro 'ata_port_dbg'
     293 |         ata_port_dbg(ap, "ATP867X: port[%d] addresses\n"
         |         ^~~~~~~~~~~~
   drivers/ata/pata_atp867x.c:315:17: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     315 |                 (unsigned long long)ioaddr->ctl_addr,
         |                 ^
   include/linux/dynamic_debug.h:134:29: note: in definition of macro '__dynamic_func_call'
     134 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:166:9: note: in expansion of macro '_dynamic_func_call'
     166 |         _dynamic_func_call(fmt,__dynamic_dev_dbg,               \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_dbg'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/libata.h:1452:9: note: in expansion of macro 'dev_dbg'
    1452 |         dev_dbg(&ap->tdev, "%s: " fmt, __func__, ##__VA_ARGS__)
         |         ^~~~~~~
   drivers/ata/pata_atp867x.c:293:9: note: in expansion of macro 'ata_port_dbg'
     293 |         ata_port_dbg(ap, "ATP867X: port[%d] addresses\n"
         |         ^~~~~~~~~~~~
   drivers/ata/pata_atp867x.c:316:17: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     316 |                 (unsigned long long)ATP867X_IO_ALTSTATUS(ap, port),
         |                 ^
   include/linux/dynamic_debug.h:134:29: note: in definition of macro '__dynamic_func_call'
     134 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:166:9: note: in expansion of macro '_dynamic_func_call'
     166 |         _dynamic_func_call(fmt,__dynamic_dev_dbg,               \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_dbg'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/libata.h:1452:9: note: in expansion of macro 'dev_dbg'
    1452 |         dev_dbg(&ap->tdev, "%s: " fmt, __func__, ##__VA_ARGS__)
         |         ^~~~~~~
   drivers/ata/pata_atp867x.c:293:9: note: in expansion of macro 'ata_port_dbg'
     293 |         ata_port_dbg(ap, "ATP867X: port[%d] addresses\n"
         |         ^~~~~~~~~~~~
   drivers/ata/pata_atp867x.c:317:17: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     317 |                 (unsigned long long)ioaddr->bmdma_addr,
         |                 ^
   include/linux/dynamic_debug.h:134:29: note: in definition of macro '__dynamic_func_call'
     134 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:166:9: note: in expansion of macro '_dynamic_func_call'
     166 |         _dynamic_func_call(fmt,__dynamic_dev_dbg,               \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_dbg'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/libata.h:1452:9: note: in expansion of macro 'dev_dbg'
    1452 |         dev_dbg(&ap->tdev, "%s: " fmt, __func__, ##__VA_ARGS__)
         |         ^~~~~~~
   drivers/ata/pata_atp867x.c:293:9: note: in expansion of macro 'ata_port_dbg'
     293 |         ata_port_dbg(ap, "ATP867X: port[%d] addresses\n"
         |         ^~~~~~~~~~~~
   drivers/ata/pata_atp867x.c:318:17: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     318 |                 (unsigned long long)ATP867X_IO_DMABASE(ap, port),
         |                 ^
   include/linux/dynamic_debug.h:134:29: note: in definition of macro '__dynamic_func_call'
     134 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:166:9: note: in expansion of macro '_dynamic_func_call'
     166 |         _dynamic_func_call(fmt,__dynamic_dev_dbg,               \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_dbg'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)


vim +313 drivers/ata/pata_atp867x.c

d15d6e6cc34056 John(Jung-Ik  Lee 2009-09-14  287) 
d15d6e6cc34056 John(Jung-Ik  Lee 2009-09-14  288) static void atp867x_check_ports(struct ata_port *ap, int port)
d15d6e6cc34056 John(Jung-Ik  Lee 2009-09-14  289) {
d15d6e6cc34056 John(Jung-Ik  Lee 2009-09-14  290) 	struct ata_ioports *ioaddr = &ap->ioaddr;
d15d6e6cc34056 John(Jung-Ik  Lee 2009-09-14  291) 	struct atp867x_priv *dp = ap->private_data;
d15d6e6cc34056 John(Jung-Ik  Lee 2009-09-14  292) 
3b60e5b29fdcba Hannes Reinecke   2021-12-21  293  	ata_port_dbg(ap, "ATP867X: port[%d] addresses\n"
d15d6e6cc34056 John(Jung-Ik  Lee 2009-09-14  294) 		"  cmd_addr	=0x%llx, 0x%llx\n"
d15d6e6cc34056 John(Jung-Ik  Lee 2009-09-14  295) 		"  ctl_addr	=0x%llx, 0x%llx\n"
d15d6e6cc34056 John(Jung-Ik  Lee 2009-09-14  296) 		"  bmdma_addr	=0x%llx, 0x%llx\n"
d15d6e6cc34056 John(Jung-Ik  Lee 2009-09-14  297) 		"  data_addr	=0x%llx\n"
d15d6e6cc34056 John(Jung-Ik  Lee 2009-09-14  298) 		"  error_addr	=0x%llx\n"
d15d6e6cc34056 John(Jung-Ik  Lee 2009-09-14  299) 		"  feature_addr	=0x%llx\n"
d15d6e6cc34056 John(Jung-Ik  Lee 2009-09-14  300) 		"  nsect_addr	=0x%llx\n"
d15d6e6cc34056 John(Jung-Ik  Lee 2009-09-14  301) 		"  lbal_addr	=0x%llx\n"
d15d6e6cc34056 John(Jung-Ik  Lee 2009-09-14  302) 		"  lbam_addr	=0x%llx\n"
d15d6e6cc34056 John(Jung-Ik  Lee 2009-09-14  303) 		"  lbah_addr	=0x%llx\n"
d15d6e6cc34056 John(Jung-Ik  Lee 2009-09-14  304) 		"  device_addr	=0x%llx\n"
d15d6e6cc34056 John(Jung-Ik  Lee 2009-09-14  305) 		"  status_addr	=0x%llx\n"
d15d6e6cc34056 John(Jung-Ik  Lee 2009-09-14  306) 		"  command_addr	=0x%llx\n"
d15d6e6cc34056 John(Jung-Ik  Lee 2009-09-14  307) 		"  dp->dma_mode	=0x%llx\n"
d15d6e6cc34056 John(Jung-Ik  Lee 2009-09-14  308) 		"  dp->mstr_piospd	=0x%llx\n"
d15d6e6cc34056 John(Jung-Ik  Lee 2009-09-14  309) 		"  dp->slave_piospd	=0x%llx\n"
d15d6e6cc34056 John(Jung-Ik  Lee 2009-09-14  310) 		"  dp->eightb_piospd	=0x%llx\n"
d15d6e6cc34056 John(Jung-Ik  Lee 2009-09-14  311) 		"  dp->pci66mhz		=0x%lx\n",
d15d6e6cc34056 John(Jung-Ik  Lee 2009-09-14  312) 		port,
d15d6e6cc34056 John(Jung-Ik  Lee 2009-09-14 @313) 		(unsigned long long)ioaddr->cmd_addr,
d15d6e6cc34056 John(Jung-Ik  Lee 2009-09-14  314) 		(unsigned long long)ATP867X_IO_PORTBASE(ap, port),
d15d6e6cc34056 John(Jung-Ik  Lee 2009-09-14  315) 		(unsigned long long)ioaddr->ctl_addr,
d15d6e6cc34056 John(Jung-Ik  Lee 2009-09-14  316) 		(unsigned long long)ATP867X_IO_ALTSTATUS(ap, port),
d15d6e6cc34056 John(Jung-Ik  Lee 2009-09-14  317) 		(unsigned long long)ioaddr->bmdma_addr,
d15d6e6cc34056 John(Jung-Ik  Lee 2009-09-14  318) 		(unsigned long long)ATP867X_IO_DMABASE(ap, port),
d15d6e6cc34056 John(Jung-Ik  Lee 2009-09-14  319) 		(unsigned long long)ioaddr->data_addr,
d15d6e6cc34056 John(Jung-Ik  Lee 2009-09-14  320) 		(unsigned long long)ioaddr->error_addr,
d15d6e6cc34056 John(Jung-Ik  Lee 2009-09-14  321) 		(unsigned long long)ioaddr->feature_addr,
d15d6e6cc34056 John(Jung-Ik  Lee 2009-09-14  322) 		(unsigned long long)ioaddr->nsect_addr,
d15d6e6cc34056 John(Jung-Ik  Lee 2009-09-14  323) 		(unsigned long long)ioaddr->lbal_addr,
d15d6e6cc34056 John(Jung-Ik  Lee 2009-09-14  324) 		(unsigned long long)ioaddr->lbam_addr,
d15d6e6cc34056 John(Jung-Ik  Lee 2009-09-14  325) 		(unsigned long long)ioaddr->lbah_addr,
d15d6e6cc34056 John(Jung-Ik  Lee 2009-09-14  326) 		(unsigned long long)ioaddr->device_addr,
d15d6e6cc34056 John(Jung-Ik  Lee 2009-09-14  327) 		(unsigned long long)ioaddr->status_addr,
d15d6e6cc34056 John(Jung-Ik  Lee 2009-09-14  328) 		(unsigned long long)ioaddr->command_addr,
d15d6e6cc34056 John(Jung-Ik  Lee 2009-09-14  329) 		(unsigned long long)dp->dma_mode,
d15d6e6cc34056 John(Jung-Ik  Lee 2009-09-14  330) 		(unsigned long long)dp->mstr_piospd,
d15d6e6cc34056 John(Jung-Ik  Lee 2009-09-14  331) 		(unsigned long long)dp->slave_piospd,
d15d6e6cc34056 John(Jung-Ik  Lee 2009-09-14  332) 		(unsigned long long)dp->eightb_piospd,
d15d6e6cc34056 John(Jung-Ik  Lee 2009-09-14  333) 		(unsigned long)dp->pci66mhz);
d15d6e6cc34056 John(Jung-Ik  Lee 2009-09-14  334) }
d15d6e6cc34056 John(Jung-Ik  Lee 2009-09-14  335) 

:::::: The code at line 313 was first introduced by commit
:::::: d15d6e6cc340566d53d953ffdec2c9e96816fa52 libata: Add pata_atp867x driver for Artop/Acard ATP867X controllers

:::::: TO: John(Jung-Ik) Lee <jilee@google.com>
:::::: CC: Jeff Garzik <jgarzik@redhat.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
