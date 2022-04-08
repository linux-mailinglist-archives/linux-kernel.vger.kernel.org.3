Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0924F8D9E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234578AbiDHFIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 01:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234555AbiDHFH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 01:07:27 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2DC22C6C2
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 22:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649394323; x=1680930323;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=R2BzqEH79jrDGPygBdzpig626mQIgmJkQSHa9nyKP4k=;
  b=c+otwALdkeWhJsOQWhyIBVX+85RAWbSEWUMNtyiE+Vi/e/mp9f9tb/6t
   6nYI6XRF90GDuEcEIXViKrg87yvddqRtvob3zYXpN/gtH1G3KKyG3H4mp
   aSKJJk7QrEp5/MmwTiqCL25vcwh/cNDEmJ6n1Bult9YYt3lEiiBWwVsYD
   8e45WT16sQu9CtIcgk5wHriRG3AJFmOpIjH/NO2dklhUy52CGS0OZpNiV
   xAytqCnTkyjbDoQUenrVVVl2iAdJbm69Hrje7Iev7SorVW7IyJUeuMJwD
   0XrHCrumcDaUFegMf4jQnJ9etAVvfkCYpqDBxfjhrqvHwv+j71K/koCWv
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="242106662"
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="242106662"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 22:05:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="525231646"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 07 Apr 2022 22:05:21 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncgoC-00064V-HW;
        Fri, 08 Apr 2022 05:05:20 +0000
Date:   Fri, 8 Apr 2022 13:04:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yongqiang Sun <yongqiang.sun@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [agd5f:drm-next 132/132]
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c:653:46: error: implicit declaration
 of function 'hypervisor_is_type'
Message-ID: <202204081332.6PEs6cNB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   49aa98ca30cd186ab33fc5802066e2024d3bfa39
commit: 49aa98ca30cd186ab33fc5802066e2024d3bfa39 [132/132] drm/amd/amdgpu: Only reserve vram for firmware with vega9 MS_HYPERV host.
config: sparc64-randconfig-r032-20220408 (https://download.01.org/0day-ci/archive/20220408/202204081332.6PEs6cNB-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout 49aa98ca30cd186ab33fc5802066e2024d3bfa39
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc64 SHELL=/bin/bash drivers/gpu/drm/amd/amdgpu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c: In function 'amdgpu_gmc_get_vbios_allocations':
>> drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c:653:46: error: implicit declaration of function 'hypervisor_is_type' [-Werror=implicit-function-declaration]
     653 |                 if (amdgpu_sriov_vf(adev) && hypervisor_is_type(X86_HYPER_MS_HYPERV)) {
         |                                              ^~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c:653:65: error: 'X86_HYPER_MS_HYPERV' undeclared (first use in this function)
     653 |                 if (amdgpu_sriov_vf(adev) && hypervisor_is_type(X86_HYPER_MS_HYPERV)) {
         |                                                                 ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c:653:65: note: each undeclared identifier is reported only once for each function it appears in
   cc1: some warnings being treated as errors


vim +/hypervisor_is_type +653 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c

   627	
   628	void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev)
   629	{
   630		unsigned size;
   631	
   632		/*
   633		 * Some ASICs need to reserve a region of video memory to avoid access
   634		 * from driver
   635		 */
   636		adev->mman.stolen_reserved_offset = 0;
   637		adev->mman.stolen_reserved_size = 0;
   638	
   639		/*
   640		 * TODO:
   641		 * Currently there is a bug where some memory client outside
   642		 * of the driver writes to first 8M of VRAM on S3 resume,
   643		 * this overrides GART which by default gets placed in first 8M and
   644		 * causes VM_FAULTS once GTT is accessed.
   645		 * Keep the stolen memory reservation until the while this is not solved.
   646		 */
   647		switch (adev->asic_type) {
   648		case CHIP_VEGA10:
   649			adev->mman.keep_stolen_vga_memory = true;
   650			/*
   651			 * VEGA10 SRIOV VF with MS_HYPERV host needs some firmware reserved area.
   652			 */
 > 653			if (amdgpu_sriov_vf(adev) && hypervisor_is_type(X86_HYPER_MS_HYPERV)) {
   654				adev->mman.stolen_reserved_offset = 0x500000;
   655				adev->mman.stolen_reserved_size = 0x200000;
   656			}
   657			break;
   658		case CHIP_RAVEN:
   659		case CHIP_RENOIR:
   660			adev->mman.keep_stolen_vga_memory = true;
   661			break;
   662		case CHIP_YELLOW_CARP:
   663			if (amdgpu_discovery == 0) {
   664				adev->mman.stolen_reserved_offset = 0x1ffb0000;
   665				adev->mman.stolen_reserved_size = 64 * PAGE_SIZE;
   666			}
   667			break;
   668		default:
   669			adev->mman.keep_stolen_vga_memory = false;
   670			break;
   671		}
   672	
   673		if (amdgpu_sriov_vf(adev) ||
   674		    !amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_DCE)) {
   675			size = 0;
   676		} else {
   677			size = amdgpu_gmc_get_vbios_fb_size(adev);
   678	
   679			if (adev->mman.keep_stolen_vga_memory)
   680				size = max(size, (unsigned)AMDGPU_VBIOS_VGA_ALLOCATION);
   681		}
   682	
   683		/* set to 0 if the pre-OS buffer uses up most of vram */
   684		if ((adev->gmc.real_vram_size - size) < (8 * 1024 * 1024))
   685			size = 0;
   686	
   687		if (size > AMDGPU_VBIOS_VGA_ALLOCATION) {
   688			adev->mman.stolen_vga_size = AMDGPU_VBIOS_VGA_ALLOCATION;
   689			adev->mman.stolen_extended_size = size - adev->mman.stolen_vga_size;
   690		} else {
   691			adev->mman.stolen_vga_size = size;
   692			adev->mman.stolen_extended_size = 0;
   693		}
   694	}
   695	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
