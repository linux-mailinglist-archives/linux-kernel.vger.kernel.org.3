Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA6951B3BA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 01:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbiEDXr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 19:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377942AbiEDXnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 19:43:55 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB43EDC7
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 16:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651707616; x=1683243616;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ErLPKcP/QuhD6dx8c87SJVGz6qV2J/pSXkY92k22r/g=;
  b=JV0uaoUZEVTgf0KAfg9fNDoHUWIpNrqNQ4ZCraCTqF7CiDOVOXcwR6Kh
   F4FOGG6xw5nJRl0YG3MOvzgLYG9AJ6X1OZE7ey7rcQiqb7GDiOD9uOPSY
   F6CvjAhh7OeHcH0347aEsMrBUtp6jIWfviFAyyxRe7a2vNuAsXoYM/9ED
   ZTSlollE/BmARTuY/s29DAu8pOLxADzSboatGv/9vdoG+NdYYU9GR/JuB
   sj6MhkSF/W5lpMhTzVT/xgBygPQad2QPlW0lDFCQyNh2lkdDWxP6K+j+k
   W3B10rg0MjrSVB8fVI5yq2ujg5kfazLoMecuxlt6PxR/csNfCRWcjisiV
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="248467380"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="248467380"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 16:40:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="621032139"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 04 May 2022 16:40:15 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmObO-000Btz-Fe;
        Wed, 04 May 2022 23:40:14 +0000
Date:   Thu, 5 May 2022 07:39:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leo Liu <leo.liu@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        James Zhu <James.Zhu@amd.com>
Subject: [agd5f:drm-next 451/460]
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c:1731:6: warning: no previous prototype
 for 'vcn_v3_0_dec_sw_ring_emit_fence'
Message-ID: <202205050701.Cg5K2NIK-lkp@intel.com>
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
commit: 1218a2e39fded75543d1dea04b8ed50e59ac6cdd [451/460] drm/amdgpu: make software ring functions reuseable for newer VCN
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220505/202205050701.Cg5K2NIK-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout 1218a2e39fded75543d1dea04b8ed50e59ac6cdd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash drivers/gpu/drm/amd/amdgpu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c:1731:6: warning: no previous prototype for 'vcn_v3_0_dec_sw_ring_emit_fence' [-Wmissing-prototypes]
    1731 | void vcn_v3_0_dec_sw_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c:1743:6: warning: no previous prototype for 'vcn_v3_0_dec_sw_ring_insert_end' [-Wmissing-prototypes]
    1743 | void vcn_v3_0_dec_sw_ring_insert_end(struct amdgpu_ring *ring)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c:1748:6: warning: no previous prototype for 'vcn_v3_0_dec_sw_ring_emit_ib' [-Wmissing-prototypes]
    1748 | void vcn_v3_0_dec_sw_ring_emit_ib(struct amdgpu_ring *ring, struct amdgpu_job *job,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c:1760:6: warning: no previous prototype for 'vcn_v3_0_dec_sw_ring_emit_reg_wait' [-Wmissing-prototypes]
    1760 | void vcn_v3_0_dec_sw_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c:1769:6: warning: no previous prototype for 'vcn_v3_0_dec_sw_ring_emit_vm_flush' [-Wmissing-prototypes]
    1769 | void vcn_v3_0_dec_sw_ring_emit_vm_flush(struct amdgpu_ring *ring,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c:1784:6: warning: no previous prototype for 'vcn_v3_0_dec_sw_ring_emit_wreg' [-Wmissing-prototypes]
    1784 | void vcn_v3_0_dec_sw_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/vcn_v3_0_dec_sw_ring_emit_fence +1731 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c

  1730	
> 1731	void vcn_v3_0_dec_sw_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
  1732	      u64 seq, uint32_t flags)
  1733	{
  1734		WARN_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
  1735	
  1736		amdgpu_ring_write(ring, VCN_DEC_SW_CMD_FENCE);
  1737		amdgpu_ring_write(ring, addr);
  1738		amdgpu_ring_write(ring, upper_32_bits(addr));
  1739		amdgpu_ring_write(ring, seq);
  1740		amdgpu_ring_write(ring, VCN_DEC_SW_CMD_TRAP);
  1741	}
  1742	
> 1743	void vcn_v3_0_dec_sw_ring_insert_end(struct amdgpu_ring *ring)
  1744	{
  1745		amdgpu_ring_write(ring, VCN_DEC_SW_CMD_END);
  1746	}
  1747	
> 1748	void vcn_v3_0_dec_sw_ring_emit_ib(struct amdgpu_ring *ring, struct amdgpu_job *job,
  1749	        struct amdgpu_ib *ib, uint32_t flags)
  1750	{
  1751		uint32_t vmid = AMDGPU_JOB_GET_VMID(job);
  1752	
  1753		amdgpu_ring_write(ring, VCN_DEC_SW_CMD_IB);
  1754		amdgpu_ring_write(ring, vmid);
  1755		amdgpu_ring_write(ring, lower_32_bits(ib->gpu_addr));
  1756		amdgpu_ring_write(ring, upper_32_bits(ib->gpu_addr));
  1757		amdgpu_ring_write(ring, ib->length_dw);
  1758	}
  1759	
> 1760	void vcn_v3_0_dec_sw_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
  1761	        uint32_t val, uint32_t mask)
  1762	{
  1763		amdgpu_ring_write(ring, VCN_DEC_SW_CMD_REG_WAIT);
  1764		amdgpu_ring_write(ring, reg << 2);
  1765		amdgpu_ring_write(ring, mask);
  1766		amdgpu_ring_write(ring, val);
  1767	}
  1768	
> 1769	void vcn_v3_0_dec_sw_ring_emit_vm_flush(struct amdgpu_ring *ring,
  1770	        uint32_t vmid, uint64_t pd_addr)
  1771	{
  1772		struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->funcs->vmhub];
  1773		uint32_t data0, data1, mask;
  1774	
  1775		pd_addr = amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
  1776	
  1777		/* wait for register write */
  1778		data0 = hub->ctx0_ptb_addr_lo32 + vmid * hub->ctx_addr_distance;
  1779		data1 = lower_32_bits(pd_addr);
  1780		mask = 0xffffffff;
  1781		vcn_v3_0_dec_sw_ring_emit_reg_wait(ring, data0, data1, mask);
  1782	}
  1783	
> 1784	void vcn_v3_0_dec_sw_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
  1785	      uint32_t val)
  1786	{
  1787		amdgpu_ring_write(ring, VCN_DEC_SW_CMD_REG_WRITE);
  1788		amdgpu_ring_write(ring,	reg << 2);
  1789		amdgpu_ring_write(ring, val);
  1790	}
  1791	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
