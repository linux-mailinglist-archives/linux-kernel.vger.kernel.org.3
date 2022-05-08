Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E286B51EF58
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236002AbiEHTIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238820AbiEHSWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 14:22:39 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17449AE65
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 11:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652033928; x=1683569928;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GtdZ1E9Jkp9Y4LzBoCJIoFrMBZvx8eD6iNyCc5Ta3xo=;
  b=OC+xffa+sJ/CZgMzQ5QM0FJTiQo5G1wzATK7JwxNA9iLLR6ckrs+5wY0
   /n1JAHmj7RN/lPmOtKrp9txNZZu8LCzl9W6Sh7NclHH0Vnh4ghgHDQwnc
   Ga1XbOAq0bugTNL37+Vx+eNiciGenN39ACmJUYqUF6xBfHYTuQHQo/Wpc
   Mcm+ejQjWaWQ6ClTBrEJp9L/E7RX3whqwF2n/snZ6i7uM7lptmDCYoAfi
   hpaSqnm8yzzE0IGq1edfo0fvQaH/DV9jvr3LWjvy4lBTDZ8ffF31mimQ1
   xOpSNI7D0lDMpPU4kjgaVMJ8regv/kJfiQos16WQiE4GIdkK7vEcldwM8
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10341"; a="355298516"
X-IronPort-AV: E=Sophos;i="5.91,208,1647327600"; 
   d="scan'208";a="355298516"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2022 11:18:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,208,1647327600"; 
   d="scan'208";a="655578036"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 08 May 2022 11:18:46 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nnlUT-000FhR-RF;
        Sun, 08 May 2022 18:18:45 +0000
Date:   Mon, 9 May 2022 02:18:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>, Junwen Wu <wudaemon@163.com>
Subject: drivers/thermal/thermal_sysfs.c:794:5: warning: ISO C90 forbids
 mixed declarations and code
Message-ID: <202205090229.ZuiS9dze-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
date:   3 hours ago
config: m68k-randconfig-r021-20220508 (https://download.01.org/0day-ci/archive/20220509/202205090229.ZuiS9dze-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a9158ddd9f2a97e356583d0bdb81c4e6822e6ad7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review UPDATE-20220508-232600/Zhang-Rui/thermal-thermal_stats-skip-broken-trans_table/20220419-165035
        git checkout a9158ddd9f2a97e356583d0bdb81c4e6822e6ad7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

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
