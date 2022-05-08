Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185B951F1CF
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 23:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbiEHV03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 17:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbiEHV0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 17:26:25 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237CCBC81
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 14:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652044953; x=1683580953;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=02DbrAd5tIValgMHCSNRVfcumpO/PsGRfW28t/0b7yM=;
  b=BxjWHNFNe+TNfhpErz002Z1ChhI7vezRmRdbopTK8wVKDTDzO7qSeB9n
   bDKendIfSTZ+vHm7+TjgftVxS3f3MvR2Ms7D4Dto17Kl9/FI6r80L7d6i
   ph/2WzL1bUSfAG+2lk5xc3zOJMU+niwgp1oO/i5PAne/97EvgB44yDyhC
   fiS4uI6ktVcntYCaPwmvVvT1TV1nKhbUIYEf+/EqRHy7mH2lnqSSKkztV
   9CeyHvhk+n5DuiuD4tAHPk9h2UfWCteS6XvgrQRk4fB2mqpGFl5vwuoxV
   1RD7bhiXER3nlurEQm8mCQy2Iu+Cd8O008i0BnF+nVe5FO9qKDD0lpwIn
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10341"; a="266476470"
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="266476470"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2022 14:22:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="569878708"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 08 May 2022 14:22:28 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nnoMG-000FqO-7v;
        Sun, 08 May 2022 21:22:28 +0000
Date:   Mon, 9 May 2022 05:21:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>, Junwen Wu <wudaemon@163.com>
Subject: drivers/thermal/thermal_sysfs.c:794:5: warning: ISO C90 forbids
 mixed declarations and code
Message-ID: <202205090558.EnCJkmXp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel-lab-lkp/linux/commits/UPDATE-20220508-232600/Zhang-Rui/thermal-thermal_stats-skip-broken-trans_table/20220419-165035
head:   a9158ddd9f2a97e356583d0bdb81c4e6822e6ad7
commit: a9158ddd9f2a97e356583d0bdb81c4e6822e6ad7 thermal/core: change mm alloc method to avoid kernel warning
date:   6 hours ago
config: arc-randconfig-r032-20220508 (https://download.01.org/0day-ci/archive/20220509/202205090558.EnCJkmXp-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a9158ddd9f2a97e356583d0bdb81c4e6822e6ad7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review UPDATE-20220508-232600/Zhang-Rui/thermal-thermal_stats-skip-broken-trans_table/20220419-165035
        git checkout a9158ddd9f2a97e356583d0bdb81c4e6822e6ad7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/thermal/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/thermal/thermal_sysfs.c: In function 'find_show_state':
>> drivers/thermal/thermal_sysfs.c:794:5: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     794 |     int l = min, r = max, mid, cnt = 0;
         |     ^~~


vim +794 drivers/thermal/thermal_sysfs.c

   785	
   786	static int find_show_state( int *nums, int numsSize, int k, unsigned int *max_value)
   787	{
   788	    int i, min = INT_MAX, max = 0;
   789	    for( i = 0; i < numsSize; ++i )
   790	    {
   791	        min = nums[i] < min ? nums[i] : min;
   792	        max = nums[i] > max ? nums[i] : max;
   793	    }
 > 794	    int l = min, r = max, mid, cnt = 0;
   795	    while( l < r )
   796	    {
   797	        mid = r - (r - l) / 2;
   798	        for( i = 0; i < numsSize; ++i )
   799	        {
   800	            if( nums[i] >= mid )
   801	                ++cnt;
   802	        }
   803	        if( cnt < k )
   804	        {
   805	            r = mid - 1;
   806	            cnt = 0;
   807	        }
   808	        else
   809	        {
   810	            l = mid;
   811	            cnt = 0;
   812	        }
   813	    }
   814	     *max_value = max;
   815	    return l;
   816	}
   817	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
