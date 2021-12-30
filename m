Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A0B4819F3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 07:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236517AbhL3Gdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 01:33:44 -0500
Received: from mga12.intel.com ([192.55.52.136]:63819 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234335AbhL3Gdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 01:33:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640846023; x=1672382023;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=no3xFpux5BQd3Cq8fdWnf0hMWcWIZZF5HonoPV/1nJQ=;
  b=n6STQ5xLGcq2rnVQd7AA4QQTmOGR8XjmEdV9fSjInZXd8RFA1i++2EmH
   +8+KIVe09fvqlo9wj2W6knhPWd1ht/xKPgsGEUXTFQLlVzw62QDEqofKb
   yRN/zmFsfdSh95R093b5hwaTi7nB//t+oZu5scAIF/lSUMdJT2XUiqjV3
   tzm6vpkkPSR7JqhF/Yuq/OL1mnJvuMlkhKO83Vpai6t13Hymwzz+rU7Cc
   pt4SgTkq1iEC7RroN/Y51huRoNLebutDUiP7tZ31mFk6bxW5LgVDAIyuT
   KZz3KRpwDZaU6ve/1QQ+f3F9BsGnee2uUxgO2xzz4fHP12/Uoa8eO1wLq
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10212"; a="221622681"
X-IronPort-AV: E=Sophos;i="5.88,247,1635231600"; 
   d="scan'208";a="221622681"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 22:33:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,247,1635231600"; 
   d="scan'208";a="470564208"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 29 Dec 2021 22:33:41 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2p0O-0009qg-R8; Thu, 30 Dec 2021 06:33:40 +0000
Date:   Thu, 30 Dec 2021 14:33:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Stanley.Yang" <Stanley.Yang@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [agd5f:drm-next-5.17 85/342]
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c:64:18: warning: variable 'ecc_err_cnt'
 set but not used
Message-ID: <202112301449.EEf5bQCC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stanley.Yang,

FYI, the error/warning still remains.

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next-5.17
head:   46dbcbf47e6871e142ada8a8188b7a4fc8f1d808
commit: 8882f90a3fe2457c8b3f86bbbbef8754f704f5ef [85/342] drm/amdgpu: add new query interface for umc block v2
config: alpha-randconfig-r004-20211122 (https://download.01.org/0day-ci/archive/20211230/202112301449.EEf5bQCC-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next-5.17
        git checkout 8882f90a3fe2457c8b3f86bbbbef8754f704f5ef
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash drivers/gpu/drm/amd/amdgpu/ drivers/gpu/drm/amd/pm/swsmu/smu11/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/umc_v6_7.c: In function 'umc_v6_7_ecc_info_query_correctable_error_count':
>> drivers/gpu/drm/amd/amdgpu/umc_v6_7.c:64:18: warning: variable 'ecc_err_cnt' set but not used [-Wunused-but-set-variable]
      64 |         uint32_t ecc_err_cnt;
         |                  ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/umc_v6_7.c: In function 'umc_v6_7_ecc_info_query_ras_error_count':
>> drivers/gpu/drm/amd/amdgpu/umc_v6_7.c:113:18: warning: variable 'umc_reg_offset' set but not used [-Wunused-but-set-variable]
     113 |         uint32_t umc_reg_offset  = 0;
         |                  ^~~~~~~~~~~~~~


vim +/ecc_err_cnt +64 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c

    59	
    60	static void umc_v6_7_ecc_info_query_correctable_error_count(struct amdgpu_device *adev,
    61							   uint32_t channel_index,
    62							   unsigned long *error_count)
    63	{
  > 64		uint32_t ecc_err_cnt;
    65		uint64_t mc_umc_status;
    66		struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
    67	
    68		/*
    69		 * select the lower chip and check the error count
    70		 * skip add error count, calc error counter only from mca_umc_status
    71		 */
    72		ecc_err_cnt = ras->umc_ecc.ecc[channel_index].ce_count_lo_chip;
    73	
    74		/*
    75		 * select the higher chip and check the err counter
    76		 * skip add error count, calc error counter only from mca_umc_status
    77		 */
    78		ecc_err_cnt = ras->umc_ecc.ecc[channel_index].ce_count_hi_chip;
    79	
    80		/* check for SRAM correctable error
    81		  MCUMC_STATUS is a 64 bit register */
    82		mc_umc_status = ras->umc_ecc.ecc[channel_index].mca_umc_status;
    83		if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
    84		    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) == 1)
    85			*error_count += 1;
    86	}
    87	
    88	static void umc_v6_7_ecc_info_querry_uncorrectable_error_count(struct amdgpu_device *adev,
    89							      uint32_t channel_index,
    90							      unsigned long *error_count)
    91	{
    92		uint64_t mc_umc_status;
    93		struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
    94	
    95		/* check the MCUMC_STATUS */
    96		mc_umc_status = ras->umc_ecc.ecc[channel_index].mca_umc_status;
    97		if ((REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1) &&
    98		    (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Deferred) == 1 ||
    99		    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) == 1 ||
   100		    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, PCC) == 1 ||
   101		    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UC) == 1 ||
   102		    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, TCC) == 1))
   103			*error_count += 1;
   104	}
   105	
   106	static void umc_v6_7_ecc_info_query_ras_error_count(struct amdgpu_device *adev,
   107						   void *ras_error_status)
   108	{
   109		struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
   110	
   111		uint32_t umc_inst        = 0;
   112		uint32_t ch_inst         = 0;
 > 113		uint32_t umc_reg_offset  = 0;
   114		uint32_t channel_index	 = 0;
   115	
   116		/*TODO: driver needs to toggle DF Cstate to ensure
   117		 * safe access of UMC registers. Will add the protection */
   118		LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) {
   119			umc_reg_offset = get_umc_v6_7_reg_offset(adev,
   120								 umc_inst,
   121								 ch_inst);
   122			channel_index = get_umc_v6_7_channel_index(adev,
   123								 umc_inst,
   124								 ch_inst);
   125			umc_v6_7_ecc_info_query_correctable_error_count(adev,
   126							      channel_index,
   127							      &(err_data->ce_count));
   128			umc_v6_7_ecc_info_querry_uncorrectable_error_count(adev,
   129								  channel_index,
   130								  &(err_data->ue_count));
   131		}
   132	}
   133	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
