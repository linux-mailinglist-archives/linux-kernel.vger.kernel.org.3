Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE13259AD36
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 12:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243060AbiHTK2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 06:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiHTK2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 06:28:34 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4605933E13
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 03:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660991312; x=1692527312;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=N71MpjXg706YSx4PmMZk9ArRZjKn11uQEGm3a/oQ4V4=;
  b=fy1wKq7FV+IXzQhDhKHTolqq0xeyUQFQYIg+EkHxfDaHhJjJOu9rn8s2
   nabxUcH4v5CKfBsnbo/LeF0KCKrKIB7sfl2dw+YMht/2eAG3G4Ln+cbsO
   e6Kbi1nV7ziKVN0rYSPycdwxfLsZswMMxfy+03HAJjBRXBnU0L6CJ2F6x
   Vf7RECdSjqJQwo1mSDTrE/iBejQZFrsrJwlvLyGNzkgB++ihPMnI1VFJC
   UerA15bMyuYIbExZ+Duiv7LXl5t5Hal5Azm6mKDMR222+Esp4KUTVrzgy
   Odk7NU4Tdjya1Q+bCP7KpcevtoztiRzKla+Q4ngYi+/svcrPh/QDA2g46
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10444"; a="354895492"
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="354895492"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2022 03:28:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="854008951"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 20 Aug 2022 03:28:27 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPLiN-0002UR-02;
        Sat, 20 Aug 2022 10:28:27 +0000
Date:   Sat, 20 Aug 2022 18:28:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>
Subject: drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c:185
 dpu_core_perf_crtc_check() warn: inconsistent indenting
Message-ID: <202208201810.AVMZPmng-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   50cd95ac46548429e5bba7ca75cc97d11a697947
commit: b3ed524f84f573ece1aa2f26e9db3c34a593e0d1 drm/msm: allow compile_test on !ARM
date:   11 months ago
config: microblaze-randconfig-m041-20220820 (https://download.01.org/0day-ci/archive/20220820/202208201810.AVMZPmng-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

New smatch warnings:
drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c:185 dpu_core_perf_crtc_check() warn: inconsistent indenting
drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c:1676 dpu_plane_init() warn: variable dereferenced before check 'pdpu->pipe_hw' (see line 1607)
drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c:1006 dpu_kms_hw_init() warn: passing zero to 'PTR_ERR'
drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c:112 dpu_rm_init() warn: passing zero to 'PTR_ERR'
drivers/gpu/drm/msm/msm_gem.c:1184 msm_gem_new() warn: passing a valid pointer to 'PTR_ERR'

Old smatch warnings:
drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c:1679 dpu_plane_init() warn: '&pdpu->mplane_list' not removed from list
drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c:1065 dpu_kms_hw_init() warn: passing zero to 'PTR_ERR'
drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c:141 dpu_rm_init() warn: passing zero to 'PTR_ERR'
drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c:159 dpu_rm_init() warn: passing zero to 'PTR_ERR'
drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c:183 dpu_rm_init() warn: passing zero to 'PTR_ERR'
drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c:200 dpu_rm_init() warn: passing zero to 'PTR_ERR'
drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c:217 dpu_rm_init() warn: passing zero to 'PTR_ERR'
drivers/gpu/drm/msm/msm_gem.c:392 get_iova_locked() warn: passing a valid pointer to 'PTR_ERR'

vim +185 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c

25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  140  
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  141  int dpu_core_perf_crtc_check(struct drm_crtc *crtc,
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  142  		struct drm_crtc_state *state)
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  143  {
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  144  	u32 bw, threshold;
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  145  	u64 bw_sum_of_intfs = 0;
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  146  	enum dpu_crtc_client_type curr_client_type;
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  147  	struct dpu_crtc_state *dpu_cstate;
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  148  	struct drm_crtc *tmp_crtc;
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  149  	struct dpu_kms *kms;
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  150  
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  151  	if (!crtc || !state) {
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  152  		DPU_ERROR("invalid crtc\n");
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  153  		return -EINVAL;
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  154  	}
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  155  
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  156  	kms = _dpu_crtc_get_kms(crtc);
96630140040210 Drew Davenport     2019-09-06  157  	if (!kms->catalog) {
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  158  		DPU_ERROR("invalid parameters\n");
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  159  		return 0;
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  160  	}
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  161  
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  162  	/* we only need bandwidth check on real-time clients (interfaces) */
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  163  	if (dpu_crtc_get_client_type(crtc) == NRT_CLIENT)
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  164  		return 0;
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  165  
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  166  	dpu_cstate = to_dpu_crtc_state(state);
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  167  
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  168  	/* obtain new values */
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  169  	_dpu_core_perf_calc_crtc(kms, crtc, state, &dpu_cstate->new_perf);
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  170  
cb88482e2570f6 Jayant Shekhar     2019-06-18  171  	bw_sum_of_intfs = dpu_cstate->new_perf.bw_ctl;
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  172  	curr_client_type = dpu_crtc_get_client_type(crtc);
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  173  
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  174  	drm_for_each_crtc(tmp_crtc, crtc->dev) {
49dfe764797b1e Jordan Crouse      2018-12-03  175  		if (tmp_crtc->enabled &&
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  176  		    (dpu_crtc_get_client_type(tmp_crtc) ==
cb88482e2570f6 Jayant Shekhar     2019-06-18  177  				curr_client_type) && (tmp_crtc != crtc)) {
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  178  			struct dpu_crtc_state *tmp_cstate =
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  179  				to_dpu_crtc_state(tmp_crtc->state);
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  180  
5b702d787b47e1 Stephen Boyd       2021-04-30  181  			DRM_DEBUG_ATOMIC("crtc:%d bw:%llu ctrl:%d\n",
cb88482e2570f6 Jayant Shekhar     2019-06-18  182  				tmp_crtc->base.id, tmp_cstate->new_perf.bw_ctl,
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  183  				tmp_cstate->bw_control);
c33b7c0389e17d Kalyan Thota       2020-07-16  184  
cb88482e2570f6 Jayant Shekhar     2019-06-18 @185  				bw_sum_of_intfs += tmp_cstate->new_perf.bw_ctl;
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  186  		}
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  187  
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  188  		/* convert bandwidth to kb */
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  189  		bw = DIV_ROUND_UP_ULL(bw_sum_of_intfs, 1000);
5b702d787b47e1 Stephen Boyd       2021-04-30  190  		DRM_DEBUG_ATOMIC("calculated bandwidth=%uk\n", bw);
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  191  
71dc6c08e4c53d Krishna Manikandan 2020-05-04  192  		threshold = kms->catalog->perf.max_bw_high;
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  193  
5b702d787b47e1 Stephen Boyd       2021-04-30  194  		DRM_DEBUG_ATOMIC("final threshold bw limit = %d\n", threshold);
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  195  
c33b7c0389e17d Kalyan Thota       2020-07-16  196  		if (!threshold) {
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  197  			DPU_ERROR("no bandwidth limits specified\n");
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  198  			return -E2BIG;
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  199  		} else if (bw > threshold) {
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  200  			DPU_ERROR("exceeds bandwidth: %ukb > %ukb\n", bw,
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  201  					threshold);
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  202  			return -E2BIG;
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  203  		}
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  204  	}
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  205  
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  206  	return 0;
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  207  }
25fdd5933e4c0f Jeykumar Sankaran  2018-06-27  208  

:::::: The code at line 185 was first introduced by commit
:::::: cb88482e2570f67a6f4e72569e5a18329d5536ab drm/msm/dpu: clean up references of DPU custom bus scaling

:::::: TO: Jayant Shekhar <jshekhar@codeaurora.org>
:::::: CC: Rob Clark <robdclark@chromium.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
