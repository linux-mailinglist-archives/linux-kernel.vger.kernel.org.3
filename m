Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEB05819DA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 20:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbiGZSjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 14:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239515AbiGZSi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 14:38:57 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C54432EFD
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 11:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658860736; x=1690396736;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rAUBIElhLyFX0ka939yot8kphikOrZSl4q2s9kNYA6Y=;
  b=gb2glYDPxJZmOSAvxM8cUxYga2+pi0mvCZ7LLrnB1XdGgWaEhh+wGxg2
   Kbl6JMfeFRZ2ZlFsQGY8vCf3axnWV6P+jJHuVI4t/F3ZR2CFNXJ0hKniE
   WGik+rzjVltvHtcj5Wt2lye1/VGNPE+OGDwvWcyFdmNGDwM5q7jOfprkJ
   nW5597pVjdY1rJr5bQ+clMwt0a1toAbufE+mYabgUQpT2v/NqQ0RCGvHn
   x8gamjwzSVpYSVYTNAzgBC/eHRincB/oFHwB1Skgu4Z39Z0puF0htgsyh
   9XOi1Af1u514DBBPr1zHMGMciieOSThBQQPkkoV7zDeuAvNxo+HfKXfrk
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="271067627"
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="271067627"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 11:38:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="575607883"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 26 Jul 2022 11:38:54 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oGPSI-0007UM-0P;
        Tue, 26 Jul 2022 18:38:54 +0000
Date:   Wed, 27 Jul 2022 02:38:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Faycal Benmlih <faycal.benmlih@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/platform/x86/socwatch/sw_counter_list.c:88:25: sparse:
 sparse: incorrect type in argument 2 (different base types)
Message-ID: <202207270208.inU91EGZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/mchinth/linux sep_socwatch_linux_5_10
head:   c55df4a2b60fc7c6c4d00fd9f9fb447087833513
commit: 80c46c8183c607e70bcb88e9b04febae6c7775a2 SEP/SOCWATCH Update SoCWatch driver after rebasing to linux v5.6
date:   1 year, 10 months ago
config: x86_64-randconfig-s022 (https://download.01.org/0day-ci/archive/20220727/202207270208.inU91EGZ-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/mchinth/linux/commit/80c46c8183c607e70bcb88e9b04febae6c7775a2
        git remote add mchinth https://github.com/mchinth/linux
        git fetch --no-tags mchinth sep_socwatch_linux_5_10
        git checkout 80c46c8183c607e70bcb88e9b04febae6c7775a2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/platform/x86/socwatch/sw_counter_list.c:88:25: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int flags @@     got restricted gfp_t @@
   drivers/platform/x86/socwatch/sw_counter_list.c:88:25: sparse:     expected unsigned int flags
   drivers/platform/x86/socwatch/sw_counter_list.c:88:25: sparse:     got restricted gfp_t

vim +88 drivers/platform/x86/socwatch/sw_counter_list.c

    74	
    75		pw_u64_t i = 0, max_msr_value = 0;//, msr_array_size = 0;
    76		pw_u64_t msr_list_size = sizeof(msr_info_list) / sizeof(msr_info_list[0]);
    77	
    78		// TODO: Probably sort msr_info_list rather than assuming it is sorted.
    79	
    80		// Since 'msr_info_list' is sorted, the last entry should be the highest MSR
    81		// address
    82		max_msr_value = msr_info_list[msr_list_size-1];
    83		pw_pr_debug("max msr value: %llx\n", max_msr_value);
    84	
    85		// TODO: Optimize the memory usage by making msr_search_array a bit vector
    86		msr_search_array_size = max_msr_value + 1;
    87		msr_search_array = sw_kmalloc(msr_search_array_size * sizeof(pw_u8_t),
  > 88				GFP_KERNEL);
    89	
    90		if (msr_search_array == NULL) {
    91			return -PW_ERROR;
    92		}
    93	
    94		memset(msr_search_array, 0, msr_search_array_size);
    95	
    96		for (i = 0; i < msr_list_size; ++i) {
    97			msr_search_array[msr_info_list[i]] = 1;
    98		}
    99	
   100		return PW_SUCCESS;
   101	}
   102	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
