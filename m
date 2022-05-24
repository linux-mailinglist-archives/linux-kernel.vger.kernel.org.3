Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2BA5332C7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 23:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241856AbiEXVBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 17:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241853AbiEXVBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 17:01:14 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3F0F73
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 14:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653426072; x=1684962072;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=25ss+2bsycbOE0VY+2i5BdlirvoEV34kTUZ5Sy5s7vM=;
  b=bdQmbha+RoHKUaOVi/4w5FI/7VVNSdvnwOkRV6gt4YkSuCnWbZa7SaE1
   4qSTmukZoTsBKrmubcFwdu2nb4eXqcPI7brvQwA/iIfjG86VN2HIVvKsq
   YcrwAGV5iqy2dvLsZPL0I9XPV8hbry0LhDdhRr6xJ0Nz+4EPFDHjwTVwi
   A05+sI7UHvXGq9tx5ynEHVq3H7NsLKllVeCzxGlpkjtxDfVXJxOtw1wIb
   acrHA1GHScFOpTJeVSNLedlBugDmxUYChL39bvdMTsBROl1PvwFNstN8L
   gN4+7hWEQgesgWMdXbNPGK835B40I1ZW4E+97S4Z0oDGJfy/5sZPK5jMA
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="334294891"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="334294891"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 14:01:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="559288430"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 24 May 2022 14:01:10 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntbeQ-0002RB-5C;
        Tue, 24 May 2022 21:01:10 +0000
Date:   Wed, 25 May 2022 05:01:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martyn Welch <martyn.welch@collabora.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [martyn:imx8mp 8/9] drivers/gpu/drm/panel/panel-simple.c:2143:38:
 warning: unused variable 'innolux_g121x1_l03_mode'
Message-ID: <202205250438.KP96c0zm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.collabora.com/martyn/linux imx8mp
head:   9a43f7e1df323f21d01d689adc7966d695aeb7f3
commit: fa301efda2e4746d122dcde65453454851fef2dd [8/9] Convert innolux g121x1 to timing
config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20220525/202205250438.KP96c0zm-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 10c9ecce9f6096e18222a331c5e7d085bd813f75)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add martyn https://gitlab.collabora.com/martyn/linux
        git fetch --no-tags martyn imx8mp
        git checkout fa301efda2e4746d122dcde65453454851fef2dd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/panel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/panel/panel-simple.c:2143:38: warning: unused variable 'innolux_g121x1_l03_mode' [-Wunused-const-variable]
   static const struct drm_display_mode innolux_g121x1_l03_mode = {
                                        ^
   1 warning generated.


vim +/innolux_g121x1_l03_mode +2143 drivers/gpu/drm/panel/panel-simple.c

d731f661b5d2dd5 Lucas Stach 2014-11-06  2142  
f8fa17ba812b7df Akshay Bhat 2015-11-18 @2143  static const struct drm_display_mode innolux_g121x1_l03_mode = {
f8fa17ba812b7df Akshay Bhat 2015-11-18  2144  	.clock = 65000,
f8fa17ba812b7df Akshay Bhat 2015-11-18  2145  	.hdisplay = 1024,
f8fa17ba812b7df Akshay Bhat 2015-11-18  2146  	.hsync_start = 1024 + 0,
f8fa17ba812b7df Akshay Bhat 2015-11-18  2147  	.hsync_end = 1024 + 1,
f8fa17ba812b7df Akshay Bhat 2015-11-18  2148  	.htotal = 1024 + 0 + 1 + 320,
f8fa17ba812b7df Akshay Bhat 2015-11-18  2149  	.vdisplay = 768,
f8fa17ba812b7df Akshay Bhat 2015-11-18  2150  	.vsync_start = 768 + 38,
f8fa17ba812b7df Akshay Bhat 2015-11-18  2151  	.vsync_end = 768 + 38 + 1,
f8fa17ba812b7df Akshay Bhat 2015-11-18  2152  	.vtotal = 768 + 38 + 1 + 0,
2e8c5eb9ef938a0 Akshay Bhat 2016-03-01  2153  	.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
f8fa17ba812b7df Akshay Bhat 2015-11-18  2154  };
f8fa17ba812b7df Akshay Bhat 2015-11-18  2155  

:::::: The code at line 2143 was first introduced by commit
:::::: f8fa17ba812b7df1535f6bb75d7264670f5997a6 drm/panel: simple: Add support for Innolux G121X1-L03

:::::: TO: Akshay Bhat <akshay.bhat@timesys.com>
:::::: CC: Thierry Reding <treding@nvidia.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
