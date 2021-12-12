Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F272471925
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 08:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbhLLHjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 02:39:04 -0500
Received: from mga04.intel.com ([192.55.52.120]:42206 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229449AbhLLHjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 02:39:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639294743; x=1670830743;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KZ0LRPbuOwIaHJmSRw0PLAQoy+5UEgNgbQhyK10cBHc=;
  b=Z6MsDhYzpL6u9wVzDTExO+DgduzVVcxUM0WLT69KQCaArlqIQYK8gsjU
   K/NNr7qfR97M9CQmhnOC15HdsgR5SPmv1nMrQDWoW+uKt64pPREpKLY2O
   fOC6gUojBCBPl+4RuGjxRYkKdqc1Sf6GkClAmia4K/QkCdYA6ahxLTPH1
   5qfpFTPVofUYCT+7fFX/dsTdgOY3E33hvxMMKufD1VxXHa9UrKWql2txK
   aLNPKrJZ9c9t+L5gBhX6WKboTs7Vq8eQztP0lCcYdQnLVVIU2LKhHBy0A
   KKc7AAInWCzULJlKqiny90jluxb9eWvxf0/xj67y6mrWZ0PdLseR+H5NM
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10195"; a="237319267"
X-IronPort-AV: E=Sophos;i="5.88,199,1635231600"; 
   d="scan'208";a="237319267"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2021 23:39:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,199,1635231600"; 
   d="scan'208";a="464255327"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 11 Dec 2021 23:39:01 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mwJRk-0005V5-Ue; Sun, 12 Dec 2021 07:39:00 +0000
Date:   Sun, 12 Dec 2021 15:38:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [superna9999:amlogic/v5.17/g12-dsi 7/23]
 drivers/gpu/drm/meson/meson_vclk.c:1035:33: error: 'vid_pll_div' undeclared
Message-ID: <202112121520.P5eMl3xJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/superna9999/linux amlogic/v5.17/g12-dsi
head:   62dac9179f2937dc08bffe08d15c6846bc4aedb4
commit: cc44c3ce92a63f2c59a3f0ac03e6defd41542940 [7/23] WiP: drm/meson: vclk: add DSI clock config
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20211212/202112121520.P5eMl3xJ-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/superna9999/linux/commit/cc44c3ce92a63f2c59a3f0ac03e6defd41542940
        git remote add superna9999 https://github.com/superna9999/linux
        git fetch --no-tags superna9999 amlogic/v5.17/g12-dsi
        git checkout cc44c3ce92a63f2c59a3f0ac03e6defd41542940
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the superna9999/amlogic/v5.17/g12-dsi HEAD 62dac9179f2937dc08bffe08d15c6846bc4aedb4 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   drivers/gpu/drm/meson/meson_vclk.c: In function 'meson_dsi_clock_config':
>> drivers/gpu/drm/meson/meson_vclk.c:1035:33: error: 'vid_pll_div' undeclared (first use in this function)
    1035 |         meson_vid_pll_set(priv, vid_pll_div);
         |                                 ^~~~~~~~~~~
   drivers/gpu/drm/meson/meson_vclk.c:1035:33: note: each undeclared identifier is reported only once for each function it appears in


vim +/vid_pll_div +1035 drivers/gpu/drm/meson/meson_vclk.c

  1029	
  1030	static void meson_dsi_clock_config(struct meson_drm *priv, unsigned freq)
  1031	{
  1032		meson_hdmi_pll_generic_set(priv, freq);
  1033	
  1034		/* Setup vid_pll divider */
> 1035		meson_vid_pll_set(priv, vid_pll_div);
  1036		
  1037		/* Disable VCLK2 */
  1038		regmap_update_bits(priv->hhi, HHI_VIID_CLK_CNTL, VCLK2_EN, 0);
  1039	
  1040		/* Setup vid_pll to /1 */
  1041		meson_vid_pll_set(priv, VID_PLL_DIV_1);
  1042	
  1043		/* Setup the VCLK2 divider value */
  1044		regmap_update_bits(priv->hhi, HHI_VIID_CLK_DIV,
  1045					VCLK2_DIV_MASK, 0);
  1046	
  1047		/* select vid_pll for vclk2 */
  1048		regmap_update_bits(priv->hhi, HHI_VIID_CLK_CNTL,
  1049				VCLK2_SEL_MASK, (0 << VCLK2_SEL_SHIFT));
  1050	
  1051		/* enable vclk2 gate */
  1052		regmap_update_bits(priv->hhi, HHI_VIID_CLK_CNTL, VCLK2_EN, VCLK2_EN);
  1053	
  1054		/* select vclk2_div1 for encl */
  1055		regmap_update_bits(priv->hhi, HHI_VIID_CLK_DIV,
  1056					CTS_ENCL_SEL_MASK, (8 << CTS_ENCL_SEL_SHIFT));
  1057	
  1058		/* release vclk2_div_reset and enable vclk2_div */
  1059		regmap_update_bits(priv->hhi, HHI_VIID_CLK_DIV,
  1060					VCLK2_DIV_EN | VCLK2_DIV_RESET, VCLK2_DIV_EN);
  1061	
  1062		/* enable vclk2_div1 gate */
  1063		regmap_update_bits(priv->hhi, HHI_VIID_CLK_CNTL,
  1064					VCLK2_DIV1_EN, VCLK2_DIV1_EN);
  1065	
  1066		/* reset vclk2 */
  1067		regmap_update_bits(priv->hhi, HHI_VIID_CLK_CNTL,
  1068					VCLK2_SOFT_RESET, VCLK2_SOFT_RESET);
  1069		regmap_update_bits(priv->hhi, HHI_VIID_CLK_CNTL,
  1070					VCLK2_SOFT_RESET, 0);
  1071	
  1072		/* enable encl_clk */
  1073		regmap_update_bits(priv->hhi, HHI_VID_CLK_CNTL2,
  1074					CTS_ENCL_EN, CTS_ENCL_EN);
  1075	
  1076		usleep_range(10000, 11000);
  1077	}
  1078	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
