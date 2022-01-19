Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC33D4933FC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 05:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346353AbiASEMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 23:12:22 -0500
Received: from mga02.intel.com ([134.134.136.20]:23119 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235242AbiASEMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 23:12:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642565541; x=1674101541;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VZR2h/GvwBVB0YEd59gL2smSoKa+1JdaUfOKC6US0qc=;
  b=PCVigqhpWg/ES9QEK2HIZcz4UuZzbSu3kwADAl5YyhH/r7Wq4L86i5il
   fHN3+xfruT3bPhjx9Ladb8DTga11gl7ktbrnM9P5zL9pez+xhXFnxHNN2
   fTOMMcE+j261bS95HfvV9S5hf90thRfu0PsJWyRMAjKS9u9Rt7g1NW9zN
   U+yuK9OYKtygRxL2+WHv3qO/wnmkUKMEIvlhFVtgeCXAS116KN4GKSAUO
   nNDk+Tn1X5mGSQvmIvhdSwO+d5nq6EKmyN5sWGZj5F9H2rDqFeKara76P
   mg4ahMoQdpSUO/tA0RBrNwx4tPQwffn2D3bPTmy5xF0mKRrMwNSrdh7qH
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="232340424"
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="232340424"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 20:12:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="492892905"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 18 Jan 2022 20:12:18 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nA2KY-000DF5-0p; Wed, 19 Jan 2022 04:12:18 +0000
Date:   Wed, 19 Jan 2022 12:12:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     mziya <Mohammadzafar.ziya@amd.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        "Stanley.Yang" <Stanley.Yang@amd.com>
Subject: [agd5f:drm-next 56/91] drivers/gpu/drm/amd/amdgpu/umc_v8_7.c:97:11:
 warning: variable 'umc_reg_offset' set but not used
Message-ID: <202201191214.xx7M9Hem-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   e23fcf632883babbea03fc27f7993e151969b652
commit: c34242eea16f7d973501267142dd340cad3caeec [56/91] drm/amdgpu: add new query interface for umc_v8_7 block
config: i386-randconfig-a001-20220117 (https://download.01.org/0day-ci/archive/20220119/202201191214.xx7M9Hem-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project f7b7138a62648f4019c55e4671682af1f851f295)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout c34242eea16f7d973501267142dd340cad3caeec
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/amd/amdgpu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/umc_v8_7.c:97:11: warning: variable 'umc_reg_offset' set but not used [-Wunused-but-set-variable]
           uint32_t umc_reg_offset  = 0;
                    ^
   1 warning generated.


vim +/umc_reg_offset +97 drivers/gpu/drm/amd/amdgpu/umc_v8_7.c

    89	
    90	static void umc_v8_7_ecc_info_query_ras_error_count(struct amdgpu_device *adev,
    91						void *ras_error_status)
    92	{
    93		struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
    94	
    95		uint32_t umc_inst        = 0;
    96		uint32_t ch_inst         = 0;
  > 97		uint32_t umc_reg_offset  = 0;
    98		uint32_t channel_index   = 0;
    99	
   100		/* TODO: driver needs to toggle DF Cstate to ensure
   101		 * safe access of UMC registers. Will add the protection
   102		 */
   103		LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) {
   104			umc_reg_offset = get_umc_v8_7_reg_offset(adev,
   105								umc_inst,
   106								ch_inst);
   107			channel_index = get_umc_v8_7_channel_index(adev,
   108								umc_inst,
   109								ch_inst);
   110			umc_v8_7_ecc_info_query_correctable_error_count(adev,
   111								channel_index,
   112								&(err_data->ce_count));
   113			umc_v8_7_ecc_info_querry_uncorrectable_error_count(adev,
   114								channel_index,
   115								&(err_data->ue_count));
   116		}
   117	}
   118	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
