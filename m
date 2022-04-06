Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4198B4F6953
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 20:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240376AbiDFSOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 14:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240401AbiDFSNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 14:13:30 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618821689ED;
        Wed,  6 Apr 2022 09:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649263875; x=1680799875;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YPU+Aki1buQ/+ir9E5A57K+53bb131dWf6cVT0d/K+Q=;
  b=JmsnT+QG1mzA3EOGERERrEJtpMOZ4cojWgSRYEXa7Ot3MUlMNUqfsW8T
   APQnKWzwRnWctclxyt+4arcA+6GGXcfAkRAFYgavQkL/SCbrjpaI23+Ap
   J0bAtLqis6kmoOGbiRFI1zccR7tlxi7yglTawvWyuWE+mn2UVx9g8vjRa
   2VEtzmFc+PFdnp5tVxkBQDOLrDsNPSUFQmfamimqJ2mrUlZYLn8SI1/F5
   ObWU+IjjT8JFN9oYPNMdtCwU4DGOdXeKX9WOAIXf1CJfQ2I1cZ2PN9+MO
   ude+BaCi7uUrNGOHJGUBc1RkqUyjD9Z7sk9JePtxAP1GaAbpbqdzb5dDv
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="241031715"
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="241031715"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 09:51:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="524014848"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 06 Apr 2022 09:51:11 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nc8sA-0004ZD-KD;
        Wed, 06 Apr 2022 16:51:10 +0000
Date:   Thu, 7 Apr 2022 00:50:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tony Huang <tonyhuang.sunplus@gmail.com>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.zabel@penguronix.de, krzysztof.kozlowski@linaro.org
Cc:     kbuild-all@lists.01.org, wells.lu@sunplus.com, lh.Kuo@sunplus.com,
        Tony Huang <tonyhuang.sunplus@gmail.com>
Subject: Re: [PATCH v6 2/2] mmc: Add mmc driver for Sunplus SP7021
Message-ID: <202204070029.JvyEor8F-lkp@intel.com>
References: <e99f3027590b5ab3938c2e2d8713bf6284a810b2.1649229258.git.tonyhuang.sunplus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e99f3027590b5ab3938c2e2d8713bf6284a810b2.1649229258.git.tonyhuang.sunplus@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

I love your patch! Yet something to improve:

[auto build test ERROR on ulf-hansson-mmc-mirror/next]
[cannot apply to robh/for-next linus/master v5.18-rc1 next-20220406]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Tony-Huang/Add-mmc-driver-for-Sunplus-SP7021-SOC/20220406-194106
base:   https://git.linaro.org/people/ulf.hansson/mmc-mirror.git next
config: nds32-buildonly-randconfig-r003-20220406 (https://download.01.org/0day-ci/archive/20220407/202204070029.JvyEor8F-lkp@intel.com/config)
compiler: nds32le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/325a0d9ca9d65f5616f794e0dbb04256312f739d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Tony-Huang/Add-mmc-driver-for-Sunplus-SP7021-SOC/20220406-194106
        git checkout 325a0d9ca9d65f5616f794e0dbb04256312f739d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash drivers/mmc/host/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   drivers/mmc/host/sunplus-mmc.c: In function 'spmmc_set_bus_timing':
>> drivers/mmc/host/sunplus-mmc.c:311:15: warning: variable 'timing_name' set but not used [-Wunused-but-set-variable]
     311 |         char *timing_name;
         |               ^~~~~~~~~~~
   drivers/mmc/host/sunplus-mmc.c: At top level:
>> drivers/mmc/host/sunplus-mmc.c:798:13: warning: no previous prototype for 'spmmc_irq' [-Wmissing-prototypes]
     798 | irqreturn_t spmmc_irq(int irq, void *dev_id)
         |             ^~~~~~~~~
>> drivers/mmc/host/sunplus-mmc.c:894:5: warning: no previous prototype for 'spmmc_get_cd' [-Wmissing-prototypes]
     894 | int spmmc_get_cd(struct mmc_host *mmc)
         |     ^~~~~~~~~~~~
   drivers/mmc/host/sunplus-mmc.c: In function 'spmmc_drv_probe':
>> drivers/mmc/host/sunplus-mmc.c:1021:22: warning: variable 'mode' set but not used [-Wunused-but-set-variable]
    1021 |         unsigned int mode;
         |                      ^~~~
   drivers/mmc/host/sunplus-mmc.c: At top level:
>> drivers/mmc/host/sunplus-mmc.c:1170:9: error: implicit declaration of function 'SYSTEM_SLEEP_PM_OPS'; did you mean 'SET_SYSTEM_SLEEP_PM_OPS'? [-Werror=implicit-function-declaration]
    1170 |         SYSTEM_SLEEP_PM_OPS(spmmc_pm_suspend, spmmc_pm_resume)
         |         ^~~~~~~~~~~~~~~~~~~
         |         SET_SYSTEM_SLEEP_PM_OPS
>> drivers/mmc/host/sunplus-mmc.c:1170:9: warning: initialization of 'int (*)(struct device *)' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   drivers/mmc/host/sunplus-mmc.c:1170:9: note: (near initialization for 'spmmc_pm_ops.prepare')
>> drivers/mmc/host/sunplus-mmc.c:1170:9: error: initializer element is not constant
   drivers/mmc/host/sunplus-mmc.c:1170:9: note: (near initialization for 'spmmc_pm_ops.prepare')
>> drivers/mmc/host/sunplus-mmc.c:1171:9: error: expected '}' before 'RUNTIME_PM_OPS'
    1171 |         RUNTIME_PM_OPS(spmmc_pm_runtime_suspend, spmmc_pm_runtime_resume, NULL)
         |         ^~~~~~~~~~~~~~
   drivers/mmc/host/sunplus-mmc.c:1169:47: note: to match this '{'
    1169 | static const struct dev_pm_ops spmmc_pm_ops = {
         |                                               ^
   drivers/mmc/host/sunplus-mmc.c:1169:32: warning: 'spmmc_pm_ops' defined but not used [-Wunused-const-variable=]
    1169 | static const struct dev_pm_ops spmmc_pm_ops = {
         |                                ^~~~~~~~~~~~
   drivers/mmc/host/sunplus-mmc.c:1160:12: warning: 'spmmc_pm_runtime_resume' defined but not used [-Wunused-function]
    1160 | static int spmmc_pm_runtime_resume(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/host/sunplus-mmc.c:1150:12: warning: 'spmmc_pm_runtime_suspend' defined but not used [-Wunused-function]
    1150 | static int spmmc_pm_runtime_suspend(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +1170 drivers/mmc/host/sunplus-mmc.c

  1015	
  1016	static int spmmc_drv_probe(struct platform_device *pdev)
  1017	{
  1018		struct mmc_host *mmc;
  1019		struct resource *res;
  1020		struct spmmc_host *host;
> 1021		unsigned int mode;
  1022		int ret = 0;
  1023	
  1024		mmc = mmc_alloc_host(sizeof(*host), &pdev->dev);
  1025		if (!mmc) {
  1026			ret = -ENOMEM;
  1027			goto probe_free_host;
  1028		}
  1029	
  1030		host = mmc_priv(mmc);
  1031		host->mmc = mmc;
  1032		host->power_state = MMC_POWER_OFF;
  1033		host->dma_int_threshold = 1024;
  1034		host->dmapio_mode = SPMMC_DMA_MODE;
  1035	
  1036		host->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
  1037		if (IS_ERR(host->base))
  1038			return PTR_ERR(host->base);
  1039	
  1040		host->clk = devm_clk_get(&pdev->dev, NULL);
  1041		if (IS_ERR(host->clk))
  1042			return dev_err_probe(&pdev->dev, PTR_ERR(host->clk), "clk get fail\n");
  1043	
  1044		host->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
  1045		if (IS_ERR(host->rstc))
  1046			return dev_err_probe(&pdev->dev, PTR_ERR(host->rstc), "rst get fail\n");
  1047	
  1048		host->irq = platform_get_irq(pdev, 0);
  1049		if (host->irq <= 0)
  1050			return host->irq;
  1051	
  1052		ret = devm_request_irq(&pdev->dev, host->irq, spmmc_irq, IRQF_SHARED,
  1053				       dev_name(&pdev->dev), host);
  1054		if (ret)
  1055			return ret;
  1056	
  1057		ret = clk_prepare_enable(host->clk);
  1058		if (ret)
  1059			return dev_err_probe(&pdev->dev, ret, "failed to enable clk\n");
  1060	
  1061		ret = mmc_of_parse(mmc);
  1062		if (ret)
  1063			goto probe_free_host;
  1064	
  1065		spin_lock_init(&host->lock);
  1066		mutex_init(&host->mrq_lock);
  1067		tasklet_init(&host->tsklet_finish_req, tsklet_func_finish_req, (unsigned long)host);
  1068		mmc->ops = &spmmc_ops;
  1069		mmc->f_min = SPMMC_MIN_CLK;
  1070		if (mmc->f_max > SPMMC_MAX_CLK)
  1071			mmc->f_max = SPMMC_MAX_CLK;
  1072	
  1073		mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
  1074		mmc->max_seg_size = SPMMC_MAX_BLK_COUNT * 512;
  1075		/* Host controller supports up to "SPMMC_MAX_DMA_MEMORY_SECTORS"*/
  1076		/* a.k.a. max scattered memory segments per request*/
  1077		mmc->max_segs = SPMMC_MAX_DMA_MEMORY_SECTORS;
  1078		mmc->max_req_size = SPMMC_MAX_BLK_COUNT * 512;
  1079		/* Limited by the max value of dma_size & data_length, set it to 512 bytes for now */
  1080		mmc->max_blk_size = 512;
  1081		mmc->max_blk_count = SPMMC_MAX_BLK_COUNT; /* Limited by sd_page_num */
  1082	
  1083		dev_set_drvdata(&pdev->dev, host);
  1084		spmmc_controller_init(host);
  1085		mode = (int)of_device_get_match_data(&pdev->dev);
  1086		spmmc_select_mode(host);
  1087		mmc_add_host(mmc);
  1088		host->tuning_info.enable_tuning = 1;
  1089		pm_runtime_set_active(&pdev->dev);
  1090		pm_runtime_enable(&pdev->dev);
  1091	
  1092		return ret;
  1093	
  1094	probe_free_host:
  1095		if (mmc)
  1096			mmc_free_host(mmc);
  1097	
  1098		return ret;
  1099	}
  1100	
  1101	static int spmmc_drv_remove(struct platform_device *dev)
  1102	{
  1103		struct spmmc_host *host = platform_get_drvdata(dev);
  1104	
  1105		mmc_remove_host(host->mmc);
  1106		clk_disable(host->clk);
  1107		clk_unprepare(host->clk);
  1108		pm_runtime_disable(&dev->dev);
  1109		platform_set_drvdata(dev, NULL);
  1110		mmc_free_host(host->mmc);
  1111	
  1112		return 0;
  1113	}
  1114	
  1115	static int spmmc_drv_suspend(struct platform_device *dev, pm_message_t state)
  1116	{
  1117		struct spmmc_host *host;
  1118	
  1119		host = platform_get_drvdata(dev);
  1120		mutex_lock(&host->mrq_lock); /* Make sure that no one is holding the controller */
  1121		mutex_unlock(&host->mrq_lock);
  1122		clk_disable(host->clk);
  1123	
  1124		return 0;
  1125	}
  1126	
  1127	static int spmmc_drv_resume(struct platform_device *dev)
  1128	{
  1129		struct spmmc_host *host;
  1130	
  1131		host = platform_get_drvdata(dev);
  1132	
  1133		return clk_enable(host->clk);
  1134	}
  1135	
  1136	static int spmmc_pm_suspend(struct device *dev)
  1137	{
  1138		pm_runtime_force_suspend(dev);
  1139	
  1140		return 0;
  1141	}
  1142	
  1143	static int spmmc_pm_resume(struct device *dev)
  1144	{
  1145		pm_runtime_force_resume(dev);
  1146	
  1147		return 0;
  1148	}
  1149	
  1150	static int spmmc_pm_runtime_suspend(struct device *dev)
  1151	{
  1152		struct spmmc_host *host;
  1153	
  1154		host = dev_get_drvdata(dev);
  1155		clk_disable(host->clk);
  1156	
  1157		return 0;
  1158	}
  1159	
  1160	static int spmmc_pm_runtime_resume(struct device *dev)
  1161	{
  1162		struct spmmc_host *host;
  1163	
  1164		host = dev_get_drvdata(dev);
  1165	
  1166		return clk_enable(host->clk);
  1167	}
  1168	
  1169	static const struct dev_pm_ops spmmc_pm_ops = {
> 1170		SYSTEM_SLEEP_PM_OPS(spmmc_pm_suspend, spmmc_pm_resume)
> 1171		RUNTIME_PM_OPS(spmmc_pm_runtime_suspend, spmmc_pm_runtime_resume, NULL)
  1172	};
  1173	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
