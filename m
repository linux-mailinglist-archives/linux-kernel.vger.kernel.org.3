Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38FF4A58EF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 10:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235822AbiBAJEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 04:04:32 -0500
Received: from mga11.intel.com ([192.55.52.93]:50040 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230333AbiBAJEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 04:04:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643706271; x=1675242271;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wf+xrgkE1Zo+W2jz+M4MNTTz74szHxj0rhJEiTNgtWE=;
  b=Ii3P6nn0KvXqnvvFv9BMqJvA2Nxs4C5a7LI4wmBD4Wcl/EL5AVgStqCC
   kgOUR/D8Wn7XDwL5QcSty0u44auo2FIvtQCtREwqkeDjAtMvf+/6XGigA
   hQVddf4IRwLZZw/kdSkalzqX79fxYQzQD6reL35oZI6Kev4usifaW97NA
   LQBcooFEAkgKkXOBK2EIzmTLQw2nVKOx4hCCjfg89h6aZu/oPDbnYR8i9
   xfVul4jxuwLxtJCQvhSw3BEYVdhknxYUFtDLtGd6EkmDSQVsGKpXorriy
   RFbDp8USlDuYNcxufR+Je++wSZ+poAVcrVhhXuBUXS0KijSPzT0vpHMsY
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="245239627"
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="245239627"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 01:04:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="619735163"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Feb 2022 01:04:28 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEp5Q-000T34-9W; Tue, 01 Feb 2022 09:04:28 +0000
Date:   Tue, 1 Feb 2022 17:04:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [agd5f:drm-next 208/242]
 drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:1427:87: error: expected ';'
 after return statement
Message-ID: <202202011714.xDhvShrU-lkp@intel.com>
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
config: i386-randconfig-a011 (https://download.01.org/0day-ci/archive/20220201/202202011714.xDhvShrU-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 6b1e844b69f15bb7dffaf9365cd2b355d2eb7579)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout 11bc42ea179dc5cbbab1bd8fd7b7a97fa46c3442
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_irq.c:29:
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:1427:87: error: expected ';' after return statement
   static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { return false };
                                                                                         ^
                                                                                         ;
   1 error generated.
--
   In file included from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_mst_types.c:31:
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:1427:87: error: expected ';' after return statement
   static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { return false };
                                                                                         ^
                                                                                         ;
   In file included from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_mst_types.c:43:
   drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h:2921:12: warning: variable 'temp' set but not used [-Wunused-but-set-variable]
                   uint64_t temp;
                            ^
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_mst_types.c:213:6: warning: no previous prototype for function 'retrieve_downstream_port_device' [-Wmissing-prototypes]
   bool retrieve_downstream_port_device(struct amdgpu_dm_connector *aconnector)
        ^
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_mst_types.c:213:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   bool retrieve_downstream_port_device(struct amdgpu_dm_connector *aconnector)
   ^
   static 
   2 warnings and 1 error generated.
--
   In file included from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:29:
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:1427:87: error: expected ';' after return statement
   static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { return false };
                                                                                         ^
                                                                                         ;
   In file included from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:33:
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dmub/dmub_srv.h:67:
   drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h:2921:12: warning: variable 'temp' set but not used [-Wunused-but-set-variable]
                   uint64_t temp;
                            ^
   1 warning and 1 error generated.
--
   In file included from drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:42:
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:1427:87: error: expected ';' after return statement
   static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { return false };
                                                                                         ^
                                                                                         ;
   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:1211:18: warning: result of comparison of constant 4294967296 with expression of type 'resource_size_t' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
                       res->start > 0x100000000ull)
                       ~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                                                 ^~~~
   include/linux/compiler.h:58:86: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                                                        ^~~~
   include/linux/compiler.h:69:3: note: expanded from macro '__trace_if_value'
           (cond) ?                                        \
            ^~~~
   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:1211:18: warning: result of comparison of constant 4294967296 with expression of type 'resource_size_t' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
                       res->start > 0x100000000ull)
                       ~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                                                 ^~~~
   include/linux/compiler.h:58:52: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                      ^~~~
   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:1211:18: warning: result of comparison of constant 4294967296 with expression of type 'resource_size_t' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
                       res->start > 0x100000000ull)
                       ~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                                                 ^~~~
   include/linux/compiler.h:58:61: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                               ^~~~
   3 warnings and 1 error generated.
--
   In file included from drivers/gpu/drm/amd/amdgpu/../pm/amdgpu_dpm_internal.c:24:
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:1427:87: error: expected ';' after return statement
   static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { return false };
                                                                                         ^
                                                                                         ;
   drivers/gpu/drm/amd/amdgpu/../pm/amdgpu_dpm_internal.c:29:6: warning: no previous prototype for function 'amdgpu_dpm_get_active_displays' [-Wmissing-prototypes]
   void amdgpu_dpm_get_active_displays(struct amdgpu_device *adev)
        ^
   drivers/gpu/drm/amd/amdgpu/../pm/amdgpu_dpm_internal.c:29:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void amdgpu_dpm_get_active_displays(struct amdgpu_device *adev)
   ^
   static 
   drivers/gpu/drm/amd/amdgpu/../pm/amdgpu_dpm_internal.c:76:5: warning: no previous prototype for function 'amdgpu_dpm_get_vrefresh' [-Wmissing-prototypes]
   u32 amdgpu_dpm_get_vrefresh(struct amdgpu_device *adev)
       ^
   drivers/gpu/drm/amd/amdgpu/../pm/amdgpu_dpm_internal.c:76:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   u32 amdgpu_dpm_get_vrefresh(struct amdgpu_device *adev)
   ^
   static 
   2 warnings and 1 error generated.
--
   In file included from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:35:
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dmub/dmub_srv.h:67:
   drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h:2921:12: warning: variable 'temp' set but not used [-Wunused-but-set-variable]
                   uint64_t temp;
                            ^
   In file included from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:44:
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:1427:87: error: expected ';' after return statement
   static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { return false };
                                                                                         ^
                                                                                         ;
   1 warning and 1 error generated.


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
