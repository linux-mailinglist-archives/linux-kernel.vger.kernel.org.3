Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBDE2471196
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 06:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345949AbhLKEzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 23:55:15 -0500
Received: from mga09.intel.com ([134.134.136.24]:9085 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233585AbhLKEzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 23:55:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639198297; x=1670734297;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ORaAGIoy+j8VYxXqV2KW+tZfGurfvWFFe66CgFnWH2E=;
  b=TfdzNj3x8TTPZpHV4+5foXCqvOa5t89xrR/flpX3BqLuvOkGcjV3Xncw
   6BOf+OHqHXrHI0kDflJINX1/tuYT2is0baGt9JqhlQDcwQPj5GoJWZr3l
   8LTuOQeTcKDr2N8lQ1vjG1I74MAY/5V8gpz4fOW7ym23CvJT7Odsh97Rl
   C5z4136sryivF1AYiQIl7RgjbTzQO94RzOWloomDJU0T2lcdXw+uhXpWM
   h/1OzlbhZhISlvVsftdquexMXYv4UXD87jWL4ak4ePsetQrQGTpzeY9Ty
   DG5HQ6MVOr5j0Y0aF4CpqygXRVWFBaMpw5PJb9qWjW4XDbXfUIyvNb5wq
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10194"; a="238313066"
X-IronPort-AV: E=Sophos;i="5.88,197,1635231600"; 
   d="scan'208";a="238313066"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 20:51:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,197,1635231600"; 
   d="scan'208";a="544212044"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 10 Dec 2021 20:51:29 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvuM4-00047v-N4; Sat, 11 Dec 2021 04:51:28 +0000
Date:   Sat, 11 Dec 2021 12:50:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [superna9999:amlogic/v5.17/g12-dsi 20/23]
 drivers/gpu/drm/meson/meson_encoder_dsi.c:59:37: error: passing 'const
 struct drm_display_mode *' to parameter of type 'struct drm_display_mode *'
 discards qualifiers
Message-ID: <202112111247.XKv1vmaF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/superna9999/linux amlogic/v5.17/g12-dsi
head:   62dac9179f2937dc08bffe08d15c6846bc4aedb4
commit: b186318175a12bdca613ee26b4b452964c795eb3 [20/23] fixup! WIP: drm/meson: add DSI encoder
config: arm-randconfig-r033-20211210 (https://download.01.org/0day-ci/archive/20211211/202112111247.XKv1vmaF-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 097a1cb1d5ebb3a0ec4bcaed8ba3ff6a8e33c00a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/superna9999/linux/commit/b186318175a12bdca613ee26b4b452964c795eb3
        git remote add superna9999 https://github.com/superna9999/linux
        git fetch --no-tags superna9999 amlogic/v5.17/g12-dsi
        git checkout b186318175a12bdca613ee26b4b452964c795eb3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/gpu/drm/meson/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/meson/meson_encoder_dsi.c:59:37: error: passing 'const struct drm_display_mode *' to parameter of type 'struct drm_display_mode *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
           meson_venc_mipi_dsi_mode_set(priv, mode);
                                              ^~~~
   drivers/gpu/drm/meson/meson_venc.h:71:32: note: passing argument to parameter 'mode' here
                                     struct drm_display_mode *mode);
                                                              ^
   drivers/gpu/drm/meson/meson_encoder_dsi.c:130:69: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
                   dev_err(priv->dev, "Failed to find DSI transceiver bridge: %d\n", ret);
                                                                                     ^~~
   include/linux/dev_printk.h:144:65: note: expanded from macro 'dev_err'
           dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                                          ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
                   _p_func(dev, fmt, ##__VA_ARGS__);                       \
                                       ^~~~~~~~~~~
   drivers/gpu/drm/meson/meson_encoder_dsi.c:109:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
   1 warning and 1 error generated.


vim +59 drivers/gpu/drm/meson/meson_encoder_dsi.c

6b197be782e041 Neil Armstrong 2021-12-09  47  
b186318175a12b Neil Armstrong 2021-12-10  48  static void meson_encoder_dsi_mode_set(struct drm_bridge *bridge,
b186318175a12b Neil Armstrong 2021-12-10  49  					const struct drm_display_mode *mode,
b186318175a12b Neil Armstrong 2021-12-10  50  					const struct drm_display_mode *adjusted_mode)
6b197be782e041 Neil Armstrong 2021-12-09  51  {
6b197be782e041 Neil Armstrong 2021-12-09  52  	struct meson_encoder_dsi *encoder_dsi = bridge_to_meson_encoder_dsi(bridge);
6b197be782e041 Neil Armstrong 2021-12-09  53  	struct meson_drm *priv = encoder_dsi->priv;
6b197be782e041 Neil Armstrong 2021-12-09  54  
b186318175a12b Neil Armstrong 2021-12-10  55  	pr_err("%s:%d\n", __func__, __LINE__);
6b197be782e041 Neil Armstrong 2021-12-09  56  
b186318175a12b Neil Armstrong 2021-12-10  57  	meson_vclk_setup(priv, MESON_VCLK_TARGET_DSI, mode->clock, 0, 0, 0, false);
6b197be782e041 Neil Armstrong 2021-12-09  58  
d521159dd8a996 Neil Armstrong 2021-12-10 @59  	meson_venc_mipi_dsi_mode_set(priv, mode);
e1e87e576f5bef Neil Armstrong 2021-12-09  60  	meson_encl_load_gamma(priv);
6b197be782e041 Neil Armstrong 2021-12-09  61  
b186318175a12b Neil Armstrong 2021-12-10  62  	writel_relaxed(0, priv->io_base + _REG(ENCL_VIDEO_EN));
b186318175a12b Neil Armstrong 2021-12-10  63  
e1e87e576f5bef Neil Armstrong 2021-12-09  64  	writel_bits_relaxed(BIT(3), BIT(3), priv->io_base + _REG(ENCL_VIDEO_MODE_ADV));
e1e87e576f5bef Neil Armstrong 2021-12-09  65  	writel_relaxed(0, priv->io_base + _REG(ENCL_TST_EN));
b186318175a12b Neil Armstrong 2021-12-10  66  }
b186318175a12b Neil Armstrong 2021-12-10  67  

:::::: The code at line 59 was first introduced by commit
:::::: d521159dd8a996678230b50e4ecafcdf50648c52 fixup! WIP: drm/meson: add DSI encoder

:::::: TO: Neil Armstrong <narmstrong@baylibre.com>
:::::: CC: Neil Armstrong <narmstrong@baylibre.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
