Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384B451EF8D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239994AbiEHTIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235729AbiEHRvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 13:51:55 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F84DDFC5
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 10:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652032084; x=1683568084;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Kw8BRvmapQWWRIscmnjVECXlHEtYY3SzO2+15W0R9ug=;
  b=F6yPvX08vLqENf8C28zTzxAtmOQyGS/8zRiDudFDW2yXtp0b5mGwiveN
   yGK3ZpyHJNW4dOZQY/Ie78hjg62XThPzPpNSiDoo2Pch73ln6eg30R2R8
   St3JSQI2g/sxUmmI9zgj2m+Sg5kS3Sm8/5jOZ/LPr7E1WxKofQxXp8nnB
   2UCxBiIIu6k7C3bWNvqkde55ceveySPQSM4YCsVtQr5nWZ1bFkl+3HLNM
   fNIdMns5+jbPk1UZcmFwtklIELIyfNgxfZap2WUz5F9xt0rBHijjooQYT
   BWVIvu0fBIo/ikITdmUL+1zDd9+53M32M6/mx/c5UewIKS4G58ZfJyWIo
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10341"; a="269004448"
X-IronPort-AV: E=Sophos;i="5.91,208,1647327600"; 
   d="scan'208";a="269004448"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2022 10:48:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,208,1647327600"; 
   d="scan'208";a="622613572"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 08 May 2022 10:48:01 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nnl0j-000FfF-8T;
        Sun, 08 May 2022 17:48:01 +0000
Date:   Mon, 9 May 2022 01:47:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, 0day robot <lkp@intel.com>,
        Junwen Wu <wudaemon@163.com>
Subject: drivers/thermal/thermal_sysfs.c:794:9: warning: mixing declarations
 and code is a C99 extension
Message-ID: <202205090117.wVvKlfFv-lkp@intel.com>
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
date:   2 hours ago
config: riscv-randconfig-r042-20220508 (https://download.01.org/0day-ci/archive/20220509/202205090117.wVvKlfFv-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a385645b470e2d3a1534aae618ea56b31177639f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/a9158ddd9f2a97e356583d0bdb81c4e6822e6ad7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review UPDATE-20220508-232600/Zhang-Rui/thermal-thermal_stats-skip-broken-trans_table/20220419-165035
        git checkout a9158ddd9f2a97e356583d0bdb81c4e6822e6ad7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/thermal/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/thermal/thermal_sysfs.c:794:9: warning: mixing declarations and code is a C99 extension [-Wdeclaration-after-statement]
       int l = min, r = max, mid, cnt = 0;
           ^
   1 warning generated.


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
