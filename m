Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2C0470E12
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 23:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243618AbhLJWnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 17:43:00 -0500
Received: from mga09.intel.com ([134.134.136.24]:63234 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243801AbhLJWl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 17:41:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639175902; x=1670711902;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rFcz27gpg3qsJSGB0uVAYFYRtvPj3RtwT1v3avMoNRo=;
  b=Ym8xWsZvnpnO4thEgRviZjwOgIKzlu8sUEq5cqaNQkUAYeUOeEw5Iedr
   DYIQLdTK8IomuB92eghRscLNpes38YbkMf+ANjIOkiyGOfESWR7mg7Pkf
   GN9YiXzpYSERVLT5JzF8LbM8aUg+9MHRxr840JDfjp78ajqanj2KMmWUr
   KdW7htAoqbvjrMeenzBEKjqqwdoIpfZ9q+66CSKs1DnZwB4oMywipVgNB
   f8PUUkyPz+t6LhUnaPFeDoMZ0k+khPr1Rx+1/6szkjuuZ5zmFXv/V56YK
   M+uh7JMUwRtmDyeoNlrFOJqzVPBOwkH35n+LqyBeav2SSZuGgp9E0xs8p
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10194"; a="238263040"
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="238263040"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 14:38:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="480885890"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 10 Dec 2021 14:38:20 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvoWx-0003l4-N3; Fri, 10 Dec 2021 22:38:19 +0000
Date:   Sat, 11 Dec 2021 06:38:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [superna9999:amlogic/v5.17/g12-dsi 10/23]
 drivers/gpu/drm/meson/meson_encoder_dsi.c:125:69: warning: variable 'ret' is
 uninitialized when used here
Message-ID: <202112110644.NcoPvA8p-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/superna9999/linux amlogic/v5.17/g12-dsi
head:   62dac9179f2937dc08bffe08d15c6846bc4aedb4
commit: d521159dd8a996678230b50e4ecafcdf50648c52 [10/23] fixup! WIP: drm/meson: add DSI encoder
config: arm-randconfig-r033-20211210 (https://download.01.org/0day-ci/archive/20211211/202112110644.NcoPvA8p-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 097a1cb1d5ebb3a0ec4bcaed8ba3ff6a8e33c00a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/superna9999/linux/commit/d521159dd8a996678230b50e4ecafcdf50648c52
        git remote add superna9999 https://github.com/superna9999/linux
        git fetch --no-tags superna9999 amlogic/v5.17/g12-dsi
        git checkout d521159dd8a996678230b50e4ecafcdf50648c52
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/gpu/drm/meson/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/meson/meson_encoder_dsi.c:125:69: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
                   dev_err(priv->dev, "Failed to find DSI transceiver bridge: %d\n", ret);
                                                                                     ^~~
   include/linux/dev_printk.h:144:65: note: expanded from macro 'dev_err'
           dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                                          ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
                   _p_func(dev, fmt, ##__VA_ARGS__);                       \
                                       ^~~~~~~~~~~
   drivers/gpu/drm/meson/meson_encoder_dsi.c:108:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
   1 warning generated.


vim +/ret +125 drivers/gpu/drm/meson/meson_encoder_dsi.c

6b197be782e0410 Neil Armstrong 2021-12-09  103  
6b197be782e0410 Neil Armstrong 2021-12-09  104  int meson_encoder_dsi_init(struct meson_drm *priv)
6b197be782e0410 Neil Armstrong 2021-12-09  105  {
6b197be782e0410 Neil Armstrong 2021-12-09  106  	struct meson_encoder_dsi *meson_encoder_dsi;
6b197be782e0410 Neil Armstrong 2021-12-09  107  	struct device_node *remote;
6b197be782e0410 Neil Armstrong 2021-12-09  108  	int ret;
6b197be782e0410 Neil Armstrong 2021-12-09  109  
6b197be782e0410 Neil Armstrong 2021-12-09  110  	DRM_DEBUG_DRIVER("\n");
6b197be782e0410 Neil Armstrong 2021-12-09  111  
6b197be782e0410 Neil Armstrong 2021-12-09  112  	meson_encoder_dsi = devm_kzalloc(priv->dev, sizeof(*meson_encoder_dsi), GFP_KERNEL);
6b197be782e0410 Neil Armstrong 2021-12-09  113  	if (!meson_encoder_dsi)
6b197be782e0410 Neil Armstrong 2021-12-09  114  		return -ENOMEM;
6b197be782e0410 Neil Armstrong 2021-12-09  115  
6b197be782e0410 Neil Armstrong 2021-12-09  116  	/* DSI Transceiver Bridge */
6b197be782e0410 Neil Armstrong 2021-12-09  117  	remote = of_graph_get_remote_node(priv->dev->of_node, 1, 0);
6b197be782e0410 Neil Armstrong 2021-12-09  118  	if (!remote) {
6b197be782e0410 Neil Armstrong 2021-12-09  119  		dev_err(priv->dev, "DSI transceiver device is disabled");
6b197be782e0410 Neil Armstrong 2021-12-09  120  		return 0;
6b197be782e0410 Neil Armstrong 2021-12-09  121  	}
6b197be782e0410 Neil Armstrong 2021-12-09  122  
6b197be782e0410 Neil Armstrong 2021-12-09  123  	meson_encoder_dsi->next_bridge = of_drm_find_bridge(remote);
6b197be782e0410 Neil Armstrong 2021-12-09  124  	if (!meson_encoder_dsi->next_bridge) {
6b197be782e0410 Neil Armstrong 2021-12-09 @125  		dev_err(priv->dev, "Failed to find DSI transceiver bridge: %d\n", ret);

:::::: The code at line 125 was first introduced by commit
:::::: 6b197be782e0410bb911b74fb152daefccce6a29 WIP: drm/meson: add DSI encoder

:::::: TO: Neil Armstrong <narmstrong@baylibre.com>
:::::: CC: Neil Armstrong <narmstrong@baylibre.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
