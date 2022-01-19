Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031C6493420
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 05:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351568AbiASExY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 23:53:24 -0500
Received: from mga04.intel.com ([192.55.52.120]:47056 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349586AbiASExW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 23:53:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642568002; x=1674104002;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3VyniYfxzb8QV4JMONvPYjE01jTYzB0RgF/1+pckj8w=;
  b=Iw2KRQayoGiuIbWoScWvF/mLo7ObnII6j9MmulIEAdHwYA11Ghq0R09O
   HoFadVGN2+vpG/bn1gL5w+gnNb/FGFZk5LwJk9/l+uIjR3R0VtJs6CqSu
   ZGyR0ChhOcq/bPh0oJ/hhJNzEkfPIJKn96CJ+Y+GURbiSSvgGRgPR3HUH
   NlJl3gZFDdiw0RqoKHwV5G8Iny2GRJjn4Q6ZzdKfPFdYo4F6Bpu9slYyM
   Nt2oy0EluRfdHnrTuU+NcMvKK0b1nMyVG34KyIHII661iSkDt4Rrcr5Mq
   WhPmr/55q9+XkWUNCCyaWMlA87HVdy6zV2DDlD4aBEdUGvb+J6EzCnxPJ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="243803770"
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="243803770"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 20:53:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="693645426"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 18 Jan 2022 20:53:19 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nA2yE-000DGf-J4; Wed, 19 Jan 2022 04:53:18 +0000
Date:   Wed, 19 Jan 2022 12:52:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     mziya <Mohammadzafar.ziya@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        "Stanley.Yang" <Stanley.Yang@amd.com>
Subject: [agd5f:drm-next 56/91] drivers/gpu/drm/amd/amdgpu/umc_v8_7.c:97:18:
 warning: variable 'umc_reg_offset' set but not used
Message-ID: <202201191227.YskrG1I5-lkp@intel.com>
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
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220119/202201191227.YskrG1I5-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout c34242eea16f7d973501267142dd340cad3caeec
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/gpu/drm/amd/amdgpu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/umc_v8_7.c: In function 'umc_v8_7_ecc_info_query_ras_error_count':
>> drivers/gpu/drm/amd/amdgpu/umc_v8_7.c:97:18: warning: variable 'umc_reg_offset' set but not used [-Wunused-but-set-variable]
      97 |         uint32_t umc_reg_offset  = 0;
         |                  ^~~~~~~~~~~~~~


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
