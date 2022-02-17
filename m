Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24DF4B9E6A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 12:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239566AbiBQLNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 06:13:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237292AbiBQLNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 06:13:02 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5578F1DE8BC
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 03:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645096368; x=1676632368;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=GPc2Mj4vYsSyg75XymveCSqM6Gq4FpwCsmBE7NayWbk=;
  b=R40z/y7p1HchznM4/xSd93QJKO9F/0QtVhmcoA8QAJnaPXSuJUwnMva4
   Zv386VaB+SrjmFEiis+UfTES9kaZVETDr/4u89d53Y77DQKVi4B1zG6si
   Ikp4kqhoFCEAR2vEXcS2DliRT5ky9UrOP3d/9Y4cEW1/cT7K9J+O5v+el
   vNRQrlCDkL7fM2EYfgjat2o8bJPFT9eMwLjrNoh6NUUHc+AvNBpJuJaXc
   /8dlJiFJwyUDJpyZYtmdV5Vx/aM1JLPhqtr5Hmuzdd0OIcZnArTrQ+uLN
   fHkLKfbJA8Vgbp8SwJaW9LHxBzPAShOBc7u4zdIgvhbBTHOvTsoqd7YKj
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="234380838"
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="234380838"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 03:12:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="503457682"
Received: from lkp-server01.sh.intel.com (HELO 6f05bf9e3301) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 17 Feb 2022 03:12:46 -0800
Received: from kbuild by 6f05bf9e3301 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKeiL-00006R-I5; Thu, 17 Feb 2022 11:12:45 +0000
Date:   Thu, 17 Feb 2022 19:12:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Roman Li <Roman.Li@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Hersen Wu <hersenwu@amd.com>
Subject: [agd5f:drm-next 44/66]
 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:6353:1: warning:
 no previous prototype for 'create_stream_for_sink'
Message-ID: <202202171946.tVfOp3up-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   5bbebaae14913a4180ff0cc7ddccfa177dba9705
commit: 17ce8a6907f77b7ac97ddaa071d8a1f6e06ce85b [44/66] drm/amd/display: Add dsc pre-validation in atomic check
config: microblaze-buildonly-randconfig-r003-20220216 (https://download.01.org/0day-ci/archive/20220217/202202171946.tVfOp3up-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout 17ce8a6907f77b7ac97ddaa071d8a1f6e06ce85b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=microblaze SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/amd/amdgpu/../display/dmub/dmub_srv.h:67,
                    from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:35:
   drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h: In function 'dmub_rb_flush_pending':
   drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h:2921:26: warning: variable 'temp' set but not used [-Wunused-but-set-variable]
    2921 |                 uint64_t temp;
         |                          ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: At top level:
>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:6353:1: warning: no previous prototype for 'create_stream_for_sink' [-Wmissing-prototypes]
    6353 | create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
         | ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:10179:5: warning: no previous prototype for 'dm_update_crtc_state' [-Wmissing-prototypes]
   10179 | int dm_update_crtc_state(struct amdgpu_display_manager *dm,
         |     ^~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/link_enc_cfg.h:33,
                    from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:32:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:127:22: warning: 'SYNAPTICS_DEVICE_ID' defined but not used [-Wunused-const-variable=]
     127 | static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
         |                      ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:124:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     124 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:123:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     123 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
--
>> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:1617:6: warning: no previous prototype for 'is_timing_changed' [-Wmissing-prototypes]
    1617 | bool is_timing_changed(struct dc_stream_state *cur_stream,
         |      ^~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/resource.h:28,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:30:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:127:22: warning: 'SYNAPTICS_DEVICE_ID' defined but not used [-Wunused-const-variable=]
     127 | static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
         |                      ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:124:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     124 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:123:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     123 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~


vim +/create_stream_for_sink +6353 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c

a85ba00538cd4bb Nikola Cornij       2021-03-15  6351  
17ce8a6907f77b7 Roman Li            2022-01-28  6352  struct dc_stream_state *
3ee6b26b78e4782 Alex Deucher        2017-10-10 @6353  create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
e7b07ceef2a650e Harry Wentland      2017-08-10  6354  		       const struct drm_display_mode *drm_mode,
b333730d126efcc Bhawanpreet Lakha   2018-11-16  6355  		       const struct dm_connector_state *dm_state,
cbd14ae7ea934fd Stylon Wang         2020-04-30  6356  		       const struct dc_stream_state *old_stream,
cbd14ae7ea934fd Stylon Wang         2020-04-30  6357  		       int requested_bpc)
e7b07ceef2a650e Harry Wentland      2017-08-10  6358  {
e7b07ceef2a650e Harry Wentland      2017-08-10  6359  	struct drm_display_mode *preferred_mode = NULL;
391ef035200f8c3 Jerry (Fangzhi  Zuo 2017-12-01  6360) 	struct drm_connector *drm_connector;
42ba01fc30e6f84 Nicholas Kazlauskas 2019-05-22  6361  	const struct drm_connector_state *con_state =
42ba01fc30e6f84 Nicholas Kazlauskas 2019-05-22  6362  		dm_state ? &dm_state->base : NULL;
0971c40e180696c Harry Wentland      2017-07-27  6363  	struct dc_stream_state *stream = NULL;
e7b07ceef2a650e Harry Wentland      2017-08-10  6364  	struct drm_display_mode mode = *drm_mode;
a85ba00538cd4bb Nikola Cornij       2021-03-15  6365  	struct drm_display_mode saved_mode;
a85ba00538cd4bb Nikola Cornij       2021-03-15  6366  	struct drm_display_mode *freesync_mode = NULL;
e7b07ceef2a650e Harry Wentland      2017-08-10  6367  	bool native_mode_found = false;
b0781603af15425 Nicholas Kazlauskas 2021-05-19  6368  	bool recalculate_timing = false;
b0781603af15425 Nicholas Kazlauskas 2021-05-19  6369  	bool scale = dm_state ? (dm_state->scaling != RMX_OFF) : false;
b333730d126efcc Bhawanpreet Lakha   2018-11-16  6370  	int mode_refresh;
58124bf8f4a6ee4 Jerry (Fangzhi  Zuo 2018-11-27  6371) 	int preferred_refresh = 0;
defeb878c46e950 Alex Deucher        2019-11-06  6372  #if defined(CONFIG_DRM_AMD_DC_DCN)
df2f10151d64d0c David Francis       2019-06-19  6373  	struct dsc_dec_dpcd_caps dsc_caps;
7c431455cdd6add Alex Deucher        2020-11-30  6374  #endif
aed15309b9b2009 Mikita Lipski       2018-05-01  6375  	struct dc_sink *sink = NULL;
a85ba00538cd4bb Nikola Cornij       2021-03-15  6376  
a85ba00538cd4bb Nikola Cornij       2021-03-15  6377  	memset(&saved_mode, 0, sizeof(saved_mode));
a85ba00538cd4bb Nikola Cornij       2021-03-15  6378  
b830ebc910f6412 Harry Wentland      2017-07-26  6379  	if (aconnector == NULL) {
e7b07ceef2a650e Harry Wentland      2017-08-10  6380  		DRM_ERROR("aconnector is NULL!\n");
64245fa72daa08c Harry Wentland      2017-12-18  6381  		return stream;
e7b07ceef2a650e Harry Wentland      2017-08-10  6382  	}
e7b07ceef2a650e Harry Wentland      2017-08-10  6383  
e7b07ceef2a650e Harry Wentland      2017-08-10  6384  	drm_connector = &aconnector->base;
2e0ac3d68838d20 Harry Wentland      2017-08-17  6385  
f4ac176e62fdc74 Jerry Zuo           2017-09-08  6386  	if (!aconnector->dc_sink) {
aed15309b9b2009 Mikita Lipski       2018-05-01  6387  		sink = create_fake_sink(aconnector);
aed15309b9b2009 Mikita Lipski       2018-05-01  6388  		if (!sink)
64245fa72daa08c Harry Wentland      2017-12-18  6389  			return stream;
aed15309b9b2009 Mikita Lipski       2018-05-01  6390  	} else {
aed15309b9b2009 Mikita Lipski       2018-05-01  6391  		sink = aconnector->dc_sink;
dcd5fb82ffb4841 Mathias Fröhlich    2019-02-10  6392  		dc_sink_retain(sink);
f4ac176e62fdc74 Jerry Zuo           2017-09-08  6393  	}
2e0ac3d68838d20 Harry Wentland      2017-08-17  6394  
aed15309b9b2009 Mikita Lipski       2018-05-01  6395  	stream = dc_create_stream_for_sink(sink);
e7b07ceef2a650e Harry Wentland      2017-08-10  6396  
b830ebc910f6412 Harry Wentland      2017-07-26  6397  	if (stream == NULL) {
e7b07ceef2a650e Harry Wentland      2017-08-10  6398  		DRM_ERROR("Failed to create stream for sink!\n");
aed15309b9b2009 Mikita Lipski       2018-05-01  6399  		goto finish;
e7b07ceef2a650e Harry Wentland      2017-08-10  6400  	}
e7b07ceef2a650e Harry Wentland      2017-08-10  6401  
ceb3dbb4690db83 Jun Lei             2018-11-09  6402  	stream->dm_stream_context = aconnector;
ceb3dbb4690db83 Jun Lei             2018-11-09  6403  
4a36fcbaec4e9be Wayne Lin           2019-09-19  6404  	stream->timing.flags.LTE_340MCSC_SCRAMBLE =
4a36fcbaec4e9be Wayne Lin           2019-09-19  6405  		drm_connector->display_info.hdmi.scdc.scrambling.low_rates;
4a36fcbaec4e9be Wayne Lin           2019-09-19  6406  
e7b07ceef2a650e Harry Wentland      2017-08-10  6407  	list_for_each_entry(preferred_mode, &aconnector->base.modes, head) {
e7b07ceef2a650e Harry Wentland      2017-08-10  6408  		/* Search for preferred mode */
e7b07ceef2a650e Harry Wentland      2017-08-10  6409  		if (preferred_mode->type & DRM_MODE_TYPE_PREFERRED) {
e7b07ceef2a650e Harry Wentland      2017-08-10  6410  			native_mode_found = true;
e7b07ceef2a650e Harry Wentland      2017-08-10  6411  			break;
e7b07ceef2a650e Harry Wentland      2017-08-10  6412  		}
e7b07ceef2a650e Harry Wentland      2017-08-10  6413  	}
e7b07ceef2a650e Harry Wentland      2017-08-10  6414  	if (!native_mode_found)
e7b07ceef2a650e Harry Wentland      2017-08-10  6415  		preferred_mode = list_first_entry_or_null(
e7b07ceef2a650e Harry Wentland      2017-08-10  6416  				&aconnector->base.modes,
e7b07ceef2a650e Harry Wentland      2017-08-10  6417  				struct drm_display_mode,
e7b07ceef2a650e Harry Wentland      2017-08-10  6418  				head);
e7b07ceef2a650e Harry Wentland      2017-08-10  6419  
b333730d126efcc Bhawanpreet Lakha   2018-11-16  6420  	mode_refresh = drm_mode_vrefresh(&mode);
b333730d126efcc Bhawanpreet Lakha   2018-11-16  6421  
b830ebc910f6412 Harry Wentland      2017-07-26  6422  	if (preferred_mode == NULL) {
1f6010a96273c31 David Francis       2018-08-15  6423  		/*
1f6010a96273c31 David Francis       2018-08-15  6424  		 * This may not be an error, the use case is when we have no
e7b07ceef2a650e Harry Wentland      2017-08-10  6425  		 * usermode calls to reset and set mode upon hotplug. In this
e7b07ceef2a650e Harry Wentland      2017-08-10  6426  		 * case, we call set mode ourselves to restore the previous mode
e7b07ceef2a650e Harry Wentland      2017-08-10  6427  		 * and the modelist may not be filled in in time.
e7b07ceef2a650e Harry Wentland      2017-08-10  6428  		 */
f1ad2f5efd29dc8 Harry Wentland      2017-09-12  6429  		DRM_DEBUG_DRIVER("No preferred mode found\n");
a85ba00538cd4bb Nikola Cornij       2021-03-15  6430  	} else {
de05abe6b9d0fe0 Solomon Chiu        2022-01-06  6431  		recalculate_timing = is_freesync_video_mode(&mode, aconnector);
a85ba00538cd4bb Nikola Cornij       2021-03-15  6432  		if (recalculate_timing) {
a85ba00538cd4bb Nikola Cornij       2021-03-15  6433  			freesync_mode = get_highest_refresh_rate_mode(aconnector, false);
a85ba00538cd4bb Nikola Cornij       2021-03-15  6434  			saved_mode = mode;
a85ba00538cd4bb Nikola Cornij       2021-03-15  6435  			mode = *freesync_mode;
e7b07ceef2a650e Harry Wentland      2017-08-10  6436  		} else {
e7b07ceef2a650e Harry Wentland      2017-08-10  6437  			decide_crtc_timing_for_drm_display_mode(
b0781603af15425 Nicholas Kazlauskas 2021-05-19  6438  				&mode, preferred_mode, scale);
a85ba00538cd4bb Nikola Cornij       2021-03-15  6439  
58124bf8f4a6ee4 Jerry (Fangzhi  Zuo 2018-11-27  6440) 			preferred_refresh = drm_mode_vrefresh(preferred_mode);
e7b07ceef2a650e Harry Wentland      2017-08-10  6441  		}
b0781603af15425 Nicholas Kazlauskas 2021-05-19  6442  	}
e7b07ceef2a650e Harry Wentland      2017-08-10  6443  
a85ba00538cd4bb Nikola Cornij       2021-03-15  6444  	if (recalculate_timing)
a85ba00538cd4bb Nikola Cornij       2021-03-15  6445  		drm_mode_set_crtcinfo(&saved_mode, 0);
fe8858bb097ba34 Nikola Cornij       2021-03-26  6446  	else if (!dm_state)
9182b4cb445dc31 Harry Wentland      2017-12-18  6447  		drm_mode_set_crtcinfo(&mode, 0);
f783577c85c00da Jerry (Fangzhi  Zuo 2018-01-17  6448) 
b333730d126efcc Bhawanpreet Lakha   2018-11-16  6449         /*
b333730d126efcc Bhawanpreet Lakha   2018-11-16  6450  	* If scaling is enabled and refresh rate didn't change
b333730d126efcc Bhawanpreet Lakha   2018-11-16  6451  	* we copy the vic and polarities of the old timings
b333730d126efcc Bhawanpreet Lakha   2018-11-16  6452  	*/
b0781603af15425 Nicholas Kazlauskas 2021-05-19  6453  	if (!scale || mode_refresh != preferred_refresh)
a85ba00538cd4bb Nikola Cornij       2021-03-15  6454  		fill_stream_properties_from_drm_display_mode(
a85ba00538cd4bb Nikola Cornij       2021-03-15  6455  			stream, &mode, &aconnector->base, con_state, NULL,
a85ba00538cd4bb Nikola Cornij       2021-03-15  6456  			requested_bpc);
b333730d126efcc Bhawanpreet Lakha   2018-11-16  6457  	else
a85ba00538cd4bb Nikola Cornij       2021-03-15  6458  		fill_stream_properties_from_drm_display_mode(
a85ba00538cd4bb Nikola Cornij       2021-03-15  6459  			stream, &mode, &aconnector->base, con_state, old_stream,
a85ba00538cd4bb Nikola Cornij       2021-03-15  6460  			requested_bpc);
b333730d126efcc Bhawanpreet Lakha   2018-11-16  6461  

:::::: The code at line 6353 was first introduced by commit
:::::: 3ee6b26b78e47825032726f807beb70be86ea20a drm/amd/display: whitespace cleanup in amdgpu_dm.c/h

:::::: TO: Alex Deucher <alexander.deucher@amd.com>
:::::: CC: Dave Airlie <airlied@redhat.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
