Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE764E6DE3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 06:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353986AbiCYFxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 01:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244753AbiCYFxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 01:53:33 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D73C55B8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 22:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648187519; x=1679723519;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wCjOnQNuYkQUYKTMHmN25adLO3wauI/DfrgbjPXBgvA=;
  b=kU3SL95AhYSToiGPp3caJeHFweYDBkFqLCZt7X3CiYeNBpXxszKuQm/k
   FdpxDja6hmb+Bqnqsn/dtxEl9RKhHjebJo+O7p1Wg4SrUcD9Ga2vUY2OU
   UbZc+rRVBL7cESLPZ1DsOPGhEY9gq7ZSQFCDQEApH9RF1rNf9BcjOESLE
   oSlOSCEZqLOewwwMK8+hD1cQBbWGAgB689GvTup/s5XMGNb5p+F7R8BO8
   C38qRmSnERnpSOzxQHpEYnQL0YKxLo9ankZEELgGIqbaFvoVsae7SIak6
   zpXXLAGxHp9yb70Hq7BhQbP55WLZgaLRW1xwrola9z/ckJIzPjdhYAvR5
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="238501808"
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="238501808"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 22:51:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="718103164"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 24 Mar 2022 22:51:56 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nXcrc-000LqL-8u; Fri, 25 Mar 2022 05:51:56 +0000
Date:   Fri, 25 Mar 2022 13:50:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Evan Quan <evan.quan@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../pm/swsmu/amdgpu_smu.c:1355:6: warning:
 variable 'num_of_active_display' set but not used
Message-ID: <202203251309.VJH4ngVX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   85c7000fda0029ec16569b1eec8fd3a8d026be73
commit: 75145aab7a0d865b361de687b201e8c4b76425eb drm/amdgpu/swsmu: clean up a bunch of stale interfaces
date:   1 year, 5 months ago
config: arm64-randconfig-r013-20220324 (https://download.01.org/0day-ci/archive/20220325/202203251309.VJH4ngVX-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=75145aab7a0d865b361de687b201e8c4b76425eb
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 75145aab7a0d865b361de687b201e8c4b76425eb
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/amdgpu_smu.c:1355:6: warning: variable 'num_of_active_display' set but not used [-Wunused-but-set-variable]
           int num_of_active_display = 0;
               ^
   1 warning generated.


vim +/num_of_active_display +1355 drivers/gpu/drm/amd/amdgpu/../pm/swsmu/amdgpu_smu.c

137d63abbf6a085 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Huang Rui 2018-11-29  1350  
94ed6d0cfdb867b drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Huang Rui 2019-01-11  1351  int smu_display_configuration_change(struct smu_context *smu,
94ed6d0cfdb867b drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Huang Rui 2019-01-11  1352  				     const struct amd_pp_display_configuration *display_config)
94ed6d0cfdb867b drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Huang Rui 2019-01-11  1353  {
94ed6d0cfdb867b drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Huang Rui 2019-01-11  1354  	int index = 0;
94ed6d0cfdb867b drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Huang Rui 2019-01-11 @1355  	int num_of_active_display = 0;
94ed6d0cfdb867b drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Huang Rui 2019-01-11  1356  
2b7ad277e96577e drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Evan Quan 2020-05-25  1357  	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
2b7ad277e96577e drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Evan Quan 2020-05-25  1358  		return -EOPNOTSUPP;
94ed6d0cfdb867b drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Huang Rui 2019-01-11  1359  
94ed6d0cfdb867b drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Huang Rui 2019-01-11  1360  	if (!display_config)
94ed6d0cfdb867b drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Huang Rui 2019-01-11  1361  		return -EINVAL;
94ed6d0cfdb867b drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Huang Rui 2019-01-11  1362  
94ed6d0cfdb867b drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Huang Rui 2019-01-11  1363  	mutex_lock(&smu->mutex);
94ed6d0cfdb867b drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Huang Rui 2019-01-11  1364  
ce63d8f8b55d28c drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Evan Quan 2020-06-08  1365  	smu_set_min_dcef_deep_sleep(smu,
94ed6d0cfdb867b drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Huang Rui 2019-01-11  1366  				    display_config->min_dcef_deep_sleep_set_clk / 100);
94ed6d0cfdb867b drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Huang Rui 2019-01-11  1367  
94ed6d0cfdb867b drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Huang Rui 2019-01-11  1368  	for (index = 0; index < display_config->num_path_including_non_display; index++) {
94ed6d0cfdb867b drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Huang Rui 2019-01-11  1369  		if (display_config->displays[index].controller_id != 0)
94ed6d0cfdb867b drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Huang Rui 2019-01-11  1370  			num_of_active_display++;
94ed6d0cfdb867b drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Huang Rui 2019-01-11  1371  	}
94ed6d0cfdb867b drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Huang Rui 2019-01-11  1372  
94ed6d0cfdb867b drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Huang Rui 2019-01-11  1373  	mutex_unlock(&smu->mutex);
94ed6d0cfdb867b drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Huang Rui 2019-01-11  1374  
94ed6d0cfdb867b drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Huang Rui 2019-01-11  1375  	return 0;
94ed6d0cfdb867b drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Huang Rui 2019-01-11  1376  }
94ed6d0cfdb867b drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Huang Rui 2019-01-11  1377  

:::::: The code at line 1355 was first introduced by commit
:::::: 94ed6d0cfdb867be9bf05f03d682980bce5d0036 drm/amd/powerplay: add smu display configuration change function

:::::: TO: Huang Rui <ray.huang@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
