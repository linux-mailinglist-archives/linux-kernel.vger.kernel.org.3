Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8162547F3AF
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 16:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbhLYP6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 10:58:43 -0500
Received: from mga18.intel.com ([134.134.136.126]:60905 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232141AbhLYP6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 10:58:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640447922; x=1671983922;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8z4iCg/5GH1skeCVVPK044mItc6SXouJxXH1T2+/Vds=;
  b=Lj1hzO3uemxfxHQexpqps8yDYsq+r4JbC6RkOCezp29YCGE613OCvvP+
   KPpRZ9kfFYMV+bTmcbmwKdh/HyD/6sXGLCl+J3+sqZA31rw+nqSk/zAf2
   sR9MAJf9lWNbsVFocrI1+U6gPGzaNF4ZZshLrz8mY85KJDowRiul/NSFy
   jsecK2WEW0BX/52cKeElfk1pEf3NgAK4cmVoSD/CXUxV5NdmBWt5/accR
   MHb1hu7ugrkOZR4jAeHfFRWmLx8OHtMeONhufQwL0X49aBsPBh7P27e4b
   OQoOu+3t1c4q+HZgD9aYbhovWQqJWnbsnGTPXtlds4iQwcmEhMymvelfh
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10208"; a="227894822"
X-IronPort-AV: E=Sophos;i="5.88,235,1635231600"; 
   d="scan'208";a="227894822"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2021 07:58:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,235,1635231600"; 
   d="scan'208";a="509401734"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 25 Dec 2021 07:58:41 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n19RQ-0004PL-DO; Sat, 25 Dec 2021 15:58:40 +0000
Date:   Sat, 25 Dec 2021 23:58:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Helge Deller <deller@gmx.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [deller-parisc:5.16-vdso-5 1/1] arch/parisc/kernel/signal.c:229:23:
 warning: variable 'start' set but not used
Message-ID: <202112252341.zoYwZgrC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git 5.16-vdso-5
head:   31c51d49e3f587cdcdf22b313b5bbce80b31405f
commit: 31c51d49e3f587cdcdf22b313b5bbce80b31405f [1/1] add testing vDSO support (v5)
config: parisc-defconfig (https://download.01.org/0day-ci/archive/20211225/202112252341.zoYwZgrC-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git/commit/?id=31c51d49e3f587cdcdf22b313b5bbce80b31405f
        git remote add deller-parisc https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git
        git fetch --no-tags deller-parisc 5.16-vdso-5
        git checkout 31c51d49e3f587cdcdf22b313b5bbce80b31405f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash arch/parisc/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/parisc/kernel/signal.c:81:1: warning: no previous prototype for 'sys_rt_sigreturn' [-Wmissing-prototypes]
      81 | sys_rt_sigreturn(struct pt_regs *regs, int in_syscall)
         | ^~~~~~~~~~~~~~~~
   arch/parisc/kernel/signal.c: In function 'setup_rt_frame':
>> arch/parisc/kernel/signal.c:229:23: warning: variable 'start' set but not used [-Wunused-but-set-variable]
     229 |         unsigned long start;
         |                       ^~~~~
   arch/parisc/kernel/signal.c: At top level:
   arch/parisc/kernel/signal.c:601:6: warning: no previous prototype for 'do_notify_resume' [-Wmissing-prototypes]
     601 | void do_notify_resume(struct pt_regs *regs, long in_syscall)
         |      ^~~~~~~~~~~~~~~~


vim +/start +229 arch/parisc/kernel/signal.c

    79	
    80	void
  > 81	sys_rt_sigreturn(struct pt_regs *regs, int in_syscall)
    82	{
    83		struct rt_sigframe __user *frame;
    84		sigset_t set;
    85		unsigned long usp = (regs->gr[30] & ~(0x01UL));
    86		unsigned long sigframe_size = PARISC_RT_SIGFRAME_SIZE;
    87	#ifdef CONFIG_64BIT
    88		struct compat_rt_sigframe __user * compat_frame;
    89		
    90		if (is_compat_task())
    91			sigframe_size = PARISC_RT_SIGFRAME_SIZE32;
    92	#endif
    93	
    94		current->restart_block.fn = do_no_restart_syscall;
    95	
    96		/* Unwind the user stack to get the rt_sigframe structure. */
    97		frame = (struct rt_sigframe __user *)
    98			(usp - sigframe_size);
    99	
   100		DBG(2,"*** sys_rt_sigreturn: frame is %p pid %d\n", frame, task_pid_nr(current));
   101	
   102		regs->orig_r28 = 1; /* no restarts for sigreturn */
   103	
   104	#ifdef CONFIG_64BIT
   105		compat_frame = (struct compat_rt_sigframe __user *)frame;
   106		
   107		if (is_compat_task()) {
   108			DBG(2,"sys_rt_sigreturn: ELF32 process.\n");
   109			if (get_compat_sigset(&set, &compat_frame->uc.uc_sigmask))
   110				goto give_sigsegv;
   111		} else
   112	#endif
   113		{
   114			if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
   115				goto give_sigsegv;
   116		}
   117			
   118		set_current_blocked(&set);
   119	
   120		/* Good thing we saved the old gr[30], eh? */
   121	#ifdef CONFIG_64BIT
   122		if (is_compat_task()) {
   123			DBG(1,"sys_rt_sigreturn: compat_frame->uc.uc_mcontext 0x%p\n",
   124					&compat_frame->uc.uc_mcontext);
   125	// FIXME: Load upper half from register file
   126			if (restore_sigcontext32(&compat_frame->uc.uc_mcontext, 
   127						&compat_frame->regs, regs))
   128				goto give_sigsegv;
   129			DBG(1,"sys_rt_sigreturn: usp %#08lx stack 0x%p\n", 
   130					usp, &compat_frame->uc.uc_stack);
   131			if (compat_restore_altstack(&compat_frame->uc.uc_stack))
   132				goto give_sigsegv;
   133		} else
   134	#endif
   135		{
   136			DBG(1,"sys_rt_sigreturn: frame->uc.uc_mcontext 0x%p\n",
   137					&frame->uc.uc_mcontext);
   138			if (restore_sigcontext(&frame->uc.uc_mcontext, regs))
   139				goto give_sigsegv;
   140			DBG(1,"sys_rt_sigreturn: usp %#08lx stack 0x%p\n", 
   141					usp, &frame->uc.uc_stack);
   142			if (restore_altstack(&frame->uc.uc_stack))
   143				goto give_sigsegv;
   144		}
   145			
   146	
   147	
   148		/* If we are on the syscall path IAOQ will not be restored, and
   149		 * if we are on the interrupt path we must not corrupt gr31.
   150		 */
   151		if (in_syscall)
   152			regs->gr[31] = regs->iaoq[0];
   153	
   154	#if DEBUG_SIG
   155		DBG(1,"sys_rt_sigreturn: returning to %#lx, DUMPING REGS:\n", regs->iaoq[0]);
   156		show_regs(regs);
   157	#endif
   158		return;
   159	
   160	give_sigsegv:
   161		DBG(1,"sys_rt_sigreturn: Sending SIGSEGV\n");
   162		force_sig(SIGSEGV);
   163		return;
   164	}
   165	
   166	/*
   167	 * Set up a signal frame.
   168	 */
   169	
   170	static inline void __user *
   171	get_sigframe(struct k_sigaction *ka, unsigned long sp, size_t frame_size)
   172	{
   173		/*FIXME: ELF32 vs. ELF64 has different frame_size, but since we
   174		  don't use the parameter it doesn't matter */
   175	
   176		DBG(1,"get_sigframe: ka = %#lx, sp = %#lx, frame_size = %#lx\n",
   177				(unsigned long)ka, sp, frame_size);
   178		
   179		/* Align alternate stack and reserve 64 bytes for the signal
   180		   handler's frame marker.  */
   181		if ((ka->sa.sa_flags & SA_ONSTACK) != 0 && ! sas_ss_flags(sp))
   182			sp = (current->sas_ss_sp + 0x7f) & ~0x3f; /* Stacks grow up! */
   183	
   184		DBG(1,"get_sigframe: Returning sp = %#lx\n", (unsigned long)sp);
   185		return (void __user *) sp; /* Stacks grow up.  Fun. */
   186	}
   187	
   188	static long
   189	setup_sigcontext(struct sigcontext __user *sc, struct pt_regs *regs, int in_syscall)
   190			 
   191	{
   192		unsigned long flags = 0;
   193		long err = 0;
   194	
   195		if (on_sig_stack((unsigned long) sc))
   196			flags |= PARISC_SC_FLAG_ONSTACK;
   197		if (in_syscall) {
   198			flags |= PARISC_SC_FLAG_IN_SYSCALL;
   199			/* regs->iaoq is undefined in the syscall return path */
   200			err |= __put_user(regs->gr[31], &sc->sc_iaoq[0]);
   201			err |= __put_user(regs->gr[31]+4, &sc->sc_iaoq[1]);
   202			err |= __put_user(regs->sr[3], &sc->sc_iasq[0]);
   203			err |= __put_user(regs->sr[3], &sc->sc_iasq[1]);
   204			DBG(1,"setup_sigcontext: iaoq %#lx / %#lx (in syscall)\n",
   205				regs->gr[31], regs->gr[31]+4);
   206		} else {
   207			err |= __copy_to_user(sc->sc_iaoq, regs->iaoq, sizeof(regs->iaoq));
   208			err |= __copy_to_user(sc->sc_iasq, regs->iasq, sizeof(regs->iasq));
   209			DBG(1,"setup_sigcontext: iaoq %#lx / %#lx (not in syscall)\n",
   210				regs->iaoq[0], regs->iaoq[1]);
   211		}
   212	
   213		err |= __put_user(flags, &sc->sc_flags);
   214		err |= __copy_to_user(sc->sc_gr, regs->gr, sizeof(regs->gr));
   215		err |= __copy_to_user(sc->sc_fr, regs->fr, sizeof(regs->fr));
   216		err |= __put_user(regs->sar, &sc->sc_sar);
   217		DBG(1,"setup_sigcontext: r28 is %ld\n", regs->gr[28]);
   218	
   219		return err;
   220	}
   221	
   222	static long
   223	setup_rt_frame(struct ksignal *ksig, sigset_t *set, struct pt_regs *regs,
   224		       int in_syscall)
   225	{
   226		struct rt_sigframe __user *frame;
   227		unsigned long rp, usp;
   228		unsigned long haddr, sigframe_size;
 > 229		unsigned long start;
   230		int err = 0;
   231	#ifdef CONFIG_64BIT
   232		struct compat_rt_sigframe __user * compat_frame;
   233	#endif
   234		
   235		usp = (regs->gr[30] & ~(0x01UL));
   236		sigframe_size = PARISC_RT_SIGFRAME_SIZE;
   237	#ifdef CONFIG_64BIT
   238		if (is_compat_task()) {
   239			/* The gcc alloca implementation leaves garbage in the upper 32 bits of sp */
   240			usp = (compat_uint_t)usp;
   241			sigframe_size = PARISC_RT_SIGFRAME_SIZE32;
   242		}
   243	#endif
   244		frame = get_sigframe(&ksig->ka, usp, sigframe_size);
   245	
   246		DBG(1,"SETUP_RT_FRAME: START\n");
   247		DBG(1,"setup_rt_frame: frame %p info %p\n", frame, ksig->info);
   248	
   249		start = (unsigned long) frame;
   250		// if (start >= user_addr_max() - sigframe_size)
   251		//	return -EFAULT;
   252		
   253	#ifdef CONFIG_64BIT
   254	
   255		compat_frame = (struct compat_rt_sigframe __user *)frame;
   256		
   257		if (is_compat_task()) {
   258			DBG(1,"setup_rt_frame: frame->info = 0x%p\n", &compat_frame->info);
   259			err |= copy_siginfo_to_user32(&compat_frame->info, &ksig->info);
   260			err |= __compat_save_altstack( &compat_frame->uc.uc_stack, regs->gr[30]);
   261			DBG(1,"setup_rt_frame: frame->uc = 0x%p\n", &compat_frame->uc);
   262			DBG(1,"setup_rt_frame: frame->uc.uc_mcontext = 0x%p\n", &compat_frame->uc.uc_mcontext);
   263			err |= setup_sigcontext32(&compat_frame->uc.uc_mcontext, 
   264						&compat_frame->regs, regs, in_syscall);
   265			err |= put_compat_sigset(&compat_frame->uc.uc_sigmask, set,
   266						 sizeof(compat_sigset_t));
   267		} else
   268	#endif
   269		{	
   270			DBG(1,"setup_rt_frame: frame->info = 0x%p\n", &frame->info);
   271			err |= copy_siginfo_to_user(&frame->info, &ksig->info);
   272			err |= __save_altstack(&frame->uc.uc_stack, regs->gr[30]);
   273			DBG(1,"setup_rt_frame: frame->uc = 0x%p\n", &frame->uc);
   274			DBG(1,"setup_rt_frame: frame->uc.uc_mcontext = 0x%p\n", &frame->uc.uc_mcontext);
   275			err |= setup_sigcontext(&frame->uc.uc_mcontext, regs, in_syscall);
   276			/* FIXME: Should probably be converted as well for the compat case */
   277			err |= __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
   278		}
   279		
   280		if (err)
   281			return -EFAULT;
   282	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
