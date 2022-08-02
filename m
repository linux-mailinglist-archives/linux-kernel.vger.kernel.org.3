Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4555880C2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 19:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiHBRHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 13:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiHBRH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 13:07:29 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D53733405
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 10:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659460048; x=1690996048;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zV6cKLFN2FvGEebMveN7G1Wd2cB6N+bA0EAS1zMTi4g=;
  b=HetDYc7skPQ0ZnAS4ZoDOGiUvswU3Rif46TDeYr2unB1KkXZwYE9iv8B
   4BwVrmDI4BB/ChnUhs5WBeZxiYkckjrVWQbZWUkj/8i6xsci7J/v7a2tP
   LARIoQrLc9eGXjnpKRwlFVGFeBobat488aYEVMblcDf+NxALr9Hjj4b5Y
   H7CA0pJECHs8nQDXUBI8AVzZuEZ1VXfCQlrWD1rFU1cXIE5IWg6xDhUck
   Je2spRvDAuXIKbFxiStNf0/tp/Wq2MQuySQxM9rdmnrGfJS7wtZljBH4m
   jA0EcRR5mR6BxBtxNdnzmiVuav/EgB4LrOQQ/18CQ60F91FGY9neLOwY7
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="289479740"
X-IronPort-AV: E=Sophos;i="5.93,211,1654585200"; 
   d="scan'208";a="289479740"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 10:07:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,211,1654585200"; 
   d="scan'208";a="930048123"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 02 Aug 2022 10:07:26 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oIvMc-000GFJ-0j;
        Tue, 02 Aug 2022 17:07:26 +0000
Date:   Wed, 3 Aug 2022 01:07:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Steev Klimaszewski <steev@kali.org>,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [steev:lenovo-x13s-5.19.0 73/150]
 drivers/clk/qcom/clk-regmap-phy-mux.c:30:15: error: implicit declaration of
 function 'FIELD_GET'
Message-ID: <202208030144.XL7rBrWY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/steev/linux lenovo-x13s-5.19.0
head:   3f70e98ff07f044b171ef59e1bb91545e1f65818
commit: a55a3f8acea99d052a3ce9e93ca8404fb8f4957b [73/150] clk: qcom: regmap: add PHY clock source implementation
config: riscv-randconfig-r042-20220801 (https://download.01.org/0day-ci/archive/20220803/202208030144.XL7rBrWY-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/steev/linux/commit/a55a3f8acea99d052a3ce9e93ca8404fb8f4957b
        git remote add steev https://github.com/steev/linux
        git fetch --no-tags steev lenovo-x13s-5.19.0
        git checkout a55a3f8acea99d052a3ce9e93ca8404fb8f4957b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/clk/qcom/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/clk/qcom/clk-regmap-phy-mux.c: In function 'phy_mux_is_enabled':
>> drivers/clk/qcom/clk-regmap-phy-mux.c:30:15: error: implicit declaration of function 'FIELD_GET' [-Werror=implicit-function-declaration]
      30 |         val = FIELD_GET(PHY_MUX_MASK, val);
         |               ^~~~~~~~~
   drivers/clk/qcom/clk-regmap-phy-mux.c: In function 'phy_mux_enable':
>> drivers/clk/qcom/clk-regmap-phy-mux.c:44:35: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
      44 |                                   FIELD_PREP(PHY_MUX_MASK, PHY_MUX_PHY_SRC));
         |                                   ^~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/FIELD_GET +30 drivers/clk/qcom/clk-regmap-phy-mux.c

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
