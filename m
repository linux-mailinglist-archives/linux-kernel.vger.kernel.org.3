Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F9049C549
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 09:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238492AbiAZIas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 03:30:48 -0500
Received: from mga09.intel.com ([134.134.136.24]:36339 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238482AbiAZIap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 03:30:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643185845; x=1674721845;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=45HjdDSSdmmL29uJvlR23zLwGLfFxTjTax9WppNmyUQ=;
  b=PJ6XRTScqS6aYGzsdVU4sbAp+xu2ueri9mE0moWpNh1aWofzFZRFLcR2
   jsx6Ue//A68sXkoEfscplitUKPDU3s6d7Firuas2qZO9ni6p1euy0YyUn
   XmS46gknTWXL/VGe5CcIBdHoaxowQ6wgEb6IACi6cxQCXt+tWuMi0js7Q
   H9B+hd+vuT/S1GiJ0lGkOxjtoJ4i1nmmQN1QFDNQQsJ0mhYd6QqiIsdRc
   lWfdbBcVRS6DEkUjoSY01oTu2T0GwBVNmp50FhQofIJt3cdgWMYnHihsm
   MrjnC23Pl7YjXEpUxfq67DqGMwXvjRBujg5c+BzcM133wVaYkwoJwMeut
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="246284960"
X-IronPort-AV: E=Sophos;i="5.88,317,1635231600"; 
   d="scan'208";a="246284960"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 00:30:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,317,1635231600"; 
   d="scan'208";a="520719898"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 26 Jan 2022 00:30:43 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCdhT-000Kzv-4X; Wed, 26 Jan 2022 08:30:43 +0000
Date:   Wed, 26 Jan 2022 16:30:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hawking Zhang <Hawking.Zhang@amd.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        "Zhou, Peng Ju" <PengJu.Zhou@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>
Subject: [agd5f:drm-next 124/190]
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:877:51: warning: variable
 'reg_access_ctrl' is uninitialized when used here
Message-ID: <202201261621.Wy5nLVza-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   63e583c8843f305a3e334a96d5de00435f4d38a2
commit: 5d447e296701484f3df5b31a7a078cbf1e3a9cc9 [124/190] drm/amdgpu: add helper for rlcg indirect reg access
config: i386-randconfig-a013-20220124 (https://download.01.org/0day-ci/archive/20220126/202201261621.Wy5nLVza-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 2a1b7aa016c0f4b5598806205bdfbab1ea2d92c4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout 5d447e296701484f3df5b31a7a078cbf1e3a9cc9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/amd/amdgpu/ drivers/gpu/drm/amd/display/amdgpu_dm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:877:51: warning: variable 'reg_access_ctrl' is uninitialized when used here [-Wuninitialized]
           scratch_reg0 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg0;
                                                            ^~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:861:53: note: initialize the variable 'reg_access_ctrl' to silence this warning
           struct amdgpu_rlcg_reg_access_ctrl *reg_access_ctrl;
                                                              ^
                                                               = NULL
   1 warning generated.


vim +/reg_access_ctrl +877 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c

   858	
   859	static u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 flag)
   860	{
   861		struct amdgpu_rlcg_reg_access_ctrl *reg_access_ctrl;
   862		uint32_t timeout = 50000;
   863		uint32_t i, tmp;
   864		uint32_t ret = 0;
   865		static void *scratch_reg0;
   866		static void *scratch_reg1;
   867		static void *scratch_reg2;
   868		static void *scratch_reg3;
   869		static void *spare_int;
   870	
   871		if (!adev->gfx.rlc.rlcg_reg_access_supported) {
   872			dev_err(adev->dev,
   873				"indirect registers access through rlcg is not available\n");
   874			return 0;
   875		}
   876	
 > 877		scratch_reg0 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg0;
   878		scratch_reg1 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg1;
   879		scratch_reg2 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg2;
   880		scratch_reg3 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg3;
   881		if (reg_access_ctrl->spare_int)
   882			spare_int = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->spare_int;
   883	
   884		if (offset == reg_access_ctrl->grbm_cntl) {
   885			/* if the target reg offset is grbm_cntl, write to scratch_reg2 */
   886			writel(v, scratch_reg2);
   887			writel(v, ((void __iomem *)adev->rmmio) + (offset * 4));
   888		} else if (offset == reg_access_ctrl->grbm_idx) {
   889			/* if the target reg offset is grbm_idx, write to scratch_reg3 */
   890			writel(v, scratch_reg3);
   891			writel(v, ((void __iomem *)adev->rmmio) + (offset * 4));
   892		} else {
   893			/*
   894			 * SCRATCH_REG0 	= read/write value
   895			 * SCRATCH_REG1[30:28]	= command
   896			 * SCRATCH_REG1[19:0]	= address in dword
   897			 * SCRATCH_REG1[26:24]	= Error reporting
   898			 */
   899			writel(v, scratch_reg0);
   900			writel((offset | flag), scratch_reg1);
   901			if (reg_access_ctrl->spare_int)
   902				writel(1, spare_int);
   903	
   904			for (i = 0; i < timeout; i++) {
   905				tmp = readl(scratch_reg1);
   906				if (!(tmp & flag))
   907					break;
   908				udelay(10);
   909			}
   910	
   911			if (i >= timeout) {
   912				if (amdgpu_sriov_rlcg_error_report_enabled(adev)) {
   913					if (tmp & AMDGPU_RLCG_VFGATE_DISABLED) {
   914						dev_err(adev->dev,
   915							"vfgate is disabled, rlcg failed to program reg: 0x%05x\n", offset);
   916					} else if (tmp & AMDGPU_RLCG_WRONG_OPERATION_TYPE) {
   917						dev_err(adev->dev,
   918							"wrong operation type, rlcg failed to program reg: 0x%05x\n", offset);
   919					} else if (tmp & AMDGPU_RLCG_REG_NOT_IN_RANGE) {
   920						dev_err(adev->dev,
   921							"regiser is not in range, rlcg failed to program reg: 0x%05x\n", offset);
   922					} else {
   923						dev_err(adev->dev,
   924							"unknown error type, rlcg failed to program reg: 0x%05x\n", offset);
   925					}
   926				} else {
   927					dev_err(adev->dev,
   928						"timeout: rlcg faled to program reg: 0x%05x\n", offset);
   929				}
   930			}
   931		}
   932	
   933		ret = readl(scratch_reg0);
   934		return ret;
   935	}
   936	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
