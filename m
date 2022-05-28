Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E177536A84
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 06:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235911AbiE1EJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 00:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiE1EJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 00:09:41 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1EA36162
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 21:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653710979; x=1685246979;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TxeQkm6iEMkkFBpNdqtHgTLWT0y+u3R+ECLEV7lRL5w=;
  b=e7nmZ2h1H0UbxAeJ1F1xZzycBNnmUdFfIkeWWXR6QqDzu28gcmTFJv2P
   gyzYf++K1uAI1RafyvZ/oHqTNs+7m9CYsCtpqqI1JcoxC9RjQ0pQ2y4rW
   pSWPevEO8n/xrmY++hS6E3+bQoX+7HDkVqhHZ8tjaoG4yWAK58KPZmpLD
   Y6eoTGLdSVWC41VmabA31/gSTgrmujKDMPAgbZe+Cl73KC269lH0NICBM
   Rl7VyCzfXzCCo7OC//MzA8TxPuCztsgH+QnjQ3Lg/WF6/6Gcg8D5r/IGC
   MpewOacpz9X3aI1mf9xlMlobovi5MGdOWeJGG9tlAtfszirQLGht75gox
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10360"; a="274723786"
X-IronPort-AV: E=Sophos;i="5.91,257,1647327600"; 
   d="scan'208";a="274723786"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 21:09:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,257,1647327600"; 
   d="scan'208";a="705425052"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 27 May 2022 21:09:36 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nunlg-0005Qv-8F;
        Sat, 28 May 2022 04:09:36 +0000
Date:   Sat, 28 May 2022 12:08:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Likun Gao <Likun.Gao@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:5759:9: sparse: sparse:
 incompatible types in conditional expression (different base types):
Message-ID: <202205281254.SCtgsHbG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bf272460d744112bacd4c4d562592decbf0edf64
commit: 563fcfbf3101b569d642ac4d71c8177f0d7dc0ce drm/amdgpu: add hdp version 6 functions
date:   3 weeks ago
config: csky-randconfig-s032-20220524 (https://download.01.org/0day-ci/archive/20220528/202205281254.SCtgsHbG-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-14-g5a0004b5-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=563fcfbf3101b569d642ac4d71c8177f0d7dc0ce
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 563fcfbf3101b569d642ac4d71c8177f0d7dc0ce
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=csky SHELL=/bin/bash drivers/gpu/drm/amd/amdgpu/ drivers/gpu/drm/amd/pm/powerplay/smumgr/ drivers/gpu/drm/amd/pm/swsmu/ drivers/vfio/pci/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:314:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
>> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:5759:9: sparse: sparse: incompatible types in conditional expression (different base types):
>> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:5759:9: sparse:    void
>> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:5759:9: sparse:    int
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/smu10_smumgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:314:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
>> drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/smu10_smumgr.c:142:9: sparse: sparse: incompatible types in conditional expression (different base types):
>> drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/smu10_smumgr.c:142:9: sparse:    void
>> drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/smu10_smumgr.c:142:9: sparse:    int
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/vega20_smumgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:314:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
>> drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/vega20_smumgr.c:195:9: sparse: sparse: incompatible types in conditional expression (different base types):
>> drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/vega20_smumgr.c:195:9: sparse:    void
>> drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/vega20_smumgr.c:195:9: sparse:    int
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/vega20_smumgr.c:309:9: sparse: sparse: incompatible types in conditional expression (different base types):
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/vega20_smumgr.c:309:9: sparse:    void
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/vega20_smumgr.c:309:9: sparse:    int
--
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu_cmn.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:314:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
>> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu_cmn.c:912:17: sparse: sparse: incompatible types in conditional expression (different base types):
>> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu_cmn.c:912:17: sparse:    void
>> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu_cmn.c:912:17: sparse:    int
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/vega12_smumgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:314:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
>> drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/vega12_smumgr.c:71:9: sparse: sparse: incompatible types in conditional expression (different base types):
>> drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/vega12_smumgr.c:71:9: sparse:    void
>> drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/vega12_smumgr.c:71:9: sparse:    int
--
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/vega10_smumgr.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h, ...):
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgv_sriovmsg.h:314:49: sparse: sparse: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
>> drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/vega10_smumgr.c:63:9: sparse: sparse: incompatible types in conditional expression (different base types):
>> drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/vega10_smumgr.c:63:9: sparse:    void
>> drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/vega10_smumgr.c:63:9: sparse:    int

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
