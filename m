Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5E150E3EB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 17:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239589AbiDYPGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 11:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242660AbiDYPGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:06:16 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F281635C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 08:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650898989; x=1682434989;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4oB6OoqVRWigzoF3s/e7cGXReU33KeSaYIKnkPIisp0=;
  b=HIa1KmwNFe+0+vLfUbtHzH5o7JelOiPwWABJSPEUcKogbEyhw2h53AUm
   Ttt0XinJ9tbWocVLsm+JrYvA50dkg7dQNLv0chUwPLENjK4xc+sV22Ql1
   6I4uNgDnUKlHYtRd77KT6CS2QCEHgGphP+BIrY65CA8cqbItSzQt36fKN
   wYJ0oNWZHpEIA+SZHLojqEB07imTaTE85IaIcE9RUV8ZtfB7Wzi9FBs99
   gk8LNUwdx24OSAHTBQ64/qmW6HBFQQAbs0rZH3cqwquYWUO8FWHqjBBMO
   GOMa6mphRNlFIoYe6vdsbZHfRoI4EHQiSwREqpd7rBq46LY7mopmNZY18
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="247198590"
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="247198590"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 08:03:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="512672392"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 25 Apr 2022 08:03:06 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nj0F0-0002bG-1m;
        Mon, 25 Apr 2022 15:03:06 +0000
Date:   Mon, 25 Apr 2022 23:02:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: drivers/mmc/host/mxcmmc.c:1028:18: warning: cast to smaller integer
 type 'enum mxcmci_type' from 'const void *'
Message-ID: <202204252204.t0QXblB0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   af2d861d4cd2a4da5137f795ee3509e6f944a25b
commit: 8223e885e74b6424cd5b0ab1de4581ca017b7a4e mmc: mxc: Convert the driver to DT-only
date:   1 year, 5 months ago
config: arm64-buildonly-randconfig-r002-20220425 (https://download.01.org/0day-ci/archive/20220425/202204252204.t0QXblB0-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 1cddcfdc3c683b393df1a5c9063252eb60e52818)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8223e885e74b6424cd5b0ab1de4581ca017b7a4e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 8223e885e74b6424cd5b0ab1de4581ca017b7a4e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/mmc/host/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/mmc/host/mxcmmc.c:1028:18: warning: cast to smaller integer type 'enum mxcmci_type' from 'const void *' [-Wvoid-pointer-to-enum-cast]
           host->devtype = (enum mxcmci_type)of_device_get_match_data(&pdev->dev);
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +1028 drivers/mmc/host/mxcmmc.c

   979	
   980	static int mxcmci_probe(struct platform_device *pdev)
   981	{
   982		struct mmc_host *mmc;
   983		struct mxcmci_host *host;
   984		struct resource *res;
   985		int ret = 0, irq;
   986		bool dat3_card_detect = false;
   987		dma_cap_mask_t mask;
   988		struct imxmmc_platform_data *pdata = pdev->dev.platform_data;
   989	
   990		pr_info("i.MX/MPC512x SDHC driver\n");
   991	
   992		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
   993		irq = platform_get_irq(pdev, 0);
   994		if (irq < 0)
   995			return irq;
   996	
   997		mmc = mmc_alloc_host(sizeof(*host), &pdev->dev);
   998		if (!mmc)
   999			return -ENOMEM;
  1000	
  1001		host = mmc_priv(mmc);
  1002	
  1003		host->base = devm_ioremap_resource(&pdev->dev, res);
  1004		if (IS_ERR(host->base)) {
  1005			ret = PTR_ERR(host->base);
  1006			goto out_free;
  1007		}
  1008	
  1009		host->phys_base = res->start;
  1010	
  1011		ret = mmc_of_parse(mmc);
  1012		if (ret)
  1013			goto out_free;
  1014		mmc->ops = &mxcmci_ops;
  1015	
  1016		/* For devicetree parsing, the bus width is read from devicetree */
  1017		if (pdata)
  1018			mmc->caps = MMC_CAP_4_BIT_DATA | MMC_CAP_SDIO_IRQ;
  1019		else
  1020			mmc->caps |= MMC_CAP_SDIO_IRQ;
  1021	
  1022		/* MMC core transfer sizes tunable parameters */
  1023		mmc->max_blk_size = 2048;
  1024		mmc->max_blk_count = 65535;
  1025		mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
  1026		mmc->max_seg_size = mmc->max_req_size;
  1027	
> 1028		host->devtype = (enum mxcmci_type)of_device_get_match_data(&pdev->dev);
  1029	
  1030		/* adjust max_segs after devtype detection */
  1031		if (!is_mpc512x_mmc(host))
  1032			mmc->max_segs = 64;
  1033	
  1034		host->mmc = mmc;
  1035		host->pdata = pdata;
  1036		spin_lock_init(&host->lock);
  1037	
  1038		if (pdata)
  1039			dat3_card_detect = pdata->dat3_card_detect;
  1040		else if (mmc_card_is_removable(mmc)
  1041				&& !of_property_read_bool(pdev->dev.of_node, "cd-gpios"))
  1042			dat3_card_detect = true;
  1043	
  1044		ret = mmc_regulator_get_supply(mmc);
  1045		if (ret)
  1046			goto out_free;
  1047	
  1048		if (!mmc->ocr_avail) {
  1049			if (pdata && pdata->ocr_avail)
  1050				mmc->ocr_avail = pdata->ocr_avail;
  1051			else
  1052				mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
  1053		}
  1054	
  1055		if (dat3_card_detect)
  1056			host->default_irq_mask =
  1057				INT_CARD_INSERTION_EN | INT_CARD_REMOVAL_EN;
  1058		else
  1059			host->default_irq_mask = 0;
  1060	
  1061		host->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
  1062		if (IS_ERR(host->clk_ipg)) {
  1063			ret = PTR_ERR(host->clk_ipg);
  1064			goto out_free;
  1065		}
  1066	
  1067		host->clk_per = devm_clk_get(&pdev->dev, "per");
  1068		if (IS_ERR(host->clk_per)) {
  1069			ret = PTR_ERR(host->clk_per);
  1070			goto out_free;
  1071		}
  1072	
  1073		ret = clk_prepare_enable(host->clk_per);
  1074		if (ret)
  1075			goto out_free;
  1076	
  1077		ret = clk_prepare_enable(host->clk_ipg);
  1078		if (ret)
  1079			goto out_clk_per_put;
  1080	
  1081		mxcmci_softreset(host);
  1082	
  1083		host->rev_no = mxcmci_readw(host, MMC_REG_REV_NO);
  1084		if (host->rev_no != 0x400) {
  1085			ret = -ENODEV;
  1086			dev_err(mmc_dev(host->mmc), "wrong rev.no. 0x%08x. aborting.\n",
  1087				host->rev_no);
  1088			goto out_clk_put;
  1089		}
  1090	
  1091		mmc->f_min = clk_get_rate(host->clk_per) >> 16;
  1092		mmc->f_max = clk_get_rate(host->clk_per) >> 1;
  1093	
  1094		/* recommended in data sheet */
  1095		mxcmci_writew(host, 0x2db4, MMC_REG_READ_TO);
  1096	
  1097		mxcmci_writel(host, host->default_irq_mask, MMC_REG_INT_CNTR);
  1098	
  1099		if (!host->pdata) {
  1100			host->dma = dma_request_chan(&pdev->dev, "rx-tx");
  1101			if (IS_ERR(host->dma)) {
  1102				if (PTR_ERR(host->dma) == -EPROBE_DEFER) {
  1103					ret = -EPROBE_DEFER;
  1104					goto out_clk_put;
  1105				}
  1106	
  1107				/* Ignore errors to fall back to PIO mode */
  1108				host->dma = NULL;
  1109			}
  1110		} else {
  1111			res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
  1112			if (res) {
  1113				host->dmareq = res->start;
  1114				host->dma_data.peripheral_type = IMX_DMATYPE_SDHC;
  1115				host->dma_data.priority = DMA_PRIO_LOW;
  1116				host->dma_data.dma_request = host->dmareq;
  1117				dma_cap_zero(mask);
  1118				dma_cap_set(DMA_SLAVE, mask);
  1119				host->dma = dma_request_channel(mask, filter, host);
  1120			}
  1121		}
  1122		if (host->dma)
  1123			mmc->max_seg_size = dma_get_max_seg_size(
  1124					host->dma->device->dev);
  1125		else
  1126			dev_info(mmc_dev(host->mmc), "dma not available. Using PIO\n");
  1127	
  1128		INIT_WORK(&host->datawork, mxcmci_datawork);
  1129	
  1130		ret = devm_request_irq(&pdev->dev, irq, mxcmci_irq, 0,
  1131				       dev_name(&pdev->dev), host);
  1132		if (ret)
  1133			goto out_free_dma;
  1134	
  1135		platform_set_drvdata(pdev, mmc);
  1136	
  1137		if (host->pdata && host->pdata->init) {
  1138			ret = host->pdata->init(&pdev->dev, mxcmci_detect_irq,
  1139					host->mmc);
  1140			if (ret)
  1141				goto out_free_dma;
  1142		}
  1143	
  1144		timer_setup(&host->watchdog, mxcmci_watchdog, 0);
  1145	
  1146		mmc_add_host(mmc);
  1147	
  1148		return 0;
  1149	
  1150	out_free_dma:
  1151		if (host->dma)
  1152			dma_release_channel(host->dma);
  1153	
  1154	out_clk_put:
  1155		clk_disable_unprepare(host->clk_ipg);
  1156	out_clk_per_put:
  1157		clk_disable_unprepare(host->clk_per);
  1158	
  1159	out_free:
  1160		mmc_free_host(mmc);
  1161	
  1162		return ret;
  1163	}
  1164	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
