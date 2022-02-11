Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBB84B2C3F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 19:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbiBKR6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 12:58:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352375AbiBKR6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:58:04 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F4BCE9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 09:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644602282; x=1676138282;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6FUVCvwln8ov+HCRQVOHB5cqwwLgdOgqqJHwvBe7IXE=;
  b=DiNsU3ItFQhocvCZ6RsRUtYppN346zFydOLUabycQEFVvr4wF6kovAZC
   Cm7uk1E89G6pJnTYTtqSDyI1xISG8IIwLxEAcjxRWpPe8xfevVme+WMX0
   f2qRTDahtx0PI0KvyiJu+hEBndlVVunVBosqC89my+9Cs+ehzp3eYidbC
   hYjrm2UccxrzKRI+6BCBwsecaS4wPqE7JI8B365Cmq/bIJhwA82xKTNz5
   sEk+vQE27M0YZeucAN/cK0m96IZ4pLUxVGnYOVSWdUmKlTmdIp1EaiZwm
   QO00r4GrsxHxYh4PbIdPiY05ZVFa5Upzal4lGalBHJ0FtKR/SvTqKSIOL
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="313059259"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="313059259"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 09:58:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="702188199"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 11 Feb 2022 09:58:01 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIaBE-0004t3-Cm; Fri, 11 Feb 2022 17:58:00 +0000
Date:   Sat, 12 Feb 2022 01:57:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Koba Ko <koba.ko@canonical.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:1744:11:
 error: dereferencing pointer to incomplete type 'struct cpuinfo_x86'
Message-ID: <202202111942.s5hvtoIO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
head:   f1baf68e1383f6ed93eb9cff2866d46562607a43
commit: b3dc549986eb7b38eba4a144e979dc93f386751f drm/amdgpu: Disable PCIE_DPM on Intel RKL Platform
date:   6 months ago
config: um-allmodconfig (https://download.01.org/0day-ci/archive/20220211/202202111942.s5hvtoIO-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
