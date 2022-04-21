Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308E5509C46
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387696AbiDUJff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387692AbiDUJf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:35:27 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6B915817
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 02:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650533558; x=1682069558;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wynBT3GsNc8N0T1pIpKq8OjfBbxpA23I2Tu5/2/HG7k=;
  b=k/Ou4n+EwH2ltadWXMSO8JJqPxcYldtHKJVgC2lTuS9DiXUJLg4A9MFP
   iJJlrRNvifJpHFXFKq8UJ/1AD6OiShrDTyREHIF63bgJQblhxU7vchvdR
   kNsXzn/3vUqX8JPxaQABrR7d3v2oN0ulab+cD0APvVuzKy0wZ2aTjziFp
   qKJRnjEZ4uvwbH6i5yh3VEn6y2DjtbJ0KfexrvlH6FLZ1tFf+DCySXH6/
   WQtI4NpyDZJLnLR8GbGJIxCU7nsytlGRTIL47RFlBeNi45lUgSTjtim/O
   r4s4XhyQIumP217PJ07Rg/o5Ki+ax+Rgl4E6C993oDix9HeeAhTizo+7N
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="327198393"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="327198393"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 02:32:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="593573923"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 21 Apr 2022 02:32:36 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhTAy-0008Af-3N;
        Thu, 21 Apr 2022 09:32:36 +0000
Date:   Thu, 21 Apr 2022 17:31:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Koba Ko <koba.ko@canonical.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:1744:18:
 error: invalid use of undefined type 'struct cpuinfo_x86'
Message-ID: <202204211734.hHKaiLoZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Koba,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b253435746d9a4a701b5f09211b9c14d3370d0da
commit: b3dc549986eb7b38eba4a144e979dc93f386751f drm/amdgpu: Disable PCIE_DPM on Intel RKL Platform
date:   8 months ago
config: um-allmodconfig (https://download.01.org/0day-ci/archive/20220421/202204211734.hHKaiLoZ-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b3dc549986eb7b38eba4a144e979dc93f386751f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout b3dc549986eb7b38eba4a144e979dc93f386751f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/x86/um/asm/processor.h:41,
                    from include/linux/spinlock_up.h:8,
                    from include/linux/spinlock.h:92,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from drivers/gpu/drm/amd/amdgpu/../pm/inc/pp_debug.h:35,
                    from drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:23:
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c: In function 'intel_core_rkl_chk':
   arch/um/include/asm/processor-generic.h:104:19: error: called object is not a function or function pointer
     104 | #define cpu_data (&boot_cpu_data)
         |                  ~^~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:1742:34: note: in expansion of macro 'cpu_data'
    1742 |         struct cpuinfo_x86 *c = &cpu_data(0);
         |                                  ^~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:1744:18: error: invalid use of undefined type 'struct cpuinfo_x86'
    1744 |         return (c->x86 == 6 && c->x86_model == INTEL_FAM6_ROCKETLAKE);
         |                  ^~
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:1744:33: error: invalid use of undefined type 'struct cpuinfo_x86'
    1744 |         return (c->x86 == 6 && c->x86_model == INTEL_FAM6_ROCKETLAKE);
         |                                 ^~
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:1748:1: error: control reaches end of non-void function [-Werror=return-type]
    1748 | }
         | ^
   cc1: some warnings being treated as errors


vim +1744 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c

  1738	
  1739	static bool intel_core_rkl_chk(void)
  1740	{
  1741	#if IS_ENABLED(CONFIG_X86_64)
  1742		struct cpuinfo_x86 *c = &cpu_data(0);
  1743	
> 1744		return (c->x86 == 6 && c->x86_model == INTEL_FAM6_ROCKETLAKE);
  1745	#else
  1746		return false;
  1747	#endif
  1748	}
  1749	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
