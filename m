Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D463474B83
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 20:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237301AbhLNTH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 14:07:57 -0500
Received: from mga11.intel.com ([192.55.52.93]:56732 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234522AbhLNTH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 14:07:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639508877; x=1671044877;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=P+/CGotftVFAYTx3eNBpOednIJxvhi0vh4YNXRoDGus=;
  b=VqRn54lV1YpJXJgEfFGeXIQDFfrNMKrjZfAFJ+zZ8fS8jHO21TqHxY/+
   y62cQa/Q2DWsDXsEaTzk0BxSc0z4CSCq+Hl/elT734rUWF6/FcnN53jDL
   vYwQO3XAytDEU9rlodjpOTSYJdEfUKarwewWoSI241ieGQg/BWxMcd6zy
   UsbVYrJ/Meaklvn/0zXksmSfqpvDtuyAcy20LatvZaG8NHZQCciCP6etp
   a98EKr/rA0juyD9h0tHb6smYtxjTzuBCn0PWCL/M8BBAs2gHHl4h2FXx3
   Xilm7NOgBkHyJnSnEozhRvELdZpN8uJYzzRQg/bXnJyrHyKnWR4DmXW4S
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="236596025"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="236596025"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 10:47:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="465212682"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 14 Dec 2021 10:47:16 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxCpX-0000dT-O6; Tue, 14 Dec 2021 18:47:15 +0000
Date:   Wed, 15 Dec 2021 02:46:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [ebiederm-user-namespace:signal-for-v5.17 11/12]
 kernel/fork.c:2123:9: error: use of undeclared label
 'bad_fork_cleanup_threadgroup_lock'
Message-ID: <202112150208.ylx9t2Sc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git signal-for-v5.17
head:   6b1248798eb6f6d5285db214299996ecc5dc1e6b
commit: 40966e316f86b8cfd83abd31ccb4df729309d3e7 [11/12] kthread: Ensure struct kthread is present for all kthreads
config: arm64-buildonly-randconfig-r001-20211213 (https://download.01.org/0day-ci/archive/20211215/202112150208.ylx9t2Sc-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project b6a2ddb6c8ac29412b1361810972e15221fa021c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git/commit/?id=40966e316f86b8cfd83abd31ccb4df729309d3e7
        git remote add ebiederm-user-namespace https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git
        git fetch --no-tags ebiederm-user-namespace signal-for-v5.17
        git checkout 40966e316f86b8cfd83abd31ccb4df729309d3e7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/fork.c:763:20: warning: no previous prototype for function 'arch_task_cache_init' [-Wmissing-prototypes]
   void __init __weak arch_task_cache_init(void) { }
                      ^
   kernel/fork.c:763:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init __weak arch_task_cache_init(void) { }
   ^
   static 
>> kernel/fork.c:2123:9: error: use of undeclared label 'bad_fork_cleanup_threadgroup_lock'
                           goto bad_fork_cleanup_threadgroup_lock;
                                ^
   1 warning and 1 error generated.


vim +/bad_fork_cleanup_threadgroup_lock +2123 kernel/fork.c

  2112	
  2113		task_io_accounting_init(&p->ioac);
  2114		acct_clear_integrals(p);
  2115	
  2116		posix_cputimers_init(&p->posix_cputimers);
  2117	
  2118		p->io_context = NULL;
  2119		audit_set_context(p, NULL);
  2120		cgroup_fork(p);
  2121		if (p->flags & PF_KTHREAD) {
  2122			if (!set_kthread_struct(p))
> 2123				goto bad_fork_cleanup_threadgroup_lock;
  2124		}
  2125	#ifdef CONFIG_NUMA
  2126		p->mempolicy = mpol_dup(p->mempolicy);
  2127		if (IS_ERR(p->mempolicy)) {
  2128			retval = PTR_ERR(p->mempolicy);
  2129			p->mempolicy = NULL;
  2130			goto bad_fork_cleanup_threadgroup_lock;
  2131		}
  2132	#endif
  2133	#ifdef CONFIG_CPUSETS
  2134		p->cpuset_mem_spread_rotor = NUMA_NO_NODE;
  2135		p->cpuset_slab_spread_rotor = NUMA_NO_NODE;
  2136		seqcount_spinlock_init(&p->mems_allowed_seq, &p->alloc_lock);
  2137	#endif
  2138	#ifdef CONFIG_TRACE_IRQFLAGS
  2139		memset(&p->irqtrace, 0, sizeof(p->irqtrace));
  2140		p->irqtrace.hardirq_disable_ip	= _THIS_IP_;
  2141		p->irqtrace.softirq_enable_ip	= _THIS_IP_;
  2142		p->softirqs_enabled		= 1;
  2143		p->softirq_context		= 0;
  2144	#endif
  2145	
  2146		p->pagefault_disabled = 0;
  2147	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
