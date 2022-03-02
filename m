Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3684CAC5F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244218AbiCBRqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234695AbiCBRqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:46:05 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C062CD048D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 09:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646243121; x=1677779121;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rOYSHNhHQNv1kQCcwK8pVi53sog9Tz6LXym2rDNepqU=;
  b=UzBqGM0Ju6Bu5ihXFB8Ga+7Aon3vjKCGOphNOQGBWIhOMFZnfkt91nG9
   fbOFqxb68NVoMCJrf6sjalUFz5zu7XaqnCZoNl2INR4682QRrB8XvilwD
   kohvziBk8HxHNGpEVCCbNa0c0mGfAbemvDeQ4Ws6pKBw5r2/I8xYycIOo
   tFSy1VsiQpmKoJOx8ePT2YMh1t/6jbvteTpBK8sKgqkGJzdDX1R1XZ46l
   o/UnCwZ0ejyGxIZYlf2wA9HvgJZk0I+pjCBPko1iAZ83h4C7cL++HvFhA
   cmHctoqMcuZE+vSVj77ROV82MJeo9a3oyXQ2WIYWKqE/mCl5Cqce59Cis
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="251037722"
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="251037722"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 09:45:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="641782643"
Received: from lkp-server02.sh.intel.com (HELO e9605edfa585) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 02 Mar 2022 09:45:19 -0800
Received: from kbuild by e9605edfa585 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPT2M-0001g6-V1; Wed, 02 Mar 2022 17:45:18 +0000
Date:   Thu, 3 Mar 2022 01:45:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:google/android/kernel/common/deprecated/android-4.9-p-release
 8545/9999] kernel/trace/ftrace.c:5740:6: warning: no previous declaration
 for 'ftrace_graph_return_stub'
Message-ID: <202203030131.ZYcQgFC1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sami,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/deprecated/android-4.9-p-release
head:   74f5cdd2ad41ea660f18bcaf7ce3d8d3e8e88428
commit: c2f9bce9fee8e31e0500c501076f73db7791d8e9 [8545/9999] ANDROID: ftrace: fix function type mismatches
config: i386-randconfig-r014-20211122 (https://download.01.org/0day-ci/archive/20220303/202203030131.ZYcQgFC1-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/c2f9bce9fee8e31e0500c501076f73db7791d8e9
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/deprecated/android-4.9-p-release
        git checkout c2f9bce9fee8e31e0500c501076f73db7791d8e9
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash kernel/trace/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/ratelimit.h:5:0,
                    from include/linux/device.h:27,
                    from include/linux/node.h:17,
                    from include/linux/cpu.h:16,
                    from include/linux/stop_machine.h:4,
                    from kernel/trace/ftrace.c:16:
   include/linux/sched.h:1260:1: warning: type qualifiers ignored on function return type [-Wignored-qualifiers]
    const struct sched_group_energy * const(*sched_domain_energy_f)(int cpu);
    ^~~~~
   kernel/trace/ftrace.c:673:5: warning: no previous declaration for 'ftrace_profile_pages_init' [-Wmissing-declarations]
    int ftrace_profile_pages_init(struct ftrace_profile_stat *stat)
        ^~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/ftrace.c:1200:1: warning: 'inline' is not at beginning of declaration [-Wold-style-declaration]
    static bool __always_inline ftrace_hash_empty(struct ftrace_hash *hash)
    ^~~~~~
   kernel/trace/ftrace.c:2646:13: warning: no previous declaration for 'arch_ftrace_trampoline_free' [-Wmissing-declarations]
    void __weak arch_ftrace_trampoline_free(struct ftrace_ops *ops)
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/ftrace.c:3268:1: warning: no previous declaration for 'arch_ftrace_trampoline_func' [-Wmissing-declarations]
    arch_ftrace_trampoline_func(struct ftrace_ops *ops, struct dyn_ftrace *rec)
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/ftrace.c:3490:15: warning: no previous declaration for 'arch_ftrace_match_adjust' [-Wmissing-declarations]
    char * __weak arch_ftrace_match_adjust(char *str, const char *search)
                  ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/ftrace.c: In function '__enable_ftrace_function_probe':
   kernel/trace/ftrace.c:3721:6: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
     int ret;
         ^~~
   kernel/trace/ftrace.c: At top level:
   kernel/trace/ftrace.c:5151:13: warning: no previous declaration for 'arch_ftrace_update_trampoline' [-Wmissing-declarations]
    void __weak arch_ftrace_update_trampoline(struct ftrace_ops *ops)
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/trace/ftrace.c:5740:6: warning: no previous declaration for 'ftrace_graph_return_stub' [-Wmissing-declarations]
    void ftrace_graph_return_stub(struct ftrace_graph_ret *trace)
         ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/ftrace.c:5744:5: warning: no previous declaration for 'ftrace_graph_entry_stub' [-Wmissing-declarations]
    int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace)
        ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/ftrace.c:1080:27: warning: 'ftrace_swapper_pid' defined but not used [-Wunused-const-variable=]
    static struct pid * const ftrace_swapper_pid = &init_struct_pid;
                              ^~~~~~~~~~~~~~~~~~


vim +/ftrace_graph_return_stub +5740 kernel/trace/ftrace.c

  5739	
> 5740	void ftrace_graph_return_stub(struct ftrace_graph_ret *trace)
  5741	{
  5742	}
  5743	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
