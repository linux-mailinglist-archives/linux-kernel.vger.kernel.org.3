Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A5148827B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 09:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbiAHIlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 03:41:50 -0500
Received: from mga01.intel.com ([192.55.52.88]:58970 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233852AbiAHIlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 03:41:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641631307; x=1673167307;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GzEgai5YpqW4VLJLYbRgUGReQHJmpARbqA6scsPsFu4=;
  b=BPuLKuisgM6APnH+K2pcbZJhl0eshKqsbyVm9tCsn3bmdR9M3nuaV27K
   27NJ/kiaJMuaPsPKaPosWJUG2gRRdB8kZLQhGw0aPFbxEltyn59CYPXa+
   lPp4HI76P2oEEhbA36q2geZTdP/aXrP3R8EWAQ5jz49U4hP1itK0OWUFX
   8oFlNiLswlAD3XjVEOqJkTIciYiN8CLOduh18UqBp/CtHvu20QLYbnclS
   VAejkwwPfz4i2zf1AfchFjMsuqHFp6AFmjoosgAV3Eo3piR8/WQafUxB8
   yCaQPPXZphWgVYoOzyVCpd05fyeHmjTMCQ8etOSIlgembDuKvtMloEfw0
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="267312695"
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="267312695"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2022 00:41:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="514097113"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 08 Jan 2022 00:41:45 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n67IG-0000QE-Dx; Sat, 08 Jan 2022 08:41:44 +0000
Date:   Sat, 8 Jan 2022 16:41:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Evan Quan <evan.quan@amd.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>
Subject: [agd5f:drm-next 20/53]
 drivers/gpu/drm/amd/amdgpu/../pm/amdgpu_dpm_internal.c:29:6: warning: no
 previous prototype for function 'amdgpu_dpm_get_active_displays'
Message-ID: <202201081630.rt0Uku7J-lkp@intel.com>
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
config: x86_64-randconfig-a013-20220107 (https://download.01.org/0day-ci/archive/20220108/202201081630.rt0Uku7J-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project f3a344d2125fa37e59bae1b0874442c650a19607)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout 855b49a8859f07dc29076c3a301888b39550c362
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../pm/amdgpu_dpm_internal.c:29:6: warning: no previous prototype for function 'amdgpu_dpm_get_active_displays' [-Wmissing-prototypes]
   void amdgpu_dpm_get_active_displays(struct amdgpu_device *adev)
        ^
   drivers/gpu/drm/amd/amdgpu/../pm/amdgpu_dpm_internal.c:29:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void amdgpu_dpm_get_active_displays(struct amdgpu_device *adev)
   ^
   static 
>> drivers/gpu/drm/amd/amdgpu/../pm/amdgpu_dpm_internal.c:76:5: warning: no previous prototype for function 'amdgpu_dpm_get_vrefresh' [-Wmissing-prototypes]
   u32 amdgpu_dpm_get_vrefresh(struct amdgpu_device *adev)
       ^
   drivers/gpu/drm/amd/amdgpu/../pm/amdgpu_dpm_internal.c:76:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   u32 amdgpu_dpm_get_vrefresh(struct amdgpu_device *adev)
   ^
   static 
   2 warnings generated.


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
