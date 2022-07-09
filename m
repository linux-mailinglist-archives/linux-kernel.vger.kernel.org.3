Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C3156C67A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 05:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiGIDkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 23:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiGIDkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 23:40:25 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D86A82FB4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 20:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657338023; x=1688874023;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YdLfOHEdJiJw3cVN/etqKWUnHalJodNayeVPziKaIvg=;
  b=QiUCTn3tCHczU4bu7QU0kIC2Aq5NNiD48K+FpNO9/1NgXZ4nVX6HHAun
   TwbbGoJSotxVXHOyAtrJZpbr9HsbFicoDZNcksUUcwnQT1kL4U8ZrNyJD
   7Gr1Z6z8T87ComlDNw2JSgWOcQ4HdB4q8nT/h2KbmiNedmkiZplWlkwxN
   uNE0Js7ssYWXh4Ja28SqtqKynnxQaKt9goJDkk4wsjwIYu2C4jLUZpBa8
   px7bf6lbBxoOBcxs6TvE5s1GGAfYHKg17jGMfIRpuq3RN4PHWQX3y+uCb
   UBKkenzAqS1QlHZeBwlcMLZC2ecTxfROZL0G4er3rCjgPFTLuPE1JIWQK
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="285531293"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="285531293"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 20:40:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="921204205"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 08 Jul 2022 20:40:21 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oA1KO-000OGO-Qz;
        Sat, 09 Jul 2022 03:40:20 +0000
Date:   Sat, 9 Jul 2022 11:40:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: [drm-msm:msm-next 9/29]
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c:904:28: warning: variable 'top' set
 but not used
Message-ID: <202207091145.lpVXwHu5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/drm/msm.git msm-next
head:   cb77085b1f0a86ef9dfba86b5f3ed6c3340c2ea3
commit: 9403f9a42c881d59396a454347540108d787685f [9/29] drm/msm/dpu: merge base_off with blk_off in struct dpu_hw_blk_reg_map
config: arm-defconfig (https://download.01.org/0day-ci/archive/20220709/202207091145.lpVXwHu5-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add drm-msm https://gitlab.freedesktop.org/drm/msm.git
        git fetch --no-tags drm-msm msm-next
        git checkout 9403f9a42c881d59396a454347540108d787685f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/gpu/drm/msm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c: In function 'dpu_kms_mdp_snapshot':
>> drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c:904:28: warning: variable 'top' set but not used [-Wunused-but-set-variable]
     904 |         struct dpu_hw_mdp *top;
         |                            ^~~


vim +/top +904 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c

220b856a3d3742 Tanmay Shah      2020-08-27  898  
eb9d6c7ebe44df Dmitry Baryshkov 2021-04-27  899  static void dpu_kms_mdp_snapshot(struct msm_disp_state *disp_state, struct msm_kms *kms)
a698b5cdfe6366 Abhinav Kumar    2021-04-16  900  {
a698b5cdfe6366 Abhinav Kumar    2021-04-16  901  	int i;
a698b5cdfe6366 Abhinav Kumar    2021-04-16  902  	struct dpu_kms *dpu_kms;
3208496720a180 Dmitry Baryshkov 2022-06-02  903  	const struct dpu_mdss_cfg *cat;
a698b5cdfe6366 Abhinav Kumar    2021-04-16 @904  	struct dpu_hw_mdp *top;
a698b5cdfe6366 Abhinav Kumar    2021-04-16  905  
a698b5cdfe6366 Abhinav Kumar    2021-04-16  906  	dpu_kms = to_dpu_kms(kms);
a698b5cdfe6366 Abhinav Kumar    2021-04-16  907  
a698b5cdfe6366 Abhinav Kumar    2021-04-16  908  	cat = dpu_kms->catalog;
a698b5cdfe6366 Abhinav Kumar    2021-04-16  909  	top = dpu_kms->hw_mdp;
a698b5cdfe6366 Abhinav Kumar    2021-04-16  910  
a698b5cdfe6366 Abhinav Kumar    2021-04-16  911  	pm_runtime_get_sync(&dpu_kms->pdev->dev);
a698b5cdfe6366 Abhinav Kumar    2021-04-16  912  
a698b5cdfe6366 Abhinav Kumar    2021-04-16  913  	/* dump CTL sub-blocks HW regs info */
a698b5cdfe6366 Abhinav Kumar    2021-04-16  914  	for (i = 0; i < cat->ctl_count; i++)
a698b5cdfe6366 Abhinav Kumar    2021-04-16  915  		msm_disp_snapshot_add_block(disp_state, cat->ctl[i].len,
a698b5cdfe6366 Abhinav Kumar    2021-04-16  916  				dpu_kms->mmio + cat->ctl[i].base, "ctl_%d", i);
a698b5cdfe6366 Abhinav Kumar    2021-04-16  917  
a698b5cdfe6366 Abhinav Kumar    2021-04-16  918  	/* dump DSPP sub-blocks HW regs info */
a698b5cdfe6366 Abhinav Kumar    2021-04-16  919  	for (i = 0; i < cat->dspp_count; i++)
a698b5cdfe6366 Abhinav Kumar    2021-04-16  920  		msm_disp_snapshot_add_block(disp_state, cat->dspp[i].len,
a698b5cdfe6366 Abhinav Kumar    2021-04-16  921  				dpu_kms->mmio + cat->dspp[i].base, "dspp_%d", i);
a698b5cdfe6366 Abhinav Kumar    2021-04-16  922  
a698b5cdfe6366 Abhinav Kumar    2021-04-16  923  	/* dump INTF sub-blocks HW regs info */
a698b5cdfe6366 Abhinav Kumar    2021-04-16  924  	for (i = 0; i < cat->intf_count; i++)
a698b5cdfe6366 Abhinav Kumar    2021-04-16  925  		msm_disp_snapshot_add_block(disp_state, cat->intf[i].len,
a698b5cdfe6366 Abhinav Kumar    2021-04-16  926  				dpu_kms->mmio + cat->intf[i].base, "intf_%d", i);
a698b5cdfe6366 Abhinav Kumar    2021-04-16  927  
a698b5cdfe6366 Abhinav Kumar    2021-04-16  928  	/* dump PP sub-blocks HW regs info */
a698b5cdfe6366 Abhinav Kumar    2021-04-16  929  	for (i = 0; i < cat->pingpong_count; i++)
a698b5cdfe6366 Abhinav Kumar    2021-04-16  930  		msm_disp_snapshot_add_block(disp_state, cat->pingpong[i].len,
a698b5cdfe6366 Abhinav Kumar    2021-04-16  931  				dpu_kms->mmio + cat->pingpong[i].base, "pingpong_%d", i);
a698b5cdfe6366 Abhinav Kumar    2021-04-16  932  
a698b5cdfe6366 Abhinav Kumar    2021-04-16  933  	/* dump SSPP sub-blocks HW regs info */
a698b5cdfe6366 Abhinav Kumar    2021-04-16  934  	for (i = 0; i < cat->sspp_count; i++)
a698b5cdfe6366 Abhinav Kumar    2021-04-16  935  		msm_disp_snapshot_add_block(disp_state, cat->sspp[i].len,
a698b5cdfe6366 Abhinav Kumar    2021-04-16  936  				dpu_kms->mmio + cat->sspp[i].base, "sspp_%d", i);
a698b5cdfe6366 Abhinav Kumar    2021-04-16  937  
3a905438887bf0 Abhinav Kumar    2021-12-15  938  	/* dump LM sub-blocks HW regs info */
3a905438887bf0 Abhinav Kumar    2021-12-15  939  	for (i = 0; i < cat->mixer_count; i++)
3a905438887bf0 Abhinav Kumar    2021-12-15  940  		msm_disp_snapshot_add_block(disp_state, cat->mixer[i].len,
3a905438887bf0 Abhinav Kumar    2021-12-15  941  				dpu_kms->mmio + cat->mixer[i].base, "lm_%d", i);
3a905438887bf0 Abhinav Kumar    2021-12-15  942  
4448d59104151c Abhinav Kumar    2022-04-26  943  	/* dump WB sub-blocks HW regs info */
4448d59104151c Abhinav Kumar    2022-04-26  944  	for (i = 0; i < cat->wb_count; i++)
4448d59104151c Abhinav Kumar    2022-04-26  945  		msm_disp_snapshot_add_block(disp_state, cat->wb[i].len,
4448d59104151c Abhinav Kumar    2022-04-26  946  				dpu_kms->mmio + cat->wb[i].base, "wb_%d", i);
4448d59104151c Abhinav Kumar    2022-04-26  947  
1e5df24b996c1c Dmitry Baryshkov 2022-06-01  948  	msm_disp_snapshot_add_block(disp_state, cat->mdp[0].len,
9403f9a42c881d Dmitry Baryshkov 2022-06-01  949  			dpu_kms->mmio + cat->mdp[0].base, "top");
a698b5cdfe6366 Abhinav Kumar    2021-04-16  950  
a698b5cdfe6366 Abhinav Kumar    2021-04-16  951  	pm_runtime_put_sync(&dpu_kms->pdev->dev);
a698b5cdfe6366 Abhinav Kumar    2021-04-16  952  }
a698b5cdfe6366 Abhinav Kumar    2021-04-16  953  

:::::: The code at line 904 was first introduced by commit
:::::: a698b5cdfe63663dc6d5cb4c19109cd9757f8daf drm/msm/disp/dpu1: add API to take DPU register snapshot

:::::: TO: Abhinav Kumar <abhinavk@codeaurora.org>
:::::: CC: Rob Clark <robdclark@chromium.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
