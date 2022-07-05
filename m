Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A450566055
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 02:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbiGEAfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 20:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiGEAfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 20:35:33 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124D4C6F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 17:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656981333; x=1688517333;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nDozPevHOEWYQSMFwkysAlRS+/eWIAYwvSAJ8wqNsGw=;
  b=L2O/mpjKa0YZdbqNEDFGF+vujtjpT6rlx2bTtqdFbn5rRAcfdBbUy3wn
   oDHxAsEXtFKqnPAASZ096FnzIqFlmuD21ut+U4ccMQbTZDSyAkaYb64KY
   kSfKkgIekiP7yOBjSiczpOm/sUd9dBnj+aXweSQ4j6Hcm+TQAB7sVXexC
   BjiEnD5JbMuElvdVkVJlgUsDSDsLLznlsINCGxrMtgcni4EnT1ex+MqDk
   +0CAeermvwAfHfIY0rXXthi3+sNprWBVAWpsH9BHySvEmMU5NFGVbMVYB
   rv8U5m9BCfB4eTcjB0N7m8b17k33OXVUxtltUUeb+swVbZKV33RQIppEt
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="284327030"
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="284327030"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 17:35:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="619550784"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 04 Jul 2022 17:35:31 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8WXK-000IVD-T6;
        Tue, 05 Jul 2022 00:35:30 +0000
Date:   Tue, 5 Jul 2022 08:35:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [arm-integrator:kernel-in-vmalloc-v5.19-rc1 18/35]
 arch/arm64/include/asm/memory.h:357:66: warning: passing argument 1 of
 'virt_to_pfn' makes pointer from integer without a cast
Message-ID: <202207050801.sTfIGPhl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git kernel-in-vmalloc-v5.19-rc1
head:   144435741b0a6f31403d3084103678da3b4f9d11
commit: 8097eb8a345273ee3c268b7f2956ce820b914ef1 [18/35] arm64: memory: Make virt_to_pfn() a static inline
config: arm64-randconfig-r011-20220703 (https://download.01.org/0day-ci/archive/20220705/202207050801.sTfIGPhl-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/commit/?id=8097eb8a345273ee3c268b7f2956ce820b914ef1
        git remote add arm-integrator https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
        git fetch --no-tags arm-integrator kernel-in-vmalloc-v5.19-rc1
        git checkout 8097eb8a345273ee3c268b7f2956ce820b914ef1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash fs/proc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/arm64/include/asm/thread_info.h:17,
                    from include/linux/thread_info.h:60,
                    from arch/arm64/include/asm/preempt.h:6,
                    from include/linux/preempt.h:78,
                    from arch/arm64/include/asm/percpu.h:8,
                    from include/linux/irqflags.h:17,
                    from include/linux/rcupdate.h:26,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/sched/task_stack.h:9,
                    from include/linux/elfcore.h:7,
                    from include/linux/crash_core.h:6,
                    from fs/proc/kcore.c:13:
   fs/proc/kcore.c: In function 'kclist_add_private':
>> arch/arm64/include/asm/memory.h:357:66: warning: passing argument 1 of 'virt_to_pfn' makes pointer from integer without a cast [-Wint-conversion]
     357 |         __is_lm_address(__addr) && pfn_is_map_memory(virt_to_pfn(__addr));      \
         |                                                                  ^~~~~~
         |                                                                  |
         |                                                                  long unsigned int
   fs/proc/kcore.c:203:14: note: in expansion of macro 'virt_addr_valid'
     203 |         if (!virt_addr_valid(ent->addr))
         |              ^~~~~~~~~~~~~~~
   arch/arm64/include/asm/memory.h:312:53: note: expected 'const void *' but argument is of type 'long unsigned int'
     312 | static inline unsigned long virt_to_pfn(const void *kaddr)
         |                                         ~~~~~~~~~~~~^~~~~


vim +/virt_to_pfn +357 arch/arm64/include/asm/memory.h

4f04d8f0054511 Catalin Marinas 2012-03-05  354  
68dd8ef321626f Will Deacon     2019-08-13  355  #define virt_addr_valid(addr)	({					\
91cb2c8b072e00 Catalin Marinas 2021-02-01  356  	__typeof__(addr) __addr = __tag_reset(addr);			\
873ba463914cf4 Mike Rapoport   2021-06-30 @357  	__is_lm_address(__addr) && pfn_is_map_memory(virt_to_pfn(__addr));	\
68dd8ef321626f Will Deacon     2019-08-13  358  })
4f04d8f0054511 Catalin Marinas 2012-03-05  359  

:::::: The code at line 357 was first introduced by commit
:::::: 873ba463914cf484371cba06959d320f9d3121ca arm64: decouple check whether pfn is in linear map from pfn_valid()

:::::: TO: Mike Rapoport <rppt@linux.ibm.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
