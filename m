Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9635555B4CF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 02:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiF0A4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 20:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiF0A4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 20:56:19 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9042BEB
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 17:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656291376; x=1687827376;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IYWMqVgSAe8IIwSU3qGwnLIPxAE7HQFbl2MblX05T/w=;
  b=E25cr454vlJmQ1D4vNj+vEV+m1nMdwFE/LUJ6YpNKUimKqSyBYKPJ0be
   6GUQqyVbNUWLtH3nHjqqiu3EDrJUF/8SmAb0cQsXO8Na1PtOFyQ8z8ow9
   Z/FTUbcpRa2Gm2GnHhzCqrSpU3vYArth399Yfh6C2P2i3sbh4fQGFMhkg
   xZRUV0w+hlOABUheq5excwL5VYtlvwT3dpZNxq/zK1k0mFtB7so0TnIzN
   +zK0R9PnXCNYY/cDz9a9axCf+jqnIu2Zfsd7TAiP9o1ixqCJlnBJ8VdDm
   JIS2aBJNL69PDHEhDSO2O4RmI0bdynkYktaIZKDNQnsXYlbi2QujL27Uj
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="270069543"
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="270069543"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2022 17:56:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="539905587"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 26 Jun 2022 17:56:13 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o5d2y-00081R-Ge;
        Mon, 27 Jun 2022 00:56:12 +0000
Date:   Mon, 27 Jun 2022 08:55:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alex Shi <alexs@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:3637:6:
 warning: stack frame size (2072) exceeds limit (2048) in
 'dml30_ModeSupportAndSystemConfigurationFull'
Message-ID: <202206270813.5fn4Mn8o-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   03c765b0e3b4cb5063276b086c76f7a612856a9a
commit: e8c07082a810fbb9db303a2b66b66b8d7e588b53 Kbuild: move to -std=gnu11
date:   4 months ago
config: x86_64-buildonly-randconfig-r004-20220627
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b0d6dd3905db145853c7c744ac92d49b00b1fa20)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e8c07082a810fbb9db303a2b66b66b8d7e588b53
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e8c07082a810fbb9db303a2b66b66b8d7e588b53
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:3055:10: warning: variable 'MaxUsedBW' set but not used [-Wunused-but-set-variable]
                   double MaxUsedBW = 0;
                          ^
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:3637:6: warning: stack frame size (2072) exceeds limit (2048) in 'dml30_ModeSupportAndSystemConfigurationFull' [-Wframe-larger-than]
   void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
        ^
   2 warnings generated.


vim +/dml30_ModeSupportAndSystemConfigurationFull +3637 drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c

6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3636  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21 @3637  void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3638  {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3639  	struct vba_vars_st *v = &mode_lib->vba;
61d861cf478576 Nicholas Kazlauskas 2020-05-13  3640  	int MinPrefetchMode, MaxPrefetchMode;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3641  	int i;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3642  	unsigned int j, k, m;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3643  	bool   EnoughWritebackUnits = true;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3644  	bool   WritebackModeSupport = true;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3645  	bool   ViewportExceedsSurface = false;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3646  	double MaxTotalVActiveRDBandwidth = 0;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3647  	long ReorderingBytes = 0;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3648  	bool NotUrgentLatencyHiding[DC__NUM_DPP__MAX] = { 0 };
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3649  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3650  	/*MODE SUPPORT, VOLTAGE STATE AND SOC CONFIGURATION*/
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3651  
61d861cf478576 Nicholas Kazlauskas 2020-05-13  3652  	CalculateMinAndMaxPrefetchMode(
61d861cf478576 Nicholas Kazlauskas 2020-05-13  3653  		mode_lib->vba.AllowDRAMSelfRefreshOrDRAMClockChangeInVblank,
61d861cf478576 Nicholas Kazlauskas 2020-05-13  3654  		&MinPrefetchMode, &MaxPrefetchMode);
61d861cf478576 Nicholas Kazlauskas 2020-05-13  3655  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3656  	/*Scale Ratio, taps Support Check*/
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3657  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3658  	v->ScaleRatioAndTapsSupport = true;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3659  	for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3660  		if (v->ScalerEnabled[k] == false
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3661  				&& ((v->SourcePixelFormat[k] != dm_444_64
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3662  						&& v->SourcePixelFormat[k] != dm_444_32
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3663  						&& v->SourcePixelFormat[k] != dm_444_16
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3664  						&& v->SourcePixelFormat[k] != dm_mono_16
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3665  						&& v->SourcePixelFormat[k] != dm_mono_8
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3666  						&& v->SourcePixelFormat[k] != dm_rgbe
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3667  						&& v->SourcePixelFormat[k] != dm_rgbe_alpha)
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3668  						|| v->HRatio[k] != 1.0
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3669  						|| v->htaps[k] != 1.0
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3670  						|| v->VRatio[k] != 1.0
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3671  						|| v->vtaps[k] != 1.0)) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3672  			v->ScaleRatioAndTapsSupport = false;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3673  		} else if (v->vtaps[k] < 1.0 || v->vtaps[k] > 8.0
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3674  				|| v->htaps[k] < 1.0 || v->htaps[k] > 8.0
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3675  				|| (v->htaps[k] > 1.0
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3676  						&& (v->htaps[k] % 2) == 1)
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3677  				|| v->HRatio[k] > v->MaxHSCLRatio
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3678  				|| v->VRatio[k] > v->MaxVSCLRatio
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3679  				|| v->HRatio[k] > v->htaps[k]
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3680  				|| v->VRatio[k] > v->vtaps[k]
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3681  				|| (v->SourcePixelFormat[k] != dm_444_64
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3682  						&& v->SourcePixelFormat[k] != dm_444_32
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3683  						&& v->SourcePixelFormat[k] != dm_444_16
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3684  						&& v->SourcePixelFormat[k] != dm_mono_16
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3685  						&& v->SourcePixelFormat[k] != dm_mono_8
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3686  						&& v->SourcePixelFormat[k] != dm_rgbe
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3687  						&& (v->VTAPsChroma[k] < 1
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3688  							|| v->VTAPsChroma[k] > 8
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3689  							|| v->HTAPsChroma[k] < 1
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3690  							|| v->HTAPsChroma[k] > 8
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3691  							|| (v->HTAPsChroma[k] > 1 && v->HTAPsChroma[k] % 2 == 1)
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3692  							|| v->HRatioChroma[k] > v->MaxHSCLRatio
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3693  							|| v->VRatioChroma[k] > v->MaxVSCLRatio
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3694  							|| v->HRatioChroma[k] > v->HTAPsChroma[k]
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3695  							|| v->VRatioChroma[k] > v->VTAPsChroma[k]))) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3696  			v->ScaleRatioAndTapsSupport = false;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3697  		}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3698  	}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3699  	/*Source Format, Pixel Format and Scan Support Check*/
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3700  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3701  	v->SourceFormatPixelAndScanSupport = true;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3702  	for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3703  		if ((v->SurfaceTiling[k] == dm_sw_linear && (!(v->SourceScan[k] != dm_vert) || v->DCCEnable[k] == true))
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3704  				|| ((v->SurfaceTiling[k] == dm_sw_64kb_d || v->SurfaceTiling[k] == dm_sw_64kb_d_t || v->SurfaceTiling[k] == dm_sw_64kb_d_x)
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3705  						&& !(v->SourcePixelFormat[k] == dm_444_64))) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3706  			v->SourceFormatPixelAndScanSupport = false;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3707  		}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3708  	}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3709  	/*Bandwidth Support Check*/
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3710  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3711  	for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3712  		CalculateBytePerPixelAnd256BBlockSizes(
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3713  				v->SourcePixelFormat[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3714  				v->SurfaceTiling[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3715  				&v->BytePerPixelY[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3716  				&v->BytePerPixelC[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3717  				&v->BytePerPixelInDETY[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3718  				&v->BytePerPixelInDETC[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3719  				&v->Read256BlockHeightY[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3720  				&v->Read256BlockHeightC[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3721  				&v->Read256BlockWidthY[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3722  				&v->Read256BlockWidthC[k]);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3723  	}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3724  	for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3725  		if (v->SourceScan[k] != dm_vert) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3726  			v->SwathWidthYSingleDPP[k] = v->ViewportWidth[k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3727  			v->SwathWidthCSingleDPP[k] = v->ViewportWidthChroma[k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3728  		} else {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3729  			v->SwathWidthYSingleDPP[k] = v->ViewportHeight[k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3730  			v->SwathWidthCSingleDPP[k] = v->ViewportHeightChroma[k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3731  		}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3732  	}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3733  	for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3734  		v->ReadBandwidthLuma[k] = v->SwathWidthYSingleDPP[k] * dml_ceil(v->BytePerPixelInDETY[k], 1.0) / (v->HTotal[k] / v->PixelClock[k]) * v->VRatio[k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3735  		v->ReadBandwidthChroma[k] = v->SwathWidthYSingleDPP[k] / 2 * dml_ceil(v->BytePerPixelInDETC[k], 2.0) / (v->HTotal[k] / v->PixelClock[k]) * v->VRatio[k] / 2.0;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3736  	}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3737  	for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3738  		if (v->WritebackEnable[k] == true
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3739  				&& v->WritebackPixelFormat[k] == dm_444_64) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3740  			v->WriteBandwidth[k] = v->WritebackDestinationWidth[k]
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3741  					* v->WritebackDestinationHeight[k]
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3742  					/ (v->WritebackSourceHeight[k]
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3743  							* v->HTotal[k]
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3744  							/ v->PixelClock[k]) * 8.0;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3745  		} else if (v->WritebackEnable[k] == true) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3746  			v->WriteBandwidth[k] = v->WritebackDestinationWidth[k]
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3747  					* v->WritebackDestinationHeight[k]
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3748  					/ (v->WritebackSourceHeight[k]
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3749  							* v->HTotal[k]
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3750  							/ v->PixelClock[k]) * 4.0;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3751  		} else {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3752  			v->WriteBandwidth[k] = 0.0;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3753  		}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3754  	}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3755  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3756  	/*Writeback Latency support check*/
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3757  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3758  	v->WritebackLatencySupport = true;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3759  	for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3760  		if (v->WritebackEnable[k] == true) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3761  			if (v->WritebackConfiguration == dm_whole_buffer_for_single_stream_no_interleave ||
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3762  			    v->WritebackConfiguration == dm_whole_buffer_for_single_stream_interleave) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3763  				if (v->WriteBandwidth[k]
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3764  						> 2.0 * v->WritebackInterfaceBufferSize * 1024
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3765  								/ v->WritebackLatency) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3766  					v->WritebackLatencySupport = false;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3767  				}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3768  			} else {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3769  				if (v->WriteBandwidth[k]
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3770  						> v->WritebackInterfaceBufferSize * 1024
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3771  								/ v->WritebackLatency) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3772  					v->WritebackLatencySupport = false;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3773  				}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3774  			}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3775  		}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3776  	}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3777  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3778  	/*Writeback Mode Support Check*/
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3779  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3780  	v->TotalNumberOfActiveWriteback = 0;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3781  	for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3782  		if (v->WritebackEnable[k] == true) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3783  			v->TotalNumberOfActiveWriteback =
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3784  					v->TotalNumberOfActiveWriteback + 1;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3785  		}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3786  	}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3787  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3788  	if (v->TotalNumberOfActiveWriteback > v->MaxNumWriteback) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3789  		EnoughWritebackUnits = false;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3790  	}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3791  	if (!v->WritebackSupportInterleaveAndUsingWholeBufferForASingleStream
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3792  			&& (v->WritebackConfiguration == dm_whole_buffer_for_single_stream_no_interleave
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3793  					|| v->WritebackConfiguration == dm_whole_buffer_for_single_stream_interleave)) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3794  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3795  		WritebackModeSupport = false;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3796  	}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3797  	if (v->WritebackConfiguration == dm_whole_buffer_for_single_stream_no_interleave && v->TotalNumberOfActiveWriteback > 1) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3798  		WritebackModeSupport = false;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3799  	}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3800  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3801  	/*Writeback Scale Ratio and Taps Support Check*/
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3802  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3803  	v->WritebackScaleRatioAndTapsSupport = true;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3804  	for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3805  		if (v->WritebackEnable[k] == true) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3806  			if (v->WritebackHRatio[k] > v->WritebackMaxHSCLRatio
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3807  					|| v->WritebackVRatio[k]
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3808  							> v->WritebackMaxVSCLRatio
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3809  					|| v->WritebackHRatio[k]
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3810  							< v->WritebackMinHSCLRatio
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3811  					|| v->WritebackVRatio[k]
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3812  							< v->WritebackMinVSCLRatio
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3813  					|| v->WritebackHTaps[k]
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3814  							> v->WritebackMaxHSCLTaps
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3815  					|| v->WritebackVTaps[k]
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3816  							> v->WritebackMaxVSCLTaps
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3817  					|| v->WritebackHRatio[k]
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3818  							> v->WritebackHTaps[k]
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3819  					|| v->WritebackVRatio[k]
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3820  							> v->WritebackVTaps[k]
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3821  					|| (v->WritebackHTaps[k] > 2.0
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3822  							&& ((v->WritebackHTaps[k] % 2)
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3823  									== 1))) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3824  				v->WritebackScaleRatioAndTapsSupport = false;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3825  			}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3826  			if (2.0 * v->WritebackDestinationWidth[k] * (v->WritebackVTaps[k] - 1) * 57 > v->WritebackLineBufferSize) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3827  				v->WritebackScaleRatioAndTapsSupport = false;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3828  			}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3829  		}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3830  	}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3831  	/*Maximum DISPCLK/DPPCLK Support check*/
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3832  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3833  	v->WritebackRequiredDISPCLK = 0.0;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3834  	for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3835  		if (v->WritebackEnable[k] == true) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3836  			v->WritebackRequiredDISPCLK = dml_max(v->WritebackRequiredDISPCLK,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3837  					dml30_CalculateWriteBackDISPCLK(
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3838  							v->WritebackPixelFormat[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3839  							v->PixelClock[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3840  							v->WritebackHRatio[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3841  							v->WritebackVRatio[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3842  							v->WritebackHTaps[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3843  							v->WritebackVTaps[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3844  							v->WritebackSourceWidth[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3845  							v->WritebackDestinationWidth[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3846  							v->HTotal[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3847  							v->WritebackLineBufferSize));
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3848  		}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3849  	}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3850  	for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3851  		if (v->HRatio[k] > 1.0) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3852  			v->PSCL_FACTOR[k] = dml_min(v->MaxDCHUBToPSCLThroughput, v->MaxPSCLToLBThroughput * v->HRatio[k] / dml_ceil(v->htaps[k] / 6.0, 1.0));
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3853  		} else {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3854  			v->PSCL_FACTOR[k] = dml_min(v->MaxDCHUBToPSCLThroughput, v->MaxPSCLToLBThroughput);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3855  		}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3856  		if (v->BytePerPixelC[k] == 0.0) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3857  			v->PSCL_FACTOR_CHROMA[k] = 0.0;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3858  			v->MinDPPCLKUsingSingleDPP[k] = v->PixelClock[k]
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3859  					* dml_max3(v->vtaps[k] / 6.0 * dml_min(1.0, v->HRatio[k]), v->HRatio[k] * v->VRatio[k] / v->PSCL_FACTOR[k], 1.0);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3860  			if ((v->htaps[k] > 6.0 || v->vtaps[k] > 6.0) && v->MinDPPCLKUsingSingleDPP[k] < 2.0 * v->PixelClock[k]) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3861  				v->MinDPPCLKUsingSingleDPP[k] = 2.0 * v->PixelClock[k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3862  			}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3863  		} else {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3864  			if (v->HRatioChroma[k] > 1.0) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3865  				v->PSCL_FACTOR_CHROMA[k] = dml_min(v->MaxDCHUBToPSCLThroughput,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3866  						v->MaxPSCLToLBThroughput * v->HRatioChroma[k] / dml_ceil(v->HTAPsChroma[k] / 6.0, 1.0));
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3867  			} else {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3868  				v->PSCL_FACTOR_CHROMA[k] = dml_min(v->MaxDCHUBToPSCLThroughput, v->MaxPSCLToLBThroughput);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3869  			}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3870  			v->MinDPPCLKUsingSingleDPP[k] = v->PixelClock[k] * dml_max5(v->vtaps[k] / 6.0 * dml_min(1.0, v->HRatio[k]),
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3871  							v->HRatio[k] * v->VRatio[k] / v->PSCL_FACTOR[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3872  							v->VTAPsChroma[k] / 6.0 * dml_min(1.0, v->HRatioChroma[k]),
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3873  							v->HRatioChroma[k] * v->VRatioChroma[k] / v->PSCL_FACTOR_CHROMA[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3874  							1.0);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3875  			if ((v->htaps[k] > 6.0 || v->vtaps[k] > 6.0 || v->HTAPsChroma[k] > 6.0 || v->VTAPsChroma[k] > 6.0)
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3876  					&& v->MinDPPCLKUsingSingleDPP[k] < 2.0 * v->PixelClock[k]) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3877  				v->MinDPPCLKUsingSingleDPP[k] = 2.0 * v->PixelClock[k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3878  			}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3879  		}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3880  	}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3881  	for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3882  		int MaximumSwathWidthSupportLuma = 0;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3883  		int MaximumSwathWidthSupportChroma = 0;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3884  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3885  		if (v->SurfaceTiling[k] == dm_sw_linear) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3886  			MaximumSwathWidthSupportLuma = 8192.0;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3887  		} else if (v->SourceScan[k] == dm_vert && v->BytePerPixelC[k] > 0) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3888  			MaximumSwathWidthSupportLuma = 2880.0;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3889  		} else {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3890  			MaximumSwathWidthSupportLuma = 5760.0;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3891  		}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3892  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3893  		if (v->SourcePixelFormat[k] == dm_420_8 || v->SourcePixelFormat[k] == dm_420_10 || v->SourcePixelFormat[k] == dm_420_12) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3894  			MaximumSwathWidthSupportChroma = MaximumSwathWidthSupportLuma / 2.0;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3895  		} else {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3896  			MaximumSwathWidthSupportChroma = MaximumSwathWidthSupportLuma;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3897  		}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3898  		v->MaximumSwathWidthInLineBufferLuma = v->LineBufferSize * dml_max(v->HRatio[k], 1.0) / v->LBBitPerPixel[k]
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3899  				/ (v->vtaps[k] + dml_max(dml_ceil(v->VRatio[k], 1.0) - 2, 0.0));
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3900  		if (v->BytePerPixelC[k] == 0.0) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3901  			v->MaximumSwathWidthInLineBufferChroma = 0;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3902  		} else {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3903  			v->MaximumSwathWidthInLineBufferChroma = v->LineBufferSize * dml_max(v->HRatioChroma[k], 1.0) / v->LBBitPerPixel[k]
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3904  					/ (v->VTAPsChroma[k] + dml_max(dml_ceil(v->VRatioChroma[k], 1.0) - 2, 0.0));
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3905  		}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3906  		v->MaximumSwathWidthLuma[k] = dml_min(MaximumSwathWidthSupportLuma, v->MaximumSwathWidthInLineBufferLuma);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3907  		v->MaximumSwathWidthChroma[k] = dml_min(MaximumSwathWidthSupportChroma, v->MaximumSwathWidthInLineBufferChroma);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3908  	}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3909  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3910  	CalculateSwathAndDETConfiguration(
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3911  			true,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3912  			v->NumberOfActivePlanes,
4469201b19354a Chaitanya Dhere     2021-04-20  3913  			v->DETBufferSizeInKByte[0],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3914  			v->MaximumSwathWidthLuma,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3915  			v->MaximumSwathWidthChroma,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3916  			v->SourceScan,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3917  			v->SourcePixelFormat,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3918  			v->SurfaceTiling,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3919  			v->ViewportWidth,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3920  			v->ViewportHeight,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3921  			v->SurfaceWidthY,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3922  			v->SurfaceWidthC,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3923  			v->SurfaceHeightY,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3924  			v->SurfaceHeightC,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3925  			v->Read256BlockHeightY,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3926  			v->Read256BlockHeightC,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3927  			v->Read256BlockWidthY,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3928  			v->Read256BlockWidthC,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3929  			v->odm_combine_dummy,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3930  			v->BlendingAndTiming,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3931  			v->BytePerPixelY,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3932  			v->BytePerPixelC,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3933  			v->BytePerPixelInDETY,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3934  			v->BytePerPixelInDETC,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3935  			v->HActive,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3936  			v->HRatio,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3937  			v->HRatioChroma,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3938  			v->DPPPerPlane,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3939  			v->swath_width_luma_ub,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3940  			v->swath_width_chroma_ub,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3941  			v->SwathWidthY,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3942  			v->SwathWidthC,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3943  			v->SwathHeightY,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3944  			v->SwathHeightC,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3945  			v->DETBufferSizeY,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3946  			v->DETBufferSizeC,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3947  			v->SingleDPPViewportSizeSupportPerPlane,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3948  			&v->ViewportSizeSupport[0][0]);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3949  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3950  	for (i = 0; i < v->soc.num_states; i++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3951  		for (j = 0; j < 2; j++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3952  			v->MaxDispclkRoundedDownToDFSGranularity = RoundToDFSGranularityDown(v->MaxDispclk[i], v->DISPCLKDPPCLKVCOSpeed);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3953  			v->MaxDppclkRoundedDownToDFSGranularity = RoundToDFSGranularityDown(v->MaxDppclk[i], v->DISPCLKDPPCLKVCOSpeed);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3954  			v->RequiredDISPCLK[i][j] = 0.0;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3955  			v->DISPCLK_DPPCLK_Support[i][j] = true;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3956  			for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3957  				v->PlaneRequiredDISPCLKWithoutODMCombine = v->PixelClock[k] * (1.0 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0)
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3958  						* (1.0 + v->DISPCLKRampingMargin / 100.0);
e4e3678260e973 Wesley Chalmers     2021-04-28  3959  				if ((v->PlaneRequiredDISPCLKWithoutODMCombine >= v->MaxDispclk[i] && v->MaxDispclk[i] == v->MaxDispclk[mode_lib->soc.num_states - 1]
e4e3678260e973 Wesley Chalmers     2021-04-28  3960  						&& v->MaxDppclk[i] == v->MaxDppclk[mode_lib->soc.num_states - 1])) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3961  					v->PlaneRequiredDISPCLKWithoutODMCombine = v->PixelClock[k] * (1 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3962  				}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3963  				v->PlaneRequiredDISPCLKWithODMCombine2To1 = v->PixelClock[k] / 2 * (1 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0)
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3964  						* (1 + v->DISPCLKRampingMargin / 100.0);
e4e3678260e973 Wesley Chalmers     2021-04-28  3965  				if ((v->PlaneRequiredDISPCLKWithODMCombine2To1 >= v->MaxDispclk[i] && v->MaxDispclk[i] == v->MaxDispclk[mode_lib->soc.num_states - 1]
e4e3678260e973 Wesley Chalmers     2021-04-28  3966  						&& v->MaxDppclk[i] == v->MaxDppclk[mode_lib->soc.num_states - 1])) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3967  					v->PlaneRequiredDISPCLKWithODMCombine2To1 = v->PixelClock[k] / 2 * (1 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3968  				}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3969  				v->PlaneRequiredDISPCLKWithODMCombine4To1 = v->PixelClock[k] / 4 * (1 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0)
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3970  						* (1 + v->DISPCLKRampingMargin / 100.0);
e4e3678260e973 Wesley Chalmers     2021-04-28  3971  				if ((v->PlaneRequiredDISPCLKWithODMCombine4To1 >= v->MaxDispclk[i] && v->MaxDispclk[i] == v->MaxDispclk[mode_lib->soc.num_states - 1]
e4e3678260e973 Wesley Chalmers     2021-04-28  3972  						&& v->MaxDppclk[i] == v->MaxDppclk[mode_lib->soc.num_states - 1])) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3973  					v->PlaneRequiredDISPCLKWithODMCombine4To1 = v->PixelClock[k] / 4 * (1 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3974  				}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3975  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3976  				if (v->ODMCombinePolicy == dm_odm_combine_policy_none) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3977  					v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_disabled;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3978  					v->PlaneRequiredDISPCLK = v->PlaneRequiredDISPCLKWithoutODMCombine;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3979  				} else if (v->ODMCombinePolicy == dm_odm_combine_policy_2to1) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3980  					v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_2to1;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3981  					v->PlaneRequiredDISPCLK = v->PlaneRequiredDISPCLKWithODMCombine2To1;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3982  				} else if (v->ODMCombinePolicy == dm_odm_combine_policy_4to1
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3983  						|| v->PlaneRequiredDISPCLKWithODMCombine2To1 > v->MaxDispclkRoundedDownToDFSGranularity) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3984  					v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_4to1;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3985  					v->PlaneRequiredDISPCLK = v->PlaneRequiredDISPCLKWithODMCombine4To1;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3986  				} else if (v->PlaneRequiredDISPCLKWithoutODMCombine > v->MaxDispclkRoundedDownToDFSGranularity) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3987  					v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_2to1;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3988  					v->PlaneRequiredDISPCLK = v->PlaneRequiredDISPCLKWithODMCombine2To1;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3989  				} else {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3990  					v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_disabled;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  3991  					v->PlaneRequiredDISPCLK = v->PlaneRequiredDISPCLKWithoutODMCombine;
346cf627fb27c0 Nikola Cornij       2021-05-18  3992  				}
346cf627fb27c0 Nikola Cornij       2021-05-18  3993  				if (v->DSCEnabled[k] && v->HActive[k] > DCN30_MAX_DSC_IMAGE_WIDTH
346cf627fb27c0 Nikola Cornij       2021-05-18  3994  						&& v->ODMCombineEnablePerState[i][k] != dm_odm_combine_mode_4to1) {
346cf627fb27c0 Nikola Cornij       2021-05-18  3995  					if (v->HActive[k] / 2 > DCN30_MAX_DSC_IMAGE_WIDTH) {
346cf627fb27c0 Nikola Cornij       2021-05-18  3996  						v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_4to1;
346cf627fb27c0 Nikola Cornij       2021-05-18  3997  						v->PlaneRequiredDISPCLK = v->PlaneRequiredDISPCLKWithODMCombine4To1;
346cf627fb27c0 Nikola Cornij       2021-05-18  3998  					} else {
346cf627fb27c0 Nikola Cornij       2021-05-18  3999  						v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_2to1;
346cf627fb27c0 Nikola Cornij       2021-05-18  4000  						v->PlaneRequiredDISPCLK = v->PlaneRequiredDISPCLKWithODMCombine2To1;
346cf627fb27c0 Nikola Cornij       2021-05-18  4001  					}
346cf627fb27c0 Nikola Cornij       2021-05-18  4002  				}
346cf627fb27c0 Nikola Cornij       2021-05-18  4003  				if (v->OutputFormat[k] == dm_420 && v->HActive[k] > DCN30_MAX_FMT_420_BUFFER_WIDTH
346cf627fb27c0 Nikola Cornij       2021-05-18  4004  						&& v->ODMCombineEnablePerState[i][k] != dm_odm_combine_mode_4to1) {
346cf627fb27c0 Nikola Cornij       2021-05-18  4005  					if (v->HActive[k] / 2 > DCN30_MAX_FMT_420_BUFFER_WIDTH) {
346cf627fb27c0 Nikola Cornij       2021-05-18  4006  						v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_4to1;
346cf627fb27c0 Nikola Cornij       2021-05-18  4007  						v->PlaneRequiredDISPCLK = v->PlaneRequiredDISPCLKWithODMCombine4To1;
346cf627fb27c0 Nikola Cornij       2021-05-18  4008  					} else {
f8b9f9a599db59 Chris Park          2020-06-09  4009  						v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_2to1;
f8b9f9a599db59 Chris Park          2020-06-09  4010  						v->PlaneRequiredDISPCLK = v->PlaneRequiredDISPCLKWithODMCombine2To1;
f8b9f9a599db59 Chris Park          2020-06-09  4011  					}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4012  				}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4013  				if (v->ODMCombineEnablePerState[i][k] == dm_odm_combine_mode_4to1) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4014  					v->MPCCombine[i][j][k] = false;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4015  					v->NoOfDPP[i][j][k] = 4;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4016  					v->RequiredDPPCLK[i][j][k] = v->MinDPPCLKUsingSingleDPP[k] * (1 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0) / 4;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4017  				} else if (v->ODMCombineEnablePerState[i][k] == dm_odm_combine_mode_2to1) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4018  					v->MPCCombine[i][j][k] = false;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4019  					v->NoOfDPP[i][j][k] = 2;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4020  					v->RequiredDPPCLK[i][j][k] = v->MinDPPCLKUsingSingleDPP[k] * (1 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0) / 2;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4021  				} else if ((v->WhenToDoMPCCombine == dm_mpc_never
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4022  						|| (v->MinDPPCLKUsingSingleDPP[k] * (1 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0) <= v->MaxDppclkRoundedDownToDFSGranularity
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4023  								&& v->SingleDPPViewportSizeSupportPerPlane[k] == true))) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4024  					v->MPCCombine[i][j][k] = false;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4025  					v->NoOfDPP[i][j][k] = 1;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4026  					v->RequiredDPPCLK[i][j][k] = v->MinDPPCLKUsingSingleDPP[k] * (1.0 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4027  				} else {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4028  					v->MPCCombine[i][j][k] = true;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4029  					v->NoOfDPP[i][j][k] = 2;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4030  					v->RequiredDPPCLK[i][j][k] = v->MinDPPCLKUsingSingleDPP[k] * (1.0 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0) / 2.0;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4031  				}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4032  				v->RequiredDISPCLK[i][j] = dml_max(v->RequiredDISPCLK[i][j], v->PlaneRequiredDISPCLK);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4033  				if ((v->MinDPPCLKUsingSingleDPP[k] / v->NoOfDPP[i][j][k] * (1.0 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0)
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4034  						> v->MaxDppclkRoundedDownToDFSGranularity) || (v->PlaneRequiredDISPCLK > v->MaxDispclkRoundedDownToDFSGranularity)) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4035  					v->DISPCLK_DPPCLK_Support[i][j] = false;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4036  				}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4037  			}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4038  			v->TotalNumberOfActiveDPP[i][j] = 0;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4039  			v->TotalNumberOfSingleDPPPlanes[i][j] = 0;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4040  			for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4041  				v->TotalNumberOfActiveDPP[i][j] = v->TotalNumberOfActiveDPP[i][j] + v->NoOfDPP[i][j][k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4042  				if (v->NoOfDPP[i][j][k] == 1)
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4043  					v->TotalNumberOfSingleDPPPlanes[i][j] = v->TotalNumberOfSingleDPPPlanes[i][j] + 1;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4044  			}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4045  			if (j == 1 && v->WhenToDoMPCCombine != dm_mpc_never) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4046  				while (!(v->TotalNumberOfActiveDPP[i][j] >= v->MaxNumDPP || v->TotalNumberOfSingleDPPPlanes[i][j] == 0)) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4047  					double BWOfNonSplitPlaneOfMaximumBandwidth = 0;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4048  					unsigned int NumberOfNonSplitPlaneOfMaximumBandwidth = 0;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4049  					BWOfNonSplitPlaneOfMaximumBandwidth = 0;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4050  					NumberOfNonSplitPlaneOfMaximumBandwidth = 0;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4051  					for (k = 0; k < v->NumberOfActivePlanes; ++k) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4052  						if (v->ReadBandwidthLuma[k] + v->ReadBandwidthChroma[k] > BWOfNonSplitPlaneOfMaximumBandwidth
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4053  								&& v->ODMCombineEnablePerState[i][k] == dm_odm_combine_mode_disabled && v->MPCCombine[i][j][k] == false) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4054  							BWOfNonSplitPlaneOfMaximumBandwidth = v->ReadBandwidthLuma[k] + v->ReadBandwidthChroma[k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4055  							NumberOfNonSplitPlaneOfMaximumBandwidth = k;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4056  						}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4057  					}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4058  					v->MPCCombine[i][j][NumberOfNonSplitPlaneOfMaximumBandwidth] = true;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4059  					v->NoOfDPP[i][j][NumberOfNonSplitPlaneOfMaximumBandwidth] = 2;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4060  					v->RequiredDPPCLK[i][j][NumberOfNonSplitPlaneOfMaximumBandwidth] = v->MinDPPCLKUsingSingleDPP[NumberOfNonSplitPlaneOfMaximumBandwidth]
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4061  							* (1 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100) / 2;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4062  					v->TotalNumberOfActiveDPP[i][j] = v->TotalNumberOfActiveDPP[i][j] + 1;
b8cc3e504622e7 Dillon Varone       2021-02-19  4063  					v->TotalNumberOfSingleDPPPlanes[i][j] = v->TotalNumberOfSingleDPPPlanes[i][j] - 1;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4064  				}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4065  			}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4066  			if (v->TotalNumberOfActiveDPP[i][j] > v->MaxNumDPP) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4067  				v->RequiredDISPCLK[i][j] = 0.0;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4068  				v->DISPCLK_DPPCLK_Support[i][j] = true;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4069  				for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4070  					v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_disabled;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4071  					if (v->SingleDPPViewportSizeSupportPerPlane[k] == false && v->WhenToDoMPCCombine != dm_mpc_never) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4072  						v->MPCCombine[i][j][k] = true;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4073  						v->NoOfDPP[i][j][k] = 2;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4074  						v->RequiredDPPCLK[i][j][k] = v->MinDPPCLKUsingSingleDPP[k] * (1.0 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0) / 2.0;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4075  					} else {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4076  						v->MPCCombine[i][j][k] = false;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4077  						v->NoOfDPP[i][j][k] = 1;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4078  						v->RequiredDPPCLK[i][j][k] = v->MinDPPCLKUsingSingleDPP[k] * (1.0 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4079  					}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4080  					if (!(v->MaxDispclk[i] == v->MaxDispclk[v->soc.num_states - 1] && v->MaxDppclk[i] == v->MaxDppclk[v->soc.num_states - 1])) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4081  						v->PlaneRequiredDISPCLK = v->PixelClock[k] * (1.0 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0)
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4082  								* (1.0 + v->DISPCLKRampingMargin / 100.0);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4083  					} else {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4084  						v->PlaneRequiredDISPCLK = v->PixelClock[k] * (1.0 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4085  					}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4086  					v->RequiredDISPCLK[i][j] = dml_max(v->RequiredDISPCLK[i][j], v->PlaneRequiredDISPCLK);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4087  					if ((v->MinDPPCLKUsingSingleDPP[k] / v->NoOfDPP[i][j][k] * (1.0 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0)
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4088  							> v->MaxDppclkRoundedDownToDFSGranularity) || (v->PlaneRequiredDISPCLK > v->MaxDispclkRoundedDownToDFSGranularity)) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4089  						v->DISPCLK_DPPCLK_Support[i][j] = false;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4090  					}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4091  				}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4092  				v->TotalNumberOfActiveDPP[i][j] = 0.0;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4093  				for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4094  					v->TotalNumberOfActiveDPP[i][j] = v->TotalNumberOfActiveDPP[i][j] + v->NoOfDPP[i][j][k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4095  				}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4096  			}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4097  			v->RequiredDISPCLK[i][j] = dml_max(v->RequiredDISPCLK[i][j], v->WritebackRequiredDISPCLK);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4098  			if (v->MaxDispclkRoundedDownToDFSGranularity < v->WritebackRequiredDISPCLK) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4099  				v->DISPCLK_DPPCLK_Support[i][j] = false;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4100  			}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4101  		}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4102  	}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4103  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4104  	/*Total Available Pipes Support Check*/
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4105  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4106  	for (i = 0; i < v->soc.num_states; i++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4107  		for (j = 0; j < 2; j++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4108  			if (v->TotalNumberOfActiveDPP[i][j] <= v->MaxNumDPP) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4109  				v->TotalAvailablePipesSupport[i][j] = true;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4110  			} else {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4111  				v->TotalAvailablePipesSupport[i][j] = false;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4112  			}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4113  		}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4114  	}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4115  	/*Display IO and DSC Support Check*/
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4116  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4117  	v->NonsupportedDSCInputBPC = false;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4118  	for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4119  		if (!(v->DSCInputBitPerComponent[k] == 12.0
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4120  				|| v->DSCInputBitPerComponent[k] == 10.0
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4121  				|| v->DSCInputBitPerComponent[k] == 8.0)) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4122  			v->NonsupportedDSCInputBPC = true;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4123  		}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4124  	}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4125  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4126  	/*Number Of DSC Slices*/
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4127  	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4128  		if (v->BlendingAndTiming[k] == k) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4129  			if (v->PixelClockBackEnd[k] > 3200) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4130  				v->NumberOfDSCSlices[k] = dml_ceil(v->PixelClockBackEnd[k] / 400.0, 4.0);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4131  			} else if (v->PixelClockBackEnd[k] > 1360) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4132  				v->NumberOfDSCSlices[k] = 8;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4133  			} else if (v->PixelClockBackEnd[k] > 680) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4134  				v->NumberOfDSCSlices[k] = 4;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4135  			} else if (v->PixelClockBackEnd[k] > 340) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4136  				v->NumberOfDSCSlices[k] = 2;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4137  			} else {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4138  				v->NumberOfDSCSlices[k] = 1;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4139  			}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4140  		} else {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4141  			v->NumberOfDSCSlices[k] = 0;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4142  		}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4143  	}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4144  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4145  	for (i = 0; i < v->soc.num_states; i++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4146  		for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4147  			v->RequiresDSC[i][k] = false;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4148  			v->RequiresFEC[i][k] = false;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4149  			if (v->BlendingAndTiming[k] == k) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4150  				if (v->Output[k] == dm_hdmi) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4151  					v->RequiresDSC[i][k] = false;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4152  					v->RequiresFEC[i][k] = false;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4153  					v->OutputBppPerState[i][k] = TruncToValidBPP(
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4154  							dml_min(600.0, v->PHYCLKPerState[i]) * 10,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4155  							3,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4156  							v->HTotal[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4157  							v->HActive[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4158  							v->PixelClockBackEnd[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4159  							v->ForcedOutputLinkBPP[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4160  							false,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4161  							v->Output[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4162  							v->OutputFormat[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4163  							v->DSCInputBitPerComponent[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4164  							v->NumberOfDSCSlices[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4165  							v->AudioSampleRate[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4166  							v->AudioSampleLayout[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4167  							v->ODMCombineEnablePerState[i][k]);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4168  				} else if (v->Output[k] == dm_dp || v->Output[k] == dm_edp) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4169  					if (v->DSCEnable[k] == true) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4170  						v->RequiresDSC[i][k] = true;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4171  						v->LinkDSCEnable = true;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4172  						if (v->Output[k] == dm_dp) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4173  							v->RequiresFEC[i][k] = true;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4174  						} else {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4175  							v->RequiresFEC[i][k] = false;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4176  						}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4177  					} else {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4178  						v->RequiresDSC[i][k] = false;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4179  						v->LinkDSCEnable = false;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4180  						v->RequiresFEC[i][k] = false;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4181  					}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4182  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4183  					v->Outbpp = BPP_INVALID;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4184  					if (v->PHYCLKPerState[i] >= 270.0) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4185  						v->Outbpp = TruncToValidBPP(
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4186  								(1.0 - v->Downspreading / 100.0) * 2700,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4187  								v->OutputLinkDPLanes[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4188  								v->HTotal[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4189  								v->HActive[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4190  								v->PixelClockBackEnd[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4191  								v->ForcedOutputLinkBPP[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4192  								v->LinkDSCEnable,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4193  								v->Output[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4194  								v->OutputFormat[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4195  								v->DSCInputBitPerComponent[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4196  								v->NumberOfDSCSlices[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4197  								v->AudioSampleRate[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4198  								v->AudioSampleLayout[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4199  								v->ODMCombineEnablePerState[i][k]);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4200  						v->OutputBppPerState[i][k] = v->Outbpp;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4201  						// TODO: Need some other way to handle this nonsense
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4202  						// v->OutputTypeAndRatePerState[i][k] = v->Output[k] & " HBR"
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4203  					}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4204  					if (v->Outbpp == BPP_INVALID && v->PHYCLKPerState[i] >= 540.0) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4205  						v->Outbpp = TruncToValidBPP(
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4206  								(1.0 - v->Downspreading / 100.0) * 5400,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4207  								v->OutputLinkDPLanes[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4208  								v->HTotal[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4209  								v->HActive[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4210  								v->PixelClockBackEnd[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4211  								v->ForcedOutputLinkBPP[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4212  								v->LinkDSCEnable,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4213  								v->Output[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4214  								v->OutputFormat[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4215  								v->DSCInputBitPerComponent[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4216  								v->NumberOfDSCSlices[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4217  								v->AudioSampleRate[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4218  								v->AudioSampleLayout[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4219  								v->ODMCombineEnablePerState[i][k]);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4220  						v->OutputBppPerState[i][k] = v->Outbpp;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4221  						// TODO: Need some other way to handle this nonsense
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4222  						// v->OutputTypeAndRatePerState[i][k] = v->Output[k] & " HBR2"
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4223  					}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4224  					if (v->Outbpp == BPP_INVALID && v->PHYCLKPerState[i] >= 810.0) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4225  						v->Outbpp = TruncToValidBPP(
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4226  								(1.0 - v->Downspreading / 100.0) * 8100,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4227  								v->OutputLinkDPLanes[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4228  								v->HTotal[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4229  								v->HActive[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4230  								v->PixelClockBackEnd[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4231  								v->ForcedOutputLinkBPP[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4232  								v->LinkDSCEnable,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4233  								v->Output[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4234  								v->OutputFormat[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4235  								v->DSCInputBitPerComponent[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4236  								v->NumberOfDSCSlices[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4237  								v->AudioSampleRate[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4238  								v->AudioSampleLayout[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4239  								v->ODMCombineEnablePerState[i][k]);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4240  						if (v->Outbpp == BPP_INVALID && v->ForcedOutputLinkBPP[k] == 0) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4241  							//if (v->Outbpp == BPP_INVALID && v->DSCEnabled[k] == dm_dsc_enable_only_if_necessary && v->ForcedOutputLinkBPP[k] == 0) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4242  							v->RequiresDSC[i][k] = true;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4243  							v->LinkDSCEnable = true;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4244  							if (v->Output[k] == dm_dp) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4245  								v->RequiresFEC[i][k] = true;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4246  							}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4247  							v->Outbpp = TruncToValidBPP(
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4248  									(1.0 - v->Downspreading / 100.0) * 8100,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4249  									v->OutputLinkDPLanes[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4250  									v->HTotal[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4251  									v->HActive[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4252  									v->PixelClockBackEnd[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4253  									v->ForcedOutputLinkBPP[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4254  									v->LinkDSCEnable,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4255  									v->Output[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4256  									v->OutputFormat[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4257  									v->DSCInputBitPerComponent[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4258  									v->NumberOfDSCSlices[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4259  									v->AudioSampleRate[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4260  									v->AudioSampleLayout[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4261  									v->ODMCombineEnablePerState[i][k]);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4262  						}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4263  						v->OutputBppPerState[i][k] = v->Outbpp;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4264  						// TODO: Need some other way to handle this nonsense
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4265  						// v->OutputTypeAndRatePerState[i][k] = v->Output[k] & " HBR3"
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4266  					}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4267  				}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4268  			} else {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4269  				v->OutputBppPerState[i][k] = 0;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4270  			}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4271  		}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4272  	}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4273  	for (i = 0; i < v->soc.num_states; i++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4274  		v->DIOSupport[i] = true;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4275  		for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
91a51fbf24e2d9 Wesley Chalmers     2021-01-29  4276  			if (!v->skip_dio_check[k] && v->BlendingAndTiming[k] == k && (v->Output[k] == dm_dp || v->Output[k] == dm_edp || v->Output[k] == dm_hdmi)
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4277  					&& (v->OutputBppPerState[i][k] == 0
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4278  							|| (v->OutputFormat[k] == dm_420 && v->Interlace[k] == true && v->ProgressiveToInterlaceUnitInOPP == true))) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4279  				v->DIOSupport[i] = false;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4280  			}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4281  		}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4282  	}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4283  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4284  	for (i = 0; i < v->soc.num_states; ++i) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4285  		v->ODMCombine4To1SupportCheckOK[i] = true;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4286  		for (k = 0; k < v->NumberOfActivePlanes; ++k) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4287  			if (v->BlendingAndTiming[k] == k && v->ODMCombineEnablePerState[i][k] == dm_odm_combine_mode_4to1
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4288  					&& (v->ODMCombine4To1Supported == false || v->Output[k] == dm_dp || v->Output[k] == dm_edp || v->Output[k] == dm_hdmi)) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4289  				v->ODMCombine4To1SupportCheckOK[i] = false;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4290  			}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4291  		}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4292  	}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4293  
346cf627fb27c0 Nikola Cornij       2021-05-18  4294  	/* Skip dscclk validation: as long as dispclk is supported, dscclk is also implicitly supported */
346cf627fb27c0 Nikola Cornij       2021-05-18  4295  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4296  	for (i = 0; i < v->soc.num_states; i++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4297  		v->NotEnoughDSCUnits[i] = false;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4298  		v->TotalDSCUnitsRequired = 0.0;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4299  		for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4300  			if (v->RequiresDSC[i][k] == true) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4301  				if (v->ODMCombineEnablePerState[i][k] == dm_odm_combine_mode_4to1) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4302  					v->TotalDSCUnitsRequired = v->TotalDSCUnitsRequired + 4.0;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4303  				} else if (v->ODMCombineEnablePerState[i][k] == dm_odm_combine_mode_2to1) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4304  					v->TotalDSCUnitsRequired = v->TotalDSCUnitsRequired + 2.0;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4305  				} else {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4306  					v->TotalDSCUnitsRequired = v->TotalDSCUnitsRequired + 1.0;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4307  				}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4308  			}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4309  		}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4310  		if (v->TotalDSCUnitsRequired > v->NumberOfDSC) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4311  			v->NotEnoughDSCUnits[i] = true;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4312  		}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4313  	}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4314  	/*DSC Delay per state*/
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4315  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4316  	for (i = 0; i < v->soc.num_states; i++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4317  		for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4318  			if (v->OutputBppPerState[i][k] == BPP_INVALID) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4319  				v->BPP = 0.0;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4320  			} else {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4321  				v->BPP = v->OutputBppPerState[i][k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4322  			}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4323  			if (v->RequiresDSC[i][k] == true && v->BPP != 0.0) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4324  				if (v->ODMCombineEnablePerState[i][k] == dm_odm_combine_mode_disabled) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4325  					v->DSCDelayPerState[i][k] = dscceComputeDelay(
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4326  							v->DSCInputBitPerComponent[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4327  							v->BPP,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4328  							dml_ceil(1.0 * v->HActive[k] / v->NumberOfDSCSlices[k], 1.0),
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4329  							v->NumberOfDSCSlices[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4330  							v->OutputFormat[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4331  							v->Output[k]) + dscComputeDelay(v->OutputFormat[k], v->Output[k]);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4332  				} else if (v->ODMCombineEnablePerState[i][k] == dm_odm_combine_mode_2to1) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4333  					v->DSCDelayPerState[i][k] = 2.0
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4334  							* dscceComputeDelay(
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4335  									v->DSCInputBitPerComponent[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4336  									v->BPP,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4337  									dml_ceil(1.0 * v->HActive[k] / v->NumberOfDSCSlices[k], 1.0),
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4338  									v->NumberOfDSCSlices[k] / 2,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4339  									v->OutputFormat[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4340  									v->Output[k]) + dscComputeDelay(v->OutputFormat[k], v->Output[k]);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4341  				} else {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4342  					v->DSCDelayPerState[i][k] = 4.0
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4343  							* (dscceComputeDelay(
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4344  									v->DSCInputBitPerComponent[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4345  									v->BPP,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4346  									dml_ceil(1.0 * v->HActive[k] / v->NumberOfDSCSlices[k], 1.0),
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4347  									v->NumberOfDSCSlices[k] / 4,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4348  									v->OutputFormat[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4349  									v->Output[k]) + dscComputeDelay(v->OutputFormat[k], v->Output[k]));
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4350  				}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4351  				v->DSCDelayPerState[i][k] = v->DSCDelayPerState[i][k] * v->PixelClock[k] / v->PixelClockBackEnd[k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4352  			} else {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4353  				v->DSCDelayPerState[i][k] = 0.0;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4354  			}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4355  		}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4356  		for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4357  			for (m = 0; m <= v->NumberOfActivePlanes - 1; m++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4358  				if (v->BlendingAndTiming[k] == m && v->RequiresDSC[i][m] == true) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4359  					v->DSCDelayPerState[i][k] = v->DSCDelayPerState[i][m];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4360  				}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4361  			}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4362  		}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4363  	}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4364  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4365  	//Calculate Swath, DET Configuration, DCFCLKDeepSleep
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4366  	//
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4367  	for (i = 0; i < mode_lib->soc.num_states; ++i) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4368  		for (j = 0; j <= 1; ++j) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4369  			for (k = 0; k < v->NumberOfActivePlanes; ++k) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4370  				v->RequiredDPPCLKThisState[k] = v->RequiredDPPCLK[i][j][k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4371  				v->NoOfDPPThisState[k] = v->NoOfDPP[i][j][k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4372  				v->ODMCombineEnableThisState[k] = v->ODMCombineEnablePerState[i][k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4373  			}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4374  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4375  			CalculateSwathAndDETConfiguration(
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4376  					false,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4377  					v->NumberOfActivePlanes,
4469201b19354a Chaitanya Dhere     2021-04-20  4378  					v->DETBufferSizeInKByte[0],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4379  					v->MaximumSwathWidthLuma,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4380  					v->MaximumSwathWidthChroma,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4381  					v->SourceScan,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4382  					v->SourcePixelFormat,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4383  					v->SurfaceTiling,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4384  					v->ViewportWidth,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4385  					v->ViewportHeight,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4386  					v->SurfaceWidthY,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4387  					v->SurfaceWidthC,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4388  					v->SurfaceHeightY,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4389  					v->SurfaceHeightC,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4390  					v->Read256BlockHeightY,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4391  					v->Read256BlockHeightC,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4392  					v->Read256BlockWidthY,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4393  					v->Read256BlockWidthC,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4394  					v->ODMCombineEnableThisState,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4395  					v->BlendingAndTiming,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4396  					v->BytePerPixelY,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4397  					v->BytePerPixelC,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4398  					v->BytePerPixelInDETY,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4399  					v->BytePerPixelInDETC,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4400  					v->HActive,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4401  					v->HRatio,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4402  					v->HRatioChroma,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4403  					v->NoOfDPPThisState,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4404  					v->swath_width_luma_ub_this_state,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4405  					v->swath_width_chroma_ub_this_state,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4406  					v->SwathWidthYThisState,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4407  					v->SwathWidthCThisState,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4408  					v->SwathHeightYThisState,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4409  					v->SwathHeightCThisState,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4410  					v->DETBufferSizeYThisState,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4411  					v->DETBufferSizeCThisState,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4412  					v->dummystring,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4413  					&v->ViewportSizeSupport[i][j]);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4414  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4415  			for (k = 0; k < v->NumberOfActivePlanes; ++k) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4416  				v->swath_width_luma_ub_all_states[i][j][k] = v->swath_width_luma_ub_this_state[k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4417  				v->swath_width_chroma_ub_all_states[i][j][k] = v->swath_width_chroma_ub_this_state[k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4418  				v->SwathWidthYAllStates[i][j][k] = v->SwathWidthYThisState[k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4419  				v->SwathWidthCAllStates[i][j][k] = v->SwathWidthCThisState[k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4420  				v->SwathHeightYAllStates[i][j][k] = v->SwathHeightYThisState[k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4421  				v->SwathHeightCAllStates[i][j][k] = v->SwathHeightCThisState[k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4422  				v->DETBufferSizeYAllStates[i][j][k] = v->DETBufferSizeYThisState[k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4423  				v->DETBufferSizeCAllStates[i][j][k] = v->DETBufferSizeCThisState[k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4424  			}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4425  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4426  		}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4427  	}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4428  	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4429  		v->cursor_bw[k] = v->NumberOfCursors[k] * v->CursorWidth[k][0] * v->CursorBPP[k][0] / 8.0 / (v->HTotal[k] / v->PixelClock[k]) * v->VRatio[k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4430  	}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4431  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4432  	for (i = 0; i < v->soc.num_states; i++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4433  		for (j = 0; j < 2; j++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4434  			for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4435  				v->swath_width_luma_ub_this_state[k] = v->swath_width_luma_ub_all_states[i][j][k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4436  				v->swath_width_chroma_ub_this_state[k] = v->swath_width_chroma_ub_all_states[i][j][k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4437  				v->SwathWidthYThisState[k] = v->SwathWidthYAllStates[i][j][k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4438  				v->SwathWidthCThisState[k] = v->SwathWidthCAllStates[i][j][k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4439  				v->SwathHeightYThisState[k] = v->SwathHeightYAllStates[i][j][k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4440  				v->SwathHeightCThisState[k] = v->SwathHeightCAllStates[i][j][k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4441  				v->DETBufferSizeYThisState[k] = v->DETBufferSizeYAllStates[i][j][k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4442  				v->DETBufferSizeCThisState[k] = v->DETBufferSizeCAllStates[i][j][k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4443  			}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4444  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4445  			v->TotalNumberOfDCCActiveDPP[i][j] = 0;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4446  			for (k = 0; k < v->NumberOfActivePlanes; ++k) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4447  				if (v->DCCEnable[k] == true) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4448  					v->TotalNumberOfDCCActiveDPP[i][j] = v->TotalNumberOfDCCActiveDPP[i][j] + v->NoOfDPP[i][j][k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4449  				}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4450  			}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4451  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4452  			for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4453  				if (v->SourcePixelFormat[k] == dm_420_8 || v->SourcePixelFormat[k] == dm_420_10 || v->SourcePixelFormat[k] == dm_420_12
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4454  						|| v->SourcePixelFormat[k] == dm_rgbe_alpha) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4455  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4456  					if ((v->SourcePixelFormat[k] == dm_420_10 || v->SourcePixelFormat[k] == dm_420_12) && v->SourceScan[k] != dm_vert) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4457  						v->PTEBufferSizeInRequestsForLuma = (v->PTEBufferSizeInRequestsLuma + v->PTEBufferSizeInRequestsChroma) / 2;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4458  						v->PTEBufferSizeInRequestsForChroma = v->PTEBufferSizeInRequestsForLuma;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4459  					} else {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4460  						v->PTEBufferSizeInRequestsForLuma = v->PTEBufferSizeInRequestsLuma;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4461  						v->PTEBufferSizeInRequestsForChroma = v->PTEBufferSizeInRequestsChroma;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4462  					}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4463  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4464  					v->PDEAndMetaPTEBytesPerFrameC = CalculateVMAndRowBytes(
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4465  							mode_lib,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4466  							v->DCCEnable[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4467  							v->Read256BlockHeightC[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4468  							v->Read256BlockWidthY[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4469  							v->SourcePixelFormat[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4470  							v->SurfaceTiling[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4471  							v->BytePerPixelC[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4472  							v->SourceScan[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4473  							v->SwathWidthCThisState[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4474  							v->ViewportHeightChroma[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4475  							v->GPUVMEnable,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4476  							v->HostVMEnable,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4477  							v->HostVMMaxNonCachedPageTableLevels,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4478  							v->GPUVMMinPageSize,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4479  							v->HostVMMinPageSize,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4480  							v->PTEBufferSizeInRequestsForChroma,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4481  							v->PitchC[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4482  							0.0,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4483  							&v->MacroTileWidthC[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4484  							&v->MetaRowBytesC,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4485  							&v->DPTEBytesPerRowC,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4486  							&v->PTEBufferSizeNotExceededC[i][j][k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4487  							&v->dummyinteger7,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4488  							&v->dpte_row_height_chroma[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4489  							&v->dummyinteger28,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4490  							&v->dummyinteger26,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4491  							&v->dummyinteger23,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4492  							&v->meta_row_height_chroma[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4493  							&v->dummyinteger8,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4494  							&v->dummyinteger9,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4495  							&v->dummyinteger19,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4496  							&v->dummyinteger20,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4497  							&v->dummyinteger17,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4498  							&v->dummyinteger10,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4499  							&v->dummyinteger11);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4500  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4501  					v->PrefetchLinesC[i][j][k] = CalculatePrefetchSourceLines(
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4502  							mode_lib,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4503  							v->VRatioChroma[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4504  							v->VTAPsChroma[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4505  							v->Interlace[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4506  							v->ProgressiveToInterlaceUnitInOPP,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4507  							v->SwathHeightCThisState[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4508  							v->ViewportYStartC[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4509  							&v->PrefillC[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4510  							&v->MaxNumSwC[k]);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4511  				} else {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4512  					v->PTEBufferSizeInRequestsForLuma = v->PTEBufferSizeInRequestsLuma + v->PTEBufferSizeInRequestsChroma;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4513  					v->PTEBufferSizeInRequestsForChroma = 0;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4514  					v->PDEAndMetaPTEBytesPerFrameC = 0.0;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4515  					v->MetaRowBytesC = 0.0;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4516  					v->DPTEBytesPerRowC = 0.0;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4517  					v->PrefetchLinesC[i][j][k] = 0.0;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4518  					v->PTEBufferSizeNotExceededC[i][j][k] = true;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4519  				}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4520  				v->PDEAndMetaPTEBytesPerFrameY = CalculateVMAndRowBytes(
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4521  						mode_lib,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4522  						v->DCCEnable[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4523  						v->Read256BlockHeightY[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4524  						v->Read256BlockWidthY[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4525  						v->SourcePixelFormat[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4526  						v->SurfaceTiling[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4527  						v->BytePerPixelY[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4528  						v->SourceScan[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4529  						v->SwathWidthYThisState[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4530  						v->ViewportHeight[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4531  						v->GPUVMEnable,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4532  						v->HostVMEnable,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4533  						v->HostVMMaxNonCachedPageTableLevels,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4534  						v->GPUVMMinPageSize,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4535  						v->HostVMMinPageSize,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4536  						v->PTEBufferSizeInRequestsForLuma,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4537  						v->PitchY[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4538  						v->DCCMetaPitchY[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4539  						&v->MacroTileWidthY[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4540  						&v->MetaRowBytesY,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4541  						&v->DPTEBytesPerRowY,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4542  						&v->PTEBufferSizeNotExceededY[i][j][k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4543  						v->dummyinteger4,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4544  						&v->dpte_row_height[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4545  						&v->dummyinteger29,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4546  						&v->dummyinteger27,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4547  						&v->dummyinteger24,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4548  						&v->meta_row_height[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4549  						&v->dummyinteger25,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4550  						&v->dpte_group_bytes[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4551  						&v->dummyinteger21,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4552  						&v->dummyinteger22,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4553  						&v->dummyinteger18,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4554  						&v->dummyinteger5,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4555  						&v->dummyinteger6);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4556  				v->PrefetchLinesY[i][j][k] = CalculatePrefetchSourceLines(
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4557  						mode_lib,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4558  						v->VRatio[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4559  						v->vtaps[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4560  						v->Interlace[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4561  						v->ProgressiveToInterlaceUnitInOPP,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4562  						v->SwathHeightYThisState[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4563  						v->ViewportYStartY[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4564  						&v->PrefillY[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4565  						&v->MaxNumSwY[k]);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4566  				v->PDEAndMetaPTEBytesPerFrame[i][j][k] = v->PDEAndMetaPTEBytesPerFrameY + v->PDEAndMetaPTEBytesPerFrameC;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4567  				v->MetaRowBytes[i][j][k] = v->MetaRowBytesY + v->MetaRowBytesC;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4568  				v->DPTEBytesPerRow[i][j][k] = v->DPTEBytesPerRowY + v->DPTEBytesPerRowC;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4569  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4570  				CalculateRowBandwidth(
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4571  						v->GPUVMEnable,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4572  						v->SourcePixelFormat[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4573  						v->VRatio[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4574  						v->VRatioChroma[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4575  						v->DCCEnable[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4576  						v->HTotal[k] / v->PixelClock[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4577  						v->MetaRowBytesY,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4578  						v->MetaRowBytesC,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4579  						v->meta_row_height[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4580  						v->meta_row_height_chroma[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4581  						v->DPTEBytesPerRowY,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4582  						v->DPTEBytesPerRowC,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4583  						v->dpte_row_height[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4584  						v->dpte_row_height_chroma[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4585  						&v->meta_row_bandwidth[i][j][k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4586  						&v->dpte_row_bandwidth[i][j][k]);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4587  			}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4588  			v->UrgLatency[i] = CalculateUrgentLatency(
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4589  					v->UrgentLatencyPixelDataOnly,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4590  					v->UrgentLatencyPixelMixedWithVMData,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4591  					v->UrgentLatencyVMDataOnly,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4592  					v->DoUrgentLatencyAdjustment,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4593  					v->UrgentLatencyAdjustmentFabricClockComponent,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4594  					v->UrgentLatencyAdjustmentFabricClockReference,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4595  					v->FabricClockPerState[i]);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4596  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4597  			for (k = 0; k < v->NumberOfActivePlanes; ++k) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4598  				CalculateUrgentBurstFactor(
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4599  						v->swath_width_luma_ub_this_state[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4600  						v->swath_width_chroma_ub_this_state[k],
4469201b19354a Chaitanya Dhere     2021-04-20  4601  						v->DETBufferSizeInKByte[0],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4602  						v->SwathHeightYThisState[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4603  						v->SwathHeightCThisState[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4604  						v->HTotal[k] / v->PixelClock[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4605  						v->UrgLatency[i],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4606  						v->CursorBufferSize,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4607  						v->CursorWidth[k][0],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4608  						v->CursorBPP[k][0],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4609  						v->VRatio[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4610  						v->VRatioChroma[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4611  						v->BytePerPixelInDETY[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4612  						v->BytePerPixelInDETC[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4613  						v->DETBufferSizeYThisState[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4614  						v->DETBufferSizeCThisState[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4615  						&v->UrgentBurstFactorCursor[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4616  						&v->UrgentBurstFactorLuma[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4617  						&v->UrgentBurstFactorChroma[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4618  						&NotUrgentLatencyHiding[k]);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4619  			}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4620  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4621  			v->NotUrgentLatencyHiding[i][j] = false;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4622  			for (k = 0; k < v->NumberOfActivePlanes; ++k) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4623  				if (NotUrgentLatencyHiding[k]) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4624  					v->NotUrgentLatencyHiding[i][j] = true;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4625  				}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4626  			}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4627  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4628  			for (k = 0; k < v->NumberOfActivePlanes; ++k) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4629  				v->VActivePixelBandwidth[i][j][k] = v->ReadBandwidthLuma[k] * v->UrgentBurstFactorLuma[k]
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4630  						+ v->ReadBandwidthChroma[k] * v->UrgentBurstFactorChroma[k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4631  				v->VActiveCursorBandwidth[i][j][k] = v->cursor_bw[k] * v->UrgentBurstFactorCursor[k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4632  			}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4633  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4634  			v->TotalVActivePixelBandwidth[i][j] = 0;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4635  			v->TotalVActiveCursorBandwidth[i][j] = 0;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4636  			v->TotalMetaRowBandwidth[i][j] = 0;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4637  			v->TotalDPTERowBandwidth[i][j] = 0;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4638  			for (k = 0; k < v->NumberOfActivePlanes; ++k) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4639  				v->TotalVActivePixelBandwidth[i][j] = v->TotalVActivePixelBandwidth[i][j] + v->VActivePixelBandwidth[i][j][k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4640  				v->TotalVActiveCursorBandwidth[i][j] = v->TotalVActiveCursorBandwidth[i][j] + v->VActiveCursorBandwidth[i][j][k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4641  				v->TotalMetaRowBandwidth[i][j] = v->TotalMetaRowBandwidth[i][j] + v->NoOfDPP[i][j][k] * v->meta_row_bandwidth[i][j][k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4642  				v->TotalDPTERowBandwidth[i][j] = v->TotalDPTERowBandwidth[i][j] + v->NoOfDPP[i][j][k] * v->dpte_row_bandwidth[i][j][k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4643  			}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4644  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4645  			CalculateDCFCLKDeepSleep(
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4646  					mode_lib,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4647  					v->NumberOfActivePlanes,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4648  					v->BytePerPixelY,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4649  					v->BytePerPixelC,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4650  					v->VRatio,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4651  					v->VRatioChroma,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4652  					v->SwathWidthYThisState,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4653  					v->SwathWidthCThisState,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4654  					v->NoOfDPPThisState,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4655  					v->HRatio,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4656  					v->HRatioChroma,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4657  					v->PixelClock,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4658  					v->PSCL_FACTOR,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4659  					v->PSCL_FACTOR_CHROMA,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4660  					v->RequiredDPPCLKThisState,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4661  					v->ReadBandwidthLuma,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4662  					v->ReadBandwidthChroma,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4663  					v->ReturnBusWidth,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4664  					&v->ProjectedDCFCLKDeepSleep[i][j]);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4665  		}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4666  	}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4667  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4668  	//Calculate Return BW
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4669  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4670  	for (i = 0; i < mode_lib->soc.num_states; ++i) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4671  		for (j = 0; j <= 1; ++j) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4672  			for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4673  				if (v->BlendingAndTiming[k] == k) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4674  					if (v->WritebackEnable[k] == true) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4675  						v->WritebackDelayTime[k] = v->WritebackLatency
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4676  								+ CalculateWriteBackDelay(
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4677  										v->WritebackPixelFormat[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4678  										v->WritebackHRatio[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4679  										v->WritebackVRatio[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4680  										v->WritebackVTaps[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4681  										v->WritebackDestinationWidth[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4682  										v->WritebackDestinationHeight[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4683  										v->WritebackSourceHeight[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4684  										v->HTotal[k]) / v->RequiredDISPCLK[i][j];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4685  					} else {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4686  						v->WritebackDelayTime[k] = 0.0;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4687  					}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4688  					for (m = 0; m <= v->NumberOfActivePlanes - 1; m++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4689  						if (v->BlendingAndTiming[m] == k && v->WritebackEnable[m] == true) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4690  							v->WritebackDelayTime[k] = dml_max(
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4691  									v->WritebackDelayTime[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4692  									v->WritebackLatency
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4693  											+ CalculateWriteBackDelay(
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4694  													v->WritebackPixelFormat[m],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4695  													v->WritebackHRatio[m],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4696  													v->WritebackVRatio[m],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4697  													v->WritebackVTaps[m],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4698  													v->WritebackDestinationWidth[m],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4699  													v->WritebackDestinationHeight[m],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4700  													v->WritebackSourceHeight[m],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4701  													v->HTotal[m]) / v->RequiredDISPCLK[i][j]);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4702  						}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4703  					}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4704  				}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4705  			}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4706  			for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4707  				for (m = 0; m <= v->NumberOfActivePlanes - 1; m++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4708  					if (v->BlendingAndTiming[k] == m) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4709  						v->WritebackDelayTime[k] = v->WritebackDelayTime[m];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4710  					}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4711  				}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4712  			}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4713  			v->MaxMaxVStartup[i][j] = 0;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4714  			for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4715  				v->MaximumVStartup[i][j][k] = v->VTotal[k] - v->VActive[k]
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4716  						- dml_max(1.0, dml_ceil(1.0 * v->WritebackDelayTime[k] / (v->HTotal[k] / v->PixelClock[k]), 1.0));
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4717  				v->MaxMaxVStartup[i][j] = dml_max(v->MaxMaxVStartup[i][j], v->MaximumVStartup[i][j][k]);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4718  			}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4719  		}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4720  	}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4721  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4722  	ReorderingBytes = v->NumberOfChannels
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4723  			* dml_max3(
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4724  					v->UrgentOutOfOrderReturnPerChannelPixelDataOnly,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4725  					v->UrgentOutOfOrderReturnPerChannelPixelMixedWithVMData,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4726  					v->UrgentOutOfOrderReturnPerChannelVMDataOnly);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4727  	v->FinalDRAMClockChangeLatency = (v->DRAMClockChangeLatencyOverride > 0 ? v->DRAMClockChangeLatencyOverride : v->DRAMClockChangeLatency);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4728  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4729  	for (i = 0; i < mode_lib->soc.num_states; ++i) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4730  		for (j = 0; j <= 1; ++j) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4731  			v->DCFCLKState[i][j] = v->DCFCLKPerState[i];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4732  		}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4733  	}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4734  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4735  	if (v->UseMinimumRequiredDCFCLK == true) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4736  		UseMinimumDCFCLK(
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4737  				mode_lib,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4738  				v->MaxInterDCNTileRepeaters,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4739  				MaxPrefetchMode,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4740  				v->FinalDRAMClockChangeLatency,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4741  				v->SREnterPlusExitTime,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4742  				v->ReturnBusWidth,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4743  				v->RoundTripPingLatencyCycles,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4744  				ReorderingBytes,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4745  				v->PixelChunkSizeInKByte,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4746  				v->MetaChunkSize,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4747  				v->GPUVMEnable,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4748  				v->GPUVMMaxPageTableLevels,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4749  				v->HostVMEnable,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4750  				v->NumberOfActivePlanes,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4751  				v->HostVMMinPageSize,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4752  				v->HostVMMaxNonCachedPageTableLevels,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4753  				v->DynamicMetadataVMEnabled,
9f95e77800f3ba Alvin Lee           2021-06-17  4754  				v->ImmediateFlipRequirement[0],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4755  				v->ProgressiveToInterlaceUnitInOPP,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4756  				v->MaxAveragePercentOfIdealSDPPortBWDisplayCanUseInNormalSystemOperation,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4757  				v->PercentOfIdealDRAMFabricAndSDPPortBWReceivedAfterUrgLatencyPixelMixedWithVMData,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4758  				v->PercentOfIdealDRAMFabricAndSDPPortBWReceivedAfterUrgLatencyVMDataOnly,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4759  				v->PercentOfIdealDRAMFabricAndSDPPortBWReceivedAfterUrgLatencyPixelDataOnly,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4760  				v->VTotal,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4761  				v->VActive,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4762  				v->DynamicMetadataTransmittedBytes,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4763  				v->DynamicMetadataLinesBeforeActiveRequired,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4764  				v->Interlace,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4765  				v->RequiredDPPCLK,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4766  				v->RequiredDISPCLK,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4767  				v->UrgLatency,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4768  				v->NoOfDPP,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4769  				v->ProjectedDCFCLKDeepSleep,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4770  				v->MaximumVStartup,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4771  				v->TotalVActivePixelBandwidth,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4772  				v->TotalVActiveCursorBandwidth,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4773  				v->TotalMetaRowBandwidth,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4774  				v->TotalDPTERowBandwidth,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4775  				v->TotalNumberOfActiveDPP,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4776  				v->TotalNumberOfDCCActiveDPP,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4777  				v->dpte_group_bytes,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4778  				v->PrefetchLinesY,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4779  				v->PrefetchLinesC,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4780  				v->swath_width_luma_ub_all_states,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4781  				v->swath_width_chroma_ub_all_states,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4782  				v->BytePerPixelY,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4783  				v->BytePerPixelC,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4784  				v->HTotal,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4785  				v->PixelClock,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4786  				v->PDEAndMetaPTEBytesPerFrame,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4787  				v->DPTEBytesPerRow,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4788  				v->MetaRowBytes,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4789  				v->DynamicMetadataEnable,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4790  				v->VActivePixelBandwidth,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4791  				v->VActiveCursorBandwidth,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4792  				v->ReadBandwidthLuma,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4793  				v->ReadBandwidthChroma,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4794  				v->DCFCLKPerState,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4795  				v->DCFCLKState);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4796  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4797  		if (v->ClampMinDCFCLK) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4798  			/* Clamp calculated values to actual minimum */
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4799  			for (i = 0; i < mode_lib->soc.num_states; ++i) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4800  				for (j = 0; j <= 1; ++j) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4801  					if (v->DCFCLKState[i][j] < mode_lib->soc.min_dcfclk) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4802  						v->DCFCLKState[i][j] = mode_lib->soc.min_dcfclk;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4803  					}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4804  				}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4805  			}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4806  		}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4807  	}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4808  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4809  	for (i = 0; i < mode_lib->soc.num_states; ++i) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4810  		for (j = 0; j <= 1; ++j) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4811  			v->IdealSDPPortBandwidthPerState[i][j] = dml_min3(
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4812  					v->ReturnBusWidth * v->DCFCLKState[i][j],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4813  					v->DRAMSpeedPerState[i] * v->NumberOfChannels * v->DRAMChannelWidth,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4814  					v->FabricClockPerState[i] * v->FabricDatapathToDCNDataReturn);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4815  			if (v->HostVMEnable != true) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4816  				v->ReturnBWPerState[i][j] = v->IdealSDPPortBandwidthPerState[i][j] * v->PercentOfIdealDRAMFabricAndSDPPortBWReceivedAfterUrgLatencyPixelDataOnly
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4817  						/ 100;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4818  			} else {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4819  				v->ReturnBWPerState[i][j] = v->IdealSDPPortBandwidthPerState[i][j]
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4820  						* v->PercentOfIdealDRAMFabricAndSDPPortBWReceivedAfterUrgLatencyPixelMixedWithVMData / 100;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4821  			}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4822  		}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4823  	}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4824  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4825  	//Re-ordering Buffer Support Check
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4826  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4827  	for (i = 0; i < mode_lib->soc.num_states; ++i) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4828  		for (j = 0; j <= 1; ++j) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4829  			if ((v->ROBBufferSizeInKByte - v->PixelChunkSizeInKByte) * 1024 / v->ReturnBWPerState[i][j]
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4830  					> (v->RoundTripPingLatencyCycles + 32) / v->DCFCLKState[i][j] + ReorderingBytes / v->ReturnBWPerState[i][j]) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4831  				v->ROBSupport[i][j] = true;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4832  			} else {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4833  				v->ROBSupport[i][j] = false;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4834  			}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4835  		}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4836  	}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4837  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4838  	//Vertical Active BW support check
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4839  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4840  	MaxTotalVActiveRDBandwidth = 0;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4841  	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4842  		MaxTotalVActiveRDBandwidth = MaxTotalVActiveRDBandwidth + v->ReadBandwidthLuma[k] + v->ReadBandwidthChroma[k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4843  	}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4844  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4845  	for (i = 0; i < mode_lib->soc.num_states; ++i) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4846  		for (j = 0; j <= 1; ++j) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4847  			v->MaxTotalVerticalActiveAvailableBandwidth[i][j] = dml_min(
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4848  					v->IdealSDPPortBandwidthPerState[i][j] * v->MaxAveragePercentOfIdealSDPPortBWDisplayCanUseInNormalSystemOperation / 100,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4849  					v->DRAMSpeedPerState[i] * v->NumberOfChannels * v->DRAMChannelWidth * v->MaxAveragePercentOfIdealDRAMBWDisplayCanUseInNormalSystemOperation
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4850  							/ 100);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4851  			if (MaxTotalVActiveRDBandwidth <= v->MaxTotalVerticalActiveAvailableBandwidth[i][j]) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4852  				v->TotalVerticalActiveBandwidthSupport[i][j] = true;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4853  			} else {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4854  				v->TotalVerticalActiveBandwidthSupport[i][j] = false;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4855  			}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4856  		}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4857  	}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4858  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4859  	//Prefetch Check
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4860  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4861  	for (i = 0; i < mode_lib->soc.num_states; ++i) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4862  		for (j = 0; j <= 1; ++j) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4863  			int NextPrefetchModeState = MinPrefetchMode;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4864  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4865  			v->TimeCalc = 24 / v->ProjectedDCFCLKDeepSleep[i][j];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4866  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4867  			v->BandwidthWithoutPrefetchSupported[i][j] = true;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4868  			if (v->TotalVActivePixelBandwidth[i][j] + v->TotalVActiveCursorBandwidth[i][j] + v->TotalMetaRowBandwidth[i][j] + v->TotalDPTERowBandwidth[i][j]
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4869  					> v->ReturnBWPerState[i][j] || v->NotUrgentLatencyHiding[i][j]) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4870  				v->BandwidthWithoutPrefetchSupported[i][j] = false;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4871  			}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4872  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4873  			for (k = 0; k < v->NumberOfActivePlanes; ++k) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4874  				v->NoOfDPPThisState[k] = v->NoOfDPP[i][j][k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4875  				v->swath_width_luma_ub_this_state[k] = v->swath_width_luma_ub_all_states[i][j][k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4876  				v->swath_width_chroma_ub_this_state[k] = v->swath_width_chroma_ub_all_states[i][j][k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4877  				v->SwathWidthYThisState[k] = v->SwathWidthYAllStates[i][j][k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4878  				v->SwathWidthCThisState[k] = v->SwathWidthCAllStates[i][j][k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4879  				v->SwathHeightYThisState[k] = v->SwathHeightYAllStates[i][j][k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4880  				v->SwathHeightCThisState[k] = v->SwathHeightCAllStates[i][j][k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4881  				v->DETBufferSizeYThisState[k] = v->DETBufferSizeYAllStates[i][j][k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4882  				v->DETBufferSizeCThisState[k] = v->DETBufferSizeCAllStates[i][j][k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4883  				v->ODMCombineEnabled[k] = v->ODMCombineEnablePerState[i][k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4884  			}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4885  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4886  			v->ExtraLatency = CalculateExtraLatency(
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4887  					v->RoundTripPingLatencyCycles,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4888  					ReorderingBytes,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4889  					v->DCFCLKState[i][j],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4890  					v->TotalNumberOfActiveDPP[i][j],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4891  					v->PixelChunkSizeInKByte,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4892  					v->TotalNumberOfDCCActiveDPP[i][j],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4893  					v->MetaChunkSize,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4894  					v->ReturnBWPerState[i][j],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4895  					v->GPUVMEnable,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4896  					v->HostVMEnable,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4897  					v->NumberOfActivePlanes,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4898  					v->NoOfDPPThisState,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4899  					v->dpte_group_bytes,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4900  					v->PercentOfIdealDRAMFabricAndSDPPortBWReceivedAfterUrgLatencyPixelMixedWithVMData,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4901  					v->PercentOfIdealDRAMFabricAndSDPPortBWReceivedAfterUrgLatencyVMDataOnly,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4902  					v->HostVMMinPageSize,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4903  					v->HostVMMaxNonCachedPageTableLevels);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4904  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4905  			v->NextMaxVStartup = v->MaxMaxVStartup[i][j];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4906  			do {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4907  				v->PrefetchModePerState[i][j] = NextPrefetchModeState;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4908  				v->MaxVStartup = v->NextMaxVStartup;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4909  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4910  				v->TWait = CalculateTWait(v->PrefetchModePerState[i][j], v->FinalDRAMClockChangeLatency, v->UrgLatency[i], v->SREnterPlusExitTime);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4911  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4912  				for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4913  					Pipe myPipe = { 0 };
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4914  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4915  					myPipe.DPPCLK = v->RequiredDPPCLK[i][j][k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4916  					myPipe.DISPCLK = v->RequiredDISPCLK[i][j];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4917  					myPipe.PixelClock = v->PixelClock[k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4918  					myPipe.DCFCLKDeepSleep = v->ProjectedDCFCLKDeepSleep[i][j];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4919  					myPipe.DPPPerPlane = v->NoOfDPP[i][j][k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4920  					myPipe.ScalerEnabled = v->ScalerEnabled[k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4921  					myPipe.SourceScan = v->SourceScan[k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4922  					myPipe.BlockWidth256BytesY = v->Read256BlockWidthY[k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4923  					myPipe.BlockHeight256BytesY = v->Read256BlockHeightY[k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4924  					myPipe.BlockWidth256BytesC = v->Read256BlockWidthC[k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4925  					myPipe.BlockHeight256BytesC = v->Read256BlockHeightC[k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4926  					myPipe.InterlaceEnable = v->Interlace[k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4927  					myPipe.NumberOfCursors = v->NumberOfCursors[k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4928  					myPipe.VBlank = v->VTotal[k] - v->VActive[k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4929  					myPipe.HTotal = v->HTotal[k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4930  					myPipe.DCCEnable = v->DCCEnable[k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4931  					myPipe.ODMCombineEnabled = !!v->ODMCombineEnabled[k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4932  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4933  					v->NoTimeForPrefetch[i][j][k] = CalculatePrefetchSchedule(
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4934  							mode_lib,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4935  							v->PercentOfIdealDRAMFabricAndSDPPortBWReceivedAfterUrgLatencyPixelMixedWithVMData,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4936  							v->PercentOfIdealDRAMFabricAndSDPPortBWReceivedAfterUrgLatencyVMDataOnly,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4937  							&myPipe,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4938  							v->DSCDelayPerState[i][k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4939  							v->DPPCLKDelaySubtotal + v->DPPCLKDelayCNVCFormater,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4940  							v->DPPCLKDelaySCL,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4941  							v->DPPCLKDelaySCLLBOnly,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4942  							v->DPPCLKDelayCNVCCursor,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4943  							v->DISPCLKDelaySubtotal,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4944  							v->SwathWidthYThisState[k] / v->HRatio[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4945  							v->OutputFormat[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4946  							v->MaxInterDCNTileRepeaters,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4947  							dml_min(v->MaxVStartup, v->MaximumVStartup[i][j][k]),
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4948  							v->MaximumVStartup[i][j][k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4949  							v->GPUVMMaxPageTableLevels,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4950  							v->GPUVMEnable,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4951  							v->HostVMEnable,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4952  							v->HostVMMaxNonCachedPageTableLevels,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4953  							v->HostVMMinPageSize,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4954  							v->DynamicMetadataEnable[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4955  							v->DynamicMetadataVMEnabled,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4956  							v->DynamicMetadataLinesBeforeActiveRequired[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4957  							v->DynamicMetadataTransmittedBytes[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4958  							v->UrgLatency[i],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4959  							v->ExtraLatency,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4960  							v->TimeCalc,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4961  							v->PDEAndMetaPTEBytesPerFrame[i][j][k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4962  							v->MetaRowBytes[i][j][k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4963  							v->DPTEBytesPerRow[i][j][k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4964  							v->PrefetchLinesY[i][j][k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4965  							v->SwathWidthYThisState[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4966  							v->BytePerPixelY[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4967  							v->PrefillY[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4968  							v->MaxNumSwY[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4969  							v->PrefetchLinesC[i][j][k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4970  							v->SwathWidthCThisState[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4971  							v->BytePerPixelC[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4972  							v->PrefillC[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4973  							v->MaxNumSwC[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4974  							v->swath_width_luma_ub_this_state[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4975  							v->swath_width_chroma_ub_this_state[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4976  							v->SwathHeightYThisState[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4977  							v->SwathHeightCThisState[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4978  							v->TWait,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4979  							v->ProgressiveToInterlaceUnitInOPP,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4980  							&v->DSTXAfterScaler[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4981  							&v->DSTYAfterScaler[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4982  							&v->LineTimesForPrefetch[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4983  							&v->PrefetchBW[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4984  							&v->LinesForMetaPTE[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4985  							&v->LinesForMetaAndDPTERow[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4986  							&v->VRatioPreY[i][j][k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4987  							&v->VRatioPreC[i][j][k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4988  							&v->RequiredPrefetchPixelDataBWLuma[i][j][k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4989  							&v->RequiredPrefetchPixelDataBWChroma[i][j][k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4990  							&v->NoTimeForDynamicMetadata[i][j][k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4991  							&v->Tno_bw[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4992  							&v->prefetch_vmrow_bw[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4993  							&v->Tdmdl_vm[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4994  							&v->Tdmdl[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4995  							&v->VUpdateOffsetPix[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4996  							&v->VUpdateWidthPix[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4997  							&v->VReadyOffsetPix[k]);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4998  				}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  4999  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5000  				for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5001  					CalculateUrgentBurstFactor(
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5002  							v->swath_width_luma_ub_this_state[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5003  							v->swath_width_chroma_ub_this_state[k],
4469201b19354a Chaitanya Dhere     2021-04-20  5004  							v->DETBufferSizeInKByte[0],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5005  							v->SwathHeightYThisState[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5006  							v->SwathHeightCThisState[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5007  							v->HTotal[k] / v->PixelClock[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5008  							v->UrgentLatency,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5009  							v->CursorBufferSize,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5010  							v->CursorWidth[k][0],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5011  							v->CursorBPP[k][0],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5012  							v->VRatioPreY[i][j][k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5013  							v->VRatioPreC[i][j][k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5014  							v->BytePerPixelInDETY[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5015  							v->BytePerPixelInDETC[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5016  							v->DETBufferSizeYThisState[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5017  							v->DETBufferSizeCThisState[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5018  							&v->UrgentBurstFactorCursorPre[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5019  							&v->UrgentBurstFactorLumaPre[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5020  							&v->UrgentBurstFactorChroma[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5021  							&v->NoUrgentLatencyHidingPre[k]);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5022  				}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5023  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5024  				v->MaximumReadBandwidthWithPrefetch = 0.0;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5025  				for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5026  					v->cursor_bw_pre[k] = v->NumberOfCursors[k] * v->CursorWidth[k][0] * v->CursorBPP[k][0] / 8.0 / (v->HTotal[k] / v->PixelClock[k])
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5027  							* v->VRatioPreY[i][j][k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5028  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5029  					v->MaximumReadBandwidthWithPrefetch = v->MaximumReadBandwidthWithPrefetch
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5030  							+ dml_max4(
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5031  									v->VActivePixelBandwidth[i][j][k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5032  									v->VActiveCursorBandwidth[i][j][k]
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5033  											+ v->NoOfDPP[i][j][k] * (v->meta_row_bandwidth[i][j][k] + v->dpte_row_bandwidth[i][j][k]),
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5034  									v->NoOfDPP[i][j][k] * v->prefetch_vmrow_bw[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5035  									v->NoOfDPP[i][j][k]
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5036  											* (v->RequiredPrefetchPixelDataBWLuma[i][j][k] * v->UrgentBurstFactorLumaPre[k]
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5037  													+ v->RequiredPrefetchPixelDataBWChroma[i][j][k]
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5038  															* v->UrgentBurstFactorChromaPre[k])
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5039  											+ v->cursor_bw_pre[k] * v->UrgentBurstFactorCursorPre[k]);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5040  				}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5041  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5042  				v->NotEnoughUrgentLatencyHidingPre = false;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5043  				for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5044  					if (v->NoUrgentLatencyHidingPre[k] == true) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5045  						v->NotEnoughUrgentLatencyHidingPre = true;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5046  					}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5047  				}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5048  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5049  				v->PrefetchSupported[i][j] = true;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5050  				if (v->BandwidthWithoutPrefetchSupported[i][j] == false || v->MaximumReadBandwidthWithPrefetch > v->ReturnBWPerState[i][j]
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5051  						|| v->NotEnoughUrgentLatencyHidingPre == 1) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5052  					v->PrefetchSupported[i][j] = false;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5053  				}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5054  				for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5055  					if (v->LineTimesForPrefetch[k] < 2.0 || v->LinesForMetaPTE[k] >= 32.0 || v->LinesForMetaAndDPTERow[k] >= 16.0
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5056  							|| v->NoTimeForPrefetch[i][j][k] == true) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5057  						v->PrefetchSupported[i][j] = false;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5058  					}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5059  				}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5060  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5061  				v->DynamicMetadataSupported[i][j] = true;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5062  				for (k = 0; k < v->NumberOfActivePlanes; ++k) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5063  					if (v->NoTimeForDynamicMetadata[i][j][k] == true) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5064  						v->DynamicMetadataSupported[i][j] = false;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5065  					}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5066  				}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5067  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5068  				v->VRatioInPrefetchSupported[i][j] = true;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5069  				for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5070  					if (v->VRatioPreY[i][j][k] > 4.0 || v->VRatioPreC[i][j][k] > 4.0 || v->NoTimeForPrefetch[i][j][k] == true) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5071  						v->VRatioInPrefetchSupported[i][j] = false;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5072  					}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5073  				}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5074  				v->AnyLinesForVMOrRowTooLarge = false;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5075  				for (k = 0; k < v->NumberOfActivePlanes; ++k) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5076  					if (v->LinesForMetaAndDPTERow[k] >= 16 || v->LinesForMetaPTE[k] >= 32) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5077  						v->AnyLinesForVMOrRowTooLarge = true;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5078  					}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5079  				}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5080  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5081  				if (v->PrefetchSupported[i][j] == true && v->VRatioInPrefetchSupported[i][j] == true) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5082  					v->BandwidthAvailableForImmediateFlip = v->ReturnBWPerState[i][j];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5083  					for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5084  						v->BandwidthAvailableForImmediateFlip = v->BandwidthAvailableForImmediateFlip
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5085  								- dml_max(
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5086  										v->VActivePixelBandwidth[i][j][k] + v->VActiveCursorBandwidth[i][j][k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5087  										v->NoOfDPP[i][j][k]
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5088  												* (v->RequiredPrefetchPixelDataBWLuma[i][j][k] * v->UrgentBurstFactorLumaPre[k]
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5089  														+ v->RequiredPrefetchPixelDataBWChroma[i][j][k]
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5090  																* v->UrgentBurstFactorChromaPre[k])
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5091  												+ v->cursor_bw_pre[k] * v->UrgentBurstFactorCursorPre[k]);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5092  					}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5093  					v->TotImmediateFlipBytes = 0.0;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5094  					for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5095  						v->TotImmediateFlipBytes = v->TotImmediateFlipBytes + v->NoOfDPP[i][j][k] * v->PDEAndMetaPTEBytesPerFrame[i][j][k]
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5096  								+ v->MetaRowBytes[i][j][k] + v->DPTEBytesPerRow[i][j][k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5097  					}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5098  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5099  					for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5100  						CalculateFlipSchedule(
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5101  								mode_lib,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5102  								v->PercentOfIdealDRAMFabricAndSDPPortBWReceivedAfterUrgLatencyPixelMixedWithVMData,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5103  								v->PercentOfIdealDRAMFabricAndSDPPortBWReceivedAfterUrgLatencyVMDataOnly,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5104  								v->ExtraLatency,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5105  								v->UrgLatency[i],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5106  								v->GPUVMMaxPageTableLevels,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5107  								v->HostVMEnable,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5108  								v->HostVMMaxNonCachedPageTableLevels,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5109  								v->GPUVMEnable,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5110  								v->HostVMMinPageSize,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5111  								v->PDEAndMetaPTEBytesPerFrame[i][j][k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5112  								v->MetaRowBytes[i][j][k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5113  								v->DPTEBytesPerRow[i][j][k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5114  								v->BandwidthAvailableForImmediateFlip,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5115  								v->TotImmediateFlipBytes,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5116  								v->SourcePixelFormat[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5117  								v->HTotal[k] / v->PixelClock[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5118  								v->VRatio[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5119  								v->VRatioChroma[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5120  								v->Tno_bw[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5121  								v->DCCEnable[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5122  								v->dpte_row_height[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5123  								v->meta_row_height[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5124  								v->dpte_row_height_chroma[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5125  								v->meta_row_height_chroma[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5126  								&v->DestinationLinesToRequestVMInImmediateFlip[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5127  								&v->DestinationLinesToRequestRowInImmediateFlip[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5128  								&v->final_flip_bw[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5129  								&v->ImmediateFlipSupportedForPipe[k]);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5130  					}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5131  					v->total_dcn_read_bw_with_flip = 0.0;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5132  					for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5133  						v->total_dcn_read_bw_with_flip = v->total_dcn_read_bw_with_flip
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5134  								+ dml_max3(
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5135  										v->NoOfDPP[i][j][k] * v->prefetch_vmrow_bw[k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5136  										v->NoOfDPP[i][j][k] * v->final_flip_bw[k] + v->VActivePixelBandwidth[i][j][k]
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5137  												+ v->VActiveCursorBandwidth[i][j][k],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5138  										v->NoOfDPP[i][j][k]
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5139  												* (v->final_flip_bw[k]
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5140  														+ v->RequiredPrefetchPixelDataBWLuma[i][j][k]
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5141  																* v->UrgentBurstFactorLumaPre[k]
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5142  														+ v->RequiredPrefetchPixelDataBWChroma[i][j][k]
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5143  																* v->UrgentBurstFactorChromaPre[k])
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5144  												+ v->cursor_bw_pre[k] * v->UrgentBurstFactorCursorPre[k]);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5145  					}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5146  					v->ImmediateFlipSupportedForState[i][j] = true;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5147  					if (v->total_dcn_read_bw_with_flip > v->ReturnBWPerState[i][j]) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5148  						v->ImmediateFlipSupportedForState[i][j] = false;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5149  					}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5150  					for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5151  						if (v->ImmediateFlipSupportedForPipe[k] == false) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5152  							v->ImmediateFlipSupportedForState[i][j] = false;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5153  						}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5154  					}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5155  				} else {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5156  					v->ImmediateFlipSupportedForState[i][j] = false;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5157  				}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5158  				if (v->MaxVStartup <= 13 || v->AnyLinesForVMOrRowTooLarge == false) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5159  					v->NextMaxVStartup = v->MaxMaxVStartup[i][j];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5160  					NextPrefetchModeState = NextPrefetchModeState + 1;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5161  				} else {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5162  					v->NextMaxVStartup = v->NextMaxVStartup - 1;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5163  				}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5164  			} while (!((v->PrefetchSupported[i][j] == true && v->DynamicMetadataSupported[i][j] == true && v->VRatioInPrefetchSupported[i][j] == true
9f95e77800f3ba Alvin Lee           2021-06-17  5165  					&& ((v->HostVMEnable == false && v->ImmediateFlipRequirement[0] != dm_immediate_flip_required)
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5166  							|| v->ImmediateFlipSupportedForState[i][j] == true))
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5167  					|| (v->NextMaxVStartup == v->MaxMaxVStartup[i][j] && NextPrefetchModeState > MaxPrefetchMode)));
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5168  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5169  			CalculateWatermarksAndDRAMSpeedChangeSupport(
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5170  					mode_lib,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5171  					v->PrefetchModePerState[i][j],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5172  					v->NumberOfActivePlanes,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5173  					v->MaxLineBufferLines,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5174  					v->LineBufferSize,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5175  					v->DPPOutputBufferPixels,
4469201b19354a Chaitanya Dhere     2021-04-20  5176  					v->DETBufferSizeInKByte[0],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5177  					v->WritebackInterfaceBufferSize,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5178  					v->DCFCLKState[i][j],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5179  					v->ReturnBWPerState[i][j],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5180  					v->GPUVMEnable,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5181  					v->dpte_group_bytes,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5182  					v->MetaChunkSize,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5183  					v->UrgLatency[i],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5184  					v->ExtraLatency,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5185  					v->WritebackLatency,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5186  					v->WritebackChunkSize,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5187  					v->SOCCLKPerState[i],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5188  					v->FinalDRAMClockChangeLatency,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5189  					v->SRExitTime,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5190  					v->SREnterPlusExitTime,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5191  					v->ProjectedDCFCLKDeepSleep[i][j],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5192  					v->NoOfDPPThisState,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5193  					v->DCCEnable,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5194  					v->RequiredDPPCLKThisState,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5195  					v->DETBufferSizeYThisState,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5196  					v->DETBufferSizeCThisState,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5197  					v->SwathHeightYThisState,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5198  					v->SwathHeightCThisState,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5199  					v->LBBitPerPixel,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5200  					v->SwathWidthYThisState,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5201  					v->SwathWidthCThisState,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5202  					v->HRatio,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5203  					v->HRatioChroma,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5204  					v->vtaps,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5205  					v->VTAPsChroma,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5206  					v->VRatio,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5207  					v->VRatioChroma,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5208  					v->HTotal,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5209  					v->PixelClock,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5210  					v->BlendingAndTiming,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5211  					v->BytePerPixelInDETY,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5212  					v->BytePerPixelInDETC,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5213  					v->DSTXAfterScaler,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5214  					v->DSTYAfterScaler,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5215  					v->WritebackEnable,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5216  					v->WritebackPixelFormat,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5217  					v->WritebackDestinationWidth,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5218  					v->WritebackDestinationHeight,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5219  					v->WritebackSourceHeight,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5220  					&v->DRAMClockChangeSupport[i][j],
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5221  					&v->UrgentWatermark,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5222  					&v->WritebackUrgentWatermark,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5223  					&v->DRAMClockChangeWatermark,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5224  					&v->WritebackDRAMClockChangeWatermark,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5225  					&v->StutterExitWatermark,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5226  					&v->StutterEnterPlusExitWatermark,
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5227  					&v->MinActiveDRAMClockChangeLatencySupported);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5228  		}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5229  	}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5230  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5231  	/*PTE Buffer Size Check*/
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5232  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5233  	for (i = 0; i < v->soc.num_states; i++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5234  		for (j = 0; j < 2; j++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5235  			v->PTEBufferSizeNotExceeded[i][j] = true;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5236  			for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5237  				if (v->PTEBufferSizeNotExceededY[i][j][k] == false || v->PTEBufferSizeNotExceededC[i][j][k] == false) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5238  					v->PTEBufferSizeNotExceeded[i][j] = false;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5239  				}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5240  			}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5241  		}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5242  	}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5243  	/*Cursor Support Check*/
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5244  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5245  	v->CursorSupport = true;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5246  	for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5247  		if (v->CursorWidth[k][0] > 0.0) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5248  			if (v->CursorBPP[k][0] == 64 && v->Cursor64BppSupport == false) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5249  				v->CursorSupport = false;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5250  			}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5251  		}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5252  	}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5253  	/*Valid Pitch Check*/
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5254  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5255  	v->PitchSupport = true;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5256  	for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5257  		v->AlignedYPitch[k] = dml_ceil(dml_max(v->PitchY[k], v->SurfaceWidthY[k]), v->MacroTileWidthY[k]);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5258  		if (v->DCCEnable[k] == true) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5259  			v->AlignedDCCMetaPitchY[k] = dml_ceil(dml_max(v->DCCMetaPitchY[k], v->SurfaceWidthY[k]), 64.0 * v->Read256BlockWidthY[k]);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5260  		} else {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5261  			v->AlignedDCCMetaPitchY[k] = v->DCCMetaPitchY[k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5262  		}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5263  		if (v->SourcePixelFormat[k] != dm_444_64 && v->SourcePixelFormat[k] != dm_444_32 && v->SourcePixelFormat[k] != dm_444_16 && v->SourcePixelFormat[k] != dm_mono_16
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5264  				&& v->SourcePixelFormat[k] != dm_rgbe && v->SourcePixelFormat[k] != dm_mono_8) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5265  			v->AlignedCPitch[k] = dml_ceil(dml_max(v->PitchC[k], v->SurfaceWidthC[k]), v->MacroTileWidthC[k]);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5266  			if (v->DCCEnable[k] == true) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5267  				v->AlignedDCCMetaPitchC[k] = dml_ceil(dml_max(v->DCCMetaPitchC[k], v->SurfaceWidthC[k]), 64.0 * v->Read256BlockWidthC[k]);
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5268  			} else {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5269  				v->AlignedDCCMetaPitchC[k] = v->DCCMetaPitchC[k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5270  			}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5271  		} else {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5272  			v->AlignedCPitch[k] = v->PitchC[k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5273  			v->AlignedDCCMetaPitchC[k] = v->DCCMetaPitchC[k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5274  		}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5275  		if (v->AlignedYPitch[k] > v->PitchY[k] || v->AlignedCPitch[k] > v->PitchC[k] || v->AlignedDCCMetaPitchY[k] > v->DCCMetaPitchY[k]
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5276  				|| v->AlignedDCCMetaPitchC[k] > v->DCCMetaPitchC[k]) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5277  			v->PitchSupport = false;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5278  		}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5279  	}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5280  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5281  	for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5282  		if (v->ViewportWidth[k] > v->SurfaceWidthY[k] || v->ViewportHeight[k] > v->SurfaceHeightY[k])
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5283  			ViewportExceedsSurface = true;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5284  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5285  		if (v->SourcePixelFormat[k] != dm_444_64 && v->SourcePixelFormat[k] != dm_444_32 && v->SourcePixelFormat[k] != dm_444_16
71f49c4898eef4 Ye Bin              2020-09-17  5286  				&& v->SourcePixelFormat[k] != dm_444_8 && v->SourcePixelFormat[k] != dm_rgbe) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5287  			if (v->ViewportWidthChroma[k] > v->SurfaceWidthC[k] || v->ViewportHeightChroma[k] > v->SurfaceHeightC[k]) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5288  				ViewportExceedsSurface = true;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5289  			}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5290  		}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5291  	}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5292  	/*Mode Support, Voltage State and SOC Configuration*/
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5293  
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5294  	for (i = v->soc.num_states - 1; i >= 0; i--) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5295  		for (j = 0; j < 2; j++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5296  			if (v->ScaleRatioAndTapsSupport == 1 && v->SourceFormatPixelAndScanSupport == 1 && v->ViewportSizeSupport[i][j] == 1
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5297  					&& v->DIOSupport[i] == 1 && v->ODMCombine4To1SupportCheckOK[i] == 1
346cf627fb27c0 Nikola Cornij       2021-05-18  5298  					&& v->NotEnoughDSCUnits[i] == 0
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5299  					&& v->DTBCLKRequiredMoreThanSupported[i] == 0
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5300  					&& v->ROBSupport[i][j] == 1 && v->DISPCLK_DPPCLK_Support[i][j] == 1 && v->TotalAvailablePipesSupport[i][j] == 1
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5301  					&& EnoughWritebackUnits == 1 && WritebackModeSupport == 1
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5302  					&& v->WritebackLatencySupport == 1 && v->WritebackScaleRatioAndTapsSupport == 1 && v->CursorSupport == 1 && v->PitchSupport == 1
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5303  					&& ViewportExceedsSurface == 0 && v->PrefetchSupported[i][j] == 1 && v->DynamicMetadataSupported[i][j] == 1
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5304  					&& v->TotalVerticalActiveBandwidthSupport[i][j] == 1 && v->VRatioInPrefetchSupported[i][j] == 1
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5305  					&& v->PTEBufferSizeNotExceeded[i][j] == 1 && v->NonsupportedDSCInputBPC == 0
9f95e77800f3ba Alvin Lee           2021-06-17  5306  					&& ((v->HostVMEnable == 0 && v->ImmediateFlipRequirement[0] != dm_immediate_flip_required)
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5307  							|| v->ImmediateFlipSupportedForState[i][j] == true)) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5308  				v->ModeSupport[i][j] = true;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5309  			} else {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5310  				v->ModeSupport[i][j] = false;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5311  			}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5312  		}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5313  	}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5314  	{
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5315  		unsigned int MaximumMPCCombine = 0;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5316  		for (i = v->soc.num_states; i >= 0; i--) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5317  			if (i == v->soc.num_states || v->ModeSupport[i][0] == true || v->ModeSupport[i][1] == true) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5318  				v->VoltageLevel = i;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5319  				v->ModeIsSupported = v->ModeSupport[i][0] == true || v->ModeSupport[i][1] == true;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5320  				if (v->ModeSupport[i][1] == true) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5321  					MaximumMPCCombine = 1;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5322  				} else {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5323  					MaximumMPCCombine = 0;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5324  				}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5325  			}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5326  		}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5327  		v->ImmediateFlipSupport = v->ImmediateFlipSupportedForState[v->VoltageLevel][MaximumMPCCombine];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5328  		for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5329  			v->MPCCombineEnable[k] = v->MPCCombine[v->VoltageLevel][MaximumMPCCombine][k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5330  			v->DPPPerPlane[k] = v->NoOfDPP[v->VoltageLevel][MaximumMPCCombine][k];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5331  		}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5332  		v->DCFCLK = v->DCFCLKState[v->VoltageLevel][MaximumMPCCombine];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5333  		v->DRAMSpeed = v->DRAMSpeedPerState[v->VoltageLevel];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5334  		v->FabricClock = v->FabricClockPerState[v->VoltageLevel];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5335  		v->SOCCLK = v->SOCCLKPerState[v->VoltageLevel];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5336  		v->ReturnBW = v->ReturnBWPerState[v->VoltageLevel][MaximumMPCCombine];
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5337  		v->maxMpcComb = MaximumMPCCombine;
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5338  	}
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5339  }
6725a88f88a7e9 Bhawanpreet Lakha   2020-05-21  5340  

:::::: The code at line 3637 was first introduced by commit
:::::: 6725a88f88a7e922e91c45bf83d320487810c192 drm/amd/display: Add DCN3 DML

:::::: TO: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
