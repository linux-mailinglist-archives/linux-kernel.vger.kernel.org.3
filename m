Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66523585E77
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 12:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiGaKqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 06:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiGaKqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 06:46:09 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEFD63E7
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 03:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659264367; x=1690800367;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=b7rPqzWvTB28jUtMPTK/RVgxxjAwMYIvz3AdRth09Os=;
  b=ExN1aPC2kbLeVvZj0aU26ZHFfIlUwfYbxprfUkYFBjsEC9iHfB+iYYjP
   hm9jLICoR9kG0xYaLz5bs4k4ZmAsWCPIS5s8aQdDEECTePg4FZmXGnEz2
   4pSMGSZSeNLlnk2l5hU8Nkz7+ySf+NDdj6odflsTQzLeRLTEEUraP8QFj
   GxUsabsY7Ilg28IRhbmEX/JAWqVrGbscwWj6CJ525rtELuOsZk9WCbzN/
   zh6AGoJfyD8+zMr0SrpM7yZAUR7YfI46xdlTonp+Aq58zg75nCwIBNpKg
   u1X9p7u2ZaDSU6+re93PJj6cowWMRtIEePOLy2As/AZ1rv5eKXaO0f8uO
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10424"; a="290192616"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="290192616"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 03:46:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="634587333"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 31 Jul 2022 03:46:04 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oI6SR-000E2u-2C;
        Sun, 31 Jul 2022 10:46:03 +0000
Date:   Sun, 31 Jul 2022 18:45:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Steev Klimaszewski <steev@kali.org>
Subject: [steev:linux-v5.19.0-rc8-tests 116/182]
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c:1747:10: error: initializer
 element is not a compile-time constant
Message-ID: <202207311819.h1pTmAEB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/steev/linux linux-v5.19.0-rc8-tests
head:   171125613e081f0d0d9aeb710dc7469ce2c6a219
commit: 2a19272fda8c6e9423a40b3b217a6c75333f48ed [116/182] drm/msm/dpu: make dpu hardware catalog static const
config: arm64-buildonly-randconfig-r005-20220731 (https://download.01.org/0day-ci/archive/20220731/202207311819.h1pTmAEB-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 52cd00cabf479aa7eb6dbb063b7ba41ea57bce9e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/steev/linux/commit/2a19272fda8c6e9423a40b3b217a6c75333f48ed
        git remote add steev https://github.com/steev/linux
        git fetch --no-tags steev linux-v5.19.0-rc8-tests
        git checkout 2a19272fda8c6e9423a40b3b217a6c75333f48ed
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/gpu/drm/msm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c:1747:10: error: initializer element is not a compile-time constant
           .perf = msm8998_perf_data,
                   ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c:1770:13: error: initializer element is not a compile-time constant
           .dma_cfg = sdm845_regdma,
                      ^~~~~~~~~~~~~
   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c:1794:13: error: initializer element is not a compile-time constant
           .dma_cfg = sdm845_regdma,
                      ^~~~~~~~~~~~~
   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c:1820:13: error: initializer element is not a compile-time constant
           .dma_cfg = sm8150_regdma,
                      ^~~~~~~~~~~~~
   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c:1844:13: error: initializer element is not a compile-time constant
           .dma_cfg = sm8150_regdma,
                      ^~~~~~~~~~~~~
   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c:1872:13: error: initializer element is not a compile-time constant
           .dma_cfg = sm8250_regdma,
                      ^~~~~~~~~~~~~
   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c:1893:10: error: initializer element is not a compile-time constant
           .perf = sc7280_perf_data,
                   ^~~~~~~~~~~~~~~~
   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c:1916:13: error: initializer element is not a compile-time constant
           .dma_cfg = sdm845_regdma,
                      ^~~~~~~~~~~~~
   8 errors generated.


vim +1747 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c

591e34a091d17d Krishna Manikandan         2021-04-06  1702  
5334087ee7438f Loic Poulain               2022-02-14  1703  static const struct dpu_perf_cfg qcm2290_perf_data = {
5334087ee7438f Loic Poulain               2022-02-14  1704  	.max_bw_low = 2700000,
5334087ee7438f Loic Poulain               2022-02-14  1705  	.max_bw_high = 2700000,
5334087ee7438f Loic Poulain               2022-02-14  1706  	.min_core_ib = 1300000,
5334087ee7438f Loic Poulain               2022-02-14  1707  	.min_llcc_ib = 0,
5334087ee7438f Loic Poulain               2022-02-14  1708  	.min_dram_ib = 1600000,
5334087ee7438f Loic Poulain               2022-02-14  1709  	.min_prefill_lines = 24,
5334087ee7438f Loic Poulain               2022-02-14  1710  	.danger_lut_tbl = {0xff, 0x0, 0x0},
5334087ee7438f Loic Poulain               2022-02-14  1711  	.safe_lut_tbl = {0xfff0, 0x0, 0x0},
5334087ee7438f Loic Poulain               2022-02-14  1712  	.qos_lut_tbl = {
5334087ee7438f Loic Poulain               2022-02-14  1713  		{.nentry = ARRAY_SIZE(qcm2290_qos_linear),
5334087ee7438f Loic Poulain               2022-02-14  1714  		.entries = qcm2290_qos_linear
5334087ee7438f Loic Poulain               2022-02-14  1715  		},
5334087ee7438f Loic Poulain               2022-02-14  1716  	},
5334087ee7438f Loic Poulain               2022-02-14  1717  	.cdp_cfg = {
5334087ee7438f Loic Poulain               2022-02-14  1718  		{.rd_enable = 1, .wr_enable = 1},
5334087ee7438f Loic Poulain               2022-02-14  1719  		{.rd_enable = 1, .wr_enable = 0}
5334087ee7438f Loic Poulain               2022-02-14  1720  	},
5334087ee7438f Loic Poulain               2022-02-14  1721  	.clk_inefficiency_factor = 105,
5334087ee7438f Loic Poulain               2022-02-14  1722  	.bw_inefficiency_factor = 120,
5334087ee7438f Loic Poulain               2022-02-14  1723  };
25fdd5933e4c0f Jeykumar Sankaran          2018-06-27  1724  /*************************************************************
2a19272fda8c6e Dmitry Baryshkov           2022-06-01  1725   * Hardware catalog
25fdd5933e4c0f Jeykumar Sankaran          2018-06-27  1726   *************************************************************/
25fdd5933e4c0f Jeykumar Sankaran          2018-06-27  1727  
2a19272fda8c6e Dmitry Baryshkov           2022-06-01  1728  static const struct dpu_mdss_cfg msm8998_dpu_cfg = {
94391a14fc2738 AngeloGioacchino Del Regno 2022-01-13  1729  	.caps = &msm8998_dpu_caps,
94391a14fc2738 AngeloGioacchino Del Regno 2022-01-13  1730  	.mdp_count = ARRAY_SIZE(msm8998_mdp),
94391a14fc2738 AngeloGioacchino Del Regno 2022-01-13  1731  	.mdp = msm8998_mdp,
94391a14fc2738 AngeloGioacchino Del Regno 2022-01-13  1732  	.ctl_count = ARRAY_SIZE(msm8998_ctl),
94391a14fc2738 AngeloGioacchino Del Regno 2022-01-13  1733  	.ctl = msm8998_ctl,
94391a14fc2738 AngeloGioacchino Del Regno 2022-01-13  1734  	.sspp_count = ARRAY_SIZE(msm8998_sspp),
94391a14fc2738 AngeloGioacchino Del Regno 2022-01-13  1735  	.sspp = msm8998_sspp,
94391a14fc2738 AngeloGioacchino Del Regno 2022-01-13  1736  	.mixer_count = ARRAY_SIZE(msm8998_lm),
94391a14fc2738 AngeloGioacchino Del Regno 2022-01-13  1737  	.mixer = msm8998_lm,
6452cbd6f04cd5 Dmitry Baryshkov           2022-02-22  1738  	.dspp_count = ARRAY_SIZE(msm8998_dspp),
6452cbd6f04cd5 Dmitry Baryshkov           2022-02-22  1739  	.dspp = msm8998_dspp,
94391a14fc2738 AngeloGioacchino Del Regno 2022-01-13  1740  	.pingpong_count = ARRAY_SIZE(sdm845_pp),
94391a14fc2738 AngeloGioacchino Del Regno 2022-01-13  1741  	.pingpong = sdm845_pp,
94391a14fc2738 AngeloGioacchino Del Regno 2022-01-13  1742  	.intf_count = ARRAY_SIZE(msm8998_intf),
94391a14fc2738 AngeloGioacchino Del Regno 2022-01-13  1743  	.intf = msm8998_intf,
94391a14fc2738 AngeloGioacchino Del Regno 2022-01-13  1744  	.vbif_count = ARRAY_SIZE(msm8998_vbif),
94391a14fc2738 AngeloGioacchino Del Regno 2022-01-13  1745  	.vbif = msm8998_vbif,
94391a14fc2738 AngeloGioacchino Del Regno 2022-01-13  1746  	.reg_dma_count = 0,
94391a14fc2738 AngeloGioacchino Del Regno 2022-01-13 @1747  	.perf = msm8998_perf_data,
94391a14fc2738 AngeloGioacchino Del Regno 2022-01-13  1748  	.mdss_irqs = IRQ_SM8250_MASK,
94391a14fc2738 AngeloGioacchino Del Regno 2022-01-13  1749  };
94391a14fc2738 AngeloGioacchino Del Regno 2022-01-13  1750  

:::::: The code at line 1747 was first introduced by commit
:::::: 94391a14fc27383a60fc9499b631e5b6ccd9f075 drm/msm/dpu1: Add MSM8998 to hw catalog

:::::: TO: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
:::::: CC: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
