Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F5549C38D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 07:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235481AbiAZGSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 01:18:46 -0500
Received: from mga18.intel.com ([134.134.136.126]:37705 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229786AbiAZGSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 01:18:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643177925; x=1674713925;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rMw1/ndT0AeN4GrfXWqVSlhKRbdH3kGgEI1ea2G9Zq4=;
  b=FORFBbE+nta/V7uQCjWIgVPvss6II31fvyuTtm8VCJiaCoD4CjCJkaLR
   thAn38qV7JiX95gH8dpVng46AYoBTeKm9D7/ubQIVfg1PKSU360kGPi1O
   AWxptaG3fSlwM000yhRWmsUNjSNpoaaptyvKCz9KErtCIMV35UvcVjkVl
   HN7dAElSz2sjVj09VxOw+umsfHTk96dVB38uRww+P47nU07UzrQSBWYe0
   timYB1AAgy6XX37++o35aluVkLvH0g6VAO6JqUm6dvXrBaBGTPHP5pScc
   XLMpriQkwdWVYEaKdnyGYYOADNaSSUqbBb4MXidTGrHHWZ9hRzk0JDqck
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="230063246"
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="230063246"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 22:18:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="520686440"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 25 Jan 2022 22:18:35 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCbdb-000Krc-30; Wed, 26 Jan 2022 06:18:35 +0000
Date:   Wed, 26 Jan 2022 14:17:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Victor Zhao <Victor.Zhao@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [agd5f:drm-next 181/190]
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: warning: "CONFIG_ARM64" is
 not defined, evaluates to 0
Message-ID: <202201261425.poUnqNur-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   63e583c8843f305a3e334a96d5de00435f4d38a2
commit: 6131c5e0ffa8e616ac27c10f3fae3b431c54f232 [181/190] drm/amdgpu: add determine passthrough under arm64
config: sparc64-buildonly-randconfig-r002-20220124 (https://download.01.org/0day-ci/archive/20220126/202201261425.poUnqNur-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout 6131c5e0ffa8e616ac27c10f3fae3b431c54f232
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc64 SHELL=/bin/bash drivers/gpu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/amd/amdgpu/amdgpu.h:93,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:42:
   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h: In function 'is_virtual_machine':
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: warning: "CONFIG_ARM64" is not defined, evaluates to 0 [-Wundef]
     299 | #elif CONFIG_ARM64
         |       ^~~~~~~~~~~~
--
   In file included from drivers/gpu/drm/amd/amdgpu/amdgpu.h:93,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c:27:
   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h: In function 'is_virtual_machine':
>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h:299:7: warning: "CONFIG_ARM64" is not defined, evaluates to 0 [-Wundef]
     299 | #elif CONFIG_ARM64
         |       ^~~~~~~~~~~~
   At top level:
   drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c:110:37: warning: 'amdgpu_rap_debugfs_ops' defined but not used [-Wunused-const-variable=]
     110 | static const struct file_operations amdgpu_rap_debugfs_ops = {
         |                                     ^~~~~~~~~~~~~~~~~~~~~~
--
   In file included from drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:93,
                    from drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/arcturus_ppt.c:27:
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h: In function 'is_virtual_machine':
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: warning: "CONFIG_ARM64" is not defined, evaluates to 0 [-Wundef]
     299 | #elif CONFIG_ARM64
         |       ^~~~~~~~~~~~
--
   In file included from drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:93,
                    from drivers/gpu/drm/amd/amdgpu/../pm/amdgpu_pm.c:26:
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h: In function 'is_virtual_machine':
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: warning: "CONFIG_ARM64" is not defined, evaluates to 0 [-Wundef]
     299 | #elif CONFIG_ARM64
         |       ^~~~~~~~~~~~
   At top level:
   drivers/gpu/drm/amd/amdgpu/../pm/amdgpu_pm.c:38:34: warning: 'clocks' defined but not used [-Wunused-const-variable=]
      38 | static const struct cg_flag_name clocks[] = {
         |                                  ^~~~~~
--
   In file included from drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:93,
                    from drivers/gpu/drm/amd/amdgpu/../pm/amdgpu_dpm_internal.c:24:
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h: In function 'is_virtual_machine':
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: warning: "CONFIG_ARM64" is not defined, evaluates to 0 [-Wundef]
     299 | #elif CONFIG_ARM64
         |       ^~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../pm/amdgpu_dpm_internal.c: At top level:
   drivers/gpu/drm/amd/amdgpu/../pm/amdgpu_dpm_internal.c:29:6: warning: no previous prototype for 'amdgpu_dpm_get_active_displays' [-Wmissing-prototypes]
      29 | void amdgpu_dpm_get_active_displays(struct amdgpu_device *adev)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../pm/amdgpu_dpm_internal.c:76:5: warning: no previous prototype for 'amdgpu_dpm_get_vrefresh' [-Wmissing-prototypes]
      76 | u32 amdgpu_dpm_get_vrefresh(struct amdgpu_device *adev)
         |     ^~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dmub/dmub_srv.h:67,
                    from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:35:
   drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h: In function 'dmub_rb_flush_pending':
   drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h:2921:26: warning: variable 'temp' set but not used [-Wunused-but-set-variable]
    2921 |                 uint64_t temp;
         |                          ^~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:93,
                    from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:44:
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h: In function 'is_virtual_machine':
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: warning: "CONFIG_ARM64" is not defined, evaluates to 0 [-Wundef]
     299 | #elif CONFIG_ARM64
         |       ^~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: In function 'dm_dmub_hw_init':
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:1030:20: warning: unused variable 'dc' [-Wunused-variable]
    1030 |         struct dc *dc = adev->dm.dc;
         |                    ^~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/link_enc_cfg.h:33,
                    from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:32:
   At top level:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:127:22: warning: 'SYNAPTICS_DEVICE_ID' defined but not used [-Wunused-const-variable=]
     127 | static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
         |                      ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:124:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     124 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:123:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     123 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:93,
                    from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_mst_types.c:31:
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h: In function 'is_virtual_machine':
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: warning: "CONFIG_ARM64" is not defined, evaluates to 0 [-Wundef]
     299 | #elif CONFIG_ARM64
         |       ^~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_mst_types.c:43:
   drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h: In function 'dmub_rb_flush_pending':
   drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h:2921:26: warning: variable 'temp' set but not used [-Wunused-but-set-variable]
    2921 |                 uint64_t temp;
         |                          ^~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/dc_link_ddc.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_mst_types.c:38:
   At top level:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:127:22: warning: 'SYNAPTICS_DEVICE_ID' defined but not used [-Wunused-const-variable=]
     127 | static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
         |                      ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:124:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     124 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:123:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     123 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:93,
                    from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_services.c:32:
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h: In function 'is_virtual_machine':
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: warning: "CONFIG_ARM64" is not defined, evaluates to 0 [-Wundef]
     299 | #elif CONFIG_ARM64
         |       ^~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_trace.h:40,
                    from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_services.c:36:
   At top level:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:127:22: warning: 'SYNAPTICS_DEVICE_ID' defined but not used [-Wunused-const-variable=]
     127 | static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
         |                      ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:124:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     124 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:123:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     123 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:93,
                    from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_helpers.c:35:
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h: In function 'is_virtual_machine':
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: warning: "CONFIG_ARM64" is not defined, evaluates to 0 [-Wundef]
     299 | #elif CONFIG_ARM64
         |       ^~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_helpers.c: At top level:
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_helpers.c:962:6: warning: no previous prototype for 'dm_helpers_enable_periodic_detection' [-Wmissing-prototypes]
     962 | void dm_helpers_enable_periodic_detection(struct dc_context *ctx, bool enable)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_helpers.c:42:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:127:22: warning: 'SYNAPTICS_DEVICE_ID' defined but not used [-Wunused-const-variable=]
     127 | static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
         |                      ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:124:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     124 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:123:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     123 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:93,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:38:
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h: In function 'is_virtual_machine':
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h:299:7: warning: "CONFIG_ARM64" is not defined, evaluates to 0 [-Wundef]
     299 | #elif CONFIG_ARM64
         |       ^~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dmub/dmub_srv.h:67,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.h:30,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:40:
   drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h: In function 'dmub_rb_flush_pending':
   drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h:2921:26: warning: variable 'temp' set but not used [-Wunused-but-set-variable]
    2921 |                 uint64_t temp;
         |                          ^~~~


vim +/CONFIG_ARM64 +299 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h

   294	
   295	static inline bool is_virtual_machine(void)
   296	{
   297	#ifdef CONFIG_X86
   298		return boot_cpu_has(X86_FEATURE_HYPERVISOR);
 > 299	#elif CONFIG_ARM64
   300		return !is_kernel_in_hyp_mode();
   301	#else
   302		return false;
   303	#endif
   304	}
   305	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
