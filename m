Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0F051E49C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 08:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383452AbiEGGiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 02:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiEGGiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 02:38:11 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD8254BCC
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 23:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651905265; x=1683441265;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kQsjAzmk0c19tGXWHeSg2vjHekHRGNteU2MHfKjiEyo=;
  b=c/YohZiSXKTP5aW0bvk0/naLwC0FflBLaWB1MNgyX8G41mVjt5i45GHl
   D8jBD55dfddhlZNR3jriwm+b9AlI37C594pyhgwaieeoaEDZBEkHmDAAc
   ezXLXc2XBSNiSSODPwW3Pogzj6nc0S1xQqxsV11xhAMzQHUYpDv12F5uU
   19V8rz4WJV8j5/8laL+a0SR1dxrZUQN764T/TO0I4S0FeSNMyPHCsXD0b
   VAXDKosOECZRPVVIBdIJntMohkCdSJBuv7C1XO5aLJiFSvS4GvidKy45t
   pcaUUtedqZUfcYOrcMQXFv8070n6eg7K1P+eG3Ui23RJpP07UuK7KsD7W
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="331657761"
X-IronPort-AV: E=Sophos;i="5.91,206,1647327600"; 
   d="scan'208";a="331657761"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 23:34:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,206,1647327600"; 
   d="scan'208";a="622156906"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 06 May 2022 23:34:22 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nnE1G-000EJW-5N;
        Sat, 07 May 2022 06:34:22 +0000
Date:   Sat, 7 May 2022 14:33:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Evan Quan <evan.quan@amd.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [agd5f:drm-next 321/599]
 drivers/gpu/drm/amd/amdgpu/../pm/inc/smu_v13_0_0_pptable.h:194:39: warning:
 field overdrive_table within 'struct smu_13_0_0_powerplay_table' is less
 aligned than 'struct smu_13_0_0_overdrive_table' and is usually due to
 'struct smu_13_0_0_powerplay_table'...
Message-ID: <202205071434.E4b56uaS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   3170f5f234272247989fafee4cba4cbbc822631c
commit: 276c03a0547068026241decd2c1159df0be5941f [321/599] drm/amd/smu: Update SMU13 support for SMU 13.0.0
config: arm-randconfig-r034-20220506 (https://download.01.org/0day-ci/archive/20220507/202205071434.E4b56uaS-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5e004fb787698440a387750db7f8028e7cb14cfc)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout 276c03a0547068026241decd2c1159df0be5941f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_0_ppt.c:39:
>> drivers/gpu/drm/amd/amdgpu/../pm/inc/smu_v13_0_0_pptable.h:194:39: warning: field overdrive_table within 'struct smu_13_0_0_powerplay_table' is less aligned than 'struct smu_13_0_0_overdrive_table' and is usually due to 'struct smu_13_0_0_powerplay_table' being packed, which can lead to unaligned accesses [-Wunaligned-access]
       struct smu_13_0_0_overdrive_table overdrive_table;
                                         ^
   1 warning generated.


vim +194 drivers/gpu/drm/amd/amdgpu/../pm/inc/smu_v13_0_0_pptable.h

ce81151c7d9df8 Likun Gao 2022-04-06  173  
ce81151c7d9df8 Likun Gao 2022-04-06  174  struct smu_13_0_0_powerplay_table
ce81151c7d9df8 Likun Gao 2022-04-06  175  {
ce81151c7d9df8 Likun Gao 2022-04-06  176      struct atom_common_table_header header; //For SMU13, header.format_revision = 15, header.content_revision = 0
ce81151c7d9df8 Likun Gao 2022-04-06  177      uint8_t table_revision;                 //For SMU13, table_revision = 2
ce81151c7d9df8 Likun Gao 2022-04-06  178      uint8_t padding;
ce81151c7d9df8 Likun Gao 2022-04-06  179      uint16_t table_size;                    //Driver portion table size. The offset to smc_pptable including header size
ce81151c7d9df8 Likun Gao 2022-04-06  180      uint32_t golden_pp_id;                  //PPGen use only: PP Table ID on the Golden Data Base
ce81151c7d9df8 Likun Gao 2022-04-06  181      uint32_t golden_revision;               //PPGen use only: PP Table Revision on the Golden Data Base
ce81151c7d9df8 Likun Gao 2022-04-06  182      uint16_t format_id;                     //PPGen use only: PPTable for different ASICs. For SMU13 this should be 0x80
ce81151c7d9df8 Likun Gao 2022-04-06  183      uint32_t platform_caps;                 //POWERPLAYABLE::ulPlatformCaps
ce81151c7d9df8 Likun Gao 2022-04-06  184  
ce81151c7d9df8 Likun Gao 2022-04-06  185      uint8_t thermal_controller_type; //one of SMU_13_0_0_PP_THERMALCONTROLLER
ce81151c7d9df8 Likun Gao 2022-04-06  186  
ce81151c7d9df8 Likun Gao 2022-04-06  187      uint16_t small_power_limit1;
ce81151c7d9df8 Likun Gao 2022-04-06  188      uint16_t small_power_limit2;
ce81151c7d9df8 Likun Gao 2022-04-06  189      uint16_t boost_power_limit; //For Gemini Board, when the slave adapter is in BACO mode, the master adapter will use this boost power limit instead of the default power limit to boost the power limit.
ce81151c7d9df8 Likun Gao 2022-04-06  190      uint16_t software_shutdown_temp;
ce81151c7d9df8 Likun Gao 2022-04-06  191  
ce81151c7d9df8 Likun Gao 2022-04-06  192      uint32_t reserve[45];
ce81151c7d9df8 Likun Gao 2022-04-06  193  
ce81151c7d9df8 Likun Gao 2022-04-06 @194      struct smu_13_0_0_overdrive_table overdrive_table;
ce81151c7d9df8 Likun Gao 2022-04-06  195      uint8_t padding1;
ce81151c7d9df8 Likun Gao 2022-04-06  196      PPTable_t smc_pptable; //PPTable_t in driver_if.h
ce81151c7d9df8 Likun Gao 2022-04-06  197  } __attribute__((packed));
ce81151c7d9df8 Likun Gao 2022-04-06  198  
ce81151c7d9df8 Likun Gao 2022-04-06  199  

:::::: The code at line 194 was first introduced by commit
:::::: ce81151c7d9df872119941e46f3f34c295b08503 drm/amd/smu: add smu v13_0 header files

:::::: TO: Likun Gao <Likun.Gao@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
