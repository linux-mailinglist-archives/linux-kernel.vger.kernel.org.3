Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD7A536B75
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 09:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiE1Hm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 03:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiE1Hmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 03:42:52 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D55B7EE
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 00:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653723770; x=1685259770;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zdBsI9qu/DZM5MSkqcsyLB6OJ9auA7XgqkrZTE+QHIg=;
  b=LA3lJyZgcbLFsTf7jsYY3BDw5ahZSucAWGLvR5ncas1rYvZ0iCKL+h8W
   VVfx2w6L1KphUDPtrhv7C/2tl6TU7npYU9bpP7DAYA6McsdfSdAtLZEZx
   Nban2CZ3hPCGiGv/1pTydPGBdSgFGjaozQxylfh4VkehqjH7XjfUiirQo
   Y9QmFqwHbh78VYKjfxf14tiaCFxtGsUo+D7N6/lIKkWTU8JWd8dWs1ogQ
   q5ATT8kFW4NLBJdrMMVTBvubeDv7Qabij4ssczq18s0oQbhwElMHClfSE
   z0P9jOsvEs2p8C4aZyEMD3e/BaUtHowVsjzwt3J6nI1o0zvSSPCx1AhiM
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10360"; a="256716386"
X-IronPort-AV: E=Sophos;i="5.91,258,1647327600"; 
   d="scan'208";a="256716386"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2022 00:42:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,258,1647327600"; 
   d="scan'208";a="822075607"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 28 May 2022 00:42:47 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nur5y-0005Zu-NY;
        Sat, 28 May 2022 07:42:46 +0000
Date:   Sat, 28 May 2022 15:42:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kenneth Feng <kenneth.feng@amd.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Yang Wang <kevinyang.wang@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:1326:12:
 warning: stack frame size (1040) exceeds limit (1024) in
 'smu_v13_0_7_get_power_profile_mode'
Message-ID: <202205281546.8st5p4J7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kenneth,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9d004b2f4fea97cde123e7f1939b80e77bf2e695
commit: 334682ae81513638aa49da9615c2c0054a711ed4 drm/amd/pm: enable workload type change on smu_v13_0_7
date:   3 weeks ago
config: riscv-randconfig-r026-20220527 (https://download.01.org/0day-ci/archive/20220528/202205281546.8st5p4J7-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 134d7f9a4b97e9035150d970bd9e376043c4577e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=334682ae81513638aa49da9615c2c0054a711ed4
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 334682ae81513638aa49da9615c2c0054a711ed4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:294:5: warning: no previous prototype for function 'smu_v13_0_7_check_fw_status' [-Wmissing-prototypes]
   int smu_v13_0_7_check_fw_status(struct smu_context *smu) {
       ^
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:294:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int smu_v13_0_7_check_fw_status(struct smu_context *smu) {
   ^
   static 
>> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:1326:12: warning: stack frame size (1040) exceeds limit (1024) in 'smu_v13_0_7_get_power_profile_mode' [-Wframe-larger-than]
   static int smu_v13_0_7_get_power_profile_mode(struct smu_context *smu, char *buf)
              ^
   2 warnings generated.


vim +/smu_v13_0_7_get_power_profile_mode +1326 drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c

  1325	
> 1326	static int smu_v13_0_7_get_power_profile_mode(struct smu_context *smu, char *buf)
  1327	{
  1328		DpmActivityMonitorCoeffIntExternal_t activity_monitor_external[PP_SMC_POWER_PROFILE_COUNT];
  1329		uint32_t i, j, size = 0;
  1330		int16_t workload_type = 0;
  1331		int result = 0;
  1332	
  1333		if (!buf)
  1334			return -EINVAL;
  1335	
  1336		size += sysfs_emit_at(buf, size, "                              ");
  1337		for (i = 0; i <= PP_SMC_POWER_PROFILE_WINDOW3D; i++)
  1338			size += sysfs_emit_at(buf, size, "%-14s%s", amdgpu_pp_profile_name[i],
  1339				(i == smu->power_profile_mode) ? "* " : "  ");
  1340	
  1341		size += sysfs_emit_at(buf, size, "\n");
  1342	
  1343		for (i = 0; i <= PP_SMC_POWER_PROFILE_WINDOW3D; i++) {
  1344			/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
  1345			workload_type = smu_cmn_to_asic_specific_index(smu,
  1346								       CMN2ASIC_MAPPING_WORKLOAD,
  1347								       i);
  1348			if (workload_type < 0)
  1349				return -EINVAL;
  1350	
  1351			result = smu_cmn_update_table(smu,
  1352						  SMU_TABLE_ACTIVITY_MONITOR_COEFF, workload_type,
  1353						  (void *)(&activity_monitor_external[i]), false);
  1354			if (result) {
  1355				dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
  1356				return result;
  1357			}
  1358		}
  1359	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
