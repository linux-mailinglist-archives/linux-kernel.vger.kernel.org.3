Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8905AD8C4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 20:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbiIESEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 14:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbiIESEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 14:04:47 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC94F580
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 11:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662401085; x=1693937085;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Keq2HmkPNuhlyDlSt+oyoxdGnyYeoDKYKTyZgz45wrI=;
  b=K3pqVX/cxGeb1OkHI7L7if8CASSaO8kUFDzaIyX2H513MVRFffb5fshE
   Zy4jJkYHVGRUh4jLB/EtIDcDQOeLmiwXDhLkwRpa/M7oRPiGvOOlmE59T
   rzUUIGF89wmoj9BIRXWmZ8QdEqE1kgnD3thVk4W02utT/Yp67K+I3vAsc
   4vFgY8zMIpiaSQ0xeoEinmcmaMTxLkMM0uFYsz/ZIGh1cjsMQrK5ZzmnI
   lRCBXLGTRF4on4Md5l7wlpGFVhAVzrKl90icjDXWcov1BQFvRDBI99+wc
   ixfJXGUop48fZkvpgGFLEm6SMwGWialhNmkOFmUrcQTe7DxC3GhIcINIu
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="276828889"
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="276828889"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 11:04:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="590992934"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 05 Sep 2022 11:04:43 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oVGSg-0004P3-2z;
        Mon, 05 Sep 2022 18:04:42 +0000
Date:   Tue, 6 Sep 2022 02:03:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Fangzhi Zuo <Jerry.Zuo@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_apg.c:117:18:
 warning: variable 'channels' set but not used
Message-ID: <202209060159.tIsVfTJM-lkp@intel.com>
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
commit: 61452908a79ec936660494fb4b9f2a35ee42e6e0 drm/amd/display: Add DP 2.0 Audio Package Generator
date:   1 year ago
config: i386-buildonly-randconfig-r004-20220905 (https://download.01.org/0day-ci/archive/20220906/202209060159.tIsVfTJM-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=61452908a79ec936660494fb4b9f2a35ee42e6e0
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 61452908a79ec936660494fb4b9f2a35ee42e6e0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_apg.c: In function 'apg31_se_audio_setup':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_apg.c:117:18: warning: variable 'channels' set but not used [-Wunused-but-set-variable]
     117 |         uint32_t channels = 0;
         |                  ^~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_apg.c:116:18: warning: variable 'speakers' set but not used [-Wunused-but-set-variable]
     116 |         uint32_t speakers = 0;
         |                  ^~~~~~~~


vim +/channels +117 drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_apg.c

   108	
   109	static void apg31_se_audio_setup(
   110		struct apg *apg,
   111		unsigned int az_inst,
   112		struct audio_info *audio_info)
   113	{
   114		struct dcn31_apg *apg31 = DCN31_APG_FROM_APG(apg);
   115	
 > 116		uint32_t speakers = 0;
 > 117		uint32_t channels = 0;
   118	
   119		ASSERT(audio_info);
   120		/* This should not happen.it does so we don't get BSOD*/
   121		if (audio_info == NULL)
   122			return;
   123	
   124		speakers = audio_info->flags.info.ALLSPEAKERS;
   125		channels = speakers_to_channels(audio_info->flags.speaker_flags).all;
   126	
   127		/* DisplayPort only allows for one audio stream with stream ID 0 */
   128		REG_UPDATE(APG_CONTROL2, APG_DP_AUDIO_STREAM_ID, 0);
   129	
   130		/* When running in "pair mode", pairs of audio channels have their own enable
   131		 * this is for really old audio drivers */
   132		REG_UPDATE(APG_DBG_GEN_CONTROL, APG_DBG_AUDIO_CHANNEL_ENABLE, 0xF);
   133		// REG_UPDATE(APG_DBG_GEN_CONTROL, APG_DBG_AUDIO_CHANNEL_ENABLE, channels);
   134	
   135		/* Disable forced mem power off */
   136		REG_UPDATE(APG_MEM_PWR, APG_MEM_PWR_FORCE, 0);
   137	
   138		apg31_enable(apg);
   139	}
   140	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
