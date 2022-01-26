Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7DF349C25A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 04:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237387AbiAZDzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 22:55:36 -0500
Received: from mga06.intel.com ([134.134.136.31]:6960 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237380AbiAZDzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 22:55:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643169335; x=1674705335;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=O93prw6CJ5wDa3VU3xPiAEskA2D8fhPmwUdGvdBtYMI=;
  b=BPYPxx60y9S+twnuyOWx3gxERt9I8vT6g1jw8clHA9rIR0kgkpJzeH9N
   hXhOa4bg8eagfRJM3Q5kcFR0+aY2ujltRZT9lM5GWZCkeUricbP/tNq8S
   +2XSQrAb7DtUHZ84hP5gD+tjfHLPqj43pSEVmlnKruILkynfENjCcMlnv
   jSh24bIiLt4ql7AZBBu2lb7BDQ0kW4ubbDN2MTS2NuRTpy80viGkh+0Qw
   e4aeMDooy5EL/thzQzWygZFTvamLdNsQUOkzHY137AlOxwo9Gxlf0v9Jy
   meD1U/r0yAoamKzKkLe+NE+wBUDb+0uEfCu90XP40ft3G4Thf0RRfHQE0
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="307191158"
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="307191158"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 19:55:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="479757727"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 25 Jan 2022 19:55:32 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCZP9-000KlQ-Sq; Wed, 26 Jan 2022 03:55:31 +0000
Date:   Wed, 26 Jan 2022 11:55:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Fangzhi Zuo <Jerry.Zuo@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Hersen Wu <hersenxs.wu@amd.com>
Subject: [agd5f:drm-next 150/190]
 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_mst_types.c:213:6:
 warning: no previous prototype for 'retrieve_downstream_port_device'
Message-ID: <202201261139.VvN01ApM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   63e583c8843f305a3e334a96d5de00435f4d38a2
commit: 09db246ceef70bc6bd9c3e0d02b3c855f8fc25fb [150/190] drm/amd/display: Retrieve MST Downstream Port Status
config: x86_64-buildonly-randconfig-r001-20220124 (https://download.01.org/0day-ci/archive/20220126/202201261139.VvN01ApM-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout 09db246ceef70bc6bd9c3e0d02b3c855f8fc25fb
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_mst_types.c:43:
   drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h: In function 'dmub_rb_flush_pending':
   drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h:2918:12: warning: variable 'temp' set but not used [-Wunused-but-set-variable]
    2918 |   uint64_t temp;
         |            ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_mst_types.c: At top level:
>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_mst_types.c:213:6: warning: no previous prototype for 'retrieve_downstream_port_device' [-Wmissing-prototypes]
     213 | bool retrieve_downstream_port_device(struct amdgpu_dm_connector *aconnector)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/dc_link_ddc.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_mst_types.c:38:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:124:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     124 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:123:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     123 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~


vim +/retrieve_downstream_port_device +213 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_mst_types.c

   212	
 > 213	bool retrieve_downstream_port_device(struct amdgpu_dm_connector *aconnector)
   214	{
   215		union dp_downstream_port_present ds_port_present;
   216	
   217		if (!aconnector->dsc_aux)
   218			return false;
   219	
   220		if (drm_dp_dpcd_read(aconnector->dsc_aux, DP_DOWNSTREAMPORT_PRESENT, &ds_port_present, 1) < 0) {
   221			DRM_INFO("Failed to read downstream_port_present 0x05 from DFP of branch device\n");
   222			return false;
   223		}
   224	
   225		aconnector->mst_downstream_port_present = ds_port_present;
   226		DRM_INFO("Downstream port present %d, type %d\n",
   227				ds_port_present.fields.PORT_PRESENT, ds_port_present.fields.PORT_TYPE);
   228	
   229		return true;
   230	}
   231	#endif
   232	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
