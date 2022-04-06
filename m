Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFC04F658D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237718AbiDFQkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238059AbiDFQkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:40:13 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE5836D099;
        Wed,  6 Apr 2022 06:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649253549; x=1680789549;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4sO0YOVEXn9YOIeEYa0+2adTXILjyuEQFtBZ73zwYmY=;
  b=f4RzOkK3vgt4J3VgllCMUOoXLDtliTqh/NkufQzX+esWjYFBwvrV+pAH
   GhsdIDARS/Z2ce2ar0E6fjFmYVA4ErdWhusW4AkIrEku4Nj08icx79aLY
   6S4rN7JPGITyzqQ9me4MRto50U2Jx9sCtNnCg+k9+sPF2mTo0rs3MWYuM
   MtEHYSe1T8uw+v5uhis/6f1oVkdrxsBZPJbgXCUcLwVs6KxtRgcwsu08V
   4RZ27muYivI/QjWs7AJFuO3PXOUZuY6XU3KUiG9GjlhqCqCUfXlQRShKH
   1HEpwn3tygIeFCtlsXe7U6Wllm5G5fRJDoyT4MlvKAvbG54hs4RnkGOrz
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="347492204"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="347492204"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 06:59:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="505737292"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 06 Apr 2022 06:59:04 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nc6Bb-0004Sn-A4;
        Wed, 06 Apr 2022 13:59:03 +0000
Date:   Wed, 6 Apr 2022 21:58:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tony Huang <tonyhuang.sunplus@gmail.com>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.zabel@penguronix.de, krzysztof.kozlowski@linaro.org
Cc:     kbuild-all@lists.01.org, wells.lu@sunplus.com, lh.Kuo@sunplus.com,
        Tony Huang <tonyhuang.sunplus@gmail.com>
Subject: Re: [PATCH v6 2/2] mmc: Add mmc driver for Sunplus SP7021
Message-ID: <202204062111.QhaaiQEq-lkp@intel.com>
References: <e99f3027590b5ab3938c2e2d8713bf6284a810b2.1649229258.git.tonyhuang.sunplus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e99f3027590b5ab3938c2e2d8713bf6284a810b2.1649229258.git.tonyhuang.sunplus@gmail.com>
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

Hi Tony,

I love your patch! Perhaps something to improve:

[auto build test WARNING on ulf-hansson-mmc-mirror/next]
[cannot apply to robh/for-next linus/master v5.18-rc1 next-20220406]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Tony-Huang/Add-mmc-driver-for-Sunplus-SP7021-SOC/20220406-194106
base:   https://git.linaro.org/people/ulf.hansson/mmc-mirror.git next
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220406/202204062111.QhaaiQEq-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/325a0d9ca9d65f5616f794e0dbb04256312f739d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Tony-Huang/Add-mmc-driver-for-Sunplus-SP7021-SOC/20220406-194106
        git checkout 325a0d9ca9d65f5616f794e0dbb04256312f739d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/mmc/host/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

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
   drivers/mmc/host/sunplus-mmc.c:1170:9: error: implicit declaration of function 'SYSTEM_SLEEP_PM_OPS'; did you mean 'SET_SYSTEM_SLEEP_PM_OPS'? [-Werror=implicit-function-declaration]
    1170 |         SYSTEM_SLEEP_PM_OPS(spmmc_pm_suspend, spmmc_pm_resume)
         |         ^~~~~~~~~~~~~~~~~~~
         |         SET_SYSTEM_SLEEP_PM_OPS
>> drivers/mmc/host/sunplus-mmc.c:1170:9: warning: initialization of 'int (*)(struct device *)' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   drivers/mmc/host/sunplus-mmc.c:1170:9: note: (near initialization for 'spmmc_pm_ops.prepare')
   drivers/mmc/host/sunplus-mmc.c:1170:9: error: initializer element is not constant
   drivers/mmc/host/sunplus-mmc.c:1170:9: note: (near initialization for 'spmmc_pm_ops.prepare')
   drivers/mmc/host/sunplus-mmc.c:1171:9: error: expected '}' before 'RUNTIME_PM_OPS'
    1171 |         RUNTIME_PM_OPS(spmmc_pm_runtime_suspend, spmmc_pm_runtime_resume, NULL)
         |         ^~~~~~~~~~~~~~
   drivers/mmc/host/sunplus-mmc.c:1169:47: note: to match this '{'
    1169 | static const struct dev_pm_ops spmmc_pm_ops = {
         |                                               ^
   drivers/mmc/host/sunplus-mmc.c:1160:12: warning: 'spmmc_pm_runtime_resume' defined but not used [-Wunused-function]
    1160 | static int spmmc_pm_runtime_resume(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/host/sunplus-mmc.c:1150:12: warning: 'spmmc_pm_runtime_suspend' defined but not used [-Wunused-function]
    1150 | static int spmmc_pm_runtime_suspend(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/timing_name +311 drivers/mmc/host/sunplus-mmc.c

   304	
   305	static void spmmc_set_bus_timing(struct spmmc_host *host, unsigned int timing)
   306	{
   307		u32 value = readl(host->base + SPMMC_SD_CONFIG1_REG);
   308		int clkdiv = FIELD_GET(SPMMC_CLOCK_DIVISION, readl(host->base + SPMMC_SD_CONFIG0_REG));
   309		int delay = clkdiv / 2 < 7 ? clkdiv / 2 : 7;
   310		int hs_en = 1;
 > 311		char *timing_name;
   312	
   313		host->ddr_enabled = 0;
   314		switch (timing) {
   315		case MMC_TIMING_LEGACY:
   316			hs_en = 0;
   317			timing_name = "legacy";
   318			break;
   319		case MMC_TIMING_MMC_HS:
   320			timing_name = "mmc high-speed";
   321			break;
   322		case MMC_TIMING_SD_HS:
   323			timing_name = "sd high-speed";
   324			break;
   325		case MMC_TIMING_UHS_SDR50:
   326			timing_name = "sd uhs SDR50";
   327			break;
   328		case MMC_TIMING_UHS_SDR104:
   329			timing_name = "sd uhs SDR104";
   330			break;
   331		case MMC_TIMING_UHS_DDR50:
   332			host->ddr_enabled = 1;
   333			timing_name = "sd uhs DDR50";
   334			break;
   335		case MMC_TIMING_MMC_DDR52:
   336			host->ddr_enabled = 1;
   337			timing_name = "mmc DDR52";
   338			break;
   339		case MMC_TIMING_MMC_HS200:
   340			timing_name = "mmc HS200";
   341			break;
   342		default:
   343			timing_name = "invalid";
   344			hs_en = 0;
   345			break;
   346		}
   347	
   348		if (hs_en) {
   349			value |= SPMMC_SD_HIGH_SPEED_EN; /* sd_high_speed_en */
   350			writel(value, host->base + SPMMC_SD_CONFIG1_REG);
   351			value = readl(host->base + SPMMC_SD_TIMING_CONFIG0_REG);
   352			value |= FIELD_PREP(SPMMC_SD_WRITE_DATA_DELAY, delay); /* sd_wr_dat_dly_sel */
   353			value |= FIELD_PREP(SPMMC_SD_WRITE_COMMAND_DELAY, delay); /* sd_wr_cmd_dly_sel */
   354			writel(value, host->base + SPMMC_SD_TIMING_CONFIG0_REG);
   355		} else {
   356			value &= ~SPMMC_SD_HIGH_SPEED_EN;
   357			writel(value, host->base + SPMMC_SD_CONFIG1_REG);
   358		}
   359		if (host->ddr_enabled) {
   360			value = readl(host->base + SPMMC_SD_CONFIG0_REG);
   361			value |= SPMMC_SD_DDR_MODE; /* sdddrmode */
   362			writel(value, host->base + SPMMC_SD_CONFIG0_REG);
   363		} else {
   364			value = readl(host->base + SPMMC_SD_CONFIG0_REG);
   365			value &= ~SPMMC_SD_DDR_MODE;
   366			writel(value, host->base + SPMMC_SD_CONFIG0_REG);
   367		}
   368	}
   369	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
