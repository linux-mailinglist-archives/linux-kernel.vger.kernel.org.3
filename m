Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4523468E18
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 00:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241256AbhLEX0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 18:26:17 -0500
Received: from mga17.intel.com ([192.55.52.151]:64838 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241232AbhLEX0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 18:26:16 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10189"; a="217903890"
X-IronPort-AV: E=Sophos;i="5.87,290,1631602800"; 
   d="scan'208";a="217903890"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2021 15:22:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,290,1631602800"; 
   d="scan'208";a="461613039"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 05 Dec 2021 15:22:46 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mu0qE-000KbC-2x; Sun, 05 Dec 2021 23:22:46 +0000
Date:   Mon, 6 Dec 2021 07:22:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: drivers/dma/ste_dma40.c:3679:29: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202112060734.YyXTPnkD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   944207047ca4dabe8e288f653e7ec6da05e70230
commit: fffdaba402cea79b8d219355487d342ec23f91c6 dmaengine: stedma40: add missing iounmap() on error in d40_probe()
date:   6 months ago
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20211206/202112060734.YyXTPnkD-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fffdaba402cea79b8d219355487d342ec23f91c6
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout fffdaba402cea79b8d219355487d342ec23f91c6
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash drivers/dma/ drivers/gpu/drm/tegra/ drivers/net/wireless/mediatek/mt76/mt7915/ drivers/remoteproc/ drivers/staging/ fs/proc/

If you fix the issue, kindly add following tag as appropriate
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
   drivers/dma/ste_dma40.c:3663:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *iomem_cookie @@     got void *base @@
   drivers/dma/ste_dma40.c:3663:40: sparse:     expected void volatile [noderef] __iomem *iomem_cookie
   drivers/dma/ste_dma40.c:3663:40: sparse:     got void *base
>> drivers/dma/ste_dma40.c:3679:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *iomem_cookie @@     got void *lcpa_base @@
   drivers/dma/ste_dma40.c:3679:29: sparse:     expected void volatile [noderef] __iomem *iomem_cookie
   drivers/dma/ste_dma40.c:3679:29: sparse:     got void *lcpa_base

vim +3679 drivers/dma/ste_dma40.c

  3504	
  3505	static int __init d40_probe(struct platform_device *pdev)
  3506	{
  3507		struct stedma40_platform_data *plat_data = dev_get_platdata(&pdev->dev);
  3508		struct device_node *np = pdev->dev.of_node;
  3509		int ret = -ENOENT;
  3510		struct d40_base *base;
  3511		struct resource *res;
  3512		int num_reserved_chans;
  3513		u32 val;
  3514	
  3515		if (!plat_data) {
  3516			if (np) {
  3517				if (d40_of_probe(pdev, np)) {
  3518					ret = -ENOMEM;
  3519					goto report_failure;
  3520				}
  3521			} else {
  3522				d40_err(&pdev->dev, "No pdata or Device Tree provided\n");
  3523				goto report_failure;
  3524			}
  3525		}
  3526	
  3527		base = d40_hw_detect_init(pdev);
  3528		if (!base)
  3529			goto report_failure;
  3530	
  3531		num_reserved_chans = d40_phy_res_init(base);
  3532	
  3533		platform_set_drvdata(pdev, base);
  3534	
  3535		spin_lock_init(&base->interrupt_lock);
  3536		spin_lock_init(&base->execmd_lock);
  3537	
  3538		/* Get IO for logical channel parameter address */
  3539		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "lcpa");
  3540		if (!res) {
  3541			ret = -ENOENT;
  3542			d40_err(&pdev->dev, "No \"lcpa\" memory resource\n");
  3543			goto destroy_cache;
  3544		}
  3545		base->lcpa_size = resource_size(res);
  3546		base->phy_lcpa = res->start;
  3547	
  3548		if (request_mem_region(res->start, resource_size(res),
  3549				       D40_NAME " I/O lcpa") == NULL) {
  3550			ret = -EBUSY;
  3551			d40_err(&pdev->dev, "Failed to request LCPA region %pR\n", res);
  3552			goto destroy_cache;
  3553		}
  3554	
  3555		/* We make use of ESRAM memory for this. */
  3556		val = readl(base->virtbase + D40_DREG_LCPA);
  3557		if (res->start != val && val != 0) {
  3558			dev_warn(&pdev->dev,
  3559				 "[%s] Mismatch LCPA dma 0x%x, def %pa\n",
  3560				 __func__, val, &res->start);
  3561		} else
  3562			writel(res->start, base->virtbase + D40_DREG_LCPA);
  3563	
> 3564		base->lcpa_base = ioremap(res->start, resource_size(res));
  3565		if (!base->lcpa_base) {
  3566			ret = -ENOMEM;
  3567			d40_err(&pdev->dev, "Failed to ioremap LCPA region\n");
  3568			goto destroy_cache;
  3569		}
  3570		/* If lcla has to be located in ESRAM we don't need to allocate */
  3571		if (base->plat_data->use_esram_lcla) {
  3572			res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
  3573								"lcla_esram");
  3574			if (!res) {
  3575				ret = -ENOENT;
  3576				d40_err(&pdev->dev,
  3577					"No \"lcla_esram\" memory resource\n");
  3578				goto destroy_cache;
  3579			}
  3580			base->lcla_pool.base = ioremap(res->start,
  3581							resource_size(res));
  3582			if (!base->lcla_pool.base) {
  3583				ret = -ENOMEM;
  3584				d40_err(&pdev->dev, "Failed to ioremap LCLA region\n");
  3585				goto destroy_cache;
  3586			}
  3587			writel(res->start, base->virtbase + D40_DREG_LCLA);
  3588	
  3589		} else {
  3590			ret = d40_lcla_allocate(base);
  3591			if (ret) {
  3592				d40_err(&pdev->dev, "Failed to allocate LCLA area\n");
  3593				goto destroy_cache;
  3594			}
  3595		}
  3596	
  3597		spin_lock_init(&base->lcla_pool.lock);
  3598	
  3599		base->irq = platform_get_irq(pdev, 0);
  3600	
  3601		ret = request_irq(base->irq, d40_handle_interrupt, 0, D40_NAME, base);
  3602		if (ret) {
  3603			d40_err(&pdev->dev, "No IRQ defined\n");
  3604			goto destroy_cache;
  3605		}
  3606	
  3607		if (base->plat_data->use_esram_lcla) {
  3608	
  3609			base->lcpa_regulator = regulator_get(base->dev, "lcla_esram");
  3610			if (IS_ERR(base->lcpa_regulator)) {
  3611				d40_err(&pdev->dev, "Failed to get lcpa_regulator\n");
  3612				ret = PTR_ERR(base->lcpa_regulator);
  3613				base->lcpa_regulator = NULL;
  3614				goto destroy_cache;
  3615			}
  3616	
  3617			ret = regulator_enable(base->lcpa_regulator);
  3618			if (ret) {
  3619				d40_err(&pdev->dev,
  3620					"Failed to enable lcpa_regulator\n");
  3621				regulator_put(base->lcpa_regulator);
  3622				base->lcpa_regulator = NULL;
  3623				goto destroy_cache;
  3624			}
  3625		}
  3626	
  3627		writel_relaxed(D40_DREG_GCC_ENABLE_ALL, base->virtbase + D40_DREG_GCC);
  3628	
  3629		pm_runtime_irq_safe(base->dev);
  3630		pm_runtime_set_autosuspend_delay(base->dev, DMA40_AUTOSUSPEND_DELAY);
  3631		pm_runtime_use_autosuspend(base->dev);
  3632		pm_runtime_mark_last_busy(base->dev);
  3633		pm_runtime_set_active(base->dev);
  3634		pm_runtime_enable(base->dev);
  3635	
  3636		ret = d40_dmaengine_init(base, num_reserved_chans);
  3637		if (ret)
  3638			goto destroy_cache;
  3639	
  3640		ret = dma_set_max_seg_size(base->dev, STEDMA40_MAX_SEG_SIZE);
  3641		if (ret) {
  3642			d40_err(&pdev->dev, "Failed to set dma max seg size\n");
  3643			goto destroy_cache;
  3644		}
  3645	
  3646		d40_hw_init(base);
  3647	
  3648		if (np) {
  3649			ret = of_dma_controller_register(np, d40_xlate, NULL);
  3650			if (ret)
  3651				dev_err(&pdev->dev,
  3652					"could not register of_dma_controller\n");
  3653		}
  3654	
  3655		dev_info(base->dev, "initialized\n");
  3656		return 0;
  3657	 destroy_cache:
  3658		kmem_cache_destroy(base->desc_slab);
  3659		if (base->virtbase)
  3660			iounmap(base->virtbase);
  3661	
  3662		if (base->lcla_pool.base && base->plat_data->use_esram_lcla) {
  3663			iounmap(base->lcla_pool.base);
  3664			base->lcla_pool.base = NULL;
  3665		}
  3666	
  3667		if (base->lcla_pool.dma_addr)
  3668			dma_unmap_single(base->dev, base->lcla_pool.dma_addr,
  3669					 SZ_1K * base->num_phy_chans,
  3670					 DMA_TO_DEVICE);
  3671	
  3672		if (!base->lcla_pool.base_unaligned && base->lcla_pool.base)
  3673			free_pages((unsigned long)base->lcla_pool.base,
  3674				   base->lcla_pool.pages);
  3675	
  3676		kfree(base->lcla_pool.base_unaligned);
  3677	
  3678		if (base->lcpa_base)
> 3679			iounmap(base->lcpa_base);
  3680	
  3681		if (base->phy_lcpa)
  3682			release_mem_region(base->phy_lcpa,
  3683					   base->lcpa_size);
  3684		if (base->phy_start)
  3685			release_mem_region(base->phy_start,
  3686					   base->phy_size);
  3687		if (base->clk) {
  3688			clk_disable_unprepare(base->clk);
  3689			clk_put(base->clk);
  3690		}
  3691	
  3692		if (base->lcpa_regulator) {
  3693			regulator_disable(base->lcpa_regulator);
  3694			regulator_put(base->lcpa_regulator);
  3695		}
  3696	
  3697		kfree(base->lcla_pool.alloc_map);
  3698		kfree(base->lookup_log_chans);
  3699		kfree(base->lookup_phy_chans);
  3700		kfree(base->phy_res);
  3701		kfree(base);
  3702	 report_failure:
  3703		d40_err(&pdev->dev, "probe failed\n");
  3704		return ret;
  3705	}
  3706	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
