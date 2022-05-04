Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982D551B1CF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 00:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378977AbiEDWba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 18:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245110AbiEDWbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:31:21 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B441837E
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 15:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651703263; x=1683239263;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=boC9Ra/3hAUVYGsNwGu1M/furVga6JLszjqJK0CsnWA=;
  b=G1m8X64TXhZBOjUju7F7YLJ66z3qbaXcq3Iam/6odlwXuj1BjAjlx1RQ
   Y7O7OsFh5zW3mhq8hwGJYUBFPBcQ+xo6DxHPYoqeZ96QuW3u9NmSai6t2
   AHGGzLubl5dATnodyAxc1MioyHn6br0waeHju4EQPvN9BWMsjF3cX5Eq0
   mq3QFcuaMW/iby3/jurrEwyz+nypEosRlki5GheSPQrqeUg+e0DA+0gEe
   qoA8EmkCUY/H001LqZcyU1WuAnF/b5u6Q3XWoeUCMYRLEVsjJ8d7oUqxm
   6HwT7IN2QBRgftHiMGk0t35r14IfpYhWUdfPRgJZPwBldjM7Rkb8ksMpG
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="247825471"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="247825471"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 15:27:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="584979467"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 04 May 2022 15:27:41 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmNTA-000Bqa-Mj;
        Wed, 04 May 2022 22:27:40 +0000
Date:   Thu, 5 May 2022 06:27:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jack Xiao <Jack.Xiao@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [agd5f:drm-next 375/460] include/linux/kern_levels.h:5:25: warning:
 format '%ld' expects argument of type 'long int', but argument 2 has type
 'size_t' {aka 'unsigned int'}
Message-ID: <202205050614.sRcY9JVz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   d6ffefccf7f04eefddc8e8aa35fb4afe05a42e0c
commit: 32de57e9ef59b6f646849a8bd615b7c978a4fa6d [375/460] drm/amdgpu/mes: manage mes doorbell allocation
config: parisc-buildonly-randconfig-r004-20220501 (https://download.01.org/0day-ci/archive/20220505/202205050614.sRcY9JVz-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout 32de57e9ef59b6f646849a8bd615b7c978a4fa6d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash drivers/gpu/drm/amd/amdgpu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:29,
                    from include/linux/cpumask.h:10,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/mutex.h:17,
                    from include/linux/kernfs.h:11,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from include/linux/irqdomain.h:35,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h:27,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h:27,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:24:
   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c: In function 'amdgpu_mes_doorbell_init':
>> include/linux/kern_levels.h:5:25: warning: format '%ld' expects argument of type 'long int', but argument 2 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
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
   At top level:
   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:105:12: warning: 'amdgpu_mes_doorbell_init' defined but not used [-Wunused-function]
     105 | static int amdgpu_mes_doorbell_init(struct amdgpu_device *adev)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:90:13: warning: 'amdgpu_mes_queue_doorbell_free' defined but not used [-Wunused-function]
      90 | static void amdgpu_mes_queue_doorbell_free(struct amdgpu_device *adev,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:59:12: warning: 'amdgpu_mes_queue_doorbell_get' defined but not used [-Wunused-function]
      59 | static int amdgpu_mes_queue_doorbell_get(struct amdgpu_device *adev,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:51:13: warning: 'amdgpu_mes_free_process_doorbells' defined but not used [-Wunused-function]
      51 | static void amdgpu_mes_free_process_doorbells(struct amdgpu_device *adev,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:39:12: warning: 'amdgpu_mes_alloc_process_doorbells' defined but not used [-Wunused-function]
      39 | static int amdgpu_mes_alloc_process_doorbells(struct amdgpu_device *adev,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +5 include/linux/kern_levels.h

314ba3520e513a7 Joe Perches 2012-07-30  4  
04d2c8c83d0e3ac Joe Perches 2012-07-30 @5  #define KERN_SOH	"\001"		/* ASCII Start Of Header */
04d2c8c83d0e3ac Joe Perches 2012-07-30  6  #define KERN_SOH_ASCII	'\001'
04d2c8c83d0e3ac Joe Perches 2012-07-30  7  

:::::: The code at line 5 was first introduced by commit
:::::: 04d2c8c83d0e3ac5f78aeede51babb3236200112 printk: convert the format for KERN_<LEVEL> to a 2 byte pattern

:::::: TO: Joe Perches <joe@perches.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
