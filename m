Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE86D51B155
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 23:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378893AbiEDVt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 17:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbiEDVtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 17:49:55 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4614D63D
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 14:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651700778; x=1683236778;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=p2pNxFGflUwXLIt4gyosVcwyl8NOU9tEMOP0RPSlsfE=;
  b=glE9GvlUv9p/W3SPwQhKbGQQZ2I23G4z4vBCoxijqekQUp+33AMa4yNL
   S6Je5daac/MQTP8L8ff5exB/bQia3K2HA2qWBQXI0LNqYi4RWPwWLur+L
   tVXcQH7NQSig7WijpyLYBAddOS6zCkyfjvyvKxEo7Vxssnl48Pv/1qJIb
   tKDsstscnb3483R2+qKVfOf8Wmf5zgugR0B1juVAuweWi2LinTNRjDujZ
   cFqxLfkjTEUTJng/mczs5neaKVbmE1GEay639YfOPly0mWFlsVuXj0ndm
   BAhiSvlpomvjNjMHfQQ/wUlAunLyqT/+xmF1svxwlJ3h7yaS1gvbpKYAp
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="265502637"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="265502637"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 14:46:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="734598584"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 04 May 2022 14:46:16 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmMp5-000Bnv-CD;
        Wed, 04 May 2022 21:46:15 +0000
Date:   Thu, 5 May 2022 05:45:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jack Xiao <Jack.Xiao@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [agd5f:drm-next 428/460]
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c:706:34: error:
 'CP_HQD_PQ_CONTROL__ENDIAN_SWAP_MASK' undeclared; did you mean
 'CP_HQD_PQ_CONTROL__PRIV_STATE_MASK'?
Message-ID: <202205050534.Qm1brRH5-lkp@intel.com>
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
head:   d6ffefccf7f04eefddc8e8aa35fb4afe05a42e0c
commit: 028c3fb37e705b8fa1448c23c42d1c89f48c07c5 [428/460] drm/amdgpu/mes11: initiate mes v11 support
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220505/202205050534.Qm1brRH5-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout 028c3fb37e705b8fa1448c23c42d1c89f48c07c5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/amd/amdgpu/mes_v11_0.c:26:
   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c: In function 'mes_v11_0_mqd_init':
>> drivers/gpu/drm/amd/amdgpu/mes_v11_0.c:706:34: error: 'CP_HQD_PQ_CONTROL__ENDIAN_SWAP_MASK' undeclared (first use in this function); did you mean 'CP_HQD_PQ_CONTROL__PRIV_STATE_MASK'?
     706 |         tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, ENDIAN_SWAP, 1);
         |                                  ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/amdgpu.h:1177:36: note: in definition of macro 'REG_FIELD_MASK'
    1177 | #define REG_FIELD_MASK(reg, field) reg##__##field##_MASK
         |                                    ^~~
   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c:706:15: note: in expansion of macro 'REG_SET_FIELD'
     706 |         tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, ENDIAN_SWAP, 1);
         |               ^~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c:706:34: note: each undeclared identifier is reported only once for each function it appears in
     706 |         tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, ENDIAN_SWAP, 1);
         |                                  ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/amdgpu.h:1177:36: note: in definition of macro 'REG_FIELD_MASK'
    1177 | #define REG_FIELD_MASK(reg, field) reg##__##field##_MASK
         |                                    ^~~
   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c:706:15: note: in expansion of macro 'REG_SET_FIELD'
     706 |         tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, ENDIAN_SWAP, 1);
         |               ^~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/mes_v11_0.c:706:34: error: 'CP_HQD_PQ_CONTROL__ENDIAN_SWAP__SHIFT' undeclared (first use in this function); did you mean 'CP_HQD_PQ_CONTROL__PRIV_STATE__SHIFT'?
     706 |         tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, ENDIAN_SWAP, 1);
         |                                  ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/amdgpu.h:1176:37: note: in definition of macro 'REG_FIELD_SHIFT'
    1176 | #define REG_FIELD_SHIFT(reg, field) reg##__##field##__SHIFT
         |                                     ^~~
   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c:706:15: note: in expansion of macro 'REG_SET_FIELD'
     706 |         tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, ENDIAN_SWAP, 1);
         |               ^~~~~~~~~~~~~


vim +706 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c

   632	
   633	static int mes_v11_0_mqd_init(struct amdgpu_ring *ring)
   634	{
   635		struct amdgpu_device *adev = ring->adev;
   636		struct v10_compute_mqd *mqd = ring->mqd_ptr;
   637		uint64_t hqd_gpu_addr, wb_gpu_addr, eop_base_addr;
   638		uint32_t tmp;
   639	
   640		mqd->header = 0xC0310800;
   641		mqd->compute_pipelinestat_enable = 0x00000001;
   642		mqd->compute_static_thread_mgmt_se0 = 0xffffffff;
   643		mqd->compute_static_thread_mgmt_se1 = 0xffffffff;
   644		mqd->compute_static_thread_mgmt_se2 = 0xffffffff;
   645		mqd->compute_static_thread_mgmt_se3 = 0xffffffff;
   646		mqd->compute_misc_reserved = 0x00000007;
   647	
   648		eop_base_addr = ring->eop_gpu_addr >> 8;
   649		mqd->cp_hqd_eop_base_addr_lo = eop_base_addr;
   650		mqd->cp_hqd_eop_base_addr_hi = upper_32_bits(eop_base_addr);
   651	
   652		/* set the EOP size, register value is 2^(EOP_SIZE+1) dwords */
   653		tmp = RREG32_SOC15(GC, 0, regCP_HQD_EOP_CONTROL);
   654		tmp = REG_SET_FIELD(tmp, CP_HQD_EOP_CONTROL, EOP_SIZE,
   655				(order_base_2(MES_EOP_SIZE / 4) - 1));
   656	
   657		mqd->cp_hqd_eop_control = tmp;
   658	
   659		/* enable doorbell? */
   660		tmp = RREG32_SOC15(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL);
   661	
   662		if (ring->use_doorbell) {
   663			tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
   664					    DOORBELL_OFFSET, ring->doorbell_index);
   665			tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
   666					    DOORBELL_EN, 1);
   667			tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
   668					    DOORBELL_SOURCE, 0);
   669			tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
   670					    DOORBELL_HIT, 0);
   671		}
   672		else
   673			tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
   674					    DOORBELL_EN, 0);
   675	
   676		mqd->cp_hqd_pq_doorbell_control = tmp;
   677	
   678		/* disable the queue if it's active */
   679		ring->wptr = 0;
   680		mqd->cp_hqd_dequeue_request = 0;
   681		mqd->cp_hqd_pq_rptr = 0;
   682		mqd->cp_hqd_pq_wptr_lo = 0;
   683		mqd->cp_hqd_pq_wptr_hi = 0;
   684	
   685		/* set the pointer to the MQD */
   686		mqd->cp_mqd_base_addr_lo = ring->mqd_gpu_addr & 0xfffffffc;
   687		mqd->cp_mqd_base_addr_hi = upper_32_bits(ring->mqd_gpu_addr);
   688	
   689		/* set MQD vmid to 0 */
   690		tmp = RREG32_SOC15(GC, 0, regCP_MQD_CONTROL);
   691		tmp = REG_SET_FIELD(tmp, CP_MQD_CONTROL, VMID, 0);
   692		mqd->cp_mqd_control = tmp;
   693	
   694		/* set the pointer to the HQD, this is similar CP_RB0_BASE/_HI */
   695		hqd_gpu_addr = ring->gpu_addr >> 8;
   696		mqd->cp_hqd_pq_base_lo = hqd_gpu_addr;
   697		mqd->cp_hqd_pq_base_hi = upper_32_bits(hqd_gpu_addr);
   698	
   699		/* set up the HQD, this is similar to CP_RB0_CNTL */
   700		tmp = RREG32_SOC15(GC, 0, regCP_HQD_PQ_CONTROL);
   701		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, QUEUE_SIZE,
   702				    (order_base_2(ring->ring_size / 4) - 1));
   703		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
   704				    ((order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1) << 8));
   705	#ifdef __BIG_ENDIAN
 > 706		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, ENDIAN_SWAP, 1);
   707	#endif
   708		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 0);
   709		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH, 0);
   710		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
   711		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
   712		mqd->cp_hqd_pq_control = tmp;
   713	
   714		/* set the wb address whether it's enabled or not */
   715		wb_gpu_addr = ring->rptr_gpu_addr;;
   716		mqd->cp_hqd_pq_rptr_report_addr_lo = wb_gpu_addr & 0xfffffffc;
   717		mqd->cp_hqd_pq_rptr_report_addr_hi =
   718			upper_32_bits(wb_gpu_addr) & 0xffff;
   719	
   720		/* only used if CP_PQ_WPTR_POLL_CNTL.CP_PQ_WPTR_POLL_CNTL__EN_MASK=1 */
   721		wb_gpu_addr = ring->wptr_gpu_addr;
   722		mqd->cp_hqd_pq_wptr_poll_addr_lo = wb_gpu_addr & 0xfffffff8;
   723		mqd->cp_hqd_pq_wptr_poll_addr_hi = upper_32_bits(wb_gpu_addr) & 0xffff;
   724	
   725		tmp = 0;
   726		/* enable the doorbell if requested */
   727		if (ring->use_doorbell) {
   728			tmp = RREG32_SOC15(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL);
   729			tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
   730					DOORBELL_OFFSET, ring->doorbell_index);
   731	
   732			tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
   733					    DOORBELL_EN, 1);
   734			tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
   735					    DOORBELL_SOURCE, 0);
   736			tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
   737					    DOORBELL_HIT, 0);
   738		}
   739	
   740		mqd->cp_hqd_pq_doorbell_control = tmp;
   741	
   742		/* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
   743		ring->wptr = 0;
   744		mqd->cp_hqd_pq_rptr = RREG32_SOC15(GC, 0, regCP_HQD_PQ_RPTR);
   745	
   746		/* set the vmid for the queue */
   747		mqd->cp_hqd_vmid = 0;
   748	
   749		tmp = RREG32_SOC15(GC, 0, regCP_HQD_PERSISTENT_STATE);
   750		tmp = REG_SET_FIELD(tmp, CP_HQD_PERSISTENT_STATE, PRELOAD_SIZE, 0x55);
   751		mqd->cp_hqd_persistent_state = tmp;
   752	
   753		/* set MIN_IB_AVAIL_SIZE */
   754		tmp = RREG32_SOC15(GC, 0, regCP_HQD_IB_CONTROL);
   755		tmp = REG_SET_FIELD(tmp, CP_HQD_IB_CONTROL, MIN_IB_AVAIL_SIZE, 3);
   756		mqd->cp_hqd_ib_control = tmp;
   757	
   758		/* activate the queue */
   759		mqd->cp_hqd_active = 1;
   760		return 0;
   761	}
   762	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
