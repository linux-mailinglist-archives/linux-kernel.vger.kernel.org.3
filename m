Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6704DC40D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 11:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbiCQKgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 06:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbiCQKgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 06:36:32 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E022613F8DA
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 03:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647513315; x=1679049315;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2zHfKZKPoHZZnn4wJvN+JDaLnv8NiPFqvhCKQhrKxPQ=;
  b=kVZLPhU0aoYWoG8cxek4KfpTOICObKv6lh8yRhK+7QlHYl0Y7Zqs/Oh+
   /YUK2Fxz1lI67OjrxPq7eq9qjBaRbZTtp+Jx2y736K/YPb+hO0uiA8Cdv
   gWB/MHW/ymys0cTgVZSCvA+MkwM+Hmpg+Q9bBQRdOZHD29DID7JTY4o2+
   AUvwGBcyLyw7OePcZo00lEu4jOj9ttSBjm3zu8iaW2eSEIm8zXWGNKI0O
   2nowsT13zhu42rM/px3LWTJyXzXsAxP5fbrJkNJfXFVHOoHSwYkgWNqN4
   o7Twv6iOqeSB5DgC61/CgCH32eWISMfUa/JnDEZOa1uaeQU+rG/JsOv1w
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="254391900"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="254391900"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 03:35:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="541321853"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 17 Mar 2022 03:35:14 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUnTN-000Dao-9p; Thu, 17 Mar 2022 10:35:13 +0000
Date:   Thu, 17 Mar 2022 18:34:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 111/2308] init/main.c:886:13: warning: no
 previous prototype for function 'init_per_task_early'
Message-ID: <202203171800.i5UHGBco-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   ef90a8d1de7ff54bfd0fcfe6371c20f544b14d6d
commit: 3e2fb1b92a2026ae3608f3d77d302217390dee27 [111/2308] headers/deps: cpusets: Move task_struct::mems_allowed_seq to per_task()
config: x86_64-randconfig-a001 (https://download.01.org/0day-ci/archive/20220317/202203171800.i5UHGBco-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6ec1e3d798f8eab43fb3a91028c6ab04e115fcb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=3e2fb1b92a2026ae3608f3d77d302217390dee27
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 3e2fb1b92a2026ae3608f3d77d302217390dee27
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   init/main.c:782:20: warning: no previous prototype for function 'mem_encrypt_init' [-Wmissing-prototypes]
   void __init __weak mem_encrypt_init(void) { }
                      ^
   init/main.c:782:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init __weak mem_encrypt_init(void) { }
   ^
   static 
>> init/main.c:886:13: warning: no previous prototype for function 'init_per_task_early' [-Wmissing-prototypes]
   void __init init_per_task_early(void)
               ^
   init/main.c:886:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init init_per_task_early(void)
   ^
   static 
   2 warnings generated.


vim +/init_per_task_early +886 init/main.c

   781	
 > 782	void __init __weak mem_encrypt_init(void) { }
   783	
   784	void __init __weak poking_init(void) { }
   785	
   786	void __init __weak pgtable_cache_init(void) { }
   787	
   788	void __init __weak trap_init(void) { }
   789	
   790	bool initcall_debug;
   791	core_param(initcall_debug, initcall_debug, bool, 0644);
   792	
   793	#ifdef TRACEPOINTS_ENABLED
   794	static void __init initcall_debug_enable(void);
   795	#else
   796	static inline void initcall_debug_enable(void)
   797	{
   798	}
   799	#endif
   800	
   801	/* Report memory auto-initialization states for this boot. */
   802	static void __init report_meminit(void)
   803	{
   804		const char *stack;
   805	
   806		if (IS_ENABLED(CONFIG_INIT_STACK_ALL_PATTERN))
   807			stack = "all(pattern)";
   808		else if (IS_ENABLED(CONFIG_INIT_STACK_ALL_ZERO))
   809			stack = "all(zero)";
   810		else if (IS_ENABLED(CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL))
   811			stack = "byref_all(zero)";
   812		else if (IS_ENABLED(CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF))
   813			stack = "byref(zero)";
   814		else if (IS_ENABLED(CONFIG_GCC_PLUGIN_STRUCTLEAK_USER))
   815			stack = "__user(zero)";
   816		else
   817			stack = "off";
   818	
   819		pr_info("mem auto-init: stack:%s, heap alloc:%s, heap free:%s\n",
   820			stack, want_init_on_alloc(GFP_KERNEL) ? "on" : "off",
   821			want_init_on_free() ? "on" : "off");
   822		if (want_init_on_free())
   823			pr_info("mem auto-init: clearing system memory may take some time...\n");
   824	}
   825	
   826	/*
   827	 * Set up kernel memory allocators
   828	 */
   829	static void __init mm_init(void)
   830	{
   831		/*
   832		 * page_ext requires contiguous pages,
   833		 * bigger than MAX_ORDER unless SPARSEMEM.
   834		 */
   835		page_ext_init_flatmem();
   836		init_mem_debugging_and_hardening();
   837		kfence_alloc_pool();
   838		report_meminit();
   839		stack_depot_early_init();
   840		mem_init();
   841		mem_init_print_info();
   842		kmem_cache_init();
   843		/*
   844		 * page_owner must be initialized after buddy is ready, and also after
   845		 * slab is ready so that stack_depot_init() works properly
   846		 */
   847		page_ext_init_flatmem_late();
   848		kmemleak_init();
   849		pgtable_init();
   850		debug_objects_mem_init();
   851		vmalloc_init();
   852		/* Should be run before the first non-init thread is created */
   853		init_espfix_bsp();
   854		/* Should be run after espfix64 is set up. */
   855		pti_init();
   856	}
   857	
   858	#ifdef CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
   859	DEFINE_STATIC_KEY_MAYBE_RO(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,
   860				   randomize_kstack_offset);
   861	DEFINE_PER_CPU(u32, kstack_offset);
   862	
   863	static int __init early_randomize_kstack_offset(char *buf)
   864	{
   865		int ret;
   866		bool bool_result;
   867	
   868		ret = kstrtobool(buf, &bool_result);
   869		if (ret)
   870			return ret;
   871	
   872		if (bool_result)
   873			static_branch_enable(&randomize_kstack_offset);
   874		else
   875			static_branch_disable(&randomize_kstack_offset);
   876		return 0;
   877	}
   878	early_param("randomize_kstack_offset", early_randomize_kstack_offset);
   879	#endif
   880	
   881	void __init __weak arch_call_rest_init(void)
   882	{
   883		rest_init();
   884	}
   885	
 > 886	void __init init_per_task_early(void)
   887	{
   888	#ifdef CONFIG_POSIX_TIMERS
   889		per_task(&init_task, posix_cputimers) = (struct posix_cputimers) __INIT_CPU_TIMERS(init_task);
   890	#endif
   891	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
