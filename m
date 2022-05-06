Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4E551CFD2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 05:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388826AbiEFDuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 23:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384740AbiEFDuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 23:50:44 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D2044A04
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 20:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651808822; x=1683344822;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=euyo/px1cfdSUEMs0Pi/s6A8waAHPkEmTHwCJYMq36w=;
  b=M3DjZo3fNBBoo30WKBfLA5NasH0+6o5EASVdCS2h+EsY/XNAH8chrcUv
   81rmvGnirhyrBo2AZlu8/V2Gjor60SjDkUwD/dDn4bHcudHqmWcpZskoJ
   IllQ+YuH5Ihx6QMaxNgQ5QUTzWSHK7FvlVBwBnCT+EeX7UhzEVwnCOBnk
   wjq6kf5Vp5CD+rudOqMKBtYrNN6epXpmnRubA/PPC2Sx5NLow/8//EaBU
   YCeF9MvwMZisVgBTEmQ6mCokz3fVokHpSFPaGX7ZRUjZ5CCw5Z+KfC83M
   qQfhz4d72qWXzfJrT9gvmHYTCmtKWn1Bhf5r7MUaeaCwcaEq4/iiSerSf
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="265928017"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="265928017"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 20:47:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="600364065"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 05 May 2022 20:47:00 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmovj-000D3u-Ll;
        Fri, 06 May 2022 03:46:59 +0000
Date:   Fri, 6 May 2022 11:46:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Likun Gao <Likun.Gao@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [agd5f:drm-next 282/573]
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:5759:9: sparse: sparse:
 incompatible types in conditional expression (different base types):
Message-ID: <202205061127.T79RCanI-lkp@intel.com>
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
commit: 563fcfbf3101b569d642ac4d71c8177f0d7dc0ce [282/573] drm/amdgpu: add hdp version 6 functions
config: mips-randconfig-s031-20220506 (https://download.01.org/0day-ci/archive/20220506/202205061127.T79RCanI-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout 563fcfbf3101b569d642ac4d71c8177f0d7dc0ce
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=mips SHELL=/bin/bash drivers/gpu/drm/amd/amdgpu/ drivers/gpu/drm/amd/pm/powerplay/smumgr/ drivers/gpu/drm/amd/pm/swsmu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:314:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
>> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:5759:9: sparse: sparse: incompatible types in conditional expression (different base types):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:5759:9: sparse:    void
>> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:5759:9: sparse:    int
--
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu_cmn.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:314:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
>> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu_cmn.c:912:17: sparse: sparse: incompatible types in conditional expression (different base types):
>> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu_cmn.c:912:17: sparse:    void
>> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu_cmn.c:912:17: sparse:    int
--
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/vega10_smumgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:314:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
>> drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/vega10_smumgr.c:63:9: sparse: sparse: incompatible types in conditional expression (different base types):
>> drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/vega10_smumgr.c:63:9: sparse:    void
>> drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/vega10_smumgr.c:63:9: sparse:    int
--
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/smu10_smumgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:314:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
>> drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/smu10_smumgr.c:142:9: sparse: sparse: incompatible types in conditional expression (different base types):
>> drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/smu10_smumgr.c:142:9: sparse:    void
>> drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/smu10_smumgr.c:142:9: sparse:    int
--
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/vega12_smumgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:314:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
>> drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/vega12_smumgr.c:71:9: sparse: sparse: incompatible types in conditional expression (different base types):
>> drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/vega12_smumgr.c:71:9: sparse:    void
>> drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/vega12_smumgr.c:71:9: sparse:    int
--
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/vega20_smumgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:314:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
>> drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/vega20_smumgr.c:195:9: sparse: sparse: incompatible types in conditional expression (different base types):
>> drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/vega20_smumgr.c:195:9: sparse:    void
>> drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/vega20_smumgr.c:195:9: sparse:    int
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/vega20_smumgr.c:309:9: sparse: sparse: incompatible types in conditional expression (different base types):
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/vega20_smumgr.c:309:9: sparse:    void
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/vega20_smumgr.c:309:9: sparse:    int

vim +5759 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c

c1dd4aa624076c Andrey Grodzovsky 2020-08-24  5748  
810085ddb7b76c Eric Huang        2021-06-02  5749  void amdgpu_device_invalidate_hdp(struct amdgpu_device *adev,
810085ddb7b76c Eric Huang        2021-06-02  5750  		struct amdgpu_ring *ring)
810085ddb7b76c Eric Huang        2021-06-02  5751  {
810085ddb7b76c Eric Huang        2021-06-02  5752  #ifdef CONFIG_X86_64
b818a5d374542c Alex Deucher      2022-03-09  5753  	if ((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev))
810085ddb7b76c Eric Huang        2021-06-02  5754  		return;
810085ddb7b76c Eric Huang        2021-06-02  5755  #endif
810085ddb7b76c Eric Huang        2021-06-02  5756  	if (adev->gmc.xgmi.connected_to_cpu)
810085ddb7b76c Eric Huang        2021-06-02  5757  		return;
c1dd4aa624076c Andrey Grodzovsky 2020-08-24  5758  
810085ddb7b76c Eric Huang        2021-06-02 @5759  	amdgpu_asic_invalidate_hdp(adev, ring);
810085ddb7b76c Eric Huang        2021-06-02  5760  }
34f3a4a98bd388 Lang Yu           2021-12-09  5761  

:::::: The code at line 5759 was first introduced by commit
:::::: 810085ddb7b76c1cc5059a1feb3b1250eceacf23 drm/amdgpu: Don't flush/invalidate HDP for APUs and A+A

:::::: TO: Eric Huang <jinhuieric.huang@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
