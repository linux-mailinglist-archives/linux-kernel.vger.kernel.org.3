Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F9551CE23
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 04:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388196AbiEFB7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 21:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388181AbiEFB7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 21:59:00 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E17DC6
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 18:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651802117; x=1683338117;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wm+woUDcj7v1dnHXmiNkS5C/6hd90Y8jrCZqGBJ+tlQ=;
  b=fqO0GNh6B3a8VZgoLRNNhujlXA72Ts9dAMMakMTIaqgDcJa2w9M3IYVd
   VnOo4d2Xc+JoAfSg/+nPbeWszfgjp4CQMSJRtFoKErza724HMKB+NFZ+h
   CSdcZLTld6Mo7gM90p5G/1PTaCKb42+c21qOppK2cVlKIfh4l2uHJwOFv
   ZMwL5UYjjRMTLI7NK9UHANYuLr4gGbwJDTpgpThMfZEL7pp3zuYBSHV8d
   evzKISD16AB26Wz3VmR2HgK2ALQNatX8nPOKvZcwtpqlKyOqEyn6iCJoW
   Yow1XKIzPN/9FFI26pfGXpE28oNwVIIeCUfZWFzLN3B6mDQWMsre/cVEV
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="265908872"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="265908872"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 18:55:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="709227380"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 05 May 2022 18:55:15 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmnBb-000CxU-5O;
        Fri, 06 May 2022 01:55:15 +0000
Date:   Fri, 6 May 2022 09:54:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chengming Gui <Jack.Gui@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>
Subject: [agd5f:drm-next 523/573]
 drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:206:5:
 warning: no previous prototype for 'smu_v13_0_7_check_fw_status'
Message-ID: <202205060948.mXtoebUU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   e7b25ac8f27f561894f8f65caec0dfafed3ddbb5
commit: 113cc31dde66e3153f7290141b6c008dce8ab2bf [523/573] drm/amd/pm: add SMU_13_0_7 ppt_funcs for SMU_13_0_7
config: alpha-randconfig-r034-20220505 (https://download.01.org/0day-ci/archive/20220506/202205060948.mXtoebUU-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout 113cc31dde66e3153f7290141b6c008dce8ab2bf
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:206:5: warning: no previous prototype for 'smu_v13_0_7_check_fw_status' [-Wmissing-prototypes]
     206 | int smu_v13_0_7_check_fw_status(struct smu_context *smu) {
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c: In function 'smu_v13_0_7_tables_init':
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:281:31: warning: unused variable 'adev' [-Wunused-variable]
     281 |         struct amdgpu_device *adev = smu->adev;
         |                               ^~~~
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c: In function 'smu_v13_0_7_set_default_dpm_table':
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:359:31: warning: unused variable 'adev' [-Wunused-variable]
     359 |         struct amdgpu_device *adev = smu->adev;
         |                               ^~~~
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c: In function 'smu_v13_0_7_set_ppt_funcs':
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:464:31: warning: unused variable 'adev' [-Wunused-variable]
     464 |         struct amdgpu_device *adev = smu->adev;
         |                               ^~~~


vim +/smu_v13_0_7_check_fw_status +206 drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c

   205	
 > 206	int smu_v13_0_7_check_fw_status(struct smu_context *smu) {
   207		struct amdgpu_device *adev = smu->adev;
   208		uint32_t mp1_fw_flags;
   209	
   210		mp1_fw_flags = RREG32_PCIE(MP1_Public |
   211					   (smnMP1_FIRMWARE_FLAGS_SMU_13_0_7 & 0xffffffff));
   212	
   213		if ((mp1_fw_flags & MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED_MASK) >>
   214				MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED__SHIFT)
   215			return 0;
   216	
   217		return -EIO;
   218	}
   219	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
