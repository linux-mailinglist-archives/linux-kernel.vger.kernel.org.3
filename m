Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D295451D194
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 08:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382331AbiEFGtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 02:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386293AbiEFGtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 02:49:16 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C8213CD0
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 23:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651819533; x=1683355533;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fi8z3mSzHPLzas4HaqdOJ94WwBNJNYKXF7/1Em0DvKA=;
  b=TZnlYrlu4ReqLWWtr3sahTLr5NbdY9tF6cJbiuWJKtpigwdXN8r0kKC4
   EkHaI9RKHm3bG9Ga45OkNcJ296HDbLgtlNiPyZEFebmQWVYQBOLi6j6Ns
   qBlnnv8tefTlIsCoL4bGGFyE6BSXSrwjb2AiFTTRlOltIuxPSIB1I3UTw
   Y/nbElrkB7JTKHgnuJ8F2bJemxLr+PIdfUB/LwOT/QSxABFj09M5bGngc
   gr2R9o7Eup5tDTkzvYK8uc8nLc+Y8BqaZng+KGYVwD7rG4TaCS9Jel1ME
   DIfmNstgs61wgehtGsoNmvb46JwfkxUaQ0Z0rrvD3mkBq5HbpUVNZpWko
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="255853046"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="255853046"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 23:45:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="549726550"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 05 May 2022 23:45:31 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmriU-000DED-CR;
        Fri, 06 May 2022 06:45:30 +0000
Date:   Fri, 6 May 2022 14:45:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chengming Gui <Jack.Gui@amd.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>
Subject: [agd5f:drm-next 523/573]
 drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:206:5:
 warning: no previous prototype for function 'smu_v13_0_7_check_fw_status'
Message-ID: <202205061407.MF1Stxst-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   e7b25ac8f27f561894f8f65caec0dfafed3ddbb5
commit: 113cc31dde66e3153f7290141b6c008dce8ab2bf [523/573] drm/amd/pm: add SMU_13_0_7 ppt_funcs for SMU_13_0_7
config: arm64-randconfig-r006-20220505 (https://download.01.org/0day-ci/archive/20220506/202205061407.MF1Stxst-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5e004fb787698440a387750db7f8028e7cb14cfc)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout 113cc31dde66e3153f7290141b6c008dce8ab2bf
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:206:5: warning: no previous prototype for function 'smu_v13_0_7_check_fw_status' [-Wmissing-prototypes]
   int smu_v13_0_7_check_fw_status(struct smu_context *smu) {
       ^
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:206:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int smu_v13_0_7_check_fw_status(struct smu_context *smu) {
   ^
   static 
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:281:24: warning: unused variable 'adev' [-Wunused-variable]
           struct amdgpu_device *adev = smu->adev;
                                 ^
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:359:24: warning: unused variable 'adev' [-Wunused-variable]
           struct amdgpu_device *adev = smu->adev;
                                 ^
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:464:24: warning: unused variable 'adev' [-Wunused-variable]
           struct amdgpu_device *adev = smu->adev;
                                 ^
   4 warnings generated.


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
