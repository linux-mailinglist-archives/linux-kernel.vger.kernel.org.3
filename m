Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E530B537107
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 15:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiE2NCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 09:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiE2NCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 09:02:45 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF92F47071
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 06:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653829363; x=1685365363;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tlxgE6hyNSvGnjBkyDs0fJIfcbbIMY2hwMSUj2jCnV8=;
  b=bIalJ4gd6P4tXxrXgwNB1KEk4PqBLhZNhUeyMp26wOnOPodvChpokhBc
   KSFtxW5tO0odc8S8LgLFdowwiGmpgDNbyXzXFk+I2U+Zaa9umx7yXgUYb
   CAva/WuGguONyTWWEcqObyAP8/h77tntdB7+t5sdryr/0knsZwsRY7AEg
   iWLfYFj6sis2E8fPovnOKfGfdQylglor87a6tTo0KTTQ5vmk9kHrdjY1j
   CKCnzzuzITHJ3pOnrz+MCNoC431Mf6J1DaepHOhvGutngmtj/HraQseL3
   KJYwvhQeKB4oFdpec/LcYW6b5ceuZgjF67qcFrQun4gEKtzOAHVB3Etk8
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10361"; a="273607784"
X-IronPort-AV: E=Sophos;i="5.91,260,1647327600"; 
   d="scan'208";a="273607784"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2022 06:02:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,260,1647327600"; 
   d="scan'208";a="678767226"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 29 May 2022 06:02:41 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nvIZ7-00011w-33;
        Sun, 29 May 2022 13:02:41 +0000
Date:   Sun, 29 May 2022 21:02:18 +0800
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
Message-ID: <202205292007.2uMB4GkA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evan,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   664a393a2663a0f62fc1b18157ccae33dcdbb8c8
commit: 837d542a09cd533055423dfca7e621a9c1d13c5b drm/amd/pm: relocate the power related headers
date:   5 months ago
config: arm-randconfig-c002-20220528 (https://download.01.org/0day-ci/archive/20220529/202205292007.2uMB4GkA-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0fbe3f3f486e01448121f7931a4ca29fac1504ab)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=837d542a09cd533055423dfca7e621a9c1d13c5b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 837d542a09cd533055423dfca7e621a9c1d13c5b
        # save the config file
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross 

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/inc/smu_v11_0_pptable.h:163:17: warning: field smc_pptable within 'struct smu_11_0_powerplay_table' is less aligned than 'PPTable_t' and is usually due to 'struct smu_11_0_powerplay_table' being packed, which can lead to unaligned accesses [-Wunaligned-access]
         PPTable_t smc_pptable;                        //PPTable_t in smu11_driver_if.h
                   ^
   1 warning generated.
--
>> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/inc/smu_v11_0_7_pptable.h:193:17: warning: field smc_pptable within 'struct smu_11_0_7_powerplay_table' is less aligned than 'PPTable_t' and is usually due to 'struct smu_11_0_7_powerplay_table' being packed, which can lead to unaligned accesses [-Wunaligned-access]
         PPTable_t smc_pptable;                        //PPTable_t in smu11_driver_if.h
                   ^
   1 warning generated.
--
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
