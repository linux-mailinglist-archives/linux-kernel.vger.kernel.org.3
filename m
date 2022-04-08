Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E4D4F9FDA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 01:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235922AbiDHXG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 19:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiDHXG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 19:06:56 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5F7252
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 16:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649459091; x=1680995091;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MCrpFimKT99fCh/iU640v0eBtLj2dSvpLXHTgk0UqvM=;
  b=lWOrRx1h+6OeGXckLOrZZHGFHKssbhfG9fnlPgUcH1C960H/B7mjxwhn
   ur3DKVqe+DMURSHAtKOaqVuZ7ybfZxsqWMW5G4TrrCdFUspURCDmUTWL3
   SyGnuC5BlOUkuj2hqtih2dvs6lFGi41dG4NbZ6vQ2ThyU8fZX9u2Kr/pg
   s5zuR2VA4vMZqHSP1DV1MYGdb7N49Dmsgajz4wRDdhDZyYGCfjHO2QbYe
   DFJ8Y6sk98wwAcbhOBf6hjWSxihl/ynbYobPBB4046E/YxH3VwsE7sJi5
   lnc3tLLhVGW6n/rGQ2bb84rOChUJOoNQfhcIYlriQk874zuX2mo2klRLc
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="259313833"
X-IronPort-AV: E=Sophos;i="5.90,246,1643702400"; 
   d="scan'208";a="259313833"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 16:04:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,246,1643702400"; 
   d="scan'208";a="621829847"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 08 Apr 2022 16:04:49 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncxer-0000hF-3Z;
        Fri, 08 Apr 2022 23:04:49 +0000
Date:   Sat, 9 Apr 2022 07:03:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Phil Elwell <phil@raspberrypi.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dom Cobley <popcornmix@gmail.com>
Subject: [l1k:smsc95xx_5.17 95/888] drivers/irqchip/irq-bcm2835.c:204:22:
 warning: variable 'last_irq' set but not used
Message-ID: <202204090628.LCLaLqKj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/l1k/linux smsc95xx_5.17
head:   240f56c27361c195cd502d95aba51c6b8e5b808c
commit: d721ee482d0edde5df2ddd15556b1e2754bdc5c0 [95/888] irqchip: irq-bcm2835: Calc. FIQ_START at boot-time
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20220409/202204090628.LCLaLqKj-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/l1k/linux/commit/d721ee482d0edde5df2ddd15556b1e2754bdc5c0
        git remote add l1k https://github.com/l1k/linux
        git fetch --no-tags l1k smsc95xx_5.17
        git checkout d721ee482d0edde5df2ddd15556b1e2754bdc5c0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/irqchip/irq-bcm2835.c: In function 'armctrl_of_init':
>> drivers/irqchip/irq-bcm2835.c:204:22: warning: variable 'last_irq' set but not used [-Wunused-but-set-variable]
     204 |         int irq = 0, last_irq, b, i;
         |                      ^~~~~~~~


vim +/last_irq +204 drivers/irqchip/irq-bcm2835.c

   198	
   199	static int __init armctrl_of_init(struct device_node *node,
   200					  struct device_node *parent,
   201					  bool is_2836)
   202	{
   203		void __iomem *base;
 > 204		int irq = 0, last_irq, b, i;
   205		u32 reg;
   206	
   207		base = of_iomap(node, 0);
   208		if (!base)
   209			panic("%pOF: unable to map IC registers\n", node);
   210	
   211		intc.base = base;
   212		intc.domain = irq_domain_add_linear(node, NUMBER_IRQS * 2,
   213						    &armctrl_ops, NULL);
   214		if (!intc.domain)
   215			panic("%pOF: unable to create IRQ domain\n", node);
   216	
   217		for (b = 0; b < NR_BANKS; b++) {
   218			intc.pending[b] = base + reg_pending[b];
   219			intc.enable[b] = base + reg_enable[b];
   220			intc.disable[b] = base + reg_disable[b];
   221	
   222			for (i = 0; i < bank_irqs[b]; i++) {
   223				irq = irq_create_mapping(intc.domain, MAKE_HWIRQ(b, i));
   224				BUG_ON(irq <= 0);
   225				irq_set_chip_and_handler(irq, &armctrl_chip,
   226					handle_level_irq);
   227				irq_set_probe(irq);
   228			}
   229	
   230			reg = readl_relaxed(intc.enable[b]);
   231			if (reg) {
   232				writel_relaxed(reg, intc.disable[b]);
   233				pr_err(FW_BUG "Bootloader left irq enabled: "
   234				       "bank %d irq %*pbl\n", b, IRQS_PER_BANK, &reg);
   235			}
   236		}
   237	
   238		reg = readl_relaxed(base + REG_FIQ_CONTROL);
   239		if (reg & FIQ_CONTROL_ENABLE) {
   240			writel_relaxed(0, base + REG_FIQ_CONTROL);
   241			pr_err(FW_BUG "Bootloader left fiq enabled\n");
   242		}
   243	
   244		last_irq = irq;
   245	
   246		if (is_2836) {
   247			int parent_irq = irq_of_parse_and_map(node, 0);
   248	
   249			if (!parent_irq) {
   250				panic("%pOF: unable to get parent interrupt.\n",
   251				      node);
   252			}
   253			irq_set_chained_handler(parent_irq, bcm2836_chained_handle_irq);
   254		} else {
   255			set_handle_irq(bcm2835_handle_irq);
   256		}
   257	
   258		if (is_2836) {
   259			extern void __iomem * __attribute__((weak)) arm_local_intc;
   260			intc.local_base = arm_local_intc;
   261			if (!intc.local_base)
   262				pr_err("Failed to get local intc base. FIQ is disabled for cpus > 1\n");
   263		}
   264	
   265		/* Make a duplicate irq range which is used to enable FIQ */
   266		for (b = 0; b < NR_BANKS; b++) {
   267			for (i = 0; i < bank_irqs[b]; i++) {
   268				irq = irq_create_mapping(intc.domain,
   269						MAKE_HWIRQ(b, i) + NUMBER_IRQS);
   270				BUG_ON(irq <= 0);
   271				irq_set_chip(irq, &armctrl_chip);
   272				irq_set_probe(irq);
   273			}
   274		}
   275	#ifndef CONFIG_ARM64
   276		init_FIQ(irq - last_irq);
   277	#endif
   278	
   279		return 0;
   280	}
   281	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
