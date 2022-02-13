Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76024B3D5B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 21:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236003AbiBMUVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 15:21:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbiBMUVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 15:21:15 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D98532E0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 12:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644783668; x=1676319668;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=B95xdXdHmWxdgNh3ecp02Wd/uPuUcWHNRTXWP56vqBA=;
  b=nqiZdR1WR3m2Yjk5lLWe46MBoWb3UL5Y2fz8z5DqO23fnP32QV1aVHsJ
   2aQdHxof6e3V3Z9pNHig6zNY7ELBBI3Y0mggKI6SUh9stnyj3h3Nk9dec
   k6lLDjWFrxgVDMRhG1RnG+tYMLh8NpTrCOMGsqx+QWxWLaW4B0qvkGaHQ
   hbCw7U9CI+reKrlUb5gOjpMa2BTv0/1KDAyru39LpaxOneAymIsfI/+Nn
   EASh0bhkvYx/EOyezu05Z1/nSsbtu2xEyBQBa36IS2YaxUezlCp3xemb9
   a3G9+s5qhYJcFGiHxdNV1DoGyPItDyHRIK9Ko5UmqtrDoVoCFSEOgFntQ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="247566071"
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="247566071"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 12:21:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="634713203"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 13 Feb 2022 12:21:05 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJLMn-0007nn-3J; Sun, 13 Feb 2022 20:21:05 +0000
Date:   Mon, 14 Feb 2022 04:20:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c:1148:26: error: variable
 'priv' set but not used
Message-ID: <202202140432.v7pvcbKc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c5d714aa6dce262482992cccc0ab01383294f7ac
commit: 167dac97eb46c7b8a15b2195080e191bb0c9ce35 drm/msm/dp: Modify prototype of encoder based API
date:   4 months ago
config: arm-randconfig-r006-20220213 (https://download.01.org/0day-ci/archive/20220214/202202140432.v7pvcbKc-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 478c237e21b2c3a83e46f26fcbeb3876682f9b14)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=167dac97eb46c7b8a15b2195080e191bb0c9ce35
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 167dac97eb46c7b8a15b2195080e191bb0c9ce35
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/gpu/drm/msm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c:1148:26: error: variable 'priv' set but not used [-Werror,-Wunused-but-set-variable]
           struct msm_drm_private *priv;
                                   ^
   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c:1197:26: error: variable 'priv' set but not used [-Werror,-Wunused-but-set-variable]
           struct msm_drm_private *priv;
                                   ^
   2 errors generated.


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
