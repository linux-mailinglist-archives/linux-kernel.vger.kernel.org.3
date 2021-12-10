Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 187C246FE34
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 10:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239647AbhLJJ5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 04:57:38 -0500
Received: from mga12.intel.com ([192.55.52.136]:13465 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239633AbhLJJ5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 04:57:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639130043; x=1670666043;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CPbklnXrDLZAnk5VD2gbvs3RLeEYAMi8u0nxymSMWSE=;
  b=WkTfrclAXoqgZlbn7k1WVYJkvVmt19fRV5NInvuCMfzbAaSuZJ2MxrS0
   uchd8H14HlXLqhUaRu9r9rRHIHfho9kJe5QFrALr/snfF0sMS81rtMsuc
   MLnLRK2ULQ0y/7npiDjlICenrQRZdQ51w70N1BAuG4GqZCh53eEW+kD7H
   HxU2QqMWEPLjgZO3YUqEv4wrYs8XSLywabnSwCG3tYPHxind81T+dpSQ/
   sdg2pWDUaskBzhmAa0tMUAg+KCcBOw6Z9rJACpNYi/DsybtBqMpu45Uk+
   z61PCBpExfUZLfOJnhj3HYSynJe2J6GHjvgl35XVJIucJ2nbaa2gCwtqV
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="218340171"
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="218340171"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 01:54:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="480679751"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 10 Dec 2021 01:54:00 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvcbI-000322-42; Fri, 10 Dec 2021 09:54:00 +0000
Date:   Fri, 10 Dec 2021 17:53:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [superna9999:amlogic/v5.17/g12-dsi 7/7]
 drivers/gpu/drm/meson/meson_vclk.c:1035:26: error: use of undeclared
 identifier 'vid_pll_div'
Message-ID: <202112101707.Kcrqw9L3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/superna9999/linux amlogic/v5.17/g12-dsi
head:   cc44c3ce92a63f2c59a3f0ac03e6defd41542940
commit: cc44c3ce92a63f2c59a3f0ac03e6defd41542940 [7/7] WiP: drm/meson: vclk: add DSI clock config
config: arm-randconfig-r034-20211210 (https://download.01.org/0day-ci/archive/20211210/202112101707.Kcrqw9L3-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 097a1cb1d5ebb3a0ec4bcaed8ba3ff6a8e33c00a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/superna9999/linux/commit/cc44c3ce92a63f2c59a3f0ac03e6defd41542940
        git remote add superna9999 https://github.com/superna9999/linux
        git fetch --no-tags superna9999 amlogic/v5.17/g12-dsi
        git checkout cc44c3ce92a63f2c59a3f0ac03e6defd41542940
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/gpu/drm/meson/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/meson/meson_vclk.c:1035:26: error: use of undeclared identifier 'vid_pll_div'
           meson_vid_pll_set(priv, vid_pll_div);
                                   ^
   1 error generated.


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
