Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0F8520210
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 18:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238885AbiEIQR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 12:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238834AbiEIQRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 12:17:25 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12C31BDDA8
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 09:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652112810; x=1683648810;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QbP6qqb6nRewydwlAAGi0onfGm51kHMVECSNbBIu3n8=;
  b=bnliK+baWZrLCprwmB6s+xT4Qk1Xz9PUvubpMK7LEg+G0rZHIkAOGsCI
   4XxBvaWKhoMH4Qlxi9u36Xx2PdYBaKVL7RnTwxtTU4lgCmqg8kdgFu1OK
   cEYHrGx2+oSPvkzs6l67nGdUmUHsSrMjxF6zNSESfMJGGHrMmuY+oPtn/
   dz5yZ/NK0yTYx/2VcI9Fy1PFv6d6fxTlCh/bGs0NSykatCtuNlMGBlFfh
   scq/uDuPdvVpDzD7OyasC5sQgBLkHhYilaTjgzBgYYLEo1MOwqcxCgAB2
   qqzEgHHNhLTc3JrOwkjLKAf4GEJEt899/CbCBgxc39FrU5s4G+axSRxnk
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="249631880"
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="249631880"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 09:13:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="738243827"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 09 May 2022 09:13:25 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1no60i-000GeE-KI;
        Mon, 09 May 2022 16:13:24 +0000
Date:   Tue, 10 May 2022 00:13:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [krzk-github:n/qcom-ufs-opp-v3 10/13] drivers/opp/core.c:1297:8:
 warning: variable 'ret' is used uninitialized whenever 'if' condition is
 false
Message-ID: <202205100055.CcUduSmT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/krzk/linux n/qcom-ufs-opp-v3
head:   22a49fd92d5e31234d4174cdf1fdade79f38ae3d
commit: ff3c34983e1cca80d8c081ea99e0117c5c38c6c3 [10/13] PM: opp: allow control of multiple clocks
config: arm-randconfig-r015-20220509 (https://download.01.org/0day-ci/archive/20220510/202205100055.CcUduSmT-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a385645b470e2d3a1534aae618ea56b31177639f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/krzk/linux/commit/ff3c34983e1cca80d8c081ea99e0117c5c38c6c3
        git remote add krzk-github https://github.com/krzk/linux
        git fetch --no-tags krzk-github n/qcom-ufs-opp-v3
        git checkout ff3c34983e1cca80d8c081ea99e0117c5c38c6c3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/opp/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/opp/core.c:1297:8: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
                           if (opp_table->clks)
                               ^~~~~~~~~~~~~~~
   drivers/opp/core.c:1335:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   drivers/opp/core.c:1297:4: note: remove the 'if' if its condition is always true
                           if (opp_table->clks)
                           ^~~~~~~~~~~~~~~~~~~~
   drivers/opp/core.c:1280:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
   1 warning generated.


vim +1297 drivers/opp/core.c

  1263	
  1264	/**
  1265	 * dev_pm_opp_set_rate() - Configure new OPP based on frequency
  1266	 * @dev:	 device for which we do this operation
  1267	 * @target_freq: frequency to achieve
  1268	 *
  1269	 * This configures the power-supplies to the levels specified by the OPP
  1270	 * corresponding to the target_freq, and programs the clock to a value <=
  1271	 * target_freq, as rounded by clk_round_rate(). Device wanting to run at fmax
  1272	 * provided by the opp, should have already rounded to the target OPP's
  1273	 * frequency.
  1274	 */
  1275	int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
  1276	{
  1277		struct opp_table *opp_table;
  1278		unsigned long freq = 0, temp_freq;
  1279		struct dev_pm_opp *opp = NULL;
  1280		int ret;
  1281	
  1282		opp_table = _find_opp_table(dev);
  1283		if (IS_ERR(opp_table)) {
  1284			dev_err(dev, "%s: device's opp table doesn't exist\n", __func__);
  1285			return PTR_ERR(opp_table);
  1286		}
  1287	
  1288		if (target_freq) {
  1289			/*
  1290			 * For IO devices which require an OPP on some platforms/SoCs
  1291			 * while just needing to scale the clock on some others
  1292			 * we look for empty OPP tables with just a clock handle and
  1293			 * scale only the clk. This makes dev_pm_opp_set_rate()
  1294			 * equivalent to a clk_set_rate()
  1295			 */
  1296			if (!_get_opp_count(opp_table)) {
> 1297				if (opp_table->clks)
  1298					ret = _generic_set_opp_clk_only(dev,
  1299									opp_table->clks[0],
  1300									target_freq);
  1301				goto put_opp_table;
  1302			}
  1303	
  1304			if (opp_table->clks)
  1305				freq = clk_round_rate(opp_table->clks[0], target_freq);
  1306			if ((long)freq <= 0)
  1307				freq = target_freq;
  1308	
  1309			/*
  1310			 * The clock driver may support finer resolution of the
  1311			 * frequencies than the OPP table, don't update the frequency we
  1312			 * pass to clk_set_rate() here.
  1313			 */
  1314			temp_freq = freq;
  1315			opp = _find_freq_ceil(opp_table, &temp_freq);
  1316			if (IS_ERR(opp)) {
  1317				ret = PTR_ERR(opp);
  1318				dev_err(dev, "%s: failed to find OPP for freq %lu (%d)\n",
  1319					__func__, freq, ret);
  1320				goto put_opp_table;
  1321			}
  1322			/*
  1323			 * opp->rates are used for scaling clocks, so be sure accurate
  1324			 * 'freq' is used, instead what was defined via e.g. Devicetree.
  1325			 */
  1326			opp->rates[0] = freq;
  1327		}
  1328	
  1329		ret = _set_opp(dev, opp_table, opp, freq);
  1330	
  1331		if (target_freq)
  1332			dev_pm_opp_put(opp);
  1333	put_opp_table:
  1334		dev_pm_opp_put_opp_table(opp_table);
  1335		return ret;
  1336	}
  1337	EXPORT_SYMBOL_GPL(dev_pm_opp_set_rate);
  1338	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
