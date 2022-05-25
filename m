Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4089A53437A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 21:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236624AbiEYTDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 15:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbiEYTDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 15:03:08 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1F6B1DD
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 12:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653505387; x=1685041387;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SU179mfTpSWiQK7fl+PnzxUPgZEme8OU2i0LItLxxog=;
  b=mBA6rahvm0BTjLmlSniB+//jbjRDNyEEH0qvx6vQJVZZOD2Z5dDehJ7e
   D+5yzM/hCH7JNtrtNq+f9j4oAPXxCbBxKig155r7nW9w41k9toBuIKC3K
   oVsV+9Zdj6syK01DRnQHA0qvIrbvjRK3TxB85X+1mYcEq8apZjKR7Glh3
   Qfq4kHMKryTWbYm7ZcfH0AA/FomtkBenSzteVo0VegClvoGzxF62ZAg5d
   hdEyZpooHCpFyrDV1m419swT/085+hE+hQploYJ6d11Kby8io6jgf1zVR
   X6PsjCC8IWhX6kV+EtuNWFN+4r0+r7OoUzYZOIzfl0QvyrircPECPtXDO
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="271484464"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="271484464"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 12:03:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="609335504"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 25 May 2022 12:03:05 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntwHh-0003FY-8p;
        Wed, 25 May 2022 19:03:05 +0000
Date:   Thu, 26 May 2022 03:02:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [vireshk-pm:opp/config 26/33]
 drivers/memory/tegra/tegra124-emc.c:1401:20: error: use of undeclared
 identifier 'hw_versions'; did you mean 'hw_version'?
Message-ID: <202205260254.LPPZybMA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/config
head:   d730dc101c586defb49eeafd8eea9b7bb0baa01b
commit: c2dbafb4076bf639babb279975e034a050d9b72a [26/33] media: tegra: Migrate to dev_pm_opp_set_config()
config: arm64-randconfig-r031-20220524 (https://download.01.org/0day-ci/archive/20220526/202205260254.LPPZybMA-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d52a6e75b0c402c7f3b42a2b1b2873f151220947)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/commit/?id=c2dbafb4076bf639babb279975e034a050d9b72a
        git remote add vireshk-pm https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git
        git fetch --no-tags vireshk-pm opp/config
        git checkout c2dbafb4076bf639babb279975e034a050d9b72a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/memory/tegra/tegra124-emc.c:1401:20: error: use of undeclared identifier 'hw_versions'; did you mean 'hw_version'?
                   .supported_hw = &hw_versions,
                                    ^~~~~~~~~~~
                                    hw_version
   drivers/memory/tegra/tegra124-emc.c:1397:6: note: 'hw_version' declared here
           u32 hw_version = BIT(tegra_sku_info.soc_speedo_id);
               ^
   1 error generated.


vim +1401 drivers/memory/tegra/tegra124-emc.c

  1394	
  1395	static int tegra_emc_opp_table_init(struct tegra_emc *emc)
  1396	{
  1397		u32 hw_version = BIT(tegra_sku_info.soc_speedo_id);
  1398		struct opp_table *opp_table;
  1399		int err;
  1400		struct dev_pm_opp_config config = {
> 1401			.supported_hw = &hw_versions,
  1402			.supported_hw_count = 1,
  1403		};
  1404	
  1405		opp_table = dev_pm_opp_set_config(emc->dev, &config);
  1406		err = PTR_ERR_OR_ZERO(opp_table);
  1407		if (err) {
  1408			dev_err(emc->dev, "failed to set OPP config: %d\n", err);
  1409			return err;
  1410		}
  1411	
  1412		err = dev_pm_opp_of_add_table(emc->dev);
  1413		if (err) {
  1414			if (err == -ENODEV)
  1415				dev_err(emc->dev, "OPP table not found, please update your device tree\n");
  1416			else
  1417				dev_err(emc->dev, "failed to add OPP table: %d\n", err);
  1418	
  1419			goto put_hw_table;
  1420		}
  1421	
  1422		dev_info_once(emc->dev, "OPP HW ver. 0x%x, current clock rate %lu MHz\n",
  1423			      hw_version, clk_get_rate(emc->clk) / 1000000);
  1424	
  1425		/* first dummy rate-set initializes voltage state */
  1426		err = dev_pm_opp_set_rate(emc->dev, clk_get_rate(emc->clk));
  1427		if (err) {
  1428			dev_err(emc->dev, "failed to initialize OPP clock: %d\n", err);
  1429			goto remove_table;
  1430		}
  1431	
  1432		return 0;
  1433	
  1434	remove_table:
  1435		dev_pm_opp_of_remove_table(emc->dev);
  1436	put_hw_table:
  1437		dev_pm_opp_clear_config(opp_table);
  1438	
  1439		return err;
  1440	}
  1441	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
