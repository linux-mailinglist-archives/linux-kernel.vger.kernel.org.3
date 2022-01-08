Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18226488558
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 19:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbiAHSYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 13:24:07 -0500
Received: from mga07.intel.com ([134.134.136.100]:38919 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230026AbiAHSYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 13:24:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641666245; x=1673202245;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=y55tsKI/LIdDDF1AGMKGPcuVM86HFS14br6dNdIZZWY=;
  b=OjYJUdO4A8NOicGn1CSgQDlTMRAqECNdVN5aT0G/iRq7RrT7TReXMQAl
   z0nDNMTyNjdi3wy6J2nCl6rhdY7EmbohnMRwtK98et8J/dJ/08m5gGA+K
   0Hc0GMPkBBK4knD5isP1AVZexg/AI+4eXXVo2EEx41abdmaprgu53syx+
   h7GKvzNWYd1H5b71/hwBNRJ15R4MR22N8hBtQ8cJJCCYvDt/zn6/+KzDn
   WtwcTLe1LnprZIexrmpz7mkQRJiTa7rFZ7hqM4iTFc149TVBS23alcXSY
   5p0jZ1JQIrY8mbfdDp6CLcYrTRBTWfzppcGPTvlhnDOO5uXibnQFy3eyL
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10221"; a="306391836"
X-IronPort-AV: E=Sophos;i="5.88,273,1635231600"; 
   d="scan'208";a="306391836"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2022 10:24:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,273,1635231600"; 
   d="scan'208";a="514205540"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 08 Jan 2022 10:24:04 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6GNn-0000u9-7H; Sat, 08 Jan 2022 18:24:03 +0000
Date:   Sun, 9 Jan 2022 02:23:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Evan Quan <evan.quan@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>
Subject: [agd5f:drm-next 20/53]
 drivers/gpu/drm/amd/amdgpu/../pm/amdgpu_dpm_internal.c:29:6: warning: no
 previous prototype for 'amdgpu_dpm_get_active_displays'
Message-ID: <202201090201.ed6mhBaD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   ec1289d5cf9f8b8872ed8b9e57130d27938faccf
commit: 855b49a8859f07dc29076c3a301888b39550c362 [20/53] drm/amd/pm: optimize the amdgpu_pm_compute_clocks() implementations
config: arm64-randconfig-r016-20220108 (https://download.01.org/0day-ci/archive/20220109/202201090201.ed6mhBaD-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout 855b49a8859f07dc29076c3a301888b39550c362
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/gpu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../pm/amdgpu_dpm_internal.c:29:6: warning: no previous prototype for 'amdgpu_dpm_get_active_displays' [-Wmissing-prototypes]
      29 | void amdgpu_dpm_get_active_displays(struct amdgpu_device *adev)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../pm/amdgpu_dpm_internal.c:76:5: warning: no previous prototype for 'amdgpu_dpm_get_vrefresh' [-Wmissing-prototypes]
      76 | u32 amdgpu_dpm_get_vrefresh(struct amdgpu_device *adev)
         |     ^~~~~~~~~~~~~~~~~~~~~~~


vim +/amdgpu_dpm_get_active_displays +29 drivers/gpu/drm/amd/amdgpu/../pm/amdgpu_dpm_internal.c

    28	
  > 29	void amdgpu_dpm_get_active_displays(struct amdgpu_device *adev)
    30	{
    31		struct drm_device *ddev = adev_to_drm(adev);
    32		struct drm_crtc *crtc;
    33		struct amdgpu_crtc *amdgpu_crtc;
    34	
    35		adev->pm.dpm.new_active_crtcs = 0;
    36		adev->pm.dpm.new_active_crtc_count = 0;
    37		if (adev->mode_info.num_crtc && adev->mode_info.mode_config_initialized) {
    38			list_for_each_entry(crtc,
    39					    &ddev->mode_config.crtc_list, head) {
    40				amdgpu_crtc = to_amdgpu_crtc(crtc);
    41				if (amdgpu_crtc->enabled) {
    42					adev->pm.dpm.new_active_crtcs |= (1 << amdgpu_crtc->crtc_id);
    43					adev->pm.dpm.new_active_crtc_count++;
    44				}
    45			}
    46		}
    47	}
    48	
    49	u32 amdgpu_dpm_get_vblank_time(struct amdgpu_device *adev)
    50	{
    51		struct drm_device *dev = adev_to_drm(adev);
    52		struct drm_crtc *crtc;
    53		struct amdgpu_crtc *amdgpu_crtc;
    54		u32 vblank_in_pixels;
    55		u32 vblank_time_us = 0xffffffff; /* if the displays are off, vblank time is max */
    56	
    57		if (adev->mode_info.num_crtc && adev->mode_info.mode_config_initialized) {
    58			list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
    59				amdgpu_crtc = to_amdgpu_crtc(crtc);
    60				if (crtc->enabled && amdgpu_crtc->enabled && amdgpu_crtc->hw_mode.clock) {
    61					vblank_in_pixels =
    62						amdgpu_crtc->hw_mode.crtc_htotal *
    63						(amdgpu_crtc->hw_mode.crtc_vblank_end -
    64						amdgpu_crtc->hw_mode.crtc_vdisplay +
    65						(amdgpu_crtc->v_border * 2));
    66	
    67					vblank_time_us = vblank_in_pixels * 1000 / amdgpu_crtc->hw_mode.clock;
    68					break;
    69				}
    70			}
    71		}
    72	
    73		return vblank_time_us;
    74	}
    75	
  > 76	u32 amdgpu_dpm_get_vrefresh(struct amdgpu_device *adev)

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
