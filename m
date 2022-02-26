Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7B74C5861
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 22:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiBZVsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 16:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiBZVsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 16:48:46 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F25149BA6
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 13:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645912091; x=1677448091;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5GzrvRSV8VfF8ky2azOLWZfrlIDuV8KRI7mlNdZaeZg=;
  b=WHLC6hx0AlqjKaIVoCxaG9jzLjUL3M7L2bE8ifZDUW24A8T9af4egOFn
   DQSAMmkueSViMWHm/su3UCvclmbCnjFK4j6/QTBMOungQq4H0bZT/wyMT
   vLM2Ini+pEt7BWGUL6fePqQJ6fOUR8qulgQ20bWI0IOsXdTSMfyiV1u7Y
   7vhpONuXElHbPleaPPeLhUOcRqMv2tIhv1QDD17n94ezKgtCd93Fgaixk
   8YO6XgP/uU3PPFIaUN9n3f15yczK2YV7zDUpUkshF/WcIraaa8vqOVuMw
   RFmP1IcBkMhU9yJ7mFeU/MkxGC/+Wf09FYAItOTHSaHEgZCNlOmDqk6OX
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10270"; a="236191168"
X-IronPort-AV: E=Sophos;i="5.90,140,1643702400"; 
   d="scan'208";a="236191168"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2022 13:48:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,140,1643702400"; 
   d="scan'208";a="640487488"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 26 Feb 2022 13:48:09 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nO4vA-0005yz-KF; Sat, 26 Feb 2022 21:48:08 +0000
Date:   Sun, 27 Feb 2022 05:47:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kees:for-next/hardening 8/8] mm/usercopy.c:61:29: error:
 'current_stack_pointer' undeclared; did you mean
 'current_user_stack_pointer'?
Message-ID: <202202270550.5SPauZxm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
head:   3dd3738f624d9cf94b96e023880d1ec69c21327e
commit: 3dd3738f624d9cf94b96e023880d1ec69c21327e [8/8] m68k: Implement "current_stack_pointer"
config: m68k-sun3x_defconfig (https://download.01.org/0day-ci/archive/20220227/202202270550.5SPauZxm-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?id=3dd3738f624d9cf94b96e023880d1ec69c21327e
        git remote add kees https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
        git fetch --no-tags kees for-next/hardening
        git checkout 3dd3738f624d9cf94b96e023880d1ec69c21327e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mm/usercopy.c: In function 'check_stack_object':
>> mm/usercopy.c:61:29: error: 'current_stack_pointer' undeclared (first use in this function); did you mean 'current_user_stack_pointer'?
      61 |                 if ((void *)current_stack_pointer < obj + len)
         |                             ^~~~~~~~~~~~~~~~~~~~~
         |                             current_user_stack_pointer
   mm/usercopy.c:61:29: note: each undeclared identifier is reported only once for each function it appears in
   mm/usercopy.c: In function '__check_object_size':
   mm/usercopy.c:297:47: error: 'current_stack_pointer' undeclared (first use in this function); did you mean 'current_user_stack_pointer'?
     297 |                                 ptr - (void *)current_stack_pointer :
         |                                               ^~~~~~~~~~~~~~~~~~~~~
         |                                               current_user_stack_pointer


vim +61 mm/usercopy.c

f5509cc18daa7f Kees Cook    2016-06-07  24  
f5509cc18daa7f Kees Cook    2016-06-07  25  /*
f5509cc18daa7f Kees Cook    2016-06-07  26   * Checks if a given pointer and length is contained by the current
f5509cc18daa7f Kees Cook    2016-06-07  27   * stack frame (if possible).
f5509cc18daa7f Kees Cook    2016-06-07  28   *
f5509cc18daa7f Kees Cook    2016-06-07  29   * Returns:
f5509cc18daa7f Kees Cook    2016-06-07  30   *	NOT_STACK: not at all on the stack
f5509cc18daa7f Kees Cook    2016-06-07  31   *	GOOD_FRAME: fully within a valid stack frame
2792d84e6da5e0 Kees Cook    2022-02-16  32   *	GOOD_STACK: within the current stack (when can't frame-check exactly)
f5509cc18daa7f Kees Cook    2016-06-07  33   *	BAD_STACK: error condition (invalid stack position or bad stack frame)
f5509cc18daa7f Kees Cook    2016-06-07  34   */
f5509cc18daa7f Kees Cook    2016-06-07  35  static noinline int check_stack_object(const void *obj, unsigned long len)
f5509cc18daa7f Kees Cook    2016-06-07  36  {
f5509cc18daa7f Kees Cook    2016-06-07  37  	const void * const stack = task_stack_page(current);
f5509cc18daa7f Kees Cook    2016-06-07  38  	const void * const stackend = stack + THREAD_SIZE;
f5509cc18daa7f Kees Cook    2016-06-07  39  	int ret;
f5509cc18daa7f Kees Cook    2016-06-07  40  
f5509cc18daa7f Kees Cook    2016-06-07  41  	/* Object is not on the stack at all. */
f5509cc18daa7f Kees Cook    2016-06-07  42  	if (obj + len <= stack || stackend <= obj)
f5509cc18daa7f Kees Cook    2016-06-07  43  		return NOT_STACK;
f5509cc18daa7f Kees Cook    2016-06-07  44  
f5509cc18daa7f Kees Cook    2016-06-07  45  	/*
f5509cc18daa7f Kees Cook    2016-06-07  46  	 * Reject: object partially overlaps the stack (passing the
5ce1be0e40fe64 Randy Dunlap 2020-08-11  47  	 * check above means at least one end is within the stack,
f5509cc18daa7f Kees Cook    2016-06-07  48  	 * so if this check fails, the other end is outside the stack).
f5509cc18daa7f Kees Cook    2016-06-07  49  	 */
f5509cc18daa7f Kees Cook    2016-06-07  50  	if (obj < stack || stackend < obj + len)
f5509cc18daa7f Kees Cook    2016-06-07  51  		return BAD_STACK;
f5509cc18daa7f Kees Cook    2016-06-07  52  
f5509cc18daa7f Kees Cook    2016-06-07  53  	/* Check if object is safely within a valid frame. */
f5509cc18daa7f Kees Cook    2016-06-07  54  	ret = arch_within_stack_frames(stack, stackend, obj, len);
f5509cc18daa7f Kees Cook    2016-06-07  55  	if (ret)
f5509cc18daa7f Kees Cook    2016-06-07  56  		return ret;
f5509cc18daa7f Kees Cook    2016-06-07  57  
2792d84e6da5e0 Kees Cook    2022-02-16  58  	/* Finally, check stack depth if possible. */
2792d84e6da5e0 Kees Cook    2022-02-16  59  #ifdef CONFIG_ARCH_HAS_CURRENT_STACK_POINTER
2792d84e6da5e0 Kees Cook    2022-02-16  60  	if (IS_ENABLED(CONFIG_STACK_GROWSUP)) {
2792d84e6da5e0 Kees Cook    2022-02-16 @61  		if ((void *)current_stack_pointer < obj + len)
2792d84e6da5e0 Kees Cook    2022-02-16  62  			return BAD_STACK;
2792d84e6da5e0 Kees Cook    2022-02-16  63  	} else {
2792d84e6da5e0 Kees Cook    2022-02-16  64  		if (obj < (void *)current_stack_pointer)
2792d84e6da5e0 Kees Cook    2022-02-16  65  			return BAD_STACK;
2792d84e6da5e0 Kees Cook    2022-02-16  66  	}
2792d84e6da5e0 Kees Cook    2022-02-16  67  #endif
2792d84e6da5e0 Kees Cook    2022-02-16  68  
f5509cc18daa7f Kees Cook    2016-06-07  69  	return GOOD_STACK;
f5509cc18daa7f Kees Cook    2016-06-07  70  }
f5509cc18daa7f Kees Cook    2016-06-07  71  

:::::: The code at line 61 was first introduced by commit
:::::: 2792d84e6da5e0fd7d3b22fd70bc69b7ee263609 usercopy: Check valid lifetime via stack depth

:::::: TO: Kees Cook <keescook@chromium.org>
:::::: CC: Kees Cook <keescook@chromium.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
