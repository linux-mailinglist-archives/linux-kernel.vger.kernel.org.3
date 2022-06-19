Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7368F5508B3
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 07:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbiFSFDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 01:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiFSFDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 01:03:48 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B8211A31
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 22:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655615027; x=1687151027;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xus0gcBhrotcKIzzH8g1rAdL587paFQCC6J4Uc93kag=;
  b=AtKH9nE0sZXEs0pqKeBUm7D8Yabivn/ZCZ4H4dwTjtqZSk4IUIWwMCs9
   W2PQSoxvXPuFyYNI2DB6tssrZwLve/QvZi2cDhLod4l6xPtr7UFkxZhlX
   it9JTtMwKcp5QhjfHz4mH/+izmawU2cwGVUIPbK0IakjCp4CX+MTujS6q
   Pk+Sw6jP9WIqWhI14GTyvBG5H3Qydslc5ruAZ36SW5LGy3EkK68vixrF1
   6C7uMAzSDgizTwMDLKneTav4MVJ8PnhLa9f46EqzPLVVbFnSBYGGPdqoW
   Q7zsC0I0dgE1QEvvnTb4n5LrJr532Oq05lp6t5w61IrRYPzk4sEDgwHwL
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="260131551"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="260131551"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2022 22:03:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="688942807"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 18 Jun 2022 22:03:45 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o2n69-000Qt1-Ak;
        Sun, 19 Jun 2022 05:03:45 +0000
Date:   Sun, 19 Jun 2022 13:03:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: drivers/gpu/drm/msm/dp/dp_link.c:969
 dp_link_process_link_status_update() warn: inconsistent indenting
Message-ID: <202206191259.gkN6i5Oe-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4b35035bcf80ddb47c0112c4fbd84a63a2836a18
commit: 202aceac8bb3ae12d41dcd3ac9e6c3395963032b drm/msm/dp: replace DRM_DEBUG_DP marco with drm_dbg_dp
date:   7 weeks ago
config: ia64-randconfig-m031-20220616 (https://download.01.org/0day-ci/archive/20220619/202206191259.gkN6i5Oe-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.3.0

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
