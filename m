Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789F655548E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 21:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357983AbiFVTby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 15:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357211AbiFVTbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 15:31:39 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D914D4338A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 12:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655926165; x=1687462165;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=iz0GkuzOnZmr6V2l22B0Lti/eoYscRjUyz/fsTtDw1w=;
  b=NbpCPvf33vXf5tBaOflsYmtkBmcPfBlryr4LEQ3hCB72tHKxkgJHtga3
   iWlLVzUi4D3G/33yisEs4B3+40m9UTOtOlXGdpnnsvEj5/Klpp0LL3ceJ
   zfIitYQ17Bo9ElIEKzj/OstmN7dUmnX+f092QtwPOqoPkaUsfYkrlkpfx
   Uwd7QFYR5neXp/ZwXHeejlkPipxEpdBCYKSU1apBsqD98TgLm0jEa/rDb
   WVmT8gLspbqMEdnyWBhzxd7uie1VRud/OIMQOWr1H/rxKM9XJwlGl7MBj
   2Vx+t3IyVM+QWaNmuQP73QAip2YfS7znA8ZTxFlMQwgbmuAKc65JbfQQ6
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="280571885"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="280571885"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 12:29:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="588327631"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 22 Jun 2022 12:28:58 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o4625-0001bt-OS;
        Wed, 22 Jun 2022 19:28:57 +0000
Date:   Thu, 23 Jun 2022 03:28:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ian Chen <ian.chen@amd.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Wenjing Liu <Wenjing.Liu@amd.com>
Subject: [agd5f:drm-next 242/274]
 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:1025:26: warning:
 variable 'pre_connection_type' set but not used
Message-ID: <202206230323.cTdHcrd3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   eec53143b7fe1ccaace434e03b5959c9117bf9c5
commit: ec457f8378901d673b841e81d289b0165286db7f [242/274] drm/amd/display: Drop unnecessary detect link code
config: s390-buildonly-randconfig-r004-20220622 (https://download.01.org/0day-ci/archive/20220623/202206230323.cTdHcrd3-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 8b8d126598ce7bd5243da7f94f69fa1104288bee)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout ec457f8378901d673b841e81d289b0165286db7f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/gpu/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:1025:26: warning: variable 'pre_connection_type' set but not used [-Wunused-but-set-variable]
           enum dc_connection_type pre_connection_type = dc_connection_none;
                                   ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:3782:25: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
           enum act_return_status ret;
                                  ^
   2 warnings generated.


vim +/pre_connection_type +1025 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c

c282d9512cdd16 Wenjing Liu           2022-01-19  1000  
c282d9512cdd16 Wenjing Liu           2022-01-19  1001  
c282d9512cdd16 Wenjing Liu           2022-01-19  1002  /**
c282d9512cdd16 Wenjing Liu           2022-01-19  1003   * detect_link_and_local_sink() - Detect if a sink is attached to a given link
2119aa17c963e5 David Francis         2018-10-09  1004   *
2119aa17c963e5 David Francis         2018-10-09  1005   * link->local_sink is created or destroyed as needed.
2119aa17c963e5 David Francis         2018-10-09  1006   *
c282d9512cdd16 Wenjing Liu           2022-01-19  1007   * This does not create remote sinks.
2119aa17c963e5 David Francis         2018-10-09  1008   */
c282d9512cdd16 Wenjing Liu           2022-01-19  1009  static bool detect_link_and_local_sink(struct dc_link *link,
dd80ad9ba5fbfc YueHaibing            2019-10-16  1010  				  enum dc_detect_reason reason)
4562236b3bc0a2 Harry Wentland        2017-09-12  1011  {
4562236b3bc0a2 Harry Wentland        2017-09-12  1012  	struct dc_sink_init_data sink_init_data = { 0 };
4562236b3bc0a2 Harry Wentland        2017-09-12  1013  	struct display_sink_capability sink_caps = { 0 };
7335d95659329b Josip Pavic           2021-06-10  1014  	uint32_t i;
4562236b3bc0a2 Harry Wentland        2017-09-12  1015  	bool converter_disable_audio = false;
4562236b3bc0a2 Harry Wentland        2017-09-12  1016  	struct audio_support *aud_support = &link->dc->res_pool->audio_support;
eb815442e840e4 Samson Tam            2018-04-13  1017  	bool same_edid = false;
4562236b3bc0a2 Harry Wentland        2017-09-12  1018  	enum dc_edid_status edid_status;
4562236b3bc0a2 Harry Wentland        2017-09-12  1019  	struct dc_context *dc_ctx = link->ctx;
a820190204aef0 Leung, Martin         2022-05-13  1020  	struct dc *dc = dc_ctx->dc;
533ed6c708334b Harry Wentland        2017-08-08  1021  	struct dc_sink *sink = NULL;
eb815442e840e4 Samson Tam            2018-04-13  1022  	struct dc_sink *prev_sink = NULL;
eb815442e840e4 Samson Tam            2018-04-13  1023  	struct dpcd_caps prev_dpcd_caps;
4562236b3bc0a2 Harry Wentland        2017-09-12  1024  	enum dc_connection_type new_connection_type = dc_connection_none;
e748b59fb74e87 Lewis Huang           2020-10-08 @1025  	enum dc_connection_type pre_connection_type = dc_connection_none;
c797ede0ec89f1 Wenjing Liu           2020-06-01  1026  	const uint32_t post_oui_delay = 30; // 30ms
9ae1b27f31d0e8 Joseph Gravenor       2019-09-04  1027  
5d4b05ddd826d8 Bhawanpreet Lakha     2018-03-15  1028  	DC_LOGGER_INIT(link->ctx->logger);
248cbed60db05f Eric Bernstein        2019-02-28  1029  
248cbed60db05f Eric Bernstein        2019-02-28  1030  	if (dc_is_virtual_signal(link->connector_signal))
4562236b3bc0a2 Harry Wentland        2017-09-12  1031  		return false;
4562236b3bc0a2 Harry Wentland        2017-09-12  1032  
5ab991ba3429a1 Yi-Ling Chen          2021-06-01  1033  	if (((link->connector_signal == SIGNAL_TYPE_LVDS ||
abe882a39a9c8c Anthony Koo           2019-05-22  1034  		link->connector_signal == SIGNAL_TYPE_EDP) &&
5ab991ba3429a1 Yi-Ling Chen          2021-06-01  1035  		(!link->dc->config.allow_edp_hotplug_detection)) &&
96577cf82a1331 Hersen Wu             2020-01-14  1036  		link->local_sink) {
96577cf82a1331 Hersen Wu             2020-01-14  1037  		// need to re-write OUI and brightness in resume case
83a3766b147053 Rajib Mahapatra       2022-01-10  1038  		if (link->connector_signal == SIGNAL_TYPE_EDP &&
83a3766b147053 Rajib Mahapatra       2022-01-10  1039  			(link->dpcd_sink_ext_caps.bits.oled == 1)) {
96577cf82a1331 Hersen Wu             2020-01-14  1040  			dpcd_set_source_specific_data(link);
c797ede0ec89f1 Wenjing Liu           2020-06-01  1041  			msleep(post_oui_delay);
ded3491b85225c Melissa Wen           2020-03-31  1042  			dc_link_set_default_brightness_aux(link);
ded3491b85225c Melissa Wen           2020-03-31  1043  			//TODO: use cached
96577cf82a1331 Hersen Wu             2020-01-14  1044  		}
96577cf82a1331 Hersen Wu             2020-01-14  1045  
abe882a39a9c8c Anthony Koo           2019-05-22  1046  		return true;
96577cf82a1331 Hersen Wu             2020-01-14  1047  	}
abe882a39a9c8c Anthony Koo           2019-05-22  1048  
ded3491b85225c Melissa Wen           2020-03-31  1049  	if (!dc_link_detect_sink(link, &new_connection_type)) {
4562236b3bc0a2 Harry Wentland        2017-09-12  1050  		BREAK_TO_DEBUGGER();
4562236b3bc0a2 Harry Wentland        2017-09-12  1051  		return false;
4562236b3bc0a2 Harry Wentland        2017-09-12  1052  	}
4562236b3bc0a2 Harry Wentland        2017-09-12  1053  
eb815442e840e4 Samson Tam            2018-04-13  1054  	prev_sink = link->local_sink;
ded3491b85225c Melissa Wen           2020-03-31  1055  	if (prev_sink) {
eb815442e840e4 Samson Tam            2018-04-13  1056  		dc_sink_retain(prev_sink);
eb815442e840e4 Samson Tam            2018-04-13  1057  		memcpy(&prev_dpcd_caps, &link->dpcd_caps, sizeof(struct dpcd_caps));
eb815442e840e4 Samson Tam            2018-04-13  1058  	}
dcf298c3137ace Wenjing Liu           2017-09-25  1059  
ded3491b85225c Melissa Wen           2020-03-31  1060  	link_disconnect_sink(link);
4562236b3bc0a2 Harry Wentland        2017-09-12  1061  	if (new_connection_type != dc_connection_none) {
e748b59fb74e87 Lewis Huang           2020-10-08  1062  		pre_connection_type = link->type;
d0778ebfd58f56 Harry Wentland        2017-07-22  1063  		link->type = new_connection_type;
eed928dcd83ee8 Charlene Liu          2019-04-29  1064  		link->link_state_valid = false;
4562236b3bc0a2 Harry Wentland        2017-09-12  1065  
4562236b3bc0a2 Harry Wentland        2017-09-12  1066  		/* From Disconnected-to-Connected. */
d0778ebfd58f56 Harry Wentland        2017-07-22  1067  		switch (link->connector_signal) {
4562236b3bc0a2 Harry Wentland        2017-09-12  1068  		case SIGNAL_TYPE_HDMI_TYPE_A: {
4562236b3bc0a2 Harry Wentland        2017-09-12  1069  			sink_caps.transaction_type = DDC_TRANSACTION_TYPE_I2C;
4562236b3bc0a2 Harry Wentland        2017-09-12  1070  			if (aud_support->hdmi_audio_native)
4562236b3bc0a2 Harry Wentland        2017-09-12  1071  				sink_caps.signal = SIGNAL_TYPE_HDMI_TYPE_A;
4562236b3bc0a2 Harry Wentland        2017-09-12  1072  			else
4562236b3bc0a2 Harry Wentland        2017-09-12  1073  				sink_caps.signal = SIGNAL_TYPE_DVI_SINGLE_LINK;
4562236b3bc0a2 Harry Wentland        2017-09-12  1074  			break;
4562236b3bc0a2 Harry Wentland        2017-09-12  1075  		}
4562236b3bc0a2 Harry Wentland        2017-09-12  1076  
4562236b3bc0a2 Harry Wentland        2017-09-12  1077  		case SIGNAL_TYPE_DVI_SINGLE_LINK: {
4562236b3bc0a2 Harry Wentland        2017-09-12  1078  			sink_caps.transaction_type = DDC_TRANSACTION_TYPE_I2C;
4562236b3bc0a2 Harry Wentland        2017-09-12  1079  			sink_caps.signal = SIGNAL_TYPE_DVI_SINGLE_LINK;
4562236b3bc0a2 Harry Wentland        2017-09-12  1080  			break;
4562236b3bc0a2 Harry Wentland        2017-09-12  1081  		}
4562236b3bc0a2 Harry Wentland        2017-09-12  1082  
4562236b3bc0a2 Harry Wentland        2017-09-12  1083  		case SIGNAL_TYPE_DVI_DUAL_LINK: {
4562236b3bc0a2 Harry Wentland        2017-09-12  1084  			sink_caps.transaction_type = DDC_TRANSACTION_TYPE_I2C;
4562236b3bc0a2 Harry Wentland        2017-09-12  1085  			sink_caps.signal = SIGNAL_TYPE_DVI_DUAL_LINK;
4562236b3bc0a2 Harry Wentland        2017-09-12  1086  			break;
4562236b3bc0a2 Harry Wentland        2017-09-12  1087  		}
4562236b3bc0a2 Harry Wentland        2017-09-12  1088  
11c3ee48bd7c23 Alex Deucher          2018-08-14  1089  		case SIGNAL_TYPE_LVDS: {
11c3ee48bd7c23 Alex Deucher          2018-08-14  1090  			sink_caps.transaction_type = DDC_TRANSACTION_TYPE_I2C;
11c3ee48bd7c23 Alex Deucher          2018-08-14  1091  			sink_caps.signal = SIGNAL_TYPE_LVDS;
11c3ee48bd7c23 Alex Deucher          2018-08-14  1092  			break;
11c3ee48bd7c23 Alex Deucher          2018-08-14  1093  		}
11c3ee48bd7c23 Alex Deucher          2018-08-14  1094  
4562236b3bc0a2 Harry Wentland        2017-09-12  1095  		case SIGNAL_TYPE_EDP: {
96577cf82a1331 Hersen Wu             2020-01-14  1096  			read_current_link_settings_on_detect(link);
96577cf82a1331 Hersen Wu             2020-01-14  1097  
4654a2f7fce0c2 Roman Li              2017-07-26  1098  			detect_edp_sink_caps(link);
5d593d682ffa53 Mario Kleiner         2020-01-09  1099  			read_current_link_settings_on_detect(link);
a820190204aef0 Leung, Martin         2022-05-13  1100  
a820190204aef0 Leung, Martin         2022-05-13  1101  			/* Disable power sequence on MIPI panel + converter
a820190204aef0 Leung, Martin         2022-05-13  1102  			 */
a820190204aef0 Leung, Martin         2022-05-13  1103  			if (dc->config.enable_mipi_converter_optimization &&
a820190204aef0 Leung, Martin         2022-05-13  1104  				dc_ctx->dce_version == DCN_VERSION_3_01 &&
a820190204aef0 Leung, Martin         2022-05-13  1105  				link->dpcd_caps.sink_dev_id == DP_BRANCH_DEVICE_ID_0022B9 &&
a820190204aef0 Leung, Martin         2022-05-13  1106  				memcmp(&link->dpcd_caps.branch_dev_name, DP_SINK_BRANCH_DEV_NAME_7580,
a820190204aef0 Leung, Martin         2022-05-13  1107  					sizeof(link->dpcd_caps.branch_dev_name)) == 0)
a820190204aef0 Leung, Martin         2022-05-13  1108  				dc->config.edp_no_power_sequencing = true;
a820190204aef0 Leung, Martin         2022-05-13  1109  
7f7652ee8c8c1c Martin Leung          2019-08-16  1110  			sink_caps.transaction_type = DDC_TRANSACTION_TYPE_I2C_OVER_AUX;
4562236b3bc0a2 Harry Wentland        2017-09-12  1111  			sink_caps.signal = SIGNAL_TYPE_EDP;
4562236b3bc0a2 Harry Wentland        2017-09-12  1112  			break;
4562236b3bc0a2 Harry Wentland        2017-09-12  1113  		}
4562236b3bc0a2 Harry Wentland        2017-09-12  1114  
4562236b3bc0a2 Harry Wentland        2017-09-12  1115  		case SIGNAL_TYPE_DISPLAY_PORT: {
b5b1f45549041c Eric Yang             2019-07-10  1116  			/* wa HPD high coming too early*/
99732e52e7f811 Jimmy Kizito          2021-04-01  1117  			if (link->ep_type == DISPLAY_ENDPOINT_PHY &&
99732e52e7f811 Jimmy Kizito          2021-04-01  1118  			    link->link_enc->features.flags.bits.DP_IS_USB_C == 1) {
b5b1f45549041c Eric Yang             2019-07-10  1119  				/* if alt mode times out, return false */
8ccf0e20769d96 Wenjing Liu           2020-04-05  1120  				if (!wait_for_entering_dp_alt_mode(link))
b5b1f45549041c Eric Yang             2019-07-10  1121  					return false;
b5b1f45549041c Eric Yang             2019-07-10  1122  			}
b5b1f45549041c Eric Yang             2019-07-10  1123  
8a58e25b8b6572 Wenjing Liu           2021-05-14  1124  			if (!detect_dp(link, &sink_caps, reason)) {
ded3491b85225c Melissa Wen           2020-03-31  1125  				if (prev_sink)
eb815442e840e4 Samson Tam            2018-04-13  1126  					dc_sink_release(prev_sink);
cdb39798082cde Yongqiang Sun         2018-01-23  1127  				return false;
eb815442e840e4 Samson Tam            2018-04-13  1128  			}
4562236b3bc0a2 Harry Wentland        2017-09-12  1129  
8a58e25b8b6572 Wenjing Liu           2021-05-14  1130  			/* Active SST downstream branch device unplug*/
8a58e25b8b6572 Wenjing Liu           2021-05-14  1131  			if (link->type == dc_connection_sst_branch &&
8a58e25b8b6572 Wenjing Liu           2021-05-14  1132  			    link->dpcd_caps.sink_count.bits.SINK_COUNT == 0) {
8a58e25b8b6572 Wenjing Liu           2021-05-14  1133  				if (prev_sink)
8a58e25b8b6572 Wenjing Liu           2021-05-14  1134  					/* Downstream unplug */
8a58e25b8b6572 Wenjing Liu           2021-05-14  1135  					dc_sink_release(prev_sink);
8a58e25b8b6572 Wenjing Liu           2021-05-14  1136  				return true;
4562236b3bc0a2 Harry Wentland        2017-09-12  1137  			}
4562236b3bc0a2 Harry Wentland        2017-09-12  1138  
8a58e25b8b6572 Wenjing Liu           2021-05-14  1139  			/* disable audio for non DP to HDMI active sst converter */
8a58e25b8b6572 Wenjing Liu           2021-05-14  1140  			if (link->type == dc_connection_sst_branch &&
8a58e25b8b6572 Wenjing Liu           2021-05-14  1141  					is_dp_active_dongle(link) &&
8a58e25b8b6572 Wenjing Liu           2021-05-14  1142  					(link->dpcd_caps.dongle_type !=
8a58e25b8b6572 Wenjing Liu           2021-05-14  1143  							DISPLAY_DONGLE_DP_HDMI_CONVERTER))
8a58e25b8b6572 Wenjing Liu           2021-05-14  1144  				converter_disable_audio = true;
4562236b3bc0a2 Harry Wentland        2017-09-12  1145  			break;
4562236b3bc0a2 Harry Wentland        2017-09-12  1146  		}
4562236b3bc0a2 Harry Wentland        2017-09-12  1147  
4562236b3bc0a2 Harry Wentland        2017-09-12  1148  		default:
4562236b3bc0a2 Harry Wentland        2017-09-12  1149  			DC_ERROR("Invalid connector type! signal:%d\n",
d0778ebfd58f56 Harry Wentland        2017-07-22  1150  				 link->connector_signal);
ded3491b85225c Melissa Wen           2020-03-31  1151  			if (prev_sink)
eb815442e840e4 Samson Tam            2018-04-13  1152  				dc_sink_release(prev_sink);
4562236b3bc0a2 Harry Wentland        2017-09-12  1153  			return false;
4562236b3bc0a2 Harry Wentland        2017-09-12  1154  		} /* switch() */
4562236b3bc0a2 Harry Wentland        2017-09-12  1155  
4562236b3bc0a2 Harry Wentland        2017-09-12  1156  		if (link->dpcd_caps.sink_count.bits.SINK_COUNT)
ded3491b85225c Melissa Wen           2020-03-31  1157  			link->dpcd_sink_count =
ded3491b85225c Melissa Wen           2020-03-31  1158  				link->dpcd_caps.sink_count.bits.SINK_COUNT;
4562236b3bc0a2 Harry Wentland        2017-09-12  1159  		else
4562236b3bc0a2 Harry Wentland        2017-09-12  1160  			link->dpcd_sink_count = 1;
4562236b3bc0a2 Harry Wentland        2017-09-12  1161  
ded3491b85225c Melissa Wen           2020-03-31  1162  		dal_ddc_service_set_transaction_type(link->ddc,
4562236b3bc0a2 Harry Wentland        2017-09-12  1163  						     sink_caps.transaction_type);
4562236b3bc0a2 Harry Wentland        2017-09-12  1164  
ded3491b85225c Melissa Wen           2020-03-31  1165  		link->aux_mode =
ded3491b85225c Melissa Wen           2020-03-31  1166  			dal_ddc_service_is_in_aux_transaction_mode(link->ddc);
7c7f5b15be6528 Andrey Grodzovsky     2017-03-28  1167  
d0778ebfd58f56 Harry Wentland        2017-07-22  1168  		sink_init_data.link = link;
4562236b3bc0a2 Harry Wentland        2017-09-12  1169  		sink_init_data.sink_signal = sink_caps.signal;
4562236b3bc0a2 Harry Wentland        2017-09-12  1170  
b73a22d3257f9e Harry Wentland        2017-07-24  1171  		sink = dc_sink_create(&sink_init_data);
b73a22d3257f9e Harry Wentland        2017-07-24  1172  		if (!sink) {
4562236b3bc0a2 Harry Wentland        2017-09-12  1173  			DC_ERROR("Failed to create sink!\n");
ded3491b85225c Melissa Wen           2020-03-31  1174  			if (prev_sink)
eb815442e840e4 Samson Tam            2018-04-13  1175  				dc_sink_release(prev_sink);
4562236b3bc0a2 Harry Wentland        2017-09-12  1176  			return false;
4562236b3bc0a2 Harry Wentland        2017-09-12  1177  		}
7d58e72149fa73 Martin Tsai           2017-09-08  1178  
ceb3dbb4690db8 Jun Lei               2018-11-09  1179  		sink->link->dongle_max_pix_clk = sink_caps.max_hdmi_pixel_clock;
7d58e72149fa73 Martin Tsai           2017-09-08  1180  		sink->converter_disable_audio = converter_disable_audio;
dcf298c3137ace Wenjing Liu           2017-09-25  1181  
dcd5fb82ffb484 Mathias Fröhlich      2019-02-10  1182  		/* dc_sink_create returns a new reference */
7d58e72149fa73 Martin Tsai           2017-09-08  1183  		link->local_sink = sink;
4562236b3bc0a2 Harry Wentland        2017-09-12  1184  
ded3491b85225c Melissa Wen           2020-03-31  1185  		edid_status = dm_helpers_read_local_edid(link->ctx,
ded3491b85225c Melissa Wen           2020-03-31  1186  							 link, sink);
4562236b3bc0a2 Harry Wentland        2017-09-12  1187  
4562236b3bc0a2 Harry Wentland        2017-09-12  1188  		switch (edid_status) {
4562236b3bc0a2 Harry Wentland        2017-09-12  1189  		case EDID_BAD_CHECKSUM:
1296423bf23c7a Bhawanpreet Lakha     2018-02-20  1190  			DC_LOG_ERROR("EDID checksum invalid.\n");
4562236b3bc0a2 Harry Wentland        2017-09-12  1191  			break;
906fbba2c9d486 Dale Zhao             2022-03-10  1192  		case EDID_PARTIAL_VALID:
906fbba2c9d486 Dale Zhao             2022-03-10  1193  			DC_LOG_ERROR("Partial EDID valid, abandon invalid blocks.\n");
906fbba2c9d486 Dale Zhao             2022-03-10  1194  			break;
4562236b3bc0a2 Harry Wentland        2017-09-12  1195  		case EDID_NO_RESPONSE:
1296423bf23c7a Bhawanpreet Lakha     2018-02-20  1196  			DC_LOG_ERROR("No EDID read.\n");
01dc285d5cd89b Harry Wentland        2018-08-01  1197  			/*
01dc285d5cd89b Harry Wentland        2018-08-01  1198  			 * Abort detection for non-DP connectors if we have
01dc285d5cd89b Harry Wentland        2018-08-01  1199  			 * no EDID
01dc285d5cd89b Harry Wentland        2018-08-01  1200  			 *
01dc285d5cd89b Harry Wentland        2018-08-01  1201  			 * DP needs to report as connected if HDP is high
01dc285d5cd89b Harry Wentland        2018-08-01  1202  			 * even if we have no EDID in order to go to
01dc285d5cd89b Harry Wentland        2018-08-01  1203  			 * fail-safe mode
01dc285d5cd89b Harry Wentland        2018-08-01  1204  			 */
16196776185cb1 Harry Wentland        2018-08-02  1205  			if (dc_is_hdmi_signal(link->connector_signal) ||
219097df0f9d47 SivapiriyanKumarasamy 2018-08-15  1206  			    dc_is_dvi_signal(link->connector_signal)) {
ded3491b85225c Melissa Wen           2020-03-31  1207  				if (prev_sink)
219097df0f9d47 SivapiriyanKumarasamy 2018-08-15  1208  					dc_sink_release(prev_sink);
219097df0f9d47 SivapiriyanKumarasamy 2018-08-15  1209  
01dc285d5cd89b Harry Wentland        2018-08-01  1210  				return false;
219097df0f9d47 SivapiriyanKumarasamy 2018-08-15  1211  			}
10a9accd4842e6 Ilya                  2022-02-10  1212  
10a9accd4842e6 Ilya                  2022-02-10  1213  			if (link->type == dc_connection_sst_branch &&
10a9accd4842e6 Ilya                  2022-02-10  1214  					link->dpcd_caps.dongle_type ==
10a9accd4842e6 Ilya                  2022-02-10  1215  						DISPLAY_DONGLE_DP_VGA_CONVERTER &&
10a9accd4842e6 Ilya                  2022-02-10  1216  					reason == DETECT_REASON_HPDRX) {
10a9accd4842e6 Ilya                  2022-02-10  1217  				/* Abort detection for DP-VGA adapters when EDID
10a9accd4842e6 Ilya                  2022-02-10  1218  				 * can't be read and detection reason is VGA-side
10a9accd4842e6 Ilya                  2022-02-10  1219  				 * hotplug
10a9accd4842e6 Ilya                  2022-02-10  1220  				 */
10a9accd4842e6 Ilya                  2022-02-10  1221  				if (prev_sink)
10a9accd4842e6 Ilya                  2022-02-10  1222  					dc_sink_release(prev_sink);
10a9accd4842e6 Ilya                  2022-02-10  1223  				link_disconnect_sink(link);
10a9accd4842e6 Ilya                  2022-02-10  1224  
10a9accd4842e6 Ilya                  2022-02-10  1225  				return true;
10a9accd4842e6 Ilya                  2022-02-10  1226  			}
10a9accd4842e6 Ilya                  2022-02-10  1227  
910e834db00e40 Gustavo A. R. Silva   2020-11-20  1228  			break;
4562236b3bc0a2 Harry Wentland        2017-09-12  1229  		default:
4562236b3bc0a2 Harry Wentland        2017-09-12  1230  			break;
4562236b3bc0a2 Harry Wentland        2017-09-12  1231  		}
4562236b3bc0a2 Harry Wentland        2017-09-12  1232  
eb815442e840e4 Samson Tam            2018-04-13  1233  		// Check if edid is the same
ded3491b85225c Melissa Wen           2020-03-31  1234  		if ((prev_sink) &&
ded3491b85225c Melissa Wen           2020-03-31  1235  		    (edid_status == EDID_THE_SAME || edid_status == EDID_OK))
ded3491b85225c Melissa Wen           2020-03-31  1236  			same_edid = is_same_edid(&prev_sink->dc_edid,
ded3491b85225c Melissa Wen           2020-03-31  1237  						 &sink->dc_edid);
eb815442e840e4 Samson Tam            2018-04-13  1238  
5fbdb1f38d16a7 Nathan Chancellor     2020-02-14  1239  		if (sink->edid_caps.panel_patch.skip_scdc_overwrite)
a760fc1bff03f2 Martin Leung          2020-01-30  1240  			link->ctx->dc->debug.hdmi20_disable = true;
a760fc1bff03f2 Martin Leung          2020-01-30  1241  
f334073ae31eae Wenjing Liu           2017-08-03  1242  		if (link->connector_signal == SIGNAL_TYPE_DISPLAY_PORT &&
ded3491b85225c Melissa Wen           2020-03-31  1243  		    sink_caps.transaction_type ==
ded3491b85225c Melissa Wen           2020-03-31  1244  		    DDC_TRANSACTION_TYPE_I2C_OVER_AUX) {
f334073ae31eae Wenjing Liu           2017-08-03  1245  			/*
f334073ae31eae Wenjing Liu           2017-08-03  1246  			 * TODO debug why Dell 2413 doesn't like
f334073ae31eae Wenjing Liu           2017-08-03  1247  			 *  two link trainings
f334073ae31eae Wenjing Liu           2017-08-03  1248  			 */
fe8db3bcf2e5f9 Bhawanpreet Lakha     2020-04-01  1249  #if defined(CONFIG_DRM_AMD_DC_HDCP)
fe8db3bcf2e5f9 Bhawanpreet Lakha     2020-04-01  1250  			query_hdcp_capability(sink->sink_signal, link);
fe8db3bcf2e5f9 Bhawanpreet Lakha     2020-04-01  1251  #endif
0301ccbaf67d3d abdoulaye berthe      2018-07-19  1252  		} else {
0301ccbaf67d3d abdoulaye berthe      2018-07-19  1253  			// If edid is the same, then discard new sink and revert back to original sink
0301ccbaf67d3d abdoulaye berthe      2018-07-19  1254  			if (same_edid) {
0301ccbaf67d3d abdoulaye berthe      2018-07-19  1255  				link_disconnect_remap(prev_sink, link);
0301ccbaf67d3d abdoulaye berthe      2018-07-19  1256  				sink = prev_sink;
0301ccbaf67d3d abdoulaye berthe      2018-07-19  1257  				prev_sink = NULL;
0301ccbaf67d3d abdoulaye berthe      2018-07-19  1258  			}
fe8db3bcf2e5f9 Bhawanpreet Lakha     2020-04-01  1259  #if defined(CONFIG_DRM_AMD_DC_HDCP)
fe8db3bcf2e5f9 Bhawanpreet Lakha     2020-04-01  1260  			query_hdcp_capability(sink->sink_signal, link);
fe8db3bcf2e5f9 Bhawanpreet Lakha     2020-04-01  1261  #endif
f334073ae31eae Wenjing Liu           2017-08-03  1262  		}
f334073ae31eae Wenjing Liu           2017-08-03  1263  
4562236b3bc0a2 Harry Wentland        2017-09-12  1264  		/* HDMI-DVI Dongle */
b73a22d3257f9e Harry Wentland        2017-07-24  1265  		if (sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A &&
b73a22d3257f9e Harry Wentland        2017-07-24  1266  		    !sink->edid_caps.edid_hdmi)
b73a22d3257f9e Harry Wentland        2017-07-24  1267  			sink->sink_signal = SIGNAL_TYPE_DVI_SINGLE_LINK;
4562236b3bc0a2 Harry Wentland        2017-09-12  1268  
5fed53c7983654 Leo (Hanghong  Ma     2022-02-11  1269) 		if (link->local_sink && dc_is_dp_signal(sink_caps.signal))
5fed53c7983654 Leo (Hanghong  Ma     2022-02-11  1270) 			dp_trace_init(link);
5fed53c7983654 Leo (Hanghong  Ma     2022-02-11  1271) 
4562236b3bc0a2 Harry Wentland        2017-09-12  1272  		/* Connectivity log: detection */
a634913ed24aae Joshua Aberback       2019-05-02  1273  		for (i = 0; i < sink->dc_edid.length / DC_EDID_BLOCK_SIZE; i++) {
4562236b3bc0a2 Harry Wentland        2017-09-12  1274  			CONN_DATA_DETECT(link,
a634913ed24aae Joshua Aberback       2019-05-02  1275  					 &sink->dc_edid.raw_edid[i * DC_EDID_BLOCK_SIZE],
a634913ed24aae Joshua Aberback       2019-05-02  1276  					 DC_EDID_BLOCK_SIZE,
b73a22d3257f9e Harry Wentland        2017-07-24  1277  					 "%s: [Block %d] ", sink->edid_caps.display_name, i);
4562236b3bc0a2 Harry Wentland        2017-09-12  1278  		}
4562236b3bc0a2 Harry Wentland        2017-09-12  1279  
1296423bf23c7a Bhawanpreet Lakha     2018-02-20  1280  		DC_LOG_DETECTION_EDID_PARSER("%s: "
4562236b3bc0a2 Harry Wentland        2017-09-12  1281  			"manufacturer_id = %X, "
4562236b3bc0a2 Harry Wentland        2017-09-12  1282  			"product_id = %X, "
4562236b3bc0a2 Harry Wentland        2017-09-12  1283  			"serial_number = %X, "
4562236b3bc0a2 Harry Wentland        2017-09-12  1284  			"manufacture_week = %d, "
4562236b3bc0a2 Harry Wentland        2017-09-12  1285  			"manufacture_year = %d, "
4562236b3bc0a2 Harry Wentland        2017-09-12  1286  			"display_name = %s, "
4562236b3bc0a2 Harry Wentland        2017-09-12  1287  			"speaker_flag = %d, "
4562236b3bc0a2 Harry Wentland        2017-09-12  1288  			"audio_mode_count = %d\n",
4562236b3bc0a2 Harry Wentland        2017-09-12  1289  			__func__,
b73a22d3257f9e Harry Wentland        2017-07-24  1290  			sink->edid_caps.manufacturer_id,
b73a22d3257f9e Harry Wentland        2017-07-24  1291  			sink->edid_caps.product_id,
b73a22d3257f9e Harry Wentland        2017-07-24  1292  			sink->edid_caps.serial_number,
b73a22d3257f9e Harry Wentland        2017-07-24  1293  			sink->edid_caps.manufacture_week,
b73a22d3257f9e Harry Wentland        2017-07-24  1294  			sink->edid_caps.manufacture_year,
b73a22d3257f9e Harry Wentland        2017-07-24  1295  			sink->edid_caps.display_name,
b73a22d3257f9e Harry Wentland        2017-07-24  1296  			sink->edid_caps.speaker_flags,
b73a22d3257f9e Harry Wentland        2017-07-24  1297  			sink->edid_caps.audio_mode_count);
b73a22d3257f9e Harry Wentland        2017-07-24  1298  
b73a22d3257f9e Harry Wentland        2017-07-24  1299  		for (i = 0; i < sink->edid_caps.audio_mode_count; i++) {
1296423bf23c7a Bhawanpreet Lakha     2018-02-20  1300  			DC_LOG_DETECTION_EDID_PARSER("%s: mode number = %d, "
4562236b3bc0a2 Harry Wentland        2017-09-12  1301  				"format_code = %d, "
4562236b3bc0a2 Harry Wentland        2017-09-12  1302  				"channel_count = %d, "
4562236b3bc0a2 Harry Wentland        2017-09-12  1303  				"sample_rate = %d, "
4562236b3bc0a2 Harry Wentland        2017-09-12  1304  				"sample_size = %d\n",
4562236b3bc0a2 Harry Wentland        2017-09-12  1305  				__func__,
4562236b3bc0a2 Harry Wentland        2017-09-12  1306  				i,
b73a22d3257f9e Harry Wentland        2017-07-24  1307  				sink->edid_caps.audio_modes[i].format_code,
b73a22d3257f9e Harry Wentland        2017-07-24  1308  				sink->edid_caps.audio_modes[i].channel_count,
b73a22d3257f9e Harry Wentland        2017-07-24  1309  				sink->edid_caps.audio_modes[i].sample_rate,
b73a22d3257f9e Harry Wentland        2017-07-24  1310  				sink->edid_caps.audio_modes[i].sample_size);
4562236b3bc0a2 Harry Wentland        2017-09-12  1311  		}
4562236b3bc0a2 Harry Wentland        2017-09-12  1312  	} else {
4562236b3bc0a2 Harry Wentland        2017-09-12  1313  		/* From Connected-to-Disconnected. */
d0778ebfd58f56 Harry Wentland        2017-07-22  1314  		link->type = dc_connection_none;
4562236b3bc0a2 Harry Wentland        2017-09-12  1315  		sink_caps.signal = SIGNAL_TYPE_NONE;
233d87a579b8ad Samson Tam            2019-05-28  1316  		/* When we unplug a passive DP-HDMI dongle connection, dongle_max_pix_clk
233d87a579b8ad Samson Tam            2019-05-28  1317  		 *  is not cleared. If we emulate a DP signal on this connection, it thinks
233d87a579b8ad Samson Tam            2019-05-28  1318  		 *  the dongle is still there and limits the number of modes we can emulate.
233d87a579b8ad Samson Tam            2019-05-28  1319  		 *  Clear dongle_max_pix_clk on disconnect to fix this
233d87a579b8ad Samson Tam            2019-05-28  1320  		 */
233d87a579b8ad Samson Tam            2019-05-28  1321  		link->dongle_max_pix_clk = 0;
4a3ad932b2c538 Shen, George          2022-01-23  1322  
c595fb05e392a5 Wenjing Liu           2022-02-08  1323  		dc_link_clear_dprx_states(link);
5fed53c7983654 Leo (Hanghong  Ma     2022-02-11  1324) 		dp_trace_reset(link);
4562236b3bc0a2 Harry Wentland        2017-09-12  1325  	}
4562236b3bc0a2 Harry Wentland        2017-09-12  1326  
8a58e25b8b6572 Wenjing Liu           2021-05-14  1327  	LINK_INFO("link=%d, dc_sink_in=%p is now %s prev_sink=%p edid same=%d\n",
b73a22d3257f9e Harry Wentland        2017-07-24  1328  		  link->link_index, sink,
ded3491b85225c Melissa Wen           2020-03-31  1329  		  (sink_caps.signal ==
ded3491b85225c Melissa Wen           2020-03-31  1330  		   SIGNAL_TYPE_NONE ? "Disconnected" : "Connected"),
8a58e25b8b6572 Wenjing Liu           2021-05-14  1331  		  prev_sink, same_edid);
eb815442e840e4 Samson Tam            2018-04-13  1332  
ded3491b85225c Melissa Wen           2020-03-31  1333  	if (prev_sink)
eb815442e840e4 Samson Tam            2018-04-13  1334  		dc_sink_release(prev_sink);
4562236b3bc0a2 Harry Wentland        2017-09-12  1335  
4562236b3bc0a2 Harry Wentland        2017-09-12  1336  	return true;
9ae1b27f31d0e8 Joseph Gravenor       2019-09-04  1337  }
9ae1b27f31d0e8 Joseph Gravenor       2019-09-04  1338  

:::::: The code at line 1025 was first introduced by commit
:::::: e748b59fb74e8725c8774a4b0753fabba9de7b97 drm/amd/display: stop top_mgr when type change to non-MST during s3

:::::: TO: Lewis Huang <Lewis.Huang@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
