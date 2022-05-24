Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815F6532758
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 12:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbiEXKSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 06:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiEXKSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 06:18:30 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC85E114E
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 03:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653387509; x=1684923509;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xSgj51pG5C3QFfOReMyZoIvSUtU6wGmpwG+rrptWICI=;
  b=FaJewR6fQXZxt6b7UaG8FECvCWevopiZRLrYMM5V7J/vffrBeftoT25+
   kMQI80VDkPEkPxF2kMF7MEA726TIKDBzivJbZrTVMW2P8yd5bWeM5peHD
   zyTfgN4+jgIEIAWgsjZAqYuYI4ccPtQWI70oBswJmjle5YM6kRLTIU1L4
   urVQF85hf8S1UDyQ+Gh/OGyE87CURaAc9zci6G1WR90hYA0OdZLR6dY4A
   1auyYsSL9o+TPWcYkSom4DTKorDY8os39Lren2ZKaD/TU/STFJplQ0yTg
   akxqSKil5D5dWRCCBnv9Z+lceXnL9oCMAwsr8qe20esKgOY0RFeb2IZqu
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="273486197"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="273486197"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 03:18:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="820230569"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 24 May 2022 03:18:27 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntRcQ-0001xi-EV;
        Tue, 24 May 2022 10:18:26 +0000
Date:   Tue, 24 May 2022 18:17:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bhanuprakash Modem <bhanuprakash.modem@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Jani Nikula <jani.nikula@intel.com>,
        Arun R Murthy <arun.r.murthy@intel.com>,
        Harry Wentland <harry.wentland@amd.com>
Subject: [drm-misc:drm-misc-next 1106/1116]
 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:6622:2: error:
 call to undeclared function 'crtc_debugfs_init'; ISO C99 and later do not
 support implicit function declarations
Message-ID: <202205241843.8EWKesIA-lkp@intel.com>
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

tree:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
head:   1a3b1ea111c44d9dce9f70ba032531a223395a15
commit: 4cd79f614b501e496ee8e4181d528c0cc1cb4e18 [1106/1116] drm/amd/display: Move connector debugfs to drm
config: arm64-randconfig-r001-20220524 (https://download.01.org/0day-ci/archive/20220524/202205241843.8EWKesIA-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 10c9ecce9f6096e18222a331c5e7d085bd813f75)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        git remote add drm-misc git://anongit.freedesktop.org/drm/drm-misc
        git fetch --no-tags drm-misc drm-misc-next
        git checkout 4cd79f614b501e496ee8e4181d528c0cc1cb4e18
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:6622:2: error: call to undeclared function 'crtc_debugfs_init'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           crtc_debugfs_init(crtc);
           ^
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:9165:20: warning: variable 'abo' set but not used [-Wunused-but-set-variable]
           struct amdgpu_bo *abo;
                             ^
   1 warning and 1 error generated.


vim +/crtc_debugfs_init +6622 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c

e7b07ceef2a650 Harry Wentland 2017-08-10  6619  
e69231c4451ae0 Wayne Lin      2021-03-08  6620  static int amdgpu_dm_crtc_late_register(struct drm_crtc *crtc)
86bc221918925a Wayne Lin      2021-03-02  6621  {
86bc221918925a Wayne Lin      2021-03-02 @6622  	crtc_debugfs_init(crtc);
86bc221918925a Wayne Lin      2021-03-02  6623  
86bc221918925a Wayne Lin      2021-03-02  6624  	return 0;
86bc221918925a Wayne Lin      2021-03-02  6625  }
86bc221918925a Wayne Lin      2021-03-02  6626  

:::::: The code at line 6622 was first introduced by commit
:::::: 86bc221918925a0bbb49043e3936e898e009b43b drm/amd/display: Support crc on specific region

:::::: TO: Wayne Lin <Wayne.Lin@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
