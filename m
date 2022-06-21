Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3F855340E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 15:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiFUNyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 09:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348291AbiFUNyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 09:54:08 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1DA193FB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 06:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655819647; x=1687355647;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cLJArMKFHmSHj/ohd454nwLWu8zVjvOFKtX3gm3ssB0=;
  b=E8+MnG+r0DTdO9cULJ3xxaWGaFqoUD8m23pb0Icg+W/5EYB5MpjglyzU
   lfXcNexfYigjNJ9XNk/BX6owRhhgs6yQ7I9sOCX4+RmaQU57GWNKkV6r+
   GszxnPuQgj6LdLb34iQLsL1FXQcoxBAeBkiD9/jUTvDcCeoIhwea4Lctc
   eDNKB2EQXEt6UlvnrxMMFBxaP8sXlbRL5VM6pfuGZjunqFYM3vI+vNUfd
   wdERBU5H6wM5dOnKYeXsc1Axs4FAXkEMokcge03iM+59VROwA32IbcLeU
   nq+vIJJIlb6eKnHhUbi5zbkvoMpxj09YlpWRseCjiH9gJXpBtZWt+JD+8
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="263155307"
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="263155307"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 06:54:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="538041861"
Received: from lkp-server02.sh.intel.com (HELO 08b4593be841) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 21 Jun 2022 06:54:05 -0700
Received: from kbuild by 08b4593be841 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3eKS-00002N-Vw;
        Tue, 21 Jun 2022 13:54:04 +0000
Date:   Tue, 21 Jun 2022 21:53:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [mgr:v5.19/topic/rk3568-vepu-h264-stateless-bootlin 3/4]
 drivers/staging/media/hantro/rockchip_vpu_hw_h264_enc.c:102:13: warning:
 variable 'encoded_slices' set but not used
Message-ID: <202206212137.GYulaDuT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.pengutronix.de/git/mgr/linux v5.19/topic/rk3568-vepu-h264-stateless-bootlin
head:   11fcd09bf7cbe84c3e2e322142e3aff59c5c8402
commit: a373f546c23855d80f8a6be85fc11748ed54413d [3/4] media: hantro: Add H.264 encoding support
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220621/202206212137.GYulaDuT-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add mgr https://git.pengutronix.de/git/mgr/linux
        git fetch --no-tags mgr v5.19/topic/rk3568-vepu-h264-stateless-bootlin
        git checkout a373f546c23855d80f8a6be85fc11748ed54413d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash drivers/power/supply/ drivers/staging/media/hantro/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/staging/media/hantro/rockchip_vpu_hw_h264_enc.c: In function 'rk3399_vpu_h264_enc_done':
>> drivers/staging/media/hantro/rockchip_vpu_hw_h264_enc.c:102:13: warning: variable 'encoded_slices' set but not used [-Wunused-but-set-variable]
     102 |         u32 encoded_slices;
         |             ^~~~~~~~~~~~~~


vim +/encoded_slices +102 drivers/staging/media/hantro/rockchip_vpu_hw_h264_enc.c

    92	
    93	void rk3399_vpu_h264_enc_done(struct hantro_ctx *ctx)
    94	{
    95		struct hantro_dev *vpu = ctx->dev;
    96		struct vb2_v4l2_buffer *dst_buf;
    97		struct v4l2_ctrl_h264_encode_feedback encode_feedback = { 0 };
    98		struct v4l2_ctrl *ctrl;
    99		unsigned int i;
   100		u32 cp_overflow = 0;
   101		u32 cp_prev = 0;
 > 102		u32 encoded_slices;
   103		u32 bytesused;
   104	
   105		ctrl = v4l2_ctrl_find(&ctx->ctrl_handler,
   106				      V4L2_CID_STATELESS_H264_ENCODE_FEEDBACK);
   107		if (!ctrl)
   108			return;
   109	
   110		dst_buf = hantro_get_dst_buf(ctx);
   111		if (!dst_buf)
   112			return;
   113	
   114		bytesused = vepu_read(vpu, VEPU_REG_STR_BUF_LIMIT) / 8;
   115		dst_buf->vb2_buf.planes[0].bytesused = bytesused;
   116	
   117		encode_feedback.qp_sum =
   118			VEPU_REG_QP_SUM(vepu_read(vpu, VEPU_REG_QP_SUM_DIV2));
   119	
   120		encode_feedback.mad_count =
   121			VEPU_REG_MB_CNT_SET(vepu_read(vpu, VEPU_REG_MB_CTRL));
   122	
   123		encode_feedback.rlc_count =
   124			VEPU_REG_RLC_SUM_OUT(vepu_read(vpu, VEPU_REG_RLC_SUM));
   125	
   126		for (i = 0; i < ARRAY_SIZE(encode_feedback.cp); i++) {
   127			/* Each register holds two checkpoint values. */
   128			u32 cp_index = i / 2;
   129			u32 cp_reg = VEPU_REG_CHECKPOINT(cp_index);
   130			u32 cp_read = vepu_read(vpu, cp_reg);
   131			u32 cp_value = VEPU_REG_CHECKPOINT_RESULT(cp_read, i);
   132	
   133			/* Hardware might overflow, correct it here. */
   134			if (cp_value < cp_prev)
   135				cp_overflow += (1 << 21);
   136	
   137			encode_feedback.cp[i] = cp_value + cp_overflow;
   138			cp_prev = cp_value;
   139		}
   140	
   141		v4l2_ctrl_s_ctrl_compound(ctrl, V4L2_CTRL_TYPE_H264_ENCODE_FEEDBACK,
   142					  &encode_feedback);
   143	
   144		encoded_slices = (vepu_read(vpu, VEPU_REG_ENC_CTRL1) >> 16) & 0xff;
   145	}
   146	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
