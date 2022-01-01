Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56F84827A9
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 14:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbiAANGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 08:06:44 -0500
Received: from mga04.intel.com ([192.55.52.120]:40445 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232415AbiAANGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 08:06:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641042403; x=1672578403;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KGZ39jgLGAibRxu/lBMUBzuPb8bpU25zmWjglAp2yNU=;
  b=SyR8Cx/G0DNapEFz2Z3QCFOBN1+8z/QDlqVRY0qg2xSFuGFjWTnZYvhi
   E/153InslWs6dWAe5Uz2pMx0vSD/kHreC/htA66+oGWIF0ybEaG7ZLR44
   J6qFU6/po+v9OBODvNqn1Q4K34+DcYlDr2YFZsnW0gL8mHTbBSfFeKKjx
   VMC5GP9l3pqy4eijczHKHvmdR3wVlSewr9Q6UC6Xe803Mj04CBBFN7FMc
   G8J7gieqpeiLIZwdeJsAzEIBG4zqRcZLdSfhpYuTDKudnc/rbVFZWOlAr
   QIGb2Nxmwwnh3D/6fiXGTNfe5VclemfL+4dH2aReOoYoCI/imfTf3SVQB
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10214"; a="240710899"
X-IronPort-AV: E=Sophos;i="5.88,253,1635231600"; 
   d="scan'208";a="240710899"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2022 05:06:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,253,1635231600"; 
   d="scan'208";a="511434043"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 01 Jan 2022 05:06:40 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n3e5o-000CTP-72; Sat, 01 Jan 2022 13:06:40 +0000
Date:   Sat, 1 Jan 2022 21:06:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Trevor Wu <trevor.wu@mediatek.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: sound/soc/mediatek/common/mtk-btcvsd.c:1367:30: sparse: sparse:
 incorrect type in assignment (different address spaces)
Message-ID: <202201012105.oRHDnK62-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8008293888188c3923f5bd8a69370dae25ed14e5
commit: 6746cc858259985a945a07075a19ec4d24352407 ASoC: mediatek: mt8195: add platform driver
date:   4 months ago
config: alpha-randconfig-s032-20211117 (https://download.01.org/0day-ci/archive/20220101/202201012105.oRHDnK62-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6746cc858259985a945a07075a19ec4d24352407
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 6746cc858259985a945a07075a19ec4d24352407
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=alpha SHELL=/bin/bash drivers/dma/ sound/soc/mediatek/common/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> sound/soc/mediatek/common/mtk-btcvsd.c:1367:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [usertype] *bt_reg_pkt_r @@     got void [noderef] __iomem * @@
   sound/soc/mediatek/common/mtk-btcvsd.c:1367:30: sparse:     expected unsigned int [usertype] *bt_reg_pkt_r
   sound/soc/mediatek/common/mtk-btcvsd.c:1367:30: sparse:     got void [noderef] __iomem *
>> sound/soc/mediatek/common/mtk-btcvsd.c:1369:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [usertype] *bt_reg_pkt_w @@     got void [noderef] __iomem * @@
   sound/soc/mediatek/common/mtk-btcvsd.c:1369:30: sparse:     expected unsigned int [usertype] *bt_reg_pkt_w
   sound/soc/mediatek/common/mtk-btcvsd.c:1369:30: sparse:     got void [noderef] __iomem *
>> sound/soc/mediatek/common/mtk-btcvsd.c:1371:28: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [usertype] *bt_reg_ctl @@     got void [noderef] __iomem * @@
   sound/soc/mediatek/common/mtk-btcvsd.c:1371:28: sparse:     expected unsigned int [usertype] *bt_reg_ctl
   sound/soc/mediatek/common/mtk-btcvsd.c:1371:28: sparse:     got void [noderef] __iomem *

vim +1367 sound/soc/mediatek/common/mtk-btcvsd.c

4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1281  
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1282  static int mtk_btcvsd_snd_probe(struct platform_device *pdev)
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1283  {
b6052c3c7a78f5 Christophe JAILLET 2021-06-06  1284  	int ret;
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1285  	int irq_id;
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1286  	u32 offset[5] = {0, 0, 0, 0, 0};
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1287  	struct mtk_btcvsd_snd *btcvsd;
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1288  	struct device *dev = &pdev->dev;
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1289  
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1290  	/* init btcvsd private data */
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1291  	btcvsd = devm_kzalloc(dev, sizeof(*btcvsd), GFP_KERNEL);
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1292  	if (!btcvsd)
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1293  		return -ENOMEM;
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1294  	platform_set_drvdata(pdev, btcvsd);
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1295  	btcvsd->dev = dev;
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1296  
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1297  	/* init tx/rx */
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1298  	btcvsd->rx = devm_kzalloc(btcvsd->dev, sizeof(*btcvsd->rx), GFP_KERNEL);
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1299  	if (!btcvsd->rx)
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1300  		return -ENOMEM;
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1301  
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1302  	btcvsd->tx = devm_kzalloc(btcvsd->dev, sizeof(*btcvsd->tx), GFP_KERNEL);
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1303  	if (!btcvsd->tx)
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1304  		return -ENOMEM;
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1305  
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1306  	spin_lock_init(&btcvsd->tx_lock);
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1307  	spin_lock_init(&btcvsd->rx_lock);
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1308  
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1309  	init_waitqueue_head(&btcvsd->tx_wait);
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1310  	init_waitqueue_head(&btcvsd->rx_wait);
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1311  
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1312  	mtk_btcvsd_snd_tx_init(btcvsd);
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1313  	mtk_btcvsd_snd_rx_init(btcvsd);
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1314  
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1315  	/* irq */
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1316  	irq_id = platform_get_irq(pdev, 0);
cf9441adb1a355 Stephen Boyd       2019-07-30  1317  	if (irq_id <= 0)
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1318  		return irq_id < 0 ? irq_id : -ENXIO;
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1319  
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1320  	ret = devm_request_irq(dev, irq_id, mtk_btcvsd_snd_irq_handler,
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1321  			       IRQF_TRIGGER_LOW, "BTCVSD_ISR_Handle",
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1322  			       (void *)btcvsd);
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1323  	if (ret) {
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1324  		dev_err(dev, "could not request_irq for BTCVSD_ISR_Handle\n");
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1325  		return ret;
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1326  	}
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1327  
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1328  	btcvsd->irq_id = irq_id;
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1329  
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1330  	/* iomap */
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1331  	btcvsd->bt_pkv_base = of_iomap(dev->of_node, 0);
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1332  	if (!btcvsd->bt_pkv_base) {
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1333  		dev_err(dev, "iomap bt_pkv_base fail\n");
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1334  		return -EIO;
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1335  	}
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1336  
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1337  	btcvsd->bt_sram_bank2_base = of_iomap(dev->of_node, 1);
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1338  	if (!btcvsd->bt_sram_bank2_base) {
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1339  		dev_err(dev, "iomap bt_sram_bank2_base fail\n");
b6052c3c7a78f5 Christophe JAILLET 2021-06-06  1340  		ret = -EIO;
b6052c3c7a78f5 Christophe JAILLET 2021-06-06  1341  		goto unmap_pkv_err;
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1342  	}
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1343  
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1344  	btcvsd->infra = syscon_regmap_lookup_by_phandle(dev->of_node,
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1345  							"mediatek,infracfg");
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1346  	if (IS_ERR(btcvsd->infra)) {
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1347  		dev_err(dev, "cannot find infra controller: %ld\n",
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1348  			PTR_ERR(btcvsd->infra));
b6052c3c7a78f5 Christophe JAILLET 2021-06-06  1349  		ret = PTR_ERR(btcvsd->infra);
b6052c3c7a78f5 Christophe JAILLET 2021-06-06  1350  		goto unmap_bank2_err;
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1351  	}
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1352  
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1353  	/* get offset */
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1354  	ret = of_property_read_u32_array(dev->of_node, "mediatek,offset",
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1355  					 offset,
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1356  					 ARRAY_SIZE(offset));
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1357  	if (ret) {
766cc4965a3a2a Colin Ian King     2019-02-04  1358  		dev_warn(dev, "%s(), get offset fail, ret %d\n", __func__, ret);
b6052c3c7a78f5 Christophe JAILLET 2021-06-06  1359  		goto unmap_bank2_err;
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1360  	}
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1361  	btcvsd->infra_misc_offset = offset[0];
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1362  	btcvsd->conn_bt_cvsd_mask = offset[1];
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1363  	btcvsd->cvsd_mcu_read_offset = offset[2];
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1364  	btcvsd->cvsd_mcu_write_offset = offset[3];
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1365  	btcvsd->cvsd_packet_indicator = offset[4];
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1366  
4bd8597dc36c37 KaiChieh Chuang    2019-01-30 @1367  	btcvsd->bt_reg_pkt_r = btcvsd->bt_pkv_base +
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1368  			       btcvsd->cvsd_mcu_read_offset;
4bd8597dc36c37 KaiChieh Chuang    2019-01-30 @1369  	btcvsd->bt_reg_pkt_w = btcvsd->bt_pkv_base +
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1370  			       btcvsd->cvsd_mcu_write_offset;
4bd8597dc36c37 KaiChieh Chuang    2019-01-30 @1371  	btcvsd->bt_reg_ctl = btcvsd->bt_pkv_base +
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1372  			     btcvsd->cvsd_packet_indicator;
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1373  
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1374  	/* init state */
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1375  	mtk_btcvsd_snd_set_state(btcvsd, btcvsd->tx, BT_SCO_STATE_IDLE);
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1376  	mtk_btcvsd_snd_set_state(btcvsd, btcvsd->rx, BT_SCO_STATE_IDLE);
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1377  
b6052c3c7a78f5 Christophe JAILLET 2021-06-06  1378  	ret = devm_snd_soc_register_component(dev, &mtk_btcvsd_snd_platform,
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1379  					      NULL, 0);
b6052c3c7a78f5 Christophe JAILLET 2021-06-06  1380  	if (ret)
b6052c3c7a78f5 Christophe JAILLET 2021-06-06  1381  		goto unmap_bank2_err;
b6052c3c7a78f5 Christophe JAILLET 2021-06-06  1382  
b6052c3c7a78f5 Christophe JAILLET 2021-06-06  1383  	return 0;
b6052c3c7a78f5 Christophe JAILLET 2021-06-06  1384  
b6052c3c7a78f5 Christophe JAILLET 2021-06-06  1385  unmap_bank2_err:
b6052c3c7a78f5 Christophe JAILLET 2021-06-06  1386  	iounmap(btcvsd->bt_sram_bank2_base);
b6052c3c7a78f5 Christophe JAILLET 2021-06-06  1387  unmap_pkv_err:
b6052c3c7a78f5 Christophe JAILLET 2021-06-06  1388  	iounmap(btcvsd->bt_pkv_base);
b6052c3c7a78f5 Christophe JAILLET 2021-06-06  1389  	return ret;
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1390  }
4bd8597dc36c37 KaiChieh Chuang    2019-01-30  1391  

:::::: The code at line 1367 was first introduced by commit
:::::: 4bd8597dc36c376a2bb1ef2c72984615bdeb68de ASoC: mediatek: add btcvsd driver

:::::: TO: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
:::::: CC: Mark Brown <broonie@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
