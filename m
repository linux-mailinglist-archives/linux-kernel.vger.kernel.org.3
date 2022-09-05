Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99B95ADBEB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 01:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbiIEXiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 19:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiIEXiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 19:38:05 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2BF286D3
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 16:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662421084; x=1693957084;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6hQ7WSv9evk+u7C9bolbX9ou4yT5TBk3jcTwUUKa1LU=;
  b=gzHsQqt3E4/xmgKTbGLGwJaJX0l8XQHpX3ygnEKdrg/st1txxHQ2NtX5
   1CyTbDRt28T6lD+QYgD7qShvYFpwCI7ymF13kGxx5AT3IRl6RB8evaYxg
   yitJHo3mttkvJErlf2dyfYBytWmBuZ6cObCQX/JaGWhx6Vcy1W1YB3yIV
   y+Yjvq6NE7S5vXhLRNT0kYHg/2BkZ05Cvl1DAlhuRHcvZ5bPNILORMrec
   6RNUfnzttoAkJ5Z3TJp5RpjLDG0ovgbj/V8WHoCEy/rZex85VKh0yBQ28
   7ddXRchD9fO+XcA9i/rh/olHPo7lnpePtsIBdhVginEqoSpUydz8GbO9i
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="294050234"
X-IronPort-AV: E=Sophos;i="5.93,292,1654585200"; 
   d="scan'208";a="294050234"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 16:38:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,292,1654585200"; 
   d="scan'208";a="942242840"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 05 Sep 2022 16:38:02 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oVLfG-0004dT-0Q;
        Mon, 05 Sep 2022 23:38:02 +0000
Date:   Tue, 6 Sep 2022 07:37:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <Harry.Wentland@amd.com>
Subject: [agd5f:drm-next 148/274]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dcn321/dcn321_resource.c:112:29:
 warning: 'DCN_BASE' defined but not used
Message-ID: <202209060758.yrShPqQn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   32d1ffcd3979b75b6d7271a3028f4df2ef181a88
commit: 99c957fedfc6678ded0b53afdcb832cd8446cec8 [148/274] drm/amd/display: change to runtime initialization for reg offsets for DCN321
config: i386-buildonly-randconfig-r004-20220905 (https://download.01.org/0day-ci/archive/20220906/202209060758.yrShPqQn-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout 99c957fedfc6678ded0b53afdcb832cd8446cec8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

         |         ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn321/dcn321_resource.c:651:17: note: in expansion of macro 'HWSEQ_DCN32_MASK_SH_LIST'
     651 |                 HWSEQ_DCN32_MASK_SH_LIST(_MASK)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_3_2_1_sh_mask.h:2823:111: warning: initialized field overwritten [-Woverride-init]
    2823 | #define DOMAIN16_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK                                                      0xC0000000L
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:678:35: note: in expansion of macro 'DOMAIN16_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK'
     678 |         .field_name = blk_name ## reg_name ## __ ## field_name ## post_fix
         |                                   ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn321/dcn321_resource.c:635:9: note: in expansion of macro 'HWS_SF'
     635 |         HWS_SF(, DOMAIN16_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
         |         ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn321/dcn321_resource.c:651:17: note: in expansion of macro 'HWSEQ_DCN32_MASK_SH_LIST'
     651 |                 HWSEQ_DCN32_MASK_SH_LIST(_MASK)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_3_2_1_sh_mask.h:2823:111: note: (near initialization for 'hwseq_mask.DOMAIN_PGFSM_PWR_STATUS')
    2823 | #define DOMAIN16_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK                                                      0xC0000000L
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:678:35: note: in expansion of macro 'DOMAIN16_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK'
     678 |         .field_name = blk_name ## reg_name ## __ ## field_name ## post_fix
         |                                   ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn321/dcn321_resource.c:635:9: note: in expansion of macro 'HWS_SF'
     635 |         HWS_SF(, DOMAIN16_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
         |         ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn321/dcn321_resource.c:651:17: note: in expansion of macro 'HWSEQ_DCN32_MASK_SH_LIST'
     651 |                 HWSEQ_DCN32_MASK_SH_LIST(_MASK)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_3_2_1_sh_mask.h:2833:111: warning: initialized field overwritten [-Woverride-init]
    2833 | #define DOMAIN17_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK                                                      0xC0000000L
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:678:35: note: in expansion of macro 'DOMAIN17_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK'
     678 |         .field_name = blk_name ## reg_name ## __ ## field_name ## post_fix
         |                                   ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn321/dcn321_resource.c:636:9: note: in expansion of macro 'HWS_SF'
     636 |         HWS_SF(, DOMAIN17_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
         |         ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn321/dcn321_resource.c:651:17: note: in expansion of macro 'HWSEQ_DCN32_MASK_SH_LIST'
     651 |                 HWSEQ_DCN32_MASK_SH_LIST(_MASK)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_3_2_1_sh_mask.h:2833:111: note: (near initialization for 'hwseq_mask.DOMAIN_PGFSM_PWR_STATUS')
    2833 | #define DOMAIN17_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK                                                      0xC0000000L
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:678:35: note: in expansion of macro 'DOMAIN17_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK'
     678 |         .field_name = blk_name ## reg_name ## __ ## field_name ## post_fix
         |                                   ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn321/dcn321_resource.c:636:9: note: in expansion of macro 'HWS_SF'
     636 |         HWS_SF(, DOMAIN17_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
         |         ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn321/dcn321_resource.c:651:17: note: in expansion of macro 'HWSEQ_DCN32_MASK_SH_LIST'
     651 |                 HWSEQ_DCN32_MASK_SH_LIST(_MASK)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_3_2_1_sh_mask.h:2843:111: warning: initialized field overwritten [-Woverride-init]
    2843 | #define DOMAIN18_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK                                                      0xC0000000L
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:678:35: note: in expansion of macro 'DOMAIN18_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK'
     678 |         .field_name = blk_name ## reg_name ## __ ## field_name ## post_fix
         |                                   ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn321/dcn321_resource.c:637:9: note: in expansion of macro 'HWS_SF'
     637 |         HWS_SF(, DOMAIN18_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
         |         ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn321/dcn321_resource.c:651:17: note: in expansion of macro 'HWSEQ_DCN32_MASK_SH_LIST'
     651 |                 HWSEQ_DCN32_MASK_SH_LIST(_MASK)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_3_2_1_sh_mask.h:2843:111: note: (near initialization for 'hwseq_mask.DOMAIN_PGFSM_PWR_STATUS')
    2843 | #define DOMAIN18_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK                                                      0xC0000000L
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:678:35: note: in expansion of macro 'DOMAIN18_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK'
     678 |         .field_name = blk_name ## reg_name ## __ ## field_name ## post_fix
         |                                   ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn321/dcn321_resource.c:637:9: note: in expansion of macro 'HWS_SF'
     637 |         HWS_SF(, DOMAIN18_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
         |         ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn321/dcn321_resource.c:651:17: note: in expansion of macro 'HWSEQ_DCN32_MASK_SH_LIST'
     651 |                 HWSEQ_DCN32_MASK_SH_LIST(_MASK)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_3_2_1_sh_mask.h:2853:111: warning: initialized field overwritten [-Woverride-init]
    2853 | #define DOMAIN19_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK                                                      0xC0000000L
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:678:35: note: in expansion of macro 'DOMAIN19_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK'
     678 |         .field_name = blk_name ## reg_name ## __ ## field_name ## post_fix
         |                                   ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn321/dcn321_resource.c:638:9: note: in expansion of macro 'HWS_SF'
     638 |         HWS_SF(, DOMAIN19_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
         |         ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn321/dcn321_resource.c:651:17: note: in expansion of macro 'HWSEQ_DCN32_MASK_SH_LIST'
     651 |                 HWSEQ_DCN32_MASK_SH_LIST(_MASK)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_3_2_1_sh_mask.h:2853:111: note: (near initialization for 'hwseq_mask.DOMAIN_PGFSM_PWR_STATUS')
    2853 | #define DOMAIN19_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK                                                      0xC0000000L
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:678:35: note: in expansion of macro 'DOMAIN19_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK'
     678 |         .field_name = blk_name ## reg_name ## __ ## field_name ## post_fix
         |                                   ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn321/dcn321_resource.c:638:9: note: in expansion of macro 'HWS_SF'
     638 |         HWS_SF(, DOMAIN19_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
         |         ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn321/dcn321_resource.c:651:17: note: in expansion of macro 'HWSEQ_DCN32_MASK_SH_LIST'
     651 |                 HWSEQ_DCN32_MASK_SH_LIST(_MASK)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn321/dcn321_resource.c:112:29: warning: 'DCN_BASE' defined but not used [-Wunused-const-variable=]
     112 | static const struct IP_BASE DCN_BASE = { { { { 0x00000012, 0x000000C0, 0x000034C0, 0x00009000, 0x02403C00, 0 } },
         |                             ^~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/resource.h:28,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn321/dcn321_resource.c:32:
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


vim +/DCN_BASE +112 drivers/gpu/drm/amd/amdgpu/../display/dc/dcn321/dcn321_resource.c

265280b99822e5 Aurabindo Pillai 2022-02-21  111  
265280b99822e5 Aurabindo Pillai 2022-02-21 @112  static const struct IP_BASE DCN_BASE = { { { { 0x00000012, 0x000000C0, 0x000034C0, 0x00009000, 0x02403C00, 0 } },
265280b99822e5 Aurabindo Pillai 2022-02-21  113  					{ { 0, 0, 0, 0, 0, 0 } },
265280b99822e5 Aurabindo Pillai 2022-02-21  114  					{ { 0, 0, 0, 0, 0, 0 } },
265280b99822e5 Aurabindo Pillai 2022-02-21  115  					{ { 0, 0, 0, 0, 0, 0 } },
265280b99822e5 Aurabindo Pillai 2022-02-21  116  					{ { 0, 0, 0, 0, 0, 0 } },
265280b99822e5 Aurabindo Pillai 2022-02-21  117  					{ { 0, 0, 0, 0, 0, 0 } },
265280b99822e5 Aurabindo Pillai 2022-02-21  118  					{ { 0, 0, 0, 0, 0, 0 } },
265280b99822e5 Aurabindo Pillai 2022-02-21  119  					{ { 0, 0, 0, 0, 0, 0 } } } };
265280b99822e5 Aurabindo Pillai 2022-02-21  120  

:::::: The code at line 112 was first introduced by commit
:::::: 265280b99822e5562eb431b102f2ba773c7b2a0a drm/amd/display: add CLKMGR changes for DCN32/321

:::::: TO: Aurabindo Pillai <aurabindo.pillai@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
