Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACD34C1324
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 13:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240592AbiBWMtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 07:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233079AbiBWMtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 07:49:00 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B074A66C3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 04:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645620512; x=1677156512;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JnOgbhTQn0zJGJFf0Si3A4r7rgf3FSnREvr4CnkwPwo=;
  b=OlCtPZU95YSP7vOyPlhHP0FEwvHq9JhNKHmMy5h1+LnBX/5QqdFqMH/5
   Nj6vCA1jHeXEpujo42qzG0yDtAzNkZt3XC+CNO2374d2w/q7cO6ZyVi3k
   VSnTjaw+TwB+ru2UebfuwZUmLwfEC7X95k5vlIPjOTrPjd4VyvxFDUXFF
   WS0t+Nc82nZJqNzx4F7d4HD68p7zcYnZ4iNVdP495hT4CdXOWnvgM+hFw
   9wwi3KSXXKTqVMXJk80bIoJzBDhdjhLu49zo+4xrw51Go9WLCNr4lYwI9
   Nq5cbE/JgIi3qbrAFu52xFTxPU0dlUv/wQkYpUL6/EiCUeqlUKLYIKzS2
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="251872995"
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="251872995"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 04:48:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="628069766"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Feb 2022 04:48:30 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMr4I-0001Po-2W; Wed, 23 Feb 2022 12:48:30 +0000
Date:   Wed, 23 Feb 2022 20:48:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [chenxing:msc313_mainlining 62/93]
 drivers/irqchip/irq-msc313-pm-wakeup.c:132:9: warning: ignoring return value
 of 'request_irq' declared with attribute 'warn_unused_result'
Message-ID: <202202232019.xWajHWPV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://github.com/linux-chenxing/linux.git msc313_mainlining
head:   99a396728dcff78ca3eddcbd2085f11eeb8a01b8
commit: 10f8a601bff9d43fdf11deba38af93f47faa1ea2 [62/93] irqchip: MStar wakeup intc
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220223/202202232019.xWajHWPV-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/linux-chenxing/linux/commit/10f8a601bff9d43fdf11deba38af93f47faa1ea2
        git remote add chenxing git://github.com/linux-chenxing/linux.git
        git fetch --no-tags chenxing msc313_mainlining
        git checkout 10f8a601bff9d43fdf11deba38af93f47faa1ea2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash drivers/irqchip/

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
   118		intc->mask = regmap_field_alloc(pmsleep, mask_field);
   119		intc->type = regmap_field_alloc(pmsleep, type_field);
   120		intc->status = regmap_field_alloc(pmsleep, status_field);
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
