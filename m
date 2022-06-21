Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D521455321B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 14:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349923AbiFUMej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 08:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349319AbiFUMcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 08:32:36 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1C3205D9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 05:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655814755; x=1687350755;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Q4Hbv5QJrl2Kvi0tpSwqYgCPP0t2luD+USznuaeTmeM=;
  b=jy04T6n144XbLNs1p7KYFUIHdNKYko6A2filXY2Cv1k0a6O+8W92f6j7
   W18RPmCcvStHlBsiwszp6+EQZzZl9+QlU3A5kpGC4OY6Gx3M2AtnUKoJd
   akRNF6EvdNAwAB1z8wXiSWKvkpAPVvu6Ua/2JsOuZxVo8u6RkoqchuN9K
   ZBnjLLwpeLiQPHDvJWOCJw72B/GEGKdd8KR5WoEIB5hGvKHJOPsE7FCyI
   5f3JXhXf0Ut9RaNV5J8jJ5tGomp/i91YJDEWRDap99hjyCPYipfOGSF41
   OClHr01RcMD9PBZm/GGqrj01anZO1PUvCBd8FC1ipiKCrF6Ux1J+DXL7r
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="263139496"
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="263139496"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 05:32:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="620463426"
Received: from lkp-server02.sh.intel.com (HELO afd2e3565656) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 21 Jun 2022 05:32:33 -0700
Received: from kbuild by afd2e3565656 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3d3Y-00005F-IB;
        Tue, 21 Jun 2022 12:32:32 +0000
Date:   Tue, 21 Jun 2022 20:31:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jan Kara <jack@suse.cz>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>
Subject: arch/x86/include/asm/current.h:18:17: warning: passing argument 1 of
 '__get_task_ioprio' makes integer from pointer without a cast
Message-ID: <202206212036.ElLkh5Sy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel-lab-lkp/linux/commits/Jan-Kara/block-Fix-IO-priority-mess/20220621-182732
head:   6f52abf6ff185567f8a06db898db11e011fbf05e
commit: 0a092365687a0a4f7e0b4cae345e554ae654f024 block: Generalize get_current_ioprio() for any task
date:   2 hours ago
config: i386-tinyconfig (https://download.01.org/0day-ci/archive/20220621/202206212036.ElLkh5Sy-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/0a092365687a0a4f7e0b4cae345e554ae654f024
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jan-Kara/block-Fix-IO-priority-mess/20220621-182732
        git checkout 0a092365687a0a4f7e0b4cae345e554ae654f024
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/thread_info.h:23,
                    from arch/x86/include/asm/preempt.h:7,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from include/linux/crypto.h:20,
                    from arch/x86/kernel/asm-offsets.c:9:
   include/linux/ioprio.h: In function 'get_current_ioprio':
>> arch/x86/include/asm/current.h:18:17: warning: passing argument 1 of '__get_task_ioprio' makes integer from pointer without a cast [-Wint-conversion]
      18 | #define current get_current()
         |                 ^~~~~~~~~~~~~
         |                 |
         |                 struct task_struct *
   include/linux/ioprio.h:60:34: note: in expansion of macro 'current'
      60 |         return __get_task_ioprio(current);
         |                                  ^~~~~~~
   In file included from include/linux/fs.h:38,
                    from include/linux/cgroup.h:17,
                    from include/linux/memcontrol.h:13,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from arch/x86/kernel/asm-offsets.c:13:
   include/linux/ioprio.h:52:41: note: expected 'int' but argument is of type 'struct task_struct *'
      52 | static inline int __get_task_ioprio(int ioprio)
         |                                     ~~~~^~~~~~
--
   In file included from include/linux/sched.h:12,
                    from arch/x86/entry/common.c:11:
   include/linux/ioprio.h: In function 'get_current_ioprio':
>> arch/x86/include/asm/current.h:18:17: warning: passing argument 1 of '__get_task_ioprio' makes integer from pointer without a cast [-Wint-conversion]
      18 | #define current get_current()
         |                 ^~~~~~~~~~~~~
         |                 |
         |                 struct task_struct *
   include/linux/ioprio.h:60:34: note: in expansion of macro 'current'
      60 |         return __get_task_ioprio(current);
         |                                  ^~~~~~~
   In file included from include/linux/fs.h:38,
                    from include/linux/huge_mm.h:8,
                    from include/linux/mm.h:700,
                    from include/linux/pid_namespace.h:7,
                    from include/linux/ptrace.h:10,
                    from include/linux/entry-common.h:6,
                    from arch/x86/entry/common.c:13:
   include/linux/ioprio.h:52:41: note: expected 'int' but argument is of type 'struct task_struct *'
      52 | static inline int __get_task_ioprio(int ioprio)
         |                                     ~~~~^~~~~~
   arch/x86/entry/common.c: At top level:
   arch/x86/entry/common.c:119:24: warning: no previous prototype for 'do_int80_syscall_32' [-Wmissing-prototypes]
     119 | __visible noinstr void do_int80_syscall_32(struct pt_regs *regs)
         |                        ^~~~~~~~~~~~~~~~~~~
   arch/x86/entry/common.c:186:24: warning: no previous prototype for 'do_fast_syscall_32' [-Wmissing-prototypes]
     186 | __visible noinstr long do_fast_syscall_32(struct pt_regs *regs)
         |                        ^~~~~~~~~~~~~~~~~~
   arch/x86/entry/common.c:238:24: warning: no previous prototype for 'do_SYSENTER_32' [-Wmissing-prototypes]
     238 | __visible noinstr long do_SYSENTER_32(struct pt_regs *regs)
         |                        ^~~~~~~~~~~~~~
--
   In file included from include/linux/thread_info.h:23,
                    from arch/x86/include/asm/preempt.h:7,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:7,
                    from arch/x86/entry/vdso/vma.c:7:
   include/linux/ioprio.h: In function 'get_current_ioprio':
>> arch/x86/include/asm/current.h:18:17: warning: passing argument 1 of '__get_task_ioprio' makes integer from pointer without a cast [-Wint-conversion]
      18 | #define current get_current()
         |                 ^~~~~~~~~~~~~
         |                 |
         |                 struct task_struct *
   include/linux/ioprio.h:60:34: note: in expansion of macro 'current'
      60 |         return __get_task_ioprio(current);
         |                                  ^~~~~~~
   In file included from include/linux/fs.h:38,
                    from include/linux/huge_mm.h:8,
                    from include/linux/mm.h:700,
                    from arch/x86/entry/vdso/vma.c:7:
   include/linux/ioprio.h:52:41: note: expected 'int' but argument is of type 'struct task_struct *'
      52 | static inline int __get_task_ioprio(int ioprio)
         |                                     ~~~~^~~~~~
   arch/x86/entry/vdso/vma.c: At top level:
   arch/x86/entry/vdso/vma.c:35:19: warning: no previous prototype for 'arch_get_vdso_data' [-Wmissing-prototypes]
      35 | struct vdso_data *arch_get_vdso_data(void *vvar_page)
         |                   ^~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/thread_info.h:23,
                    from arch/x86/include/asm/preempt.h:7,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from include/linux/crypto.h:20,
                    from arch/x86/kernel/asm-offsets.c:9:
   include/linux/ioprio.h: In function 'get_current_ioprio':
>> arch/x86/include/asm/current.h:18:17: warning: passing argument 1 of '__get_task_ioprio' makes integer from pointer without a cast [-Wint-conversion]
      18 | #define current get_current()
         |                 ^~~~~~~~~~~~~
         |                 |
         |                 struct task_struct *
   include/linux/ioprio.h:60:34: note: in expansion of macro 'current'
      60 |         return __get_task_ioprio(current);
         |                                  ^~~~~~~
   In file included from include/linux/fs.h:38,
                    from include/linux/cgroup.h:17,
                    from include/linux/memcontrol.h:13,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from arch/x86/kernel/asm-offsets.c:13:
   include/linux/ioprio.h:52:41: note: expected 'int' but argument is of type 'struct task_struct *'
      52 | static inline int __get_task_ioprio(int ioprio)
         |                                     ~~~~^~~~~~


vim +/__get_task_ioprio +18 arch/x86/include/asm/current.h

f0766440dda7ac include/asm-x86/current.h      Christoph Lameter 2008-05-09  17  
c6f5e0acd5d12e arch/x86/include/asm/current.h Brian Gerst       2009-01-19 @18  #define current get_current()
f0766440dda7ac include/asm-x86/current.h      Christoph Lameter 2008-05-09  19  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
