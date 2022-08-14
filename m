Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF53591FA3
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 13:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbiHNLhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 07:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiHNLg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 07:36:59 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB41B20BD8
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 04:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660477017; x=1692013017;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1F1pmWMVFdi7IchfIlr5r8dHEjmuFaqe2OXHVPvemiw=;
  b=PIZ9QWOe/DWgLgSfUEXbDkQXEXS8va+ISKEo7A8jUUYeH8f6iuK8nk+h
   mIoLiKFw2tFq4rhdMMzv2ODXFqs59g0/fYPalu4Cq9tjdZY6tO1C80Upo
   L8YAsjfgsVDAfQklMkmYvdUaIBt+iVDwp16lI557Dta3PAM74eqmo8S0z
   w4D2rdefABGy0XE8SVCi8q76FDr2pNhOIXfJ+x8BA5eYo96NVEOKOcsxg
   HkcABc95EMZixwS8h4p2MNuKyPOP8OvGP88duQWWKa1WNf7swyun2HN/E
   G4xhbdGwuvi/R2LXOXE3q8SGOOd3WRQJzGApdMcZ1fBYUH/Ay6pW9O67Y
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="353560498"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="353560498"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 04:36:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="934199003"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 14 Aug 2022 04:36:56 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNBvL-00002V-1d;
        Sun, 14 Aug 2022 11:36:55 +0000
Date:   Sun, 14 Aug 2022 19:36:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/arm/mach-imx/pm-imx6.c:513:9: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202208141937.OgkglzhI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   aea23e7c464bfdec04b52cf61edb62030e9e0d0a
commit: 28e77cc1c0686621a4d416f599cee5ab369daa0a fortify: Detect struct member overflows in memset() at compile-time
date:   6 months ago
config: arm-randconfig-s031-20220810 (https://download.01.org/0day-ci/archive/20220814/202208141937.OgkglzhI-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=28e77cc1c0686621a4d416f599cee5ab369daa0a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 28e77cc1c0686621a4d416f599cee5ab369daa0a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   arch/arm/mach-imx/pm-imx6.c:373:24: sparse: sparse: cast removes address space '__iomem' of expression
>> arch/arm/mach-imx/pm-imx6.c:513:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *static [assigned] [toplevel] suspend_ocram_base @@
   arch/arm/mach-imx/pm-imx6.c:513:9: sparse:     expected void const *
   arch/arm/mach-imx/pm-imx6.c:513:9: sparse:     got void [noderef] __iomem *static [assigned] [toplevel] suspend_ocram_base
>> arch/arm/mach-imx/pm-imx6.c:513:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *static [assigned] [toplevel] suspend_ocram_base @@
   arch/arm/mach-imx/pm-imx6.c:513:9: sparse:     expected void const *
   arch/arm/mach-imx/pm-imx6.c:513:9: sparse:     got void [noderef] __iomem *static [assigned] [toplevel] suspend_ocram_base
   arch/arm/mach-imx/pm-imx6.c:513:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *static [assigned] [toplevel] suspend_ocram_base @@
   arch/arm/mach-imx/pm-imx6.c:513:9: sparse:     expected void *
   arch/arm/mach-imx/pm-imx6.c:513:9: sparse:     got void [noderef] __iomem *static [assigned] [toplevel] suspend_ocram_base
   arch/arm/mach-imx/pm-imx6.c:514:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct imx6_cpu_pm_info *pm_info @@     got void [noderef] __iomem *static [assigned] [toplevel] suspend_ocram_base @@
   arch/arm/mach-imx/pm-imx6.c:514:17: sparse:     expected struct imx6_cpu_pm_info *pm_info
   arch/arm/mach-imx/pm-imx6.c:514:17: sparse:     got void [noderef] __iomem *static [assigned] [toplevel] suspend_ocram_base
   arch/arm/mach-imx/pm-imx6.c:570:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem * @@
   arch/arm/mach-imx/pm-imx6.c:570:36: sparse:     expected void const *
   arch/arm/mach-imx/pm-imx6.c:570:36: sparse:     got void [noderef] __iomem *
   arch/arm/mach-imx/pm-imx6.c:570:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem * @@
   arch/arm/mach-imx/pm-imx6.c:570:36: sparse:     expected void const *
   arch/arm/mach-imx/pm-imx6.c:570:36: sparse:     got void [noderef] __iomem *
   arch/arm/mach-imx/pm-imx6.c:570:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/arm/mach-imx/pm-imx6.c:570:36: sparse:     expected void *
   arch/arm/mach-imx/pm-imx6.c:570:36: sparse:     got void [noderef] __iomem *

vim +513 arch/arm/mach-imx/pm-imx6.c

df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  462  
afc51f4643063c arch/arm/mach-imx/pm-imx6q.c Shawn Guo              2014-02-26  463  static int __init imx6q_suspend_init(const struct imx6_pm_socdata *socdata)
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  464  {
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  465  	phys_addr_t ocram_pbase;
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  466  	struct device_node *node;
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  467  	struct platform_device *pdev;
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  468  	struct imx6_cpu_pm_info *pm_info;
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  469  	struct gen_pool *ocram_pool;
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  470  	unsigned long ocram_base;
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  471  	int i, ret = 0;
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  472  	const u32 *mmdc_offset_array;
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  473  
afc51f4643063c arch/arm/mach-imx/pm-imx6q.c Shawn Guo              2014-02-26  474  	suspend_set_ops(&imx6q_pm_ops);
afc51f4643063c arch/arm/mach-imx/pm-imx6q.c Shawn Guo              2014-02-26  475  
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  476  	if (!socdata) {
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  477  		pr_warn("%s: invalid argument!\n", __func__);
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  478  		return -EINVAL;
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  479  	}
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  480  
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  481  	node = of_find_compatible_node(NULL, NULL, "mmio-sram");
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  482  	if (!node) {
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  483  		pr_warn("%s: failed to find ocram node!\n", __func__);
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  484  		return -ENODEV;
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  485  	}
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  486  
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  487  	pdev = of_find_device_by_node(node);
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  488  	if (!pdev) {
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  489  		pr_warn("%s: failed to find ocram device!\n", __func__);
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  490  		ret = -ENODEV;
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  491  		goto put_node;
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  492  	}
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  493  
73858173593c31 arch/arm/mach-imx/pm-imx6.c  Vladimir Zapolskiy     2015-09-04  494  	ocram_pool = gen_pool_get(&pdev->dev, NULL);
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  495  	if (!ocram_pool) {
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  496  		pr_warn("%s: ocram pool unavailable!\n", __func__);
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  497  		ret = -ENODEV;
4845446036fc9c arch/arm/mach-imx/pm-imx6.c  yu kuai                2020-06-04  498  		goto put_device;
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  499  	}
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  500  
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  501  	ocram_base = gen_pool_alloc(ocram_pool, MX6Q_SUSPEND_OCRAM_SIZE);
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  502  	if (!ocram_base) {
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  503  		pr_warn("%s: unable to alloc ocram!\n", __func__);
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  504  		ret = -ENOMEM;
4845446036fc9c arch/arm/mach-imx/pm-imx6.c  yu kuai                2020-06-04  505  		goto put_device;
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  506  	}
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  507  
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  508  	ocram_pbase = gen_pool_virt_to_phys(ocram_pool, ocram_base);
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  509  
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  510  	suspend_ocram_base = __arm_ioremap_exec(ocram_pbase,
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  511  		MX6Q_SUSPEND_OCRAM_SIZE, false);
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  512  
ee4a5f838c8437 arch/arm/mach-imx/pm-imx6.c  Anson Huang            2015-08-05 @513  	memset(suspend_ocram_base, 0, sizeof(*pm_info));
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  514  	pm_info = suspend_ocram_base;
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  515  	pm_info->pbase = ocram_pbase;
64fc2a947a9873 arch/arm/mach-imx/pm-imx6.c  Florian Fainelli       2017-01-15  516  	pm_info->resume_addr = __pa_symbol(v7_cpu_resume);
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  517  	pm_info->pm_info_size = sizeof(*pm_info);
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  518  
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  519  	/*
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  520  	 * ccm physical address is not used by asm code currently,
f0b478b5d42ee9 arch/arm/mach-imx/pm-imx6.c  Shawn Guo              2015-04-25  521  	 * so get ccm virtual address directly.
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  522  	 */
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  523  	pm_info->ccm_base.vbase = ccm_base;
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  524  
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  525  	ret = imx6_pm_get_base(&pm_info->mmdc_base, socdata->mmdc_compat);
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  526  	if (ret) {
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  527  		pr_warn("%s: failed to get mmdc base %d!\n", __func__, ret);
4845446036fc9c arch/arm/mach-imx/pm-imx6.c  yu kuai                2020-06-04  528  		goto put_device;
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  529  	}
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  530  
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  531  	ret = imx6_pm_get_base(&pm_info->src_base, socdata->src_compat);
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  532  	if (ret) {
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  533  		pr_warn("%s: failed to get src base %d!\n", __func__, ret);
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  534  		goto src_map_failed;
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  535  	}
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  536  
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  537  	ret = imx6_pm_get_base(&pm_info->iomuxc_base, socdata->iomuxc_compat);
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  538  	if (ret) {
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  539  		pr_warn("%s: failed to get iomuxc base %d!\n", __func__, ret);
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  540  		goto iomuxc_map_failed;
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  541  	}
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  542  
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  543  	ret = imx6_pm_get_base(&pm_info->gpc_base, socdata->gpc_compat);
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  544  	if (ret) {
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  545  		pr_warn("%s: failed to get gpc base %d!\n", __func__, ret);
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  546  		goto gpc_map_failed;
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  547  	}
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  548  
ee4a5f838c8437 arch/arm/mach-imx/pm-imx6.c  Anson Huang            2015-08-05  549  	if (socdata->pl310_compat) {
ee4a5f838c8437 arch/arm/mach-imx/pm-imx6.c  Anson Huang            2015-08-05  550  		ret = imx6_pm_get_base(&pm_info->l2_base, socdata->pl310_compat);
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  551  		if (ret) {
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  552  			pr_warn("%s: failed to get pl310-cache base %d!\n",
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  553  				__func__, ret);
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  554  			goto pl310_cache_map_failed;
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  555  		}
ee4a5f838c8437 arch/arm/mach-imx/pm-imx6.c  Anson Huang            2015-08-05  556  	}
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  557  
ec336b28413661 arch/arm/mach-imx/pm-imx6.c  Anson Huang            2014-09-17  558  	pm_info->ddr_type = imx_mmdc_get_ddr_type();
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  559  	pm_info->mmdc_io_num = socdata->mmdc_io_num;
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  560  	mmdc_offset_array = socdata->mmdc_io_offset;
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  561  
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  562  	for (i = 0; i < pm_info->mmdc_io_num; i++) {
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  563  		pm_info->mmdc_io_val[i][0] =
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  564  			mmdc_offset_array[i];
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  565  		pm_info->mmdc_io_val[i][1] =
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  566  			readl_relaxed(pm_info->iomuxc_base.vbase +
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  567  			mmdc_offset_array[i]);
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  568  	}
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  569  
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  570  	imx6_suspend_in_ocram_fn = fncpy(
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  571  		suspend_ocram_base + sizeof(*pm_info),
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  572  		&imx6_suspend,
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  573  		MX6Q_SUSPEND_OCRAM_SIZE - sizeof(*pm_info));
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  574  
4aede550f10415 arch/arm/mach-imx/pm-imx6.c  Russell King (Oracle   2021-09-21  575) 	__arm_iomem_set_ro(suspend_ocram_base, MX6Q_SUSPEND_OCRAM_SIZE);
4aede550f10415 arch/arm/mach-imx/pm-imx6.c  Russell King (Oracle   2021-09-21  576) 
4845446036fc9c arch/arm/mach-imx/pm-imx6.c  yu kuai                2020-06-04  577  	goto put_device;
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  578  
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  579  pl310_cache_map_failed:
cfefb762ad2963 arch/arm/mach-imx/pm-imx6.c  Jean-Christophe Dubois 2015-12-26  580  	iounmap(pm_info->gpc_base.vbase);
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  581  gpc_map_failed:
cfefb762ad2963 arch/arm/mach-imx/pm-imx6.c  Jean-Christophe Dubois 2015-12-26  582  	iounmap(pm_info->iomuxc_base.vbase);
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  583  iomuxc_map_failed:
cfefb762ad2963 arch/arm/mach-imx/pm-imx6.c  Jean-Christophe Dubois 2015-12-26  584  	iounmap(pm_info->src_base.vbase);
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  585  src_map_failed:
cfefb762ad2963 arch/arm/mach-imx/pm-imx6.c  Jean-Christophe Dubois 2015-12-26  586  	iounmap(pm_info->mmdc_base.vbase);
4845446036fc9c arch/arm/mach-imx/pm-imx6.c  yu kuai                2020-06-04  587  put_device:
4845446036fc9c arch/arm/mach-imx/pm-imx6.c  yu kuai                2020-06-04  588  	put_device(&pdev->dev);
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  589  put_node:
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  590  	of_node_put(node);
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  591  
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  592  	return ret;
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  593  }
df595746fa69db arch/arm/mach-imx/pm-imx6q.c Anson Huang            2014-01-17  594  

:::::: The code at line 513 was first introduced by commit
:::::: ee4a5f838c8437484c9387e9ef9256332f07f3dd ARM: imx: add suspend/resume support for i.mx6ul

:::::: TO: Anson Huang <b20788@freescale.com>
:::::: CC: Shawn Guo <shawnguo@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
