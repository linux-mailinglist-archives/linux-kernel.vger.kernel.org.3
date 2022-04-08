Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501934F9D7C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 21:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239132AbiDHTKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 15:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiDHTKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 15:10:11 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79918C90C2
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 12:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649444886; x=1680980886;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FxJKwOUl1MlqPc/WkywJNLE0a2oQDkypTFPhDqZX7mg=;
  b=BIo81or8VRY5/rBf1fDKitx8mpDTVmEWOs53FOqMYkIIqNJRnFLxlyJ8
   xEfNmGAWEYpWjs/fXkJ9ELThNHovJlhkugClkvMIL/y2OfLglIZT6XyO9
   rkIg3s33YxQy90WcdptOyZQ6xccgq/QKe4y+pMhKTpEzf30Etx/OuYVqw
   7n2oBd+1si+NydN4u/Ssik7PfvBmcauu5ZmnOi8c/tAyeFqWO4bruFaQE
   IbNO9a+VsGuZiWTGvA4aeoD/ronhdIVRa477Ev2PjL5KQ0AVTfFZv9hko
   4grezBX7e5RfQOvNeaaCaaquOxcqVJyNl4f9L1R4x7UBL0gqp+BA2TWnf
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="243801104"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="243801104"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 12:08:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="609863990"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 08 Apr 2022 12:08:04 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nctxj-0000Yi-CJ;
        Fri, 08 Apr 2022 19:08:03 +0000
Date:   Sat, 9 Apr 2022 03:07:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zhi Wang <zhi.a.wang@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        zhenyu.z.wang@intel.com, terrence.xu@intel.com,
        intel-gvt-dev@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [intel-gvt:gvt-staging 2/3]
 drivers/gpu/drm/i915/intel_gvt_mmio_table.c:1021:9: error: use of undeclared
 identifier 'DMC_SSP_BASE'
Message-ID: <202204090309.4k0CRWvn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/gvt-linux.git gvt-staging
head:   d7b5d2c7c69602d92c926075fb8191a7d6df2c08
commit: 94b8f98a1026f9b304417f8152b99993f24baf13 [2/3] Merge remote-tracking branch 'origin/gvt-next' into gvt-staging
config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive/20220409/202204090309.4k0CRWvn-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c29a51b3a257908aebc01cd7c4655665db317d66)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel/gvt-linux/commit/94b8f98a1026f9b304417f8152b99993f24baf13
        git remote add intel-gvt https://github.com/intel/gvt-linux.git
        git fetch --no-tags intel-gvt gvt-staging
        git checkout 94b8f98a1026f9b304417f8152b99993f24baf13
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpu/drm/i915/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/i915/intel_gvt_mmio_table.c:1021:9: error: use of undeclared identifier 'DMC_SSP_BASE'
           MMIO_D(DMC_SSP_BASE);
                  ^
>> drivers/gpu/drm/i915/intel_gvt_mmio_table.c:1022:9: error: use of undeclared identifier 'DMC_HTP_SKL'
           MMIO_D(DMC_HTP_SKL);
                  ^
>> drivers/gpu/drm/i915/intel_gvt_mmio_table.c:1023:9: error: use of undeclared identifier 'DMC_LAST_WRITE'
           MMIO_D(DMC_LAST_WRITE);
                  ^
>> drivers/gpu/drm/i915/intel_gvt_mmio_table.c:1080:15: error: use of undeclared identifier 'DMC_MMIO_START_RANGE'
           MMIO_F(_MMIO(DMC_MMIO_START_RANGE), 0x3000);
                        ^
   4 errors generated.


vim +/DMC_SSP_BASE +1021 drivers/gpu/drm/i915/intel_gvt_mmio_table.c

e870ce1791520c Zhi Wang 2022-04-07   885  
e870ce1791520c Zhi Wang 2022-04-07   886  static int iterate_skl_plus_mmio(struct intel_gvt_mmio_table_iter *iter)
e870ce1791520c Zhi Wang 2022-04-07   887  {
e870ce1791520c Zhi Wang 2022-04-07   888  	struct drm_i915_private *dev_priv = iter->i915;
e870ce1791520c Zhi Wang 2022-04-07   889  
e870ce1791520c Zhi Wang 2022-04-07   890  	MMIO_D(FORCEWAKE_RENDER_GEN9);
e870ce1791520c Zhi Wang 2022-04-07   891  	MMIO_D(FORCEWAKE_ACK_RENDER_GEN9);
e870ce1791520c Zhi Wang 2022-04-07   892  	MMIO_D(FORCEWAKE_GT_GEN9);
e870ce1791520c Zhi Wang 2022-04-07   893  	MMIO_D(FORCEWAKE_ACK_GT_GEN9);
e870ce1791520c Zhi Wang 2022-04-07   894  	MMIO_D(FORCEWAKE_MEDIA_GEN9);
e870ce1791520c Zhi Wang 2022-04-07   895  	MMIO_D(FORCEWAKE_ACK_MEDIA_GEN9);
e870ce1791520c Zhi Wang 2022-04-07   896  	MMIO_F(DP_AUX_CH_CTL(AUX_CH_B), 6 * 4);
e870ce1791520c Zhi Wang 2022-04-07   897  	MMIO_F(DP_AUX_CH_CTL(AUX_CH_C), 6 * 4);
e870ce1791520c Zhi Wang 2022-04-07   898  	MMIO_F(DP_AUX_CH_CTL(AUX_CH_D), 6 * 4);
e870ce1791520c Zhi Wang 2022-04-07   899  	MMIO_D(HSW_PWR_WELL_CTL1);
e870ce1791520c Zhi Wang 2022-04-07   900  	MMIO_D(HSW_PWR_WELL_CTL2);
e870ce1791520c Zhi Wang 2022-04-07   901  	MMIO_D(DBUF_CTL_S(0));
e870ce1791520c Zhi Wang 2022-04-07   902  	MMIO_D(GEN9_PG_ENABLE);
e870ce1791520c Zhi Wang 2022-04-07   903  	MMIO_D(GEN9_MEDIA_PG_IDLE_HYSTERESIS);
e870ce1791520c Zhi Wang 2022-04-07   904  	MMIO_D(GEN9_RENDER_PG_IDLE_HYSTERESIS);
e870ce1791520c Zhi Wang 2022-04-07   905  	MMIO_D(GEN9_GAMT_ECO_REG_RW_IA);
e870ce1791520c Zhi Wang 2022-04-07   906  	MMIO_D(MMCD_MISC_CTRL);
e870ce1791520c Zhi Wang 2022-04-07   907  	MMIO_D(CHICKEN_PAR1_1);
e870ce1791520c Zhi Wang 2022-04-07   908  	MMIO_D(DC_STATE_EN);
e870ce1791520c Zhi Wang 2022-04-07   909  	MMIO_D(DC_STATE_DEBUG);
e870ce1791520c Zhi Wang 2022-04-07   910  	MMIO_D(CDCLK_CTL);
e870ce1791520c Zhi Wang 2022-04-07   911  	MMIO_D(LCPLL1_CTL);
e870ce1791520c Zhi Wang 2022-04-07   912  	MMIO_D(LCPLL2_CTL);
e870ce1791520c Zhi Wang 2022-04-07   913  	MMIO_D(_MMIO(_DPLL1_CFGCR1));
e870ce1791520c Zhi Wang 2022-04-07   914  	MMIO_D(_MMIO(_DPLL2_CFGCR1));
e870ce1791520c Zhi Wang 2022-04-07   915  	MMIO_D(_MMIO(_DPLL3_CFGCR1));
e870ce1791520c Zhi Wang 2022-04-07   916  	MMIO_D(_MMIO(_DPLL1_CFGCR2));
e870ce1791520c Zhi Wang 2022-04-07   917  	MMIO_D(_MMIO(_DPLL2_CFGCR2));
e870ce1791520c Zhi Wang 2022-04-07   918  	MMIO_D(_MMIO(_DPLL3_CFGCR2));
e870ce1791520c Zhi Wang 2022-04-07   919  	MMIO_D(DPLL_CTRL1);
e870ce1791520c Zhi Wang 2022-04-07   920  	MMIO_D(DPLL_CTRL2);
e870ce1791520c Zhi Wang 2022-04-07   921  	MMIO_D(DPLL_STATUS);
e870ce1791520c Zhi Wang 2022-04-07   922  	MMIO_D(SKL_PS_WIN_POS(PIPE_A, 0));
e870ce1791520c Zhi Wang 2022-04-07   923  	MMIO_D(SKL_PS_WIN_POS(PIPE_A, 1));
e870ce1791520c Zhi Wang 2022-04-07   924  	MMIO_D(SKL_PS_WIN_POS(PIPE_B, 0));
e870ce1791520c Zhi Wang 2022-04-07   925  	MMIO_D(SKL_PS_WIN_POS(PIPE_B, 1));
e870ce1791520c Zhi Wang 2022-04-07   926  	MMIO_D(SKL_PS_WIN_POS(PIPE_C, 0));
e870ce1791520c Zhi Wang 2022-04-07   927  	MMIO_D(SKL_PS_WIN_POS(PIPE_C, 1));
e870ce1791520c Zhi Wang 2022-04-07   928  	MMIO_D(SKL_PS_WIN_SZ(PIPE_A, 0));
e870ce1791520c Zhi Wang 2022-04-07   929  	MMIO_D(SKL_PS_WIN_SZ(PIPE_A, 1));
e870ce1791520c Zhi Wang 2022-04-07   930  	MMIO_D(SKL_PS_WIN_SZ(PIPE_B, 0));
e870ce1791520c Zhi Wang 2022-04-07   931  	MMIO_D(SKL_PS_WIN_SZ(PIPE_B, 1));
e870ce1791520c Zhi Wang 2022-04-07   932  	MMIO_D(SKL_PS_WIN_SZ(PIPE_C, 0));
e870ce1791520c Zhi Wang 2022-04-07   933  	MMIO_D(SKL_PS_WIN_SZ(PIPE_C, 1));
e870ce1791520c Zhi Wang 2022-04-07   934  	MMIO_D(SKL_PS_CTRL(PIPE_A, 0));
e870ce1791520c Zhi Wang 2022-04-07   935  	MMIO_D(SKL_PS_CTRL(PIPE_A, 1));
e870ce1791520c Zhi Wang 2022-04-07   936  	MMIO_D(SKL_PS_CTRL(PIPE_B, 0));
e870ce1791520c Zhi Wang 2022-04-07   937  	MMIO_D(SKL_PS_CTRL(PIPE_B, 1));
e870ce1791520c Zhi Wang 2022-04-07   938  	MMIO_D(SKL_PS_CTRL(PIPE_C, 0));
e870ce1791520c Zhi Wang 2022-04-07   939  	MMIO_D(SKL_PS_CTRL(PIPE_C, 1));
e870ce1791520c Zhi Wang 2022-04-07   940  	MMIO_D(PLANE_BUF_CFG(PIPE_A, 0));
e870ce1791520c Zhi Wang 2022-04-07   941  	MMIO_D(PLANE_BUF_CFG(PIPE_A, 1));
e870ce1791520c Zhi Wang 2022-04-07   942  	MMIO_D(PLANE_BUF_CFG(PIPE_A, 2));
e870ce1791520c Zhi Wang 2022-04-07   943  	MMIO_D(PLANE_BUF_CFG(PIPE_A, 3));
e870ce1791520c Zhi Wang 2022-04-07   944  	MMIO_D(PLANE_BUF_CFG(PIPE_B, 0));
e870ce1791520c Zhi Wang 2022-04-07   945  	MMIO_D(PLANE_BUF_CFG(PIPE_B, 1));
e870ce1791520c Zhi Wang 2022-04-07   946  	MMIO_D(PLANE_BUF_CFG(PIPE_B, 2));
e870ce1791520c Zhi Wang 2022-04-07   947  	MMIO_D(PLANE_BUF_CFG(PIPE_B, 3));
e870ce1791520c Zhi Wang 2022-04-07   948  	MMIO_D(PLANE_BUF_CFG(PIPE_C, 0));
e870ce1791520c Zhi Wang 2022-04-07   949  	MMIO_D(PLANE_BUF_CFG(PIPE_C, 1));
e870ce1791520c Zhi Wang 2022-04-07   950  	MMIO_D(PLANE_BUF_CFG(PIPE_C, 2));
e870ce1791520c Zhi Wang 2022-04-07   951  	MMIO_D(PLANE_BUF_CFG(PIPE_C, 3));
e870ce1791520c Zhi Wang 2022-04-07   952  	MMIO_D(CUR_BUF_CFG(PIPE_A));
e870ce1791520c Zhi Wang 2022-04-07   953  	MMIO_D(CUR_BUF_CFG(PIPE_B));
e870ce1791520c Zhi Wang 2022-04-07   954  	MMIO_D(CUR_BUF_CFG(PIPE_C));
e870ce1791520c Zhi Wang 2022-04-07   955  	MMIO_F(PLANE_WM(PIPE_A, 0, 0), 4 * 8);
e870ce1791520c Zhi Wang 2022-04-07   956  	MMIO_F(PLANE_WM(PIPE_A, 1, 0), 4 * 8);
e870ce1791520c Zhi Wang 2022-04-07   957  	MMIO_F(PLANE_WM(PIPE_A, 2, 0), 4 * 8);
e870ce1791520c Zhi Wang 2022-04-07   958  	MMIO_F(PLANE_WM(PIPE_B, 0, 0), 4 * 8);
e870ce1791520c Zhi Wang 2022-04-07   959  	MMIO_F(PLANE_WM(PIPE_B, 1, 0), 4 * 8);
e870ce1791520c Zhi Wang 2022-04-07   960  	MMIO_F(PLANE_WM(PIPE_B, 2, 0), 4 * 8);
e870ce1791520c Zhi Wang 2022-04-07   961  	MMIO_F(PLANE_WM(PIPE_C, 0, 0), 4 * 8);
e870ce1791520c Zhi Wang 2022-04-07   962  	MMIO_F(PLANE_WM(PIPE_C, 1, 0), 4 * 8);
e870ce1791520c Zhi Wang 2022-04-07   963  	MMIO_F(PLANE_WM(PIPE_C, 2, 0), 4 * 8);
e870ce1791520c Zhi Wang 2022-04-07   964  	MMIO_F(CUR_WM(PIPE_A, 0), 4 * 8);
e870ce1791520c Zhi Wang 2022-04-07   965  	MMIO_F(CUR_WM(PIPE_B, 0), 4 * 8);
e870ce1791520c Zhi Wang 2022-04-07   966  	MMIO_F(CUR_WM(PIPE_C, 0), 4 * 8);
e870ce1791520c Zhi Wang 2022-04-07   967  	MMIO_D(PLANE_WM_TRANS(PIPE_A, 0));
e870ce1791520c Zhi Wang 2022-04-07   968  	MMIO_D(PLANE_WM_TRANS(PIPE_A, 1));
e870ce1791520c Zhi Wang 2022-04-07   969  	MMIO_D(PLANE_WM_TRANS(PIPE_A, 2));
e870ce1791520c Zhi Wang 2022-04-07   970  	MMIO_D(PLANE_WM_TRANS(PIPE_B, 0));
e870ce1791520c Zhi Wang 2022-04-07   971  	MMIO_D(PLANE_WM_TRANS(PIPE_B, 1));
e870ce1791520c Zhi Wang 2022-04-07   972  	MMIO_D(PLANE_WM_TRANS(PIPE_B, 2));
e870ce1791520c Zhi Wang 2022-04-07   973  	MMIO_D(PLANE_WM_TRANS(PIPE_C, 0));
e870ce1791520c Zhi Wang 2022-04-07   974  	MMIO_D(PLANE_WM_TRANS(PIPE_C, 1));
e870ce1791520c Zhi Wang 2022-04-07   975  	MMIO_D(PLANE_WM_TRANS(PIPE_C, 2));
e870ce1791520c Zhi Wang 2022-04-07   976  	MMIO_D(CUR_WM_TRANS(PIPE_A));
e870ce1791520c Zhi Wang 2022-04-07   977  	MMIO_D(CUR_WM_TRANS(PIPE_B));
e870ce1791520c Zhi Wang 2022-04-07   978  	MMIO_D(CUR_WM_TRANS(PIPE_C));
e870ce1791520c Zhi Wang 2022-04-07   979  	MMIO_D(PLANE_NV12_BUF_CFG(PIPE_A, 0));
e870ce1791520c Zhi Wang 2022-04-07   980  	MMIO_D(PLANE_NV12_BUF_CFG(PIPE_A, 1));
e870ce1791520c Zhi Wang 2022-04-07   981  	MMIO_D(PLANE_NV12_BUF_CFG(PIPE_A, 2));
e870ce1791520c Zhi Wang 2022-04-07   982  	MMIO_D(PLANE_NV12_BUF_CFG(PIPE_A, 3));
e870ce1791520c Zhi Wang 2022-04-07   983  	MMIO_D(PLANE_NV12_BUF_CFG(PIPE_B, 0));
e870ce1791520c Zhi Wang 2022-04-07   984  	MMIO_D(PLANE_NV12_BUF_CFG(PIPE_B, 1));
e870ce1791520c Zhi Wang 2022-04-07   985  	MMIO_D(PLANE_NV12_BUF_CFG(PIPE_B, 2));
e870ce1791520c Zhi Wang 2022-04-07   986  	MMIO_D(PLANE_NV12_BUF_CFG(PIPE_B, 3));
e870ce1791520c Zhi Wang 2022-04-07   987  	MMIO_D(PLANE_NV12_BUF_CFG(PIPE_C, 0));
e870ce1791520c Zhi Wang 2022-04-07   988  	MMIO_D(PLANE_NV12_BUF_CFG(PIPE_C, 1));
e870ce1791520c Zhi Wang 2022-04-07   989  	MMIO_D(PLANE_NV12_BUF_CFG(PIPE_C, 2));
e870ce1791520c Zhi Wang 2022-04-07   990  	MMIO_D(PLANE_NV12_BUF_CFG(PIPE_C, 3));
e870ce1791520c Zhi Wang 2022-04-07   991  	MMIO_D(_MMIO(_REG_701C0(PIPE_A, 1)));
e870ce1791520c Zhi Wang 2022-04-07   992  	MMIO_D(_MMIO(_REG_701C0(PIPE_A, 2)));
e870ce1791520c Zhi Wang 2022-04-07   993  	MMIO_D(_MMIO(_REG_701C0(PIPE_A, 3)));
e870ce1791520c Zhi Wang 2022-04-07   994  	MMIO_D(_MMIO(_REG_701C0(PIPE_A, 4)));
e870ce1791520c Zhi Wang 2022-04-07   995  	MMIO_D(_MMIO(_REG_701C0(PIPE_B, 1)));
e870ce1791520c Zhi Wang 2022-04-07   996  	MMIO_D(_MMIO(_REG_701C0(PIPE_B, 2)));
e870ce1791520c Zhi Wang 2022-04-07   997  	MMIO_D(_MMIO(_REG_701C0(PIPE_B, 3)));
e870ce1791520c Zhi Wang 2022-04-07   998  	MMIO_D(_MMIO(_REG_701C0(PIPE_B, 4)));
e870ce1791520c Zhi Wang 2022-04-07   999  	MMIO_D(_MMIO(_REG_701C0(PIPE_C, 1)));
e870ce1791520c Zhi Wang 2022-04-07  1000  	MMIO_D(_MMIO(_REG_701C0(PIPE_C, 2)));
e870ce1791520c Zhi Wang 2022-04-07  1001  	MMIO_D(_MMIO(_REG_701C0(PIPE_C, 3)));
e870ce1791520c Zhi Wang 2022-04-07  1002  	MMIO_D(_MMIO(_REG_701C0(PIPE_C, 4)));
e870ce1791520c Zhi Wang 2022-04-07  1003  	MMIO_D(_MMIO(_REG_701C4(PIPE_A, 1)));
e870ce1791520c Zhi Wang 2022-04-07  1004  	MMIO_D(_MMIO(_REG_701C4(PIPE_A, 2)));
e870ce1791520c Zhi Wang 2022-04-07  1005  	MMIO_D(_MMIO(_REG_701C4(PIPE_A, 3)));
e870ce1791520c Zhi Wang 2022-04-07  1006  	MMIO_D(_MMIO(_REG_701C4(PIPE_A, 4)));
e870ce1791520c Zhi Wang 2022-04-07  1007  	MMIO_D(_MMIO(_REG_701C4(PIPE_B, 1)));
e870ce1791520c Zhi Wang 2022-04-07  1008  	MMIO_D(_MMIO(_REG_701C4(PIPE_B, 2)));
e870ce1791520c Zhi Wang 2022-04-07  1009  	MMIO_D(_MMIO(_REG_701C4(PIPE_B, 3)));
e870ce1791520c Zhi Wang 2022-04-07  1010  	MMIO_D(_MMIO(_REG_701C4(PIPE_B, 4)));
e870ce1791520c Zhi Wang 2022-04-07  1011  	MMIO_D(_MMIO(_REG_701C4(PIPE_C, 1)));
e870ce1791520c Zhi Wang 2022-04-07  1012  	MMIO_D(_MMIO(_REG_701C4(PIPE_C, 2)));
e870ce1791520c Zhi Wang 2022-04-07  1013  	MMIO_D(_MMIO(_REG_701C4(PIPE_C, 3)));
e870ce1791520c Zhi Wang 2022-04-07  1014  	MMIO_D(_MMIO(_REG_701C4(PIPE_C, 4)));
e870ce1791520c Zhi Wang 2022-04-07  1015  	MMIO_D(_MMIO(_PLANE_CTL_3_A));
e870ce1791520c Zhi Wang 2022-04-07  1016  	MMIO_D(_MMIO(_PLANE_CTL_3_B));
e870ce1791520c Zhi Wang 2022-04-07  1017  	MMIO_D(_MMIO(0x72380));
e870ce1791520c Zhi Wang 2022-04-07  1018  	MMIO_D(_MMIO(0x7239c));
e870ce1791520c Zhi Wang 2022-04-07  1019  	MMIO_D(_MMIO(_PLANE_SURF_3_A));
e870ce1791520c Zhi Wang 2022-04-07  1020  	MMIO_D(_MMIO(_PLANE_SURF_3_B));
e870ce1791520c Zhi Wang 2022-04-07 @1021  	MMIO_D(DMC_SSP_BASE);
e870ce1791520c Zhi Wang 2022-04-07 @1022  	MMIO_D(DMC_HTP_SKL);
e870ce1791520c Zhi Wang 2022-04-07 @1023  	MMIO_D(DMC_LAST_WRITE);
e870ce1791520c Zhi Wang 2022-04-07  1024  	MMIO_D(BDW_SCRATCH1);
e870ce1791520c Zhi Wang 2022-04-07  1025  	MMIO_D(SKL_DFSM);
e870ce1791520c Zhi Wang 2022-04-07  1026  	MMIO_D(DISPIO_CR_TX_BMU_CR0);
e870ce1791520c Zhi Wang 2022-04-07  1027  	MMIO_F(GEN9_GFX_MOCS(0), 0x7f8);
e870ce1791520c Zhi Wang 2022-04-07  1028  	MMIO_F(GEN7_L3CNTLREG2, 0x80);
e870ce1791520c Zhi Wang 2022-04-07  1029  	MMIO_D(RPM_CONFIG0);
e870ce1791520c Zhi Wang 2022-04-07  1030  	MMIO_D(_MMIO(0xd08));
e870ce1791520c Zhi Wang 2022-04-07  1031  	MMIO_D(RC6_LOCATION);
e870ce1791520c Zhi Wang 2022-04-07  1032  	MMIO_D(GEN7_FF_SLICE_CS_CHICKEN1);
e870ce1791520c Zhi Wang 2022-04-07  1033  	MMIO_D(GEN9_CS_DEBUG_MODE1);
e870ce1791520c Zhi Wang 2022-04-07  1034  	/* TRTT */
e870ce1791520c Zhi Wang 2022-04-07  1035  	MMIO_D(TRVATTL3PTRDW(0));
e870ce1791520c Zhi Wang 2022-04-07  1036  	MMIO_D(TRVATTL3PTRDW(1));
e870ce1791520c Zhi Wang 2022-04-07  1037  	MMIO_D(TRVATTL3PTRDW(2));
e870ce1791520c Zhi Wang 2022-04-07  1038  	MMIO_D(TRVATTL3PTRDW(3));
e870ce1791520c Zhi Wang 2022-04-07  1039  	MMIO_D(TRVADR);
e870ce1791520c Zhi Wang 2022-04-07  1040  	MMIO_D(TRTTE);
e870ce1791520c Zhi Wang 2022-04-07  1041  	MMIO_D(_MMIO(0x4dfc));
e870ce1791520c Zhi Wang 2022-04-07  1042  	MMIO_D(_MMIO(0x46430));
e870ce1791520c Zhi Wang 2022-04-07  1043  	MMIO_D(_MMIO(0x46520));
e870ce1791520c Zhi Wang 2022-04-07  1044  	MMIO_D(_MMIO(0xc403c));
e870ce1791520c Zhi Wang 2022-04-07  1045  	MMIO_D(GEN8_GARBCNTL);
e870ce1791520c Zhi Wang 2022-04-07  1046  	MMIO_D(DMA_CTRL);
e870ce1791520c Zhi Wang 2022-04-07  1047  	MMIO_D(_MMIO(0x65900));
e870ce1791520c Zhi Wang 2022-04-07  1048  	MMIO_D(GEN6_STOLEN_RESERVED);
e870ce1791520c Zhi Wang 2022-04-07  1049  	MMIO_D(_MMIO(0x4068));
e870ce1791520c Zhi Wang 2022-04-07  1050  	MMIO_D(_MMIO(0x67054));
e870ce1791520c Zhi Wang 2022-04-07  1051  	MMIO_D(_MMIO(0x6e560));
e870ce1791520c Zhi Wang 2022-04-07  1052  	MMIO_D(_MMIO(0x6e554));
e870ce1791520c Zhi Wang 2022-04-07  1053  	MMIO_D(_MMIO(0x2b20));
e870ce1791520c Zhi Wang 2022-04-07  1054  	MMIO_D(_MMIO(0x65f00));
e870ce1791520c Zhi Wang 2022-04-07  1055  	MMIO_D(_MMIO(0x65f08));
e870ce1791520c Zhi Wang 2022-04-07  1056  	MMIO_D(_MMIO(0x320f0));
e870ce1791520c Zhi Wang 2022-04-07  1057  	MMIO_D(_MMIO(0x70034));
e870ce1791520c Zhi Wang 2022-04-07  1058  	MMIO_D(_MMIO(0x71034));
e870ce1791520c Zhi Wang 2022-04-07  1059  	MMIO_D(_MMIO(0x72034));
e870ce1791520c Zhi Wang 2022-04-07  1060  	MMIO_D(_MMIO(_PLANE_KEYVAL_1(PIPE_A)));
e870ce1791520c Zhi Wang 2022-04-07  1061  	MMIO_D(_MMIO(_PLANE_KEYVAL_1(PIPE_B)));
e870ce1791520c Zhi Wang 2022-04-07  1062  	MMIO_D(_MMIO(_PLANE_KEYVAL_1(PIPE_C)));
e870ce1791520c Zhi Wang 2022-04-07  1063  	MMIO_D(_MMIO(_PLANE_KEYMAX_1(PIPE_A)));
e870ce1791520c Zhi Wang 2022-04-07  1064  	MMIO_D(_MMIO(_PLANE_KEYMAX_1(PIPE_B)));
e870ce1791520c Zhi Wang 2022-04-07  1065  	MMIO_D(_MMIO(_PLANE_KEYMAX_1(PIPE_C)));
e870ce1791520c Zhi Wang 2022-04-07  1066  	MMIO_D(_MMIO(_PLANE_KEYMSK_1(PIPE_A)));
e870ce1791520c Zhi Wang 2022-04-07  1067  	MMIO_D(_MMIO(_PLANE_KEYMSK_1(PIPE_B)));
e870ce1791520c Zhi Wang 2022-04-07  1068  	MMIO_D(_MMIO(_PLANE_KEYMSK_1(PIPE_C)));
e870ce1791520c Zhi Wang 2022-04-07  1069  	MMIO_D(_MMIO(0x44500));
e870ce1791520c Zhi Wang 2022-04-07  1070  #define CSFE_CHICKEN1_REG(base) _MMIO((base) + 0xD4)
e870ce1791520c Zhi Wang 2022-04-07  1071  	MMIO_RING_D(CSFE_CHICKEN1_REG);
e870ce1791520c Zhi Wang 2022-04-07  1072  #undef CSFE_CHICKEN1_REG
e870ce1791520c Zhi Wang 2022-04-07  1073  	MMIO_D(GEN8_HDC_CHICKEN1);
e870ce1791520c Zhi Wang 2022-04-07  1074  	MMIO_D(GEN9_WM_CHICKEN3);
e870ce1791520c Zhi Wang 2022-04-07  1075  
e870ce1791520c Zhi Wang 2022-04-07  1076  	if (IS_KABYLAKE(dev_priv) || IS_COFFEELAKE(dev_priv))
e870ce1791520c Zhi Wang 2022-04-07  1077  		MMIO_D(GAMT_CHKN_BIT_REG);
e870ce1791520c Zhi Wang 2022-04-07  1078  	if (!IS_BROXTON(dev_priv))
e870ce1791520c Zhi Wang 2022-04-07  1079  		MMIO_D(GEN9_CTX_PREEMPT_REG);
e870ce1791520c Zhi Wang 2022-04-07 @1080  	MMIO_F(_MMIO(DMC_MMIO_START_RANGE), 0x3000);
e870ce1791520c Zhi Wang 2022-04-07  1081  	return 0;
e870ce1791520c Zhi Wang 2022-04-07  1082  }
e870ce1791520c Zhi Wang 2022-04-07  1083  

:::::: The code at line 1021 was first introduced by commit
:::::: e870ce1791520cd03f67c5a16f309d94e4aede85 i915/gvt: Separate the MMIO tracking table from GVT-g

:::::: TO: Zhi Wang <zhi.a.wang@intel.com>
:::::: CC: Zhi Wang <zhi.a.wang@intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
