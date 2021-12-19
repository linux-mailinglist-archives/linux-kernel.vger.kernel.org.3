Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD0847A03D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 11:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbhLSKtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 05:49:32 -0500
Received: from mga07.intel.com ([134.134.136.100]:23913 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229801AbhLSKtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 05:49:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639910971; x=1671446971;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DU+Ch+Bd9k6ElZcwAu4SBLgHixTb83UzHp0kfC5fzXA=;
  b=cJJzQehKADVe299jcPlpLpYPT6QW97+DmUtVsVVehMtLWf+KDUnX/35T
   HAIZJqz7eFzePeERIcEKFZMLWZQCKN2mMDvenvC3PsaMmhUUxF+j6uwY6
   GWBZWrb7LdmDKV4l8g379w80mPMNLaAUEA9Wyf9BGttD3c2bv7UYntT2+
   eVF0lcrNDZ58JF6xLQF0kg2N/hSe9KnWfrJBIwZDDaTVuDi3ykhaGrHeb
   bkRhyFlf0m5yBDT0ku7krXiv8CuVlIxSdG5+G1zOBz0hpo7AZ/IlYhNJj
   F9j2ba7GtAk5RwrDF8qBUT4ILr5tFri/AwTwbB/X7juF8e72ooA9ZNMfd
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10202"; a="303379479"
X-IronPort-AV: E=Sophos;i="5.88,217,1635231600"; 
   d="scan'208";a="303379479"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2021 02:49:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,217,1635231600"; 
   d="scan'208";a="507331006"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 19 Dec 2021 02:49:29 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mytkv-0006tf-2Y; Sun, 19 Dec 2021 10:49:29 +0000
Date:   Sun, 19 Dec 2021 18:49:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wenjing Liu <wenjing.liu@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Jun Lei <Jun.Lei@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:1700
 dp_perform_8b_10b_link_training() warn: inconsistent indenting
Message-ID: <202112191837.wHojpl3e-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3f667b5d4053ad54aee13dab5c94f04ff75ddfdf
commit: cd6a9a1c15c2942c6a3b19a33a2523a18229ec4a drm/amd/display: isolate 8b 10b link training sequence into its own function
date:   7 months ago
config: x86_64-randconfig-m001-20211207 (https://download.01.org/0day-ci/archive/20211219/202112191837.wHojpl3e-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

New smatch warnings:
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:1700 dp_perform_8b_10b_link_training() warn: inconsistent indenting

Old smatch warnings:
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:1857 perform_link_training_with_retries() warn: inconsistent indenting

vim +1700 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c

3df212576e8b6f Wenjing Liu      2021-05-03  1657  
cd6a9a1c15c294 Wenjing Liu      2021-05-04  1658  static enum link_training_result dp_perform_8b_10b_link_training(
e0a6440a2961b1 David Galiffi    2019-05-30  1659  		struct dc_link *link,
cd6a9a1c15c294 Wenjing Liu      2021-05-04  1660  		struct link_training_settings *lt_settings)
e0a6440a2961b1 David Galiffi    2019-05-30  1661  {
e0a6440a2961b1 David Galiffi    2019-05-30  1662  	enum link_training_result status = LINK_TRAINING_SUCCESS;
64c12b733fe7ea abdoulaye berthe 2019-07-24  1663  
cd6a9a1c15c294 Wenjing Liu      2021-05-04  1664  	uint8_t repeater_cnt;
cd6a9a1c15c294 Wenjing Liu      2021-05-04  1665  	uint8_t repeater_id;
bcc5042a220903 abdoulaye berthe 2020-02-18  1666  
82054678aeb669 Martin Leung     2020-02-12  1667  	if (link->ctx->dc->work_arounds.lt_early_cr_pattern)
cd6a9a1c15c294 Wenjing Liu      2021-05-04  1668  		start_clock_recovery_pattern_early(link, lt_settings, DPRX);
834a9a9f04c708 Martin Leung     2020-02-13  1669  
834a9a9f04c708 Martin Leung     2020-02-13  1670  	/* 1. set link rate, lane count and spread. */
cd6a9a1c15c294 Wenjing Liu      2021-05-04  1671  	dpcd_set_link_settings(link, lt_settings);
e0a6440a2961b1 David Galiffi    2019-05-30  1672  
3128b285021ec0 Wesley Chalmers  2021-03-15  1673  	if (link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT) {
008a4016c5cf92 Nikola Cornij    2019-06-24  1674  
e0a6440a2961b1 David Galiffi    2019-05-30  1675  		/* 2. perform link training (set link training done
e0a6440a2961b1 David Galiffi    2019-05-30  1676  		 *  to false is done as well)
e0a6440a2961b1 David Galiffi    2019-05-30  1677  		 */
573a0a03af0253 Jimmy Kizito     2021-04-09  1678  		repeater_cnt = dp_convert_to_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
64c12b733fe7ea abdoulaye berthe 2019-07-24  1679  
64c12b733fe7ea abdoulaye berthe 2019-07-24  1680  		for (repeater_id = repeater_cnt; (repeater_id > 0 && status == LINK_TRAINING_SUCCESS);
64c12b733fe7ea abdoulaye berthe 2019-07-24  1681  				repeater_id--) {
cd6a9a1c15c294 Wenjing Liu      2021-05-04  1682  			status = perform_clock_recovery_sequence(link, lt_settings, repeater_id);
64c12b733fe7ea abdoulaye berthe 2019-07-24  1683  
64c12b733fe7ea abdoulaye berthe 2019-07-24  1684  			if (status != LINK_TRAINING_SUCCESS)
64c12b733fe7ea abdoulaye berthe 2019-07-24  1685  				break;
64c12b733fe7ea abdoulaye berthe 2019-07-24  1686  
64c12b733fe7ea abdoulaye berthe 2019-07-24  1687  			status = perform_channel_equalization_sequence(link,
cd6a9a1c15c294 Wenjing Liu      2021-05-04  1688  					lt_settings,
64c12b733fe7ea abdoulaye berthe 2019-07-24  1689  					repeater_id);
64c12b733fe7ea abdoulaye berthe 2019-07-24  1690  
64c12b733fe7ea abdoulaye berthe 2019-07-24  1691  			if (status != LINK_TRAINING_SUCCESS)
64c12b733fe7ea abdoulaye berthe 2019-07-24  1692  				break;
64c12b733fe7ea abdoulaye berthe 2019-07-24  1693  
64c12b733fe7ea abdoulaye berthe 2019-07-24  1694  			repeater_training_done(link, repeater_id);
64c12b733fe7ea abdoulaye berthe 2019-07-24  1695  		}
64c12b733fe7ea abdoulaye berthe 2019-07-24  1696  	}
64c12b733fe7ea abdoulaye berthe 2019-07-24  1697  
64c12b733fe7ea abdoulaye berthe 2019-07-24  1698  	if (status == LINK_TRAINING_SUCCESS) {
cd6a9a1c15c294 Wenjing Liu      2021-05-04  1699  		status = perform_clock_recovery_sequence(link, lt_settings, DPRX);
e0a6440a2961b1 David Galiffi    2019-05-30 @1700  	if (status == LINK_TRAINING_SUCCESS) {
e0a6440a2961b1 David Galiffi    2019-05-30  1701  		status = perform_channel_equalization_sequence(link,
cd6a9a1c15c294 Wenjing Liu      2021-05-04  1702  					lt_settings,
64c12b733fe7ea abdoulaye berthe 2019-07-24  1703  					DPRX);
64c12b733fe7ea abdoulaye berthe 2019-07-24  1704  		}
e0a6440a2961b1 David Galiffi    2019-05-30  1705  	}
e0a6440a2961b1 David Galiffi    2019-05-30  1706  
cd6a9a1c15c294 Wenjing Liu      2021-05-04  1707  	return status;
e0a6440a2961b1 David Galiffi    2019-05-30  1708  }
e0a6440a2961b1 David Galiffi    2019-05-30  1709  

:::::: The code at line 1700 was first introduced by commit
:::::: e0a6440a2961b1da3ea895b0bef082fc1a78e190 drm/amd/display: Add ability to set preferred link training parameters.

:::::: TO: David Galiffi <David.Galiffi@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
