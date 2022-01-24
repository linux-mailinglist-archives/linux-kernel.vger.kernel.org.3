Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43B2497D9E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 12:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237207AbiAXLKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 06:10:40 -0500
Received: from mga06.intel.com ([134.134.136.31]:6738 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234207AbiAXLKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 06:10:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643022639; x=1674558639;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oHfUtK0fTKaKv4aGAdYSITCetidrA8+/vg8ChqXn3/g=;
  b=J9t2y25q/HYpigvJxSjoF4S0cDYjMTVK/iRdpDQ2hGTkOm9n2KuVu1Gd
   Of/IVYaUxKXVm/OwAQuy5opt3BnJnjGRpip7Qz/QYErJYHakfdWlVwXun
   mXd5/cur4Tfz6tgxJRV2veH5NOOCmXHUOOeEROTn79f9JRS1xFUcRHBua
   iaWKQ/i+U4S3TtEz1tUfjKlVWwjJB+ng8NLAPolUc5vyVW9rlNZvLAMRM
   x7Rp5MeE1PfUZ4HQh8DOCQk9dTDVQqXhFIDYtyjJS/0hZCyo/XsKy8Rnq
   S0KPMdKbmNKCJCmzW4znIJMMHM9Agpg+cGaxUrCLG9NOMxSBtXxxIhIuh
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="306736836"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="306736836"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 03:10:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="695386936"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 24 Jan 2022 03:10:37 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nBxF6-000IDw-KJ; Mon, 24 Jan 2022 11:10:36 +0000
Date:   Mon, 24 Jan 2022 19:10:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/cirrus/cs89x0.c:897:41: error: implicit
 declaration of function 'isa_virt_to_bus'; did you mean 'virt_to_bus'?
Message-ID: <202201241942.ipae4E4A-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dd81e1c7d5fb126e5fbc5c9e334d7b3ec29a16a0
commit: 47fd22f2b84765a2f7e3f150282497b902624547 cs89x0: rework driver configuration
date:   6 months ago
config: m68k-randconfig-r006-20220123 (https://download.01.org/0day-ci/archive/20220124/202201241942.ipae4E4A-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=47fd22f2b84765a2f7e3f150282497b902624547
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 47fd22f2b84765a2f7e3f150282497b902624547
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash drivers/net/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/printk.h:456,
                    from include/linux/kernel.h:19,
                    from include/linux/list.h:9,
                    from include/linux/module.h:12,
                    from drivers/net/ethernet/cirrus/cs89x0.c:51:
   drivers/net/ethernet/cirrus/cs89x0.c: In function 'net_open':
>> drivers/net/ethernet/cirrus/cs89x0.c:897:41: error: implicit declaration of function 'isa_virt_to_bus'; did you mean 'virt_to_bus'? [-Werror=implicit-function-declaration]
     897 |                          (unsigned long)isa_virt_to_bus(lp->dma_buff));
         |                                         ^~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:134:29: note: in definition of macro '__dynamic_func_call'
     134 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:162:9: note: in expansion of macro '_dynamic_func_call'
     162 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/printk.h:471:9: note: in expansion of macro 'dynamic_pr_debug'
     471 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~
   drivers/net/ethernet/cirrus/cs89x0.c:86:17: note: in expansion of macro 'pr_debug'
      86 |                 pr_##level(fmt, ##__VA_ARGS__);                 \
         |                 ^~~
   drivers/net/ethernet/cirrus/cs89x0.c:894:17: note: in expansion of macro 'cs89_dbg'
     894 |                 cs89_dbg(1, debug, "%s: dma %lx %lx\n",
         |                 ^~~~~~~~
   cc1: some warnings being treated as errors


vim +897 drivers/net/ethernet/cirrus/cs89x0.c

^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   825  
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   826  static int
6fba180ee8b1c8 drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   827  net_open(struct net_device *dev)
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   828  {
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   829  	struct net_local *lp = netdev_priv(dev);
6fba180ee8b1c8 drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   830  	int result = 0;
6fba180ee8b1c8 drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   831  	int i;
6fba180ee8b1c8 drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   832  	int ret;
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   833  
6fba180ee8b1c8 drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   834  	if (dev->irq < 2) {
6fba180ee8b1c8 drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   835  		/* Allow interrupts to be generated by the chip */
6fba180ee8b1c8 drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   836  /* Cirrus' release had this: */
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   837  #if 0
6fba180ee8b1c8 drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   838  		writereg(dev, PP_BusCTL, readreg(dev, PP_BusCTL) | ENABLE_IRQ);
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   839  #endif
6fba180ee8b1c8 drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   840  /* And 2.3.47 had this: */
6fba180ee8b1c8 drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   841  		writereg(dev, PP_BusCTL, ENABLE_IRQ | MEMORY_ON);
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   842  
6fba180ee8b1c8 drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   843  		for (i = 2; i < CS8920_NO_INTS; i++) {
6fba180ee8b1c8 drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   844  			if ((1 << i) & lp->irq_map) {
6fba180ee8b1c8 drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   845  				if (request_irq(i, net_interrupt, 0, dev->name,
6fba180ee8b1c8 drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   846  						dev) == 0) {
6fba180ee8b1c8 drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   847  					dev->irq = i;
6fba180ee8b1c8 drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   848  					write_irq(dev, lp->chip_type, i);
6fba180ee8b1c8 drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   849  					/* writereg(dev, PP_BufCFG, GENERATE_SW_INTERRUPT); */
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   850  					break;
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   851  				}
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   852  			}
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   853  		}
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   854  
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   855  		if (i >= CS8920_NO_INTS) {
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   856  			writereg(dev, PP_BusCTL, 0);	/* disable interrupts. */
dd92b9ade43907 drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   857  			pr_err("can't get an interrupt\n");
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   858  			ret = -EAGAIN;
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   859  			goto bad_out;
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   860  		}
ca034bcdb1786b drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   861  	} else {
47fd22f2b84765 drivers/net/ethernet/cirrus/cs89x0.c Arnd Bergmann  2021-08-03   862  #if IS_ENABLED(CONFIG_CS89x0_ISA)
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   863  		if (((1 << dev->irq) & lp->irq_map) == 0) {
dd92b9ade43907 drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   864  			pr_err("%s: IRQ %d is not in our map of allowable IRQs, which is %x\n",
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   865  			       dev->name, dev->irq, lp->irq_map);
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   866  			ret = -EAGAIN;
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   867  			goto bad_out;
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   868  		}
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   869  #endif
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   870  /* FIXME: Cirrus' release had this: */
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   871  		writereg(dev, PP_BusCTL, readreg(dev, PP_BusCTL)|ENABLE_IRQ);
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   872  /* And 2.3.47 had this: */
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   873  #if 0
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   874  		writereg(dev, PP_BusCTL, ENABLE_IRQ | MEMORY_ON);
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   875  #endif
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   876  		write_irq(dev, lp->chip_type, dev->irq);
a0607fd3a25ba1 drivers/net/cs89x0.c                 Joe Perches    2009-11-18   877  		ret = request_irq(dev->irq, net_interrupt, 0, dev->name, dev);
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   878  		if (ret) {
dd92b9ade43907 drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   879  			pr_err("request_irq(%d) failed\n", dev->irq);
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   880  			goto bad_out;
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   881  		}
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   882  	}
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   883  
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   884  #if ALLOW_DMA
ca034bcdb1786b drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   885  	if (lp->use_dma && (lp->isa_config & ANY_ISA_DMA)) {
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   886  		unsigned long flags;
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   887  		lp->dma_buff = (unsigned char *)__get_dma_pages(GFP_KERNEL,
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   888  								get_order(lp->dmasize * 1024));
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   889  		if (!lp->dma_buff) {
dd92b9ade43907 drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   890  			pr_err("%s: cannot get %dK memory for DMA\n",
dd92b9ade43907 drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   891  			       dev->name, lp->dmasize);
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   892  			goto release_irq;
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   893  		}
808e9a77358995 drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   894  		cs89_dbg(1, debug, "%s: dma %lx %lx\n",
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   895  			 dev->name,
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   896  			 (unsigned long)lp->dma_buff,
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16  @897  			 (unsigned long)isa_virt_to_bus(lp->dma_buff));
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   898  		if ((unsigned long)lp->dma_buff >= MAX_DMA_ADDRESS ||
ca034bcdb1786b drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   899  		    !dma_page_eq(lp->dma_buff,
ca034bcdb1786b drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   900  				 lp->dma_buff + lp->dmasize * 1024 - 1)) {
ca034bcdb1786b drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   901  			pr_err("%s: not usable as DMA buffer\n", dev->name);
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   902  			goto release_irq;
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   903  		}
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   904  		memset(lp->dma_buff, 0, lp->dmasize * 1024);	/* Why? */
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   905  		if (request_dma(dev->dma, dev->name)) {
dd92b9ade43907 drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   906  			pr_err("%s: cannot get dma channel %d\n",
dd92b9ade43907 drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   907  			       dev->name, dev->dma);
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   908  			goto release_irq;
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   909  		}
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   910  		write_dma(dev, lp->chip_type, dev->dma);
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   911  		lp->rx_dma_ptr = lp->dma_buff;
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   912  		lp->end_dma_buff = lp->dma_buff + lp->dmasize * 1024;
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   913  		spin_lock_irqsave(&lp->lock, flags);
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   914  		disable_dma(dev->dma);
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   915  		clear_dma_ff(dev->dma);
ef0657c49e0f93 drivers/net/cs89x0.c                 Julia Lawall   2009-07-06   916  		set_dma_mode(dev->dma, DMA_RX_MODE); /* auto_init as well */
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   917  		set_dma_addr(dev->dma, isa_virt_to_bus(lp->dma_buff));
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   918  		set_dma_count(dev->dma, lp->dmasize * 1024);
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   919  		enable_dma(dev->dma);
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   920  		spin_unlock_irqrestore(&lp->lock, flags);
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   921  	}
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   922  #endif	/* ALLOW_DMA */
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   923  
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   924  	/* set the Ethernet address */
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   925  	for (i = 0; i < ETH_ALEN / 2; i++)
ca034bcdb1786b drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   926  		writereg(dev, PP_IA + i * 2,
ca034bcdb1786b drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   927  			 (dev->dev_addr[i * 2] |
ca034bcdb1786b drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   928  			  (dev->dev_addr[i * 2 + 1] << 8)));
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   929  
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   930  	/* while we're testing the interface, leave interrupts disabled */
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   931  	writereg(dev, PP_BusCTL, MEMORY_ON);
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   932  
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   933  	/* Set the LineCTL quintuplet based on adapter configuration read from EEPROM */
ca034bcdb1786b drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   934  	if ((lp->adapter_cnf & A_CNF_EXTND_10B_2) &&
ca034bcdb1786b drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   935  	    (lp->adapter_cnf & A_CNF_LOW_RX_SQUELCH))
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   936  		lp->linectl = LOW_RX_SQUELCH;
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   937  	else
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   938  		lp->linectl = 0;
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   939  
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   940  	/* check to make sure that they have the "right" hardware available */
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   941  	switch (lp->adapter_cnf & A_CNF_MEDIA_TYPE) {
ca034bcdb1786b drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   942  	case A_CNF_MEDIA_10B_T:
ca034bcdb1786b drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   943  		result = lp->adapter_cnf & A_CNF_10B_T;
ca034bcdb1786b drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   944  		break;
ca034bcdb1786b drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   945  	case A_CNF_MEDIA_AUI:
ca034bcdb1786b drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   946  		result = lp->adapter_cnf & A_CNF_AUI;
ca034bcdb1786b drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   947  		break;
ca034bcdb1786b drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   948  	case A_CNF_MEDIA_10B_2:
ca034bcdb1786b drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   949  		result = lp->adapter_cnf & A_CNF_10B_2;
ca034bcdb1786b drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   950  		break;
ca034bcdb1786b drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   951  	default:
ca034bcdb1786b drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   952  		result = lp->adapter_cnf & (A_CNF_10B_T |
ca034bcdb1786b drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   953  					    A_CNF_AUI |
ca034bcdb1786b drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   954  					    A_CNF_10B_2);
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   955  	}
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   956  	if (!result) {
dd92b9ade43907 drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   957  		pr_err("%s: EEPROM is configured for unavailable media\n",
dd92b9ade43907 drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   958  		       dev->name);
17a9440f7deb78 drivers/net/cs89x0.c                 Wang Chen      2008-05-30   959  release_dma:
17a9440f7deb78 drivers/net/cs89x0.c                 Wang Chen      2008-05-30   960  #if ALLOW_DMA
17a9440f7deb78 drivers/net/cs89x0.c                 Wang Chen      2008-05-30   961  		free_dma(dev->dma);
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   962  release_irq:
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   963  		release_dma_buff(lp);
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   964  #endif
ca034bcdb1786b drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   965  		writereg(dev, PP_LineCTL,
ca034bcdb1786b drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   966  			 readreg(dev, PP_LineCTL) & ~(SERIAL_TX_ON | SERIAL_RX_ON));
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   967  		free_irq(dev->irq, dev);
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   968  		ret = -EAGAIN;
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   969  		goto bad_out;
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   970  	}
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   971  
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   972  	/* set the hardware to the configured choice */
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   973  	switch (lp->adapter_cnf & A_CNF_MEDIA_TYPE) {
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   974  	case A_CNF_MEDIA_10B_T:
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   975  		result = detect_tp(dev);
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   976  		if (result == DETECTED_NONE) {
dd92b9ade43907 drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   977  			pr_warn("%s: 10Base-T (RJ-45) has no cable\n",
dd92b9ade43907 drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   978  				dev->name);
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   979  			if (lp->auto_neg_cnf & IMM_BIT) /* check "ignore missing media" bit */
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   980  				result = DETECTED_RJ45H; /* Yes! I don't care if I see a link pulse */
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   981  		}
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   982  		break;
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   983  	case A_CNF_MEDIA_AUI:
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   984  		result = detect_aui(dev);
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   985  		if (result == DETECTED_NONE) {
dd92b9ade43907 drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   986  			pr_warn("%s: 10Base-5 (AUI) has no cable\n", dev->name);
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   987  			if (lp->auto_neg_cnf & IMM_BIT) /* check "ignore missing media" bit */
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   988  				result = DETECTED_AUI; /* Yes! I don't care if I see a carrrier */
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   989  		}
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   990  		break;
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   991  	case A_CNF_MEDIA_10B_2:
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   992  		result = detect_bnc(dev);
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   993  		if (result == DETECTED_NONE) {
dd92b9ade43907 drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18   994  			pr_warn("%s: 10Base-2 (BNC) has no cable\n", dev->name);
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   995  			if (lp->auto_neg_cnf & IMM_BIT) /* check "ignore missing media" bit */
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   996  				result = DETECTED_BNC; /* Yes! I don't care if I can xmit a packet */
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   997  		}
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   998  		break;
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16   999  	case A_CNF_MEDIA_AUTO:
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16  1000  		writereg(dev, PP_LineCTL, lp->linectl | AUTO_AUI_10BASET);
ca034bcdb1786b drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18  1001  		if (lp->adapter_cnf & A_CNF_10B_T) {
ca034bcdb1786b drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18  1002  			result = detect_tp(dev);
ca034bcdb1786b drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18  1003  			if (result != DETECTED_NONE)
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16  1004  				break;
ca034bcdb1786b drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18  1005  		}
ca034bcdb1786b drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18  1006  		if (lp->adapter_cnf & A_CNF_AUI) {
ca034bcdb1786b drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18  1007  			result = detect_aui(dev);
ca034bcdb1786b drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18  1008  			if (result != DETECTED_NONE)
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16  1009  				break;
ca034bcdb1786b drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18  1010  		}
ca034bcdb1786b drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18  1011  		if (lp->adapter_cnf & A_CNF_10B_2) {
ca034bcdb1786b drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18  1012  			result = detect_bnc(dev);
ca034bcdb1786b drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18  1013  			if (result != DETECTED_NONE)
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16  1014  				break;
ca034bcdb1786b drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18  1015  		}
dd92b9ade43907 drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18  1016  		pr_err("%s: no media detected\n", dev->name);
17a9440f7deb78 drivers/net/cs89x0.c                 Wang Chen      2008-05-30  1017  		goto release_dma;
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16  1018  	}
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16  1019  	switch (result) {
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16  1020  	case DETECTED_NONE:
dd92b9ade43907 drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18  1021  		pr_err("%s: no network cable attached to configured media\n",
dd92b9ade43907 drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18  1022  		       dev->name);
17a9440f7deb78 drivers/net/cs89x0.c                 Wang Chen      2008-05-30  1023  		goto release_dma;
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16  1024  	case DETECTED_RJ45H:
dd92b9ade43907 drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18  1025  		pr_info("%s: using half-duplex 10Base-T (RJ-45)\n", dev->name);
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16  1026  		break;
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16  1027  	case DETECTED_RJ45F:
dd92b9ade43907 drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18  1028  		pr_info("%s: using full-duplex 10Base-T (RJ-45)\n", dev->name);
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16  1029  		break;
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16  1030  	case DETECTED_AUI:
dd92b9ade43907 drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18  1031  		pr_info("%s: using 10Base-5 (AUI)\n", dev->name);
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16  1032  		break;
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16  1033  	case DETECTED_BNC:
dd92b9ade43907 drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18  1034  		pr_info("%s: using 10Base-2 (BNC)\n", dev->name);
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16  1035  		break;
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16  1036  	}
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16  1037  
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16  1038  	/* Turn on both receive and transmit operations */
ca034bcdb1786b drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18  1039  	writereg(dev, PP_LineCTL,
ca034bcdb1786b drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18  1040  		 readreg(dev, PP_LineCTL) | SERIAL_RX_ON | SERIAL_TX_ON);
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16  1041  
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16  1042  	/* Receive only error free packets addressed to this card */
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16  1043  	lp->rx_mode = 0;
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16  1044  	writereg(dev, PP_RxCTL, DEF_RX_ACCEPT);
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16  1045  
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16  1046  	lp->curr_rx_cfg = RX_OK_ENBL | RX_CRC_ERROR_ENBL;
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16  1047  
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16  1048  	if (lp->isa_config & STREAM_TRANSFER)
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16  1049  		lp->curr_rx_cfg |= RX_STREAM_ENBL;
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16  1050  #if ALLOW_DMA
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16  1051  	set_dma_cfg(dev);
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16  1052  #endif
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16  1053  	writereg(dev, PP_RxCFG, lp->curr_rx_cfg);
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16  1054  
ca034bcdb1786b drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18  1055  	writereg(dev, PP_TxCFG, (TX_LOST_CRS_ENBL |
ca034bcdb1786b drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18  1056  				 TX_SQE_ERROR_ENBL |
ca034bcdb1786b drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18  1057  				 TX_OK_ENBL |
ca034bcdb1786b drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18  1058  				 TX_LATE_COL_ENBL |
ca034bcdb1786b drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18  1059  				 TX_JBR_ENBL |
ca034bcdb1786b drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18  1060  				 TX_ANY_COL_ENBL |
ca034bcdb1786b drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18  1061  				 TX_16_COL_ENBL));
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16  1062  
ca034bcdb1786b drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18  1063  	writereg(dev, PP_BufCFG, (READY_FOR_TX_ENBL |
ca034bcdb1786b drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18  1064  				  RX_MISS_COUNT_OVRFLOW_ENBL |
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16  1065  #if ALLOW_DMA
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16  1066  				  dma_bufcfg(dev) |
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16  1067  #endif
ca034bcdb1786b drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18  1068  				  TX_COL_COUNT_OVRFLOW_ENBL |
ca034bcdb1786b drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18  1069  				  TX_UNDERRUN_ENBL));
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16  1070  
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16  1071  	/* now that we've got our act together, enable everything */
ca034bcdb1786b drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18  1072  	writereg(dev, PP_BusCTL, (ENABLE_IRQ
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16  1073  				  | (dev->mem_start ? MEMORY_ON : 0) /* turn memory on */
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16  1074  #if ALLOW_DMA
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16  1075  				  | dma_busctl(dev)
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16  1076  #endif
ca034bcdb1786b drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18  1077  			 ));
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16  1078  	netif_start_queue(dev);
808e9a77358995 drivers/net/ethernet/cirrus/cs89x0.c Joe Perches    2012-05-18  1079  	cs89_dbg(1, debug, "net_open() succeeded\n");
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16  1080  	return 0;
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16  1081  bad_out:
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16  1082  	return ret;
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16  1083  }
^1da177e4c3f41 drivers/net/cs89x0.c                 Linus Torvalds 2005-04-16  1084  

:::::: The code at line 897 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
