Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0AE559B17B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 06:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiHUD5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 23:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiHUD5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 23:57:35 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E113F222B9
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 20:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661054252; x=1692590252;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=a2+HZ/1VMGndE5pqJ7qFGvhrauP3mcu9ynso9RvgP1c=;
  b=ieIvIY+RGA1ED917KL6C8I3V7T7QLzxw9R7HcDDZ8flL4O2qHiutvhS+
   ZeY51tLzPYO5Eqv6fDhepzhWZu2qLV1fuDcbxwwbXpzlyA686sn21qSpl
   KAewntPrg2EVdXiVnxa3uL5hNANhcjF2Qa5/hQD1wojNJ37lN9jydLAWx
   W2egqrqTdsVkaFmMT6dtD+fbiyYfCLprI6yDm+ju+GocLpENrbM5St02I
   fxHdDoR9uK83DYK/tn9CBnasjwF6n4I2SzD9gSYum7iis496sHYYBvL9R
   B56IBiLAniGbHALbm8DEYI7oXBW4JrieTxnmCYPDjoX0D9bt0t3+VPGX9
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10445"; a="294499670"
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="294499670"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2022 20:57:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="676840843"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 20 Aug 2022 20:57:30 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPc5a-0003bv-07;
        Sun, 21 Aug 2022 03:57:30 +0000
Date:   Sun, 21 Aug 2022 11:56:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: drivers/gpu/drm/msm/dp/dp_link.c:969
 dp_link_process_link_status_update() warn: inconsistent indenting
Message-ID: <202208211100.Mmub10Dv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   15b3f48a4339e3c16acf18624e2b7f60bc5e9a2c
commit: 202aceac8bb3ae12d41dcd3ac9e6c3395963032b drm/msm/dp: replace DRM_DEBUG_DP marco with drm_dbg_dp
date:   4 months ago
config: microblaze-randconfig-m041-20220820 (https://download.01.org/0day-ci/archive/20220821/202208211100.Mmub10Dv-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
drivers/gpu/drm/msm/dp/dp_link.c:969 dp_link_process_link_status_update() warn: inconsistent indenting

vim +969 drivers/gpu/drm/msm/dp/dp_link.c

c943b4948b5848 Chandan Uddaraju 2020-08-27  941  
c943b4948b5848 Chandan Uddaraju 2020-08-27  942  /**
c943b4948b5848 Chandan Uddaraju 2020-08-27  943   * dp_link_process_link_status_update() - processes link status updates
c943b4948b5848 Chandan Uddaraju 2020-08-27  944   * @link: Display Port link module data
c943b4948b5848 Chandan Uddaraju 2020-08-27  945   *
c943b4948b5848 Chandan Uddaraju 2020-08-27  946   * This function will check for changes in the link status, e.g. clock
c943b4948b5848 Chandan Uddaraju 2020-08-27  947   * recovery done on all lanes, and trigger link training if there is a
c943b4948b5848 Chandan Uddaraju 2020-08-27  948   * failure/error on the link.
c943b4948b5848 Chandan Uddaraju 2020-08-27  949   *
c943b4948b5848 Chandan Uddaraju 2020-08-27  950   * The function will return 0 if the a link status update has been processed,
c943b4948b5848 Chandan Uddaraju 2020-08-27  951   * otherwise it will return -EINVAL.
c943b4948b5848 Chandan Uddaraju 2020-08-27  952   */
c943b4948b5848 Chandan Uddaraju 2020-08-27  953  static int dp_link_process_link_status_update(struct dp_link_private *link)
c943b4948b5848 Chandan Uddaraju 2020-08-27  954  {
ea530388e64bd5 Kuogee Hsieh     2020-11-03  955  	bool channel_eq_done = drm_dp_channel_eq_ok(link->link_status,
ea530388e64bd5 Kuogee Hsieh     2020-11-03  956  			link->dp_link.link_params.num_lanes);
ea530388e64bd5 Kuogee Hsieh     2020-11-03  957  
ea530388e64bd5 Kuogee Hsieh     2020-11-03  958  	bool clock_recovery_done = drm_dp_clock_recovery_ok(link->link_status,
ea530388e64bd5 Kuogee Hsieh     2020-11-03  959  			link->dp_link.link_params.num_lanes);
c943b4948b5848 Chandan Uddaraju 2020-08-27  960  
202aceac8bb3ae Kuogee Hsieh     2022-02-17  961  	drm_dbg_dp(link->drm_dev,
202aceac8bb3ae Kuogee Hsieh     2022-02-17  962  		       "channel_eq_done = %d, clock_recovery_done = %d\n",
ea530388e64bd5 Kuogee Hsieh     2020-11-03  963                          channel_eq_done, clock_recovery_done);
ea530388e64bd5 Kuogee Hsieh     2020-11-03  964  
ea530388e64bd5 Kuogee Hsieh     2020-11-03  965  	if (channel_eq_done && clock_recovery_done)
ea530388e64bd5 Kuogee Hsieh     2020-11-03  966  		return -EINVAL;
ea530388e64bd5 Kuogee Hsieh     2020-11-03  967  
c943b4948b5848 Chandan Uddaraju 2020-08-27  968  
c943b4948b5848 Chandan Uddaraju 2020-08-27 @969         return 0;
c943b4948b5848 Chandan Uddaraju 2020-08-27  970  }
c943b4948b5848 Chandan Uddaraju 2020-08-27  971  

:::::: The code at line 969 was first introduced by commit
:::::: c943b4948b5848fc0e07f875edbd35a973879e22 drm/msm/dp: add displayPort driver support

:::::: TO: Chandan Uddaraju <chandanu@codeaurora.org>
:::::: CC: Rob Clark <robdclark@chromium.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
