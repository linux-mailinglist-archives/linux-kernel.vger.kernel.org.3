Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C2F53441A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 21:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344266AbiEYTQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 15:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344721AbiEYTPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 15:15:15 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3820D222A4
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 12:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653506049; x=1685042049;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MWjLt/C0+HzwFey4r8iM3vFgAnnhjWJ6ptvZvdqX7W8=;
  b=ly84XSjWV3z0wGpxY8bA62NcE2KY+ApY5JtE9V1xc3asfl5eyFHMAaWo
   W/Zi/aA38JDkd3K9tPrXeGJt3Q1NShgvQ63+6XzNlcSn2qIvMItKA/cnY
   qiVeHOpzJvudSCrgAzi1m242MII7sanuAVzQn+/1aHR6TUtAVy6Laj4V7
   13VLlsvIK6OnU4Q5UsM/lGFXtIpmQoWS+du2hTmkDEZ4SLcKvlh3k+iUH
   73TAIEvM00ZFs7qaIXlBv5wlMqi8C9tGIJtcV76QC5bndnWbgSKqY0qE9
   ptfDrZFKzDbpV4fwTTbqyoD2WaxfjiROtqfrLKslXjTe0DeVWBFLI17Cs
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="255977176"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="255977176"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 12:14:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="527001913"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 25 May 2022 12:14:07 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntwSM-0003Fu-1y;
        Wed, 25 May 2022 19:14:06 +0000
Date:   Thu, 26 May 2022 03:13:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [vireshk-pm:opp/config 26/33]
 drivers/memory/tegra/tegra124-emc.c:1401:34: error: 'hw_versions'
 undeclared; did you mean 'hw_version'?
Message-ID: <202205260337.QJEzLw2I-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/config
head:   d730dc101c586defb49eeafd8eea9b7bb0baa01b
commit: c2dbafb4076bf639babb279975e034a050d9b72a [26/33] media: tegra: Migrate to dev_pm_opp_set_config()
config: arc-randconfig-r034-20220524 (https://download.01.org/0day-ci/archive/20220526/202205260337.QJEzLw2I-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/commit/?id=c2dbafb4076bf639babb279975e034a050d9b72a
        git remote add vireshk-pm https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git
        git fetch --no-tags vireshk-pm opp/config
        git checkout c2dbafb4076bf639babb279975e034a050d9b72a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/memory/tegra/tegra124-emc.c: In function 'tegra_emc_opp_table_init':
>> drivers/memory/tegra/tegra124-emc.c:1401:34: error: 'hw_versions' undeclared (first use in this function); did you mean 'hw_version'?
    1401 |                 .supported_hw = &hw_versions,
         |                                  ^~~~~~~~~~~
         |                                  hw_version
   drivers/memory/tegra/tegra124-emc.c:1401:34: note: each undeclared identifier is reported only once for each function it appears in


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
