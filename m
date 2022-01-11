Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339C248A4E0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 02:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346182AbiAKBSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 20:18:40 -0500
Received: from mga02.intel.com ([134.134.136.20]:38140 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243319AbiAKBSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 20:18:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641863919; x=1673399919;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OKcoqAuTqG3PJ0a2unikEAGf2NNr+JOqEdT5YxOnB3M=;
  b=YhYko4Xe5ezfd8CIJUasu+79ANLlpay6CsOqwJ9Z2yCcNzwoSL1v4HHp
   g92TNKxwk3axJzZLxUvu5Y2IzS8BKSohm94fjDqKU2ernTeoC20BEpViV
   e+QZ3W4dJ+4fARsMcgziW6QDXQwhqKZgC3K+rwj0CR8OylOcilACUwcTc
   oL11GblMYQaMyh53KytRn680E5vZ+cXEKU9+kTsi5MZFhn2jRKDs87FR/
   NoOOVq16l9EjspFn3NtHNuOWQOrqDCGbDwP/vos/SMdgL4T0nYsSgzwKO
   3nxXJrP2tGUdbFbz0Val3Hg56P07BVzq4d1XOh/7eFxaGELhm5ROsaS8i
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="230716842"
X-IronPort-AV: E=Sophos;i="5.88,278,1635231600"; 
   d="scan'208";a="230716842"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 17:18:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,278,1635231600"; 
   d="scan'208";a="514897284"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 10 Jan 2022 17:18:18 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n75nm-0004AI-18; Tue, 11 Jan 2022 01:18:18 +0000
Date:   Tue, 11 Jan 2022 09:17:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Brazdil <dbrazdil@google.com>
Cc:     kbuild-all@lists.01.org, GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [ammarfaizi2-block:google/android/kernel/common/android13-5.15
 2562/2575] arch/arm64/kvm/iommu/s2mpu.c:129: warning: This comment starts
 with '/**', but isn't a kernel-doc comment. Refer
 Documentation/doc-guide/kernel-doc.rst
Message-ID: <202201110931.duyXOD4g-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android13-5.15
head:   d52e3e4473075ddf199c9ae763e747302d729468
commit: 4a75e1b060286edbc814df36ab6b314826d2dc5e [2562/2575] ANDROID: KVM: arm64: Implement IRQ handler for S2MPU faults
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220111/202201110931.duyXOD4g-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/4a75e1b060286edbc814df36ab6b314826d2dc5e
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android13-5.15
        git checkout 4a75e1b060286edbc814df36ab6b314826d2dc5e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kvm/iommu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm64/kvm/iommu/s2mpu.c:129: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Parse interrupt information from DT and if found, register IRQ handler.


vim +129 arch/arm64/kvm/iommu/s2mpu.c

   127	
   128	/**
 > 129	 * Parse interrupt information from DT and if found, register IRQ handler.
   130	 * This is considered optional and will not fail even if the initialization is
   131	 * unsuccessful. In that case the IRQ will remain masked.
   132	 */
   133	static void s2mpu_probe_irq(struct platform_device *pdev, void __iomem *kaddr)
   134	{
   135		struct s2mpu_irq_info *irq_info;
   136		int ret, irq;
   137	
   138		irq = platform_get_irq_optional(pdev, 0);
   139	
   140		if (irq == -ENXIO)
   141			return; /* No IRQ specified. */
   142	
   143		if (irq < 0) {
   144			/* IRQ specified but failed to parse. */
   145			dev_err(&pdev->dev, "failed to parse IRQ, IRQ not enabled");
   146			return;
   147		}
   148	
   149		irq_info = devm_kmalloc(&pdev->dev, sizeof(*irq_info), GFP_KERNEL);
   150		if (!irq_info)
   151			return;
   152	
   153		*irq_info = (struct s2mpu_irq_info){
   154			.dev = &pdev->dev,
   155			.va = kaddr,
   156		};
   157	
   158		ret = devm_request_irq(&pdev->dev, irq, s2mpu_irq_handler, 0,
   159				       dev_name(&pdev->dev), irq_info);
   160		if (ret) {
   161			dev_err(&pdev->dev, "failed to register IRQ, IRQ not enabled");
   162			return;
   163		}
   164	}
   165	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
