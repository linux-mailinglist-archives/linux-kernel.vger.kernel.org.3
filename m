Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF2251E3C4
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 05:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445414AbiEGDYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 23:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445407AbiEGDYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 23:24:32 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E244E2AE27
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 20:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651893645; x=1683429645;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zVjKSTl58tpRGZnWQ/NWRdaGrJtq08QeNLOnBXk1/cg=;
  b=cEAfC0iaED209k4sVz93r8i6mG6ERFz5r8w/4AjXoWIX5ZZIj442+Oxh
   6EelBCaopsy4LLWp3dHD5JCpySRTUy/8iWJ75MXdiwQycxVWun2uw36Ia
   bkN6wpikEXvJyga8hmw/Pgr0OAlhkJN8kLYJHh+IRZMltVvowBj5JGIWN
   wRgrx7xHBHlG84gdrzpn9Jz1Akpgjx9cXqGBG39Pudee6nOGtXSMuKjv4
   x21I3ODC1avr3baO/988Z8KgwXVOZo0n7Ps9YRVxapy6AvbWqJjfpn0Z8
   e0UtOZXmB02Ht8iXOiJuvmtT1//W8+8VCRuZODQsJNPn5ptJW9ukctbkc
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="267479962"
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="267479962"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 20:20:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="812663844"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 06 May 2022 20:20:44 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nnAzr-000EAk-KP;
        Sat, 07 May 2022 03:20:43 +0000
Date:   Sat, 7 May 2022 11:20:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ebiederm-user-namespace:kthread-cleanups-for-v5.19 2/7]
 arch/h8300/kernel/process.c:108:46: error: unknown type name
 'kernel_clone_args'
Message-ID: <202205071135.brFxCRDU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git kthread-cleanups-for-v5.19
head:   688122ff3e49ddca3c6c3572cadb19285045bbe3
commit: 498391acef1e0098a722e7f45496fda39a15284a [2/7] fork: Pass struct kernel_clone_args into copy_thread
config: h8300-randconfig-r025-20220506 (https://download.01.org/0day-ci/archive/20220507/202205071135.brFxCRDU-lkp@intel.com/config)
compiler: h8300-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git/commit/?id=498391acef1e0098a722e7f45496fda39a15284a
        git remote add ebiederm-user-namespace https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git
        git fetch --no-tags ebiederm-user-namespace kthread-cleanups-for-v5.19
        git checkout 498391acef1e0098a722e7f45496fda39a15284a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=h8300 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/h8300/kernel/process.c:58:6: warning: no previous prototype for 'arch_cpu_idle' [-Wmissing-prototypes]
      58 | void arch_cpu_idle(void)
         |      ^~~~~~~~~~~~~
>> arch/h8300/kernel/process.c:108:46: error: unknown type name 'kernel_clone_args'
     108 | int copy_thread(struct task_struct *p, const kernel_clone_args *args)
         |                                              ^~~~~~~~~~~~~~~~~
   arch/h8300/kernel/process.c:108:5: error: conflicting types for 'copy_thread'; have 'int(struct task_struct *, const int *)'
     108 | int copy_thread(struct task_struct *p, const kernel_clone_args *args)
         |     ^~~~~~~~~~~
   In file included from arch/h8300/kernel/process.c:30:
   include/linux/sched/task.h:71:12: note: previous declaration of 'copy_thread' with type 'int(struct task_struct *, const struct kernel_clone_args *)'
      71 | extern int copy_thread(struct task_struct *, const struct kernel_clone_args *);
         |            ^~~~~~~~~~~
   arch/h8300/kernel/process.c: In function 'copy_thread':
   arch/h8300/kernel/process.c:110:33: error: request for member 'stack' in something not a structure or union
     110 |         unsigned long usp = args->stack;
         |                                 ^~
   arch/h8300/kernel/process.c:111:36: error: request for member 'stack_size' in something not a structure or union
     111 |         unsigned long topstk = args->stack_size;
         |                                    ^~
   arch/h8300/kernel/process.c: At top level:
   arch/h8300/kernel/process.c:153:16: warning: no previous prototype for 'sys_clone' [-Wmissing-prototypes]
     153 | asmlinkage int sys_clone(unsigned long __user *args)
         |                ^~~~~~~~~


vim +/kernel_clone_args +108 arch/h8300/kernel/process.c

   107	
 > 108	int copy_thread(struct task_struct *p, const kernel_clone_args *args)
   109	{
   110		unsigned long usp = args->stack;
   111		unsigned long topstk = args->stack_size;
   112		struct pt_regs *childregs;
   113	
   114		childregs = (struct pt_regs *) (THREAD_SIZE + task_stack_page(p)) - 1;
   115	
   116		if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
   117			memset(childregs, 0, sizeof(struct pt_regs));
   118			childregs->retpc = (unsigned long) ret_from_kernel_thread;
   119			childregs->er4 = topstk; /* arg */
   120			childregs->er5 = usp; /* fn */
   121		}  else {
   122			*childregs = *current_pt_regs();
   123			childregs->er0 = 0;
   124			childregs->retpc = (unsigned long) ret_from_fork;
   125			p->thread.usp = usp ?: rdusp();
   126		}
   127		p->thread.ksp = (unsigned long)childregs;
   128	
   129		return 0;
   130	}
   131	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
