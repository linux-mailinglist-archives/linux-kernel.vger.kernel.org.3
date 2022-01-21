Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B35496547
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 19:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiAUSvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 13:51:14 -0500
Received: from mga12.intel.com ([192.55.52.136]:26696 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229873AbiAUSvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 13:51:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642791063; x=1674327063;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YSgT/azaGL4jexzg08Pwlog39iWO8I3HNrfuyXC+8lI=;
  b=SYCN1PiLv67S0o0E/sCPcLAGeUxMhGuPIez0x/S+4AxmFBno5hYCNgsF
   qvnv8v9Vd38ACdeomotj8b+L5Fx06g+OZI1kPiIfiTjPnD8ADncVI4N8f
   SuQnWYIZFuBosvMVRD0el9vjMupD1GyKcdH25VENBdFwyDYjm0pTFctM5
   1R7sSP3pJOKA78Tw34OXdI7MbogXabdFH3O1fudVdSs3Gg7mPu7mMDwh+
   mVxc8koP68ZzypiyXD3s6PfkJMFJPHtxG3VFh9IuWKck4l9QkrNrwWqW2
   brAToMLi2bGSttmXyPRtLCTaNG57xKMnhWS02Z+W6IIk6/0TZw/BWRKSK
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10234"; a="225706943"
X-IronPort-AV: E=Sophos;i="5.88,306,1635231600"; 
   d="scan'208";a="225706943"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 10:51:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,306,1635231600"; 
   d="scan'208";a="531483606"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 21 Jan 2022 10:51:01 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nAz00-000FaK-Ij; Fri, 21 Jan 2022 18:51:00 +0000
Date:   Sat, 22 Jan 2022 02:50:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [superna9999:amlogic/v5.18/g12-dsi-wip 13/14]
 drivers/gpu/drm/meson/meson_encoder_dsi.c:122:69: warning: variable 'ret' is
 uninitialized when used here
Message-ID: <202201220231.SSLn9QGA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/superna9999/linux amlogic/v5.18/g12-dsi-wip
head:   fbcc0a7f53880919dc415da44339313dd59768f0
commit: 69065af6f6c3f3c1a6a29ab765c02e8371be3a42 [13/14] drm/meson: add DSI encoder
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20220122/202201220231.SSLn9QGA-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 7b3d30728816403d1fd73cc5082e9fb761262bce)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/superna9999/linux/commit/69065af6f6c3f3c1a6a29ab765c02e8371be3a42
        git remote add superna9999 https://github.com/superna9999/linux
        git fetch --no-tags superna9999 amlogic/v5.18/g12-dsi-wip
        git checkout 69065af6f6c3f3c1a6a29ab765c02e8371be3a42
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/gpu/drm/meson/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/meson/meson_encoder_dsi.c:122:69: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
                   dev_dbg(priv->dev, "Failed to find DSI transceiver bridge: %d\n", ret);
                                                                                     ^~~
   include/linux/dev_printk.h:155:39: note: expanded from macro 'dev_dbg'
           dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                ^~~~~~~~~~~
   include/linux/dynamic_debug.h:167:19: note: expanded from macro 'dynamic_dev_dbg'
                              dev, fmt, ##__VA_ARGS__)
                                          ^~~~~~~~~~~
   include/linux/dynamic_debug.h:152:56: note: expanded from macro '_dynamic_func_call'
           __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
                                                                 ^~~~~~~~~~~
   include/linux/dynamic_debug.h:134:15: note: expanded from macro '__dynamic_func_call'
                   func(&id, ##__VA_ARGS__);               \
                               ^~~~~~~~~~~
   drivers/gpu/drm/meson/meson_encoder_dsi.c:107:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
   1 warning generated.


vim +/ret +122 drivers/gpu/drm/meson/meson_encoder_dsi.c

   102	
   103	int meson_encoder_dsi_init(struct meson_drm *priv)
   104	{
   105		struct meson_encoder_dsi *meson_encoder_dsi;
   106		struct device_node *remote;
   107		int ret;
   108	
   109		meson_encoder_dsi = devm_kzalloc(priv->dev, sizeof(*meson_encoder_dsi), GFP_KERNEL);
   110		if (!meson_encoder_dsi)
   111			return -ENOMEM;
   112	
   113		/* DSI Transceiver Bridge */
   114		remote = of_graph_get_remote_node(priv->dev->of_node, 2, 0);
   115		if (!remote) {
   116			dev_err(priv->dev, "DSI transceiver device is disabled");
   117			return 0;
   118		}
   119	
   120		meson_encoder_dsi->next_bridge = of_drm_find_bridge(remote);
   121		if (!meson_encoder_dsi->next_bridge) {
 > 122			dev_dbg(priv->dev, "Failed to find DSI transceiver bridge: %d\n", ret);

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
