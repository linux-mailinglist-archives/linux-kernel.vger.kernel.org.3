Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F26E4FF4AF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 12:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbiDMKbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 06:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234899AbiDMKbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 06:31:37 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DE9D40
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 03:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649845754; x=1681381754;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OA+98Jt9fvgJ0WjQ+9iA5GSbYWM2KdXUpV4opH+O59I=;
  b=OTZOPZitWrqv1Zu8LcJlOxgmqsfTO6abNLONdO7WOXwJxVV5/ptNJYLf
   GUzXIJaCxLvE/17tUlTpY3cvx+voq3Y5bQvHua03TPqcWpI3I/l6tLEWq
   BHbOR5LuC91+xnnGGrYCsyaDyJsCQSU5XZje2Gw94ocfq9zhm13ofYkJC
   //ObWo6mV5NpgfqAf/iOndiPuLYReDuteXhLA0Fq2dpeLWdyXKuJ30XV4
   A3dI6OwyhQTIPpgCG7H1e8MNmr7cgnIIs0SDl5ndGgeOGmDlJzENyu31B
   6uwc7xt0u5GD0qRXO/0qHbbCvuwC3h47817FO6NwApWMK8+FEmoxGHsiF
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="349068652"
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="349068652"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 03:29:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="724850054"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 13 Apr 2022 03:29:12 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1neaFM-0000DT-3q;
        Wed, 13 Apr 2022 10:29:12 +0000
Date:   Wed, 13 Apr 2022 18:28:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Zhang <dingchen.zhang@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [agd5f:drm-next 162/166]
 drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:798:61:
 error: 'DP_PSR2_WITH_Y_COORD_ET_SUPPORTED' undeclared; did you mean
 'DP_PSR2_WITH_Y_COORD_IS_SUPPORTED'?
Message-ID: <202204131805.RzoAYpTv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   01215dfe2a468234303a465c545abc88d4af9878
commit: 901029aa00171805ca366091a0f604cb8684efca [162/166] drm/amd/display: implement shared PSR-SU sink validation helper
config: sparc64-buildonly-randconfig-r001-20220413 (https://download.01.org/0day-ci/archive/20220413/202204131805.RzoAYpTv-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout 901029aa00171805ca366091a0f604cb8684efca
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc64 SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c: In function 'is_psr_su_specific_panel':
>> drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:798:61: error: 'DP_PSR2_WITH_Y_COORD_ET_SUPPORTED' undeclared (first use in this function); did you mean 'DP_PSR2_WITH_Y_COORD_IS_SUPPORTED'?
     798 |                 if (link->dpcd_caps.psr_info.psr_version >= DP_PSR2_WITH_Y_COORD_ET_SUPPORTED)
         |                                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                                             DP_PSR2_WITH_Y_COORD_IS_SUPPORTED
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:798:61: note: each undeclared identifier is reported only once for each function it appears in
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:29:
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


vim +798 drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c

   786	
   787	/*
   788	 * is_psr_su_specific_panel() - check if sink is AMD vendor-specific PSR-SU
   789	 * supported eDP device.
   790	 *
   791	 * @link: dc link pointer
   792	 *
   793	 * Return: true if AMDGPU vendor specific PSR-SU eDP panel
   794	 */
   795	bool is_psr_su_specific_panel(struct dc_link *link)
   796	{
   797		if (link->dpcd_caps.edp_rev >= DP_EDP_14) {
 > 798			if (link->dpcd_caps.psr_info.psr_version >= DP_PSR2_WITH_Y_COORD_ET_SUPPORTED)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
