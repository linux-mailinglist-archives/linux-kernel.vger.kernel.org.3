Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2996B4824C2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 17:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhLaQTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 11:19:02 -0500
Received: from mga07.intel.com ([134.134.136.100]:10573 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229446AbhLaQTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 11:19:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640967541; x=1672503541;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BK1lAcaPQ2t2JifJ2coPsOwM6F6PRW295crshlBKwhk=;
  b=XjGTPYdE9TNa8bvOgqA4rR/fwc0TZyRDTAnjN0q7ivinc+Itn6JhXscA
   zClsnOAzfRLsqTYiKeWNj2Hp0d9bev17D8LIBtEX5LEoIiKR45etd1Z/C
   TDscDzRC7iTyZsAqa06X2s0yzLg9o5RhTjw/NaeAGphpu626Itj1LyMc5
   lNMmfGuCVYm1eGtKFuoQXQ5XPt6MZKdqoR5rVgWvNfo4wdZC+Nua7E5xG
   KljF9XUItkVPpjagYkWUxGTTqYc+Z307YR2RwyJwJlfP6SXOy6/rQmtz1
   iNwZ/UGYgnCYFiXjp99jgLyAs73grp+wcdrQSaEjGjufh1Ekb/yzpSC5D
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10213"; a="305185414"
X-IronPort-AV: E=Sophos;i="5.88,251,1635231600"; 
   d="scan'208";a="305185414"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2021 08:19:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,251,1635231600"; 
   d="scan'208";a="619667189"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 31 Dec 2021 08:18:59 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n3KcN-000BNv-4k; Fri, 31 Dec 2021 16:18:59 +0000
Date:   Sat, 1 Jan 2022 00:18:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [dlemoal-libata:for-5.17-logging 31/79]
 drivers/ata/sata_fsl.c:316:17: error: passing argument 2 of
 '__dynamic_dev_dbg' from incompatible pointer type
Message-ID: <202201010008.hPfgdpH7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata.git for-5.17-logging
head:   fc730a4198504b83666da816eea7cb582fd9ae01
commit: 8bb1beeb144d8284af32b98c9f46f58030b74ac2 [31/79] sata_fsl: move DPRINTK to ata debugging
config: powerpc64-randconfig-r036-20211231 (https://download.01.org/0day-ci/archive/20220101/202201010008.hPfgdpH7-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata.git/commit/?id=8bb1beeb144d8284af32b98c9f46f58030b74ac2
        git remote add dlemoal-libata git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata.git
        git fetch --no-tags dlemoal-libata for-5.17-logging
        git checkout 8bb1beeb144d8284af32b98c9f46f58030b74ac2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/printk.h:559,
                    from include/linux/kernel.h:20,
                    from drivers/ata/sata_fsl.c:13:
   drivers/ata/sata_fsl.c: In function 'fsl_sata_set_irq_coalescing':
>> drivers/ata/sata_fsl.c:316:17: error: passing argument 2 of '__dynamic_dev_dbg' from incompatible pointer type [-Werror=incompatible-pointer-types]
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
   In file included from include/linux/printk.h:559,
                    from include/linux/kernel.h:20,
                    from drivers/ata/sata_fsl.c:13:
   drivers/ata/sata_fsl.c: In function 'sata_fsl_init_controller':
   drivers/ata/sata_fsl.c:1361:22: error: 'ap' undeclared (first use in this function); did you mean 'up'?
    1361 |         ata_port_dbg(ap, "icc = 0x%x\n", ioread32(hcr_base + ICC));
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
   drivers/ata/sata_fsl.c:1361:9: note: in expansion of macro 'ata_port_dbg'
    1361 |         ata_port_dbg(ap, "icc = 0x%x\n", ioread32(hcr_base + ICC));
         |         ^~~~~~~~~~~~
   drivers/ata/sata_fsl.c:1361:22: note: each undeclared identifier is reported only once for each function it appears in
    1361 |         ata_port_dbg(ap, "icc = 0x%x\n", ioread32(hcr_base + ICC));
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


vim +/__dynamic_dev_dbg +316 drivers/ata/sata_fsl.c

   290	
   291	static void fsl_sata_set_irq_coalescing(struct ata_host *host,
   292			unsigned int count, unsigned int ticks)
   293	{
   294		struct sata_fsl_host_priv *host_priv = host->private_data;
   295		void __iomem *hcr_base = host_priv->hcr_base;
   296		unsigned long flags;
   297	
   298		if (count > ICC_MAX_INT_COUNT_THRESHOLD)
   299			count = ICC_MAX_INT_COUNT_THRESHOLD;
   300		else if (count < ICC_MIN_INT_COUNT_THRESHOLD)
   301			count = ICC_MIN_INT_COUNT_THRESHOLD;
   302	
   303		if (ticks > ICC_MAX_INT_TICKS_THRESHOLD)
   304			ticks = ICC_MAX_INT_TICKS_THRESHOLD;
   305		else if ((ICC_MIN_INT_TICKS_THRESHOLD == ticks) &&
   306				(count > ICC_MIN_INT_COUNT_THRESHOLD))
   307			ticks = ICC_SAFE_INT_TICKS;
   308	
   309		spin_lock_irqsave(&host->lock, flags);
   310		iowrite32((count << 24 | ticks), hcr_base + ICC);
   311	
   312		intr_coalescing_count = count;
   313		intr_coalescing_ticks = ticks;
   314		spin_unlock_irqrestore(&host->lock, flags);
   315	
 > 316		dev_dbg(&host->dev, "interrupt coalescing, count = 0x%x, ticks = %x\n",
   317				intr_coalescing_count, intr_coalescing_ticks);
   318		dev_dbg(&host->dev, "ICC register status: (hcr base: 0x%x) = 0x%x\n",
   319				hcr_base, ioread32(hcr_base + ICC));
   320	}
   321	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
