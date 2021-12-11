Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C01EF4711F7
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 06:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhLKFjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 00:39:09 -0500
Received: from mga09.intel.com ([134.134.136.24]:52540 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229621AbhLKFjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 00:39:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639200933; x=1670736933;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Zn6FZl8kQmJxVoCDower+78MRLEjQ+VYM8wSuETAoUs=;
  b=bzI+zP1/GmvtEstwqTo9v1Fwo12jRHxaoSorsnhn//+8lVJ4oqqxta2F
   GH+wy1s0F7U8XRf5jDGfl8WH04e/wxudyog3x7H5+ofFcy13PlNIjVqmm
   pSjptKFAxX4SSLJDkSgYlvEFicpwHqOeTU5RR+dPjGktJ6pzl6MQIa2yJ
   +Y2CxiRJPkNr620YXcHafroJ+2dtamlVji1APufa3vWC+h9BQV4lmu4uk
   iPPeWzHcRBxx/0KQCoN4LpzhBXPolPzi7kgIyKhIAxwKmVtOrjzZAdbI+
   g6XLvImWWXEt0678l2ulMTC9F/eh7yaMqpW2dr8l8FenmwhxXeVarpBqx
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10194"; a="238315634"
X-IronPort-AV: E=Sophos;i="5.88,197,1635231600"; 
   d="scan'208";a="238315634"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 21:35:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,197,1635231600"; 
   d="scan'208";a="544219376"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 10 Dec 2021 21:35:31 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvv2g-0004Ap-QT; Sat, 11 Dec 2021 05:35:30 +0000
Date:   Sat, 11 Dec 2021 13:34:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Fangzhi Zuo <Jerry.Zuo@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: [agd5f:drm-next 205/258]
 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:3248:27:
 error: 'struct dc_debug_options' has no member named 'set_mst_en_for_sst'
Message-ID: <202112111319.i3OFFWLM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   8e00bea4bc1ae98ad8dec7c633175c0afd7ccc0c
commit: 99e574ca64d3b6046b960e06a0b16e7a328b0318 [205/258] drm/amd/display: Add Debugfs Entry to Force in SST Sequence
config: microblaze-randconfig-r014-20211210 (https://download.01.org/0day-ci/archive/20211211/202112111319.i3OFFWLM-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout 99e574ca64d3b6046b960e06a0b16e7a328b0318
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=microblaze SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/amd/amdgpu/../display/dmub/dmub_srv.h:67,
                    from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:33:
   drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h: In function 'dmub_rb_flush_pending':
   drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h:2918:26: warning: variable 'temp' set but not used [-Wunused-but-set-variable]
    2918 |                 uint64_t temp;
         |                          ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c: In function 'dp_force_sst_set':
>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:3248:27: error: 'struct dc_debug_options' has no member named 'set_mst_en_for_sst'
    3248 |         adev->dm.dc->debug.set_mst_en_for_sst = val;
         |                           ^
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c: In function 'dp_force_sst_get':
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:3257:34: error: 'struct dc_debug_options' has no member named 'set_mst_en_for_sst'
    3257 |         *val = adev->dm.dc->debug.set_mst_en_for_sst;
         |                                  ^
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/resource.h:28,
                    from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:34:
   At top level:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:122:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     122 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:121:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     121 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~


vim +3248 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c

  3236	
  3237	DEFINE_DEBUGFS_ATTRIBUTE(disable_hpd_ops, disable_hpd_get,
  3238				 disable_hpd_set, "%llu\n");
  3239	
  3240	/*
  3241	 * Force sst sequence in mst capable receiver.
  3242	 * Example usage: echo 1 > /sys/kernel/debug/dri/0/amdgpu_dm_dp_set_mst_en_for_sst
  3243	 */
  3244	static int dp_force_sst_set(void *data, u64 val)
  3245	{
  3246		struct amdgpu_device *adev = data;
  3247	
> 3248		adev->dm.dc->debug.set_mst_en_for_sst = val;
  3249	
  3250		return 0;
  3251	}
  3252	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
