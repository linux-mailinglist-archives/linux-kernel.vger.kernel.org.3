Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC34A46D174
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 11:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbhLHLCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 06:02:15 -0500
Received: from mga14.intel.com ([192.55.52.115]:64341 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhLHLCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 06:02:14 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="238034791"
X-IronPort-AV: E=Sophos;i="5.87,297,1631602800"; 
   d="scan'208";a="238034791"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 02:58:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,297,1631602800"; 
   d="scan'208";a="564033161"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 08 Dec 2021 02:58:40 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muuem-0000RW-44; Wed, 08 Dec 2021 10:58:40 +0000
Date:   Wed, 8 Dec 2021 18:58:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [dlemoal-libata:ata-msg 34/61] drivers/ata/sata_fsl.c:318:29:
 warning: format '%x' expects argument of type 'unsigned int', but argument 4
 has type 'void *'
Message-ID: <202112081807.hUOrVSCI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata.git ata-msg
head:   7d6ff0ace26c7e7f01d532d244de0b9811765f47
commit: efab2a8f108886fa8d2d0108941bb1ccb36f8526 [34/61] sata_fsl: move DPRINTK to ata debugging
config: powerpc-mpc837x_rdb_defconfig (https://download.01.org/0day-ci/archive/20211208/202112081807.hUOrVSCI-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata.git/commit/?id=efab2a8f108886fa8d2d0108941bb1ccb36f8526
        git remote add dlemoal-libata git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata.git
        git fetch --no-tags dlemoal-libata ata-msg
        git checkout efab2a8f108886fa8d2d0108941bb1ccb36f8526
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/ata/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/platform_device.h:13,
                    from drivers/ata/sata_fsl.c:15:
   drivers/ata/sata_fsl.c: In function 'fsl_sata_set_irq_coalescing':
   drivers/ata/sata_fsl.c:316:17: error: passing argument 2 of '_dev_printk' from incompatible pointer type [-Werror=incompatible-pointer-types]
     316 |         dev_dbg(&host->dev, "interrupt coalescing, count = 0x%x, ticks = %x\n",
         |                 ^~~~~~~~~~
         |                 |
         |                 struct device **
   include/linux/dev_printk.h:129:36: note: in definition of macro 'dev_printk'
     129 |                 _dev_printk(level, dev, fmt, ##__VA_ARGS__);            \
         |                                    ^~~
   drivers/ata/sata_fsl.c:316:9: note: in expansion of macro 'dev_dbg'
     316 |         dev_dbg(&host->dev, "interrupt coalescing, count = 0x%x, ticks = %x\n",
         |         ^~~~~~~
   include/linux/dev_printk.h:41:58: note: expected 'const struct device *' but argument is of type 'struct device **'
      41 | void _dev_printk(const char *level, const struct device *dev,
         |                                     ~~~~~~~~~~~~~~~~~~~~~^~~
   drivers/ata/sata_fsl.c:318:17: error: passing argument 2 of '_dev_printk' from incompatible pointer type [-Werror=incompatible-pointer-types]
     318 |         dev_dbg(&host->dev, "ICC register status: (hcr base: 0x%x) = 0x%x\n",
         |                 ^~~~~~~~~~
         |                 |
         |                 struct device **
   include/linux/dev_printk.h:129:36: note: in definition of macro 'dev_printk'
     129 |                 _dev_printk(level, dev, fmt, ##__VA_ARGS__);            \
         |                                    ^~~
   drivers/ata/sata_fsl.c:318:9: note: in expansion of macro 'dev_dbg'
     318 |         dev_dbg(&host->dev, "ICC register status: (hcr base: 0x%x) = 0x%x\n",
         |         ^~~~~~~
   include/linux/dev_printk.h:41:58: note: expected 'const struct device *' but argument is of type 'struct device **'
      41 | void _dev_printk(const char *level, const struct device *dev,
         |                                     ~~~~~~~~~~~~~~~~~~~~~^~~
>> drivers/ata/sata_fsl.c:318:29: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'void *' [-Wformat=]
     318 |         dev_dbg(&host->dev, "ICC register status: (hcr base: 0x%x) = 0x%x\n",
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:129:41: note: in definition of macro 'dev_printk'
     129 |                 _dev_printk(level, dev, fmt, ##__VA_ARGS__);            \
         |                                         ^~~
   include/linux/dev_printk.h:163:45: note: in expansion of macro 'dev_fmt'
     163 |                 dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
         |                                             ^~~~~~~
   drivers/ata/sata_fsl.c:318:9: note: in expansion of macro 'dev_dbg'
     318 |         dev_dbg(&host->dev, "ICC register status: (hcr base: 0x%x) = 0x%x\n",
         |         ^~~~~~~
   drivers/ata/sata_fsl.c:318:65: note: format string is defined here
     318 |         dev_dbg(&host->dev, "ICC register status: (hcr base: 0x%x) = 0x%x\n",
         |                                                                ~^
         |                                                                 |
         |                                                                 unsigned int
         |                                                                %p
   In file included from include/linux/device.h:15,
                    from include/linux/platform_device.h:13,
                    from drivers/ata/sata_fsl.c:15:
   drivers/ata/sata_fsl.c: In function 'sata_fsl_init_controller':
   drivers/ata/sata_fsl.c:1361:22: error: 'ap' undeclared (first use in this function); did you mean 'up'?
    1361 |         ata_port_dbg(ap, "icc = 0x%x\n", ioread32(hcr_base + ICC));
         |                      ^~
   include/linux/dev_printk.h:129:36: note: in definition of macro 'dev_printk'
     129 |                 _dev_printk(level, dev, fmt, ##__VA_ARGS__);            \
         |                                    ^~~
   include/linux/libata.h:1502:9: note: in expansion of macro 'dev_dbg'
    1502 |         dev_dbg(&ap->tdev, "%s: " fmt, __func__, ##__VA_ARGS__)
         |         ^~~~~~~
   drivers/ata/sata_fsl.c:1361:9: note: in expansion of macro 'ata_port_dbg'
    1361 |         ata_port_dbg(ap, "icc = 0x%x\n", ioread32(hcr_base + ICC));
         |         ^~~~~~~~~~~~
   drivers/ata/sata_fsl.c:1361:22: note: each undeclared identifier is reported only once for each function it appears in
    1361 |         ata_port_dbg(ap, "icc = 0x%x\n", ioread32(hcr_base + ICC));
         |                      ^~
   include/linux/dev_printk.h:129:36: note: in definition of macro 'dev_printk'
     129 |                 _dev_printk(level, dev, fmt, ##__VA_ARGS__);            \
         |                                    ^~~
   include/linux/libata.h:1502:9: note: in expansion of macro 'dev_dbg'
    1502 |         dev_dbg(&ap->tdev, "%s: " fmt, __func__, ##__VA_ARGS__)
         |         ^~~~~~~
   drivers/ata/sata_fsl.c:1361:9: note: in expansion of macro 'ata_port_dbg'
    1361 |         ata_port_dbg(ap, "icc = 0x%x\n", ioread32(hcr_base + ICC));
         |         ^~~~~~~~~~~~
   drivers/ata/sata_fsl.c: At top level:
   drivers/ata/sata_fsl.c:1399:22: warning: initialized field overwritten [-Woverride-init]
    1399 |         .can_queue = SATA_FSL_QUEUE_DEPTH,
         |                      ^~~~~~~~~~~~~~~~~~~~
   drivers/ata/sata_fsl.c:1399:22: note: (near initialization for 'sata_fsl_sht.can_queue')
   In file included from include/linux/device.h:15,
                    from include/linux/platform_device.h:13,
                    from drivers/ata/sata_fsl.c:15:
   drivers/ata/sata_fsl.c: In function 'sata_fsl_probe':
   drivers/ata/sata_fsl.c:1470:22: error: 'ap' undeclared (first use in this function); did you mean 'up'?
    1470 |         ata_port_dbg(ap, "@reset i/o = 0x%x\n", ioread32(csr_base + TRANSCFG));
         |                      ^~
   include/linux/dev_printk.h:129:36: note: in definition of macro 'dev_printk'
     129 |                 _dev_printk(level, dev, fmt, ##__VA_ARGS__);            \
         |                                    ^~~
   include/linux/libata.h:1502:9: note: in expansion of macro 'dev_dbg'
    1502 |         dev_dbg(&ap->tdev, "%s: " fmt, __func__, ##__VA_ARGS__)
         |         ^~~~~~~
   drivers/ata/sata_fsl.c:1470:9: note: in expansion of macro 'ata_port_dbg'
    1470 |         ata_port_dbg(ap, "@reset i/o = 0x%x\n", ioread32(csr_base + TRANSCFG));
         |         ^~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +318 drivers/ata/sata_fsl.c

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
   316		dev_dbg(&host->dev, "interrupt coalescing, count = 0x%x, ticks = %x\n",
   317				intr_coalescing_count, intr_coalescing_ticks);
 > 318		dev_dbg(&host->dev, "ICC register status: (hcr base: 0x%x) = 0x%x\n",
   319				hcr_base, ioread32(hcr_base + ICC));
   320	}
   321	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
