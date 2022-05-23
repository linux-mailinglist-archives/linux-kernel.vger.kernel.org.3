Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891FA531757
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243314AbiEWSsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 14:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243364AbiEWSrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 14:47:39 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DF374DFB
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 11:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653330692; x=1684866692;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vsVMhnWUP6CRAWXVvPo3aXNptIH/Cik7O9y+9qYPjwA=;
  b=bW58AFgABu58BXAwqKGiYd583rIFrS0DFZZd4HmDxCXvVNtQmcGvsLGG
   fuhJMiSr5rZn0JwlcFgKWLUTEHytKcIkRe7QdEa5K9rmEwbdZJh9Vic82
   qCP4Oc6tGXKikd0AumbvSly+9BvqaU+qsSEV8no4qjGWGKTSMt8ictuCv
   6UfteoKPMutdX4WF8dyJi8CE1IvXzXok2GkiKObi0PETU6GFHIM59UyvR
   Aj1GssXJqYd+eBr/bfDc3SCrlfir4AP6Q62qkLagAOycmKc8Ph4CD9dqI
   ay4YzpcFvXuakYiXmDu2a1eSDYgiCbUIa6kQ/g1RL8cpjv0fsdNaG6n5G
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="260925090"
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="260925090"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 11:31:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="558795960"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 23 May 2022 11:31:16 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntCpn-0001M2-Kh;
        Mon, 23 May 2022 18:31:15 +0000
Date:   Tue, 24 May 2022 02:31:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bhanuprakash Modem <bhanuprakash.modem@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@intel.com>,
        Arun R Murthy <arun.r.murthy@intel.com>,
        Harry Wentland <harry.wentland@amd.com>
Subject: [drm-misc:drm-misc-next 1106/1111]
 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:6622:9: error:
 implicit declaration of function 'crtc_debugfs_init'; did you mean
 'amdgpu_debugfs_init'?
Message-ID: <202205240207.KmDLuSrC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
head:   8e71a4a8156a9f3fa27088dc59e852693713d94f
commit: 4cd79f614b501e496ee8e4181d528c0cc1cb4e18 [1106/1111] drm/amd/display: Move connector debugfs to drm
config: alpha-randconfig-r033-20220522 (https://download.01.org/0day-ci/archive/20220524/202205240207.KmDLuSrC-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add drm-misc git://anongit.freedesktop.org/drm/drm-misc
        git fetch --no-tags drm-misc drm-misc-next
        git checkout 4cd79f614b501e496ee8e4181d528c0cc1cb4e18
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: In function 'amdgpu_dm_crtc_late_register':
>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:6622:9: error: implicit declaration of function 'crtc_debugfs_init'; did you mean 'amdgpu_debugfs_init'? [-Werror=implicit-function-declaration]
    6622 |         crtc_debugfs_init(crtc);
         |         ^~~~~~~~~~~~~~~~~
         |         amdgpu_debugfs_init
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: In function 'amdgpu_dm_commit_planes':
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:9165:27: warning: variable 'abo' set but not used [-Wunused-but-set-variable]
    9165 |         struct amdgpu_bo *abo;
         |                           ^~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/link_enc_cfg.h:33,
                    from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:32:
   At top level:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:129:22: warning: 'SYNAPTICS_DEVICE_ID' defined but not used [-Wunused-const-variable=]
     129 | static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
         |                      ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:126:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     126 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:125:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     125 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +6622 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c

e7b07ceef2a650 Harry Wentland 2017-08-10  6619  
e69231c4451ae0 Wayne Lin      2021-03-08  6620  static int amdgpu_dm_crtc_late_register(struct drm_crtc *crtc)
86bc221918925a Wayne Lin      2021-03-02  6621  {
86bc221918925a Wayne Lin      2021-03-02 @6622  	crtc_debugfs_init(crtc);
86bc221918925a Wayne Lin      2021-03-02  6623  
86bc221918925a Wayne Lin      2021-03-02  6624  	return 0;
86bc221918925a Wayne Lin      2021-03-02  6625  }
86bc221918925a Wayne Lin      2021-03-02  6626  

:::::: The code at line 6622 was first introduced by commit
:::::: 86bc221918925a0bbb49043e3936e898e009b43b drm/amd/display: Support crc on specific region

:::::: TO: Wayne Lin <Wayne.Lin@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
