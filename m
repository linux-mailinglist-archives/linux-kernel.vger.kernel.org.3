Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3154E6A68
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 22:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344867AbiCXVxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 17:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiCXVxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 17:53:00 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB892B7C56
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 14:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648158687; x=1679694687;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cz6HBthwW0nY24DRIJjypp9xMPbxdoGHo2l1mnA2Wxg=;
  b=GCEmtGwiSFjTtLq5ca4HA8TGvCrju98ma4l0AGKQLpaJo7eM3sF2B47a
   BKsSWhpLecdDeO0Po6DxMghCQwI4CRGcehwrHVoln15q4a8T0b3stg+Sz
   bhyoKhKUhMDhZqLtVgq6M2YrxrtalUmhi95RrkutpZGtKw7X9XzLIp3EN
   GSHveKe++uQBWw+zizUw+8UrczWEDMq4/sxDvKINVl2q1e0FznLFNDlFm
   AbjYUurRFcZGrJIh6zKRt8UtixvcAob7GSxtRhGjQNl+lkNBsJ0BWf3Sx
   BroVgni3y2TwnIOzxKnkyT8z9hXKTsJvdEfLilKwtWKy4uzzYp84Fitfd
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="238439498"
X-IronPort-AV: E=Sophos;i="5.90,208,1643702400"; 
   d="scan'208";a="238439498"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 14:51:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,208,1643702400"; 
   d="scan'208";a="650017140"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 24 Mar 2022 14:51:01 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nXVMD-000LTf-3j; Thu, 24 Mar 2022 21:51:01 +0000
Date:   Fri, 25 Mar 2022 05:49:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jimmy Kizito <Jimmy.Kizito@amd.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Jun Lei <Jun.Lei@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_enc_cfg.c:416:6:
 warning: variable 'matching_stream_ptrs' set but not used
Message-ID: <202203250504.X4x0hoOe-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ed4643521e6af8ab8ed1e467630a85884d2696cf
commit: b3492ed160768ad60ad6753269099213b6772a70 drm/amd/display: Fix concurrent dynamic encoder assignment
date:   6 months ago
config: arm64-randconfig-r013-20220324 (https://download.01.org/0day-ci/archive/20220325/202203250504.X4x0hoOe-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b3492ed160768ad60ad6753269099213b6772a70
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout b3492ed160768ad60ad6753269099213b6772a70
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_enc_cfg.c:416:6: warning: variable 'matching_stream_ptrs' set but not used [-Wunused-but-set-variable]
           int matching_stream_ptrs = 0;
               ^
   1 warning generated.


vim +/matching_stream_ptrs +416 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_enc_cfg.c

   404	
   405	bool link_enc_cfg_validate(struct dc *dc, struct dc_state *state)
   406	{
   407		bool is_valid = false;
   408		bool valid_entries = true;
   409		bool valid_stream_ptrs = true;
   410		bool valid_uniqueness = true;
   411		bool valid_avail = true;
   412		bool valid_streams = true;
   413		int i, j;
   414		uint8_t valid_count = 0;
   415		uint8_t dig_stream_count = 0;
 > 416		int matching_stream_ptrs = 0;

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
