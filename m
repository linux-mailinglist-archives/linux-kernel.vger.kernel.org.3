Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83AF591C94
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 22:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239578AbiHMU1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 16:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238225AbiHMU1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 16:27:33 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDAB240BC
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 13:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660422452; x=1691958452;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1Zm4RKO8C2kEUmxyXI4UzeZ0jyWp5NSnCmzsRL2OFGw=;
  b=eOmCv/kX3z5oen9W/LItxrBlTMLQZah5IzoC9Mt4c/3M7jjt6LgtOhWt
   nwiI77qNw212HTkWKr1S/dRVGwM1hxVXg+7IYX0bKkzXLKRutMyM3mtj0
   616D1bXcO+dz0pLvyk0LpLUjnlHoeSrW6Rj/PJhHnE5Al2oBIJBCicgoE
   3cNSv9bX8S8d9JJ7hiUCfIhzgeVImwzOT5Yc4rnZfCl4CgkSwgIg/oAsR
   oe8JXL9GsgU5zUVfTp9YPd+k3rsdsxml23ZQyA3aCy4IsIaLaAKMjbeCs
   UMFmfc7hZGYQ7P1Kr93DJ1Szn1QIwnWjakALOD0N6zGqcp/0DvTBfN4X0
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="290529281"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="290529281"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 13:27:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="732551986"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 13 Aug 2022 13:27:30 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMxjF-00024x-1X;
        Sat, 13 Aug 2022 20:27:29 +0000
Date:   Sun, 14 Aug 2022 04:27:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Koba Ko <koba.ko@canonical.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:1744:18:
 error: invalid use of undefined type 'struct cpuinfo_x86'
Message-ID: <202208140449.QuPTilYq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Koba,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   69dac8e431af26173ca0a1ebc87054e01c585bcc
commit: b3dc549986eb7b38eba4a144e979dc93f386751f drm/amdgpu: Disable PCIE_DPM on Intel RKL Platform
date:   12 months ago
config: um-allyesconfig (https://download.01.org/0day-ci/archive/20220814/202208140449.QuPTilYq-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b3dc549986eb7b38eba4a144e979dc93f386751f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout b3dc549986eb7b38eba4a144e979dc93f386751f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
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
