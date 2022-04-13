Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478335002D3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 01:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235876AbiDMX61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 19:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbiDMX6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 19:58:25 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1ADF54BE4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649894162; x=1681430162;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sRCvt1KkR5nJ9oWYR3wlxpBAHsZjc36ltesMcedDqks=;
  b=f/mHjXFqSM2kZotW8n3v1qh4BXL8+nPFRjRfiWaMX8pzGNLYSKl5VIpP
   m2dM8NDnFb71rP8cUuGqMyXfFgsNMjdwG0ylBWz9usH7iKTyghS+6xtct
   2gartF/ZTjIdmBuicmvhQSeRnbly7Ns9Jsgh3g8GZ3SM3J0ci0/v+UB48
   T/xdNWxmdqMH9yQMKE1OqnGihr1X0HGqAPxuGStOHAiEW23HAMWJE7bLZ
   E7skylAvKjgOp2+lyp+7o8pNA5RcYOGuGsnifv5ruT06a5yuhUZkW8DYL
   8umOPAGDoxPz86Q2JL51tkPZPd3mjtu0FeRUHdM/T0rW/5Xx52m5no4p6
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="250097996"
X-IronPort-AV: E=Sophos;i="5.90,258,1643702400"; 
   d="scan'208";a="250097996"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 16:56:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,258,1643702400"; 
   d="scan'208";a="590950501"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 13 Apr 2022 16:56:00 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nemq7-0000iX-EP;
        Wed, 13 Apr 2022 23:55:59 +0000
Date:   Thu, 14 Apr 2022 07:54:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jpoimboe:objtool-run 11/29] arch/ia64/kernel/process.c:230:1:
 warning: 'noreturn' function does return
Message-ID: <202204140711.k6JoljtY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git objtool-run
head:   6d60b700d2179c68f134da8eda4d9879d460d1a3
commit: f5a10245e0eab8e93b77aa796fdf404d10b32468 [11/29] sched: Mark arch_cpu_idle_dead() __noreturn
config: ia64-randconfig-r035-20220413 (https://download.01.org/0day-ci/archive/20220414/202204140711.k6JoljtY-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/commit/?id=f5a10245e0eab8e93b77aa796fdf404d10b32468
        git remote add jpoimboe https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git
        git fetch --no-tags jpoimboe objtool-run
        git checkout f5a10245e0eab8e93b77aa796fdf404d10b32468
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash arch/ia64/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/ia64/kernel/process.c:155:1: warning: no previous prototype for 'console_print' [-Wmissing-prototypes]
     155 | console_print(const char *s)
         | ^~~~~~~~~~~~~
   arch/ia64/kernel/process.c:161:1: warning: no previous prototype for 'do_notify_resume_user' [-Wmissing-prototypes]
     161 | do_notify_resume_user(sigset_t *unused, struct sigscratch *scr, long in_syscall)
         | ^~~~~~~~~~~~~~~~~~~~~
   arch/ia64/kernel/process.c:400:17: warning: no previous prototype for 'ia64_clone' [-Wmissing-prototypes]
     400 | asmlinkage long ia64_clone(unsigned long clone_flags, unsigned long stack_start,
         |                 ^~~~~~~~~~
   arch/ia64/kernel/process.c:554:1: warning: no previous prototype for 'cpu_halt' [-Wmissing-prototypes]
     554 | cpu_halt (void)
         | ^~~~~~~~
   arch/ia64/kernel/process.c: In function 'arch_cpu_idle_dead':
>> arch/ia64/kernel/process.c:230:1: warning: 'noreturn' function does return
     230 | }
         | ^


vim +/noreturn +230 arch/ia64/kernel/process.c

^1da177e4c3f41 Linus Torvalds    2005-04-16  226  
91d591c387af34 Thomas Gleixner   2013-03-21  227  void arch_cpu_idle_dead(void)
^1da177e4c3f41 Linus Torvalds    2005-04-16  228  {
91d591c387af34 Thomas Gleixner   2013-03-21  229  	play_dead();
0888f06ac99f99 Ingo Molnar       2006-12-22 @230  }
1e185b97b43640 Kenneth W Chen    2005-11-15  231  
91d591c387af34 Thomas Gleixner   2013-03-21  232  void arch_cpu_idle(void)
91d591c387af34 Thomas Gleixner   2013-03-21  233  {
91d591c387af34 Thomas Gleixner   2013-03-21  234  	void (*mark_idle)(int) = ia64_mark_idle;
91d591c387af34 Thomas Gleixner   2013-03-21  235  
^1da177e4c3f41 Linus Torvalds    2005-04-16  236  #ifdef CONFIG_SMP
^1da177e4c3f41 Linus Torvalds    2005-04-16  237  	min_xtp();
^1da177e4c3f41 Linus Torvalds    2005-04-16  238  #endif
7d5f9c0f102550 Zwane Mwaikambo   2005-03-30  239  	rmb();
^1da177e4c3f41 Linus Torvalds    2005-04-16  240  	if (mark_idle)
^1da177e4c3f41 Linus Torvalds    2005-04-16  241  		(*mark_idle)(1);
^1da177e4c3f41 Linus Torvalds    2005-04-16  242  
58c644ba512cfb Peter Zijlstra    2020-11-20  243  	raw_safe_halt();
91d591c387af34 Thomas Gleixner   2013-03-21  244  
^1da177e4c3f41 Linus Torvalds    2005-04-16  245  	if (mark_idle)
^1da177e4c3f41 Linus Torvalds    2005-04-16  246  		(*mark_idle)(0);
^1da177e4c3f41 Linus Torvalds    2005-04-16  247  #ifdef CONFIG_SMP
^1da177e4c3f41 Linus Torvalds    2005-04-16  248  	normal_xtp();
^1da177e4c3f41 Linus Torvalds    2005-04-16  249  #endif
64c7c8f8855962 Nicholas Piggin   2005-11-08  250  }
^1da177e4c3f41 Linus Torvalds    2005-04-16  251  
^1da177e4c3f41 Linus Torvalds    2005-04-16  252  void
^1da177e4c3f41 Linus Torvalds    2005-04-16  253  ia64_save_extra (struct task_struct *task)
^1da177e4c3f41 Linus Torvalds    2005-04-16  254  {
^1da177e4c3f41 Linus Torvalds    2005-04-16  255  	if ((task->thread.flags & IA64_THREAD_DBG_VALID) != 0)
^1da177e4c3f41 Linus Torvalds    2005-04-16  256  		ia64_save_debug_regs(&task->thread.dbr[0]);
^1da177e4c3f41 Linus Torvalds    2005-04-16  257  }
^1da177e4c3f41 Linus Torvalds    2005-04-16  258  
^1da177e4c3f41 Linus Torvalds    2005-04-16  259  void
^1da177e4c3f41 Linus Torvalds    2005-04-16  260  ia64_load_extra (struct task_struct *task)
^1da177e4c3f41 Linus Torvalds    2005-04-16  261  {
^1da177e4c3f41 Linus Torvalds    2005-04-16  262  	if ((task->thread.flags & IA64_THREAD_DBG_VALID) != 0)
^1da177e4c3f41 Linus Torvalds    2005-04-16  263  		ia64_load_debug_regs(&task->thread.dbr[0]);
^1da177e4c3f41 Linus Torvalds    2005-04-16  264  }
^1da177e4c3f41 Linus Torvalds    2005-04-16  265  
^1da177e4c3f41 Linus Torvalds    2005-04-16  266  /*
^1da177e4c3f41 Linus Torvalds    2005-04-16  267   * Copy the state of an ia-64 thread.
^1da177e4c3f41 Linus Torvalds    2005-04-16  268   *
^1da177e4c3f41 Linus Torvalds    2005-04-16  269   * We get here through the following  call chain:
^1da177e4c3f41 Linus Torvalds    2005-04-16  270   *
^1da177e4c3f41 Linus Torvalds    2005-04-16  271   *	from user-level:	from kernel:
^1da177e4c3f41 Linus Torvalds    2005-04-16  272   *
^1da177e4c3f41 Linus Torvalds    2005-04-16  273   *	<clone syscall>	        <some kernel call frames>
^1da177e4c3f41 Linus Torvalds    2005-04-16  274   *	sys_clone		   :
f8c40ebe659db3 Christian Brauner 2020-08-19  275   *	kernel_clone		kernel_clone
^1da177e4c3f41 Linus Torvalds    2005-04-16  276   *	copy_thread		copy_thread
^1da177e4c3f41 Linus Torvalds    2005-04-16  277   *
^1da177e4c3f41 Linus Torvalds    2005-04-16  278   * This means that the stack layout is as follows:
^1da177e4c3f41 Linus Torvalds    2005-04-16  279   *
^1da177e4c3f41 Linus Torvalds    2005-04-16  280   *	+---------------------+ (highest addr)
^1da177e4c3f41 Linus Torvalds    2005-04-16  281   *	|   struct pt_regs    |
^1da177e4c3f41 Linus Torvalds    2005-04-16  282   *	+---------------------+
^1da177e4c3f41 Linus Torvalds    2005-04-16  283   *	| struct switch_stack |
^1da177e4c3f41 Linus Torvalds    2005-04-16  284   *	+---------------------+
^1da177e4c3f41 Linus Torvalds    2005-04-16  285   *	|                     |
^1da177e4c3f41 Linus Torvalds    2005-04-16  286   *	|    memory stack     |
^1da177e4c3f41 Linus Torvalds    2005-04-16  287   *	|                     | <-- sp (lowest addr)
^1da177e4c3f41 Linus Torvalds    2005-04-16  288   *	+---------------------+
^1da177e4c3f41 Linus Torvalds    2005-04-16  289   *
^1da177e4c3f41 Linus Torvalds    2005-04-16  290   * Observe that we copy the unat values that are in pt_regs and switch_stack.  Spilling an
^1da177e4c3f41 Linus Torvalds    2005-04-16  291   * integer to address X causes bit N in ar.unat to be set to the NaT bit of the register,
^1da177e4c3f41 Linus Torvalds    2005-04-16  292   * with N=(X & 0x1ff)/8.  Thus, copying the unat value preserves the NaT bits ONLY if the
^1da177e4c3f41 Linus Torvalds    2005-04-16  293   * pt_regs structure in the parent is congruent to that of the child, modulo 512.  Since
^1da177e4c3f41 Linus Torvalds    2005-04-16  294   * the stack is page aligned and the page size is at least 4KB, this is always the case,
^1da177e4c3f41 Linus Torvalds    2005-04-16  295   * so there is nothing to worry about.
^1da177e4c3f41 Linus Torvalds    2005-04-16  296   */
^1da177e4c3f41 Linus Torvalds    2005-04-16  297  int
714acdbd1c94e7 Christian Brauner 2020-06-11  298  copy_thread(unsigned long clone_flags, unsigned long user_stack_base,
714acdbd1c94e7 Christian Brauner 2020-06-11  299  	    unsigned long user_stack_size, struct task_struct *p, unsigned long tls)
^1da177e4c3f41 Linus Torvalds    2005-04-16  300  {
32974ad4907cdd Tony Luck         2010-02-08  301  	extern char ia64_ret_from_clone;
^1da177e4c3f41 Linus Torvalds    2005-04-16  302  	struct switch_stack *child_stack, *stack;
^1da177e4c3f41 Linus Torvalds    2005-04-16  303  	unsigned long rbs, child_rbs, rbs_size;
^1da177e4c3f41 Linus Torvalds    2005-04-16  304  	struct pt_regs *child_ptregs;
afa86fc426ff7e Al Viro           2012-10-22  305  	struct pt_regs *regs = current_pt_regs();
^1da177e4c3f41 Linus Torvalds    2005-04-16  306  	int retval = 0;
^1da177e4c3f41 Linus Torvalds    2005-04-16  307  
^1da177e4c3f41 Linus Torvalds    2005-04-16  308  	child_ptregs = (struct pt_regs *) ((unsigned long) p + IA64_STK_OFFSET) - 1;
^1da177e4c3f41 Linus Torvalds    2005-04-16  309  	child_stack = (struct switch_stack *) child_ptregs - 1;
^1da177e4c3f41 Linus Torvalds    2005-04-16  310  
^1da177e4c3f41 Linus Torvalds    2005-04-16  311  	rbs = (unsigned long) current + IA64_RBS_OFFSET;
^1da177e4c3f41 Linus Torvalds    2005-04-16  312  	child_rbs = (unsigned long) p + IA64_RBS_OFFSET;
^1da177e4c3f41 Linus Torvalds    2005-04-16  313  
^1da177e4c3f41 Linus Torvalds    2005-04-16  314  	/* copy parts of thread_struct: */
^1da177e4c3f41 Linus Torvalds    2005-04-16  315  	p->thread.ksp = (unsigned long) child_stack - 16;
^1da177e4c3f41 Linus Torvalds    2005-04-16  316  
^1da177e4c3f41 Linus Torvalds    2005-04-16  317  	/*
^1da177e4c3f41 Linus Torvalds    2005-04-16  318  	 * NOTE: The calling convention considers all floating point
^1da177e4c3f41 Linus Torvalds    2005-04-16  319  	 * registers in the high partition (fph) to be scratch.  Since
^1da177e4c3f41 Linus Torvalds    2005-04-16  320  	 * the only way to get to this point is through a system call,
^1da177e4c3f41 Linus Torvalds    2005-04-16  321  	 * we know that the values in fph are all dead.  Hence, there
^1da177e4c3f41 Linus Torvalds    2005-04-16  322  	 * is no need to inherit the fph state from the parent to the
^1da177e4c3f41 Linus Torvalds    2005-04-16  323  	 * child and all we have to do is to make sure that
^1da177e4c3f41 Linus Torvalds    2005-04-16  324  	 * IA64_THREAD_FPH_VALID is cleared in the child.
^1da177e4c3f41 Linus Torvalds    2005-04-16  325  	 *
^1da177e4c3f41 Linus Torvalds    2005-04-16  326  	 * XXX We could push this optimization a bit further by
^1da177e4c3f41 Linus Torvalds    2005-04-16  327  	 * clearing IA64_THREAD_FPH_VALID on ANY system call.
^1da177e4c3f41 Linus Torvalds    2005-04-16  328  	 * However, it's not clear this is worth doing.  Also, it
^1da177e4c3f41 Linus Torvalds    2005-04-16  329  	 * would be a slight deviation from the normal Linux system
^1da177e4c3f41 Linus Torvalds    2005-04-16  330  	 * call behavior where scratch registers are preserved across
^1da177e4c3f41 Linus Torvalds    2005-04-16  331  	 * system calls (unless used by the system call itself).
^1da177e4c3f41 Linus Torvalds    2005-04-16  332  	 */
^1da177e4c3f41 Linus Torvalds    2005-04-16  333  #	define THREAD_FLAGS_TO_CLEAR	(IA64_THREAD_FPH_VALID | IA64_THREAD_DBG_VALID \
^1da177e4c3f41 Linus Torvalds    2005-04-16  334  					 | IA64_THREAD_PM_VALID)
^1da177e4c3f41 Linus Torvalds    2005-04-16  335  #	define THREAD_FLAGS_TO_SET	0
^1da177e4c3f41 Linus Torvalds    2005-04-16  336  	p->thread.flags = ((current->thread.flags & ~THREAD_FLAGS_TO_CLEAR)
^1da177e4c3f41 Linus Torvalds    2005-04-16  337  			   | THREAD_FLAGS_TO_SET);
54d496c3915a10 Al Viro           2012-10-14  338  
^1da177e4c3f41 Linus Torvalds    2005-04-16  339  	ia64_drop_fpu(p);	/* don't pick up stale state from a CPU's fph */
^1da177e4c3f41 Linus Torvalds    2005-04-16  340  
4727dc20e04222 Jens Axboe        2021-02-17  341  	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
54d496c3915a10 Al Viro           2012-10-14  342  		if (unlikely(!user_stack_base)) {
54d496c3915a10 Al Viro           2012-10-14  343  			/* fork_idle() called us */
54d496c3915a10 Al Viro           2012-10-14  344  			return 0;
54d496c3915a10 Al Viro           2012-10-14  345  		}
54d496c3915a10 Al Viro           2012-10-14  346  		memset(child_stack, 0, sizeof(*child_ptregs) + sizeof(*child_stack));
54d496c3915a10 Al Viro           2012-10-14  347  		child_stack->r4 = user_stack_base;	/* payload */
54d496c3915a10 Al Viro           2012-10-14  348  		child_stack->r5 = user_stack_size;	/* argument */
54d496c3915a10 Al Viro           2012-10-14  349  		/*
54d496c3915a10 Al Viro           2012-10-14  350  		 * Preserve PSR bits, except for bits 32-34 and 37-45,
54d496c3915a10 Al Viro           2012-10-14  351  		 * which we can't read.
54d496c3915a10 Al Viro           2012-10-14  352  		 */
54d496c3915a10 Al Viro           2012-10-14  353  		child_ptregs->cr_ipsr = ia64_getreg(_IA64_REG_PSR) | IA64_PSR_BN;
54d496c3915a10 Al Viro           2012-10-14  354  		/* mark as valid, empty frame */
54d496c3915a10 Al Viro           2012-10-14  355  		child_ptregs->cr_ifs = 1UL << 63;
54d496c3915a10 Al Viro           2012-10-14  356  		child_stack->ar_fpsr = child_ptregs->ar_fpsr
54d496c3915a10 Al Viro           2012-10-14  357  			= ia64_getreg(_IA64_REG_AR_FPSR);
54d496c3915a10 Al Viro           2012-10-14  358  		child_stack->pr = (1 << PRED_KERNEL_STACK);
54d496c3915a10 Al Viro           2012-10-14  359  		child_stack->ar_bspstore = child_rbs;
54d496c3915a10 Al Viro           2012-10-14  360  		child_stack->b0 = (unsigned long) &ia64_ret_from_clone;
54d496c3915a10 Al Viro           2012-10-14  361  
54d496c3915a10 Al Viro           2012-10-14  362  		/* stop some PSR bits from being inherited.
54d496c3915a10 Al Viro           2012-10-14  363  		 * the psr.up/psr.pp bits must be cleared on fork but inherited on execve()
54d496c3915a10 Al Viro           2012-10-14  364  		 * therefore we must specify them explicitly here and not include them in
54d496c3915a10 Al Viro           2012-10-14  365  		 * IA64_PSR_BITS_TO_CLEAR.
54d496c3915a10 Al Viro           2012-10-14  366  		 */
54d496c3915a10 Al Viro           2012-10-14  367  		child_ptregs->cr_ipsr = ((child_ptregs->cr_ipsr | IA64_PSR_BITS_TO_SET)
54d496c3915a10 Al Viro           2012-10-14  368  				 & ~(IA64_PSR_BITS_TO_CLEAR | IA64_PSR_PP | IA64_PSR_UP));
54d496c3915a10 Al Viro           2012-10-14  369  
54d496c3915a10 Al Viro           2012-10-14  370  		return 0;
54d496c3915a10 Al Viro           2012-10-14  371  	}
54d496c3915a10 Al Viro           2012-10-14  372  	stack = ((struct switch_stack *) regs) - 1;
54d496c3915a10 Al Viro           2012-10-14  373  	/* copy parent's switch_stack & pt_regs to child: */
54d496c3915a10 Al Viro           2012-10-14  374  	memcpy(child_stack, stack, sizeof(*child_ptregs) + sizeof(*child_stack));
54d496c3915a10 Al Viro           2012-10-14  375  
54d496c3915a10 Al Viro           2012-10-14  376  	/* copy the parent's register backing store to the child: */
54d496c3915a10 Al Viro           2012-10-14  377  	rbs_size = stack->ar_bspstore - rbs;
54d496c3915a10 Al Viro           2012-10-14  378  	memcpy((void *) child_rbs, (void *) rbs, rbs_size);
54d496c3915a10 Al Viro           2012-10-14  379  	if (clone_flags & CLONE_SETTLS)
ddb815bd545901 Christian Brauner 2020-05-17  380  		child_ptregs->r13 = tls;
54d496c3915a10 Al Viro           2012-10-14  381  	if (user_stack_base) {
54d496c3915a10 Al Viro           2012-10-14  382  		child_ptregs->r12 = user_stack_base + user_stack_size - 16;
54d496c3915a10 Al Viro           2012-10-14  383  		child_ptregs->ar_bspstore = user_stack_base;
54d496c3915a10 Al Viro           2012-10-14  384  		child_ptregs->ar_rnat = 0;
54d496c3915a10 Al Viro           2012-10-14  385  		child_ptregs->loadrs = 0;
54d496c3915a10 Al Viro           2012-10-14  386  	}
54d496c3915a10 Al Viro           2012-10-14  387  	child_stack->ar_bspstore = child_rbs + rbs_size;
54d496c3915a10 Al Viro           2012-10-14  388  	child_stack->b0 = (unsigned long) &ia64_ret_from_clone;
54d496c3915a10 Al Viro           2012-10-14  389  
54d496c3915a10 Al Viro           2012-10-14  390  	/* stop some PSR bits from being inherited.
54d496c3915a10 Al Viro           2012-10-14  391  	 * the psr.up/psr.pp bits must be cleared on fork but inherited on execve()
54d496c3915a10 Al Viro           2012-10-14  392  	 * therefore we must specify them explicitly here and not include them in
54d496c3915a10 Al Viro           2012-10-14  393  	 * IA64_PSR_BITS_TO_CLEAR.
54d496c3915a10 Al Viro           2012-10-14  394  	 */
54d496c3915a10 Al Viro           2012-10-14  395  	child_ptregs->cr_ipsr = ((child_ptregs->cr_ipsr | IA64_PSR_BITS_TO_SET)
54d496c3915a10 Al Viro           2012-10-14  396  				 & ~(IA64_PSR_BITS_TO_CLEAR | IA64_PSR_PP | IA64_PSR_UP));
^1da177e4c3f41 Linus Torvalds    2005-04-16  397  	return retval;
^1da177e4c3f41 Linus Torvalds    2005-04-16  398  }
^1da177e4c3f41 Linus Torvalds    2005-04-16  399  
ddb815bd545901 Christian Brauner 2020-05-17 @400  asmlinkage long ia64_clone(unsigned long clone_flags, unsigned long stack_start,
ddb815bd545901 Christian Brauner 2020-05-17  401  			   unsigned long stack_size, unsigned long parent_tidptr,
ddb815bd545901 Christian Brauner 2020-05-17  402  			   unsigned long child_tidptr, unsigned long tls)
ddb815bd545901 Christian Brauner 2020-05-17  403  {
ddb815bd545901 Christian Brauner 2020-05-17  404  	struct kernel_clone_args args = {
ddb815bd545901 Christian Brauner 2020-05-17  405  		.flags		= (lower_32_bits(clone_flags) & ~CSIGNAL),
ddb815bd545901 Christian Brauner 2020-05-17  406  		.pidfd		= (int __user *)parent_tidptr,
ddb815bd545901 Christian Brauner 2020-05-17  407  		.child_tid	= (int __user *)child_tidptr,
ddb815bd545901 Christian Brauner 2020-05-17  408  		.parent_tid	= (int __user *)parent_tidptr,
ddb815bd545901 Christian Brauner 2020-05-17  409  		.exit_signal	= (lower_32_bits(clone_flags) & CSIGNAL),
ddb815bd545901 Christian Brauner 2020-05-17  410  		.stack		= stack_start,
ddb815bd545901 Christian Brauner 2020-05-17  411  		.stack_size	= stack_size,
ddb815bd545901 Christian Brauner 2020-05-17  412  		.tls		= tls,
ddb815bd545901 Christian Brauner 2020-05-17  413  	};
ddb815bd545901 Christian Brauner 2020-05-17  414  
f8c40ebe659db3 Christian Brauner 2020-08-19  415  	return kernel_clone(&args);
ddb815bd545901 Christian Brauner 2020-05-17  416  }
ddb815bd545901 Christian Brauner 2020-05-17  417  

:::::: The code at line 230 was first introduced by commit
:::::: 0888f06ac99f993df2bb4c479f5b9306dafe154f [PATCH] sched: fix bad missed wakeups in the i386, x86_64, ia64, ACPI and APM idle code

:::::: TO: Ingo Molnar <mingo@elte.hu>
:::::: CC: Linus Torvalds <torvalds@woody.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
