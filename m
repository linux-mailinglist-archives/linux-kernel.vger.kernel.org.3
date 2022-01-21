Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C40DB496755
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 22:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiAUVeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 16:34:09 -0500
Received: from mga07.intel.com ([134.134.136.100]:53079 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229798AbiAUVeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 16:34:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642800848; x=1674336848;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TUIu/hEwyZOJjP0RMpy0JKE2+Z4JbU+k3d74jBVIpP4=;
  b=YCaMcCqxE2tNyPEUEHHJOdBCnyI/McBS/X4wMGXo8TxuMWgLIZFFT4tD
   fsCeon3xVkVfrM6RZ4sRHchTcaG1ZduFRz0iXD/W7obQU5Ze7E+W08umd
   SHWVaNT/34wiYIFu/HSWZ9WKJGNmYSrLO9PNRDDwzfde++Yln3NChwMf/
   MugVQHS2ijiKcU9MsBtLS2YabmQgvH/5YaOmlrSPe1NlzwuIL+d3D09MJ
   rYO4feRCO8mp8UaYfUvBisNk13soZpjYSaqgHQDEQZeJ0HE9pSjhXDG9T
   GxJAiu4PVvTWghtp1trrd/pViPSc36YijCdY2aea3KKa7OrBZPfCxCFcG
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10234"; a="309074222"
X-IronPort-AV: E=Sophos;i="5.88,306,1635231600"; 
   d="scan'208";a="309074222"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 13:34:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,306,1635231600"; 
   d="scan'208";a="694777472"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 21 Jan 2022 13:34:04 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nB1Xo-000Fge-4y; Fri, 21 Jan 2022 21:34:04 +0000
Date:   Sat, 22 Jan 2022 05:33:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chevron Li <chevron.li@bayhubtech.com>, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, shirley.her@bayhubtech.com,
        fred.ai@bayhubtech.com, xiaoguang.yu@bayhubtech.com
Subject: Re: [PATCH 1/2] mmc:sdhci-msm:fix Qualcomm sd host 7180 SD card
 compatibility issue
Message-ID: <202201220531.njLkAypI-lkp@intel.com>
References: <20220121110909.104-1-chevron.li@bayhubtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121110909.104-1-chevron.li@bayhubtech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chevron,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on c9e6606c7fe92b50a02ce51dda82586ebdf99b48]

url:    https://github.com/0day-ci/linux/commits/Chevron-Li/mmc-sdhci-msm-fix-Qualcomm-sd-host-7180-SD-card-compatibility-issue/20220121-191113
base:   c9e6606c7fe92b50a02ce51dda82586ebdf99b48
config: arc-randconfig-r043-20220121 (https://download.01.org/0day-ci/archive/20220122/202201220531.njLkAypI-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/bba780c9359fe89c2a3e769bfa6373f58b90ee76
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Chevron-Li/mmc-sdhci-msm-fix-Qualcomm-sd-host-7180-SD-card-compatibility-issue/20220121-191113
        git checkout bba780c9359fe89c2a3e769bfa6373f58b90ee76
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/mmc/host/sdhci-msm.c: In function 'sdhci_msm_probe':
>> drivers/mmc/host/sdhci-msm.c:2535:40: warning: variable 'bht_host' set but not used [-Wunused-but-set-variable]
    2535 |                 struct sdhci_bht_host *bht_host;
         |                                        ^~~~~~~~


vim +/bht_host +2535 drivers/mmc/host/sdhci-msm.c

  2498	
  2499	
  2500	static int sdhci_msm_probe(struct platform_device *pdev)
  2501	{
  2502		struct sdhci_host *host;
  2503		struct sdhci_pltfm_host *pltfm_host;
  2504		struct sdhci_msm_host *msm_host;
  2505		struct clk *clk;
  2506		int ret;
  2507		u16 host_version, core_minor;
  2508		u32 core_version, config;
  2509		u8 core_major;
  2510		const struct sdhci_msm_offset *msm_offset;
  2511		const struct sdhci_msm_variant_info *var_info;
  2512		struct device_node *node = pdev->dev.of_node;
  2513	
  2514		/* Bayhub patch: memory allocate for sdhci_bht_host structure */
  2515		if (of_find_property(node, "use-bayhub-bh201", NULL))
  2516			host = sdhci_pltfm_init(pdev, &sdhci_msm_pdata,
  2517				sizeof(*msm_host) + sizeof(struct sdhci_bht_host));
  2518		else
  2519			host = sdhci_pltfm_init(pdev, &sdhci_msm_pdata, sizeof(*msm_host));
  2520		if (IS_ERR(host))
  2521			return PTR_ERR(host);
  2522	
  2523		host->sdma_boundary = 0;
  2524		pltfm_host = sdhci_priv(host);
  2525		msm_host = sdhci_pltfm_priv(pltfm_host);
  2526		msm_host->mmc = host->mmc;
  2527		msm_host->pdev = pdev;
  2528	
  2529		ret = mmc_of_parse(host->mmc);
  2530		if (ret)
  2531			goto pltfm_free;
  2532	
  2533		/* Bayhub patch: resource assign and mmc_rescan routine overload */
  2534		if (of_find_property(node, "use-bayhub-bh201", NULL)) {
> 2535			struct sdhci_bht_host *bht_host;
  2536	
  2537			bht_host = sdhci_msm_priv(msm_host);
  2538			sdhci_bht_parse(msm_host->mmc);
  2539			INIT_DELAYED_WORK(&host->mmc->detect, mmc_rescan_bht);
  2540		}
  2541	
  2542		/*
  2543		 * Based on the compatible string, load the required msm host info from
  2544		 * the data associated with the version info.
  2545		 */
  2546		var_info = of_device_get_match_data(&pdev->dev);
  2547	
  2548		msm_host->mci_removed = var_info->mci_removed;
  2549		msm_host->restore_dll_config = var_info->restore_dll_config;
  2550		msm_host->var_ops = var_info->var_ops;
  2551		msm_host->offset = var_info->offset;
  2552	
  2553		msm_offset = msm_host->offset;
  2554	
  2555		sdhci_get_of_property(pdev);
  2556		sdhci_msm_get_of_property(pdev, host);
  2557	
  2558		msm_host->saved_tuning_phase = INVALID_TUNING_PHASE;
  2559	
  2560		/* Setup SDCC bus voter clock. */
  2561		msm_host->bus_clk = devm_clk_get(&pdev->dev, "bus");
  2562		if (!IS_ERR(msm_host->bus_clk)) {
  2563			/* Vote for max. clk rate for max. performance */
  2564			ret = clk_set_rate(msm_host->bus_clk, INT_MAX);
  2565			if (ret)
  2566				goto pltfm_free;
  2567			ret = clk_prepare_enable(msm_host->bus_clk);
  2568			if (ret)
  2569				goto pltfm_free;
  2570		}
  2571	
  2572		/* Setup main peripheral bus clock */
  2573		clk = devm_clk_get(&pdev->dev, "iface");
  2574		if (IS_ERR(clk)) {
  2575			ret = PTR_ERR(clk);
  2576			dev_err(&pdev->dev, "Peripheral clk setup failed (%d)\n", ret);
  2577			goto bus_clk_disable;
  2578		}
  2579		msm_host->bulk_clks[1].clk = clk;
  2580	
  2581		/* Setup SDC MMC clock */
  2582		clk = devm_clk_get(&pdev->dev, "core");
  2583		if (IS_ERR(clk)) {
  2584			ret = PTR_ERR(clk);
  2585			dev_err(&pdev->dev, "SDC MMC clk setup failed (%d)\n", ret);
  2586			goto bus_clk_disable;
  2587		}
  2588		msm_host->bulk_clks[0].clk = clk;
  2589	
  2590		 /* Check for optional interconnect paths */
  2591		ret = dev_pm_opp_of_find_icc_paths(&pdev->dev, NULL);
  2592		if (ret)
  2593			goto bus_clk_disable;
  2594	
  2595		ret = devm_pm_opp_set_clkname(&pdev->dev, "core");
  2596		if (ret)
  2597			goto bus_clk_disable;
  2598	
  2599		/* OPP table is optional */
  2600		ret = devm_pm_opp_of_add_table(&pdev->dev);
  2601		if (ret && ret != -ENODEV) {
  2602			dev_err(&pdev->dev, "Invalid OPP table in Device tree\n");
  2603			goto bus_clk_disable;
  2604		}
  2605	
  2606		/* Vote for maximum clock rate for maximum performance */
  2607		ret = dev_pm_opp_set_rate(&pdev->dev, INT_MAX);
  2608		if (ret)
  2609			dev_warn(&pdev->dev, "core clock boost failed\n");
  2610	
  2611		clk = devm_clk_get(&pdev->dev, "cal");
  2612		if (IS_ERR(clk))
  2613			clk = NULL;
  2614		msm_host->bulk_clks[2].clk = clk;
  2615	
  2616		clk = devm_clk_get(&pdev->dev, "sleep");
  2617		if (IS_ERR(clk))
  2618			clk = NULL;
  2619		msm_host->bulk_clks[3].clk = clk;
  2620	
  2621		clk = sdhci_msm_ice_get_clk(&pdev->dev);
  2622		if (IS_ERR(clk))
  2623			clk = NULL;
  2624		msm_host->bulk_clks[4].clk = clk;
  2625	
  2626		ret = clk_bulk_prepare_enable(ARRAY_SIZE(msm_host->bulk_clks),
  2627					      msm_host->bulk_clks);
  2628		if (ret)
  2629			goto bus_clk_disable;
  2630	
  2631		/*
  2632		 * xo clock is needed for FLL feature of cm_dll.
  2633		 * In case if xo clock is not mentioned in DT, warn and proceed.
  2634		 */
  2635		msm_host->xo_clk = devm_clk_get(&pdev->dev, "xo");
  2636		if (IS_ERR(msm_host->xo_clk)) {
  2637			ret = PTR_ERR(msm_host->xo_clk);
  2638			dev_warn(&pdev->dev, "TCXO clk not present (%d)\n", ret);
  2639		}
  2640	
  2641		if (!msm_host->mci_removed) {
  2642			msm_host->core_mem = devm_platform_ioremap_resource(pdev, 1);
  2643			if (IS_ERR(msm_host->core_mem)) {
  2644				ret = PTR_ERR(msm_host->core_mem);
  2645				goto clk_disable;
  2646			}
  2647		}
  2648	
  2649		/* Reset the vendor spec register to power on reset state */
  2650		writel_relaxed(CORE_VENDOR_SPEC_POR_VAL,
  2651				host->ioaddr + msm_offset->core_vendor_spec);
  2652	
  2653		if (!msm_host->mci_removed) {
  2654			/* Set HC_MODE_EN bit in HC_MODE register */
  2655			msm_host_writel(msm_host, HC_MODE_EN, host,
  2656					msm_offset->core_hc_mode);
  2657			config = msm_host_readl(msm_host, host,
  2658					msm_offset->core_hc_mode);
  2659			config |= FF_CLK_SW_RST_DIS;
  2660			msm_host_writel(msm_host, config, host,
  2661					msm_offset->core_hc_mode);
  2662		}
  2663	
  2664		host_version = readw_relaxed((host->ioaddr + SDHCI_HOST_VERSION));
  2665		dev_dbg(&pdev->dev, "Host Version: 0x%x Vendor Version 0x%x\n",
  2666			host_version, ((host_version & SDHCI_VENDOR_VER_MASK) >>
  2667				       SDHCI_VENDOR_VER_SHIFT));
  2668	
  2669		core_version = msm_host_readl(msm_host, host,
  2670				msm_offset->core_mci_version);
  2671		core_major = (core_version & CORE_VERSION_MAJOR_MASK) >>
  2672			      CORE_VERSION_MAJOR_SHIFT;
  2673		core_minor = core_version & CORE_VERSION_MINOR_MASK;
  2674		dev_dbg(&pdev->dev, "MCI Version: 0x%08x, major: 0x%04x, minor: 0x%02x\n",
  2675			core_version, core_major, core_minor);
  2676	
  2677		if (core_major == 1 && core_minor >= 0x42)
  2678			msm_host->use_14lpp_dll_reset = true;
  2679	
  2680		/*
  2681		 * SDCC 5 controller with major version 1, minor version 0x34 and later
  2682		 * with HS 400 mode support will use CM DLL instead of CDC LP 533 DLL.
  2683		 */
  2684		if (core_major == 1 && core_minor < 0x34)
  2685			msm_host->use_cdclp533 = true;
  2686	
  2687		/*
  2688		 * Support for some capabilities is not advertised by newer
  2689		 * controller versions and must be explicitly enabled.
  2690		 */
  2691		if (core_major >= 1 && core_minor != 0x11 && core_minor != 0x12) {
  2692			config = readl_relaxed(host->ioaddr + SDHCI_CAPABILITIES);
  2693			config |= SDHCI_CAN_VDD_300 | SDHCI_CAN_DO_8BIT;
  2694			writel_relaxed(config, host->ioaddr +
  2695					msm_offset->core_vendor_spec_capabilities0);
  2696		}
  2697	
  2698		if (core_major == 1 && core_minor >= 0x49)
  2699			msm_host->updated_ddr_cfg = true;
  2700	
  2701		if (core_major == 1 && core_minor >= 0x71)
  2702			msm_host->uses_tassadar_dll = true;
  2703	
  2704		ret = sdhci_msm_register_vreg(msm_host);
  2705		if (ret)
  2706			goto clk_disable;
  2707	
  2708		/*
  2709		 * Power on reset state may trigger power irq if previous status of
  2710		 * PWRCTL was either BUS_ON or IO_HIGH_V. So before enabling pwr irq
  2711		 * interrupt in GIC, any pending power irq interrupt should be
  2712		 * acknowledged. Otherwise power irq interrupt handler would be
  2713		 * fired prematurely.
  2714		 */
  2715		sdhci_msm_handle_pwr_irq(host, 0);
  2716	
  2717		/*
  2718		 * Ensure that above writes are propogated before interrupt enablement
  2719		 * in GIC.
  2720		 */
  2721		mb();
  2722	
  2723		/* Setup IRQ for handling power/voltage tasks with PMIC */
  2724		msm_host->pwr_irq = platform_get_irq_byname(pdev, "pwr_irq");
  2725		if (msm_host->pwr_irq < 0) {
  2726			ret = msm_host->pwr_irq;
  2727			goto clk_disable;
  2728		}
  2729	
  2730		sdhci_msm_init_pwr_irq_wait(msm_host);
  2731		/* Enable pwr irq interrupts */
  2732		msm_host_writel(msm_host, INT_MASK, host,
  2733			msm_offset->core_pwrctl_mask);
  2734	
  2735		ret = devm_request_threaded_irq(&pdev->dev, msm_host->pwr_irq, NULL,
  2736						sdhci_msm_pwr_irq, IRQF_ONESHOT,
  2737						dev_name(&pdev->dev), host);
  2738		if (ret) {
  2739			dev_err(&pdev->dev, "Request IRQ failed (%d)\n", ret);
  2740			goto clk_disable;
  2741		}
  2742	
  2743		msm_host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_NEED_RSP_BUSY;
  2744	
  2745		/* Set the timeout value to max possible */
  2746		host->max_timeout_count = 0xF;
  2747	
  2748		pm_runtime_get_noresume(&pdev->dev);
  2749		pm_runtime_set_active(&pdev->dev);
  2750		pm_runtime_enable(&pdev->dev);
  2751		pm_runtime_set_autosuspend_delay(&pdev->dev,
  2752						 MSM_MMC_AUTOSUSPEND_DELAY_MS);
  2753		pm_runtime_use_autosuspend(&pdev->dev);
  2754	
  2755		host->mmc_host_ops.start_signal_voltage_switch =
  2756			sdhci_msm_start_signal_voltage_switch;
  2757		host->mmc_host_ops.execute_tuning = sdhci_msm_execute_tuning;
  2758		/* Bayhub patch: overload the mmc_host_ops.execute_tuning routine */
  2759		if (of_find_property(node, "use-bayhub-bh201", NULL))
  2760			host->mmc_host_ops.execute_tuning = sdhci_bht_execute_tuning;
  2761		if (of_property_read_bool(node, "supports-cqe"))
  2762			ret = sdhci_msm_cqe_add_host(host, pdev);
  2763		else
  2764			ret = sdhci_add_host(host);
  2765		if (ret)
  2766			goto pm_runtime_disable;
  2767	
  2768		pm_runtime_mark_last_busy(&pdev->dev);
  2769		pm_runtime_put_autosuspend(&pdev->dev);
  2770	
  2771		return 0;
  2772	
  2773	pm_runtime_disable:
  2774		pm_runtime_disable(&pdev->dev);
  2775		pm_runtime_set_suspended(&pdev->dev);
  2776		pm_runtime_put_noidle(&pdev->dev);
  2777	clk_disable:
  2778		clk_bulk_disable_unprepare(ARRAY_SIZE(msm_host->bulk_clks),
  2779					   msm_host->bulk_clks);
  2780	bus_clk_disable:
  2781		if (!IS_ERR(msm_host->bus_clk))
  2782			clk_disable_unprepare(msm_host->bus_clk);
  2783	pltfm_free:
  2784		/* Bayhub patch: release assigned resource */
  2785		if (of_find_property(node, "use-bayhub-bh201", NULL))
  2786			sdhci_bht_resource_free(msm_host);
  2787		sdhci_pltfm_free(pdev);
  2788		return ret;
  2789	}
  2790	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
