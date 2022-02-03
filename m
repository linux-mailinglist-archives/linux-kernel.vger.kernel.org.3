Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EA94A87D8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 16:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbiBCPjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 10:39:48 -0500
Received: from mga03.intel.com ([134.134.136.65]:59850 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351945AbiBCPjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 10:39:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643902764; x=1675438764;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7mRbriesMnc5y9jim1krZpY4CvguXRL9C3UcMNNveDg=;
  b=hB8+6qrbbAXoX/kggvGMkn36g3Z7mHGgQ06IwPAJ7j3WIhAKaSSHnJqI
   qCexT8DfMpoYnUXh/opC9KxmtC0n+ceaQ1/ovuG+XmphTwJSTJWmlfRPq
   WJSnsmKqGJ/k4H7GrSpeGpJBq8zeXBhP393FveW8Arkz61zgv11HZNnVY
   mFIXfBKtD5xxNgyRtiKVvmsw8CMq7Eq2AsrQzvBmK7EXsakSavMpfEJ0k
   OEMxWE1mEfP9Lm77FAaclyF6ZvHTmBrngImsJzM8Wtu6d729cwwLq8yIy
   mWHR6uET1tBsp8gS8xy4fOg4dA9VBgUy3rR8yXkbdHhtYhKNrGPJyDJ31
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="248119025"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="248119025"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 07:39:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="583821356"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 03 Feb 2022 07:39:18 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFeCb-000WI2-SS; Thu, 03 Feb 2022 15:39:17 +0000
Date:   Thu, 3 Feb 2022 23:38:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Darren Powell <darren.powell@amd.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [agd5f:drm-next 243/250]
 drivers/gpu/drm/amd/amdgpu/../pm/swsmu/amdgpu_smu.c:2277:6: warning:
 variable 'ret' set but not used
Message-ID: <202202032303.GcRtJxzw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   53593d1be00c441585cb4fec41a756b8e586b710
commit: 5d64f9bbb6281a5a89a2266b9d39daa1fca1d6b4 [243/250] amdgpu/pm: Implement new API function "emit" that accepts buffer base and write offset
config: i386-randconfig-a011-20220131 (https://download.01.org/0day-ci/archive/20220203/202202032303.GcRtJxzw-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a73e4ce6a59b01f0e37037761c1e6889d539d233)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout 5d64f9bbb6281a5a89a2266b9d39daa1fca1d6b4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/amdgpu_smu.c:2277:6: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
           int ret = 0;
               ^
   1 warning generated.


vim +/ret +2277 drivers/gpu/drm/amd/amdgpu/../pm/swsmu/amdgpu_smu.c

  2272	
  2273	static int smu_emit_ppclk_levels(void *handle, enum pp_clock_type type, char *buf, int *offset)
  2274	{
  2275		struct smu_context *smu = handle;
  2276		enum smu_clk_type clk_type;
> 2277		int ret = 0;
  2278	
  2279		clk_type = smu_convert_to_smuclk(type);
  2280		if (clk_type == SMU_CLK_COUNT)
  2281			return -EINVAL;
  2282	
  2283		if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
  2284			return -EOPNOTSUPP;
  2285	
  2286		if (!smu->ppt_funcs->emit_clk_levels)
  2287			ret = -ENOENT;
  2288	
  2289		return smu->ppt_funcs->emit_clk_levels(smu, clk_type, buf, offset);
  2290	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
