Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCAB0588A29
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 12:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbiHCKMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 06:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbiHCKMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 06:12:03 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E661E3E5
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 03:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659521522; x=1691057522;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=h0Tq3B5/VFQNqg+DY8Yg9rv2Cd7sJ3O/e1qvCe0iaRo=;
  b=bn+lT6NQPEib3YY9HyqRuZgumMuLYQ1eSsLOrWrs3sg94ai+pUwl7qMw
   xwWdW1bcKxJRELNQPwfVDn9sJmVtb3nCDKRris06ztWlWGDXm27I+icTW
   ybBeuv4sx+j1uPTsz9fLjvGUkzjmwqCrp61eiH8iHkdCqWyjfbVAxHNss
   5jXRQuIqtIqICrYmZPEA1RiTFYmX+GIaGQ4y8ZNPdnBoES7q3H2WxB4rE
   Cp5ptqoR/jtw0H3MQhNvej7zcGQkw5+RT45c1EVqse6bM+tYOkrTX/VEl
   vpYhztsDn/SSsd58UNcKYk9Adau0/dTx5Q/AkUY4MoARtJNFLd4Y4EzSC
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="270015964"
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="270015964"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 03:12:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="692192957"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Aug 2022 03:12:01 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJBM8-000H8j-1T;
        Wed, 03 Aug 2022 10:12:00 +0000
Date:   Wed, 3 Aug 2022 18:11:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [ammarfaizi2-block:tglx/devel/depthtracking 57/59]
 kernel/trace/trace_selftest.c:790:13: error: expected string literal before
 'CALL_DEPTH_ACCOUNT'
Message-ID: <202208031836.BJr6Jjxd-lkp@intel.com>
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
head:   b518e558c49324fa002255761d2a7324ba31f7b5
commit: cb5c190267562764025e25c3e726ae511003b0a0 [57/59] x86/ftrace: Make it call depth tracking aware
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20220803/202208031836.BJr6Jjxd-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/cb5c190267562764025e25c3e726ae511003b0a0
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block tglx/devel/depthtracking
        git checkout cb5c190267562764025e25c3e726ae511003b0a0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

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
