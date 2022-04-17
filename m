Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13ED5049A9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 23:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbiDQVsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 17:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbiDQVsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 17:48:43 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992E5E009
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 14:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650231963; x=1681767963;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QDTc3+JLDhEMbDbF/sCTQeHWPHzpAQmkGJ4SIB8+viM=;
  b=Rw/JYho4nxgI94QQj+I3t0Zw6/497N0HBfkegehL9Fh+JhH0/M84TTYG
   bVntNGOjAcbolp+ArNF6gpIZjCfgp4aUHICxh6ZRsr9k/ZsZBI2FpKi6f
   lMW21feqvTu0YUGehd5gET2GhPQKZkhrLyWQxnaZ2cdBoG7RP+NNAJXjD
   lN3/C5lGjRBX4+zQys/EzTUJwBS3PuWYJg0xFP73yj1RAwTeM5DqUL3vw
   0npLferLwCJWk0oi3d0Q7AoJOTFe2fBGBQQsimEm3iYUrDXVGcWKZzfs8
   naZ+IZz5LaT2C5mP6NdAbg+IMOhbqsPOdCz5DEq0EXYqFYaJ72ocRGSbY
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="263173726"
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="263173726"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2022 14:46:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="528640863"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 17 Apr 2022 14:46:02 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngCiX-0004Ad-Bo;
        Sun, 17 Apr 2022 21:46:01 +0000
Date:   Mon, 18 Apr 2022 05:45:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/x86/kernel/traps.c:248:17: error: implicit declaration of
 function '__warn'; did you mean 'pr_warn'?
Message-ID: <202204180524.7PXohDtU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a1901b464e7e3e28956ae7423db2847dbbfb5be8
commit: 991625f3dd2cbc4b787deb0213e2bcf8fa264b21 x86/ibt: Add IBT feature, MSR and #CP handling
date:   5 weeks ago
config: x86_64-buildonly-randconfig-r006-20220418 (https://download.01.org/0day-ci/archive/20220418/202204180524.7PXohDtU-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=991625f3dd2cbc4b787deb0213e2bcf8fa264b21
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 991625f3dd2cbc4b787deb0213e2bcf8fa264b21
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86/kernel/traps.c: In function '__exc_control_protection':
>> arch/x86/kernel/traps.c:248:17: error: implicit declaration of function '__warn'; did you mean 'pr_warn'? [-Werror=implicit-function-declaration]
     248 |                 __warn(__FILE__, __LINE__, (void *)regs->ip, TAINT_WARN, regs, NULL);
         |                 ^~~~~~
         |                 pr_warn
   cc1: some warnings being treated as errors


vim +248 arch/x86/kernel/traps.c

   229	
   230	DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
   231	{
   232		if (!cpu_feature_enabled(X86_FEATURE_IBT)) {
   233			pr_err("Unexpected #CP\n");
   234			BUG();
   235		}
   236	
   237		if (WARN_ON_ONCE(user_mode(regs) || (error_code & CP_EC) != CP_ENDBR))
   238			return;
   239	
   240		if (unlikely(regs->ip == (unsigned long)&ibt_selftest_ip)) {
   241			regs->ax = 0;
   242			return;
   243		}
   244	
   245		pr_err("Missing ENDBR: %pS\n", (void *)instruction_pointer(regs));
   246		if (!ibt_fatal) {
   247			printk(KERN_DEFAULT CUT_HERE);
 > 248			__warn(__FILE__, __LINE__, (void *)regs->ip, TAINT_WARN, regs, NULL);
   249			return;
   250		}
   251		BUG();
   252	}
   253	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
