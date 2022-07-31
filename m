Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B871E585CBB
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 02:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbiGaAW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 20:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiGaAWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 20:22:55 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34E71400A
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 17:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659226973; x=1690762973;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=v/lLAqG7klp4yJ14dRYNO9gU4FGYkmFV6yKgEb7YtwY=;
  b=NhbmyJrFNInvo20WqOHWS4TXviIWf7pHdwVrMFMiMf4QnaVxoDuWtew6
   tAAoIYQVX3PKEy27zcpmLhRlh2t0S+cs0Teu/BCqdf+lrhtp+WDy9egA/
   eIVNAqLiEhQTYA9LRegw35wYsRLnPAAPjOau7V/Uoz82wPVJOBm6t0nnz
   oU/dK+0w24lvqEhvzGXFAkvkw2pgJLPbTLw/SgGx00HXwtWC3w3uCvq3J
   og/5VXNOSLgo+4QwMd2f7dg0PwfKvekNAlmgrfF6kMOqBVjmSC75z3bFk
   EWPekmIgtlI55BwpX35Cn+sd8dwlk+vM5arO75yb6MFrui3KucNJQRNTb
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10424"; a="314769338"
X-IronPort-AV: E=Sophos;i="5.93,205,1654585200"; 
   d="scan'208";a="314769338"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2022 17:22:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,205,1654585200"; 
   d="scan'208";a="669643131"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 30 Jul 2022 17:22:52 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHwjL-000DSZ-15;
        Sun, 31 Jul 2022 00:22:51 +0000
Date:   Sun, 31 Jul 2022 08:22:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Steev Klimaszewski <steev@kali.org>,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [steev:lenovo-x13s-5.19-rc8+suspend 73/134]
 drivers/clk/qcom/clk-regmap-phy-mux.c:30:15: error: implicit declaration of
 function 'FIELD_GET'; did you mean 'FOLL_GET'?
Message-ID: <202207310844.E9OItlb7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/steev/linux lenovo-x13s-5.19-rc8+suspend
head:   5455957b06f6a7fabc7eedae4add8e574533bf0d
commit: c5cd165b06389db2c6888ee46e58d9f761d5b64e [73/134] clk: qcom: regmap: add PHY clock source implementation
config: microblaze-randconfig-r002-20220731 (https://download.01.org/0day-ci/archive/20220731/202207310844.E9OItlb7-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/steev/linux/commit/c5cd165b06389db2c6888ee46e58d9f761d5b64e
        git remote add steev https://github.com/steev/linux
        git fetch --no-tags steev lenovo-x13s-5.19-rc8+suspend
        git checkout c5cd165b06389db2c6888ee46e58d9f761d5b64e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=microblaze SHELL=/bin/bash drivers/clk/qcom/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/clk/qcom/clk-regmap-phy-mux.c: In function 'phy_mux_is_enabled':
>> drivers/clk/qcom/clk-regmap-phy-mux.c:30:15: error: implicit declaration of function 'FIELD_GET'; did you mean 'FOLL_GET'? [-Werror=implicit-function-declaration]
      30 |         val = FIELD_GET(PHY_MUX_MASK, val);
         |               ^~~~~~~~~
         |               FOLL_GET
   drivers/clk/qcom/clk-regmap-phy-mux.c: In function 'phy_mux_enable':
>> drivers/clk/qcom/clk-regmap-phy-mux.c:44:35: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
      44 |                                   FIELD_PREP(PHY_MUX_MASK, PHY_MUX_PHY_SRC));
         |                                   ^~~~~~~~~~
   cc1: some warnings being treated as errors


vim +30 drivers/clk/qcom/clk-regmap-phy-mux.c

    22	
    23	static int phy_mux_is_enabled(struct clk_hw *hw)
    24	{
    25		struct clk_regmap *clkr = to_clk_regmap(hw);
    26		struct clk_regmap_phy_mux *phy_mux = to_clk_regmap_phy_mux(clkr);
    27		unsigned int val;
    28	
    29		regmap_read(clkr->regmap, phy_mux->reg, &val);
  > 30		val = FIELD_GET(PHY_MUX_MASK, val);
    31	
    32		WARN_ON(val != PHY_MUX_PHY_SRC && val != PHY_MUX_REF_SRC);
    33	
    34		return val == PHY_MUX_PHY_SRC;
    35	}
    36	
    37	static int phy_mux_enable(struct clk_hw *hw)
    38	{
    39		struct clk_regmap *clkr = to_clk_regmap(hw);
    40		struct clk_regmap_phy_mux *phy_mux = to_clk_regmap_phy_mux(clkr);
    41	
    42		return regmap_update_bits(clkr->regmap, phy_mux->reg,
    43					  PHY_MUX_MASK,
  > 44					  FIELD_PREP(PHY_MUX_MASK, PHY_MUX_PHY_SRC));
    45	}
    46	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
