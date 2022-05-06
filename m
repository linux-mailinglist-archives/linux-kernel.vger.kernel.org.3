Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0BA51D098
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 07:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389098AbiEFF2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 01:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389093AbiEFF2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 01:28:30 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D965DA62
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 22:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651814689; x=1683350689;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WFTQCIQFzhCfgbpfxyHS/3Le+7tIInlYKeVClPpREp8=;
  b=BMMIbeTwy5DVHOqHFewMoXXw8kXTnD0xXvYy5ukc8qESp52L+T93SbUg
   rvq/9dVlRSdNszdZlDIRRAOS4LAoYvxjn97DZ1OpR5WuB8s7DttL9s2fO
   e7cr+wow9cn+foK/KXFsMqJSniGfrc0Oq2Fb9d4NJL0vhnC60YgqqOQjU
   Y4cHUYMqYRM7de9cUehC2EL42SOJQm0WK74CoqrYgHCtq/uuHc4ooeTyo
   3jhCWaGjFiKW4HpIKJr8vfm4zdyv6xTLn/hEG3oECHWLBhPacrjfGPXhB
   UkxiEJ7+z3QkkJM6iRDiwYfc1DAEJfpXRJnmApOwZmdtm1Sv3KyhN8pqK
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="267196306"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="267196306"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 22:24:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="812178405"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 05 May 2022 22:24:46 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmqSM-000DA4-9h;
        Fri, 06 May 2022 05:24:46 +0000
Date:   Fri, 6 May 2022 13:23:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tom <support@vamrs.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>
Subject: [esmil:visionfive 22/55]
 drivers/soc/sifive/sifive_l2_cache.c:142:19: warning: result of comparison
 of constant 36507222016 with expression of type 'unsigned long' is always
 false
Message-ID: <202205061342.dVMH03HG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/esmil/linux visionfive
head:   f568ecc24aebec8ce1c59b86f2a85098675a4091
commit: 7fa12d2f832a42a37ff0d8f4dd7569cee4b0b82f [22/55] sifive/sifive_l2_cache: Add sifive_l2_flush64_range function
config: riscv-randconfig-r031-20220505 (https://download.01.org/0day-ci/archive/20220506/202205061342.dVMH03HG-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5e004fb787698440a387750db7f8028e7cb14cfc)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/esmil/linux/commit/7fa12d2f832a42a37ff0d8f4dd7569cee4b0b82f
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout 7fa12d2f832a42a37ff0d8f4dd7569cee4b0b82f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/soc/sifive/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/soc/sifive/sifive_l2_cache.c:152:3: error: call to undeclared function 'writeq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   writeq(line, l2_base + SIFIVE_L2_FLUSH64);
                   ^
>> drivers/soc/sifive/sifive_l2_cache.c:142:19: warning: result of comparison of constant 36507222016 with expression of type 'unsigned long' is always false [-Wtautological-constant-out-of-range-compare]
              (start + len) > (CONFIG_SIFIVE_L2_FLUSH_START +
              ~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                              ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:86: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                                       ~~~~~~~~~~~~~~~~~^~~~~
   include/linux/compiler.h:69:3: note: expanded from macro '__trace_if_value'
           (cond) ?                                        \
            ^~~~
>> drivers/soc/sifive/sifive_l2_cache.c:142:19: warning: result of comparison of constant 36507222016 with expression of type 'unsigned long' is always false [-Wtautological-constant-out-of-range-compare]
              (start + len) > (CONFIG_SIFIVE_L2_FLUSH_START +
              ~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                              ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:52: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                      ^~~~
>> drivers/soc/sifive/sifive_l2_cache.c:142:19: warning: result of comparison of constant 36507222016 with expression of type 'unsigned long' is always false [-Wtautological-constant-out-of-range-compare]
              (start + len) > (CONFIG_SIFIVE_L2_FLUSH_START +
              ~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                              ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:61: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                               ^~~~
   3 warnings and 1 error generated.


vim +142 drivers/soc/sifive/sifive_l2_cache.c

   123	
   124	#ifdef CONFIG_SIFIVE_L2_FLUSH
   125	void sifive_l2_flush64_range(unsigned long start, unsigned long len)
   126	{
   127		unsigned long line;
   128	
   129		if(!l2_base) {
   130			pr_warn("L2CACHE: base addr invalid, skipping flush\n");
   131			return;
   132		}
   133	
   134		/* TODO: if (len == 0), skipping flush or going on? */
   135		if(!len) {
   136			pr_debug("L2CACHE: flush64 range @ 0x%lx(len:0)\n", start);
   137			return;
   138		}
   139	
   140		/* make sure the address is in the range */
   141		if(start < CONFIG_SIFIVE_L2_FLUSH_START ||
 > 142		   (start + len) > (CONFIG_SIFIVE_L2_FLUSH_START +
   143				     CONFIG_SIFIVE_L2_FLUSH_SIZE)) {
   144			pr_warn("L2CACHE: flush64 out of range: %lx(%lx), skip flush\n",
   145				start, len);
   146			return;
   147		}
   148	
   149		mb();	/* sync */
   150		for (line = start; line < start + len;
   151		     line += SIFIVE_L2_FLUSH64_LINE_LEN) {
   152			writeq(line, l2_base + SIFIVE_L2_FLUSH64);
   153			mb();
   154		}
   155	}
   156	EXPORT_SYMBOL_GPL(sifive_l2_flush64_range);
   157	#endif
   158	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
