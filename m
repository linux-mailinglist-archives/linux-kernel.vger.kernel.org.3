Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8331851E378
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 04:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445336AbiEGCLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 22:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445334AbiEGCLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 22:11:17 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A063B712F1
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 19:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651889249; x=1683425249;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UWI+ru9RPI/I/S7oKbgUNFDCe5FeBh3kBgTsXYZBtOM=;
  b=Pexpx5nghAAisQDN0lHinJIy6MRgIf0UKqB/XR0wF2dEppJEzy4nT2bY
   py1ZG74+ueI5PNf36VG4owTBiwOErmrnopmZVAaUWiiD3MLrncklhcWNz
   lp2zesEKOPorloWQ8Kj6n8BgW0TVIVcCFx0/qbPvGOPRozscnCVsJFvOM
   xAV0cHXLVSOhnlr1p84hg21SgIGDqeHZflnav36qc/i/Xkwm992NxcVvm
   xIjHUWo1R+aa+Mui4mIFZjSjnq/zbiCjL0d/SLpExJt2SETnqDUcBWYYt
   gSXQ/0grrlBQ8y/lrkGUqdQjlM8jmLHR2zm7BVVFa0rkWXeGkFAtzLv79
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="268525354"
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="268525354"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 19:07:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="654955904"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 06 May 2022 19:07:25 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nn9qu-000E6y-FH;
        Sat, 07 May 2022 02:07:24 +0000
Date:   Sat, 7 May 2022 10:07:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Zhu <James.Zhu@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>
Subject: [agd5f:drm-next 578/599]
 drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c:26:6: warning: no previous
 prototype for 'vcn_dec_sw_ring_emit_fence'
Message-ID: <202205070951.rG9TBWtB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   3170f5f234272247989fafee4cba4cbbc822631c
commit: 60a2e9eecf1676e3d59f050e5c9688830d7425cc [578/599] drm/amdgpu/vcn: add common vcn sofware ring decode
config: arc-randconfig-r035-20220506 (https://download.01.org/0day-ci/archive/20220507/202205070951.rG9TBWtB-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout 60a2e9eecf1676e3d59f050e5c9688830d7425cc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/gpu/drm/amd/amdgpu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c:26:6: warning: no previous prototype for 'vcn_dec_sw_ring_emit_fence' [-Wmissing-prototypes]
      26 | void vcn_dec_sw_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c:38:6: warning: no previous prototype for 'vcn_dec_sw_ring_insert_end' [-Wmissing-prototypes]
      38 | void vcn_dec_sw_ring_insert_end(struct amdgpu_ring *ring)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c:43:6: warning: no previous prototype for 'vcn_dec_sw_ring_emit_ib' [-Wmissing-prototypes]
      43 | void vcn_dec_sw_ring_emit_ib(struct amdgpu_ring *ring, struct amdgpu_job *job,
         |      ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c:55:6: warning: no previous prototype for 'vcn_dec_sw_ring_emit_reg_wait' [-Wmissing-prototypes]
      55 | void vcn_dec_sw_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c:64:6: warning: no previous prototype for 'vcn_dec_sw_ring_emit_vm_flush' [-Wmissing-prototypes]
      64 | void vcn_dec_sw_ring_emit_vm_flush(struct amdgpu_ring *ring,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c:79:6: warning: no previous prototype for 'vcn_dec_sw_ring_emit_wreg' [-Wmissing-prototypes]
      79 | void vcn_dec_sw_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/vcn_dec_sw_ring_emit_fence +26 drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c

    25	
  > 26	void vcn_dec_sw_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
    27		u64 seq, uint32_t flags)
    28	{
    29		WARN_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
    30	
    31		amdgpu_ring_write(ring, VCN_DEC_SW_CMD_FENCE);
    32		amdgpu_ring_write(ring, addr);
    33		amdgpu_ring_write(ring, upper_32_bits(addr));
    34		amdgpu_ring_write(ring, seq);
    35		amdgpu_ring_write(ring, VCN_DEC_SW_CMD_TRAP);
    36	}
    37	
  > 38	void vcn_dec_sw_ring_insert_end(struct amdgpu_ring *ring)
    39	{
    40		amdgpu_ring_write(ring, VCN_DEC_SW_CMD_END);
    41	}
    42	
  > 43	void vcn_dec_sw_ring_emit_ib(struct amdgpu_ring *ring, struct amdgpu_job *job,
    44		struct amdgpu_ib *ib, uint32_t flags)
    45	{
    46		uint32_t vmid = AMDGPU_JOB_GET_VMID(job);
    47	
    48		amdgpu_ring_write(ring, VCN_DEC_SW_CMD_IB);
    49		amdgpu_ring_write(ring, vmid);
    50		amdgpu_ring_write(ring, lower_32_bits(ib->gpu_addr));
    51		amdgpu_ring_write(ring, upper_32_bits(ib->gpu_addr));
    52		amdgpu_ring_write(ring, ib->length_dw);
    53	}
    54	
  > 55	void vcn_dec_sw_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
    56		uint32_t val, uint32_t mask)
    57	{
    58		amdgpu_ring_write(ring, VCN_DEC_SW_CMD_REG_WAIT);
    59		amdgpu_ring_write(ring, reg << 2);
    60		amdgpu_ring_write(ring, mask);
    61		amdgpu_ring_write(ring, val);
    62	}
    63	
  > 64	void vcn_dec_sw_ring_emit_vm_flush(struct amdgpu_ring *ring,
    65		uint32_t vmid, uint64_t pd_addr)
    66	{
    67		struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->funcs->vmhub];
    68		uint32_t data0, data1, mask;
    69	
    70		pd_addr = amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
    71	
    72		/* wait for register write */
    73		data0 = hub->ctx0_ptb_addr_lo32 + vmid * hub->ctx_addr_distance;
    74		data1 = lower_32_bits(pd_addr);
    75		mask = 0xffffffff;
    76		vcn_dec_sw_ring_emit_reg_wait(ring, data0, data1, mask);
    77	}
    78	
  > 79	void vcn_dec_sw_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
