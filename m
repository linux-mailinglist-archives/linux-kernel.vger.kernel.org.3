Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6628D4C55B0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 12:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbiBZLm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 06:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiBZLmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 06:42:25 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A557F244A3E
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 03:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645875711; x=1677411711;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RgmcXJbJ/Ccx3swLS6YILi+XqKDeBSb5Ta9hU0rJz0w=;
  b=GdFpL372HYQNsRy0MoL49Ky6Q8GAReeBVuEtIOZBgNavhvNhatrRQnHe
   RuesJ41gSz7YxUXJ6ZMn5ZFpNW80uC7U9u5OsO/2m9yjzFUaVIUnkZyGg
   YmIfu/V4tulkRsszGpByOYPqcPdACwooCh1EoAnP9paDQANCA3iaCl+w5
   XF9vZLuz7YuxEQVrCIzdcSxt02M7RCpvzhyRrGj6uZO+CIF4htfo0Yl7z
   B+P5uGNrg6Le0RmjBhOF31EC26jQk9+mAndZYhALeaXLxfbmcY9n6fMoR
   yu6Xz2gH5ywG4Gz+Q28ocEwBfv28gjjseJ8RWIoFvTgNyd3+gCHngDBZD
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10269"; a="251485062"
X-IronPort-AV: E=Sophos;i="5.90,139,1643702400"; 
   d="scan'208";a="251485062"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2022 03:41:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,139,1643702400"; 
   d="scan'208";a="640404067"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 26 Feb 2022 03:41:50 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNvSP-0005QM-AH; Sat, 26 Feb 2022 11:41:49 +0000
Date:   Sat, 26 Feb 2022 19:41:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:x86/wip.ibt 17/47]
 arch/x86/include/asm/segment.h:278:39: error: 'HAS_KERNEL_IBT' undeclared
 here (not in a function)
Message-ID: <202202261948.uPVLnDCm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/wip.ibt
head:   db78c0938593e12efacf2c1821700b6f39754245
commit: 286a983c759d72da5b39c444d8531c7f1135d151 [17/47] x86/ibt,entry: Sprinkle ENDBR dust
config: i386-debian-10.3 (https://download.01.org/0day-ci/archive/20220226/202202261948.uPVLnDCm-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=286a983c759d72da5b39c444d8531c7f1135d151
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue x86/wip.ibt
        git checkout 286a983c759d72da5b39c444d8531c7f1135d151
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/x86/include/asm/ptrace.h:5,
                    from arch/x86/include/asm/math_emu.h:5,
                    from arch/x86/include/asm/processor.h:13,
                    from arch/x86/include/asm/cpufeature.h:5,
                    from arch/x86/include/asm/thread_info.h:53,
                    from include/linux/thread_info.h:60,
                    from arch/x86/include/asm/preempt.h:7,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from include/linux/crypto.h:20,
                    from arch/x86/kernel/asm-offsets.c:9:
>> arch/x86/include/asm/segment.h:278:39: error: 'HAS_KERNEL_IBT' undeclared here (not in a function)
     278 | #define EARLY_IDT_HANDLER_SIZE (9 + 4*HAS_KERNEL_IBT)
         |                                       ^~~~~~~~~~~~~~
   arch/x86/include/asm/segment.h:290:66: note: in expansion of macro 'EARLY_IDT_HANDLER_SIZE'
     290 | extern const char early_idt_handler_array[NUM_EXCEPTION_VECTORS][EARLY_IDT_HANDLER_SIZE];
         |                                                                  ^~~~~~~~~~~~~~~~~~~~~~
   make[2]: *** [scripts/Makefile.build:121: arch/x86/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1191: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/HAS_KERNEL_IBT +278 arch/x86/include/asm/segment.h

   270	
   271	/*
   272	 * early_idt_handler_array is an array of entry points referenced in the
   273	 * early IDT.  For simplicity, it's a real array with one entry point
   274	 * every nine bytes.  That leaves room for an optional 'push $0' if the
   275	 * vector has no error code (two bytes), a 'push $vector_number' (two
   276	 * bytes), and a jump to the common entry code (up to five bytes).
   277	 */
 > 278	#define EARLY_IDT_HANDLER_SIZE (9 + 4*HAS_KERNEL_IBT)
   279	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
