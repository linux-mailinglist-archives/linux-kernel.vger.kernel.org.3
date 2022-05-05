Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1A751B47A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 02:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiEEAOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 20:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiEEAOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 20:14:53 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299BC47AEE
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 17:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651709476; x=1683245476;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jKkf2XJ4kTKfNutikYTX3AQCR3EVXC57RoIMV5aQr2U=;
  b=fMBv1CuMuVl7zGCUd43N42mbKBLkX4EIrpdIjvYNTFIH0AdkP6F3rh8c
   Ngfy2Ec0w6TG5JLKYbZcSJd1gyQvPY3G39t3f/CZk3A8AwYYslgmnqubA
   J6PYKtyGx/B7G7wiC4oinep/Iwud4UfWuf15hudtKzYLSJSMq1wNSj/AB
   36PA6ajngzS1Mqnd7ZSyd18dQXSf8xkxo6XwyRa29W66df67VTffV3QYN
   HXss9fsn2MrMRlBmHOwsmAMI8NsRgEtKdoXpxwFPOaJR48/wA440xlR8b
   bDFHUSzYOpIz9JuMNlNh7hwnfWA7Q0KzFD9o/+mFhVXZhwegFV/og8ioA
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="266781137"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="266781137"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 17:11:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="694409553"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 04 May 2022 17:11:12 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmP5L-000Bv5-MR;
        Thu, 05 May 2022 00:11:11 +0000
Date:   Thu, 5 May 2022 08:11:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hawking Zhang <Hawking.Zhang@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Wenhui Sheng <Wenhui.Sheng@amd.com>
Subject: [agd5f:drm-next 429/460]
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:3399:34: error:
 'CP_RB0_CNTL__BUF_SWAP_MASK' undeclared; did you mean
 'CP_RB0_CNTL__TMZ_STATE_MASK'?
Message-ID: <202205050828.iPV8Kl9Z-lkp@intel.com>
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
head:   d6ffefccf7f04eefddc8e8aa35fb4afe05a42e0c
commit: 3d879e81f0f9ed5d33b5eda0fe5226c884bb8073 [429/460] drm/amdgpu: add init support for GFX11 (v2)
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220505/202205050828.iPV8Kl9Z-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout 3d879e81f0f9ed5d33b5eda0fe5226c884bb8073
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:1945:6: warning: no previous prototype for 'gfx_v11_0_rlc_stop' [-Wmissing-prototypes]
    1945 | void gfx_v11_0_rlc_stop(struct amdgpu_device *adev)
         |      ^~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:28:
   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c: In function 'gfx_v11_0_cp_gfx_resume':
>> drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:3399:34: error: 'CP_RB0_CNTL__BUF_SWAP_MASK' undeclared (first use in this function); did you mean 'CP_RB0_CNTL__TMZ_STATE_MASK'?
    3399 |         tmp = REG_SET_FIELD(tmp, CP_RB0_CNTL, BUF_SWAP, 1);
         |                                  ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/amdgpu.h:1177:36: note: in definition of macro 'REG_FIELD_MASK'
    1177 | #define REG_FIELD_MASK(reg, field) reg##__##field##_MASK
         |                                    ^~~
   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:3399:15: note: in expansion of macro 'REG_SET_FIELD'
    3399 |         tmp = REG_SET_FIELD(tmp, CP_RB0_CNTL, BUF_SWAP, 1);
         |               ^~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:3399:34: note: each undeclared identifier is reported only once for each function it appears in
    3399 |         tmp = REG_SET_FIELD(tmp, CP_RB0_CNTL, BUF_SWAP, 1);
         |                                  ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/amdgpu.h:1177:36: note: in definition of macro 'REG_FIELD_MASK'
    1177 | #define REG_FIELD_MASK(reg, field) reg##__##field##_MASK
         |                                    ^~~
   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:3399:15: note: in expansion of macro 'REG_SET_FIELD'
    3399 |         tmp = REG_SET_FIELD(tmp, CP_RB0_CNTL, BUF_SWAP, 1);
         |               ^~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:3399:34: error: 'CP_RB0_CNTL__BUF_SWAP__SHIFT' undeclared (first use in this function); did you mean 'CP_RB0_CNTL__TMZ_STATE__SHIFT'?
    3399 |         tmp = REG_SET_FIELD(tmp, CP_RB0_CNTL, BUF_SWAP, 1);
         |                                  ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/amdgpu.h:1176:37: note: in definition of macro 'REG_FIELD_SHIFT'
    1176 | #define REG_FIELD_SHIFT(reg, field) reg##__##field##__SHIFT
         |                                     ^~~
   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:3399:15: note: in expansion of macro 'REG_SET_FIELD'
    3399 |         tmp = REG_SET_FIELD(tmp, CP_RB0_CNTL, BUF_SWAP, 1);
         |               ^~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c: In function 'gfx_v11_0_compute_mqd_init':
>> drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:4049:34: error: 'CP_HQD_PQ_CONTROL__ENDIAN_SWAP_MASK' undeclared (first use in this function); did you mean 'CP_HQD_PQ_CONTROL__PRIV_STATE_MASK'?
    4049 |         tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, ENDIAN_SWAP, 1);
         |                                  ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/amdgpu.h:1177:36: note: in definition of macro 'REG_FIELD_MASK'
    1177 | #define REG_FIELD_MASK(reg, field) reg##__##field##_MASK
         |                                    ^~~
   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:4049:15: note: in expansion of macro 'REG_SET_FIELD'
    4049 |         tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, ENDIAN_SWAP, 1);
         |               ^~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:4049:34: error: 'CP_HQD_PQ_CONTROL__ENDIAN_SWAP__SHIFT' undeclared (first use in this function); did you mean 'CP_HQD_PQ_CONTROL__PRIV_STATE__SHIFT'?
    4049 |         tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, ENDIAN_SWAP, 1);
         |                                  ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/amdgpu.h:1176:37: note: in definition of macro 'REG_FIELD_SHIFT'
    1176 | #define REG_FIELD_SHIFT(reg, field) reg##__##field##__SHIFT
         |                                     ^~~
   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:4049:15: note: in expansion of macro 'REG_SET_FIELD'
    4049 |         tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, ENDIAN_SWAP, 1);
         |               ^~~~~~~~~~~~~


vim +3399 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c

  3374	
  3375	static int gfx_v11_0_cp_gfx_resume(struct amdgpu_device *adev)
  3376	{
  3377		struct amdgpu_ring *ring;
  3378		u32 tmp;
  3379		u32 rb_bufsz;
  3380		u64 rb_addr, rptr_addr, wptr_gpu_addr;
  3381		u32 i;
  3382	
  3383		/* Set the write pointer delay */
  3384		WREG32_SOC15(GC, 0, regCP_RB_WPTR_DELAY, 0);
  3385	
  3386		/* set the RB to use vmid 0 */
  3387		WREG32_SOC15(GC, 0, regCP_RB_VMID, 0);
  3388	
  3389		/* Init gfx ring 0 for pipe 0 */
  3390		mutex_lock(&adev->srbm_mutex);
  3391		gfx_v11_0_cp_gfx_switch_pipe(adev, PIPE_ID0);
  3392	
  3393		/* Set ring buffer size */
  3394		ring = &adev->gfx.gfx_ring[0];
  3395		rb_bufsz = order_base_2(ring->ring_size / 8);
  3396		tmp = REG_SET_FIELD(0, CP_RB0_CNTL, RB_BUFSZ, rb_bufsz);
  3397		tmp = REG_SET_FIELD(tmp, CP_RB0_CNTL, RB_BLKSZ, rb_bufsz - 2);
  3398	#ifdef __BIG_ENDIAN
> 3399		tmp = REG_SET_FIELD(tmp, CP_RB0_CNTL, BUF_SWAP, 1);
  3400	#endif
  3401		WREG32_SOC15(GC, 0, regCP_RB0_CNTL, tmp);
  3402	
  3403		/* Initialize the ring buffer's write pointers */
  3404		ring->wptr = 0;
  3405		WREG32_SOC15(GC, 0, regCP_RB0_WPTR, lower_32_bits(ring->wptr));
  3406		WREG32_SOC15(GC, 0, regCP_RB0_WPTR_HI, upper_32_bits(ring->wptr));
  3407	
  3408		/* set the wb address wether it's enabled or not */
  3409		rptr_addr = ring->rptr_gpu_addr;
  3410		WREG32_SOC15(GC, 0, regCP_RB0_RPTR_ADDR, lower_32_bits(rptr_addr));
  3411		WREG32_SOC15(GC, 0, regCP_RB0_RPTR_ADDR_HI, upper_32_bits(rptr_addr) &
  3412			     CP_RB_RPTR_ADDR_HI__RB_RPTR_ADDR_HI_MASK);
  3413	
  3414		wptr_gpu_addr = ring->wptr_gpu_addr;
  3415		WREG32_SOC15(GC, 0, regCP_RB_WPTR_POLL_ADDR_LO,
  3416			     lower_32_bits(wptr_gpu_addr));
  3417		WREG32_SOC15(GC, 0, regCP_RB_WPTR_POLL_ADDR_HI,
  3418			     upper_32_bits(wptr_gpu_addr));
  3419	
  3420		mdelay(1);
  3421		WREG32_SOC15(GC, 0, regCP_RB0_CNTL, tmp);
  3422	
  3423		rb_addr = ring->gpu_addr >> 8;
  3424		WREG32_SOC15(GC, 0, regCP_RB0_BASE, rb_addr);
  3425		WREG32_SOC15(GC, 0, regCP_RB0_BASE_HI, upper_32_bits(rb_addr));
  3426	
  3427		WREG32_SOC15(GC, 0, regCP_RB_ACTIVE, 1);
  3428	
  3429		gfx_v11_0_cp_gfx_set_doorbell(adev, ring);
  3430		mutex_unlock(&adev->srbm_mutex);
  3431	
  3432		/* Init gfx ring 1 for pipe 1 */
  3433		if (adev->gfx.num_gfx_rings > 1) {
  3434			mutex_lock(&adev->srbm_mutex);
  3435			gfx_v11_0_cp_gfx_switch_pipe(adev, PIPE_ID1);
  3436			/* maximum supported gfx ring is 2 */
  3437			ring = &adev->gfx.gfx_ring[1];
  3438			rb_bufsz = order_base_2(ring->ring_size / 8);
  3439			tmp = REG_SET_FIELD(0, CP_RB1_CNTL, RB_BUFSZ, rb_bufsz);
  3440			tmp = REG_SET_FIELD(tmp, CP_RB1_CNTL, RB_BLKSZ, rb_bufsz - 2);
  3441			WREG32_SOC15(GC, 0, regCP_RB1_CNTL, tmp);
  3442			/* Initialize the ring buffer's write pointers */
  3443			ring->wptr = 0;
  3444			WREG32_SOC15(GC, 0, regCP_RB1_WPTR, lower_32_bits(ring->wptr));
  3445			WREG32_SOC15(GC, 0, regCP_RB1_WPTR_HI, upper_32_bits(ring->wptr));
  3446			/* Set the wb address wether it's enabled or not */
  3447			rptr_addr = ring->rptr_gpu_addr;
  3448			WREG32_SOC15(GC, 0, regCP_RB1_RPTR_ADDR, lower_32_bits(rptr_addr));
  3449			WREG32_SOC15(GC, 0, regCP_RB1_RPTR_ADDR_HI, upper_32_bits(rptr_addr) &
  3450				     CP_RB1_RPTR_ADDR_HI__RB_RPTR_ADDR_HI_MASK);
  3451			wptr_gpu_addr = ring->wptr_gpu_addr;
  3452			WREG32_SOC15(GC, 0, regCP_RB_WPTR_POLL_ADDR_LO,
  3453				     lower_32_bits(wptr_gpu_addr));
  3454			WREG32_SOC15(GC, 0, regCP_RB_WPTR_POLL_ADDR_HI,
  3455				     upper_32_bits(wptr_gpu_addr));
  3456	
  3457			mdelay(1);
  3458			WREG32_SOC15(GC, 0, regCP_RB1_CNTL, tmp);
  3459	
  3460			rb_addr = ring->gpu_addr >> 8;
  3461			WREG32_SOC15(GC, 0, regCP_RB1_BASE, rb_addr);
  3462			WREG32_SOC15(GC, 0, regCP_RB1_BASE_HI, upper_32_bits(rb_addr));
  3463			WREG32_SOC15(GC, 0, regCP_RB1_ACTIVE, 1);
  3464	
  3465			gfx_v11_0_cp_gfx_set_doorbell(adev, ring);
  3466			mutex_unlock(&adev->srbm_mutex);
  3467		}
  3468		/* Switch to pipe 0 */
  3469		mutex_lock(&adev->srbm_mutex);
  3470		gfx_v11_0_cp_gfx_switch_pipe(adev, PIPE_ID0);
  3471		mutex_unlock(&adev->srbm_mutex);
  3472	
  3473		/* start the ring */
  3474		gfx_v11_0_cp_gfx_start(adev);
  3475	
  3476		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
  3477			ring = &adev->gfx.gfx_ring[i];
  3478			ring->sched.ready = true;
  3479		}
  3480	
  3481		return 0;
  3482	}
  3483	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
