Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF4156C61D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 04:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiGIC5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 22:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGIC5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 22:57:23 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882407AB32
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 19:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657335442; x=1688871442;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vRfnR/UD7walTljvNomHTrtOr1kTLnz6WRTX2/mj0lg=;
  b=VjQjS4PZL7m/05SVOCgxYHUhQLrnEldmv9kw65lVg13Jve9X9XBK6P68
   eax/f1vfSuCWM5jqN+jv1SHCObc64blOJVahQzTe3CYPfZCEd9ahfPudV
   Z8THC+9ASUjk6lZP6MJHKnJIdOgyVvRoejgPrtMf7cOJYj4x63yuyDlix
   ZhS7eDnCYt1zrnqb++xgSzonTkx7NHsARfC6gGHAWzK3GqY2Y/iCE965K
   FhSOV0+xe4y/ikBzdMtUyH2c5huOh5dOLtCaqGX9RhNPUSJOd89NlNGN2
   c+LHf7ElLmmnuOLSc2VP2q05PZ35Kev+01/JgxLl+AXqeXbBkfW5K1pAJ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="283156054"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="283156054"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 19:57:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="626899891"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 08 Jul 2022 19:57:19 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oA0el-000OEU-4l;
        Sat, 09 Jul 2022 02:57:19 +0000
Date:   Sat, 9 Jul 2022 10:56:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Rob Clark <robdclark@chromium.org>
Subject: [ammarfaizi2-block:stable/linux-stable-rc/queue/5.15 150/161]
 drivers/gpu/drm/msm/dp/dp_drm.c:16:27: error: field 'bridge' has incomplete
 type
Message-ID: <202207091046.gt1QOj1G-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block stable/linux-stable-rc/queue/5.15
head:   ab88938c957f2e2edc60e19ab6df7830fc1c6914
commit: 17570fbfe787716e607a5496dd44312eab6e733e [150/161] drm/msm/dp: employ bridge mechanism for display enable and disable
config: arm-defconfig (https://download.01.org/0day-ci/archive/20220709/202207091046.gt1QOj1G-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/17570fbfe787716e607a5496dd44312eab6e733e
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block stable/linux-stable-rc/queue/5.15
        git checkout 17570fbfe787716e607a5496dd44312eab6e733e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/msm/dp/dp_drm.c:16:27: error: field 'bridge' has incomplete type
      16 |         struct drm_bridge bridge;
         |                           ^~~~~~
   drivers/gpu/drm/msm/dp/dp_drm.c: In function 'dp_bridge_mode_set':
>> drivers/gpu/drm/msm/dp/dp_drm.c:181:55: error: invalid use of undefined type 'struct drm_bridge'
     181 |         msm_dp_display_mode_set(dp_display, drm_bridge->encoder, mode, adjusted_mode);
         |                                                       ^~
   drivers/gpu/drm/msm/dp/dp_drm.c: In function 'dp_bridge_enable':
   drivers/gpu/drm/msm/dp/dp_drm.c:189:53: error: invalid use of undefined type 'struct drm_bridge'
     189 |         msm_dp_display_enable(dp_display, drm_bridge->encoder);
         |                                                     ^~
   drivers/gpu/drm/msm/dp/dp_drm.c: In function 'dp_bridge_disable':
   drivers/gpu/drm/msm/dp/dp_drm.c:197:58: error: invalid use of undefined type 'struct drm_bridge'
     197 |         msm_dp_display_pre_disable(dp_display, drm_bridge->encoder);
         |                                                          ^~
   drivers/gpu/drm/msm/dp/dp_drm.c: In function 'dp_bridge_post_disable':
   drivers/gpu/drm/msm/dp/dp_drm.c:205:54: error: invalid use of undefined type 'struct drm_bridge'
     205 |         msm_dp_display_disable(dp_display, drm_bridge->encoder);
         |                                                      ^~
   drivers/gpu/drm/msm/dp/dp_drm.c: At top level:
>> drivers/gpu/drm/msm/dp/dp_drm.c:208:21: error: variable 'dp_bridge_ops' has initializer but incomplete type
     208 | static const struct drm_bridge_funcs dp_bridge_ops = {
         |                     ^~~~~~~~~~~~~~~~
>> drivers/gpu/drm/msm/dp/dp_drm.c:209:10: error: 'const struct drm_bridge_funcs' has no member named 'enable'
     209 |         .enable       = dp_bridge_enable,
         |          ^~~~~~
   drivers/gpu/drm/msm/dp/dp_drm.c:209:25: warning: excess elements in struct initializer
     209 |         .enable       = dp_bridge_enable,
         |                         ^~~~~~~~~~~~~~~~
   drivers/gpu/drm/msm/dp/dp_drm.c:209:25: note: (near initialization for 'dp_bridge_ops')
>> drivers/gpu/drm/msm/dp/dp_drm.c:210:10: error: 'const struct drm_bridge_funcs' has no member named 'disable'
     210 |         .disable      = dp_bridge_disable,
         |          ^~~~~~~
   drivers/gpu/drm/msm/dp/dp_drm.c:210:25: warning: excess elements in struct initializer
     210 |         .disable      = dp_bridge_disable,
         |                         ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/msm/dp/dp_drm.c:210:25: note: (near initialization for 'dp_bridge_ops')
>> drivers/gpu/drm/msm/dp/dp_drm.c:211:10: error: 'const struct drm_bridge_funcs' has no member named 'post_disable'
     211 |         .post_disable = dp_bridge_post_disable,
         |          ^~~~~~~~~~~~
   drivers/gpu/drm/msm/dp/dp_drm.c:211:25: warning: excess elements in struct initializer
     211 |         .post_disable = dp_bridge_post_disable,
         |                         ^~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/msm/dp/dp_drm.c:211:25: note: (near initialization for 'dp_bridge_ops')
>> drivers/gpu/drm/msm/dp/dp_drm.c:212:10: error: 'const struct drm_bridge_funcs' has no member named 'mode_set'
     212 |         .mode_set     = dp_bridge_mode_set,
         |          ^~~~~~~~
   drivers/gpu/drm/msm/dp/dp_drm.c:212:25: warning: excess elements in struct initializer
     212 |         .mode_set     = dp_bridge_mode_set,
         |                         ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/msm/dp/dp_drm.c:212:25: note: (near initialization for 'dp_bridge_ops')
   drivers/gpu/drm/msm/dp/dp_drm.c: In function 'msm_dp_bridge_init':
   drivers/gpu/drm/msm/dp/dp_drm.c:229:15: error: invalid use of undefined type 'struct drm_bridge'
     229 |         bridge->funcs = &dp_bridge_ops;
         |               ^~
   drivers/gpu/drm/msm/dp/dp_drm.c:230:15: error: invalid use of undefined type 'struct drm_bridge'
     230 |         bridge->encoder = encoder;
         |               ^~
>> drivers/gpu/drm/msm/dp/dp_drm.c:232:14: error: implicit declaration of function 'drm_bridge_attach'; did you mean 'drm_bridge_detach'? [-Werror=implicit-function-declaration]
     232 |         rc = drm_bridge_attach(encoder, bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
         |              ^~~~~~~~~~~~~~~~~
         |              drm_bridge_detach
>> drivers/gpu/drm/msm/dp/dp_drm.c:232:55: error: 'DRM_BRIDGE_ATTACH_NO_CONNECTOR' undeclared (first use in this function)
     232 |         rc = drm_bridge_attach(encoder, bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
         |                                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/msm/dp/dp_drm.c:232:55: note: each undeclared identifier is reported only once for each function it appears in
   drivers/gpu/drm/msm/dp/dp_drm.c: At top level:
>> drivers/gpu/drm/msm/dp/dp_drm.c:208:38: error: storage size of 'dp_bridge_ops' isn't known
     208 | static const struct drm_bridge_funcs dp_bridge_ops = {
         |                                      ^~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/bridge +16 drivers/gpu/drm/msm/dp/dp_drm.c

    13	
    14	
    15	struct msm_dp_bridge {
  > 16		struct drm_bridge bridge;
    17		struct msm_dp *dp_display;
    18	};
    19	
    20	#define to_dp_display(x)     container_of((x), struct msm_dp_bridge, bridge)
    21	
    22	struct dp_connector {
    23		struct drm_connector base;
    24		struct msm_dp *dp_display;
    25	};
    26	#define to_dp_connector(x) container_of(x, struct dp_connector, base)
    27	
    28	/**
    29	 * dp_connector_detect - callback to determine if connector is connected
    30	 * @conn: Pointer to drm connector structure
    31	 * @force: Force detect setting from drm framework
    32	 * Returns: Connector 'is connected' status
    33	 */
    34	static enum drm_connector_status dp_connector_detect(struct drm_connector *conn,
    35			bool force)
    36	{
    37		struct msm_dp *dp;
    38	
    39		dp = to_dp_connector(conn)->dp_display;
    40	
    41		DRM_DEBUG_DP("is_connected = %s\n",
    42			(dp->is_connected) ? "true" : "false");
    43	
    44		return (dp->is_connected) ? connector_status_connected :
    45						connector_status_disconnected;
    46	}
    47	
    48	/**
    49	 * dp_connector_get_modes - callback to add drm modes via drm_mode_probed_add()
    50	 * @connector: Pointer to drm connector structure
    51	 * Returns: Number of modes added
    52	 */
    53	static int dp_connector_get_modes(struct drm_connector *connector)
    54	{
    55		int rc = 0;
    56		struct msm_dp *dp;
    57		struct dp_display_mode *dp_mode = NULL;
    58		struct drm_display_mode *m, drm_mode;
    59	
    60		if (!connector)
    61			return 0;
    62	
    63		dp = to_dp_connector(connector)->dp_display;
    64	
    65		dp_mode = kzalloc(sizeof(*dp_mode),  GFP_KERNEL);
    66		if (!dp_mode)
    67			return 0;
    68	
    69		/* pluggable case assumes EDID is read when HPD */
    70		if (dp->is_connected) {
    71			/*
    72			 *The get_modes() function might return one mode that is stored
    73			 * in dp_mode when compliance test is in progress. If not, the
    74			 * return value is equal to the total number of modes supported
    75			 * by the sink
    76			 */
    77			rc = dp_display_get_modes(dp, dp_mode);
    78			if (rc <= 0) {
    79				DRM_ERROR("failed to get DP sink modes, rc=%d\n", rc);
    80				kfree(dp_mode);
    81				return rc;
    82			}
    83			if (dp_mode->drm_mode.clock) { /* valid DP mode */
    84				memset(&drm_mode, 0x0, sizeof(drm_mode));
    85				drm_mode_copy(&drm_mode, &dp_mode->drm_mode);
    86				m = drm_mode_duplicate(connector->dev, &drm_mode);
    87				if (!m) {
    88					DRM_ERROR("failed to add mode %ux%u\n",
    89					       drm_mode.hdisplay,
    90					       drm_mode.vdisplay);
    91					kfree(dp_mode);
    92					return 0;
    93				}
    94				drm_mode_probed_add(connector, m);
    95			}
    96		} else {
    97			DRM_DEBUG_DP("No sink connected\n");
    98		}
    99		kfree(dp_mode);
   100		return rc;
   101	}
   102	
   103	/**
   104	 * dp_connector_mode_valid - callback to determine if specified mode is valid
   105	 * @connector: Pointer to drm connector structure
   106	 * @mode: Pointer to drm mode structure
   107	 * Returns: Validity status for specified mode
   108	 */
   109	static enum drm_mode_status dp_connector_mode_valid(
   110			struct drm_connector *connector,
   111			struct drm_display_mode *mode)
   112	{
   113		struct msm_dp *dp_disp;
   114	
   115		dp_disp = to_dp_connector(connector)->dp_display;
   116	
   117		if ((dp_disp->max_pclk_khz <= 0) ||
   118				(dp_disp->max_pclk_khz > DP_MAX_PIXEL_CLK_KHZ) ||
   119				(mode->clock > dp_disp->max_pclk_khz))
   120			return MODE_BAD;
   121	
   122		return dp_display_validate_mode(dp_disp, mode->clock);
   123	}
   124	
   125	static const struct drm_connector_funcs dp_connector_funcs = {
   126		.detect = dp_connector_detect,
   127		.fill_modes = drm_helper_probe_single_connector_modes,
   128		.destroy = drm_connector_cleanup,
   129		.reset = drm_atomic_helper_connector_reset,
   130		.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
   131		.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
   132	};
   133	
   134	static const struct drm_connector_helper_funcs dp_connector_helper_funcs = {
   135		.get_modes = dp_connector_get_modes,
   136		.mode_valid = dp_connector_mode_valid,
   137	};
   138	
   139	/* connector initialization */
   140	struct drm_connector *dp_drm_connector_init(struct msm_dp *dp_display)
   141	{
   142		struct drm_connector *connector = NULL;
   143		struct dp_connector *dp_connector;
   144		int ret;
   145	
   146		dp_connector = devm_kzalloc(dp_display->drm_dev->dev,
   147						sizeof(*dp_connector),
   148						GFP_KERNEL);
   149		if (!dp_connector)
   150			return ERR_PTR(-ENOMEM);
   151	
   152		dp_connector->dp_display = dp_display;
   153	
   154		connector = &dp_connector->base;
   155	
   156		ret = drm_connector_init(dp_display->drm_dev, connector,
   157				&dp_connector_funcs,
   158				DRM_MODE_CONNECTOR_DisplayPort);
   159		if (ret)
   160			return ERR_PTR(ret);
   161	
   162		drm_connector_helper_add(connector, &dp_connector_helper_funcs);
   163	
   164		/*
   165		 * Enable HPD to let hpd event is handled when cable is connected.
   166		 */
   167		connector->polled = DRM_CONNECTOR_POLL_HPD;
   168	
   169		drm_connector_attach_encoder(connector, dp_display->encoder);
   170	
   171		return connector;
   172	}
   173	
   174	static void dp_bridge_mode_set(struct drm_bridge *drm_bridge,
   175					const struct drm_display_mode *mode,
   176					const struct drm_display_mode *adjusted_mode)
   177	{
   178		struct msm_dp_bridge *dp_bridge = to_dp_display(drm_bridge);
   179		struct msm_dp *dp_display = dp_bridge->dp_display;
   180	
 > 181		msm_dp_display_mode_set(dp_display, drm_bridge->encoder, mode, adjusted_mode);
   182	}
   183	
   184	static void dp_bridge_enable(struct drm_bridge *drm_bridge)
   185	{
   186		struct msm_dp_bridge *dp_bridge = to_dp_display(drm_bridge);
   187		struct msm_dp *dp_display = dp_bridge->dp_display;
   188	
   189		msm_dp_display_enable(dp_display, drm_bridge->encoder);
   190	}
   191	
   192	static void dp_bridge_disable(struct drm_bridge *drm_bridge)
   193	{
   194		struct msm_dp_bridge *dp_bridge = to_dp_display(drm_bridge);
   195		struct msm_dp *dp_display = dp_bridge->dp_display;
   196	
   197		msm_dp_display_pre_disable(dp_display, drm_bridge->encoder);
   198	}
   199	
   200	static void dp_bridge_post_disable(struct drm_bridge *drm_bridge)
   201	{
   202		struct msm_dp_bridge *dp_bridge = to_dp_display(drm_bridge);
   203		struct msm_dp *dp_display = dp_bridge->dp_display;
   204	
   205		msm_dp_display_disable(dp_display, drm_bridge->encoder);
   206	}
   207	
 > 208	static const struct drm_bridge_funcs dp_bridge_ops = {
 > 209		.enable       = dp_bridge_enable,
 > 210		.disable      = dp_bridge_disable,
 > 211		.post_disable = dp_bridge_post_disable,
 > 212		.mode_set     = dp_bridge_mode_set,
   213	};
   214	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
