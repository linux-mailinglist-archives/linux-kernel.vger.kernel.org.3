Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07FA4A85C1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351001AbiBCOGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:06:24 -0500
Received: from mga12.intel.com ([192.55.52.136]:31668 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350987AbiBCOGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:06:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643897177; x=1675433177;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5B9AIPF6SdtEmhAa6LrpjgkcyJ4vM83xwW97m3lQ4qg=;
  b=kVEM1+ewZnno8NmjTyhG0i883JWfyVLhHM6dANBtmwfpfsZy9d+SCD8K
   xEHjYORT/AZNqr2ZVzUYFD5cbA6S8LR5gGRfkz7vNCGA7h8EZHQbSVtVC
   F42TO7TCkJYd7PfNHd9kzXRhbKa5Ag6igN3xWL9Y6StwZfQmLpnORvKjW
   zBP1Kt7Jh1aWx/3AOdoyhjDBYTQjkTpo2YmjJ2ZdTMDEV0afg/r8t1azR
   naiyJE8MdfH71JXzYVZ+zVhgO9cvoo9lzjIbj9HcvZakYB0xMVz103df+
   yHAL0yFRzu/B8v5juZeMTJpSDzl3PfFcudCVbs6EfgphX3Vy0ybx3iMkF
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="228115541"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="228115541"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 06:06:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="769630768"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 03 Feb 2022 06:06:15 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFckY-000WC9-Kj; Thu, 03 Feb 2022 14:06:14 +0000
Date:   Thu, 3 Feb 2022 22:06:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Darren Powell <darren.powell@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [agd5f:drm-next 243/250]
 drivers/gpu/drm/amd/amdgpu/../pm/swsmu/amdgpu_smu.c:2277:13: warning:
 variable 'ret' set but not used
Message-ID: <202202031511.FRQppMha-lkp@intel.com>
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
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20220203/202202031511.FRQppMha-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout 5d64f9bbb6281a5a89a2266b9d39daa1fca1d6b4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/amdgpu_smu.c: In function 'smu_emit_ppclk_levels':
>> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/amdgpu_smu.c:2277:13: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
    2277 |         int ret = 0;
         |             ^~~


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
