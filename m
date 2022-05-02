Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12613516955
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 04:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243739AbiEBCRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 22:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbiEBCRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 22:17:16 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2ADE393E1
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 19:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651457628; x=1682993628;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/T4k9vntaDfGuOw+mEwrRphDQ6ejkarytnqW2ROKQlQ=;
  b=Oj+6BwKfJlF7scacvmgRZN4sfk1JZ97s3Womq2inBJSD9Y/9mcg8V5Qx
   DbzLk1BRTAPdOGlSNa+ycTK+3poTq43E07SLUykpG4G3y2rLFPskhJAXv
   8uJGmp8//dW49OIP9IyZ9ADnOswHsdTFXCQb4fp+Q/JzsR3JOz1cMZyKE
   2do9PhdZpsmE1dnRez3a/YMExr/l1nBvM8w3Q2mTOI/CSBgbVwu3n0Psl
   XroDj4TR1PfBklLLx66tqd0AC07qu+g038iSBNcl/BpcmgZZLcoMwJKwc
   2qTS6FINjokhTKNj2EfGPT+eW9MbZnkGcg2IzfuzrrHY+/Urok6XQbenM
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10334"; a="292274293"
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="292274293"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2022 19:13:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="598408934"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 01 May 2022 19:13:46 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlLZJ-0009Cx-FP;
        Mon, 02 May 2022 02:13:45 +0000
Date:   Mon, 2 May 2022 10:13:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: drivers/dma/imx-dma.c:1048:20: warning: cast to smaller integer type
 'enum imx_dma_type' from 'const void *'
Message-ID: <202205021042.xPjJ6Z4J-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   672c0c5173427e6b3e2a9bbb7be51ceeec78093a
commit: 0ab785c894e618587e83bb67e8a8e96649868ad1 dmaengine: imx-dma: Remove unused .id_table
date:   1 year, 5 months ago
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220502/202205021042.xPjJ6Z4J-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 09325d36061e42b495d1f4c7e933e260eac260ed)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0ab785c894e618587e83bb67e8a8e96649868ad1
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 0ab785c894e618587e83bb67e8a8e96649868ad1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/dma/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/dma/imx-dma.c:1048:20: warning: cast to smaller integer type 'enum imx_dma_type' from 'const void *' [-Wvoid-pointer-to-enum-cast]
           imxdma->devtype = (enum imx_dma_type)of_device_get_match_data(&pdev->dev);
                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +1048 drivers/dma/imx-dma.c

  1035	
  1036	static int __init imxdma_probe(struct platform_device *pdev)
  1037	{
  1038		struct imxdma_engine *imxdma;
  1039		struct resource *res;
  1040		int ret, i;
  1041		int irq, irq_err;
  1042	
  1043		imxdma = devm_kzalloc(&pdev->dev, sizeof(*imxdma), GFP_KERNEL);
  1044		if (!imxdma)
  1045			return -ENOMEM;
  1046	
  1047		imxdma->dev = &pdev->dev;
> 1048		imxdma->devtype = (enum imx_dma_type)of_device_get_match_data(&pdev->dev);
  1049	
  1050		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
  1051		imxdma->base = devm_ioremap_resource(&pdev->dev, res);
  1052		if (IS_ERR(imxdma->base))
  1053			return PTR_ERR(imxdma->base);
  1054	
  1055		irq = platform_get_irq(pdev, 0);
  1056		if (irq < 0)
  1057			return irq;
  1058	
  1059		imxdma->dma_ipg = devm_clk_get(&pdev->dev, "ipg");
  1060		if (IS_ERR(imxdma->dma_ipg))
  1061			return PTR_ERR(imxdma->dma_ipg);
  1062	
  1063		imxdma->dma_ahb = devm_clk_get(&pdev->dev, "ahb");
  1064		if (IS_ERR(imxdma->dma_ahb))
  1065			return PTR_ERR(imxdma->dma_ahb);
  1066	
  1067		ret = clk_prepare_enable(imxdma->dma_ipg);
  1068		if (ret)
  1069			return ret;
  1070		ret = clk_prepare_enable(imxdma->dma_ahb);
  1071		if (ret)
  1072			goto disable_dma_ipg_clk;
  1073	
  1074		/* reset DMA module */
  1075		imx_dmav1_writel(imxdma, DCR_DRST, DMA_DCR);
  1076	
  1077		if (is_imx1_dma(imxdma)) {
  1078			ret = devm_request_irq(&pdev->dev, irq,
  1079					       dma_irq_handler, 0, "DMA", imxdma);
  1080			if (ret) {
  1081				dev_warn(imxdma->dev, "Can't register IRQ for DMA\n");
  1082				goto disable_dma_ahb_clk;
  1083			}
  1084			imxdma->irq = irq;
  1085	
  1086			irq_err = platform_get_irq(pdev, 1);
  1087			if (irq_err < 0) {
  1088				ret = irq_err;
  1089				goto disable_dma_ahb_clk;
  1090			}
  1091	
  1092			ret = devm_request_irq(&pdev->dev, irq_err,
  1093					       imxdma_err_handler, 0, "DMA", imxdma);
  1094			if (ret) {
  1095				dev_warn(imxdma->dev, "Can't register ERRIRQ for DMA\n");
  1096				goto disable_dma_ahb_clk;
  1097			}
  1098			imxdma->irq_err = irq_err;
  1099		}
  1100	
  1101		/* enable DMA module */
  1102		imx_dmav1_writel(imxdma, DCR_DEN, DMA_DCR);
  1103	
  1104		/* clear all interrupts */
  1105		imx_dmav1_writel(imxdma, (1 << IMX_DMA_CHANNELS) - 1, DMA_DISR);
  1106	
  1107		/* disable interrupts */
  1108		imx_dmav1_writel(imxdma, (1 << IMX_DMA_CHANNELS) - 1, DMA_DIMR);
  1109	
  1110		INIT_LIST_HEAD(&imxdma->dma_device.channels);
  1111	
  1112		dma_cap_set(DMA_SLAVE, imxdma->dma_device.cap_mask);
  1113		dma_cap_set(DMA_CYCLIC, imxdma->dma_device.cap_mask);
  1114		dma_cap_set(DMA_MEMCPY, imxdma->dma_device.cap_mask);
  1115		dma_cap_set(DMA_INTERLEAVE, imxdma->dma_device.cap_mask);
  1116	
  1117		/* Initialize 2D global parameters */
  1118		for (i = 0; i < IMX_DMA_2D_SLOTS; i++)
  1119			imxdma->slots_2d[i].count = 0;
  1120	
  1121		spin_lock_init(&imxdma->lock);
  1122	
  1123		/* Initialize channel parameters */
  1124		for (i = 0; i < IMX_DMA_CHANNELS; i++) {
  1125			struct imxdma_channel *imxdmac = &imxdma->channel[i];
  1126	
  1127			if (!is_imx1_dma(imxdma)) {
  1128				ret = devm_request_irq(&pdev->dev, irq + i,
  1129						dma_irq_handler, 0, "DMA", imxdma);
  1130				if (ret) {
  1131					dev_warn(imxdma->dev, "Can't register IRQ %d "
  1132						 "for DMA channel %d\n",
  1133						 irq + i, i);
  1134					goto disable_dma_ahb_clk;
  1135				}
  1136	
  1137				imxdmac->irq = irq + i;
  1138				timer_setup(&imxdmac->watchdog, imxdma_watchdog, 0);
  1139			}
  1140	
  1141			imxdmac->imxdma = imxdma;
  1142	
  1143			INIT_LIST_HEAD(&imxdmac->ld_queue);
  1144			INIT_LIST_HEAD(&imxdmac->ld_free);
  1145			INIT_LIST_HEAD(&imxdmac->ld_active);
  1146	
  1147			tasklet_setup(&imxdmac->dma_tasklet, imxdma_tasklet);
  1148			imxdmac->chan.device = &imxdma->dma_device;
  1149			dma_cookie_init(&imxdmac->chan);
  1150			imxdmac->channel = i;
  1151	
  1152			/* Add the channel to the DMAC list */
  1153			list_add_tail(&imxdmac->chan.device_node,
  1154				      &imxdma->dma_device.channels);
  1155		}
  1156	
  1157		imxdma->dma_device.dev = &pdev->dev;
  1158	
  1159		imxdma->dma_device.device_alloc_chan_resources = imxdma_alloc_chan_resources;
  1160		imxdma->dma_device.device_free_chan_resources = imxdma_free_chan_resources;
  1161		imxdma->dma_device.device_tx_status = imxdma_tx_status;
  1162		imxdma->dma_device.device_prep_slave_sg = imxdma_prep_slave_sg;
  1163		imxdma->dma_device.device_prep_dma_cyclic = imxdma_prep_dma_cyclic;
  1164		imxdma->dma_device.device_prep_dma_memcpy = imxdma_prep_dma_memcpy;
  1165		imxdma->dma_device.device_prep_interleaved_dma = imxdma_prep_dma_interleaved;
  1166		imxdma->dma_device.device_config = imxdma_config;
  1167		imxdma->dma_device.device_terminate_all = imxdma_terminate_all;
  1168		imxdma->dma_device.device_issue_pending = imxdma_issue_pending;
  1169	
  1170		platform_set_drvdata(pdev, imxdma);
  1171	
  1172		imxdma->dma_device.copy_align = DMAENGINE_ALIGN_4_BYTES;
  1173		dma_set_max_seg_size(imxdma->dma_device.dev, 0xffffff);
  1174	
  1175		ret = dma_async_device_register(&imxdma->dma_device);
  1176		if (ret) {
  1177			dev_err(&pdev->dev, "unable to register\n");
  1178			goto disable_dma_ahb_clk;
  1179		}
  1180	
  1181		if (pdev->dev.of_node) {
  1182			ret = of_dma_controller_register(pdev->dev.of_node,
  1183					imxdma_xlate, imxdma);
  1184			if (ret) {
  1185				dev_err(&pdev->dev, "unable to register of_dma_controller\n");
  1186				goto err_of_dma_controller;
  1187			}
  1188		}
  1189	
  1190		return 0;
  1191	
  1192	err_of_dma_controller:
  1193		dma_async_device_unregister(&imxdma->dma_device);
  1194	disable_dma_ahb_clk:
  1195		clk_disable_unprepare(imxdma->dma_ahb);
  1196	disable_dma_ipg_clk:
  1197		clk_disable_unprepare(imxdma->dma_ipg);
  1198		return ret;
  1199	}
  1200	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
