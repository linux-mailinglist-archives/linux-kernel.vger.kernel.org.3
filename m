Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDAB58D8AB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 14:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239002AbiHIMTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 08:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234170AbiHIMTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 08:19:50 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1CA1ADA9
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 05:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660047589; x=1691583589;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EN0BtWfGZj+U4kbcfOmfGPZUzYI/nONzeDPEL/tkMOM=;
  b=QHsR3qv83UQv0/1hyu9qHLlr84HO17/x1B0ro48toe6KbYMQitWB+JEh
   JscakzdE9jeozbutDcoaPzcfhJaReFLoUYFuDx3811L08ZqqkBsuUHLl8
   vLbdd7J6cqAkrvONfXYGngW30TtuvVgcCiNs2QXKYsIklElJxnRwlUdmF
   mB+hfC+ppLEHG8peYxhjZhXHPLAxZPolpl64y0GE+BPXaac3rClOwPaFR
   usiyA6X/VZFEfsrWMDdFu5UknqQFHYAFhOnhLIrszeC1aaJfJS46CgfiS
   TIDOk4SRReev8KHKXdZOESE4faW7L7n5Ue7dVfMFVSiGcZNchLiTwZb9v
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="271204497"
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="271204497"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 05:19:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="664410992"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 09 Aug 2022 05:19:47 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLOD4-000Mvd-2G;
        Tue, 09 Aug 2022 12:19:46 +0000
Date:   Tue, 9 Aug 2022 20:19:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jack Xiao <Jack.Xiao@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:864:13: warning: variable
 'r' set but not used
Message-ID: <202208092032.V6o0PjnJ-lkp@intel.com>
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

Hi Jack,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   eb555cb5b794f4e12a9897f3d46d5a72104cd4a7
commit: e3652b0976f383dea912607a404e974632b019b1 drm/amdgpu/mes: add helper functions to alloc/free ctx metadata
date:   3 months ago
config: arc-randconfig-r043-20220808 (https://download.01.org/0day-ci/archive/20220809/202208092032.V6o0PjnJ-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e3652b0976f383dea912607a404e974632b019b1
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e3652b0976f383dea912607a404e974632b019b1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/gpu/drm/amd/amdgpu/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:22,
                    from arch/arc/include/asm/bug.h:30,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/current.h:5,
                    from arch/arc/include/asm/current.h:20,
                    from include/linux/mutex.h:14,
                    from include/linux/kernfs.h:11,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from include/linux/irqdomain.h:35,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h:27,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h:27,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:24:
   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c: In function 'amdgpu_mes_doorbell_init':
   include/linux/kern_levels.h:5:25: warning: format '%ld' expects argument of type 'long int', but argument 2 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:418:25: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/drm/drm_print.h:494:9: note: in expansion of macro 'printk'
     494 |         printk##once(KERN_##level "[" DRM_NAME "] " fmt, ##__VA_ARGS__)
         |         ^~~~~~
   include/linux/kern_levels.h:14:25: note: in expansion of macro 'KERN_SOH'
      14 | #define KERN_INFO       KERN_SOH "6"    /* informational */
         |                         ^~~~~~~~
   include/drm/drm_print.h:494:22: note: in expansion of macro 'KERN_INFO'
     494 |         printk##once(KERN_##level "[" DRM_NAME "] " fmt, ##__VA_ARGS__)
         |                      ^~~~~
   include/drm/drm_print.h:498:9: note: in expansion of macro '_DRM_PRINTK'
     498 |         _DRM_PRINTK(, INFO, fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:131:9: note: in expansion of macro 'DRM_INFO'
     131 |         DRM_INFO("max_doorbell_slices=%ld\n", doorbell_process_limit);
         |         ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c: In function 'amdgpu_mes_ctx_alloc_meta_data':
>> drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:864:13: warning: variable 'r' set but not used [-Wunused-but-set-variable]
     864 |         int r;
         |             ^


vim +/r +864 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c

   860	
   861	int amdgpu_mes_ctx_alloc_meta_data(struct amdgpu_device *adev,
   862					   struct amdgpu_mes_ctx_data *ctx_data)
   863	{
 > 864		int r;
   865	
   866		r = amdgpu_bo_create_kernel(adev,
   867				    sizeof(struct amdgpu_mes_ctx_meta_data),
   868				    PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT,
   869				    &ctx_data->meta_data_obj, NULL,
   870				    &ctx_data->meta_data_ptr);
   871		if (!ctx_data->meta_data_obj)
   872			return -ENOMEM;
   873	
   874		memset(ctx_data->meta_data_ptr, 0,
   875		       sizeof(struct amdgpu_mes_ctx_meta_data));
   876	
   877		return 0;
   878	}
   879	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
