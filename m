Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C404DE55B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 04:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241919AbiCSDkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 23:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbiCSDkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 23:40:22 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145A8326F7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 20:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647661141; x=1679197141;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gbksJuruGm3R4TRFQ5BY7t+Nib4XGDZNhrWQ48KAOQo=;
  b=MqkR/blR601KwUuo6vi/lFYzKx5BHpNKFVTaC7v+fFCKqeFI+yBKrW7G
   KFe28rAQGo5LWFbyVLt1qrixgvgOso23hTEgQarPuCZtaCzUpEAnXk4/f
   hYP8xo3sATD7rda4RSQVKfNmff0B51cZ3ZUbQWDRGW5Bw+L8wloYNrLAP
   E//cZIU+AR7PeoEBZhMceldGnOf2NMGCHUMdech6R4Jyj8EaKkqKMKoXd
   urzta6oOm/vQrmnDiZSxs6oQrjVp/9Ied1b2gDX6+LdgQPbB25YzDfoQu
   AFbRiNv55rGKTrxZ1wyG+bVktgYW+vvTwi/cHKbmzv5JjTp2AfU/gHICI
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="256993885"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="256993885"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 20:39:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="647752882"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 18 Mar 2022 20:38:59 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nVPve-000FUM-64; Sat, 19 Mar 2022 03:38:58 +0000
Date:   Sat, 19 Mar 2022 11:38:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Helge Deller <deller@gmx.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [deller-parisc:for-next 23/24] include/linux/jump_label.h:266:16:
 error: implicit declaration of function 'atomic_read'
Message-ID: <202203191125.4vT2F6La-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git for-next
head:   ca3ee5ad86cc1b9553d5bd6878957ad8c79dfb4a
commit: 0acfd47aee46a4dc7aedcc6470d52c35bf0a836c [23/24] parisc: Convert parisc_requires_coherency() to static branch
config: parisc-defconfig (https://download.01.org/0day-ci/archive/20220319/202203191125.4vT2F6La-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git/commit/?id=0acfd47aee46a4dc7aedcc6470d52c35bf0a836c
        git remote add deller-parisc https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git
        git fetch --no-tags deller-parisc for-next
        git checkout 0acfd47aee46a4dc7aedcc6470d52c35bf0a836c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from arch/parisc/include/asm/processor.h:14,
                    from arch/parisc/include/asm/spinlock.h:7,
                    from arch/parisc/include/asm/atomic.h:22,
                    from include/linux/atomic.h:7,
                    from arch/parisc/include/asm/bitops.h:13,
                    from include/linux/bitops.h:33,
                    from include/linux/kernel.h:22,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
   include/linux/jump_label.h: In function 'static_key_count':
>> include/linux/jump_label.h:266:16: error: implicit declaration of function 'atomic_read' [-Werror=implicit-function-declaration]
     266 |         return atomic_read(&key->enabled);
         |                ^~~~~~~~~~~
   In file included from arch/parisc/include/asm/processor.h:14,
                    from arch/parisc/include/asm/spinlock.h:7,
                    from arch/parisc/include/asm/atomic.h:22,
                    from include/linux/atomic.h:7,
                    from arch/parisc/include/asm/bitops.h:13,
                    from include/linux/bitops.h:33,
                    from include/linux/kernel.h:22,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
   include/linux/jump_label.h: In function 'static_key_slow_inc':
>> include/linux/jump_label.h:81:35: error: implicit declaration of function 'WARN' [-Werror=implicit-function-declaration]
      81 | #define STATIC_KEY_CHECK_USE(key) WARN(!static_key_initialized,               \
         |                                   ^~~~
   include/linux/jump_label.h:290:9: note: in expansion of macro 'STATIC_KEY_CHECK_USE'
     290 |         STATIC_KEY_CHECK_USE(key);
         |         ^~~~~~~~~~~~~~~~~~~~
   In file included from arch/parisc/include/asm/processor.h:14,
                    from arch/parisc/include/asm/spinlock.h:7,
                    from arch/parisc/include/asm/atomic.h:22,
                    from include/linux/atomic.h:7,
                    from arch/parisc/include/asm/bitops.h:13,
                    from include/linux/bitops.h:33,
                    from include/linux/kernel.h:22,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
>> include/linux/jump_label.h:291:9: error: implicit declaration of function 'atomic_inc' [-Werror=implicit-function-declaration]
     291 |         atomic_inc(&key->enabled);
         |         ^~~~~~~~~~
   include/linux/jump_label.h: In function 'static_key_slow_dec':
>> include/linux/jump_label.h:297:9: error: implicit declaration of function 'atomic_dec' [-Werror=implicit-function-declaration]
     297 |         atomic_dec(&key->enabled);
         |         ^~~~~~~~~~
   include/linux/jump_label.h: In function 'static_key_enable':
>> include/linux/jump_label.h:321:17: error: implicit declaration of function 'WARN_ON_ONCE' [-Werror=implicit-function-declaration]
     321 |                 WARN_ON_ONCE(atomic_read(&key->enabled) != 1);
         |                 ^~~~~~~~~~~~
>> include/linux/jump_label.h:324:9: error: implicit declaration of function 'atomic_set' [-Werror=implicit-function-declaration]
     324 |         atomic_set(&key->enabled, 1);
         |         ^~~~~~~~~~
   In file included from include/linux/atomic.h:82,
                    from arch/parisc/include/asm/bitops.h:13,
                    from include/linux/bitops.h:33,
                    from include/linux/kernel.h:22,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
   include/linux/atomic/atomic-instrumented.h: At top level:
>> include/linux/atomic/atomic-instrumented.h:25:1: error: static declaration of 'atomic_read' follows non-static declaration
      25 | atomic_read(const atomic_t *v)
         | ^~~~~~~~~~~
   In file included from arch/parisc/include/asm/processor.h:14,
                    from arch/parisc/include/asm/spinlock.h:7,
                    from arch/parisc/include/asm/atomic.h:22,
                    from include/linux/atomic.h:7,
                    from arch/parisc/include/asm/bitops.h:13,
                    from include/linux/bitops.h:33,
                    from include/linux/kernel.h:22,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
   include/linux/jump_label.h:266:16: note: previous implicit declaration of 'atomic_read' with type 'int()'
     266 |         return atomic_read(&key->enabled);
         |                ^~~~~~~~~~~
   In file included from include/linux/atomic.h:82,
                    from arch/parisc/include/asm/bitops.h:13,
                    from include/linux/bitops.h:33,
                    from include/linux/kernel.h:22,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
>> include/linux/atomic/atomic-instrumented.h:39:1: warning: conflicting types for 'atomic_set'; have 'void(atomic_t *, int)'
      39 | atomic_set(atomic_t *v, int i)
         | ^~~~~~~~~~
>> include/linux/atomic/atomic-instrumented.h:39:1: error: static declaration of 'atomic_set' follows non-static declaration
   In file included from arch/parisc/include/asm/processor.h:14,
                    from arch/parisc/include/asm/spinlock.h:7,
                    from arch/parisc/include/asm/atomic.h:22,
                    from include/linux/atomic.h:7,
                    from arch/parisc/include/asm/bitops.h:13,
                    from include/linux/bitops.h:33,
                    from include/linux/kernel.h:22,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
   include/linux/jump_label.h:324:9: note: previous implicit declaration of 'atomic_set' with type 'void(atomic_t *, int)'
     324 |         atomic_set(&key->enabled, 1);
         |         ^~~~~~~~~~
   In file included from include/linux/atomic.h:82,
                    from arch/parisc/include/asm/bitops.h:13,
                    from include/linux/bitops.h:33,
                    from include/linux/kernel.h:22,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
>> include/linux/atomic/atomic-instrumented.h:188:1: warning: conflicting types for 'atomic_inc'; have 'void(atomic_t *)'
     188 | atomic_inc(atomic_t *v)
         | ^~~~~~~~~~
>> include/linux/atomic/atomic-instrumented.h:188:1: error: static declaration of 'atomic_inc' follows non-static declaration
   In file included from arch/parisc/include/asm/processor.h:14,
                    from arch/parisc/include/asm/spinlock.h:7,
                    from arch/parisc/include/asm/atomic.h:22,
                    from include/linux/atomic.h:7,
                    from arch/parisc/include/asm/bitops.h:13,
                    from include/linux/bitops.h:33,
                    from include/linux/kernel.h:22,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
   include/linux/jump_label.h:291:9: note: previous implicit declaration of 'atomic_inc' with type 'void(atomic_t *)'
     291 |         atomic_inc(&key->enabled);
         |         ^~~~~~~~~~
   In file included from include/linux/atomic.h:82,
                    from arch/parisc/include/asm/bitops.h:13,
                    from include/linux/bitops.h:33,
                    from include/linux/kernel.h:22,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
>> include/linux/atomic/atomic-instrumented.h:255:1: warning: conflicting types for 'atomic_dec'; have 'void(atomic_t *)'
     255 | atomic_dec(atomic_t *v)
         | ^~~~~~~~~~
>> include/linux/atomic/atomic-instrumented.h:255:1: error: static declaration of 'atomic_dec' follows non-static declaration
   In file included from arch/parisc/include/asm/processor.h:14,
                    from arch/parisc/include/asm/spinlock.h:7,
                    from arch/parisc/include/asm/atomic.h:22,
                    from include/linux/atomic.h:7,
                    from arch/parisc/include/asm/bitops.h:13,
                    from include/linux/bitops.h:33,
                    from include/linux/kernel.h:22,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
   include/linux/jump_label.h:297:9: note: previous implicit declaration of 'atomic_dec' with type 'void(atomic_t *)'
     297 |         atomic_dec(&key->enabled);
         |         ^~~~~~~~~~
   cc1: some warnings being treated as errors
   make[2]: *** [scripts/Makefile.build:121: kernel/bounds.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1191: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/atomic_read +266 include/linux/jump_label.h

c4b2c0c5f647aa1 Hannes Frederic Sowa       2013-10-19   80  
5cdda5117e125e0 Borislav Petkov            2017-10-18  @81  #define STATIC_KEY_CHECK_USE(key) WARN(!static_key_initialized,		      \
5cdda5117e125e0 Borislav Petkov            2017-10-18   82  				    "%s(): static key '%pS' used before call to jump_label_init()", \
5cdda5117e125e0 Borislav Petkov            2017-10-18   83  				    __func__, (key))
d430d3d7e646eb1 Jason Baron                2011-03-16   84  
e9666d10a5677a4 Masahiro Yamada            2018-12-31   85  #ifdef CONFIG_JUMP_LABEL
d430d3d7e646eb1 Jason Baron                2011-03-16   86  
c5905afb0ee6550 Ingo Molnar                2012-02-24   87  struct static_key {
d430d3d7e646eb1 Jason Baron                2011-03-16   88  	atomic_t enabled;
3821fd35b58dba4 Jason Baron                2017-02-03   89  /*
b17ef2ed624aa7c Steven Rostedt (VMware     2017-03-02   90)  * Note:
b17ef2ed624aa7c Steven Rostedt (VMware     2017-03-02   91)  *   To make anonymous unions work with old compilers, the static
b17ef2ed624aa7c Steven Rostedt (VMware     2017-03-02   92)  *   initialization of them requires brackets. This creates a dependency
b17ef2ed624aa7c Steven Rostedt (VMware     2017-03-02   93)  *   on the order of the struct with the initializers. If any fields
b17ef2ed624aa7c Steven Rostedt (VMware     2017-03-02   94)  *   are added, STATIC_KEY_INIT_TRUE and STATIC_KEY_INIT_FALSE may need
b17ef2ed624aa7c Steven Rostedt (VMware     2017-03-02   95)  *   to be modified.
b17ef2ed624aa7c Steven Rostedt (VMware     2017-03-02   96)  *
3821fd35b58dba4 Jason Baron                2017-02-03   97   * bit 0 => 1 if key is initially true
3821fd35b58dba4 Jason Baron                2017-02-03   98   *	    0 if initially false
3821fd35b58dba4 Jason Baron                2017-02-03   99   * bit 1 => 1 if points to struct static_key_mod
3821fd35b58dba4 Jason Baron                2017-02-03  100   *	    0 if points to struct jump_entry
3821fd35b58dba4 Jason Baron                2017-02-03  101   */
3821fd35b58dba4 Jason Baron                2017-02-03  102  	union {
3821fd35b58dba4 Jason Baron                2017-02-03  103  		unsigned long type;
d430d3d7e646eb1 Jason Baron                2011-03-16  104  		struct jump_entry *entries;
c5905afb0ee6550 Ingo Molnar                2012-02-24  105  		struct static_key_mod *next;
3821fd35b58dba4 Jason Baron                2017-02-03  106  	};
d430d3d7e646eb1 Jason Baron                2011-03-16  107  };
d430d3d7e646eb1 Jason Baron                2011-03-16  108  
ea5e9539abf1258 Mel Gorman                 2014-06-04  109  #else
ea5e9539abf1258 Mel Gorman                 2014-06-04  110  struct static_key {
ea5e9539abf1258 Mel Gorman                 2014-06-04  111  	atomic_t enabled;
ea5e9539abf1258 Mel Gorman                 2014-06-04  112  };
e9666d10a5677a4 Masahiro Yamada            2018-12-31  113  #endif	/* CONFIG_JUMP_LABEL */
c0ccf6f99e3a43b Anton Blanchard            2015-04-09  114  #endif /* __ASSEMBLY__ */
c0ccf6f99e3a43b Anton Blanchard            2015-04-09  115  
e9666d10a5677a4 Masahiro Yamada            2018-12-31  116  #ifdef CONFIG_JUMP_LABEL
c0ccf6f99e3a43b Anton Blanchard            2015-04-09  117  #include <asm/jump_label.h>
9ae033aca8d600e Ard Biesheuvel             2018-09-18  118  
9ae033aca8d600e Ard Biesheuvel             2018-09-18  119  #ifndef __ASSEMBLY__
50ff18ab497aa22 Ard Biesheuvel             2018-09-18  120  #ifdef CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE
50ff18ab497aa22 Ard Biesheuvel             2018-09-18  121  
50ff18ab497aa22 Ard Biesheuvel             2018-09-18  122  struct jump_entry {
50ff18ab497aa22 Ard Biesheuvel             2018-09-18  123  	s32 code;
50ff18ab497aa22 Ard Biesheuvel             2018-09-18  124  	s32 target;
50ff18ab497aa22 Ard Biesheuvel             2018-09-18  125  	long key;	// key may be far away from the core kernel under KASLR
50ff18ab497aa22 Ard Biesheuvel             2018-09-18  126  };
50ff18ab497aa22 Ard Biesheuvel             2018-09-18  127  
50ff18ab497aa22 Ard Biesheuvel             2018-09-18  128  static inline unsigned long jump_entry_code(const struct jump_entry *entry)
50ff18ab497aa22 Ard Biesheuvel             2018-09-18  129  {
50ff18ab497aa22 Ard Biesheuvel             2018-09-18  130  	return (unsigned long)&entry->code + entry->code;
50ff18ab497aa22 Ard Biesheuvel             2018-09-18  131  }
50ff18ab497aa22 Ard Biesheuvel             2018-09-18  132  
50ff18ab497aa22 Ard Biesheuvel             2018-09-18  133  static inline unsigned long jump_entry_target(const struct jump_entry *entry)
50ff18ab497aa22 Ard Biesheuvel             2018-09-18  134  {
50ff18ab497aa22 Ard Biesheuvel             2018-09-18  135  	return (unsigned long)&entry->target + entry->target;
50ff18ab497aa22 Ard Biesheuvel             2018-09-18  136  }
50ff18ab497aa22 Ard Biesheuvel             2018-09-18  137  
50ff18ab497aa22 Ard Biesheuvel             2018-09-18  138  static inline struct static_key *jump_entry_key(const struct jump_entry *entry)
50ff18ab497aa22 Ard Biesheuvel             2018-09-18  139  {
19483677684b6ca Ard Biesheuvel             2018-09-18  140  	long offset = entry->key & ~3L;
50ff18ab497aa22 Ard Biesheuvel             2018-09-18  141  
50ff18ab497aa22 Ard Biesheuvel             2018-09-18  142  	return (struct static_key *)((unsigned long)&entry->key + offset);
50ff18ab497aa22 Ard Biesheuvel             2018-09-18  143  }
50ff18ab497aa22 Ard Biesheuvel             2018-09-18  144  
50ff18ab497aa22 Ard Biesheuvel             2018-09-18  145  #else
9ae033aca8d600e Ard Biesheuvel             2018-09-18  146  
9ae033aca8d600e Ard Biesheuvel             2018-09-18  147  static inline unsigned long jump_entry_code(const struct jump_entry *entry)
9ae033aca8d600e Ard Biesheuvel             2018-09-18  148  {
9ae033aca8d600e Ard Biesheuvel             2018-09-18  149  	return entry->code;
9ae033aca8d600e Ard Biesheuvel             2018-09-18  150  }
9ae033aca8d600e Ard Biesheuvel             2018-09-18  151  
9ae033aca8d600e Ard Biesheuvel             2018-09-18  152  static inline unsigned long jump_entry_target(const struct jump_entry *entry)
9ae033aca8d600e Ard Biesheuvel             2018-09-18  153  {
9ae033aca8d600e Ard Biesheuvel             2018-09-18  154  	return entry->target;
9ae033aca8d600e Ard Biesheuvel             2018-09-18  155  }
9ae033aca8d600e Ard Biesheuvel             2018-09-18  156  
9ae033aca8d600e Ard Biesheuvel             2018-09-18  157  static inline struct static_key *jump_entry_key(const struct jump_entry *entry)
9ae033aca8d600e Ard Biesheuvel             2018-09-18  158  {
19483677684b6ca Ard Biesheuvel             2018-09-18  159  	return (struct static_key *)((unsigned long)entry->key & ~3UL);
9ae033aca8d600e Ard Biesheuvel             2018-09-18  160  }
9ae033aca8d600e Ard Biesheuvel             2018-09-18  161  
50ff18ab497aa22 Ard Biesheuvel             2018-09-18  162  #endif
50ff18ab497aa22 Ard Biesheuvel             2018-09-18  163  
9ae033aca8d600e Ard Biesheuvel             2018-09-18  164  static inline bool jump_entry_is_branch(const struct jump_entry *entry)
9ae033aca8d600e Ard Biesheuvel             2018-09-18  165  {
9ae033aca8d600e Ard Biesheuvel             2018-09-18  166  	return (unsigned long)entry->key & 1UL;
9ae033aca8d600e Ard Biesheuvel             2018-09-18  167  }
9ae033aca8d600e Ard Biesheuvel             2018-09-18  168  
9ae033aca8d600e Ard Biesheuvel             2018-09-18  169  static inline bool jump_entry_is_init(const struct jump_entry *entry)
9ae033aca8d600e Ard Biesheuvel             2018-09-18  170  {
19483677684b6ca Ard Biesheuvel             2018-09-18  171  	return (unsigned long)entry->key & 2UL;
9ae033aca8d600e Ard Biesheuvel             2018-09-18  172  }
9ae033aca8d600e Ard Biesheuvel             2018-09-18  173  
5af0ea293d78c8b Peter Zijlstra             2021-05-06  174  static inline void jump_entry_set_init(struct jump_entry *entry, bool set)
9ae033aca8d600e Ard Biesheuvel             2018-09-18  175  {
5af0ea293d78c8b Peter Zijlstra             2021-05-06  176  	if (set)
19483677684b6ca Ard Biesheuvel             2018-09-18  177  		entry->key |= 2;
5af0ea293d78c8b Peter Zijlstra             2021-05-06  178  	else
5af0ea293d78c8b Peter Zijlstra             2021-05-06  179  		entry->key &= ~2;
9ae033aca8d600e Ard Biesheuvel             2018-09-18  180  }
9ae033aca8d600e Ard Biesheuvel             2018-09-18  181  
fa5e5dc39669b44 Peter Zijlstra             2021-05-06  182  static inline int jump_entry_size(struct jump_entry *entry)
fa5e5dc39669b44 Peter Zijlstra             2021-05-06  183  {
fa5e5dc39669b44 Peter Zijlstra             2021-05-06  184  #ifdef JUMP_LABEL_NOP_SIZE
fa5e5dc39669b44 Peter Zijlstra             2021-05-06  185  	return JUMP_LABEL_NOP_SIZE;
fa5e5dc39669b44 Peter Zijlstra             2021-05-06  186  #else
fa5e5dc39669b44 Peter Zijlstra             2021-05-06  187  	return arch_jump_entry_size(entry);
fa5e5dc39669b44 Peter Zijlstra             2021-05-06  188  #endif
fa5e5dc39669b44 Peter Zijlstra             2021-05-06  189  }
fa5e5dc39669b44 Peter Zijlstra             2021-05-06  190  
9ae033aca8d600e Ard Biesheuvel             2018-09-18  191  #endif
c0ccf6f99e3a43b Anton Blanchard            2015-04-09  192  #endif
c0ccf6f99e3a43b Anton Blanchard            2015-04-09  193  
c0ccf6f99e3a43b Anton Blanchard            2015-04-09  194  #ifndef __ASSEMBLY__
bf5438fca2950b0 Jason Baron                2010-09-17  195  
bf5438fca2950b0 Jason Baron                2010-09-17  196  enum jump_label_type {
76b235c6bcb1606 Peter Zijlstra             2015-07-24  197  	JUMP_LABEL_NOP = 0,
76b235c6bcb1606 Peter Zijlstra             2015-07-24  198  	JUMP_LABEL_JMP,
bf5438fca2950b0 Jason Baron                2010-09-17  199  };
bf5438fca2950b0 Jason Baron                2010-09-17  200  
bf5438fca2950b0 Jason Baron                2010-09-17  201  struct module;
bf5438fca2950b0 Jason Baron                2010-09-17  202  
e9666d10a5677a4 Masahiro Yamada            2018-12-31  203  #ifdef CONFIG_JUMP_LABEL
4c5ea0a9cd02d6a Paolo Bonzini              2016-06-21  204  
a1efb01feca597b Peter Zijlstra             2015-07-24  205  #define JUMP_TYPE_FALSE		0UL
a1efb01feca597b Peter Zijlstra             2015-07-24  206  #define JUMP_TYPE_TRUE		1UL
3821fd35b58dba4 Jason Baron                2017-02-03  207  #define JUMP_TYPE_LINKED	2UL
3821fd35b58dba4 Jason Baron                2017-02-03  208  #define JUMP_TYPE_MASK		3UL
c5905afb0ee6550 Ingo Molnar                2012-02-24  209  
c5905afb0ee6550 Ingo Molnar                2012-02-24  210  static __always_inline bool static_key_false(struct static_key *key)
c5905afb0ee6550 Ingo Molnar                2012-02-24  211  {
11276d5306b8e5b Peter Zijlstra             2015-07-24  212  	return arch_static_branch(key, false);
c5905afb0ee6550 Ingo Molnar                2012-02-24  213  }
d430d3d7e646eb1 Jason Baron                2011-03-16  214  
c5905afb0ee6550 Ingo Molnar                2012-02-24  215  static __always_inline bool static_key_true(struct static_key *key)
c5905afb0ee6550 Ingo Molnar                2012-02-24  216  {
11276d5306b8e5b Peter Zijlstra             2015-07-24  217  	return !arch_static_branch(key, true);
c5905afb0ee6550 Ingo Molnar                2012-02-24  218  }
c5905afb0ee6550 Ingo Molnar                2012-02-24  219  
bf5438fca2950b0 Jason Baron                2010-09-17  220  extern struct jump_entry __start___jump_table[];
bf5438fca2950b0 Jason Baron                2010-09-17  221  extern struct jump_entry __stop___jump_table[];
bf5438fca2950b0 Jason Baron                2010-09-17  222  
97ce2c88f9ad42e Jeremy Fitzhardinge        2011-10-12  223  extern void jump_label_init(void);
91bad2f8d305748 Jason Baron                2010-10-01  224  extern void jump_label_lock(void);
91bad2f8d305748 Jason Baron                2010-10-01  225  extern void jump_label_unlock(void);
bf5438fca2950b0 Jason Baron                2010-09-17  226  extern void arch_jump_label_transform(struct jump_entry *entry,
bf5438fca2950b0 Jason Baron                2010-09-17  227  				      enum jump_label_type type);
20284aa77c0f622 Jeremy Fitzhardinge        2011-10-03  228  extern void arch_jump_label_transform_static(struct jump_entry *entry,
20284aa77c0f622 Jeremy Fitzhardinge        2011-10-03  229  					     enum jump_label_type type);
c2ba8a15f310d91 Daniel Bristot de Oliveira 2019-06-12  230  extern bool arch_jump_label_transform_queue(struct jump_entry *entry,
c2ba8a15f310d91 Daniel Bristot de Oliveira 2019-06-12  231  					    enum jump_label_type type);
c2ba8a15f310d91 Daniel Bristot de Oliveira 2019-06-12  232  extern void arch_jump_label_transform_apply(void);
4c3ef6d79328c0e Jason Baron                2010-09-17  233  extern int jump_label_text_reserved(void *start, void *end);
c5905afb0ee6550 Ingo Molnar                2012-02-24  234  extern void static_key_slow_inc(struct static_key *key);
c5905afb0ee6550 Ingo Molnar                2012-02-24  235  extern void static_key_slow_dec(struct static_key *key);
ce48c146495a1a5 Peter Zijlstra             2018-01-22  236  extern void static_key_slow_inc_cpuslocked(struct static_key *key);
ce48c146495a1a5 Peter Zijlstra             2018-01-22  237  extern void static_key_slow_dec_cpuslocked(struct static_key *key);
d430d3d7e646eb1 Jason Baron                2011-03-16  238  extern void jump_label_apply_nops(struct module *mod);
1f69bf9c6137602 Jason Baron                2016-08-03  239  extern int static_key_count(struct static_key *key);
1f69bf9c6137602 Jason Baron                2016-08-03  240  extern void static_key_enable(struct static_key *key);
1f69bf9c6137602 Jason Baron                2016-08-03  241  extern void static_key_disable(struct static_key *key);
5a40527f8f07985 Marc Zyngier               2017-08-01  242  extern void static_key_enable_cpuslocked(struct static_key *key);
5a40527f8f07985 Marc Zyngier               2017-08-01  243  extern void static_key_disable_cpuslocked(struct static_key *key);
c5905afb0ee6550 Ingo Molnar                2012-02-24  244  
1f69bf9c6137602 Jason Baron                2016-08-03  245  /*
1f69bf9c6137602 Jason Baron                2016-08-03  246   * We should be using ATOMIC_INIT() for initializing .enabled, but
1f69bf9c6137602 Jason Baron                2016-08-03  247   * the inclusion of atomic.h is problematic for inclusion of jump_label.h
1f69bf9c6137602 Jason Baron                2016-08-03  248   * in 'low-level' headers. Thus, we are initializing .enabled with a
1f69bf9c6137602 Jason Baron                2016-08-03  249   * raw value, but have added a BUILD_BUG_ON() to catch any issues in
1f69bf9c6137602 Jason Baron                2016-08-03  250   * jump_label_init() see: kernel/jump_label.c.
1f69bf9c6137602 Jason Baron                2016-08-03  251   */
11276d5306b8e5b Peter Zijlstra             2015-07-24  252  #define STATIC_KEY_INIT_TRUE					\
1f69bf9c6137602 Jason Baron                2016-08-03  253  	{ .enabled = { 1 },					\
cd8d860dcce906c Boris Ostrovsky            2017-02-28  254  	  { .entries = (void *)JUMP_TYPE_TRUE } }
11276d5306b8e5b Peter Zijlstra             2015-07-24  255  #define STATIC_KEY_INIT_FALSE					\
1f69bf9c6137602 Jason Baron                2016-08-03  256  	{ .enabled = { 0 },					\
cd8d860dcce906c Boris Ostrovsky            2017-02-28  257  	  { .entries = (void *)JUMP_TYPE_FALSE } }
bf5438fca2950b0 Jason Baron                2010-09-17  258  
e9666d10a5677a4 Masahiro Yamada            2018-12-31  259  #else  /* !CONFIG_JUMP_LABEL */
bf5438fca2950b0 Jason Baron                2010-09-17  260  
1f69bf9c6137602 Jason Baron                2016-08-03  261  #include <linux/atomic.h>
1f69bf9c6137602 Jason Baron                2016-08-03  262  #include <linux/bug.h>
1f69bf9c6137602 Jason Baron                2016-08-03  263  
4c5ea0a9cd02d6a Paolo Bonzini              2016-06-21  264  static inline int static_key_count(struct static_key *key)
4c5ea0a9cd02d6a Paolo Bonzini              2016-06-21  265  {
4c5ea0a9cd02d6a Paolo Bonzini              2016-06-21 @266  	return atomic_read(&key->enabled);
4c5ea0a9cd02d6a Paolo Bonzini              2016-06-21  267  }
4c5ea0a9cd02d6a Paolo Bonzini              2016-06-21  268  
97ce2c88f9ad42e Jeremy Fitzhardinge        2011-10-12  269  static __always_inline void jump_label_init(void)
97ce2c88f9ad42e Jeremy Fitzhardinge        2011-10-12  270  {
c4b2c0c5f647aa1 Hannes Frederic Sowa       2013-10-19  271  	static_key_initialized = true;
97ce2c88f9ad42e Jeremy Fitzhardinge        2011-10-12  272  }
97ce2c88f9ad42e Jeremy Fitzhardinge        2011-10-12  273  
c5905afb0ee6550 Ingo Molnar                2012-02-24  274  static __always_inline bool static_key_false(struct static_key *key)
c5905afb0ee6550 Ingo Molnar                2012-02-24  275  {
2f0df49c89acaa5 Steven Rostedt (VMware     2020-12-11  276) 	if (unlikely_notrace(static_key_count(key) > 0))
c5905afb0ee6550 Ingo Molnar                2012-02-24  277  		return true;
c5905afb0ee6550 Ingo Molnar                2012-02-24  278  	return false;
c5905afb0ee6550 Ingo Molnar                2012-02-24  279  }
c5905afb0ee6550 Ingo Molnar                2012-02-24  280  
c5905afb0ee6550 Ingo Molnar                2012-02-24  281  static __always_inline bool static_key_true(struct static_key *key)
d430d3d7e646eb1 Jason Baron                2011-03-16  282  {
2f0df49c89acaa5 Steven Rostedt (VMware     2020-12-11  283) 	if (likely_notrace(static_key_count(key) > 0))
d430d3d7e646eb1 Jason Baron                2011-03-16  284  		return true;
d430d3d7e646eb1 Jason Baron                2011-03-16  285  	return false;
d430d3d7e646eb1 Jason Baron                2011-03-16  286  }
bf5438fca2950b0 Jason Baron                2010-09-17  287  
c5905afb0ee6550 Ingo Molnar                2012-02-24  288  static inline void static_key_slow_inc(struct static_key *key)
d430d3d7e646eb1 Jason Baron                2011-03-16  289  {
5cdda5117e125e0 Borislav Petkov            2017-10-18  290  	STATIC_KEY_CHECK_USE(key);
d430d3d7e646eb1 Jason Baron                2011-03-16 @291  	atomic_inc(&key->enabled);
d430d3d7e646eb1 Jason Baron                2011-03-16  292  }
bf5438fca2950b0 Jason Baron                2010-09-17  293  
c5905afb0ee6550 Ingo Molnar                2012-02-24  294  static inline void static_key_slow_dec(struct static_key *key)
bf5438fca2950b0 Jason Baron                2010-09-17  295  {
5cdda5117e125e0 Borislav Petkov            2017-10-18  296  	STATIC_KEY_CHECK_USE(key);
d430d3d7e646eb1 Jason Baron                2011-03-16 @297  	atomic_dec(&key->enabled);
bf5438fca2950b0 Jason Baron                2010-09-17  298  }
bf5438fca2950b0 Jason Baron                2010-09-17  299  
ce48c146495a1a5 Peter Zijlstra             2018-01-22  300  #define static_key_slow_inc_cpuslocked(key) static_key_slow_inc(key)
ce48c146495a1a5 Peter Zijlstra             2018-01-22  301  #define static_key_slow_dec_cpuslocked(key) static_key_slow_dec(key)
ce48c146495a1a5 Peter Zijlstra             2018-01-22  302  
4c3ef6d79328c0e Jason Baron                2010-09-17  303  static inline int jump_label_text_reserved(void *start, void *end)
4c3ef6d79328c0e Jason Baron                2010-09-17  304  {
4c3ef6d79328c0e Jason Baron                2010-09-17  305  	return 0;
4c3ef6d79328c0e Jason Baron                2010-09-17  306  }
4c3ef6d79328c0e Jason Baron                2010-09-17  307  
91bad2f8d305748 Jason Baron                2010-10-01  308  static inline void jump_label_lock(void) {}
91bad2f8d305748 Jason Baron                2010-10-01  309  static inline void jump_label_unlock(void) {}
91bad2f8d305748 Jason Baron                2010-10-01  310  
d430d3d7e646eb1 Jason Baron                2011-03-16  311  static inline int jump_label_apply_nops(struct module *mod)
d430d3d7e646eb1 Jason Baron                2011-03-16  312  {
d430d3d7e646eb1 Jason Baron                2011-03-16  313  	return 0;
d430d3d7e646eb1 Jason Baron                2011-03-16  314  }
b202952075f6260 Gleb Natapov               2011-11-27  315  
e33886b38cc82a9 Peter Zijlstra             2015-07-24  316  static inline void static_key_enable(struct static_key *key)
e33886b38cc82a9 Peter Zijlstra             2015-07-24  317  {
5cdda5117e125e0 Borislav Petkov            2017-10-18  318  	STATIC_KEY_CHECK_USE(key);
e33886b38cc82a9 Peter Zijlstra             2015-07-24  319  
1dbb6704de91b16 Paolo Bonzini              2017-08-01  320  	if (atomic_read(&key->enabled) != 0) {
1dbb6704de91b16 Paolo Bonzini              2017-08-01 @321  		WARN_ON_ONCE(atomic_read(&key->enabled) != 1);
1dbb6704de91b16 Paolo Bonzini              2017-08-01  322  		return;
1dbb6704de91b16 Paolo Bonzini              2017-08-01  323  	}
1dbb6704de91b16 Paolo Bonzini              2017-08-01 @324  	atomic_set(&key->enabled, 1);
e33886b38cc82a9 Peter Zijlstra             2015-07-24  325  }
e33886b38cc82a9 Peter Zijlstra             2015-07-24  326  

:::::: The code at line 266 was first introduced by commit
:::::: 4c5ea0a9cd02d6aa8adc86e100b2a4cff8d614ff locking/static_key: Fix concurrent static_key_slow_inc()

:::::: TO: Paolo Bonzini <pbonzini@redhat.com>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
