Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C424FED9E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 05:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbiDMDg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 23:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiDMDgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 23:36:53 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3728B0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 20:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649820872; x=1681356872;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=nnpBGMaA634MUkOuD/3RJmlH+ANNdGClFShNfoaQxxo=;
  b=iV7W4HHen2FKYm7C2fe7vpH+/nz8GYbNCj0DDlHNqe1yMm2uVgiOpLs0
   1LTgWbffCWueVoG0F3hSLQDDCWhYW/JgVdr6GIfJbVyUUXZDF9ahBJYN6
   4pSIXDnHNOdN4A1NqZTb5LLPXFcWzXC4fJAhuy9eUyZWjzlGl4stcHCby
   9sMPg9khvwjTpBxQ0nUVtdT2+QrYTJjt3b8YlaP7nW09GxO0dfmiShqza
   bsgkI167zELhJ5s8D565B5wUQa0cCK6hNI8TZDUyY0+BAE+Pa4vl2XZE1
   TKa1FotMB0ePqMaX8GPmb/leSgwZFpVerpdb5WovBVnxX9mZeojBRaLTB
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="323005834"
X-IronPort-AV: E=Sophos;i="5.90,255,1643702400"; 
   d="scan'208";a="323005834"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 20:34:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,255,1643702400"; 
   d="scan'208";a="507812806"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 12 Apr 2022 20:34:30 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1neTm1-0003Os-MB;
        Wed, 13 Apr 2022 03:34:29 +0000
Date:   Wed, 13 Apr 2022 11:33:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dominik Behr <dbehr@chromium.org>,
        =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>
Subject: [jsarha:topic/cros-sof-v4.14 835/9354]
 drivers/gpu/drm/i915/intel_display.c:5249:24: error: variable 'conn' set but
 not used
Message-ID: <202204131116.AR9J6kE7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maarten,

FYI, the error/warning still remains.

tree:   https://github.com/jsarha/linux topic/cros-sof-v4.14
head:   6f750b16c322c9191168a3a97c427c90581d9144
commit: 17de7cbd45ef192faed9f7f17ddc8fe9155645b4 [835/9354] UPSTREAM: drm/atomic: Make atomic iterators less surprising
config: i386-randconfig-a011-20220411 (https://download.01.org/0day-ci/archive/20220413/202204131116.AR9J6kE7-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build):
        # https://github.com/jsarha/linux/commit/17de7cbd45ef192faed9f7f17ddc8fe9155645b4
        git remote add jsarha https://github.com/jsarha/linux
        git fetch --no-tags jsarha topic/cros-sof-v4.14
        git checkout 17de7cbd45ef192faed9f7f17ddc8fe9155645b4
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/i915/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/gpu/drm/i915/intel_display.c: In function '__intel_display_resume':
   drivers/gpu/drm/i915/intel_display.c:3656:19: error: variable 'crtc' set but not used [-Werror=unused-but-set-variable]
     struct drm_crtc *crtc;
                      ^~~~
   drivers/gpu/drm/i915/intel_display.c: In function 'intel_encoders_pre_pll_enable':
>> drivers/gpu/drm/i915/intel_display.c:5249:24: error: variable 'conn' set but not used [-Werror=unused-but-set-variable]
     struct drm_connector *conn;
                           ^~~~
   drivers/gpu/drm/i915/intel_display.c: In function 'intel_encoders_pre_enable':
   drivers/gpu/drm/i915/intel_display.c:5269:24: error: variable 'conn' set but not used [-Werror=unused-but-set-variable]
     struct drm_connector *conn;
                           ^~~~
   drivers/gpu/drm/i915/intel_display.c: In function 'intel_encoders_enable':
   drivers/gpu/drm/i915/intel_display.c:5289:24: error: variable 'conn' set but not used [-Werror=unused-but-set-variable]
     struct drm_connector *conn;
                           ^~~~
   drivers/gpu/drm/i915/intel_display.c: In function 'intel_encoders_disable':
   drivers/gpu/drm/i915/intel_display.c:5309:24: error: variable 'conn' set but not used [-Werror=unused-but-set-variable]
     struct drm_connector *conn;
                           ^~~~
   drivers/gpu/drm/i915/intel_display.c: In function 'intel_encoders_post_disable':
   drivers/gpu/drm/i915/intel_display.c:5329:24: error: variable 'conn' set but not used [-Werror=unused-but-set-variable]
     struct drm_connector *conn;
                           ^~~~
   drivers/gpu/drm/i915/intel_display.c: In function 'intel_encoders_post_pll_disable':
   drivers/gpu/drm/i915/intel_display.c:5349:24: error: variable 'conn' set but not used [-Werror=unused-but-set-variable]
     struct drm_connector *conn;
                           ^~~~
   drivers/gpu/drm/i915/intel_display.c: In function 'chv_prepare_pll':
   drivers/gpu/drm/i915/intel_display.c:6776:13: error: variable 'bestm1' set but not used [-Werror=unused-but-set-variable]
     u32 bestn, bestm1, bestm2, bestp1, bestp2, bestm2_frac;
                ^~~~~~
   drivers/gpu/drm/i915/intel_display.c:6776:6: error: variable 'bestn' set but not used [-Werror=unused-but-set-variable]
     u32 bestn, bestm1, bestm2, bestp1, bestp2, bestm2_frac;
         ^~~~~
   drivers/gpu/drm/i915/intel_display.c: In function 'i9xx_get_initial_plane_config':
   drivers/gpu/drm/i915/intel_display.c:7500:17: error: variable 'offset' set but not used [-Werror=unused-but-set-variable]
     u32 val, base, offset;
                    ^~~~~~
   drivers/gpu/drm/i915/intel_display.c: In function 'skylake_get_initial_plane_config':
   drivers/gpu/drm/i915/intel_display.c:8526:17: error: variable 'offset' set but not used [-Werror=unused-but-set-variable]
     u32 val, base, offset, stride_mult, tiling;
                    ^~~~~~
   drivers/gpu/drm/i915/intel_display.c: In function 'ironlake_get_initial_plane_config':
   drivers/gpu/drm/i915/intel_display.c:8638:17: error: variable 'offset' set but not used [-Werror=unused-but-set-variable]
     u32 val, base, offset;
                    ^~~~~~
   drivers/gpu/drm/i915/intel_display.c: In function 'check_single_encoder_cloning':
>> drivers/gpu/drm/i915/intel_display.c:10472:24: error: variable 'connector' set but not used [-Werror=unused-but-set-variable]
     struct drm_connector *connector;
                           ^~~~~~~~~
   drivers/gpu/drm/i915/intel_display.c: In function 'intel_modeset_pipe_config':
   drivers/gpu/drm/i915/intel_display.c:10892:24: error: variable 'connector' set but not used [-Werror=unused-but-set-variable]
     struct drm_connector *connector;
                           ^~~~~~~~~
   drivers/gpu/drm/i915/intel_display.c: In function 'verify_encoder_state':
   drivers/gpu/drm/i915/intel_display.c:11520:24: error: variable 'connector' set but not used [-Werror=unused-but-set-variable]
     struct drm_connector *connector;
                           ^~~~~~~~~
   drivers/gpu/drm/i915/intel_display.c: In function 'sanitize_watermarks':
   drivers/gpu/drm/i915/intel_display.c:14419:19: error: variable 'crtc' set but not used [-Werror=unused-but-set-variable]
     struct drm_crtc *crtc;
                      ^~~~
   In file included from include/uapi/linux/stddef.h:2:0,
                    from include/linux/stddef.h:5,
                    from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/list.h:5,
                    from include/linux/dmi.h:5,
                    from drivers/gpu/drm/i915/intel_display.c:27:
   drivers/gpu/drm/i915/intel_drv.h: In function 'enc_to_dig_port':
   include/linux/compiler.h:176:22: error: this statement may fall through [-Werror=implicit-fallthrough=]
    # define unlikely(x) __builtin_expect(!!(x), 0)
                         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/bug.h:120:2: note: in expansion of macro 'unlikely'
     unlikely(__ret_warn_on);     \
     ^~~~~~~~
   drivers/gpu/drm/i915/i915_utils.h:37:20: note: in expansion of macro 'WARN'
    #define WARN_ON(x) WARN((x), "%s", "WARN_ON(" __stringify(x) ")")
                       ^~~~
   drivers/gpu/drm/i915/intel_drv.h:1151:3: note: in expansion of macro 'WARN_ON'
      WARN_ON(!HAS_DDI(to_i915(encoder->dev)));
      ^~~~~~~
   In file included from drivers/gpu/drm/i915/intel_display.c:36:0:
   drivers/gpu/drm/i915/intel_drv.h:1152:2: note: here
     case INTEL_OUTPUT_DP:
     ^~~~
   In file included from include/uapi/linux/stddef.h:2:0,
                    from include/linux/stddef.h:5,
                    from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/list.h:5,
                    from include/linux/dmi.h:5,
                    from drivers/gpu/drm/i915/intel_display.c:27:
   drivers/gpu/drm/i915/intel_display.c: In function 'hsw_get_transcoder_state':
   include/linux/compiler.h:176:22: error: this statement may fall through [-Werror=implicit-fallthrough=]
    # define unlikely(x) __builtin_expect(!!(x), 0)
                         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/bug.h:120:2: note: in expansion of macro 'unlikely'
     unlikely(__ret_warn_on);     \
     ^~~~~~~~
   drivers/gpu/drm/i915/intel_display.c:9150:4: note: in expansion of macro 'WARN'
       WARN(1, "unknown pipe linked to edp transcoder\n");
       ^~~~
   drivers/gpu/drm/i915/intel_display.c:9151:3: note: here
      case TRANS_DDI_EDP_INPUT_A_ONOFF:
      ^~~~
   drivers/gpu/drm/i915/intel_display.c: In function 'check_digital_port_conflicts':
   drivers/gpu/drm/i915/intel_display.c:10818:7: error: this statement may fall through [-Werror=implicit-fallthrough=]
       if (WARN_ON(!HAS_DDI(to_i915(dev))))
          ^
   drivers/gpu/drm/i915/intel_display.c:10820:3: note: here
      case INTEL_OUTPUT_DP:
      ^~~~
   cc1: all warnings being treated as errors
--
   drivers/gpu/drm/i915/intel_ddi.c: In function 'intel_ddi_get_crtc_new_encoder':
>> drivers/gpu/drm/i915/intel_ddi.c:988:24: error: variable 'connector' set but not used [-Werror=unused-but-set-variable]
     struct drm_connector *connector;
                           ^~~~~~~~~
   In file included from include/uapi/linux/stddef.h:2:0,
                    from include/linux/stddef.h:5,
                    from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/uapi/drm/drm.h:41,
                    from include/uapi/drm/i915_drm.h:30,
                    from drivers/gpu/drm/i915/i915_drv.h:33,
                    from drivers/gpu/drm/i915/intel_ddi.c:28:
   drivers/gpu/drm/i915/intel_drv.h: In function 'enc_to_dig_port':
   include/linux/compiler.h:176:22: error: this statement may fall through [-Werror=implicit-fallthrough=]
    # define unlikely(x) __builtin_expect(!!(x), 0)
                         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/bug.h:120:2: note: in expansion of macro 'unlikely'
     unlikely(__ret_warn_on);     \
     ^~~~~~~~
   drivers/gpu/drm/i915/i915_utils.h:37:20: note: in expansion of macro 'WARN'
    #define WARN_ON(x) WARN((x), "%s", "WARN_ON(" __stringify(x) ")")
                       ^~~~
   drivers/gpu/drm/i915/intel_drv.h:1151:3: note: in expansion of macro 'WARN_ON'
      WARN_ON(!HAS_DDI(to_i915(encoder->dev)));
      ^~~~~~~
   In file included from drivers/gpu/drm/i915/i915_trace.h:11:0,
                    from drivers/gpu/drm/i915/i915_drv.h:3130,
                    from drivers/gpu/drm/i915/intel_ddi.c:28:
   drivers/gpu/drm/i915/intel_drv.h:1152:2: note: here
     case INTEL_OUTPUT_DP:
     ^~~~
   cc1: all warnings being treated as errors


vim +/conn +5249 drivers/gpu/drm/i915/intel_display.c

a5c4d7bc187bd13 Ville Syrjälä     2014-03-07  5243  
fb1c98b181ae139 Maarten Lankhorst 2016-08-09  5244  static void intel_encoders_pre_pll_enable(struct drm_crtc *crtc,
fd6bbda9c7a46be Maarten Lankhorst 2016-08-09  5245  					  struct intel_crtc_state *crtc_state,
fb1c98b181ae139 Maarten Lankhorst 2016-08-09  5246  					  struct drm_atomic_state *old_state)
fb1c98b181ae139 Maarten Lankhorst 2016-08-09  5247  {
aa5e9b47b90156f Maarten Lankhorst 2017-03-09  5248  	struct drm_connector_state *conn_state;
fb1c98b181ae139 Maarten Lankhorst 2016-08-09 @5249  	struct drm_connector *conn;
fb1c98b181ae139 Maarten Lankhorst 2016-08-09  5250  	int i;
fb1c98b181ae139 Maarten Lankhorst 2016-08-09  5251  
aa5e9b47b90156f Maarten Lankhorst 2017-03-09  5252  	for_each_new_connector_in_state(old_state, conn, conn_state, i) {
fb1c98b181ae139 Maarten Lankhorst 2016-08-09  5253  		struct intel_encoder *encoder =
fb1c98b181ae139 Maarten Lankhorst 2016-08-09  5254  			to_intel_encoder(conn_state->best_encoder);
fb1c98b181ae139 Maarten Lankhorst 2016-08-09  5255  
fb1c98b181ae139 Maarten Lankhorst 2016-08-09  5256  		if (conn_state->crtc != crtc)
fb1c98b181ae139 Maarten Lankhorst 2016-08-09  5257  			continue;
fb1c98b181ae139 Maarten Lankhorst 2016-08-09  5258  
fb1c98b181ae139 Maarten Lankhorst 2016-08-09  5259  		if (encoder->pre_pll_enable)
fd6bbda9c7a46be Maarten Lankhorst 2016-08-09  5260  			encoder->pre_pll_enable(encoder, crtc_state, conn_state);
fb1c98b181ae139 Maarten Lankhorst 2016-08-09  5261  	}
fb1c98b181ae139 Maarten Lankhorst 2016-08-09  5262  }
fb1c98b181ae139 Maarten Lankhorst 2016-08-09  5263  

:::::: The code at line 5249 was first introduced by commit
:::::: fb1c98b181ae139412eca6b7ef727b655b6125da drm/i915: Walk over encoders in crtc enable/disable using atomic state.

:::::: TO: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
:::::: CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
