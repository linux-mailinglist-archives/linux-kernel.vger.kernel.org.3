Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B694A5701
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 06:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbiBAFjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 00:39:23 -0500
Received: from mga18.intel.com ([134.134.136.126]:59566 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232330AbiBAFjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 00:39:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643693961; x=1675229961;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Na+0qkxUqL5yYvuisO7RJERjyxgN6byW+WnEMaJD7Zs=;
  b=U+cLPw+OJ8Q05OFh8SOZVnSwQaPVW9nIkc6En1ukB92y4dscV1yo1w3D
   aWtEr0bjMFcRZR86ormlFsFTzF5IX+Jbj5jwqGvwusmognn4BBLoAJH9k
   NVs3Aww5G4632GozVU98grXSnuWaMZnBlJgnF0twau6AP1iXjgohuJk6U
   G18y9ttUszN3A4zWynDXJ4yj7usLfor4WIGSvSnttUyqfST2vD93nLX2f
   IuL5hX/MaFuf9mLC3SBE7f9oDdRjH1+vSvXoJgtlZy00ls2LJwbOURDfB
   wqd+CQP4iaiGzSlf6P4YqpJHiWTuecriJlqd9lnHg30gWytHsM8PerQaW
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="231195483"
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="231195483"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 21:39:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="482093009"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 31 Jan 2022 21:39:19 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nElst-000SpS-4g; Tue, 01 Feb 2022 05:39:19 +0000
Date:   Tue, 1 Feb 2022 13:39:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [agd5f:drm-next 208/242]
 drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:1427:87: error: expected ';'
 before '}' token
Message-ID: <202202011339.JLS9aua6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   349fbcd8a3d7ba0f8c0f748273c2f4be1a668344
commit: 11bc42ea179dc5cbbab1bd8fd7b7a97fa46c3442 [208/242] drm/amd: add support to check whether the system is set to s3
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220201/202202011339.JLS9aua6-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout 11bc42ea179dc5cbbab1bd8fd7b7a97fa46c3442
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/amd/amdgpu/../pm/amdgpu_dpm_internal.c:24:
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h: In function 'amdgpu_acpi_is_s3_active':
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:1427:87: error: expected ';' before '}' token
    1427 | static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { return false };
         |                                                                                       ^~
         |                                                                                       ;
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
   In file included from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:44:
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h: In function 'amdgpu_acpi_is_s3_active':
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:1427:87: error: expected ';' before '}' token
    1427 | static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { return false };
         |                                                                                       ^~
         |                                                                                       ;
   In file included from include/linux/perf_event.h:25,
                    from include/linux/trace_events.h:10,
                    from include/trace/trace_events.h:21,
                    from include/trace/define_trace.h:102,
                    from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_trace.h:669,
                    from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:41:
   At top level:
   arch/arc/include/asm/perf_event.h:126:27: warning: 'arc_pmu_cache_map' defined but not used [-Wunused-const-variable=]
     126 | static const unsigned int arc_pmu_cache_map[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
         |                           ^~~~~~~~~~~~~~~~~
   arch/arc/include/asm/perf_event.h:91:27: warning: 'arc_pmu_ev_hw_map' defined but not used [-Wunused-const-variable=]
      91 | static const char * const arc_pmu_ev_hw_map[] = {
         |                           ^~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/link_enc_cfg.h:33,
                    from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:32:
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
   In file included from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_irq.c:29:
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h: In function 'amdgpu_acpi_is_s3_active':
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:1427:87: error: expected ';' before '}' token
    1427 | static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { return false };
         |                                                                                       ^~
         |                                                                                       ;
--
   In file included from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_mst_types.c:31:
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h: In function 'amdgpu_acpi_is_s3_active':
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:1427:87: error: expected ';' before '}' token
    1427 | static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { return false };
         |                                                                                       ^~
         |                                                                                       ;
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
   In file included from drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c:30:
   drivers/gpu/drm/amd/amdgpu/amdgpu.h: In function 'amdgpu_acpi_is_s3_active':
>> drivers/gpu/drm/amd/amdgpu/amdgpu.h:1427:87: error: expected ';' before '}' token
    1427 | static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { return false };
         |                                                                                       ^~
         |                                                                                       ;
--
   In file included from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_services.c:32:
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h: In function 'amdgpu_acpi_is_s3_active':
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:1427:87: error: expected ';' before '}' token
    1427 | static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { return false };
         |                                                                                       ^~
         |                                                                                       ;
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
   In file included from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_helpers.c:35:
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h: In function 'amdgpu_acpi_is_s3_active':
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:1427:87: error: expected ';' before '}' token
    1427 | static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { return false };
         |                                                                                       ^~
         |                                                                                       ;
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
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:38:
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h: In function 'amdgpu_acpi_is_s3_active':
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:1427:87: error: expected ';' before '}' token
    1427 | static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { return false };
         |                                                                                       ^~
         |                                                                                       ;
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dmub/dmub_srv.h:67,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.h:30,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:40:
   drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h: In function 'dmub_rb_flush_pending':
   drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h:2921:26: warning: variable 'temp' set but not used [-Wunused-but-set-variable]
    2921 |                 uint64_t temp;
         |                          ^~~~
--
   In file included from drivers/gpu/drm/amd/amdgpu/amdgpu_trace_points.c:26:
   drivers/gpu/drm/amd/amdgpu/amdgpu.h: In function 'amdgpu_acpi_is_s3_active':
>> drivers/gpu/drm/amd/amdgpu/amdgpu.h:1427:87: error: expected ';' before '}' token
    1427 | static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { return false };
         |                                                                                       ^~
         |                                                                                       ;
   In file included from include/linux/perf_event.h:25,
                    from include/linux/trace_events.h:10,
                    from include/trace/trace_events.h:21,
                    from include/trace/define_trace.h:102,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h:546,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu_trace_points.c:29:
   At top level:
   arch/arc/include/asm/perf_event.h:126:27: warning: 'arc_pmu_cache_map' defined but not used [-Wunused-const-variable=]
     126 | static const unsigned int arc_pmu_cache_map[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
         |                           ^~~~~~~~~~~~~~~~~
   arch/arc/include/asm/perf_event.h:91:27: warning: 'arc_pmu_ev_hw_map' defined but not used [-Wunused-const-variable=]
      91 | static const char * const arc_pmu_ev_hw_map[] = {
         |                           ^~~~~~~~~~~~~~~~~


vim +1427 drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h

  1421	
  1422	#if defined(CONFIG_ACPI) && defined(CONFIG_SUSPEND)
  1423	bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev);
  1424	bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);
  1425	#else
  1426	static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev) { return false; }
> 1427	static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { return false };
  1428	#endif
  1429	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
