Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8F04BF180
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 06:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiBVFlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 00:41:39 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiBVFlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 00:41:31 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFB89F3BF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 21:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645508461; x=1677044461;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MzoXTT1RzSdqKEdOaK0Z7AnwJmvHtP1CWUEKHGvLrE8=;
  b=F7MNEihUDGlzw+F5wUF+gEWpo/xFct/CwOBJNd5JIt8zdkiCQEOccIXw
   pslbMp4eY6zu87lOLkG0b2APR/nkGrWigO6H7LTidpV/xfU/iMF30jP0g
   uQTzoxiUzy7ClC1VpZa9cIKgYKq1M5J6TjmJIl1+WsDyCkFOyUOF4sffv
   w16OXAWOZ8P94zIg9Na2DWfOMAYTPGvGSMJwdjeb1dK14pfq7D2feiyrA
   EJeXcWVnNdCuaKUO3OMvr1d4XPiSnejvs7/zZdM+MTiYab7hTO6DhZw0q
   d1rywXdvr4dnKjBdZC2q0pdtzcIiFg9UE4FM1S2sbDMHlWagATHUjsLaZ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="312356469"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="312356469"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 20:38:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="507842543"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 21 Feb 2022 20:38:51 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMMwt-0002Kc-2V; Tue, 22 Feb 2022 04:38:51 +0000
Date:   Tue, 22 Feb 2022 12:38:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/ti/am65-cpsw-nuss.c:2493:17: sparse: sparse:
 incorrect type in assignment (different base types)
Message-ID: <202202221208.c53b6mBk-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   038101e6b2cd5c55f888f85db42ea2ad3aecb4b6
commit: 58356eb31d60dd8994e5067096ef1a09e4d9ceda net: ti: am65-cpsw-nuss: Add devlink support
date:   1 year ago
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20220222/202202221208.c53b6mBk-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=58356eb31d60dd8994e5067096ef1a09e4d9ceda
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 58356eb31d60dd8994e5067096ef1a09e4d9ceda
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/gpu/drm/tegra/ drivers/gpu/host1x/ drivers/hid/ drivers/irqchip/ drivers/net/ethernet/ti/ drivers/remoteproc/ drivers/scsi/hisi_sas/ security/integrity/ima/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/net/ethernet/ti/am65-cpsw-nuss.c:1917:55: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct am65_cpsw_ndev_stats [noderef] __percpu *stats @@     got void *data @@
   drivers/net/ethernet/ti/am65-cpsw-nuss.c:1917:55: sparse:     expected struct am65_cpsw_ndev_stats [noderef] __percpu *stats
   drivers/net/ethernet/ti/am65-cpsw-nuss.c:1917:55: sparse:     got void *data
   drivers/net/ethernet/ti/am65-cpsw-nuss.c:1974:49: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void *data @@     got struct am65_cpsw_ndev_stats [noderef] __percpu *stats @@
   drivers/net/ethernet/ti/am65-cpsw-nuss.c:1974:49: sparse:     expected void *data
   drivers/net/ethernet/ti/am65-cpsw-nuss.c:1974:49: sparse:     got struct am65_cpsw_ndev_stats [noderef] __percpu *stats
>> drivers/net/ethernet/ti/am65-cpsw-nuss.c:2493:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] id_temp @@     got restricted __be64 [usertype] @@
   drivers/net/ethernet/ti/am65-cpsw-nuss.c:2493:17: sparse:     expected unsigned long long [usertype] id_temp
   drivers/net/ethernet/ti/am65-cpsw-nuss.c:2493:17: sparse:     got restricted __be64 [usertype]

vim +2493 drivers/net/ethernet/ti/am65-cpsw-nuss.c

  2462	
  2463	static int am65_cpsw_nuss_probe(struct platform_device *pdev)
  2464	{
  2465		struct cpsw_ale_params ale_params = { 0 };
  2466		const struct of_device_id *of_id;
  2467		struct device *dev = &pdev->dev;
  2468		struct am65_cpsw_common *common;
  2469		struct device_node *node;
  2470		struct resource *res;
  2471		struct clk *clk;
  2472		u64 id_temp;
  2473		int ret, i;
  2474	
  2475		common = devm_kzalloc(dev, sizeof(struct am65_cpsw_common), GFP_KERNEL);
  2476		if (!common)
  2477			return -ENOMEM;
  2478		common->dev = dev;
  2479	
  2480		of_id = of_match_device(am65_cpsw_nuss_of_mtable, dev);
  2481		if (!of_id)
  2482			return -EINVAL;
  2483		common->pdata = *(const struct am65_cpsw_pdata *)of_id->data;
  2484	
  2485		am65_cpsw_nuss_apply_socinfo(common);
  2486	
  2487		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cpsw_nuss");
  2488		common->ss_base = devm_ioremap_resource(&pdev->dev, res);
  2489		if (IS_ERR(common->ss_base))
  2490			return PTR_ERR(common->ss_base);
  2491		common->cpsw_base = common->ss_base + AM65_CPSW_CPSW_NU_BASE;
  2492		/* Use device's physical base address as switch id */
> 2493		id_temp = cpu_to_be64(res->start);
  2494		memcpy(common->switch_id, &id_temp, sizeof(res->start));
  2495	
  2496		node = of_get_child_by_name(dev->of_node, "ethernet-ports");
  2497		if (!node)
  2498			return -ENOENT;
  2499		common->port_num = of_get_child_count(node);
  2500		if (common->port_num < 1 || common->port_num > AM65_CPSW_MAX_PORTS)
  2501			return -ENOENT;
  2502		of_node_put(node);
  2503	
  2504		common->rx_flow_id_base = -1;
  2505		init_completion(&common->tdown_complete);
  2506		common->tx_ch_num = 1;
  2507		common->pf_p0_rx_ptype_rrobin = false;
  2508		common->default_vlan = 1;
  2509	
  2510		common->ports = devm_kcalloc(dev, common->port_num,
  2511					     sizeof(*common->ports),
  2512					     GFP_KERNEL);
  2513		if (!common->ports)
  2514			return -ENOMEM;
  2515	
  2516		clk = devm_clk_get(dev, "fck");
  2517		if (IS_ERR(clk))
  2518			return dev_err_probe(dev, PTR_ERR(clk), "getting fck clock\n");
  2519		common->bus_freq = clk_get_rate(clk);
  2520	
  2521		pm_runtime_enable(dev);
  2522		ret = pm_runtime_get_sync(dev);
  2523		if (ret < 0) {
  2524			pm_runtime_put_noidle(dev);
  2525			pm_runtime_disable(dev);
  2526			return ret;
  2527		}
  2528	
  2529		node = of_get_child_by_name(dev->of_node, "mdio");
  2530		if (!node) {
  2531			dev_warn(dev, "MDIO node not found\n");
  2532		} else if (of_device_is_available(node)) {
  2533			struct platform_device *mdio_pdev;
  2534	
  2535			mdio_pdev = of_platform_device_create(node, NULL, dev);
  2536			if (!mdio_pdev) {
  2537				ret = -ENODEV;
  2538				goto err_pm_clear;
  2539			}
  2540	
  2541			common->mdio_dev =  &mdio_pdev->dev;
  2542		}
  2543		of_node_put(node);
  2544	
  2545		am65_cpsw_nuss_get_ver(common);
  2546	
  2547		/* init tx channels */
  2548		ret = am65_cpsw_nuss_init_tx_chns(common);
  2549		if (ret)
  2550			goto err_of_clear;
  2551		ret = am65_cpsw_nuss_init_rx_chns(common);
  2552		if (ret)
  2553			goto err_of_clear;
  2554	
  2555		ret = am65_cpsw_nuss_init_host_p(common);
  2556		if (ret)
  2557			goto err_of_clear;
  2558	
  2559		ret = am65_cpsw_nuss_init_slave_ports(common);
  2560		if (ret)
  2561			goto err_of_clear;
  2562	
  2563		/* init common data */
  2564		ale_params.dev = dev;
  2565		ale_params.ale_ageout = AM65_CPSW_ALE_AGEOUT_DEFAULT;
  2566		ale_params.ale_ports = common->port_num + 1;
  2567		ale_params.ale_regs = common->cpsw_base + AM65_CPSW_NU_ALE_BASE;
  2568		ale_params.dev_id = common->pdata.ale_dev_id;
  2569		ale_params.bus_freq = common->bus_freq;
  2570	
  2571		common->ale = cpsw_ale_create(&ale_params);
  2572		if (IS_ERR(common->ale)) {
  2573			dev_err(dev, "error initializing ale engine\n");
  2574			ret = PTR_ERR(common->ale);
  2575			goto err_of_clear;
  2576		}
  2577	
  2578		ret = am65_cpsw_init_cpts(common);
  2579		if (ret)
  2580			goto err_of_clear;
  2581	
  2582		/* init ports */
  2583		for (i = 0; i < common->port_num; i++)
  2584			am65_cpsw_nuss_slave_disable_unused(&common->ports[i]);
  2585	
  2586		dev_set_drvdata(dev, common);
  2587	
  2588		common->is_emac_mode = true;
  2589	
  2590		ret = am65_cpsw_nuss_init_ndevs(common);
  2591		if (ret)
  2592			goto err_of_clear;
  2593	
  2594		ret = am65_cpsw_nuss_register_ndevs(common);
  2595		if (ret)
  2596			goto err_of_clear;
  2597	
  2598		pm_runtime_put(dev);
  2599		return 0;
  2600	
  2601	err_of_clear:
  2602		of_platform_device_destroy(common->mdio_dev, NULL);
  2603	err_pm_clear:
  2604		pm_runtime_put_sync(dev);
  2605		pm_runtime_disable(dev);
  2606		return ret;
  2607	}
  2608	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
