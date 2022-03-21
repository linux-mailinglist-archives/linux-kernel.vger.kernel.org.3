Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D91E4E20A1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 07:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344605AbiCUGiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 02:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240240AbiCUGio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 02:38:44 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A30BA336
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 23:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647844640; x=1679380640;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IGeMfCRhm3fXY08UTQC5jBtxs2IlelwWauGtSBCUq5I=;
  b=NwQ/4KTeGm+8QYmEY7iTkV3tIbfFp/tws+/9og8ZN5MbGTIGLiWaHGr5
   k13xy1uB2e9zkhABd2Xdz2wuor+9MBbAXcJ8agFfZFuw2amxfxKYFTfz9
   SF08JOpeoU0zU1436IAOY7McITJTeBjwfDdOIlyQqZvG2rJis6Mc/eh27
   U/NWcBYO15kIfWDSCZKZ72FS3CpNGjUvYFQ4muJpx/u6hX2q5pTrbwj6M
   lntg9AKTiUNcW4L+DWpabS7/CdZZf8SjEhLQWrI8qIVVNpu4ue0M3kESF
   p0KF1+JDQD8FXYGIMdpafj7TsAgs6t0uSw9u/5l65GAGJmqQOYyIZ1e66
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="256298619"
X-IronPort-AV: E=Sophos;i="5.90,197,1643702400"; 
   d="scan'208";a="256298619"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2022 23:37:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,197,1643702400"; 
   d="scan'208";a="648448451"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 20 Mar 2022 23:37:18 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWBfJ-000HYl-LV; Mon, 21 Mar 2022 06:37:17 +0000
Date:   Mon, 21 Mar 2022 14:36:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Koba Ko <koba.ko@canonical.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:1744:11:
 error: dereferencing pointer to incomplete type 'struct cpuinfo_x86'
Message-ID: <202203211404.CXFYnU02-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
head:   f443e374ae131c168a065ea1748feac6b2e76613
commit: b3dc549986eb7b38eba4a144e979dc93f386751f drm/amdgpu: Disable PCIE_DPM on Intel RKL Platform
date:   7 months ago
config: um-allmodconfig (https://download.01.org/0day-ci/archive/20220321/202203211404.CXFYnU02-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b3dc549986eb7b38eba4a144e979dc93f386751f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout b3dc549986eb7b38eba4a144e979dc93f386751f
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SHELL=/bin/bash drivers/gpu/drm/

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
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:1742:27: note: in expansion of macro 'cpu_data'
    1742 |  struct cpuinfo_x86 *c = &cpu_data(0);
         |                           ^~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:1744:11: error: dereferencing pointer to incomplete type 'struct cpuinfo_x86'
    1744 |  return (c->x86 == 6 && c->x86_model == INTEL_FAM6_ROCKETLAKE);
         |           ^~
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
