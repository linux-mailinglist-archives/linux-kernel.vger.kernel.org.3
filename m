Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B14AB483F8C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 11:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbiADKBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 05:01:07 -0500
Received: from mga04.intel.com ([192.55.52.120]:44306 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229779AbiADKBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 05:01:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641290466; x=1672826466;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xIUgqatUPuYifspp9DAu75NvWEx4AEcObXpKvRZoiSk=;
  b=FsZ1Dpt72ZEEmoaTh1k5EOFn2aICCQ/YTd1/VphxTcUtFmaIkRX8JtM+
   8utYnWD0VddU74BNVrmBllN0zIBPMPb2fUC0rnNdWRyn2zIwNgbBLiJdS
   FLzHBnK+rMgvgmOSadlF7lpFL0y0HJ39ccrkjUDiurYfiIOSPD+oY8fPF
   tSAAoC0tl22F2G7/d9QicVqv3oExAHV2VTaH2ufsauZXGbOjBZc9ODcM3
   JFREqZDDeWTLQHXqOkqZ0N2sFrgyMloZPLHii19cSLbcd7VySUUWORRBb
   X4ECj6qYj8ufQkc2eqF5tjdM2wWZzOF2RId8YtS5a3mBjaznsAleREnMA
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="241014769"
X-IronPort-AV: E=Sophos;i="5.88,260,1635231600"; 
   d="scan'208";a="241014769"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 02:00:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,260,1635231600"; 
   d="scan'208";a="472008525"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 04 Jan 2022 02:00:43 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n4gcV-000FBr-1k; Tue, 04 Jan 2022 10:00:43 +0000
Date:   Tue, 4 Jan 2022 17:59:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [chenxing:msc313_mainlining 66/86]
 drivers/irqchip/irq-msc313-pm-wakeup.c:132:9: warning: ignoring return value
 of 'request_irq' declared with attribute 'warn_unused_result'
Message-ID: <202201041740.4jmJEDh7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://github.com/linux-chenxing/linux.git msc313_mainlining
head:   2269f75a5b53b9a05d21d432ad75f5e41b344814
commit: 73b030d3e228a0412a9e13ae129032467467c31e [66/86] irqchip: MStar wakeup intc
config: h8300-buildonly-randconfig-r003-20220103 (https://download.01.org/0day-ci/archive/20220104/202201041740.4jmJEDh7-lkp@intel.com/config)
compiler: h8300-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/linux-chenxing/linux/commit/73b030d3e228a0412a9e13ae129032467467c31e
        git remote add chenxing git://github.com/linux-chenxing/linux.git
        git fetch --no-tags chenxing msc313_mainlining
        git checkout 73b030d3e228a0412a9e13ae129032467467c31e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=h8300 SHELL=/bin/bash drivers/clocksource/ drivers/irqchip/

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
