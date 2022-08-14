Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1A5592049
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 16:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiHNO4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 10:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiHNO4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 10:56:04 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EC017045
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 07:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660488962; x=1692024962;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JRT/87epB8cSTvK0Ai9kFMPipqC4ORfgcvFO3IbpJu4=;
  b=VGI180M1qoDsAok3eaDsrqDH4MUO8JAN4ze0s60o0pSNY54SRjCYP7Gh
   wGq2SWjtqflDx006OeUnxjoLtPwPnEiSi4c7mjJwrhFKUsnnG8VuXhO40
   jxp1DIAvaFve8B2ezIWVgR6zxqEx0SE298naHSv6BQ6VEqKw2eZvFACvY
   ZZmMyx9blOdG8M+wdbE1RKayNIXXp8DiEzRQJQtsEKC4oJwQP59b4Ws2p
   UR4x4Dl9VyRhhlsgrufCVxWHzLLwHLc02Xlaj5v0xBwVJ/IN0rweBdLcE
   TJzdCZC15UtzsMNeVoTc1BtKilRuuZ9NqjHHBag5HLY5/yog/bxrLhHPS
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="289400069"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="289400069"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 07:56:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="674581408"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 14 Aug 2022 07:56:00 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNF1z-0000C4-2E;
        Sun, 14 Aug 2022 14:55:59 +0000
Date:   Sun, 14 Aug 2022 22:55:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Arnd Bergmann <arnd@arndb.de>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: drivers/dma/ste_dma40.c:3663:40: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202208142208.AUxRuZhj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   aea23e7c464bfdec04b52cf61edb62030e9e0d0a
commit: d803336abdbc1bfacdb32b2cf9f4fdbee072b8ee ARM: mm: kill unused runtime hook arch_iounmap()
date:   7 weeks ago
config: arm-randconfig-s031-20220810 (https://download.01.org/0day-ci/archive/20220814/202208142208.AUxRuZhj-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d803336abdbc1bfacdb32b2cf9f4fdbee072b8ee
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d803336abdbc1bfacdb32b2cf9f4fdbee072b8ee
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   drivers/dma/ste_dma40.c:1389:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ste_dma40.c:1389:28: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/dma/ste_dma40.c:1389:28: sparse:     got unsigned int *
   drivers/dma/ste_dma40.c:1405:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ste_dma40.c:1405:27: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/dma/ste_dma40.c:1405:27: sparse:     got unsigned int *
   drivers/dma/ste_dma40.c:3564:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *lcpa_base @@     got void [noderef] __iomem * @@
   drivers/dma/ste_dma40.c:3564:25: sparse:     expected void *lcpa_base
   drivers/dma/ste_dma40.c:3564:25: sparse:     got void [noderef] __iomem *
   drivers/dma/ste_dma40.c:3580:38: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *base @@     got void [noderef] __iomem * @@
   drivers/dma/ste_dma40.c:3580:38: sparse:     expected void *base
   drivers/dma/ste_dma40.c:3580:38: sparse:     got void [noderef] __iomem *
>> drivers/dma/ste_dma40.c:3663:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *io_addr @@     got void *base @@
   drivers/dma/ste_dma40.c:3663:40: sparse:     expected void volatile [noderef] __iomem *io_addr
   drivers/dma/ste_dma40.c:3663:40: sparse:     got void *base
>> drivers/dma/ste_dma40.c:3679:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *io_addr @@     got void *lcpa_base @@
   drivers/dma/ste_dma40.c:3679:29: sparse:     expected void volatile [noderef] __iomem *io_addr
   drivers/dma/ste_dma40.c:3679:29: sparse:     got void *lcpa_base

vim +3663 drivers/dma/ste_dma40.c

1814a1703ce2d6 Lee Jones      2013-05-03  3504  
8d318a50b3d72e Linus Walleij  2010-03-30  3505  static int __init d40_probe(struct platform_device *pdev)
8d318a50b3d72e Linus Walleij  2010-03-30  3506  {
d4adcc0160404c Jingoo Han     2013-07-30  3507  	struct stedma40_platform_data *plat_data = dev_get_platdata(&pdev->dev);
1814a1703ce2d6 Lee Jones      2013-05-03  3508  	struct device_node *np = pdev->dev.of_node;
8d318a50b3d72e Linus Walleij  2010-03-30  3509  	int ret = -ENOENT;
a9bae06dd05fc8 Markus Elfring 2015-11-16  3510  	struct d40_base *base;
aeb8974ac70f07 Markus Elfring 2015-11-16  3511  	struct resource *res;
8d318a50b3d72e Linus Walleij  2010-03-30  3512  	int num_reserved_chans;
8d318a50b3d72e Linus Walleij  2010-03-30  3513  	u32 val;
8d318a50b3d72e Linus Walleij  2010-03-30  3514  
1814a1703ce2d6 Lee Jones      2013-05-03  3515  	if (!plat_data) {
1814a1703ce2d6 Lee Jones      2013-05-03  3516  		if (np) {
1814a1703ce2d6 Lee Jones      2013-05-03  3517  			if (d40_of_probe(pdev, np)) {
1814a1703ce2d6 Lee Jones      2013-05-03  3518  				ret = -ENOMEM;
a9bae06dd05fc8 Markus Elfring 2015-11-16  3519  				goto report_failure;
1814a1703ce2d6 Lee Jones      2013-05-03  3520  			}
1814a1703ce2d6 Lee Jones      2013-05-03  3521  		} else {
1814a1703ce2d6 Lee Jones      2013-05-03  3522  			d40_err(&pdev->dev, "No pdata or Device Tree provided\n");
a9bae06dd05fc8 Markus Elfring 2015-11-16  3523  			goto report_failure;
1814a1703ce2d6 Lee Jones      2013-05-03  3524  		}
1814a1703ce2d6 Lee Jones      2013-05-03  3525  	}
8d318a50b3d72e Linus Walleij  2010-03-30  3526  
1814a1703ce2d6 Lee Jones      2013-05-03  3527  	base = d40_hw_detect_init(pdev);
8d318a50b3d72e Linus Walleij  2010-03-30  3528  	if (!base)
a9bae06dd05fc8 Markus Elfring 2015-11-16  3529  		goto report_failure;
8d318a50b3d72e Linus Walleij  2010-03-30  3530  
8d318a50b3d72e Linus Walleij  2010-03-30  3531  	num_reserved_chans = d40_phy_res_init(base);
8d318a50b3d72e Linus Walleij  2010-03-30  3532  
8d318a50b3d72e Linus Walleij  2010-03-30  3533  	platform_set_drvdata(pdev, base);
8d318a50b3d72e Linus Walleij  2010-03-30  3534  
8d318a50b3d72e Linus Walleij  2010-03-30  3535  	spin_lock_init(&base->interrupt_lock);
8d318a50b3d72e Linus Walleij  2010-03-30  3536  	spin_lock_init(&base->execmd_lock);
8d318a50b3d72e Linus Walleij  2010-03-30  3537  
8d318a50b3d72e Linus Walleij  2010-03-30  3538  	/* Get IO for logical channel parameter address */
8d318a50b3d72e Linus Walleij  2010-03-30  3539  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "lcpa");
8d318a50b3d72e Linus Walleij  2010-03-30  3540  	if (!res) {
8d318a50b3d72e Linus Walleij  2010-03-30  3541  		ret = -ENOENT;
6db5a8ba11bf23 Rabin Vincent  2011-01-25  3542  		d40_err(&pdev->dev, "No \"lcpa\" memory resource\n");
d7b7ecce4bcb15 Markus Elfring 2016-09-17  3543  		goto destroy_cache;
8d318a50b3d72e Linus Walleij  2010-03-30  3544  	}
8d318a50b3d72e Linus Walleij  2010-03-30  3545  	base->lcpa_size = resource_size(res);
8d318a50b3d72e Linus Walleij  2010-03-30  3546  	base->phy_lcpa = res->start;
8d318a50b3d72e Linus Walleij  2010-03-30  3547  
8d318a50b3d72e Linus Walleij  2010-03-30  3548  	if (request_mem_region(res->start, resource_size(res),
8d318a50b3d72e Linus Walleij  2010-03-30  3549  			       D40_NAME " I/O lcpa") == NULL) {
8d318a50b3d72e Linus Walleij  2010-03-30  3550  		ret = -EBUSY;
3a919d5b43e459 Fabio Estevam  2013-08-21  3551  		d40_err(&pdev->dev, "Failed to request LCPA region %pR\n", res);
d7b7ecce4bcb15 Markus Elfring 2016-09-17  3552  		goto destroy_cache;
8d318a50b3d72e Linus Walleij  2010-03-30  3553  	}
8d318a50b3d72e Linus Walleij  2010-03-30  3554  
8d318a50b3d72e Linus Walleij  2010-03-30  3555  	/* We make use of ESRAM memory for this. */
8d318a50b3d72e Linus Walleij  2010-03-30  3556  	val = readl(base->virtbase + D40_DREG_LCPA);
8d318a50b3d72e Linus Walleij  2010-03-30  3557  	if (res->start != val && val != 0) {
8d318a50b3d72e Linus Walleij  2010-03-30  3558  		dev_warn(&pdev->dev,
3a919d5b43e459 Fabio Estevam  2013-08-21  3559  			 "[%s] Mismatch LCPA dma 0x%x, def %pa\n",
3a919d5b43e459 Fabio Estevam  2013-08-21  3560  			 __func__, val, &res->start);
8d318a50b3d72e Linus Walleij  2010-03-30  3561  	} else
8d318a50b3d72e Linus Walleij  2010-03-30  3562  		writel(res->start, base->virtbase + D40_DREG_LCPA);
8d318a50b3d72e Linus Walleij  2010-03-30  3563  
8d318a50b3d72e Linus Walleij  2010-03-30  3564  	base->lcpa_base = ioremap(res->start, resource_size(res));
8d318a50b3d72e Linus Walleij  2010-03-30  3565  	if (!base->lcpa_base) {
8d318a50b3d72e Linus Walleij  2010-03-30  3566  		ret = -ENOMEM;
6db5a8ba11bf23 Rabin Vincent  2011-01-25  3567  		d40_err(&pdev->dev, "Failed to ioremap LCPA region\n");
d7b7ecce4bcb15 Markus Elfring 2016-09-17  3568  		goto destroy_cache;
8d318a50b3d72e Linus Walleij  2010-03-30  3569  	}
28c7a19d230228 Narayanan G    2011-11-22  3570  	/* If lcla has to be located in ESRAM we don't need to allocate */
28c7a19d230228 Narayanan G    2011-11-22  3571  	if (base->plat_data->use_esram_lcla) {
28c7a19d230228 Narayanan G    2011-11-22  3572  		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
28c7a19d230228 Narayanan G    2011-11-22  3573  							"lcla_esram");
28c7a19d230228 Narayanan G    2011-11-22  3574  		if (!res) {
28c7a19d230228 Narayanan G    2011-11-22  3575  			ret = -ENOENT;
28c7a19d230228 Narayanan G    2011-11-22  3576  			d40_err(&pdev->dev,
28c7a19d230228 Narayanan G    2011-11-22  3577  				"No \"lcla_esram\" memory resource\n");
d7b7ecce4bcb15 Markus Elfring 2016-09-17  3578  			goto destroy_cache;
28c7a19d230228 Narayanan G    2011-11-22  3579  		}
28c7a19d230228 Narayanan G    2011-11-22  3580  		base->lcla_pool.base = ioremap(res->start,
28c7a19d230228 Narayanan G    2011-11-22  3581  						resource_size(res));
28c7a19d230228 Narayanan G    2011-11-22  3582  		if (!base->lcla_pool.base) {
28c7a19d230228 Narayanan G    2011-11-22  3583  			ret = -ENOMEM;
28c7a19d230228 Narayanan G    2011-11-22  3584  			d40_err(&pdev->dev, "Failed to ioremap LCLA region\n");
d7b7ecce4bcb15 Markus Elfring 2016-09-17  3585  			goto destroy_cache;
28c7a19d230228 Narayanan G    2011-11-22  3586  		}
28c7a19d230228 Narayanan G    2011-11-22  3587  		writel(res->start, base->virtbase + D40_DREG_LCLA);
8d318a50b3d72e Linus Walleij  2010-03-30  3588  
28c7a19d230228 Narayanan G    2011-11-22  3589  	} else {
508849ade23c11 Linus Walleij  2010-06-20  3590  		ret = d40_lcla_allocate(base);
508849ade23c11 Linus Walleij  2010-06-20  3591  		if (ret) {
6db5a8ba11bf23 Rabin Vincent  2011-01-25  3592  			d40_err(&pdev->dev, "Failed to allocate LCLA area\n");
d7b7ecce4bcb15 Markus Elfring 2016-09-17  3593  			goto destroy_cache;
8d318a50b3d72e Linus Walleij  2010-03-30  3594  		}
28c7a19d230228 Narayanan G    2011-11-22  3595  	}
8d318a50b3d72e Linus Walleij  2010-03-30  3596  
8d318a50b3d72e Linus Walleij  2010-03-30  3597  	spin_lock_init(&base->lcla_pool.lock);
8d318a50b3d72e Linus Walleij  2010-03-30  3598  
8d318a50b3d72e Linus Walleij  2010-03-30  3599  	base->irq = platform_get_irq(pdev, 0);
8d318a50b3d72e Linus Walleij  2010-03-30  3600  
8d318a50b3d72e Linus Walleij  2010-03-30  3601  	ret = request_irq(base->irq, d40_handle_interrupt, 0, D40_NAME, base);
8d318a50b3d72e Linus Walleij  2010-03-30  3602  	if (ret) {
6db5a8ba11bf23 Rabin Vincent  2011-01-25  3603  		d40_err(&pdev->dev, "No IRQ defined\n");
d7b7ecce4bcb15 Markus Elfring 2016-09-17  3604  		goto destroy_cache;
8d318a50b3d72e Linus Walleij  2010-03-30  3605  	}
8d318a50b3d72e Linus Walleij  2010-03-30  3606  
28c7a19d230228 Narayanan G    2011-11-22  3607  	if (base->plat_data->use_esram_lcla) {
28c7a19d230228 Narayanan G    2011-11-22  3608  
28c7a19d230228 Narayanan G    2011-11-22  3609  		base->lcpa_regulator = regulator_get(base->dev, "lcla_esram");
28c7a19d230228 Narayanan G    2011-11-22  3610  		if (IS_ERR(base->lcpa_regulator)) {
28c7a19d230228 Narayanan G    2011-11-22  3611  			d40_err(&pdev->dev, "Failed to get lcpa_regulator\n");
8581bbcd30afa9 Wei Yongjun    2013-05-31  3612  			ret = PTR_ERR(base->lcpa_regulator);
28c7a19d230228 Narayanan G    2011-11-22  3613  			base->lcpa_regulator = NULL;
d7b7ecce4bcb15 Markus Elfring 2016-09-17  3614  			goto destroy_cache;
28c7a19d230228 Narayanan G    2011-11-22  3615  		}
28c7a19d230228 Narayanan G    2011-11-22  3616  
28c7a19d230228 Narayanan G    2011-11-22  3617  		ret = regulator_enable(base->lcpa_regulator);
28c7a19d230228 Narayanan G    2011-11-22  3618  		if (ret) {
28c7a19d230228 Narayanan G    2011-11-22  3619  			d40_err(&pdev->dev,
28c7a19d230228 Narayanan G    2011-11-22  3620  				"Failed to enable lcpa_regulator\n");
28c7a19d230228 Narayanan G    2011-11-22  3621  			regulator_put(base->lcpa_regulator);
28c7a19d230228 Narayanan G    2011-11-22  3622  			base->lcpa_regulator = NULL;
d7b7ecce4bcb15 Markus Elfring 2016-09-17  3623  			goto destroy_cache;
28c7a19d230228 Narayanan G    2011-11-22  3624  		}
28c7a19d230228 Narayanan G    2011-11-22  3625  	}
28c7a19d230228 Narayanan G    2011-11-22  3626  
2dafca17c8807b Ulf Hansson    2014-04-23  3627  	writel_relaxed(D40_DREG_GCC_ENABLE_ALL, base->virtbase + D40_DREG_GCC);
2dafca17c8807b Ulf Hansson    2014-04-23  3628  
2dafca17c8807b Ulf Hansson    2014-04-23  3629  	pm_runtime_irq_safe(base->dev);
2dafca17c8807b Ulf Hansson    2014-04-23  3630  	pm_runtime_set_autosuspend_delay(base->dev, DMA40_AUTOSUSPEND_DELAY);
2dafca17c8807b Ulf Hansson    2014-04-23  3631  	pm_runtime_use_autosuspend(base->dev);
2dafca17c8807b Ulf Hansson    2014-04-23  3632  	pm_runtime_mark_last_busy(base->dev);
2dafca17c8807b Ulf Hansson    2014-04-23  3633  	pm_runtime_set_active(base->dev);
2dafca17c8807b Ulf Hansson    2014-04-23  3634  	pm_runtime_enable(base->dev);
2dafca17c8807b Ulf Hansson    2014-04-23  3635  
8581bbcd30afa9 Wei Yongjun    2013-05-31  3636  	ret = d40_dmaengine_init(base, num_reserved_chans);
8581bbcd30afa9 Wei Yongjun    2013-05-31  3637  	if (ret)
d7b7ecce4bcb15 Markus Elfring 2016-09-17  3638  		goto destroy_cache;
8d318a50b3d72e Linus Walleij  2010-03-30  3639  
8581bbcd30afa9 Wei Yongjun    2013-05-31  3640  	ret = dma_set_max_seg_size(base->dev, STEDMA40_MAX_SEG_SIZE);
8581bbcd30afa9 Wei Yongjun    2013-05-31  3641  	if (ret) {
b96710e5b22609 Per Forlin     2011-10-18  3642  		d40_err(&pdev->dev, "Failed to set dma max seg size\n");
d7b7ecce4bcb15 Markus Elfring 2016-09-17  3643  		goto destroy_cache;
b96710e5b22609 Per Forlin     2011-10-18  3644  	}
b96710e5b22609 Per Forlin     2011-10-18  3645  
8d318a50b3d72e Linus Walleij  2010-03-30  3646  	d40_hw_init(base);
8d318a50b3d72e Linus Walleij  2010-03-30  3647  
fa332de5c6b389 Lee Jones      2013-05-03  3648  	if (np) {
8581bbcd30afa9 Wei Yongjun    2013-05-31  3649  		ret = of_dma_controller_register(np, d40_xlate, NULL);
8581bbcd30afa9 Wei Yongjun    2013-05-31  3650  		if (ret)
fa332de5c6b389 Lee Jones      2013-05-03  3651  			dev_err(&pdev->dev,
fa332de5c6b389 Lee Jones      2013-05-03  3652  				"could not register of_dma_controller\n");
fa332de5c6b389 Lee Jones      2013-05-03  3653  	}
fa332de5c6b389 Lee Jones      2013-05-03  3654  
8d318a50b3d72e Linus Walleij  2010-03-30  3655  	dev_info(base->dev, "initialized\n");
8d318a50b3d72e Linus Walleij  2010-03-30  3656  	return 0;
d7b7ecce4bcb15 Markus Elfring 2016-09-17  3657   destroy_cache:
c675b1b424446b Jonas Aaberg   2010-06-20  3658  	kmem_cache_destroy(base->desc_slab);
8d318a50b3d72e Linus Walleij  2010-03-30  3659  	if (base->virtbase)
8d318a50b3d72e Linus Walleij  2010-03-30  3660  		iounmap(base->virtbase);
026cbc424a162e Rabin Vincent  2011-01-25  3661  
28c7a19d230228 Narayanan G    2011-11-22  3662  	if (base->lcla_pool.base && base->plat_data->use_esram_lcla) {
28c7a19d230228 Narayanan G    2011-11-22 @3663  		iounmap(base->lcla_pool.base);
28c7a19d230228 Narayanan G    2011-11-22  3664  		base->lcla_pool.base = NULL;
28c7a19d230228 Narayanan G    2011-11-22  3665  	}
28c7a19d230228 Narayanan G    2011-11-22  3666  
026cbc424a162e Rabin Vincent  2011-01-25  3667  	if (base->lcla_pool.dma_addr)
026cbc424a162e Rabin Vincent  2011-01-25  3668  		dma_unmap_single(base->dev, base->lcla_pool.dma_addr,
026cbc424a162e Rabin Vincent  2011-01-25  3669  				 SZ_1K * base->num_phy_chans,
026cbc424a162e Rabin Vincent  2011-01-25  3670  				 DMA_TO_DEVICE);
026cbc424a162e Rabin Vincent  2011-01-25  3671  
508849ade23c11 Linus Walleij  2010-06-20  3672  	if (!base->lcla_pool.base_unaligned && base->lcla_pool.base)
508849ade23c11 Linus Walleij  2010-06-20  3673  		free_pages((unsigned long)base->lcla_pool.base,
508849ade23c11 Linus Walleij  2010-06-20  3674  			   base->lcla_pool.pages);
767a9675c4a68a Jonas Aaberg   2010-08-09  3675  
508849ade23c11 Linus Walleij  2010-06-20  3676  	kfree(base->lcla_pool.base_unaligned);
767a9675c4a68a Jonas Aaberg   2010-08-09  3677  
fffdaba402cea7 Yang Yingliang 2021-05-18  3678  	if (base->lcpa_base)
fffdaba402cea7 Yang Yingliang 2021-05-18 @3679  		iounmap(base->lcpa_base);
fffdaba402cea7 Yang Yingliang 2021-05-18  3680  
8d318a50b3d72e Linus Walleij  2010-03-30  3681  	if (base->phy_lcpa)
8d318a50b3d72e Linus Walleij  2010-03-30  3682  		release_mem_region(base->phy_lcpa,
8d318a50b3d72e Linus Walleij  2010-03-30  3683  				   base->lcpa_size);
8d318a50b3d72e Linus Walleij  2010-03-30  3684  	if (base->phy_start)
8d318a50b3d72e Linus Walleij  2010-03-30  3685  		release_mem_region(base->phy_start,
8d318a50b3d72e Linus Walleij  2010-03-30  3686  				   base->phy_size);
8d318a50b3d72e Linus Walleij  2010-03-30  3687  	if (base->clk) {
da2ac56a1bc9c6 Fabio Baltieri 2013-01-07  3688  		clk_disable_unprepare(base->clk);
8d318a50b3d72e Linus Walleij  2010-03-30  3689  		clk_put(base->clk);
8d318a50b3d72e Linus Walleij  2010-03-30  3690  	}
8d318a50b3d72e Linus Walleij  2010-03-30  3691  
28c7a19d230228 Narayanan G    2011-11-22  3692  	if (base->lcpa_regulator) {
28c7a19d230228 Narayanan G    2011-11-22  3693  		regulator_disable(base->lcpa_regulator);
28c7a19d230228 Narayanan G    2011-11-22  3694  		regulator_put(base->lcpa_regulator);
28c7a19d230228 Narayanan G    2011-11-22  3695  	}
28c7a19d230228 Narayanan G    2011-11-22  3696  
8d318a50b3d72e Linus Walleij  2010-03-30  3697  	kfree(base->lcla_pool.alloc_map);
8d318a50b3d72e Linus Walleij  2010-03-30  3698  	kfree(base->lookup_log_chans);
8d318a50b3d72e Linus Walleij  2010-03-30  3699  	kfree(base->lookup_phy_chans);
8d318a50b3d72e Linus Walleij  2010-03-30  3700  	kfree(base->phy_res);
8d318a50b3d72e Linus Walleij  2010-03-30  3701  	kfree(base);
a9bae06dd05fc8 Markus Elfring 2015-11-16  3702   report_failure:
6db5a8ba11bf23 Rabin Vincent  2011-01-25  3703  	d40_err(&pdev->dev, "probe failed\n");
8d318a50b3d72e Linus Walleij  2010-03-30  3704  	return ret;
8d318a50b3d72e Linus Walleij  2010-03-30  3705  }
8d318a50b3d72e Linus Walleij  2010-03-30  3706  

:::::: The code at line 3663 was first introduced by commit
:::::: 28c7a19d230228ab9ae61c300c5003a2400fadd3 dmaengine/ste_dma40: Add support to use lcla area from esram

:::::: TO: Narayanan G <narayanan.gopalakrishnan@stericsson.com>
:::::: CC: Vinod Koul <vinod.koul@linux.intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
