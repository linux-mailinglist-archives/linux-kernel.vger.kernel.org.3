Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75AC5ADA6C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 22:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbiIEUxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 16:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbiIEUw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 16:52:57 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26376582C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 13:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662411175; x=1693947175;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BYboI3CT2E0SBv6p0z1LCbkTuithuqoHUTG1sxLf4BA=;
  b=iZUOVOKzvCsJl3DW03hu7cjUMTr7Ha5oR4H/ro6NvbIYBOLjO2myiIzp
   wjfuz5t0pSMFo1Spfls7yIMQhg2gUprpkJU0RCmOC+3nGQSmz9iam76bM
   9rPCFeorexZo9oUGNFbae1wsTv8xr8S6SzI3sbBulHxSf9FpGGGL5vIjZ
   awwKnBcY+lY9+dYFAEalESlv2l4uWgE+h22ldfKWqFNyHLrx1BbBoRy+9
   1drrIacseMHLaU3UbAWlNeWDELEEs3jPSrleXKGPkHF+TOwfDCXxvC+wB
   tD8thZmzVFHTCBXF7ppt+y73NMwQ6Foqq7BLYgFab0h0mqfk4TLxc7BcJ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="295188855"
X-IronPort-AV: E=Sophos;i="5.93,292,1654585200"; 
   d="scan'208";a="295188855"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 13:52:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,292,1654585200"; 
   d="scan'208";a="613875030"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 05 Sep 2022 13:52:53 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oVJ5R-0004Wm-0Y;
        Mon, 05 Sep 2022 20:52:53 +0000
Date:   Tue, 6 Sep 2022 04:52:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Fangzhi Zuo <Jerry.Zuo@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c:439:14:
 warning: variable 'sdp_stream_enable' set but not used
Message-ID: <202209060420.Wzjr6Sj2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fangzhi,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7e18e42e4b280c85b76967a9106a13ca61c16179
commit: 83228ebb82e4fe2e5513f35d9b0b0eded3c44cbc drm/amd/display: Add DP 2.0 HPO Stream Encoder
date:   1 year ago
config: i386-buildonly-randconfig-r004-20220905 (https://download.01.org/0day-ci/archive/20220906/202209060420.Wzjr6Sj2-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=83228ebb82e4fe2e5513f35d9b0b0eded3c44cbc
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 83228ebb82e4fe2e5513f35d9b0b0eded3c44cbc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c: In function 'dcn31_hpo_dp_stream_enc_update_dp_info_packets':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c:439:14: warning: variable 'sdp_stream_enable' set but not used [-Wunused-but-set-variable]
     439 |         bool sdp_stream_enable = false;
         |              ^~~~~~~~~~~~~~~~~


vim +/sdp_stream_enable +439 drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c

   432	
   433	static void dcn31_hpo_dp_stream_enc_update_dp_info_packets(
   434			struct hpo_dp_stream_encoder *enc,
   435			const struct encoder_info_frame *info_frame)
   436	{
   437		struct dcn31_hpo_dp_stream_encoder *enc3 = DCN3_1_HPO_DP_STREAM_ENC_FROM_HPO_STREAM_ENC(enc);
   438		uint32_t dmdata_packet_enabled = 0;
 > 439		bool sdp_stream_enable = false;
   440	
   441		if (info_frame->vsc.valid) {
   442			enc->vpg->funcs->update_generic_info_packet(
   443					enc->vpg,
   444					0,  /* packetIndex */
   445					&info_frame->vsc);
   446			sdp_stream_enable = true;
   447		}
   448		if (info_frame->spd.valid) {
   449			enc->vpg->funcs->update_generic_info_packet(
   450					enc->vpg,
   451					2,  /* packetIndex */
   452					&info_frame->spd);
   453			sdp_stream_enable = true;
   454		}
   455		if (info_frame->hdrsmd.valid) {
   456			enc->vpg->funcs->update_generic_info_packet(
   457					enc->vpg,
   458					3,  /* packetIndex */
   459					&info_frame->hdrsmd);
   460			sdp_stream_enable = true;
   461		}
   462		/* enable/disable transmission of packet(s).
   463		 * If enabled, packet transmission begins on the next frame
   464		 */
   465		REG_UPDATE(DP_SYM32_ENC_SDP_GSP_CONTROL0, GSP_VIDEO_CONTINUOUS_TRANSMISSION_ENABLE, info_frame->vsc.valid);
   466		REG_UPDATE(DP_SYM32_ENC_SDP_GSP_CONTROL2, GSP_VIDEO_CONTINUOUS_TRANSMISSION_ENABLE, info_frame->spd.valid);
   467		REG_UPDATE(DP_SYM32_ENC_SDP_GSP_CONTROL3, GSP_VIDEO_CONTINUOUS_TRANSMISSION_ENABLE, info_frame->hdrsmd.valid);
   468	
   469		/* check if dynamic metadata packet transmission is enabled */
   470		REG_GET(DP_SYM32_ENC_SDP_METADATA_PACKET_CONTROL,
   471				METADATA_PACKET_ENABLE, &dmdata_packet_enabled);
   472	
   473		/* Enable secondary data path */
   474		REG_UPDATE(DP_SYM32_ENC_SDP_CONTROL,
   475				SDP_STREAM_ENABLE, 1);
   476	}
   477	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
