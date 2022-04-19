Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7C3506406
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 07:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348688AbiDSFtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 01:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbiDSFtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 01:49:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A9F27CD3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 22:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650347189; x=1681883189;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QYqHpfCKtvWDg6CmgjDCtxCqfjR4nUJqnP5V5K/4s74=;
  b=AYjeUkMbIK2mXDBBW9uWD4KDt+A5T5xZhA8AqD8+pkvspXPiUI8CZCLC
   aDLDPl52y45c+7N7QyeoMkgtU1J26yVP7M0S1zWITD8bGfboR1rkidfJG
   vSWyXPfX9CIIp1f2DPIMlkLJ9tHHI90kfh6/b6EXJUS64hKPPGiEzKRVW
   K7I7co63c3O5IGv1Y+P4KuPQGxWJUWmao2CWckK1PMfuOjAkVkz+UYI3x
   cMhLI7Y+leqNlbpKM/ttAOCGDfayXIIXooiaJ/oRH/VjdVHI9WYEBWQDu
   J/w1mscXgffxEKTi6Q4H9gR6noixyCa/3E8Oh9KicrrzRsAXy+OQzCzTu
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="263857074"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="263857074"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 22:46:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="804550131"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 18 Apr 2022 22:46:28 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nggh1-0005Or-EG;
        Tue, 19 Apr 2022 05:46:27 +0000
Date:   Tue, 19 Apr 2022 13:45:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Evan Quan <evan.quan@amd.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../pm/swsmu/inc/smu_v11_0_pptable.h:163:17:
 warning: field smc_pptable within 'struct smu_11_0_powerplay_table' is less
 aligned than 'PPTable_t' and is usually due to 'struct
 smu_11_0_powerplay_table' being packed, which can lea...
Message-ID: <202204191309.RHCwD9RR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evan,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b2d229d4ddb17db541098b83524d901257e93845
commit: 837d542a09cd533055423dfca7e621a9c1d13c5b drm/amd/pm: relocate the power related headers
date:   3 months ago
config: arm-randconfig-r035-20220418 (https://download.01.org/0day-ci/archive/20220419/202204191309.RHCwD9RR-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 429cbac0390654f90bba18a41799464adf31a5ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=837d542a09cd533055423dfca7e621a9c1d13c5b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 837d542a09cd533055423dfca7e621a9c1d13c5b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/arcturus_ppt.c:37:
>> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/inc/smu_v11_0_pptable.h:163:17: warning: field smc_pptable within 'struct smu_11_0_powerplay_table' is less aligned than 'PPTable_t' and is usually due to 'struct smu_11_0_powerplay_table' being packed, which can lead to unaligned accesses [-Wunaligned-access]
         PPTable_t smc_pptable;                        //PPTable_t in smu11_driver_if.h
                   ^
   1 warning generated.
--
   In file included from drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/sienna_cichlid_ppt.c:39:
>> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/inc/smu_v11_0_7_pptable.h:193:17: warning: field smc_pptable within 'struct smu_11_0_7_powerplay_table' is less aligned than 'PPTable_t' and is usually due to 'struct smu_11_0_7_powerplay_table' being packed, which can lead to unaligned accesses [-Wunaligned-access]
         PPTable_t smc_pptable;                        //PPTable_t in smu11_driver_if.h
                   ^
   1 warning generated.
--
   In file included from drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/aldebaran_ppt.c:37:
>> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/inc/smu_v13_0_pptable.h:161:12: warning: field smc_pptable within 'struct smu_13_0_powerplay_table' is less aligned than 'PPTable_t' and is usually due to 'struct smu_13_0_powerplay_table' being packed, which can lead to unaligned accesses [-Wunaligned-access]
           PPTable_t smc_pptable;                        //PPTable_t in driver_if.h
                     ^
   1 warning generated.


vim +163 drivers/gpu/drm/amd/amdgpu/../pm/swsmu/inc/smu_v11_0_pptable.h

ae35cd6a480f9c drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_pptable.h Huang Rui    2018-12-12  137  
ae35cd6a480f9c drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_pptable.h Huang Rui    2018-12-12  138  struct smu_11_0_powerplay_table
ae35cd6a480f9c drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_pptable.h Huang Rui    2018-12-12  139  {
ae35cd6a480f9c drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_pptable.h Huang Rui    2018-12-12  140        struct atom_common_table_header header;
ae35cd6a480f9c drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_pptable.h Huang Rui    2018-12-12  141        uint8_t  table_revision;
4b2bb705a0b72f drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_pptable.h Kenneth Feng 2019-04-04  142        uint16_t table_size;                          //Driver portion table size. The offset to smc_pptable including header size
ae35cd6a480f9c drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_pptable.h Huang Rui    2018-12-12  143        uint32_t golden_pp_id;
ae35cd6a480f9c drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_pptable.h Huang Rui    2018-12-12  144        uint32_t golden_revision;
ae35cd6a480f9c drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_pptable.h Huang Rui    2018-12-12  145        uint16_t format_id;
ae35cd6a480f9c drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_pptable.h Huang Rui    2018-12-12  146        uint32_t platform_caps;                       //POWERPLAYABLE::ulPlatformCaps
ae35cd6a480f9c drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_pptable.h Huang Rui    2018-12-12  147                                                      
ae35cd6a480f9c drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_pptable.h Huang Rui    2018-12-12  148        uint8_t  thermal_controller_type;             //one of SMU_11_0_PP_THERMALCONTROLLER
ae35cd6a480f9c drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_pptable.h Huang Rui    2018-12-12  149  
ae35cd6a480f9c drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_pptable.h Huang Rui    2018-12-12  150        uint16_t small_power_limit1;
ae35cd6a480f9c drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_pptable.h Huang Rui    2018-12-12  151        uint16_t small_power_limit2;
ae35cd6a480f9c drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_pptable.h Huang Rui    2018-12-12  152        uint16_t boost_power_limit;
ae35cd6a480f9c drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_pptable.h Huang Rui    2018-12-12  153        uint16_t od_turbo_power_limit;                //Power limit setting for Turbo mode in Performance UI Tuning. 
ae35cd6a480f9c drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_pptable.h Huang Rui    2018-12-12  154        uint16_t od_power_save_power_limit;           //Power limit setting for PowerSave/Optimal mode in Performance UI Tuning. 
ae35cd6a480f9c drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_pptable.h Huang Rui    2018-12-12  155        uint16_t software_shutdown_temp;
ae35cd6a480f9c drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_pptable.h Huang Rui    2018-12-12  156  
ae35cd6a480f9c drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_pptable.h Huang Rui    2018-12-12  157        uint16_t reserve[6];                          //Zero filled field reserved for future use
ae35cd6a480f9c drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_pptable.h Huang Rui    2018-12-12  158  
ae35cd6a480f9c drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_pptable.h Huang Rui    2018-12-12  159        struct smu_11_0_power_saving_clock_table      power_saving_clock;
ae35cd6a480f9c drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_pptable.h Huang Rui    2018-12-12  160        struct smu_11_0_overdrive_table               overdrive_table;
ae35cd6a480f9c drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_pptable.h Huang Rui    2018-12-12  161  
73abde4d864b38 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_pptable.h Matt Coffin  2019-11-11  162  #ifndef SMU_11_0_PARTIAL_PPTABLE
ae35cd6a480f9c drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_pptable.h Huang Rui    2018-12-12 @163        PPTable_t smc_pptable;                        //PPTable_t in smu11_driver_if.h
73abde4d864b38 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_pptable.h Matt Coffin  2019-11-11  164  #endif
2dd1209e576068 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_pptable.h Huang Rui    2019-02-12  165  } __attribute__((packed));
ae35cd6a480f9c drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_pptable.h Huang Rui    2018-12-12  166  

:::::: The code at line 163 was first introduced by commit
:::::: ae35cd6a480f9c2ac356f792c9a9321a5863776a drm/amd/powerplay: add pptable header for smu11

:::::: TO: Huang Rui <ray.huang@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
