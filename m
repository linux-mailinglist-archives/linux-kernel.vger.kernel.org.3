Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FE74E88F7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 18:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236083AbiC0Qr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 12:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235060AbiC0Qrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 12:47:55 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2762013CF9
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 09:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648399576; x=1679935576;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=yVsrP3tyOesK2UcDeqUPYX5bwgfBmBpYlO07wiAw8eg=;
  b=C03X+QC7I4g8HqoxJhAUnQqUwBo5zQF3bAfXB/x/zTYuflumgMQrtteW
   27CaF4NX3BvjPG448CH5BtMfTxkf47Pyy36eUQPvd18Msqu4SWjxxaL6Z
   1uZXI1cLPR8aAcWNCsfbGGxPr2xutxtoy91MyzoLOAS1xDvQbw+1v+N4l
   WC3vb2a424BAI7L8TFxrY6mRweU/iYPqUjK1ZEkTWcGubGzFbo9+GM5XA
   I8Yw5nrw9uoRhkNAZFhjgoulGBqECSZQU4o+V+7THZv44L5wcRETdhRXq
   jUubw85pc8v9P22+E/U/lEWWaaz1MvHLI5C6wTGkMqbemgCbC+m3nYISL
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10299"; a="241016549"
X-IronPort-AV: E=Sophos;i="5.90,215,1643702400"; 
   d="scan'208";a="241016549"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2022 09:46:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,215,1643702400"; 
   d="scan'208";a="502269540"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 27 Mar 2022 09:46:13 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nYW1s-0001FI-UO; Sun, 27 Mar 2022 16:46:12 +0000
Date:   Mon, 28 Mar 2022 00:46:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>
Subject: drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c:552:40: warning:
 variable 'mode' set but not used
Message-ID: <202203280038.k7SUnGSa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f022814633e1c600507b3a99691b4d624c2813f0
commit: 3177589c6e934494e72a2d5934539a836b986390 drm/msm/dpu: encoder: drop unused mode_fixup callback
date:   5 weeks ago
config: nios2-allyesconfig (https://download.01.org/0day-ci/archive/20220328/202203280038.k7SUnGSa-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3177589c6e934494e72a2d5934539a836b986390
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 3177589c6e934494e72a2d5934539a836b986390
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash drivers/gpu/drm/msm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c: In function 'dpu_encoder_virt_atomic_check':
>> drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c:552:40: warning: variable 'mode' set but not used [-Wunused-but-set-variable]
     552 |         const struct drm_display_mode *mode;
         |                                        ^~~~


vim +/mode +552 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c

25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  501  
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  502  static struct msm_display_topology dpu_encoder_get_topology(
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  503  			struct dpu_encoder_virt *dpu_enc,
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  504  			struct dpu_kms *dpu_kms,
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  505  			struct drm_display_mode *mode)
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  506  {
5fddd4f5db8730 Kalyan Thota      2020-06-11  507  	struct msm_display_topology topology = {0};
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  508  	int i, intf_count = 0;
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  509  
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  510  	for (i = 0; i < MAX_PHYS_ENCODERS_PER_VIRTUAL; i++)
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  511  		if (dpu_enc->phys_encs[i])
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  512  			intf_count++;
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  513  
42a558b71c9ead Kalyan Thota      2019-11-25  514  	/* Datapath topology selection
42a558b71c9ead Kalyan Thota      2019-11-25  515  	 *
42a558b71c9ead Kalyan Thota      2019-11-25  516  	 * Dual display
42a558b71c9ead Kalyan Thota      2019-11-25  517  	 * 2 LM, 2 INTF ( Split display using 2 interfaces)
42a558b71c9ead Kalyan Thota      2019-11-25  518  	 *
42a558b71c9ead Kalyan Thota      2019-11-25  519  	 * Single display
42a558b71c9ead Kalyan Thota      2019-11-25  520  	 * 1 LM, 1 INTF
42a558b71c9ead Kalyan Thota      2019-11-25  521  	 * 2 LM, 1 INTF (stream merge to support high resolution interfaces)
42a558b71c9ead Kalyan Thota      2019-11-25  522  	 *
5fddd4f5db8730 Kalyan Thota      2020-06-11  523  	 * Adding color blocks only to primary interface if available in
5fddd4f5db8730 Kalyan Thota      2020-06-11  524  	 * sufficient number
42a558b71c9ead Kalyan Thota      2019-11-25  525  	 */
42a558b71c9ead Kalyan Thota      2019-11-25  526  	if (intf_count == 2)
42a558b71c9ead Kalyan Thota      2019-11-25  527  		topology.num_lm = 2;
42a558b71c9ead Kalyan Thota      2019-11-25  528  	else if (!dpu_kms->catalog->caps->has_3d_merge)
42a558b71c9ead Kalyan Thota      2019-11-25  529  		topology.num_lm = 1;
42a558b71c9ead Kalyan Thota      2019-11-25  530  	else
42a558b71c9ead Kalyan Thota      2019-11-25  531  		topology.num_lm = (mode->hdisplay > MAX_HDISPLAY_SPLIT) ? 2 : 1;
42a558b71c9ead Kalyan Thota      2019-11-25  532  
5fddd4f5db8730 Kalyan Thota      2020-06-11  533  	if (dpu_enc->disp_info.intf_type == DRM_MODE_ENCODER_DSI) {
5fddd4f5db8730 Kalyan Thota      2020-06-11  534  		if (dpu_kms->catalog->dspp &&
5fddd4f5db8730 Kalyan Thota      2020-06-11  535  			(dpu_kms->catalog->dspp_count >= topology.num_lm))
e47616df008b10 Kalyan Thota      2020-03-24  536  			topology.num_dspp = topology.num_lm;
5fddd4f5db8730 Kalyan Thota      2020-06-11  537  	}
e47616df008b10 Kalyan Thota      2020-03-24  538  
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  539  	topology.num_enc = 0;
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  540  	topology.num_intf = intf_count;
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  541  
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  542  	return topology;
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  543  }
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  544  static int dpu_encoder_virt_atomic_check(
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  545  		struct drm_encoder *drm_enc,
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  546  		struct drm_crtc_state *crtc_state,
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  547  		struct drm_connector_state *conn_state)
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  548  {
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  549  	struct dpu_encoder_virt *dpu_enc;
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  550  	struct msm_drm_private *priv;
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  551  	struct dpu_kms *dpu_kms;
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27 @552  	const struct drm_display_mode *mode;
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  553  	struct drm_display_mode *adj_mode;
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  554  	struct msm_display_topology topology;
de3916c70a24e3 Drew Davenport    2020-02-19  555  	struct dpu_global_state *global_state;
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  556  	int i = 0;
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  557  	int ret = 0;
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  558  
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  559  	if (!drm_enc || !crtc_state || !conn_state) {
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  560  		DPU_ERROR("invalid arg(s), drm_enc %d, crtc/conn state %d/%d\n",
e6790f7210062e Zheng Bin         2020-01-23  561  				drm_enc != NULL, crtc_state != NULL, conn_state != NULL);
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  562  		return -EINVAL;
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  563  	}
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  564  
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  565  	dpu_enc = to_dpu_encoder_virt(drm_enc);
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  566  	DPU_DEBUG_ENC(dpu_enc, "\n");
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  567  
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  568  	priv = drm_enc->dev->dev_private;
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  569  	dpu_kms = to_dpu_kms(priv->kms);
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  570  	mode = &crtc_state->mode;
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  571  	adj_mode = &crtc_state->adjusted_mode;
ccc862b957c641 Kalyan Thota      2020-08-10  572  	global_state = dpu_kms_get_global_state(crtc_state->state);
ccc862b957c641 Kalyan Thota      2020-08-10  573  	if (IS_ERR(global_state))
ccc862b957c641 Kalyan Thota      2020-08-10  574  		return PTR_ERR(global_state);
ccc862b957c641 Kalyan Thota      2020-08-10  575  
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  576  	trace_dpu_enc_atomic_check(DRMID(drm_enc));
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  577  
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  578  	/* perform atomic check on the first physical encoder (master) */
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  579  	for (i = 0; i < dpu_enc->num_phys_encs; i++) {
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  580  		struct dpu_encoder_phys *phys = dpu_enc->phys_encs[i];
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  581  
b6fadcade62704 Drew Davenport    2019-12-06  582  		if (phys->ops.atomic_check)
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  583  			ret = phys->ops.atomic_check(phys, crtc_state,
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  584  					conn_state);
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  585  		if (ret) {
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  586  			DPU_ERROR_ENC(dpu_enc,
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  587  					"mode unsupported, phys idx %d\n", i);
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  588  			break;
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  589  		}
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  590  	}
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  591  
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  592  	topology = dpu_encoder_get_topology(dpu_enc, dpu_kms, adj_mode);
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  593  
de3916c70a24e3 Drew Davenport    2020-02-19  594  	/* Reserve dynamic resources now. */
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  595  	if (!ret) {
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  596  		/*
ccc862b957c641 Kalyan Thota      2020-08-10  597  		 * Release and Allocate resources on every modeset
ccc862b957c641 Kalyan Thota      2020-08-10  598  		 * Dont allocate when active is false.
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  599  		 */
de3916c70a24e3 Drew Davenport    2020-02-19  600  		if (drm_atomic_crtc_needs_modeset(crtc_state)) {
ccc862b957c641 Kalyan Thota      2020-08-10  601  			dpu_rm_release(global_state, drm_enc);
ccc862b957c641 Kalyan Thota      2020-08-10  602  
ccc862b957c641 Kalyan Thota      2020-08-10  603  			if (!crtc_state->active_changed || crtc_state->active)
de3916c70a24e3 Drew Davenport    2020-02-19  604  				ret = dpu_rm_reserve(&dpu_kms->rm, global_state,
de3916c70a24e3 Drew Davenport    2020-02-19  605  						drm_enc, crtc_state, topology);
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  606  		}
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  607  	}
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  608  
5dce0c0b92d426 Ville Syrjälä     2020-04-28  609  	trace_dpu_enc_atomic_check_flags(DRMID(drm_enc), adj_mode->flags);
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  610  
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  611  	return ret;
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  612  }
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  613  

:::::: The code at line 552 was first introduced by commit
:::::: 25fdd5933e4c0f5fe2ea5cd59994f8ac5fbe90ef drm/msm: Add SDM845 DPU support

:::::: TO: Jeykumar Sankaran <jsanka@codeaurora.org>
:::::: CC: Sean Paul <seanpaul@chromium.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
