Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0604947FDF0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 15:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237240AbhL0Ow3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 09:52:29 -0500
Received: from mga14.intel.com ([192.55.52.115]:48822 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237206AbhL0Ow1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 09:52:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640616747; x=1672152747;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1BRdNRI+8gn9reY4HQCp5TVhskgrjrgMwE8u9ac8Cv0=;
  b=EHrEWt1OM0gDfBmcps7HzHcytmt9DPeZ+S2Tu3yMChdUQeE5UESDeHTj
   6pV34GghsXV7EhQsptiXpues89zezb+6DyQNnZ8li8asGIANgT3aGgJZG
   cU9ocB8aSMNK2JRsAEhqTVcvVWXf0LKuzg2m09A8Is84m4rdKPfj5MQAG
   31e/nfxjRUfZYqUVTFH9w+XTHsuBZdUILe8npIckr+hV2VEZBCDLGHHfM
   5nwluKvWSRNN8K/9KBFwvyCNhzlrkAXrIytLiLX9KVmzaeujBMhH23Vfe
   GXjPLsaUku7pYTi+co/v91vQlOvRm6XrTEyEoJzZhSHrkCM6V95TbbAgj
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10209"; a="241433744"
X-IronPort-AV: E=Sophos;i="5.88,239,1635231600"; 
   d="scan'208";a="241433744"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2021 06:52:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,239,1635231600"; 
   d="scan'208";a="686304274"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 27 Dec 2021 06:52:22 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n1rML-0006Lu-Bb; Mon, 27 Dec 2021 14:52:21 +0000
Date:   Mon, 27 Dec 2021 22:51:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:1917:13:
 warning: stack frame size (2296) exceeds limit (2048) in
 'DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation'
Message-ID: <202112272211.3wi11WNb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fc74e0a40e4f9fd0468e34045b0c45bba11dcbb2
commit: 02c587733c8161355a43e6e110c2e29bd0acff72 kasan: remove redundant config option
date:   9 months ago
config: x86_64-randconfig-a004-20211227 (https://download.01.org/0day-ci/archive/20211227/202112272211.3wi11WNb-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 511726c64d3b6cca66f7c54d457d586aa3129f67)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=02c587733c8161355a43e6e110c2e29bd0acff72
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 02c587733c8161355a43e6e110c2e29bd0acff72
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:3052:10: warning: variable 'MaxUsedBW' set but not used [-Wunused-but-set-variable]
                   double MaxUsedBW = 0;
                          ^
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:1917:13: warning: stack frame size (2296) exceeds limit (2048) in 'DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation' [-Wframe-larger-than]
   static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation(
               ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:3641:6: warning: stack frame size (2840) exceeds limit (2048) in 'dml30_ModeSupportAndSystemConfigurationFull' [-Wframe-larger-than]
   void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
        ^
   3 warnings generated.


vim +/DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation +1917 drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c

6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1916  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21 @1917  static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation(
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1918  		struct display_mode_lib *mode_lib)
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1919  {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1920  	struct vba_vars_st *v = &mode_lib->vba;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1921  	unsigned int j, k;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1922  	long ReorderBytes = 0;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1923  	unsigned int PrefetchMode = v->PrefetchModePerState[v->VoltageLevel][v->maxMpcComb];
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1924  	double MaxTotalRDBandwidth = 0;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1925  	double MaxTotalRDBandwidthNoUrgentBurst = 0;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1926  	bool DestinationLineTimesForPrefetchLessThan2 = false;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1927  	bool VRatioPrefetchMoreThan4 = false;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1928  	double TWait;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1929  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1930  	v->WritebackDISPCLK = 0.0;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1931  	v->DISPCLKWithRamping = 0;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1932  	v->DISPCLKWithoutRamping = 0;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1933  	v->GlobalDPPCLK = 0.0;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1934  	/* DAL custom code: need to update ReturnBW in case min dcfclk is overriden */
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1935  	v->IdealSDPPortBandwidthPerState[v->VoltageLevel][v->maxMpcComb] = dml_min3(
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1936  			v->ReturnBusWidth * v->DCFCLK,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1937  			v->DRAMSpeedPerState[v->VoltageLevel] * v->NumberOfChannels * v->DRAMChannelWidth,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1938  			v->FabricClockPerState[v->VoltageLevel] * v->FabricDatapathToDCNDataReturn);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1939  	if (v->HostVMEnable != true) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1940  		v->ReturnBW = v->IdealSDPPortBandwidthPerState[v->VoltageLevel][v->maxMpcComb] * v->PercentOfIdealDRAMFabricAndSDPPortBWReceivedAfterUrgLatencyPixelDataOnly / 100;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1941  	} else {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1942  		v->ReturnBW = v->IdealSDPPortBandwidthPerState[v->VoltageLevel][v->maxMpcComb] * v->PercentOfIdealDRAMFabricAndSDPPortBWReceivedAfterUrgLatencyPixelMixedWithVMData / 100;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1943  	}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1944  	/* End DAL custom code */
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1945  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1946  	// DISPCLK and DPPCLK Calculation
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1947  	//
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1948  	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1949  		if (v->WritebackEnable[k]) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1950  			v->WritebackDISPCLK = dml_max(v->WritebackDISPCLK,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1951  				dml30_CalculateWriteBackDISPCLK(
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1952  						v->WritebackPixelFormat[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1953  						v->PixelClock[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1954  						v->WritebackHRatio[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1955  						v->WritebackVRatio[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1956  						v->WritebackHTaps[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1957  						v->WritebackVTaps[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1958  						v->WritebackSourceWidth[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1959  						v->WritebackDestinationWidth[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1960  						v->HTotal[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1961  						v->WritebackLineBufferSize));
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1962  		}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1963  	}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1964  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1965  	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1966  		if (v->HRatio[k] > 1) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1967  			v->PSCL_THROUGHPUT_LUMA[k] = dml_min(v->MaxDCHUBToPSCLThroughput,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1968  				v->MaxPSCLToLBThroughput * v->HRatio[k] / dml_ceil(v->htaps[k] / 6.0, 1));
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1969  		} else {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1970  			v->PSCL_THROUGHPUT_LUMA[k] = dml_min(
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1971  					v->MaxDCHUBToPSCLThroughput,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1972  					v->MaxPSCLToLBThroughput);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1973  		}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1974  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1975  		v->DPPCLKUsingSingleDPPLuma = v->PixelClock[k]
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1976  			* dml_max(v->vtaps[k] / 6.0 * dml_min(1.0, v->HRatio[k]),
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1977  				dml_max(v->HRatio[k] * v->VRatio[k] / v->PSCL_THROUGHPUT_LUMA[k], 1.0));
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1978  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1979  		if ((v->htaps[k] > 6 || v->vtaps[k] > 6)
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1980  				&& v->DPPCLKUsingSingleDPPLuma < 2 * v->PixelClock[k]) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1981  			v->DPPCLKUsingSingleDPPLuma = 2 * v->PixelClock[k];
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1982  		}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1983  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1984  		if ((v->SourcePixelFormat[k] != dm_420_8
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1985  				&& v->SourcePixelFormat[k] != dm_420_10
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1986  				&& v->SourcePixelFormat[k] != dm_420_12
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1987  				&& v->SourcePixelFormat[k] != dm_rgbe_alpha)) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1988  			v->PSCL_THROUGHPUT_CHROMA[k] = 0.0;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1989  			v->DPPCLKUsingSingleDPP[k] = v->DPPCLKUsingSingleDPPLuma;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1990  		} else {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1991  			if (v->HRatioChroma[k] > 1) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1992  				v->PSCL_THROUGHPUT_CHROMA[k] = dml_min(v->MaxDCHUBToPSCLThroughput,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1993  					v->MaxPSCLToLBThroughput * v->HRatioChroma[k] / dml_ceil(v->HTAPsChroma[k] / 6.0, 1.0));
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1994  			} else {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1995  				v->PSCL_THROUGHPUT_CHROMA[k] = dml_min(
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1996  						v->MaxDCHUBToPSCLThroughput,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1997  						v->MaxPSCLToLBThroughput);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1998  			}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  1999  			v->DPPCLKUsingSingleDPPChroma = v->PixelClock[k]
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2000  				* dml_max3(v->VTAPsChroma[k] / 6.0 * dml_min(1.0, v->HRatioChroma[k]),
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2001  					v->HRatioChroma[k] * v->VRatioChroma[k] / v->PSCL_THROUGHPUT_CHROMA[k], 1.0);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2002  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2003  			if ((v->HTAPsChroma[k] > 6 || v->VTAPsChroma[k] > 6)
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2004  					&& v->DPPCLKUsingSingleDPPChroma
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2005  							< 2 * v->PixelClock[k]) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2006  				v->DPPCLKUsingSingleDPPChroma = 2
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2007  						* v->PixelClock[k];
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2008  			}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2009  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2010  			v->DPPCLKUsingSingleDPP[k] = dml_max(
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2011  					v->DPPCLKUsingSingleDPPLuma,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2012  					v->DPPCLKUsingSingleDPPChroma);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2013  		}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2014  	}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2015  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2016  	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2017  		if (v->BlendingAndTiming[k] != k)
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2018  			continue;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2019  		if (v->ODMCombineEnabled[k] == dm_odm_combine_mode_4to1) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2020  			v->DISPCLKWithRamping = dml_max(v->DISPCLKWithRamping,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2021  				v->PixelClock[k] / 4 * (1 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100)
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2022  					* (1 + v->DISPCLKRampingMargin / 100));
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2023  			v->DISPCLKWithoutRamping = dml_max(v->DISPCLKWithoutRamping,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2024  				v->PixelClock[k] / 4 * (1 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100));
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2025  		} else if (v->ODMCombineEnabled[k] == dm_odm_combine_mode_2to1) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2026  			v->DISPCLKWithRamping = dml_max(v->DISPCLKWithRamping,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2027  				v->PixelClock[k] / 2 * (1 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100)
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2028  					* (1 + v->DISPCLKRampingMargin / 100));
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2029  			v->DISPCLKWithoutRamping = dml_max(v->DISPCLKWithoutRamping,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2030  				v->PixelClock[k] / 2 * (1 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100));
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2031  		} else {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2032  			v->DISPCLKWithRamping = dml_max(v->DISPCLKWithRamping,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2033  				v->PixelClock[k] * (1 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100)
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2034  									* (1 + v->DISPCLKRampingMargin / 100));
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2035  			v->DISPCLKWithoutRamping = dml_max(v->DISPCLKWithoutRamping,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2036  				v->PixelClock[k] * (1 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100));
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2037  		}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2038  	}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2039  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2040  	v->DISPCLKWithRamping = dml_max(
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2041  			v->DISPCLKWithRamping,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2042  			v->WritebackDISPCLK);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2043  	v->DISPCLKWithoutRamping = dml_max(
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2044  			v->DISPCLKWithoutRamping,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2045  			v->WritebackDISPCLK);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2046  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2047  	ASSERT(v->DISPCLKDPPCLKVCOSpeed != 0);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2048  	v->DISPCLKWithRampingRoundedToDFSGranularity = RoundToDFSGranularityUp(
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2049  			v->DISPCLKWithRamping,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2050  			v->DISPCLKDPPCLKVCOSpeed);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2051  	v->DISPCLKWithoutRampingRoundedToDFSGranularity = RoundToDFSGranularityUp(
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2052  			v->DISPCLKWithoutRamping,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2053  			v->DISPCLKDPPCLKVCOSpeed);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2054  	v->MaxDispclkRoundedToDFSGranularity = RoundToDFSGranularityDown(
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2055  			v->soc.clock_limits[mode_lib->soc.num_states].dispclk_mhz,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2056  			v->DISPCLKDPPCLKVCOSpeed);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2057  	if (v->DISPCLKWithoutRampingRoundedToDFSGranularity
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2058  			> v->MaxDispclkRoundedToDFSGranularity) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2059  		v->DISPCLK_calculated =
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2060  				v->DISPCLKWithoutRampingRoundedToDFSGranularity;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2061  	} else if (v->DISPCLKWithRampingRoundedToDFSGranularity
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2062  			> v->MaxDispclkRoundedToDFSGranularity) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2063  		v->DISPCLK_calculated = v->MaxDispclkRoundedToDFSGranularity;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2064  	} else {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2065  		v->DISPCLK_calculated =
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2066  				v->DISPCLKWithRampingRoundedToDFSGranularity;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2067  	}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2068  	v->DISPCLK = v->DISPCLK_calculated;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2069  	DTRACE("   dispclk_mhz (calculated) = %f", v->DISPCLK_calculated);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2070  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2071  	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2072  		v->DPPCLK_calculated[k] = v->DPPCLKUsingSingleDPP[k]
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2073  				/ v->DPPPerPlane[k]
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2074  				* (1 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2075  		v->GlobalDPPCLK = dml_max(
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2076  				v->GlobalDPPCLK,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2077  				v->DPPCLK_calculated[k]);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2078  	}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2079  	v->GlobalDPPCLK = RoundToDFSGranularityUp(
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2080  			v->GlobalDPPCLK,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2081  			v->DISPCLKDPPCLKVCOSpeed);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2082  	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2083  		v->DPPCLK_calculated[k] = v->GlobalDPPCLK / 255
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2084  				* dml_ceil(
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2085  						v->DPPCLK_calculated[k] * 255.0
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2086  								/ v->GlobalDPPCLK,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2087  						1);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2088  		DTRACE("   dppclk_mhz[%i] (calculated) = %f", k, v->DPPCLK_calculated[k]);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2089  		v->DPPCLK[k] = v->DPPCLK_calculated[k];
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2090  	}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2091  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2092  	// Urgent and B P-State/DRAM Clock Change Watermark
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2093  	DTRACE("   dcfclk_mhz         = %f", v->DCFCLK);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2094  	DTRACE("   return_bus_bw      = %f", v->ReturnBW);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2095  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2096  	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2097  		CalculateBytePerPixelAnd256BBlockSizes(
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2098  				v->SourcePixelFormat[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2099  				v->SurfaceTiling[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2100  				&v->BytePerPixelY[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2101  				&v->BytePerPixelC[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2102  				&v->BytePerPixelDETY[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2103  				&v->BytePerPixelDETC[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2104  				&v->BlockHeight256BytesY[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2105  				&v->BlockHeight256BytesC[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2106  				&v->BlockWidth256BytesY[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2107  				&v->BlockWidth256BytesC[k]);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2108  	}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2109  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2110  	CalculateSwathWidth(
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2111  			false,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2112  			v->NumberOfActivePlanes,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2113  			v->SourcePixelFormat,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2114  			v->SourceScan,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2115  			v->ViewportWidth,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2116  			v->ViewportHeight,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2117  			v->SurfaceWidthY,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2118  			v->SurfaceWidthC,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2119  			v->SurfaceHeightY,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2120  			v->SurfaceHeightC,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2121  			v->ODMCombineEnabled,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2122  			v->BytePerPixelY,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2123  			v->BytePerPixelC,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2124  			v->BlockHeight256BytesY,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2125  			v->BlockHeight256BytesC,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2126  			v->BlockWidth256BytesY,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2127  			v->BlockWidth256BytesC,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2128  			v->BlendingAndTiming,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2129  			v->HActive,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2130  			v->HRatio,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2131  			v->DPPPerPlane,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2132  			v->SwathWidthSingleDPPY,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2133  			v->SwathWidthSingleDPPC,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2134  			v->SwathWidthY,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2135  			v->SwathWidthC,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2136  			v->dummyinteger3,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2137  			v->dummyinteger4,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2138  			v->swath_width_luma_ub,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2139  			v->swath_width_chroma_ub);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2140  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2141  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2142  	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2143  		v->ReadBandwidthPlaneLuma[k] = v->SwathWidthSingleDPPY[k] * v->BytePerPixelY[k] / (v->HTotal[k] / v->PixelClock[k]) * v->VRatio[k];
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2144  		v->ReadBandwidthPlaneChroma[k] = v->SwathWidthSingleDPPC[k] * v->BytePerPixelC[k] / (v->HTotal[k] / v->PixelClock[k]) * v->VRatioChroma[k];
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2145  		DTRACE("read_bw[%i] = %fBps", k, v->ReadBandwidthPlaneLuma[k] + v->ReadBandwidthPlaneChroma[k]);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2146  	}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2147  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2148  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2149  	// DCFCLK Deep Sleep
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2150  	CalculateDCFCLKDeepSleep(
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2151  			mode_lib,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2152  			v->NumberOfActivePlanes,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2153  			v->BytePerPixelY,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2154  			v->BytePerPixelC,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2155  			v->VRatio,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2156  			v->VRatioChroma,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2157  			v->SwathWidthY,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2158  			v->SwathWidthC,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2159  			v->DPPPerPlane,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2160  			v->HRatio,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2161  			v->HRatioChroma,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2162  			v->PixelClock,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2163  			v->PSCL_THROUGHPUT_LUMA,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2164  			v->PSCL_THROUGHPUT_CHROMA,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2165  			v->DPPCLK,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2166  			v->ReadBandwidthPlaneLuma,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2167  			v->ReadBandwidthPlaneChroma,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2168  			v->ReturnBusWidth,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2169  			&v->DCFCLKDeepSleep);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2170  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2171  	// DSCCLK
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2172  	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2173  		if ((v->BlendingAndTiming[k] != k) || !v->DSCEnabled[k]) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2174  			v->DSCCLK_calculated[k] = 0.0;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2175  		} else {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2176  			if (v->OutputFormat[k] == dm_420)
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2177  				v->DSCFormatFactor = 2;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2178  			else if (v->OutputFormat[k] == dm_444)
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2179  				v->DSCFormatFactor = 1;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2180  			else if (v->OutputFormat[k] == dm_n422)
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2181  				v->DSCFormatFactor = 2;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2182  			else
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2183  				v->DSCFormatFactor = 1;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2184  			if (v->ODMCombineEnabled[k] == dm_odm_combine_mode_4to1)
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2185  				v->DSCCLK_calculated[k] = v->PixelClockBackEnd[k] / 12
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2186  					/ v->DSCFormatFactor / (1 - v->DISPCLKDPPCLKDSCCLKDownSpreading / 100);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2187  			else if (v->ODMCombineEnabled[k] == dm_odm_combine_mode_2to1)
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2188  				v->DSCCLK_calculated[k] = v->PixelClockBackEnd[k] / 6
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2189  					/ v->DSCFormatFactor / (1 - v->DISPCLKDPPCLKDSCCLKDownSpreading / 100);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2190  			else
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2191  				v->DSCCLK_calculated[k] = v->PixelClockBackEnd[k] / 3
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2192  					/ v->DSCFormatFactor / (1 - v->DISPCLKDPPCLKDSCCLKDownSpreading / 100);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2193  		}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2194  	}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2195  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2196  	// DSC Delay
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2197  	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2198  		double BPP = v->OutputBppPerState[k][v->VoltageLevel];
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2199  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2200  		if (v->DSCEnabled[k] && BPP != 0) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2201  			if (v->ODMCombineEnabled[k] == dm_odm_combine_mode_disabled) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2202  				v->DSCDelay[k] = dscceComputeDelay(v->DSCInputBitPerComponent[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2203  						BPP,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2204  						dml_ceil((double) v->HActive[k] / v->NumberOfDSCSlices[k], 1),
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2205  						v->NumberOfDSCSlices[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2206  						v->OutputFormat[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2207  						v->Output[k])
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2208  					+ dscComputeDelay(v->OutputFormat[k], v->Output[k]);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2209  			} else if (v->ODMCombineEnabled[k] == dm_odm_combine_mode_2to1) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2210  				v->DSCDelay[k] = 2 * dscceComputeDelay(v->DSCInputBitPerComponent[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2211  						BPP,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2212  						dml_ceil((double) v->HActive[k] / v->NumberOfDSCSlices[k], 1),
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2213  						v->NumberOfDSCSlices[k] / 2.0,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2214  						v->OutputFormat[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2215  						v->Output[k])
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2216  					+ dscComputeDelay(v->OutputFormat[k], v->Output[k]);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2217  			} else {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2218  				v->DSCDelay[k] = 4 * dscceComputeDelay(v->DSCInputBitPerComponent[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2219  						BPP,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2220  						dml_ceil((double) v->HActive[k] / v->NumberOfDSCSlices[k], 1),
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2221  						v->NumberOfDSCSlices[k] / 4.0,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2222  						v->OutputFormat[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2223  						v->Output[k])
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2224  					+ dscComputeDelay(v->OutputFormat[k], v->Output[k]);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2225  			}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2226  			v->DSCDelay[k] = v->DSCDelay[k] * v->PixelClock[k] / v->PixelClockBackEnd[k];
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2227  		} else {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2228  			v->DSCDelay[k] = 0;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2229  		}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2230  	}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2231  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2232  	for (k = 0; k < v->NumberOfActivePlanes; ++k)
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2233  		for (j = 0; j < v->NumberOfActivePlanes; ++j) // NumberOfPlanes
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2234  			if (j != k && v->BlendingAndTiming[k] == j
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2235  					&& v->DSCEnabled[j])
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2236  				v->DSCDelay[k] = v->DSCDelay[j];
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2237  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2238  	// Prefetch
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2239  	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2240  		unsigned int PDEAndMetaPTEBytesFrameY = 0;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2241  		unsigned int PixelPTEBytesPerRowY = 0;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2242  		unsigned int MetaRowByteY = 0;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2243  		unsigned int MetaRowByteC = 0;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2244  		unsigned int PDEAndMetaPTEBytesFrameC = 0;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2245  		unsigned int PixelPTEBytesPerRowC = 0;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2246  		bool         PTEBufferSizeNotExceededY = 0;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2247  		bool         PTEBufferSizeNotExceededC = 0;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2248  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2249  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2250  		if (v->SourcePixelFormat[k] == dm_420_8 || v->SourcePixelFormat[k] == dm_420_10 || v->SourcePixelFormat[k] == dm_420_12 || v->SourcePixelFormat[k] == dm_rgbe_alpha) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2251  			if ((v->SourcePixelFormat[k] == dm_420_10 || v->SourcePixelFormat[k] == dm_420_12) && v->SourceScan[k] != dm_vert) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2252  				v->PTEBufferSizeInRequestsForLuma = (v->PTEBufferSizeInRequestsLuma + v->PTEBufferSizeInRequestsChroma) / 2;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2253  				v->PTEBufferSizeInRequestsForChroma = v->PTEBufferSizeInRequestsForLuma;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2254  			} else {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2255  				v->PTEBufferSizeInRequestsForLuma = v->PTEBufferSizeInRequestsLuma;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2256  				v->PTEBufferSizeInRequestsForChroma = v->PTEBufferSizeInRequestsChroma;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2257  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2258  			}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2259  			PDEAndMetaPTEBytesFrameC = CalculateVMAndRowBytes(
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2260  					mode_lib,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2261  					v->DCCEnable[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2262  					v->BlockHeight256BytesC[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2263  					v->BlockWidth256BytesC[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2264  					v->SourcePixelFormat[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2265  					v->SurfaceTiling[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2266  					v->BytePerPixelC[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2267  					v->SourceScan[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2268  					v->SwathWidthC[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2269  					v->ViewportHeightChroma[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2270  					v->GPUVMEnable,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2271  					v->HostVMEnable,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2272  					v->HostVMMaxNonCachedPageTableLevels,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2273  					v->GPUVMMinPageSize,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2274  					v->HostVMMinPageSize,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2275  					v->PTEBufferSizeInRequestsForChroma,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2276  					v->PitchC[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2277  					v->DCCMetaPitchC[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2278  					&v->MacroTileWidthC[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2279  					&MetaRowByteC,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2280  					&PixelPTEBytesPerRowC,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2281  					&PTEBufferSizeNotExceededC,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2282  					&v->dpte_row_width_chroma_ub[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2283  					&v->dpte_row_height_chroma[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2284  					&v->meta_req_width_chroma[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2285  					&v->meta_req_height_chroma[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2286  					&v->meta_row_width_chroma[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2287  					&v->meta_row_height_chroma[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2288  					&v->dummyinteger1,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2289  					&v->dummyinteger2,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2290  					&v->PixelPTEReqWidthC[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2291  					&v->PixelPTEReqHeightC[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2292  					&v->PTERequestSizeC[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2293  					&v->dpde0_bytes_per_frame_ub_c[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2294  					&v->meta_pte_bytes_per_frame_ub_c[k]);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2295  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2296  			v->PrefetchSourceLinesC[k] = CalculatePrefetchSourceLines(
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2297  					mode_lib,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2298  					v->VRatioChroma[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2299  					v->VTAPsChroma[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2300  					v->Interlace[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2301  					v->ProgressiveToInterlaceUnitInOPP,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2302  					v->SwathHeightC[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2303  					v->ViewportYStartC[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2304  					&v->VInitPreFillC[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2305  					&v->MaxNumSwathC[k]);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2306  		} else {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2307  			v->PTEBufferSizeInRequestsForLuma = v->PTEBufferSizeInRequestsLuma + v->PTEBufferSizeInRequestsChroma;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2308  			v->PTEBufferSizeInRequestsForChroma = 0;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2309  			PixelPTEBytesPerRowC = 0;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2310  			PDEAndMetaPTEBytesFrameC = 0;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2311  			MetaRowByteC = 0;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2312  			v->MaxNumSwathC[k] = 0;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2313  			v->PrefetchSourceLinesC[k] = 0;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2314  		}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2315  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2316  		PDEAndMetaPTEBytesFrameY = CalculateVMAndRowBytes(
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2317  				mode_lib,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2318  				v->DCCEnable[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2319  				v->BlockHeight256BytesY[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2320  				v->BlockWidth256BytesY[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2321  				v->SourcePixelFormat[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2322  				v->SurfaceTiling[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2323  				v->BytePerPixelY[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2324  				v->SourceScan[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2325  				v->SwathWidthY[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2326  				v->ViewportHeight[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2327  				v->GPUVMEnable,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2328  				v->HostVMEnable,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2329  				v->HostVMMaxNonCachedPageTableLevels,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2330  				v->GPUVMMinPageSize,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2331  				v->HostVMMinPageSize,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2332  				v->PTEBufferSizeInRequestsForLuma,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2333  				v->PitchY[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2334  				v->DCCMetaPitchY[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2335  				&v->MacroTileWidthY[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2336  				&MetaRowByteY,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2337  				&PixelPTEBytesPerRowY,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2338  				&PTEBufferSizeNotExceededY,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2339  				&v->dpte_row_width_luma_ub[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2340  				&v->dpte_row_height[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2341  				&v->meta_req_width[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2342  				&v->meta_req_height[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2343  				&v->meta_row_width[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2344  				&v->meta_row_height[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2345  				&v->vm_group_bytes[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2346  				&v->dpte_group_bytes[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2347  				&v->PixelPTEReqWidthY[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2348  				&v->PixelPTEReqHeightY[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2349  				&v->PTERequestSizeY[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2350  				&v->dpde0_bytes_per_frame_ub_l[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2351  				&v->meta_pte_bytes_per_frame_ub_l[k]);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2352  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2353  		v->PrefetchSourceLinesY[k] = CalculatePrefetchSourceLines(
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2354  				mode_lib,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2355  				v->VRatio[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2356  				v->vtaps[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2357  				v->Interlace[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2358  				v->ProgressiveToInterlaceUnitInOPP,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2359  				v->SwathHeightY[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2360  				v->ViewportYStartY[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2361  				&v->VInitPreFillY[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2362  				&v->MaxNumSwathY[k]);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2363  		v->PixelPTEBytesPerRow[k] = PixelPTEBytesPerRowY + PixelPTEBytesPerRowC;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2364  		v->PDEAndMetaPTEBytesFrame[k] = PDEAndMetaPTEBytesFrameY
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2365  				+ PDEAndMetaPTEBytesFrameC;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2366  		v->MetaRowByte[k] = MetaRowByteY + MetaRowByteC;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2367  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2368  		CalculateRowBandwidth(
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2369  				v->GPUVMEnable,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2370  				v->SourcePixelFormat[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2371  				v->VRatio[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2372  				v->VRatioChroma[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2373  				v->DCCEnable[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2374  				v->HTotal[k] / v->PixelClock[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2375  				MetaRowByteY,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2376  				MetaRowByteC,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2377  				v->meta_row_height[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2378  				v->meta_row_height_chroma[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2379  				PixelPTEBytesPerRowY,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2380  				PixelPTEBytesPerRowC,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2381  				v->dpte_row_height[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2382  				v->dpte_row_height_chroma[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2383  				&v->meta_row_bw[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2384  				&v->dpte_row_bw[k]);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2385  	}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2386  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2387  	v->TotalDCCActiveDPP = 0;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2388  	v->TotalActiveDPP = 0;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2389  	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2390  		v->TotalActiveDPP = v->TotalActiveDPP
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2391  				+ v->DPPPerPlane[k];
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2392  		if (v->DCCEnable[k])
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2393  			v->TotalDCCActiveDPP = v->TotalDCCActiveDPP
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2394  					+ v->DPPPerPlane[k];
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2395  	}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2396  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2397  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2398  	ReorderBytes = v->NumberOfChannels * dml_max3(
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2399  		v->UrgentOutOfOrderReturnPerChannelPixelDataOnly,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2400  		v->UrgentOutOfOrderReturnPerChannelPixelMixedWithVMData,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2401  		v->UrgentOutOfOrderReturnPerChannelVMDataOnly);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2402  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2403  	v->UrgentExtraLatency = CalculateExtraLatency(
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2404  		v->RoundTripPingLatencyCycles,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2405  		ReorderBytes,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2406  		v->DCFCLK,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2407  		v->TotalActiveDPP,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2408  		v->PixelChunkSizeInKByte,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2409  		v->TotalDCCActiveDPP,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2410  		v->MetaChunkSize,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2411  		v->ReturnBW,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2412  		v->GPUVMEnable,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2413  		v->HostVMEnable,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2414  		v->NumberOfActivePlanes,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2415  		v->DPPPerPlane,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2416  		v->dpte_group_bytes,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2417  		v->PercentOfIdealDRAMFabricAndSDPPortBWReceivedAfterUrgLatencyPixelMixedWithVMData,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2418  		v->PercentOfIdealDRAMFabricAndSDPPortBWReceivedAfterUrgLatencyVMDataOnly,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2419  		v->HostVMMinPageSize,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2420  		v->HostVMMaxNonCachedPageTableLevels);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2421  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2422  	v->TCalc = 24.0 / v->DCFCLKDeepSleep;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2423  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2424  	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2425  		if (v->BlendingAndTiming[k] == k) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2426  			if (v->WritebackEnable[k] == true) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2427  				v->WritebackDelay[v->VoltageLevel][k] = v->WritebackLatency +
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2428  						CalculateWriteBackDelay(v->WritebackPixelFormat[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2429  									v->WritebackHRatio[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2430  									v->WritebackVRatio[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2431  									v->WritebackVTaps[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2432  									v->WritebackDestinationWidth[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2433  									v->WritebackDestinationHeight[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2434  									v->WritebackSourceHeight[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2435  									v->HTotal[k]) / v->DISPCLK;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2436  			} else
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2437  				v->WritebackDelay[v->VoltageLevel][k] = 0;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2438  			for (j = 0; j < v->NumberOfActivePlanes; ++j) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2439  				if (v->BlendingAndTiming[j] == k
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2440  						&& v->WritebackEnable[j] == true) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2441  					v->WritebackDelay[v->VoltageLevel][k] = dml_max(v->WritebackDelay[v->VoltageLevel][k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2442  							v->WritebackLatency + CalculateWriteBackDelay(
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2443  											v->WritebackPixelFormat[j],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2444  											v->WritebackHRatio[j],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2445  											v->WritebackVRatio[j],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2446  											v->WritebackVTaps[j],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2447  											v->WritebackDestinationWidth[j],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2448  											v->WritebackDestinationHeight[j],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2449  											v->WritebackSourceHeight[j],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2450  											v->HTotal[k]) / v->DISPCLK);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2451  				}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2452  			}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2453  		}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2454  	}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2455  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2456  	for (k = 0; k < v->NumberOfActivePlanes; ++k)
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2457  		for (j = 0; j < v->NumberOfActivePlanes; ++j)
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2458  			if (v->BlendingAndTiming[k] == j)
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2459  				v->WritebackDelay[v->VoltageLevel][k] = v->WritebackDelay[v->VoltageLevel][j];
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2460  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2461  	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2462  		v->MaxVStartupLines[k] = v->VTotal[k] - v->VActive[k] - dml_max(1.0, dml_ceil((double) v->WritebackDelay[v->VoltageLevel][k] / (v->HTotal[k] / v->PixelClock[k]), 1));
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2463  	}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2464  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2465  	v->MaximumMaxVStartupLines = 0;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2466  	for (k = 0; k < v->NumberOfActivePlanes; ++k)
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2467  		v->MaximumMaxVStartupLines = dml_max(v->MaximumMaxVStartupLines, v->MaxVStartupLines[k]);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2468  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2469  	if (v->DRAMClockChangeLatencyOverride > 0.0) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2470  		v->FinalDRAMClockChangeLatency = v->DRAMClockChangeLatencyOverride;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2471  	} else {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2472  		v->FinalDRAMClockChangeLatency = v->DRAMClockChangeLatency;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2473  	}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2474  	v->UrgentLatency = CalculateUrgentLatency(v->UrgentLatencyPixelDataOnly, v->UrgentLatencyPixelMixedWithVMData, v->UrgentLatencyVMDataOnly, v->DoUrgentLatencyAdjustment, v->UrgentLatencyAdjustmentFabricClockComponent, v->UrgentLatencyAdjustmentFabricClockReference, v->FabricClock);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2475  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2476  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2477  	v->FractionOfUrgentBandwidth = 0.0;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2478  	v->FractionOfUrgentBandwidthImmediateFlip = 0.0;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2479  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2480  	v->VStartupLines = 13;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2481  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2482  	do {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2483  		MaxTotalRDBandwidth = 0;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2484  		MaxTotalRDBandwidthNoUrgentBurst = 0;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2485  		DestinationLineTimesForPrefetchLessThan2 = false;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2486  		VRatioPrefetchMoreThan4 = false;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2487  		TWait = CalculateTWait(
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2488  				PrefetchMode,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2489  				v->FinalDRAMClockChangeLatency,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2490  				v->UrgentLatency,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2491  				v->SREnterPlusExitTime);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2492  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2493  		for (k = 0; k < v->NumberOfActivePlanes; ++k) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2494  			Pipe myPipe = { 0 };
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2495  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2496  			myPipe.DPPCLK = v->DPPCLK[k];
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2497  			myPipe.DISPCLK = v->DISPCLK;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2498  			myPipe.PixelClock = v->PixelClock[k];
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2499  			myPipe.DCFCLKDeepSleep = v->DCFCLKDeepSleep;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2500  			myPipe.DPPPerPlane = v->DPPPerPlane[k];
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2501  			myPipe.ScalerEnabled = v->ScalerEnabled[k];
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2502  			myPipe.SourceScan = v->SourceScan[k];
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2503  			myPipe.BlockWidth256BytesY = v->BlockWidth256BytesY[k];
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2504  			myPipe.BlockHeight256BytesY = v->BlockHeight256BytesY[k];
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2505  			myPipe.BlockWidth256BytesC = v->BlockWidth256BytesC[k];
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2506  			myPipe.BlockHeight256BytesC = v->BlockHeight256BytesC[k];
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2507  			myPipe.InterlaceEnable = v->Interlace[k];
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2508  			myPipe.NumberOfCursors = v->NumberOfCursors[k];
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2509  			myPipe.VBlank = v->VTotal[k] - v->VActive[k];
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2510  			myPipe.HTotal = v->HTotal[k];
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2511  			myPipe.DCCEnable = v->DCCEnable[k];
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2512  			myPipe.ODMCombineEnabled = !!v->ODMCombineEnabled[k];
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2513  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2514  			v->ErrorResult[k] = CalculatePrefetchSchedule(
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2515  					mode_lib,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2516  					v->PercentOfIdealDRAMFabricAndSDPPortBWReceivedAfterUrgLatencyPixelMixedWithVMData,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2517  					v->PercentOfIdealDRAMFabricAndSDPPortBWReceivedAfterUrgLatencyVMDataOnly,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2518  					&myPipe,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2519  					v->DSCDelay[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2520  					v->DPPCLKDelaySubtotal
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2521  							+ v->DPPCLKDelayCNVCFormater,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2522  					v->DPPCLKDelaySCL,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2523  					v->DPPCLKDelaySCLLBOnly,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2524  					v->DPPCLKDelayCNVCCursor,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2525  					v->DISPCLKDelaySubtotal,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2526  					(unsigned int) (v->SwathWidthY[k] / v->HRatio[k]),
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2527  					v->OutputFormat[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2528  					v->MaxInterDCNTileRepeaters,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2529  					dml_min(v->VStartupLines, v->MaxVStartupLines[k]),
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2530  					v->MaxVStartupLines[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2531  					v->GPUVMMaxPageTableLevels,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2532  					v->GPUVMEnable,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2533  					v->HostVMEnable,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2534  					v->HostVMMaxNonCachedPageTableLevels,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2535  					v->HostVMMinPageSize,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2536  					v->DynamicMetadataEnable[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2537  					v->DynamicMetadataVMEnabled,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2538  					v->DynamicMetadataLinesBeforeActiveRequired[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2539  					v->DynamicMetadataTransmittedBytes[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2540  					v->UrgentLatency,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2541  					v->UrgentExtraLatency,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2542  					v->TCalc,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2543  					v->PDEAndMetaPTEBytesFrame[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2544  					v->MetaRowByte[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2545  					v->PixelPTEBytesPerRow[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2546  					v->PrefetchSourceLinesY[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2547  					v->SwathWidthY[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2548  					v->BytePerPixelY[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2549  					v->VInitPreFillY[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2550  					v->MaxNumSwathY[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2551  					v->PrefetchSourceLinesC[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2552  					v->SwathWidthC[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2553  					v->BytePerPixelC[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2554  					v->VInitPreFillC[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2555  					v->MaxNumSwathC[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2556  					v->swath_width_luma_ub[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2557  					v->swath_width_chroma_ub[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2558  					v->SwathHeightY[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2559  					v->SwathHeightC[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2560  					TWait,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2561  					v->ProgressiveToInterlaceUnitInOPP,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2562  					&v->DSTXAfterScaler[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2563  					&v->DSTYAfterScaler[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2564  					&v->DestinationLinesForPrefetch[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2565  					&v->PrefetchBandwidth[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2566  					&v->DestinationLinesToRequestVMInVBlank[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2567  					&v->DestinationLinesToRequestRowInVBlank[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2568  					&v->VRatioPrefetchY[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2569  					&v->VRatioPrefetchC[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2570  					&v->RequiredPrefetchPixDataBWLuma[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2571  					&v->RequiredPrefetchPixDataBWChroma[k],
eaa483642f63cf Dmytro Laktyushkin 2020-06-15  2572  					&v->NotEnoughTimeForDynamicMetadata[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2573  					&v->Tno_bw[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2574  					&v->prefetch_vmrow_bw[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2575  					&v->Tdmdl_vm[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2576  					&v->Tdmdl[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2577  					&v->VUpdateOffsetPix[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2578  					&v->VUpdateWidthPix[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2579  					&v->VReadyOffsetPix[k]);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2580  			if (v->BlendingAndTiming[k] == k) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2581  				double TotalRepeaterDelayTime = v->MaxInterDCNTileRepeaters * (2 / v->DPPCLK[k] + 3 / v->DISPCLK);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2582  				v->VUpdateWidthPix[k] = (14 / v->DCFCLKDeepSleep + 12 / v->DPPCLK[k] + TotalRepeaterDelayTime) * v->PixelClock[k];
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2583  				v->VReadyOffsetPix[k] = dml_max(150.0 / v->DPPCLK[k], TotalRepeaterDelayTime + 20 / v->DCFCLKDeepSleep + 10 / v->DPPCLK[k]) * v->PixelClock[k];
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2584  				v->VUpdateOffsetPix[k] = dml_ceil(v->HTotal[k] / 4.0, 1);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2585  				v->VStartup[k] = dml_min(v->VStartupLines, v->MaxVStartupLines[k]);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2586  			} else {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2587  				int x = v->BlendingAndTiming[k];
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2588  				double TotalRepeaterDelayTime = v->MaxInterDCNTileRepeaters * (2 / v->DPPCLK[k] + 3 / v->DISPCLK);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2589  				v->VUpdateWidthPix[k] = (14 / v->DCFCLKDeepSleep + 12 / v->DPPCLK[k] + TotalRepeaterDelayTime) * v->PixelClock[x];
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2590  				v->VReadyOffsetPix[k] = dml_max(150.0 / v->DPPCLK[k], TotalRepeaterDelayTime + 20 / v->DCFCLKDeepSleep + 10 / v->DPPCLK[k]) * v->PixelClock[x];
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2591  				v->VUpdateOffsetPix[k] = dml_ceil(v->HTotal[x] / 4.0, 1);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2592  				if (!v->MaxVStartupLines[x])
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2593  					v->MaxVStartupLines[x] = v->MaxVStartupLines[k];
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2594  				v->VStartup[k] = dml_min(v->VStartupLines, v->MaxVStartupLines[x]);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2595  			}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2596  		}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2597  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2598  		v->NotEnoughUrgentLatencyHiding = false;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2599  		v->NotEnoughUrgentLatencyHidingPre = false;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2600  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2601  		for (k = 0; k < v->NumberOfActivePlanes; ++k) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2602  			v->cursor_bw[k] = v->NumberOfCursors[k]
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2603  					* v->CursorWidth[k][0] * v->CursorBPP[k][0]
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2604  					/ 8.0
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2605  					/ (v->HTotal[k] / v->PixelClock[k])
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2606  					* v->VRatio[k];
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2607  			v->cursor_bw_pre[k] = v->NumberOfCursors[k]
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2608  					* v->CursorWidth[k][0] * v->CursorBPP[k][0]
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2609  					/ 8.0
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2610  					/ (v->HTotal[k] / v->PixelClock[k])
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2611  					* v->VRatioPrefetchY[k];
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2612  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2613  			CalculateUrgentBurstFactor(
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2614  					v->swath_width_luma_ub[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2615  					v->swath_width_chroma_ub[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2616  					v->DETBufferSizeInKByte,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2617  					v->SwathHeightY[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2618  					v->SwathHeightC[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2619  					v->HTotal[k] / v->PixelClock[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2620  					v->UrgentLatency,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2621  					v->CursorBufferSize,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2622  					v->CursorWidth[k][0],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2623  					v->CursorBPP[k][0],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2624  					v->VRatio[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2625  					v->VRatioChroma[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2626  					v->BytePerPixelDETY[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2627  					v->BytePerPixelDETC[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2628  					v->DETBufferSizeY[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2629  					v->DETBufferSizeC[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2630  					&v->UrgentBurstFactorCursor[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2631  					&v->UrgentBurstFactorLuma[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2632  					&v->UrgentBurstFactorChroma[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2633  					&v->NoUrgentLatencyHiding[k]);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2634  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2635  			CalculateUrgentBurstFactor(
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2636  					v->swath_width_luma_ub[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2637  					v->swath_width_chroma_ub[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2638  					v->DETBufferSizeInKByte,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2639  					v->SwathHeightY[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2640  					v->SwathHeightC[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2641  					v->HTotal[k] / v->PixelClock[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2642  					v->UrgentLatency,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2643  					v->CursorBufferSize,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2644  					v->CursorWidth[k][0],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2645  					v->CursorBPP[k][0],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2646  					v->VRatioPrefetchY[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2647  					v->VRatioPrefetchC[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2648  					v->BytePerPixelDETY[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2649  					v->BytePerPixelDETC[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2650  					v->DETBufferSizeY[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2651  					v->DETBufferSizeC[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2652  					&v->UrgentBurstFactorCursorPre[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2653  					&v->UrgentBurstFactorLumaPre[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2654  					&v->UrgentBurstFactorChromaPre[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2655  					&v->NoUrgentLatencyHidingPre[k]);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2656  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2657  			MaxTotalRDBandwidth = MaxTotalRDBandwidth +
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2658  				dml_max3(v->DPPPerPlane[k] * v->prefetch_vmrow_bw[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2659  					v->ReadBandwidthPlaneLuma[k] *
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2660  					v->UrgentBurstFactorLuma[k] +
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2661  					v->ReadBandwidthPlaneChroma[k] *
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2662  					v->UrgentBurstFactorChroma[k] +
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2663  					v->cursor_bw[k] *
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2664  					v->UrgentBurstFactorCursor[k] +
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2665  					v->DPPPerPlane[k] * (v->meta_row_bw[k] + v->dpte_row_bw[k]),
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2666  					v->DPPPerPlane[k] * (v->RequiredPrefetchPixDataBWLuma[k] * v->UrgentBurstFactorLumaPre[k] +
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2667  						v->RequiredPrefetchPixDataBWChroma[k] * v->UrgentBurstFactorChromaPre[k]) + v->cursor_bw_pre[k] *
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2668  					v->UrgentBurstFactorCursorPre[k]);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2669  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2670  			MaxTotalRDBandwidthNoUrgentBurst = MaxTotalRDBandwidthNoUrgentBurst +
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2671  				dml_max3(v->DPPPerPlane[k] * v->prefetch_vmrow_bw[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2672  					v->ReadBandwidthPlaneLuma[k] +
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2673  					v->ReadBandwidthPlaneChroma[k] +
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2674  					v->cursor_bw[k] +
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2675  					v->DPPPerPlane[k] * (v->meta_row_bw[k] + v->dpte_row_bw[k]),
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2676  					v->DPPPerPlane[k] * (v->RequiredPrefetchPixDataBWLuma[k] + v->RequiredPrefetchPixDataBWChroma[k]) + v->cursor_bw_pre[k]);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2677  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2678  			if (v->DestinationLinesForPrefetch[k] < 2)
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2679  				DestinationLineTimesForPrefetchLessThan2 = true;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2680  			if (v->VRatioPrefetchY[k] > 4 || v->VRatioPrefetchC[k] > 4)
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2681  				VRatioPrefetchMoreThan4 = true;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2682  			if (v->NoUrgentLatencyHiding[k] == true)
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2683  				v->NotEnoughUrgentLatencyHiding = true;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2684  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2685  			if (v->NoUrgentLatencyHidingPre[k] == true)
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2686  				v->NotEnoughUrgentLatencyHidingPre = true;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2687  		}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2688  		v->FractionOfUrgentBandwidth = MaxTotalRDBandwidthNoUrgentBurst / v->ReturnBW;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2689  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2690  
eaa483642f63cf Dmytro Laktyushkin 2020-06-15  2691  		if (MaxTotalRDBandwidth <= v->ReturnBW && v->NotEnoughUrgentLatencyHiding == 0 && v->NotEnoughUrgentLatencyHidingPre == 0 && !VRatioPrefetchMoreThan4
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2692  				&& !DestinationLineTimesForPrefetchLessThan2)
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2693  			v->PrefetchModeSupported = true;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2694  		else {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2695  			v->PrefetchModeSupported = false;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2696  			dml_print("DML: CalculatePrefetchSchedule ***failed***. Bandwidth violation. Results are NOT valid\n");
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2697  			dml_print("DML: MaxTotalRDBandwidth:%f AvailReturnBandwidth:%f\n", MaxTotalRDBandwidth, v->ReturnBW);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2698  			dml_print("DML: VRatioPrefetch %s more than 4\n", (VRatioPrefetchMoreThan4) ? "is" : "is not");
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2699  			dml_print("DML: DestinationLines for Prefetch %s less than 2\n", (DestinationLineTimesForPrefetchLessThan2) ? "is" : "is not");
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2700  		}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2701  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2702  		if (v->PrefetchModeSupported == true && v->ImmediateFlipSupport == true) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2703  			v->BandwidthAvailableForImmediateFlip = v->ReturnBW;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2704  			for (k = 0; k < v->NumberOfActivePlanes; ++k) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2705  				v->BandwidthAvailableForImmediateFlip =
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2706  						v->BandwidthAvailableForImmediateFlip
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2707  								- dml_max(
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2708  										v->ReadBandwidthPlaneLuma[k] * v->UrgentBurstFactorLuma[k]
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2709  												+ v->ReadBandwidthPlaneChroma[k] * v->UrgentBurstFactorChroma[k]
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2710  												+ v->cursor_bw[k] * v->UrgentBurstFactorCursor[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2711  										v->DPPPerPlane[k] * (v->RequiredPrefetchPixDataBWLuma[k] * v->UrgentBurstFactorLumaPre[k] +
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2712  										v->RequiredPrefetchPixDataBWChroma[k] * v->UrgentBurstFactorChromaPre[k]) +
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2713  										v->cursor_bw_pre[k] * v->UrgentBurstFactorCursorPre[k]);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2714  			}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2715  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2716  			v->TotImmediateFlipBytes = 0;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2717  			for (k = 0; k < v->NumberOfActivePlanes; ++k) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2718  				v->TotImmediateFlipBytes = v->TotImmediateFlipBytes + v->DPPPerPlane[k] * (v->PDEAndMetaPTEBytesFrame[k] + v->MetaRowByte[k] + v->PixelPTEBytesPerRow[k]);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2719  			}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2720  			for (k = 0; k < v->NumberOfActivePlanes; ++k) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2721  				CalculateFlipSchedule(
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2722  						mode_lib,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2723  						v->PercentOfIdealDRAMFabricAndSDPPortBWReceivedAfterUrgLatencyPixelMixedWithVMData,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2724  						v->PercentOfIdealDRAMFabricAndSDPPortBWReceivedAfterUrgLatencyVMDataOnly,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2725  						v->UrgentExtraLatency,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2726  						v->UrgentLatency,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2727  						v->GPUVMMaxPageTableLevels,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2728  						v->HostVMEnable,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2729  						v->HostVMMaxNonCachedPageTableLevels,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2730  						v->GPUVMEnable,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2731  						v->HostVMMinPageSize,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2732  						v->PDEAndMetaPTEBytesFrame[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2733  						v->MetaRowByte[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2734  						v->PixelPTEBytesPerRow[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2735  						v->BandwidthAvailableForImmediateFlip,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2736  						v->TotImmediateFlipBytes,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2737  						v->SourcePixelFormat[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2738  						v->HTotal[k] / v->PixelClock[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2739  						v->VRatio[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2740  						v->VRatioChroma[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2741  						v->Tno_bw[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2742  						v->DCCEnable[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2743  						v->dpte_row_height[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2744  						v->meta_row_height[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2745  						v->dpte_row_height_chroma[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2746  						v->meta_row_height_chroma[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2747  						&v->DestinationLinesToRequestVMInImmediateFlip[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2748  						&v->DestinationLinesToRequestRowInImmediateFlip[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2749  						&v->final_flip_bw[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2750  						&v->ImmediateFlipSupportedForPipe[k]);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2751  			}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2752  			v->total_dcn_read_bw_with_flip = 0.0;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2753  			v->total_dcn_read_bw_with_flip_no_urgent_burst = 0.0;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2754  			for (k = 0; k < v->NumberOfActivePlanes; ++k) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2755  				v->total_dcn_read_bw_with_flip = v->total_dcn_read_bw_with_flip + dml_max3(
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2756  					v->DPPPerPlane[k] * v->prefetch_vmrow_bw[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2757  					v->DPPPerPlane[k] * v->final_flip_bw[k] +
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2758  					v->ReadBandwidthLuma[k] * v->UrgentBurstFactorLuma[k] +
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2759  					v->ReadBandwidthChroma[k] * v->UrgentBurstFactorChroma[k] +
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2760  					v->cursor_bw[k] * v->UrgentBurstFactorCursor[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2761  					v->DPPPerPlane[k] * (v->final_flip_bw[k] +
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2762  					v->RequiredPrefetchPixDataBWLuma[k] * v->UrgentBurstFactorLumaPre[k] +
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2763  					v->RequiredPrefetchPixDataBWChroma[k] * v->UrgentBurstFactorChromaPre[k]) +
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2764  					v->cursor_bw_pre[k] * v->UrgentBurstFactorCursorPre[k]);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2765  				v->total_dcn_read_bw_with_flip_no_urgent_burst =
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2766  					v->total_dcn_read_bw_with_flip_no_urgent_burst +
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2767  						dml_max3(v->DPPPerPlane[k] * v->prefetch_vmrow_bw[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2768  							v->DPPPerPlane[k] * v->final_flip_bw[k] + v->ReadBandwidthPlaneLuma[k] + v->ReadBandwidthPlaneChroma[k] + v->cursor_bw[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2769  							v->DPPPerPlane[k] * (v->final_flip_bw[k] + v->RequiredPrefetchPixDataBWLuma[k] + v->RequiredPrefetchPixDataBWChroma[k]) + v->cursor_bw_pre[k]);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2770  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2771  			}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2772  			v->FractionOfUrgentBandwidthImmediateFlip = v->total_dcn_read_bw_with_flip_no_urgent_burst / v->ReturnBW;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2773  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2774  			v->ImmediateFlipSupported = true;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2775  			if (v->total_dcn_read_bw_with_flip > v->ReturnBW) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2776  				v->ImmediateFlipSupported = false;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2777  				v->total_dcn_read_bw_with_flip = MaxTotalRDBandwidth;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2778  			}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2779  			for (k = 0; k < v->NumberOfActivePlanes; ++k) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2780  				if (v->ImmediateFlipSupportedForPipe[k] == false) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2781  					v->ImmediateFlipSupported = false;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2782  				}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2783  			}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2784  		} else {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2785  			v->ImmediateFlipSupported = false;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2786  		}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2787  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2788  		for (k = 0; k < v->NumberOfActivePlanes; ++k) {
eaa483642f63cf Dmytro Laktyushkin 2020-06-15  2789  			if (v->ErrorResult[k] || v->NotEnoughTimeForDynamicMetadata[k]) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2790  				v->PrefetchModeSupported = false;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2791  				dml_print("DML: CalculatePrefetchSchedule ***failed***. Prefetch schedule violation. Results are NOT valid\n");
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2792  			}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2793  		}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2794  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2795  		v->VStartupLines = v->VStartupLines + 1;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2796  		v->PrefetchAndImmediateFlipSupported = (v->PrefetchModeSupported == true && ((!v->ImmediateFlipSupport && !v->HostVMEnable && v->ImmediateFlipRequirement != dm_immediate_flip_required) || v->ImmediateFlipSupported)) ? true : false;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2797  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2798  	} while (!v->PrefetchModeSupported && v->VStartupLines <= v->MaximumMaxVStartupLines);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2799  	ASSERT(v->PrefetchModeSupported);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2800  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2801  	//Watermarks and NB P-State/DRAM Clock Change Support
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2802  	{
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2803  		enum clock_change_support   DRAMClockChangeSupport = 0; // dummy
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2804  		CalculateWatermarksAndDRAMSpeedChangeSupport(
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2805  			mode_lib,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2806  			PrefetchMode,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2807  			v->NumberOfActivePlanes,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2808  			v->MaxLineBufferLines,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2809  			v->LineBufferSize,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2810  			v->DPPOutputBufferPixels,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2811  			v->DETBufferSizeInKByte,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2812  			v->WritebackInterfaceBufferSize,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2813  			v->DCFCLK,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2814  			v->ReturnBW,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2815  			v->GPUVMEnable,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2816  			v->dpte_group_bytes,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2817  			v->MetaChunkSize,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2818  			v->UrgentLatency,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2819  			v->UrgentExtraLatency,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2820  			v->WritebackLatency,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2821  			v->WritebackChunkSize,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2822  			v->SOCCLK,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2823  			v->FinalDRAMClockChangeLatency,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2824  			v->SRExitTime,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2825  			v->SREnterPlusExitTime,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2826  			v->DCFCLKDeepSleep,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2827  			v->DPPPerPlane,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2828  			v->DCCEnable,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2829  			v->DPPCLK,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2830  			v->DETBufferSizeY,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2831  			v->DETBufferSizeC,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2832  			v->SwathHeightY,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2833  			v->SwathHeightC,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2834  			v->LBBitPerPixel,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2835  			v->SwathWidthY,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2836  			v->SwathWidthC,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2837  			v->HRatio,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2838  			v->HRatioChroma,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2839  			v->vtaps,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2840  			v->VTAPsChroma,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2841  			v->VRatio,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2842  			v->VRatioChroma,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2843  			v->HTotal,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2844  			v->PixelClock,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2845  			v->BlendingAndTiming,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2846  			v->BytePerPixelDETY,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2847  			v->BytePerPixelDETC,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2848  			v->DSTXAfterScaler,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2849  			v->DSTYAfterScaler,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2850  			v->WritebackEnable,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2851  			v->WritebackPixelFormat,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2852  			v->WritebackDestinationWidth,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2853  			v->WritebackDestinationHeight,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2854  			v->WritebackSourceHeight,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2855  			&DRAMClockChangeSupport,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2856  			&v->UrgentWatermark,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2857  			&v->WritebackUrgentWatermark,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2858  			&v->DRAMClockChangeWatermark,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2859  			&v->WritebackDRAMClockChangeWatermark,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2860  			&v->StutterExitWatermark,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2861  			&v->StutterEnterPlusExitWatermark,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2862  			&v->MinActiveDRAMClockChangeLatencySupported);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2863  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2864  		for (k = 0; k < v->NumberOfActivePlanes; ++k) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2865  			if (v->WritebackEnable[k] == true) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2866  				if (v->BlendingAndTiming[k] == k) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2867  					v->ThisVStartup = v->VStartup[k];
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2868  				} else {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2869  					for (j = 0; j < v->NumberOfActivePlanes; ++j) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2870  						if (v->BlendingAndTiming[k] == j) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2871  							v->ThisVStartup = v->VStartup[j];
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2872  						}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2873  					}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2874  				}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2875  				v->WritebackAllowDRAMClockChangeEndPosition[k] = dml_max(0,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2876  					v->ThisVStartup * v->HTotal[k] / v->PixelClock[k] - v->WritebackDRAMClockChangeWatermark);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2877  			} else {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2878  				v->WritebackAllowDRAMClockChangeEndPosition[k] = 0;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2879  			}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2880  		}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2881  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2882  	}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2883  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2884  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2885  	//Display Pipeline Delivery Time in Prefetch, Groups
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2886  	CalculatePixelDeliveryTimes(
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2887  			v->NumberOfActivePlanes,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2888  			v->VRatio,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2889  			v->VRatioChroma,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2890  			v->VRatioPrefetchY,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2891  			v->VRatioPrefetchC,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2892  			v->swath_width_luma_ub,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2893  			v->swath_width_chroma_ub,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2894  			v->DPPPerPlane,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2895  			v->HRatio,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2896  			v->HRatioChroma,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2897  			v->PixelClock,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2898  			v->PSCL_THROUGHPUT_LUMA,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2899  			v->PSCL_THROUGHPUT_CHROMA,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2900  			v->DPPCLK,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2901  			v->BytePerPixelC,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2902  			v->SourceScan,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2903  			v->NumberOfCursors,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2904  			v->CursorWidth,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2905  			v->CursorBPP,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2906  			v->BlockWidth256BytesY,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2907  			v->BlockHeight256BytesY,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2908  			v->BlockWidth256BytesC,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2909  			v->BlockHeight256BytesC,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2910  			v->DisplayPipeLineDeliveryTimeLuma,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2911  			v->DisplayPipeLineDeliveryTimeChroma,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2912  			v->DisplayPipeLineDeliveryTimeLumaPrefetch,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2913  			v->DisplayPipeLineDeliveryTimeChromaPrefetch,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2914  			v->DisplayPipeRequestDeliveryTimeLuma,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2915  			v->DisplayPipeRequestDeliveryTimeChroma,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2916  			v->DisplayPipeRequestDeliveryTimeLumaPrefetch,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2917  			v->DisplayPipeRequestDeliveryTimeChromaPrefetch,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2918  			v->CursorRequestDeliveryTime,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2919  			v->CursorRequestDeliveryTimePrefetch);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2920  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2921  	CalculateMetaAndPTETimes(
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2922  			v->NumberOfActivePlanes,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2923  			v->GPUVMEnable,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2924  			v->MetaChunkSize,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2925  			v->MinMetaChunkSizeBytes,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2926  			v->HTotal,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2927  			v->VRatio,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2928  			v->VRatioChroma,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2929  			v->DestinationLinesToRequestRowInVBlank,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2930  			v->DestinationLinesToRequestRowInImmediateFlip,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2931  			v->DCCEnable,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2932  			v->PixelClock,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2933  			v->BytePerPixelY,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2934  			v->BytePerPixelC,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2935  			v->SourceScan,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2936  			v->dpte_row_height,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2937  			v->dpte_row_height_chroma,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2938  			v->meta_row_width,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2939  			v->meta_row_width_chroma,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2940  			v->meta_row_height,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2941  			v->meta_row_height_chroma,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2942  			v->meta_req_width,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2943  			v->meta_req_width_chroma,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2944  			v->meta_req_height,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2945  			v->meta_req_height_chroma,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2946  			v->dpte_group_bytes,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2947  			v->PTERequestSizeY,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2948  			v->PTERequestSizeC,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2949  			v->PixelPTEReqWidthY,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2950  			v->PixelPTEReqHeightY,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2951  			v->PixelPTEReqWidthC,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2952  			v->PixelPTEReqHeightC,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2953  			v->dpte_row_width_luma_ub,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2954  			v->dpte_row_width_chroma_ub,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2955  			v->DST_Y_PER_PTE_ROW_NOM_L,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2956  			v->DST_Y_PER_PTE_ROW_NOM_C,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2957  			v->DST_Y_PER_META_ROW_NOM_L,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2958  			v->DST_Y_PER_META_ROW_NOM_C,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2959  			v->TimePerMetaChunkNominal,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2960  			v->TimePerChromaMetaChunkNominal,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2961  			v->TimePerMetaChunkVBlank,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2962  			v->TimePerChromaMetaChunkVBlank,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2963  			v->TimePerMetaChunkFlip,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2964  			v->TimePerChromaMetaChunkFlip,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2965  			v->time_per_pte_group_nom_luma,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2966  			v->time_per_pte_group_vblank_luma,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2967  			v->time_per_pte_group_flip_luma,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2968  			v->time_per_pte_group_nom_chroma,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2969  			v->time_per_pte_group_vblank_chroma,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2970  			v->time_per_pte_group_flip_chroma);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2971  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2972  	CalculateVMGroupAndRequestTimes(
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2973  			v->NumberOfActivePlanes,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2974  			v->GPUVMEnable,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2975  			v->GPUVMMaxPageTableLevels,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2976  			v->HTotal,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2977  			v->BytePerPixelC,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2978  			v->DestinationLinesToRequestVMInVBlank,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2979  			v->DestinationLinesToRequestVMInImmediateFlip,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2980  			v->DCCEnable,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2981  			v->PixelClock,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2982  			v->dpte_row_width_luma_ub,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2983  			v->dpte_row_width_chroma_ub,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2984  			v->vm_group_bytes,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2985  			v->dpde0_bytes_per_frame_ub_l,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2986  			v->dpde0_bytes_per_frame_ub_c,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2987  			v->meta_pte_bytes_per_frame_ub_l,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2988  			v->meta_pte_bytes_per_frame_ub_c,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2989  			v->TimePerVMGroupVBlank,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2990  			v->TimePerVMGroupFlip,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2991  			v->TimePerVMRequestVBlank,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2992  			v->TimePerVMRequestFlip);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2993  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2994  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2995  	// Min TTUVBlank
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2996  	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2997  		if (PrefetchMode == 0) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2998  			v->AllowDRAMClockChangeDuringVBlank[k] = true;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  2999  			v->AllowDRAMSelfRefreshDuringVBlank[k] = true;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3000  			v->MinTTUVBlank[k] = dml_max(
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3001  					v->DRAMClockChangeWatermark,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3002  					dml_max(
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3003  							v->StutterEnterPlusExitWatermark,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3004  							v->UrgentWatermark));
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3005  		} else if (PrefetchMode == 1) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3006  			v->AllowDRAMClockChangeDuringVBlank[k] = false;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3007  			v->AllowDRAMSelfRefreshDuringVBlank[k] = true;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3008  			v->MinTTUVBlank[k] = dml_max(
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3009  					v->StutterEnterPlusExitWatermark,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3010  					v->UrgentWatermark);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3011  		} else {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3012  			v->AllowDRAMClockChangeDuringVBlank[k] = false;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3013  			v->AllowDRAMSelfRefreshDuringVBlank[k] = false;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3014  			v->MinTTUVBlank[k] = v->UrgentWatermark;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3015  		}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3016  		if (!v->DynamicMetadataEnable[k])
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3017  			v->MinTTUVBlank[k] = v->TCalc
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3018  					+ v->MinTTUVBlank[k];
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3019  	}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3020  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3021  	// DCC Configuration
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3022  	v->ActiveDPPs = 0;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3023  	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3024  		CalculateDCCConfiguration(v->DCCEnable[k], false, // We should always know the direction DCCProgrammingAssumesScanDirectionUnknown,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3025  				v->SourcePixelFormat[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3026  				v->SurfaceWidthY[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3027  				v->SurfaceWidthC[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3028  				v->SurfaceHeightY[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3029  				v->SurfaceHeightC[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3030  				v->DETBufferSizeInKByte * 1024,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3031  				v->BlockHeight256BytesY[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3032  				v->BlockHeight256BytesC[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3033  				v->SurfaceTiling[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3034  				v->BytePerPixelY[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3035  				v->BytePerPixelC[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3036  				v->BytePerPixelDETY[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3037  				v->BytePerPixelDETC[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3038  				v->SourceScan[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3039  				&v->DCCYMaxUncompressedBlock[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3040  				&v->DCCCMaxUncompressedBlock[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3041  				&v->DCCYMaxCompressedBlock[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3042  				&v->DCCCMaxCompressedBlock[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3043  				&v->DCCYIndependentBlock[k],
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3044  				&v->DCCCIndependentBlock[k]);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3045  	}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3046  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3047  	{
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3048  		//Maximum Bandwidth Used
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3049  		double TotalWRBandwidth = 0;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3050  		double MaxPerPlaneVActiveWRBandwidth = 0;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3051  		double WRBandwidth = 0;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3052  		double MaxUsedBW = 0;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3053  		for (k = 0; k < v->NumberOfActivePlanes; ++k) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3054  			if (v->WritebackEnable[k] == true
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3055  					&& v->WritebackPixelFormat[k] == dm_444_32) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3056  				WRBandwidth = v->WritebackDestinationWidth[k] * v->WritebackDestinationHeight[k]
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3057  						/ (v->HTotal[k] * v->WritebackSourceHeight[k] / v->PixelClock[k]) * 4;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3058  			} else if (v->WritebackEnable[k] == true) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3059  				WRBandwidth = v->WritebackDestinationWidth[k] * v->WritebackDestinationHeight[k]
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3060  						/ (v->HTotal[k] * v->WritebackSourceHeight[k] / v->PixelClock[k]) * 8;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3061  			}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3062  			TotalWRBandwidth = TotalWRBandwidth + WRBandwidth;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3063  			MaxPerPlaneVActiveWRBandwidth = dml_max(MaxPerPlaneVActiveWRBandwidth, WRBandwidth);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3064  		}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3065  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3066  		v->TotalDataReadBandwidth = 0;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3067  		for (k = 0; k < v->NumberOfActivePlanes; ++k) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3068  			v->TotalDataReadBandwidth = v->TotalDataReadBandwidth
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3069  					+ v->ReadBandwidthPlaneLuma[k]
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3070  					+ v->ReadBandwidthPlaneChroma[k];
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3071  		}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3072  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3073  		{
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3074  			double MaxPerPlaneVActiveRDBandwidth = 0;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3075  			for (k = 0; k < v->NumberOfActivePlanes; ++k) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3076  				MaxPerPlaneVActiveRDBandwidth = dml_max(MaxPerPlaneVActiveRDBandwidth,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3077  						v->ReadBandwidthPlaneLuma[k] + v->ReadBandwidthPlaneChroma[k]);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3078  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3079  			}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3080  		}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3081  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3082  		MaxUsedBW = MaxTotalRDBandwidth + TotalWRBandwidth;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3083  	}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3084  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3085  	// VStartup Margin
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3086  	v->VStartupMargin = 0;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3087  	v->FirstMainPlane = true;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3088  	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3089  		if (v->BlendingAndTiming[k] == k) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3090  			double margin = (v->MaxVStartupLines[k] - v->VStartup[k]) * v->HTotal[k]
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3091  					/ v->PixelClock[k];
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3092  			if (v->FirstMainPlane == true) {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3093  				v->VStartupMargin = margin;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3094  				v->FirstMainPlane = false;
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3095  			} else {
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3096  				v->VStartupMargin = dml_min(v->VStartupMargin, margin);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3097  			}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3098  		}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3099  	}
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3100  
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3101  	// Stutter Efficiency
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3102  	CalculateStutterEfficiency(
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3103  			v->NumberOfActivePlanes,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3104  			v->ROBBufferSizeInKByte,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3105  			v->TotalDataReadBandwidth,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3106  			v->DCFCLK,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3107  			v->ReturnBW,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3108  			v->SRExitTime,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3109  			v->SynchronizedVBlank,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3110  			v->DPPPerPlane,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3111  			v->DETBufferSizeY,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3112  			v->BytePerPixelY,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3113  			v->BytePerPixelDETY,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3114  			v->SwathWidthY,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3115  			v->SwathHeightY,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3116  			v->SwathHeightC,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3117  			v->DCCRateLuma,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3118  			v->DCCRateChroma,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3119  			v->HTotal,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3120  			v->VTotal,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3121  			v->PixelClock,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3122  			v->VRatio,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3123  			v->SourceScan,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3124  			v->BlockHeight256BytesY,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3125  			v->BlockWidth256BytesY,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3126  			v->BlockHeight256BytesC,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3127  			v->BlockWidth256BytesC,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3128  			v->DCCYMaxUncompressedBlock,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3129  			v->DCCCMaxUncompressedBlock,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3130  			v->VActive,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3131  			v->DCCEnable,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3132  			v->WritebackEnable,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3133  			v->ReadBandwidthPlaneLuma,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3134  			v->ReadBandwidthPlaneChroma,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3135  			v->meta_row_bw,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3136  			v->dpte_row_bw,
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3137  			&v->StutterEfficiencyNotIncludingVBlank,
6b85151f6bcdb7 Martin Leung       2020-08-28  3138  			&v->StutterEfficiency,
6b85151f6bcdb7 Martin Leung       2020-08-28  3139  			&v->StutterPeriod);
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3140  }
6725a88f88a7e9 Bhawanpreet Lakha  2020-05-21  3141  

:::::: The code at line 1917 was first introduced by commit
:::::: 6725a88f88a7e922e91c45bf83d320487810c192 drm/amd/display: Add DCN3 DML

:::::: TO: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
