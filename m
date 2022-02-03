Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67294A7E98
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 05:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349253AbiBCEVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 23:21:48 -0500
Received: from mga17.intel.com ([192.55.52.151]:29848 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245287AbiBCEVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 23:21:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643862105; x=1675398105;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lnRJAeoNlBOuReXM0IAo9uLQfX1piqeDJ1U14yaNvQM=;
  b=XwGT/Ea1R5dniJj9tQZSl2A27oS42fXsQLXqXS0qPhKPMSVIPNlQgc84
   o2jq4v7kcpvZt60mjNoO+NR+M3L5d2YxbAe09CotH1FanQo6El1Omblty
   nTJvr+zUe7aUns7uJNmX/iTFHE5D0JeT+zOswzlFaxSTjUOmHmIMCBqI4
   HNUU4JiRZoBsrnMtnKZV+rIz5l8CUU9pEcyDNmANxK4RnMKP+puSw2/1a
   RB9c8MkHXtrG/fZhLyvcZ+VebPdM5RehguAkfR1dDJkZ8pxGrQ3yzWvwH
   RHwiBwqNSFsuSYBC5uMo2uOFtfh1MReQHYs/OMFXaygTDSUwuyzbQ9RqM
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="228726757"
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="228726757"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 20:21:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="631217624"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 02 Feb 2022 20:21:42 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFTcr-000VYy-Uu; Thu, 03 Feb 2022 04:21:41 +0000
Date:   Thu, 3 Feb 2022 12:21:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bean Huo <huobean@gmail.com>, ulf.hansson@linaro.org,
        eugen.hristev@microchip.com, adrian.hunter@intel.com,
        nicolas.ferre@microchip.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, beanhuo@micron.com
Subject: Re: [PATCH 3/5] mmc: sdhci-omap: Use of_device_get_match_data()
 helper
Message-ID: <202202031221.asY8tGvu-lkp@intel.com>
References: <20220202180648.1252154-4-huobean@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202180648.1252154-4-huobean@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bean,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tegra/for-next]
[also build test WARNING on linus/master ulf-hansson-mmc-mirror/next v5.17-rc2 next-20220202]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Bean-Huo/Use-of_device_get_match_data-helper/20220203-020721
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git for-next
config: openrisc-randconfig-s031-20220131 (https://download.01.org/0day-ci/archive/20220203/202202031221.asY8tGvu-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/33ccc62e7dd0ac8f965521ed7ff44ff52182f4b0
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Bean-Huo/Use-of_device_get_match_data-helper/20220203-020721
        git checkout 33ccc62e7dd0ac8f965521ed7ff44ff52182f4b0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=openrisc SHELL=/bin/bash drivers/mmc/host/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/mmc/host/sdhci-omap.c:1226:14: sparse: sparse: incorrect type in assignment (different modifiers) @@     expected struct sdhci_omap_data *data @@     got void const * @@
   drivers/mmc/host/sdhci-omap.c:1226:14: sparse:     expected struct sdhci_omap_data *data
   drivers/mmc/host/sdhci-omap.c:1226:14: sparse:     got void const *

vim +1226 drivers/mmc/host/sdhci-omap.c

  1212	
  1213	static int sdhci_omap_probe(struct platform_device *pdev)
  1214	{
  1215		int ret;
  1216		u32 offset;
  1217		struct device *dev = &pdev->dev;
  1218		struct sdhci_host *host;
  1219		struct sdhci_pltfm_host *pltfm_host;
  1220		struct sdhci_omap_host *omap_host;
  1221		struct mmc_host *mmc;
  1222		struct sdhci_omap_data *data;
  1223		const struct soc_device_attribute *soc;
  1224		struct resource *regs;
  1225	
> 1226		data = of_device_get_match_data(&pdev->dev);
  1227		if (!data) {
  1228			dev_err(dev, "no sdhci omap data\n");
  1229			return -EINVAL;
  1230		}
  1231		offset = data->offset;
  1232	
  1233		regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
  1234		if (!regs)
  1235			return -ENXIO;
  1236	
  1237		host = sdhci_pltfm_init(pdev, &sdhci_omap_pdata,
  1238					sizeof(*omap_host));
  1239		if (IS_ERR(host)) {
  1240			dev_err(dev, "Failed sdhci_pltfm_init\n");
  1241			return PTR_ERR(host);
  1242		}
  1243	
  1244		pltfm_host = sdhci_priv(host);
  1245		omap_host = sdhci_pltfm_priv(pltfm_host);
  1246		omap_host->host = host;
  1247		omap_host->base = host->ioaddr;
  1248		omap_host->dev = dev;
  1249		omap_host->power_mode = MMC_POWER_UNDEFINED;
  1250		omap_host->timing = MMC_TIMING_LEGACY;
  1251		omap_host->flags = data->flags;
  1252		omap_host->omap_offset = data->omap_offset;
  1253		omap_host->con = -EINVAL; /* Prevent invalid restore on first resume */
  1254		host->ioaddr += offset;
  1255		host->mapbase = regs->start + offset;
  1256	
  1257		mmc = host->mmc;
  1258		sdhci_get_of_property(pdev);
  1259		ret = mmc_of_parse(mmc);
  1260		if (ret)
  1261			goto err_pltfm_free;
  1262	
  1263		soc = soc_device_match(sdhci_omap_soc_devices);
  1264		if (soc) {
  1265			omap_host->version = "rev11";
  1266			if (!strcmp(dev_name(dev), "4809c000.mmc"))
  1267				mmc->f_max = 96000000;
  1268			if (!strcmp(dev_name(dev), "480b4000.mmc"))
  1269				mmc->f_max = 48000000;
  1270			if (!strcmp(dev_name(dev), "480ad000.mmc"))
  1271				mmc->f_max = 48000000;
  1272		}
  1273	
  1274		if (!mmc_can_gpio_ro(mmc))
  1275			mmc->caps2 |= MMC_CAP2_NO_WRITE_PROTECT;
  1276	
  1277		pltfm_host->clk = devm_clk_get(dev, "fck");
  1278		if (IS_ERR(pltfm_host->clk)) {
  1279			ret = PTR_ERR(pltfm_host->clk);
  1280			goto err_pltfm_free;
  1281		}
  1282	
  1283		ret = clk_set_rate(pltfm_host->clk, mmc->f_max);
  1284		if (ret) {
  1285			dev_err(dev, "failed to set clock to %d\n", mmc->f_max);
  1286			goto err_pltfm_free;
  1287		}
  1288	
  1289		omap_host->pbias = devm_regulator_get_optional(dev, "pbias");
  1290		if (IS_ERR(omap_host->pbias)) {
  1291			ret = PTR_ERR(omap_host->pbias);
  1292			if (ret != -ENODEV)
  1293				goto err_pltfm_free;
  1294			dev_dbg(dev, "unable to get pbias regulator %d\n", ret);
  1295		}
  1296		omap_host->pbias_enabled = false;
  1297	
  1298		/*
  1299		 * omap_device_pm_domain has callbacks to enable the main
  1300		 * functional clock, interface clock and also configure the
  1301		 * SYSCONFIG register of omap devices. The callback will be invoked
  1302		 * as part of pm_runtime_get_sync.
  1303		 */
  1304		pm_runtime_use_autosuspend(dev);
  1305		pm_runtime_set_autosuspend_delay(dev, 50);
  1306		pm_runtime_enable(dev);
  1307		ret = pm_runtime_resume_and_get(dev);
  1308		if (ret) {
  1309			dev_err(dev, "pm_runtime_get_sync failed\n");
  1310			goto err_rpm_disable;
  1311		}
  1312	
  1313		ret = sdhci_omap_set_capabilities(host);
  1314		if (ret) {
  1315			dev_err(dev, "failed to set system capabilities\n");
  1316			goto err_rpm_put;
  1317		}
  1318	
  1319		host->mmc_host_ops.start_signal_voltage_switch =
  1320						sdhci_omap_start_signal_voltage_switch;
  1321		host->mmc_host_ops.set_ios = sdhci_omap_set_ios;
  1322		host->mmc_host_ops.card_busy = sdhci_omap_card_busy;
  1323		host->mmc_host_ops.execute_tuning = sdhci_omap_execute_tuning;
  1324		host->mmc_host_ops.enable_sdio_irq = sdhci_omap_enable_sdio_irq;
  1325	
  1326		/*
  1327		 * Switch to external DMA only if there is the "dmas" property and
  1328		 * ADMA is not available on the controller instance.
  1329		 */
  1330		if (device_property_present(dev, "dmas") &&
  1331		    !sdhci_omap_has_adma(omap_host, offset))
  1332			sdhci_switch_external_dma(host, true);
  1333	
  1334		if (device_property_read_bool(dev, "ti,non-removable")) {
  1335			dev_warn_once(dev, "using old ti,non-removable property\n");
  1336			mmc->caps |= MMC_CAP_NONREMOVABLE;
  1337		}
  1338	
  1339		/* R1B responses is required to properly manage HW busy detection. */
  1340		mmc->caps |= MMC_CAP_NEED_RSP_BUSY;
  1341	
  1342		/* Allow card power off and runtime PM for eMMC/SD card devices */
  1343		mmc->caps |= MMC_CAP_POWER_OFF_CARD | MMC_CAP_AGGRESSIVE_PM;
  1344	
  1345		ret = sdhci_setup_host(host);
  1346		if (ret)
  1347			goto err_rpm_put;
  1348	
  1349		ret = sdhci_omap_config_iodelay_pinctrl_state(omap_host);
  1350		if (ret)
  1351			goto err_cleanup_host;
  1352	
  1353		ret = __sdhci_add_host(host);
  1354		if (ret)
  1355			goto err_cleanup_host;
  1356	
  1357		/*
  1358		 * SDIO devices can use the dat1 pin as a wake-up interrupt. Some
  1359		 * devices like wl1xxx, use an out-of-band GPIO interrupt instead.
  1360		 */
  1361		omap_host->wakeirq = of_irq_get_byname(dev->of_node, "wakeup");
  1362		if (omap_host->wakeirq == -EPROBE_DEFER) {
  1363			ret = -EPROBE_DEFER;
  1364			goto err_cleanup_host;
  1365		}
  1366		if (omap_host->wakeirq > 0) {
  1367			device_init_wakeup(dev, true);
  1368			ret = dev_pm_set_dedicated_wake_irq(dev, omap_host->wakeirq);
  1369			if (ret) {
  1370				device_init_wakeup(dev, false);
  1371				goto err_cleanup_host;
  1372			}
  1373			host->mmc->pm_caps |= MMC_PM_KEEP_POWER | MMC_PM_WAKE_SDIO_IRQ;
  1374		}
  1375	
  1376		pm_runtime_mark_last_busy(dev);
  1377		pm_runtime_put_autosuspend(dev);
  1378	
  1379		return 0;
  1380	
  1381	err_cleanup_host:
  1382		sdhci_cleanup_host(host);
  1383	
  1384	err_rpm_put:
  1385		pm_runtime_mark_last_busy(dev);
  1386		pm_runtime_put_autosuspend(dev);
  1387	err_rpm_disable:
  1388		pm_runtime_dont_use_autosuspend(dev);
  1389		pm_runtime_disable(dev);
  1390	
  1391	err_pltfm_free:
  1392		sdhci_pltfm_free(pdev);
  1393		return ret;
  1394	}
  1395	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
