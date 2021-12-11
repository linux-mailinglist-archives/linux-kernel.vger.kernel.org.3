Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7560B4712F0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 09:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhLKIsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 03:48:37 -0500
Received: from mga05.intel.com ([192.55.52.43]:18088 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230046AbhLKIsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 03:48:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639212517; x=1670748517;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oFPy4UupFqT8jCF7pii+h9Z5feJjmfDrEoPug/ti/gE=;
  b=jAHmlXs4eXeKStO5eRu9ysMqNWPJYA5XRAo5ZZ1+Ul1ziKiJ5vhMUS9M
   qvp6FEu1Sj82fmiaQiGvvZbMdSKnh5emUDk7nKxRf9giGLZZKqrXjZVaD
   +kpUqnwl0zcKsy2UxfaG/as9PTqsMUQ2+vX1qhfN5Fx3d2Sm042MYFaBq
   4P7u3mO7eGNIIf4+dBYVqEKuHs1ZPTMJfmby3kbCMRLspDtcPRTwLFVaP
   y0SInKAGwLlFb2Bz1fXU0LiEiluWzcfGcZt4+2DC1unM5f5XwuA1vE16e
   aqHVA9zNab1AXolCnFC/PSv3L/q2hLKOeUnk8OVFMw/KBwAgMBUVMKGFe
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10194"; a="324787662"
X-IronPort-AV: E=Sophos;i="5.88,197,1635231600"; 
   d="scan'208";a="324787662"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2021 00:48:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,197,1635231600"; 
   d="scan'208";a="464001175"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 11 Dec 2021 00:48:35 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvy3W-0004N5-UY; Sat, 11 Dec 2021 08:48:34 +0000
Date:   Sat, 11 Dec 2021 16:47:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [chenxing:msc313_mainlining 66/73]
 drivers/irqchip/irq-msc313-pm-wakeup.c:132:9: warning: ignoring return value
 of 'request_irq' declared with attribute 'warn_unused_result'
Message-ID: <202112111641.E105jEr1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://github.com/linux-chenxing/linux.git msc313_mainlining
head:   5e3741656d3316ae3aad27aab949cf42b09a803e
commit: e864bf0c3324aa13e0efe2d1f4a7b92c797f92ba [66/73] irqchip: MStar wakeup intc
config: alpha-randconfig-r001-20211211 (https://download.01.org/0day-ci/archive/20211211/202112111641.E105jEr1-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/linux-chenxing/linux/commit/e864bf0c3324aa13e0efe2d1f4a7b92c797f92ba
        git remote add chenxing git://github.com/linux-chenxing/linux.git
        git fetch --no-tags chenxing msc313_mainlining
        git checkout e864bf0c3324aa13e0efe2d1f4a7b92c797f92ba
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash drivers/irqchip/ drivers/mtd/spi-nor/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/irqchip/irq-msc313-pm-wakeup.c: In function 'msc313_pm_wakeup_intc_of_init':
>> drivers/irqchip/irq-msc313-pm-wakeup.c:132:9: warning: ignoring return value of 'request_irq' declared with attribute 'warn_unused_result' [-Wunused-result]
     132 |         request_irq(irq, msc313_pm_wakeup_intc_chainedhandler, IRQF_SHARED,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     133 |                                 "pmsleep", domain);
         |                                 ~~~~~~~~~~~~~~~~~~


vim +132 drivers/irqchip/irq-msc313-pm-wakeup.c

    97	
    98	static int __init msc313_pm_wakeup_intc_of_init(struct device_node *node,
    99					   struct device_node *parent)
   100	{
   101		int ret = 0, irq;
   102		struct regmap *pmsleep;
   103		struct msc313_sleep_intc *intc;
   104		struct irq_domain *domain;
   105	
   106		irq = of_irq_get(node, 0);
   107		if (irq <= 0)
   108			return irq;
   109	
   110		pmsleep = syscon_regmap_lookup_by_phandle(node, "mstar,pmsleep");
   111		if (IS_ERR(pmsleep))
   112			return PTR_ERR(pmsleep);
   113	
   114		intc = kzalloc(sizeof(*intc), GFP_KERNEL);
   115		if (!intc)
   116			return -ENOMEM;
   117	
   118		intc->mask = regmap_field_alloc(pmsleep, field_mask);
   119		intc->type = regmap_field_alloc(pmsleep, field_type);
   120		intc->status = regmap_field_alloc(pmsleep, field_status);
   121	
   122		/* The masks survive deep sleep so clear them. */
   123		regmap_field_write(intc->mask, ~0);
   124	
   125		domain = irq_domain_add_linear(node, NUM_IRQ,
   126				&msc313_pm_wakeup_intc_domain_ops, intc);
   127		if (!domain) {
   128			ret = -ENOMEM;
   129			goto out_free;
   130		}
   131	
 > 132		request_irq(irq, msc313_pm_wakeup_intc_chainedhandler, IRQF_SHARED,
   133					"pmsleep", domain);
   134	
   135		return 0;
   136	
   137	out_free:
   138		kfree(intc);
   139		return ret;
   140	}
   141	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
