Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D904B3FC2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 03:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236457AbiBNCsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 21:48:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbiBNCsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 21:48:33 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AC93F33E
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 18:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644806906; x=1676342906;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hbUIdt1FhiJgEAGg/7eUSx6eqCzb9AsTPvEVmAfY5HA=;
  b=Z0QzmSSU35pwa1Tqzx4mL500Myaj+u3CgX81R2XsC7ePT+s2VLRgV7bH
   xNOEBiqrZ0Ytiugj8hYR1T5H/MeFAMSKs5O8HxwuJ/bOU7kAmt+9IYKtt
   AQ8a68KffRVDdBbgeEO7PaiV99yytkpHs2XH3CrHgx03a31Kw0Qa3YjgH
   6q6b2oCxre440//0/tm8x77mNQkdtPAm4KyyCCrEXQroMOOyyf+yiimM+
   a4v6NNoPb2/FOiwh4fKAHstJPEtR3d2YzjHqDRf/Wx4zva/z8PnvDDMN+
   Exo1mmwIXgCOTRhH0QGLbG5Hg84QxtPWUwwHHFbf6d3MFDKIBX7uYuPox
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="310735451"
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="310735451"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 18:48:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="485123162"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 13 Feb 2022 18:48:24 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJRPb-00086p-Ll; Mon, 14 Feb 2022 02:48:23 +0000
Date:   Mon, 14 Feb 2022 10:47:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:x86/wip.ibt 14/15] include/linux/kern_levels.h:5:18:
 error: format '%d' expects argument of type 'int', but argument 2 has type
 'long int'
Message-ID: <202202141009.F1MCaPz3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/wip.ibt
head:   ede73fa4e97e8f275401a989b8d9df192a2c3ec4
commit: 8c06569295c8df00e797ca406fc6b0919a473ee5 [14/15] x86/alternative: Use .ibt_endbr_sites to seal indirect calls
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220214/202202141009.F1MCaPz3-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=8c06569295c8df00e797ca406fc6b0919a473ee5
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue x86/wip.ibt
        git checkout 8c06569295c8df00e797ca406fc6b0919a473ee5
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/kernel.h:29,
                    from arch/x86/include/asm/percpu.h:27,
                    from arch/x86/include/asm/current.h:6,
                    from arch/x86/include/asm/processor.h:17,
                    from arch/x86/include/asm/timex.h:5,
                    from include/linux/timex.h:65,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from arch/x86/kernel/alternative.c:4:
   arch/x86/kernel/alternative.c: In function 'apply_ibt_endbr':
>> include/linux/kern_levels.h:5:18: error: format '%d' expects argument of type 'int', but argument 2 has type 'long int' [-Werror=format=]
       5 | #define KERN_SOH "\001"  /* ASCII Start Of Header */
         |                  ^~~~~~
   include/linux/printk.h:418:11: note: in definition of macro 'printk_index_wrap'
     418 |   _p_func(_fmt, ##__VA_ARGS__);    \
         |           ^~~~
   include/linux/printk.h:489:2: note: in expansion of macro 'printk'
     489 |  printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |  ^~~~~~
   include/linux/kern_levels.h:11:18: note: in expansion of macro 'KERN_SOH'
      11 | #define KERN_ERR KERN_SOH "3" /* error conditions */
         |                  ^~~~~~~~
   include/linux/printk.h:489:9: note: in expansion of macro 'KERN_ERR'
     489 |  printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~
   arch/x86/kernel/alternative.c:531:2: note: in expansion of macro 'pr_err'
     531 |  pr_err("XXX IBT: %d\n", end-start);
         |  ^~~~~~
   arch/x86/kernel/alternative.c:531:20: note: format string is defined here
     531 |  pr_err("XXX IBT: %d\n", end-start);
         |                   ~^
         |                    |
         |                    int
         |                   %ld
   cc1: all warnings being treated as errors


vim +5 include/linux/kern_levels.h

314ba3520e513a Joe Perches 2012-07-30  4  
04d2c8c83d0e3a Joe Perches 2012-07-30 @5  #define KERN_SOH	"\001"		/* ASCII Start Of Header */
04d2c8c83d0e3a Joe Perches 2012-07-30  6  #define KERN_SOH_ASCII	'\001'
04d2c8c83d0e3a Joe Perches 2012-07-30  7  

:::::: The code at line 5 was first introduced by commit
:::::: 04d2c8c83d0e3ac5f78aeede51babb3236200112 printk: convert the format for KERN_<LEVEL> to a 2 byte pattern

:::::: TO: Joe Perches <joe@perches.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
