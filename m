Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6387458B9FB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 09:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbiHGHR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 03:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbiHGHR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 03:17:27 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFD9CE14
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 00:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659856646; x=1691392646;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TdLw4Azh+hoq5i+6PGvcMP8zLtqWf25xwRt90BA7PeY=;
  b=CyB1XFyimKhppcdqrPTMwS0/UK3ahXAfVqPipSmqj69NF3Ij+Bei6EWk
   8XhFQuGWMRh/MMbZG9wNDrGEYIvDGZeBdNw9mCDynUL1PUvk3VaN8LlLS
   T4cXjhit+nFI7qDY7cFsd5X8o3D5wvIqu4mB79nihPVec2FMV7G0fuQLb
   PmLif88Y4wAbHFYSis4JnDaM6mVfwRDf/c63M74v9B/UF0DvQBUQQAT1Z
   1ecqgJudjXfIJpvtPNzQUdxf7kg8Uomii3byIDCgrDbmN4Bl2CU2q2DIC
   tx3dx+c0JSEcaxoRIcORkYBZ9nWXq0+FbA+oy0toouZTQhu/fX3d0EiDp
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10431"; a="376712202"
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="376712202"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 00:17:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="746291656"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 07 Aug 2022 00:17:24 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKaXM-000L66-17;
        Sun, 07 Aug 2022 07:17:24 +0000
Date:   Sun, 7 Aug 2022 15:16:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [ammarfaizi2-block:tglx/devel/depthtracking 57/59]
 kernel/trace/trace_selftest.c:790:31: error: expected string literal before
 ')' token
Message-ID: <202208071501.dqQ7TXNS-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block tglx/devel/depthtracking
head:   b518e558c49324fa002255761d2a7324ba31f7b5
commit: cb5c190267562764025e25c3e726ae511003b0a0 [57/59] x86/ftrace: Make it call depth tracking aware
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220807/202208071501.dqQ7TXNS-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/cb5c190267562764025e25c3e726ae511003b0a0
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block tglx/devel/depthtracking
        git checkout cb5c190267562764025e25c3e726ae511003b0a0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

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
>> kernel/trace/trace_selftest.c:790:31: error: expected string literal before ')' token
     790 |         asm(CALL_DEPTH_ACCOUNT);
         |                               ^


vim +790 kernel/trace/trace_selftest.c

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
