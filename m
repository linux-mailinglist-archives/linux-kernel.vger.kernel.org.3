Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CF657729C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 03:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbiGQBDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 21:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiGQBDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 21:03:03 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6871A81D
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 18:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658019783; x=1689555783;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3BiS0zbc+cusXvd8nZICX7spbSHsg8v/8OaQlGSShxs=;
  b=RrOU75v5NmcmIojvVVFXwVl0nsqqRMJcZNpIQX+7wJolYYLw4uG/y4XU
   MCcqDWDO4k2k3jH6ytegWKBO1uNCCklXOBF6jHGpkYHNX4wzcVxlg5JW8
   8mQIKIwT2Zuctnn7WBq8XtVAECwj/DddzmzyM3PjQg7ENAIbjnV5QNMow
   iGs2uDSrSCdvwajYnNVX5cp8xmu709Ok+F/6NPd1W3mlMurHeMbtw9fKB
   qRV3f5ujzjJO8o6vqrDC2mRnZ9D9gbw/2CkVHy7M6rh6aWDvvC61Wspcu
   cy8DagcyE92lCG2g0FjbipEHLwVgc+mO6AmOUNRYj+4fpuDnEz+yYh4QJ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10410"; a="284773614"
X-IronPort-AV: E=Sophos;i="5.92,278,1650956400"; 
   d="scan'208";a="284773614"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2022 18:03:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,278,1650956400"; 
   d="scan'208";a="624290577"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 16 Jul 2022 18:03:01 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCsgW-0002OQ-II;
        Sun, 17 Jul 2022 01:03:00 +0000
Date:   Sun, 17 Jul 2022 09:02:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [ammarfaizi2-block:tglx/devel/depthtracking 36/38]
 kernel/trace/trace_selftest.c:790:13: error: expected string literal before
 'CALL_DEPTH_ACCOUNT'
Message-ID: <202207170826.7Ag7hzNL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block tglx/devel/depthtracking
head:   6acb3e18b1371629447553c6ec79c3dbf04a849d
commit: da9a7b9cb9728a5d14c71d4b42b812f4821326e6 [36/38] x86/ftrace: Make it call depth tracking aware
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20220717/202207170826.7Ag7hzNL-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/da9a7b9cb9728a5d14c71d4b42b812f4821326e6
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block tglx/devel/depthtracking
        git checkout da9a7b9cb9728a5d14c71d4b42b812f4821326e6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/trace/trace.c: In function 'trace_check_vprintf':
   kernel/trace/trace.c:3846:17: warning: function 'trace_check_vprintf' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    3846 |                 trace_seq_vprintf(&iter->seq, iter->fmt, ap);
         |                 ^~~~~~~~~~~~~~~~~
   kernel/trace/trace.c:3913:17: warning: function 'trace_check_vprintf' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    3913 |                 trace_seq_vprintf(&iter->seq, p, ap);
         |                 ^~~~~~~~~~~~~~~~~
   In file included from kernel/trace/trace.c:8672:
   kernel/trace/trace_selftest.c: In function 'trace_direct_tramp':
>> kernel/trace/trace_selftest.c:790:13: error: expected string literal before 'CALL_DEPTH_ACCOUNT'
     790 |         asm(CALL_DEPTH_ACCOUNT);
         |             ^~~~~~~~~~~~~~~~~~


vim +/CALL_DEPTH_ACCOUNT +790 kernel/trace/trace_selftest.c

   786	
   787	#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
   788	noinline __noclone static void trace_direct_tramp(void)
   789	{
 > 790		asm(CALL_DEPTH_ACCOUNT);
   791	}
   792	#endif
   793	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
