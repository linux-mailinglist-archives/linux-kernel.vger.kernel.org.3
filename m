Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC54C509CE4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387962AbiDUJ4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387935AbiDUJ4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:56:42 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F84727B25
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 02:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650534832; x=1682070832;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GBbvlsaoFPxqmOBBk4cx5j/ytlbVzRJ1iFNTPqQDh0U=;
  b=VFAhMS0yMxPImtF9NuPYYVzeF0R2Y0KRN5SYTmlI/mRfQP7bC61Htxlm
   IiJAf2bAxCWsspNkRVaYE2Hp3Kp2fejEybi3VvtNcdWYl4KnFMOetYbRM
   aTE1TB5XRVtvdJD1It5GgYGXMeWVC0xRCFYGfdabIAnMWsANQO3lOA+uZ
   I9Okq6SP57ADhB2G+IrcYwUG3mvoU4O1VLok0xdIlLEodM/GmYcaIKvth
   EEu0KYGx3qUb0vWvtEMlLqM3MlbV2y5GyJChhqCXn7Kl09K7467zBR6EP
   W+Bx/gARHtuHxZP1JKJtsVfFjuLNUYHDsux3IRfr6uPIcFrqM+9GM+dcb
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="251613918"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="251613918"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 02:53:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="532994768"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 21 Apr 2022 02:53:50 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhTVV-0008BX-Rf;
        Thu, 21 Apr 2022 09:53:49 +0000
Date:   Thu, 21 Apr 2022 17:53:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:palmer/linux/tspinlock-v3 5/9]
 kernel/seccomp.c:870:9: sparse: sparse: incorrect type in argument 1
 (different address spaces)
Message-ID: <202204211726.WgiHp9Ql-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block palmer/linux/tspinlock-v3
head:   fc2d79f0558a2de8cdf896d84f507bf51f90cd0c
commit: 9d7cdf43225edaf8bef5c716927eb6a6c5a0f69b [5/9] RISC-V: Move to generic spinlocks
config: riscv-randconfig-s032-20220420 (https://download.01.org/0day-ci/archive/20220421/202204211726.WgiHp9Ql-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/9d7cdf43225edaf8bef5c716927eb6a6c5a0f69b
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block palmer/linux/tspinlock-v3
        git checkout 9d7cdf43225edaf8bef5c716927eb6a6c5a0f69b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> kernel/seccomp.c:870:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct atomic_t [usertype] *lock @@     got struct atomic_t [noderef] __rcu * @@
   kernel/seccomp.c:870:9: sparse:     expected struct atomic_t [usertype] *lock
   kernel/seccomp.c:870:9: sparse:     got struct atomic_t [noderef] __rcu *
   kernel/seccomp.c:1344:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/seccomp.c:1344:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/seccomp.c:1344:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/seccomp.c:1356:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/seccomp.c:1356:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/seccomp.c:1356:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/seccomp.c:1782:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct lockdep_map const *lock @@     got struct lockdep_map [noderef] __rcu * @@
   kernel/seccomp.c:1782:9: sparse:     expected struct lockdep_map const *lock
   kernel/seccomp.c:1782:9: sparse:     got struct lockdep_map [noderef] __rcu *
   kernel/seccomp.c:1860:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/seccomp.c:1860:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/seccomp.c:1860:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/seccomp.c:1878:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/seccomp.c:1878:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/seccomp.c:1878:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/seccomp.c:2020:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/seccomp.c:2020:28: sparse:     expected struct spinlock [usertype] *lock
   kernel/seccomp.c:2020:28: sparse:     got struct spinlock [noderef] __rcu *
   kernel/seccomp.c:2023:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/seccomp.c:2023:38: sparse:     expected struct spinlock [usertype] *lock
   kernel/seccomp.c:2023:38: sparse:     got struct spinlock [noderef] __rcu *
   kernel/seccomp.c:2029:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/seccomp.c:2029:30: sparse:     expected struct spinlock [usertype] *lock
   kernel/seccomp.c:2029:30: sparse:     got struct spinlock [noderef] __rcu *
   kernel/seccomp.c:487:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct atomic_t [usertype] *lock @@     got struct atomic_t [noderef] __rcu * @@
   kernel/seccomp.c:487:9: sparse:     expected struct atomic_t [usertype] *lock
   kernel/seccomp.c:487:9: sparse:     got struct atomic_t [noderef] __rcu *
   kernel/seccomp.c:584:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct atomic_t [usertype] *lock @@     got struct atomic_t [noderef] __rcu * @@
   kernel/seccomp.c:584:9: sparse:     expected struct atomic_t [usertype] *lock
   kernel/seccomp.c:584:9: sparse:     got struct atomic_t [noderef] __rcu *
   kernel/seccomp.c:445:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct atomic_t [usertype] *lock @@     got struct atomic_t [noderef] __rcu * @@
   kernel/seccomp.c:445:9: sparse:     expected struct atomic_t [usertype] *lock
   kernel/seccomp.c:445:9: sparse:     got struct atomic_t [noderef] __rcu *
   kernel/seccomp.c:431:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct atomic_t [usertype] *lock @@     got struct atomic_t [noderef] __rcu * @@
   kernel/seccomp.c:431:9: sparse:     expected struct atomic_t [usertype] *lock
   kernel/seccomp.c:431:9: sparse:     got struct atomic_t [noderef] __rcu *
   kernel/seccomp.c:445:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct atomic_t [usertype] *lock @@     got struct atomic_t [noderef] __rcu * @@
   kernel/seccomp.c:445:9: sparse:     expected struct atomic_t [usertype] *lock
   kernel/seccomp.c:445:9: sparse:     got struct atomic_t [noderef] __rcu *
   kernel/seccomp.c:431:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct atomic_t [usertype] *lock @@     got struct atomic_t [noderef] __rcu * @@
   kernel/seccomp.c:431:9: sparse:     expected struct atomic_t [usertype] *lock
   kernel/seccomp.c:431:9: sparse:     got struct atomic_t [noderef] __rcu *
   kernel/seccomp.c:445:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct atomic_t [usertype] *lock @@     got struct atomic_t [noderef] __rcu * @@
   kernel/seccomp.c:445:9: sparse:     expected struct atomic_t [usertype] *lock
   kernel/seccomp.c:445:9: sparse:     got struct atomic_t [noderef] __rcu *
--
   kernel/fork.c:1304:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct file [noderef] __rcu *_x_ @@     got struct file *new_exe_file @@
   kernel/fork.c:1304:24: sparse:     expected struct file [noderef] __rcu *_x_
   kernel/fork.c:1304:24: sparse:     got struct file *new_exe_file
   kernel/fork.c:1304:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *[assigned] old_exe_file @@     got struct file [noderef] __rcu * @@
   kernel/fork.c:1304:22: sparse:     expected struct file *[assigned] old_exe_file
   kernel/fork.c:1304:22: sparse:     got struct file [noderef] __rcu *
   kernel/fork.c:1635:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct refcount_struct [usertype] *r @@     got struct refcount_struct [noderef] __rcu * @@
   kernel/fork.c:1635:38: sparse:     expected struct refcount_struct [usertype] *r
   kernel/fork.c:1635:38: sparse:     got struct refcount_struct [noderef] __rcu *
   kernel/fork.c:1644:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:1644:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:1644:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:1645:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got struct k_sigaction [noderef] __rcu * @@
   kernel/fork.c:1645:36: sparse:     expected void const *
   kernel/fork.c:1645:36: sparse:     got struct k_sigaction [noderef] __rcu *
   kernel/fork.c:1646:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:1646:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:1646:33: sparse:     got struct spinlock [noderef] __rcu *
>> kernel/fork.c:1739:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct atomic_t [usertype] *lock @@     got struct atomic_t [noderef] __rcu * @@
   kernel/fork.c:1739:9: sparse:     expected struct atomic_t [usertype] *lock
   kernel/fork.c:1739:9: sparse:     got struct atomic_t [noderef] __rcu *
   kernel/fork.c:2058:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2058:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2058:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2062:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2062:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2062:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2379:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct [noderef] __rcu *real_parent @@     got struct task_struct * @@
   kernel/fork.c:2379:32: sparse:     expected struct task_struct [noderef] __rcu *real_parent
   kernel/fork.c:2379:32: sparse:     got struct task_struct *
   kernel/fork.c:2388:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2388:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2388:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2433:54: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct list_head *head @@     got struct list_head [noderef] __rcu * @@
   kernel/fork.c:2433:54: sparse:     expected struct list_head *head
   kernel/fork.c:2433:54: sparse:     got struct list_head [noderef] __rcu *
   kernel/fork.c:2454:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2454:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2454:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2475:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2475:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2475:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2502:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sighand_struct *sighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   kernel/fork.c:2502:28: sparse:     expected struct sighand_struct *sighand
   kernel/fork.c:2502:28: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   kernel/fork.c:2531:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2531:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2531:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2533:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2533:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2533:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2942:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *[assigned] parent @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/fork.c:2942:24: sparse:     expected struct task_struct *[assigned] parent
   kernel/fork.c:2942:24: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/fork.c:3023:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct refcount_struct const [usertype] *r @@     got struct refcount_struct [noderef] __rcu * @@
   kernel/fork.c:3023:43: sparse:     expected struct refcount_struct const [usertype] *r
   kernel/fork.c:3023:43: sparse:     got struct refcount_struct [noderef] __rcu *
   kernel/fork.c:2100:22: sparse: sparse: dereference of noderef expression
   kernel/fork.c: note: in included file (through include/linux/ftrace.h, include/linux/perf_event.h, include/linux/trace_events.h, ...):
   include/linux/ptrace.h:217:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *new_parent @@     got struct task_struct [noderef] __rcu *parent @@
   include/linux/ptrace.h:217:45: sparse:     expected struct task_struct *new_parent
   include/linux/ptrace.h:217:45: sparse:     got struct task_struct [noderef] __rcu *parent
   include/linux/ptrace.h:217:62: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected struct cred const *ptracer_cred @@     got struct cred const [noderef] __rcu *ptracer_cred @@
   include/linux/ptrace.h:217:62: sparse:     expected struct cred const *ptracer_cred
   include/linux/ptrace.h:217:62: sparse:     got struct cred const [noderef] __rcu *ptracer_cred
   kernel/fork.c:2431:59: sparse: sparse: dereference of noderef expression
   kernel/fork.c:2432:59: sparse: sparse: dereference of noderef expression

vim +870 kernel/seccomp.c

8e01b51a31a1e0 YiFei Zhu      2020-10-11  851  
c8bee430dc52cf Kees Cook      2014-06-27  852  /**
c8bee430dc52cf Kees Cook      2014-06-27  853   * seccomp_attach_filter: validate and attach filter
c8bee430dc52cf Kees Cook      2014-06-27  854   * @flags:  flags to change filter behavior
c8bee430dc52cf Kees Cook      2014-06-27  855   * @filter: seccomp filter to add to the current process
c8bee430dc52cf Kees Cook      2014-06-27  856   *
dbd952127d11bb Kees Cook      2014-06-27  857   * Caller must be holding current->sighand->siglock lock.
dbd952127d11bb Kees Cook      2014-06-27  858   *
7a0df7fbc14505 Tycho Andersen 2019-03-06  859   * Returns 0 on success, -ve on error, or
7a0df7fbc14505 Tycho Andersen 2019-03-06  860   *   - in TSYNC mode: the pid of a thread which was either not in the correct
7a0df7fbc14505 Tycho Andersen 2019-03-06  861   *     seccomp mode or did not have an ancestral seccomp filter
7a0df7fbc14505 Tycho Andersen 2019-03-06  862   *   - in NEW_LISTENER mode: the fd of the new listener
c8bee430dc52cf Kees Cook      2014-06-27  863   */
c8bee430dc52cf Kees Cook      2014-06-27  864  static long seccomp_attach_filter(unsigned int flags,
c8bee430dc52cf Kees Cook      2014-06-27  865  				  struct seccomp_filter *filter)
c8bee430dc52cf Kees Cook      2014-06-27  866  {
c8bee430dc52cf Kees Cook      2014-06-27  867  	unsigned long total_insns;
c8bee430dc52cf Kees Cook      2014-06-27  868  	struct seccomp_filter *walker;
c8bee430dc52cf Kees Cook      2014-06-27  869  
69f6a34bdeea4f Guenter Roeck  2014-08-10 @870  	assert_spin_locked(&current->sighand->siglock);
dbd952127d11bb Kees Cook      2014-06-27  871  
c8bee430dc52cf Kees Cook      2014-06-27  872  	/* Validate resulting filter length. */
c8bee430dc52cf Kees Cook      2014-06-27  873  	total_insns = filter->prog->len;
c8bee430dc52cf Kees Cook      2014-06-27  874  	for (walker = current->seccomp.filter; walker; walker = walker->prev)
c8bee430dc52cf Kees Cook      2014-06-27  875  		total_insns += walker->prog->len + 4;  /* 4 instr penalty */
c8bee430dc52cf Kees Cook      2014-06-27  876  	if (total_insns > MAX_INSNS_PER_PATH)
c8bee430dc52cf Kees Cook      2014-06-27  877  		return -ENOMEM;
c8bee430dc52cf Kees Cook      2014-06-27  878  
c2e1f2e30daa55 Kees Cook      2014-06-05  879  	/* If thread sync has been requested, check that it is possible. */
c2e1f2e30daa55 Kees Cook      2014-06-05  880  	if (flags & SECCOMP_FILTER_FLAG_TSYNC) {
c2e1f2e30daa55 Kees Cook      2014-06-05  881  		int ret;
c2e1f2e30daa55 Kees Cook      2014-06-05  882  
c2e1f2e30daa55 Kees Cook      2014-06-05  883  		ret = seccomp_can_sync_threads();
51891498f2da78 Tycho Andersen 2020-03-04  884  		if (ret) {
51891498f2da78 Tycho Andersen 2020-03-04  885  			if (flags & SECCOMP_FILTER_FLAG_TSYNC_ESRCH)
51891498f2da78 Tycho Andersen 2020-03-04  886  				return -ESRCH;
51891498f2da78 Tycho Andersen 2020-03-04  887  			else
c2e1f2e30daa55 Kees Cook      2014-06-05  888  				return ret;
c2e1f2e30daa55 Kees Cook      2014-06-05  889  		}
51891498f2da78 Tycho Andersen 2020-03-04  890  	}
c2e1f2e30daa55 Kees Cook      2014-06-05  891  
e66a39977985b1 Tyler Hicks    2017-08-11  892  	/* Set log flag, if present. */
e66a39977985b1 Tyler Hicks    2017-08-11  893  	if (flags & SECCOMP_FILTER_FLAG_LOG)
e66a39977985b1 Tyler Hicks    2017-08-11  894  		filter->log = true;
e66a39977985b1 Tyler Hicks    2017-08-11  895  
c8bee430dc52cf Kees Cook      2014-06-27  896  	/*
c8bee430dc52cf Kees Cook      2014-06-27  897  	 * If there is an existing filter, make it the prev and don't drop its
c8bee430dc52cf Kees Cook      2014-06-27  898  	 * task reference.
c8bee430dc52cf Kees Cook      2014-06-27  899  	 */
c8bee430dc52cf Kees Cook      2014-06-27  900  	filter->prev = current->seccomp.filter;
8e01b51a31a1e0 YiFei Zhu      2020-10-11  901  	seccomp_cache_prepare(filter);
c8bee430dc52cf Kees Cook      2014-06-27  902  	current->seccomp.filter = filter;
c818c03b661cd7 Kees Cook      2020-05-13  903  	atomic_inc(&current->seccomp.filter_count);
c8bee430dc52cf Kees Cook      2014-06-27  904  
c2e1f2e30daa55 Kees Cook      2014-06-05  905  	/* Now that the new filter is in place, synchronize to all threads. */
c2e1f2e30daa55 Kees Cook      2014-06-05  906  	if (flags & SECCOMP_FILTER_FLAG_TSYNC)
00a02d0c502a06 Kees Cook      2018-05-03  907  		seccomp_sync_threads(flags);
c2e1f2e30daa55 Kees Cook      2014-06-05  908  
c8bee430dc52cf Kees Cook      2014-06-27  909  	return 0;
e2cfabdfd07564 Will Drewry    2012-04-12  910  }
e2cfabdfd07564 Will Drewry    2012-04-12  911  

:::::: The code at line 870 was first introduced by commit
:::::: 69f6a34bdeea4fec50bb90619bc9602973119572 seccomp: Replace BUG(!spin_is_locked()) with assert_spin_lock

:::::: TO: Guenter Roeck <linux@roeck-us.net>
:::::: CC: Kees Cook <keescook@chromium.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
