Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA9848E72F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 10:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237772AbiANJNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 04:13:40 -0500
Received: from mga06.intel.com ([134.134.136.31]:55322 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233450AbiANJNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 04:13:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642151618; x=1673687618;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RaOJVlZwiSIS8nodz6Kmpx4JyHIXqLC15AZgaDM31mo=;
  b=S7EoP7y+Ca73f2rXnSvyjjsL3qOvtL9uyxP1MQiumEOMLdywr4HYKQzl
   +sCxiiEIEmqUTJqPVBfxHSHEx/MJ1AxYcEdVr0EufuXFEYEOifvn0B4bL
   wmVXSuVHN/ipaAFTp9KMCq1zqQrOaCEeUgU1DoMn6sCEuIJVZvr+5HRTy
   bUUYP8AK5Ddy2BDJfhXZzozVgOpGaIn6LpVnyAEc7uE79HQHjP+5hqC0D
   Q+C3Wvpn59KpkmoCcN6eGhgdj3Qqp4NEqAkPut21OaxcP/WiXlpVz7R6F
   kDnm6LQcesyXYq8F2TAGoPrtkB6kpPmze7le5MIsUXTi+kh9dr0MCsVAw
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="304945615"
X-IronPort-AV: E=Sophos;i="5.88,288,1635231600"; 
   d="scan'208";a="304945615"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 01:13:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,288,1635231600"; 
   d="scan'208";a="516308942"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 14 Jan 2022 01:13:36 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8IeN-0008Lq-OC; Fri, 14 Jan 2022 09:13:35 +0000
Date:   Fri, 14 Jan 2022 17:13:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Fangzhi Zuo <Jerry.Zuo@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:4343:
 warning: expecting prototype for Return PCON's post FRL link training
 supported BW if its non(). Prototype was for intersect_frl_link_bw_support()
 instead
Message-ID: <202201141715.OhMqGKge-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fangzhi,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fb3b0673b7d5b477ed104949450cd511337ba3c6
commit: c022375ae0955b6d97ec438d658ab43a857a010f drm/amd/display: Add DP-HDMI FRL PCON Support in DC
date:   6 weeks ago
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220114/202201141715.OhMqGKge-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c022375ae0955b6d97ec438d658ab43a857a010f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout c022375ae0955b6d97ec438d658ab43a857a010f
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:4343: warning: Function parameter or member 'max_supported_frl_bw_in_kbps' not described in 'intersect_frl_link_bw_support'
   drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:4343: warning: Function parameter or member 'hdmi_encoded_link_bw' not described in 'intersect_frl_link_bw_support'
>> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:4343: warning: expecting prototype for Return PCON's post FRL link training supported BW if its non(). Prototype was for intersect_frl_link_bw_support() instead


vim +4343 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c

  4336	
  4337	/**
  4338	 * Return PCON's post FRL link training supported BW if its non-zero, otherwise return max_supported_frl_bw.
  4339	 */
  4340	static uint32_t intersect_frl_link_bw_support(
  4341		const uint32_t max_supported_frl_bw_in_kbps,
  4342		const union hdmi_encoded_link_bw hdmi_encoded_link_bw)
> 4343	{
  4344		uint32_t supported_bw_in_kbps = max_supported_frl_bw_in_kbps;
  4345	
  4346		// HDMI_ENCODED_LINK_BW bits are only valid if HDMI Link Configuration bit is 1 (FRL mode)
  4347		if (hdmi_encoded_link_bw.bits.FRL_MODE) {
  4348			if (hdmi_encoded_link_bw.bits.BW_48Gbps)
  4349				supported_bw_in_kbps = 48000000;
  4350			else if (hdmi_encoded_link_bw.bits.BW_40Gbps)
  4351				supported_bw_in_kbps = 40000000;
  4352			else if (hdmi_encoded_link_bw.bits.BW_32Gbps)
  4353				supported_bw_in_kbps = 32000000;
  4354			else if (hdmi_encoded_link_bw.bits.BW_24Gbps)
  4355				supported_bw_in_kbps = 24000000;
  4356			else if (hdmi_encoded_link_bw.bits.BW_18Gbps)
  4357				supported_bw_in_kbps = 18000000;
  4358			else if (hdmi_encoded_link_bw.bits.BW_9Gbps)
  4359				supported_bw_in_kbps = 9000000;
  4360		}
  4361	
  4362		return supported_bw_in_kbps;
  4363	}
  4364	#endif
  4365	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
