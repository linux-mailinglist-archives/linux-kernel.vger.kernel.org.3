Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD914742F1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 13:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbhLNMwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 07:52:11 -0500
Received: from mga05.intel.com ([192.55.52.43]:29075 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232332AbhLNMwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 07:52:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639486330; x=1671022330;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LhOCH6KCJMVbaBpDHKKj3GnByfkmhM3q0uSs05SfGP4=;
  b=jCLL9qDniF0sZ5XkaGdPocpRZr57f16/98RWke+nPjln/zf1psnHhYx2
   UYuCZZMJUU/K6VSEQvnPELa+o1IyvT0de1y+jn5xUBiAd6745RmOvoH4b
   tqKdbGoco8eHy9mJw4nl2Jp0b5yTYeaBlgwojxfcuA5q3NbaWpDJfgPFh
   SPb2rF+St/+sl4FISAQu7ouIlfsTxNFU6bG3b9nl9/B12CtoIX3Cwcrq+
   HCdEfpF/j0b+0zai6t9YJj9cKlvCU6U78L3RGaT7wnT8PEhRvVaZWyn1C
   Ejp5QCKgzZIubJSGbbDK9Ke9KtNLLeBLeFKesxmPjrQMXTK+v/S6cVx7z
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="325245456"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="325245456"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 04:52:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="505348409"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 14 Dec 2021 04:52:08 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mx7Hs-0000Jx-8F; Tue, 14 Dec 2021 12:52:08 +0000
Date:   Tue, 14 Dec 2021 20:51:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [chenxing:msc313_mainlining 66/78]
 drivers/irqchip/irq-msc313-pm-wakeup.c:132:2: warning: ignoring return value
 of function declared with 'warn_unused_result' attribute
Message-ID: <202112142011.TrAzr38n-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://github.com/linux-chenxing/linux.git msc313_mainlining
head:   04c62a6ed8b1b9034464e903809c8b6a9354bf6e
commit: ef6b5b20ff3e51fa6026bc510f66980c5107698c [66/78] irqchip: MStar wakeup intc
config: hexagon-buildonly-randconfig-r002-20211214 (https://download.01.org/0day-ci/archive/20211214/202112142011.TrAzr38n-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project b6a2ddb6c8ac29412b1361810972e15221fa021c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/linux-chenxing/linux/commit/ef6b5b20ff3e51fa6026bc510f66980c5107698c
        git remote add chenxing git://github.com/linux-chenxing/linux.git
        git fetch --no-tags chenxing msc313_mainlining
        git checkout ef6b5b20ff3e51fa6026bc510f66980c5107698c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/clocksource/ drivers/irqchip/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/irqchip/irq-msc313-pm-wakeup.c:132:2: warning: ignoring return value of function declared with 'warn_unused_result' attribute [-Wunused-result]
           request_irq(irq, msc313_pm_wakeup_intc_chainedhandler, IRQF_SHARED,
           ^~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +/warn_unused_result +132 drivers/irqchip/irq-msc313-pm-wakeup.c

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
