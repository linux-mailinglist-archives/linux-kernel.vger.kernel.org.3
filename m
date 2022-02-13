Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B10B4B3B3D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 13:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235871AbiBMMND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 07:13:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiBMMNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 07:13:01 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590AE5BD1F
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 04:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644754375; x=1676290375;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+1nyQhInHKiE5L1NPY2vkzjd24HvWdP2YuP0xFGH5lA=;
  b=nogyjQ3Bv/nU610nzoPlrDBz11nqfPYO+BDXioc0APh8Nl0seEqFlNfb
   lxNkzV/5hkkNfwYWRakmm2J8nEwvDo1jcpTaNsXdhnvOU2rqoENpV2Wga
   noqfoXsrwQC6hPxBUaLOPdFyvpYUCsgbgqU1C+bas7DmaReMGh22OwYte
   s9pbc+Hbg7pC1FX6z0HNtHdnn/cTK+2sonS2S2Mlh3LFpNu8+HeEW3tHk
   JUG1FpSsHrsyS8PS030KL5jRmUtPs20EO9nh3sRBltT+fw1Sgjo0CzkKd
   jCsuKwhQOlSTCvxJ24kbeO7Cl/qW0t5w8nTItZ2+yE4GGIJvDtZ2hJNAr
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10256"; a="336368965"
X-IronPort-AV: E=Sophos;i="5.88,365,1635231600"; 
   d="scan'208";a="336368965"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 04:12:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,365,1635231600"; 
   d="scan'208";a="484757246"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 13 Feb 2022 04:12:53 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJDkK-0007Ti-MN; Sun, 13 Feb 2022 12:12:52 +0000
Date:   Sun, 13 Feb 2022 20:12:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rob Clark <robdclark@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dave Airlie <airlied@redhat.com>
Subject: drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c:1148:33: error: variable
 'priv' set but not used
Message-ID: <202202132058.hSfn3UlB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b81b1829e7e39f6cebdf6e4d5484eacbceda8554
commit: de99e6479885dfa3f64a9511a6477c2b7899e53f Merge tag 'drm-msm-next-2021-10-26' of https://gitlab.freedesktop.org/drm/msm into drm-next
date:   4 months ago
config: parisc-randconfig-r015-20220213 (https://download.01.org/0day-ci/archive/20220213/202202132058.hSfn3UlB-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=de99e6479885dfa3f64a9511a6477c2b7899e53f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout de99e6479885dfa3f64a9511a6477c2b7899e53f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash drivers/gpu/drm/msm/ drivers/misc/cardreader/ drivers/net/ethernet/broadcom/bnxt/ drivers/staging/vc04_services/ mm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c:17:
   drivers/gpu/drm/msm/msm_drv.h:531: error: "COND" redefined [-Werror]
     531 | #define COND(bool, val) ((bool) ? (val) : 0)
         | 
   In file included from arch/parisc/include/asm/jump_label.h:8,
                    from include/linux/jump_label.h:117,
                    from include/linux/static_key.h:1,
                    from include/linux/kasan.h:7,
                    from include/linux/slab.h:136,
                    from include/linux/resource_ext.h:11,
                    from include/linux/acpi.h:14,
                    from include/linux/i2c.h:13,
                    from include/drm/drm_crtc.h:28,
                    from drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c:13:
   arch/parisc/include/asm/assembly.h:37: note: this is the location of the previous definition
      37 | #define COND(x) x
         | 
   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c: In function 'dpu_encoder_virt_enable':
>> drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c:1148:33: error: variable 'priv' set but not used [-Werror=unused-but-set-variable]
    1148 |         struct msm_drm_private *priv;
         |                                 ^~~~
   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c: In function 'dpu_encoder_virt_disable':
   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c:1197:33: error: variable 'priv' set but not used [-Werror=unused-but-set-variable]
    1197 |         struct msm_drm_private *priv;
         |                                 ^~~~
   cc1: all warnings being treated as errors


vim +/priv +1148 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c

25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1143  
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1144  static void dpu_encoder_virt_enable(struct drm_encoder *drm_enc)
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1145  {
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1146  	struct dpu_encoder_virt *dpu_enc = NULL;
86b89080368b46 Jeykumar Sankaran 2018-09-05  1147  	int ret = 0;
c943b4948b5848 Chandan Uddaraju  2020-08-27 @1148  	struct msm_drm_private *priv;
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1149  	struct drm_display_mode *cur_mode = NULL;
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1150  
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1151  	if (!drm_enc) {
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1152  		DPU_ERROR("invalid encoder\n");
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1153  		return;
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1154  	}
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1155  	dpu_enc = to_dpu_encoder_virt(drm_enc);
fba7427eb59496 Sean Paul         2018-11-16  1156  
fba7427eb59496 Sean Paul         2018-11-16  1157  	mutex_lock(&dpu_enc->enc_lock);
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1158  	cur_mode = &dpu_enc->base.crtc->state->adjusted_mode;
c943b4948b5848 Chandan Uddaraju  2020-08-27  1159  	priv = drm_enc->dev->dev_private;
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1160  
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1161  	trace_dpu_enc_enable(DRMID(drm_enc), cur_mode->hdisplay,
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1162  			     cur_mode->vdisplay);
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1163  
86b89080368b46 Jeykumar Sankaran 2018-09-05  1164  	/* always enable slave encoder before master */
86b89080368b46 Jeykumar Sankaran 2018-09-05  1165  	if (dpu_enc->cur_slave && dpu_enc->cur_slave->ops.enable)
86b89080368b46 Jeykumar Sankaran 2018-09-05  1166  		dpu_enc->cur_slave->ops.enable(dpu_enc->cur_slave);
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1167  
86b89080368b46 Jeykumar Sankaran 2018-09-05  1168  	if (dpu_enc->cur_master && dpu_enc->cur_master->ops.enable)
86b89080368b46 Jeykumar Sankaran 2018-09-05  1169  		dpu_enc->cur_master->ops.enable(dpu_enc->cur_master);
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1170  
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1171  	ret = dpu_encoder_resource_control(drm_enc, DPU_ENC_RC_EVENT_KICKOFF);
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1172  	if (ret) {
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1173  		DPU_ERROR_ENC(dpu_enc, "dpu resource control failed: %d\n",
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1174  				ret);
fba7427eb59496 Sean Paul         2018-11-16  1175  		goto out;
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1176  	}
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1177  
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1178  	_dpu_encoder_virt_enable_helper(drm_enc);
fba7427eb59496 Sean Paul         2018-11-16  1179  
167dac97eb46c7 Bjorn Andersson   2021-10-16  1180  	if (drm_enc->encoder_type == DRM_MODE_ENCODER_TMDS) {
167dac97eb46c7 Bjorn Andersson   2021-10-16  1181  		ret = msm_dp_display_enable(dpu_enc->dp, drm_enc);
c943b4948b5848 Chandan Uddaraju  2020-08-27  1182  		if (ret) {
c943b4948b5848 Chandan Uddaraju  2020-08-27  1183  			DPU_ERROR_ENC(dpu_enc, "dp display enable failed: %d\n",
c943b4948b5848 Chandan Uddaraju  2020-08-27  1184  				ret);
c943b4948b5848 Chandan Uddaraju  2020-08-27  1185  			goto out;
c943b4948b5848 Chandan Uddaraju  2020-08-27  1186  		}
c943b4948b5848 Chandan Uddaraju  2020-08-27  1187  	}
fba7427eb59496 Sean Paul         2018-11-16  1188  	dpu_enc->enabled = true;
fba7427eb59496 Sean Paul         2018-11-16  1189  
fba7427eb59496 Sean Paul         2018-11-16  1190  out:
fba7427eb59496 Sean Paul         2018-11-16  1191  	mutex_unlock(&dpu_enc->enc_lock);
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1192  }
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1193  

:::::: The code at line 1148 was first introduced by commit
:::::: c943b4948b5848fc0e07f875edbd35a973879e22 drm/msm/dp: add displayPort driver support

:::::: TO: Chandan Uddaraju <chandanu@codeaurora.org>
:::::: CC: Rob Clark <robdclark@chromium.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
