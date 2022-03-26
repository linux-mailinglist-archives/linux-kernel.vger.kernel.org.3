Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9359D4E8336
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 19:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234502AbiCZSZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 14:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbiCZSZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 14:25:08 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7009618B25D
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 11:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648319011; x=1679855011;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=enFmCdwCdCJeADzJVzSf/8+DS0xxg/52aeuzCXGPE70=;
  b=ZaqmWPBGoi7sxrVPARoVxPY9x0OuZ/9QRVjOqLsqHQi9moV7dSF3H+wa
   el2+i5UbRtOg/ptwEZ2ezEq+9OUFqO1V+CY9KR47UXZq4Ljq6LCd6bd6J
   0J9bZ3SSPo7MTAVfy68GoTT1A71BSV+azSwHHeNOH5rgCrHGHDZ7+7V5U
   yR4vwC/epBxhHjZm2lsvueIGviM770b95bhwkfkxity81RExFR9odHBqg
   Mj85d8yjpfhyx0vLkYqJDDLVEutMJZCRwy8XV8QFFAYt0NqRCmmQvWoIt
   b6zGc7ZBdgh2kmLgRwC77DIDBSqBy/ZlbqEBGSRsJCnGNNkQ2dkuL1VXg
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10298"; a="239397712"
X-IronPort-AV: E=Sophos;i="5.90,213,1643702400"; 
   d="scan'208";a="239397712"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2022 11:23:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,213,1643702400"; 
   d="scan'208";a="553506531"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 26 Mar 2022 11:23:29 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nYB4T-0000HK-30; Sat, 26 Mar 2022 18:23:29 +0000
Date:   Sun, 27 Mar 2022 02:22:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Fangzhi Zuo <Jerry.Zuo@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c:439:14:
 warning: variable 'sdp_stream_enable' set but not used
Message-ID: <202203270212.a3XLb3nU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   52d543b5497cf31d6baeb0bcfe5a5474c3238578
commit: 83228ebb82e4fe2e5513f35d9b0b0eded3c44cbc drm/amd/display: Add DP 2.0 HPO Stream Encoder
date:   7 months ago
config: powerpc64-randconfig-r015-20220325 (https://download.01.org/0day-ci/archive/20220327/202203270212.a3XLb3nU-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=83228ebb82e4fe2e5513f35d9b0b0eded3c44cbc
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 83228ebb82e4fe2e5513f35d9b0b0eded3c44cbc
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag as appropriate
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
