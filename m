Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718115808D2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 02:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234916AbiGZAwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 20:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiGZAwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 20:52:22 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C998F26AE8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 17:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658796741; x=1690332741;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7MJPprHrWC/22tcVZAr1w0eZz8ntLzaTRRmATdZzq2Q=;
  b=jwyXAUz5xfD3AHPqCy18wx3TohlKI9OuE8ZVKQfVxis+Hi3Y2mMn9JPk
   sEdPitINZtO1tDbfuVJtU6g75RJJ5vB8IX5akQHMj4+EeALNpY0r5gbTz
   jbWpv39rX4Yac+yX68itxFWRKGMAouBIBavym+v2xObwQ+txoDPjDNwmx
   iYG/qg7tNolYEN6sGanAS2MN1rlU6oG4UbviJkcTTf4OQQxNMxzeHz5l9
   hLRJrGxdgS51ECSgq4bLTMOZAOalzK33GhY2M59bzfM/Zy+cYqEZ1gZMq
   AVjOCD3AjzqXlRw8jAa5SUJE9vTqaScF6fG3wj+mU4ZGim+QcJoIx/G/a
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="274694217"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="274694217"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 17:52:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="667690528"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 25 Jul 2022 17:52:19 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oG8o6-0005kF-3B;
        Tue, 26 Jul 2022 00:52:18 +0000
Date:   Tue, 26 Jul 2022 08:51:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Yan <andy.yan@rock-chips.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: drivers/gpu/drm/rockchip/rockchip_vop2_reg.c:248:34: warning: unused
 variable 'vop2_dt_match'
Message-ID: <202207260823.a2e6HBuO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e0dccc3b76fb35bb257b4118367a883073d7390e
commit: 604be85547ce4d61b89292d2f9a78c721b778c16 drm/rockchip: Add VOP2 driver
date:   3 months ago
config: arm-randconfig-c002-20220724 (https://download.01.org/0day-ci/archive/20220726/202207260823.a2e6HBuO-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 9e88cbcc403bdf82f29259ad60ff60a8fc4434a1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=604be85547ce4d61b89292d2f9a78c721b778c16
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 604be85547ce4d61b89292d2f9a78c721b778c16
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/kernel/ drivers/gpu/drm/rockchip/ drivers/usb/gadget/ fs/ntfs3/ net/ceph/ net/ipv6/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/rockchip/rockchip_vop2_reg.c:248:34: warning: unused variable 'vop2_dt_match' [-Wunused-const-variable]
   static const struct of_device_id vop2_dt_match[] = {
                                    ^
   1 warning generated.


vim +/vop2_dt_match +248 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c

   247	
 > 248	static const struct of_device_id vop2_dt_match[] = {
   249		{
   250			.compatible = "rockchip,rk3566-vop",
   251			.data = &rk3566_vop,
   252		}, {
   253			.compatible = "rockchip,rk3568-vop",
   254			.data = &rk3568_vop,
   255		}, {
   256		},
   257	};
   258	MODULE_DEVICE_TABLE(of, vop2_dt_match);
   259	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
