Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE52572BC8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 05:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbiGMDNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 23:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiGMDNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 23:13:47 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE53CDF23
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 20:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657682025; x=1689218025;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uP01vqSzXfDRLqj0Aj7fiPbmaBHyJAW3yMATe1WpWMc=;
  b=i3zJCaMDj55v1a/3/ZzCakz4cSqmw8IS41YpC2QAYrSJ9DkTlZw2X2iV
   Ll9wwL87P/6h1oa3mQmbhwGSn9oF0p+VQj2DV6VT9QxhXxc1rNZi8YUAe
   lcXifEPQOVxpUyvNa77FP6eaoJtv4REKNqA8g2pA+y+MJC8UkZP/LYa7b
   7loZVpUpgLNC6reSJ4OLfCzwHEShBJTBFUp11W4KfdSw9EaSUBy1ixRTm
   VLkO1KjOrJiLOz8vJl++p1qdzqSPDXPYVbtH1Sk++EL01MpJNOSq2JCPA
   1MSUIutJkH7zwvdYa5+QM3wjQv+FpvR96UNH0XRjHbckBmhFPvYMP3ty8
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="285842957"
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="285842957"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 20:13:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="628133485"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 12 Jul 2022 20:13:44 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBSop-00030t-IC;
        Wed, 13 Jul 2022 03:13:43 +0000
Date:   Wed, 13 Jul 2022 11:13:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Fangzhi Zuo <Jerry.Zuo@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [agd5f:drm-next 423/465]
 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:1427:6: warning:
 no previous prototype for 'retrieve_dmi_info'
Message-ID: <202207131128.zyQigy2v-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   0365a66ae4438923eb981c265a2152cc95e89c91
commit: 19a459dfedd49deef6cd3169597df1b414c65f10 [423/465] drm/amd/display: Ignore First MST Sideband Message Return Error
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220713/202207131128.zyQigy2v-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout 19a459dfedd49deef6cd3169597df1b414c65f10
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:1427:6: warning: no previous prototype for 'retrieve_dmi_info' [-Wmissing-prototypes]
    1427 | void retrieve_dmi_info(struct amdgpu_display_manager *dm)
         |      ^~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/link_enc_cfg.h:33,
                    from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:32:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:137:22: warning: 'SYNAPTICS_DEVICE_ID' defined but not used [-Wunused-const-variable=]
     137 | static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
         |                      ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:134:17: warning: 'DP_SINK_BRANCH_DEV_NAME_7580' defined but not used [-Wunused-const-variable=]
     134 | static const u8 DP_SINK_BRANCH_DEV_NAME_7580[] = "7580\x80u";
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:132:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     132 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:131:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     131 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~


vim +/retrieve_dmi_info +1427 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c

  1426	
> 1427	void retrieve_dmi_info(struct amdgpu_display_manager *dm)
  1428	{
  1429		const struct dmi_system_id *dmi_id;
  1430	
  1431		dm->aux_hpd_discon_quirk = false;
  1432	
  1433		dmi_id = dmi_first_match(hpd_disconnect_quirk_table);
  1434		if (dmi_id) {
  1435			dm->aux_hpd_discon_quirk = true;
  1436			DRM_INFO("aux_hpd_discon_quirk attached\n");
  1437		}
  1438	}
  1439	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
