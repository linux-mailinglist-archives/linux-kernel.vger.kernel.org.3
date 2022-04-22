Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8B150AF9D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 07:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiDVFk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 01:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbiDVFdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 01:33:41 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BC64F445
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 22:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650605449; x=1682141449;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4ELds+ozdE9ev44uE/QSC+UYaWavPh95sp7UGSKykTU=;
  b=JVwkjvdl0j/CbbfN/LOVGGqJ6h5yxrr5+L5qmhy4vRNwg/F/2YjVlFzQ
   +Rx30LtxCFvm+A1tZr4lu7Ez2wZrt6+O2S+3O4PFb15hzhQJ2I+spxSlJ
   JKym/At3bUQCtm8/2MA91fp1AyL3muuGmMIrnyfovomIkLiFSz8eLW0AI
   raCcsiB9zh20sm+dgKqAyBkVlckYZv0A7iTNVnZa0mBtFmO5skwwSXuCB
   rwK9K9apUFXnG5+qds3ktq3ZKXmy1oYmnQW7NlrAUWJCderP/MS9mrxyZ
   Hu9NeM5iG9UD++useve690+bjrqdC0ZuF2l/lkplyQHkacX06qWuujzOB
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="351018044"
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="351018044"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 22:30:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="533972955"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 21 Apr 2022 22:30:47 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhlsU-0009Gj-J6;
        Fri, 22 Apr 2022 05:30:46 +0000
Date:   Fri, 22 Apr 2022 13:30:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Fangzhi Zuo <Jerry.Zuo@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c:439:14:
 warning: variable 'sdp_stream_enable' set but not used
Message-ID: <202204221332.ZuRIqlbM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fangzhi,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d569e86915b7f2f9795588591c8d5ea0b66481cb
commit: 83228ebb82e4fe2e5513f35d9b0b0eded3c44cbc drm/amd/display: Add DP 2.0 HPO Stream Encoder
date:   8 months ago
config: powerpc64-randconfig-r033-20220420 (https://download.01.org/0day-ci/archive/20220422/202204221332.ZuRIqlbM-lkp@intel.com/config)
compiler: powerpc64le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=83228ebb82e4fe2e5513f35d9b0b0eded3c44cbc
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 83228ebb82e4fe2e5513f35d9b0b0eded3c44cbc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/gpu/drm/

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
