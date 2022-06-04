Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22AF853D744
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 16:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236877AbiFDOho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 10:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbiFDOhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 10:37:42 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483971C124
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 07:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654353461; x=1685889461;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5O/XZex4hWTIl3kWl2+aVwPSjJtWZV8c2J6eJuTjE3c=;
  b=K/R2j4cBoebfXmoU2wfqDpXqagK3LGrMTryzqfq0znPFDQZnA9ntZVg/
   +1PBi1elTl/UzNpCohfSrTU+9yN+jENHQ+esCZgUjjdv9LE3P3xMUo8ad
   uzQVug3nr4YMoWc8hg26kPXHgTS5WWu2QMDNpYVWGItm1EMIhWo6sGqbe
   KxYVIn+3KpxCtBffRHoau7LRr4aepb3uq6M0PCL6woYogeTlfdkFA0Lrp
   US4DsoN1KoB6O5xFN4DMUX0Vwmt0qrEBK3jlJlUHBJvF4sugAyoAFV2bm
   8zSsUwz5kvjHopGEblYKqu0X+DwFpWwV9NIhM4W/3u7lhBa2JQBB4ZGO4
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10368"; a="339515314"
X-IronPort-AV: E=Sophos;i="5.91,277,1647327600"; 
   d="scan'208";a="339515314"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 07:37:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,277,1647327600"; 
   d="scan'208";a="613665843"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 04 Jun 2022 07:37:39 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxUuJ-000Awr-5n;
        Sat, 04 Jun 2022 14:37:39 +0000
Date:   Sat, 4 Jun 2022 22:36:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Eric Bernstein <eric.bernstein@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [agd5f:drm-next 44/63]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_dccg.c:180:6: warning:
 no previous prototype for 'dccg32_set_valid_pixel_rate'
Message-ID: <202206042226.yKcIBQny-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   0401cdad37f8a62e64363b2a6fc16c7fafba66e2
commit: 0fa8930c48889344f93251e749deb8fa0257532d [44/63] drm/amd/display: Use DTBCLK for valid pixel clock
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220604/202206042226.yKcIBQny-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout 0fa8930c48889344f93251e749deb8fa0257532d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_dccg.c:136:6: warning: no previous prototype for 'dccg32_set_dtbclk_dto' [-Wmissing-prototypes]
     136 | void dccg32_set_dtbclk_dto(
         |      ^~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_dccg.c:180:6: warning: no previous prototype for 'dccg32_set_valid_pixel_rate' [-Wmissing-prototypes]
     180 | void dccg32_set_valid_pixel_rate(
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_dccg.c:205:6: warning: no previous prototype for 'dccg32_set_dpstreamclk' [-Wmissing-prototypes]
     205 | void dccg32_set_dpstreamclk(
         |      ^~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_dccg.c:241:6: warning: no previous prototype for 'dccg32_otg_add_pixel' [-Wmissing-prototypes]
     241 | void dccg32_otg_add_pixel(struct dccg *dccg,
         |      ^~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_dccg.c:250:6: warning: no previous prototype for 'dccg32_otg_drop_pixel' [-Wmissing-prototypes]
     250 | void dccg32_otg_drop_pixel(struct dccg *dccg,
         |      ^~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_dccg.c:27:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:133:22: warning: 'SYNAPTICS_DEVICE_ID' defined but not used [-Wunused-const-variable=]
     133 | static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
         |                      ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:130:17: warning: 'DP_SINK_BRANCH_DEV_NAME_7580' defined but not used [-Wunused-const-variable=]
     130 | static const u8 DP_SINK_BRANCH_DEV_NAME_7580[] = "7580\x80u";
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:128:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     128 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:127:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     127 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~


vim +/dccg32_set_valid_pixel_rate +180 drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_dccg.c

   179	
 > 180	void dccg32_set_valid_pixel_rate(
   181			struct dccg *dccg,
   182			int otg_inst,
   183			int pixclk_khz)
   184	{
   185		struct dtbclk_dto_params dto_params = {0};
   186	
   187		dto_params.otg_inst = otg_inst;
   188		dto_params.pixclk_khz = pixclk_khz;
   189	
   190		dccg32_set_dtbclk_dto(dccg, &dto_params);
   191	}
   192	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
