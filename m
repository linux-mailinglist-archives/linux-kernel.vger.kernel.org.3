Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE03563DE7
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 05:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbiGBDQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 23:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiGBDQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 23:16:35 -0400
Received: from mga01.intel.com (unknown [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A352B1AC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 20:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656731793; x=1688267793;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LG9K9EwOECMrDSejcf733/0+DxJ2NMTz2nYldlSCCvk=;
  b=HcbHGpU9xF6NMWGOkiMwiBFmaAFEDXRKLhgT1Rz9D/W4rgvV52f2Wc0Z
   D2y3TEM1/7/4o04x1TSmCXC4w6yviMxbfsQO6ls0uSc2MmOhhbV5ksh1R
   PNUvjGk0ou7mLWp2zkTolwQdEFwgYMHkZOt8b9hp2IHsGeEW+khY/9SB5
   i9xrZh8tjocGp4TX1hMcfTvEIPha1JFS/1Yd6hgTfzxEKbN4DyA3xHK55
   dJIBAK6nM9214SmHvr2TTxeYzv0ZtCydijn38sLschiuX7enQTsT/FJfo
   jTuyVIdLD6v5AAsC9LHfwxTwuaPbXaJDtpDZpqjG2VFVL5jSkxcNXnrQq
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="308315731"
X-IronPort-AV: E=Sophos;i="5.92,239,1650956400"; 
   d="scan'208";a="308315731"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 20:16:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,239,1650956400"; 
   d="scan'208";a="596474636"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 01 Jul 2022 20:16:32 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o7TcV-000Eju-3T;
        Sat, 02 Jul 2022 03:16:31 +0000
Date:   Sat, 2 Jul 2022 11:15:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jcmvbkbc-xtensa:xtensa-5.19-esp32 9/9] kernel/ptrace.c:1193:42:
 error: 'mm_context_t' has no member named 'exec_fdpic_loadmap'
Message-ID: <202207021158.pAtpGDCH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jcmvbkbc/linux-xtensa xtensa-5.19-esp32
head:   a44bcd03203280e59963b3eb3bfba38402be6e33
commit: a44bcd03203280e59963b3eb3bfba38402be6e33 [9/9] WIP: xtensa: add FDPIC support
config: xtensa-allyesconfig (https://download.01.org/0day-ci/archive/20220702/202207021158.pAtpGDCH-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jcmvbkbc/linux-xtensa/commit/a44bcd03203280e59963b3eb3bfba38402be6e33
        git remote add jcmvbkbc-xtensa https://github.com/jcmvbkbc/linux-xtensa
        git fetch --no-tags jcmvbkbc-xtensa xtensa-5.19-esp32
        git checkout a44bcd03203280e59963b3eb3bfba38402be6e33
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/ptrace.c: In function 'ptrace_request':
>> kernel/ptrace.c:1193:42: error: 'mm_context_t' has no member named 'exec_fdpic_loadmap'
    1193 |                         tmp = mm->context.exec_fdpic_loadmap;
         |                                          ^
>> kernel/ptrace.c:1196:42: error: 'mm_context_t' has no member named 'interp_fdpic_loadmap'
    1196 |                         tmp = mm->context.interp_fdpic_loadmap;
         |                                          ^
--
   fs/binfmt_elf_fdpic.c: In function 'load_elf_fdpic_binary':
>> fs/binfmt_elf_fdpic.c:364:29: error: 'mm_context_t' has no member named 'exec_fdpic_loadmap'
     364 |         current->mm->context.exec_fdpic_loadmap = 0;
         |                             ^
>> fs/binfmt_elf_fdpic.c:365:29: error: 'mm_context_t' has no member named 'interp_fdpic_loadmap'
     365 |         current->mm->context.interp_fdpic_loadmap = 0;
         |                             ^
   fs/binfmt_elf_fdpic.c: In function 'create_elf_fdpic_tables':
   fs/binfmt_elf_fdpic.c:570:29: error: 'mm_context_t' has no member named 'exec_fdpic_loadmap'
     570 |         current->mm->context.exec_fdpic_loadmap = (unsigned long) sp;
         |                             ^
   fs/binfmt_elf_fdpic.c:583:37: error: 'mm_context_t' has no member named 'interp_fdpic_loadmap'
     583 |                 current->mm->context.interp_fdpic_loadmap = (unsigned long) sp;
         |                                     ^
   fs/binfmt_elf_fdpic.c: In function 'fill_elf_fdpic_header':
>> fs/binfmt_elf_fdpic.c:1252:24: error: 'ELF_FDPIC_CORE_EFLAGS' undeclared (first use in this function)
    1252 |         elf->e_flags = ELF_FDPIC_CORE_EFLAGS;
         |                        ^~~~~~~~~~~~~~~~~~~~~
   fs/binfmt_elf_fdpic.c:1252:24: note: each undeclared identifier is reported only once for each function it appears in
   fs/binfmt_elf_fdpic.c: In function 'elf_dump_thread_status':
   fs/binfmt_elf_fdpic.c:1393:59: error: 'mm_context_t' has no member named 'exec_fdpic_loadmap'
    1393 |         t->prstatus.pr_exec_fdpic_loadmap = p->mm->context.exec_fdpic_loadmap;
         |                                                           ^
   fs/binfmt_elf_fdpic.c:1394:61: error: 'mm_context_t' has no member named 'interp_fdpic_loadmap'
    1394 |         t->prstatus.pr_interp_fdpic_loadmap = p->mm->context.interp_fdpic_loadmap;
         |                                                             ^


vim +1193 kernel/ptrace.c

2225a122ae26d5 Suresh Siddha     2010-02-11  1029  
^1da177e4c3f41 Linus Torvalds    2005-04-16  1030  int ptrace_request(struct task_struct *child, long request,
4abf986960ecda Namhyung Kim      2010-10-27  1031  		   unsigned long addr, unsigned long data)
^1da177e4c3f41 Linus Torvalds    2005-04-16  1032  {
fca26f260c528e Tejun Heo         2011-06-14  1033  	bool seized = child->ptrace & PT_SEIZED;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1034  	int ret = -EIO;
ae7795bc6187a1 Eric W. Biederman 2018-09-25  1035  	kernel_siginfo_t siginfo, *si;
9fed81dc40f5a1 Namhyung Kim      2010-10-27  1036  	void __user *datavp = (void __user *) data;
9fed81dc40f5a1 Namhyung Kim      2010-10-27  1037  	unsigned long __user *datalp = datavp;
fca26f260c528e Tejun Heo         2011-06-14  1038  	unsigned long flags;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1039  
^1da177e4c3f41 Linus Torvalds    2005-04-16  1040  	switch (request) {
16c3e389e7a725 Roland McGrath    2008-01-30  1041  	case PTRACE_PEEKTEXT:
16c3e389e7a725 Roland McGrath    2008-01-30  1042  	case PTRACE_PEEKDATA:
16c3e389e7a725 Roland McGrath    2008-01-30  1043  		return generic_ptrace_peekdata(child, addr, data);
16c3e389e7a725 Roland McGrath    2008-01-30  1044  	case PTRACE_POKETEXT:
16c3e389e7a725 Roland McGrath    2008-01-30  1045  	case PTRACE_POKEDATA:
16c3e389e7a725 Roland McGrath    2008-01-30  1046  		return generic_ptrace_pokedata(child, addr, data);
16c3e389e7a725 Roland McGrath    2008-01-30  1047  
^1da177e4c3f41 Linus Torvalds    2005-04-16  1048  #ifdef PTRACE_OLDSETOPTIONS
^1da177e4c3f41 Linus Torvalds    2005-04-16  1049  	case PTRACE_OLDSETOPTIONS:
^1da177e4c3f41 Linus Torvalds    2005-04-16  1050  #endif
^1da177e4c3f41 Linus Torvalds    2005-04-16  1051  	case PTRACE_SETOPTIONS:
^1da177e4c3f41 Linus Torvalds    2005-04-16  1052  		ret = ptrace_setoptions(child, data);
^1da177e4c3f41 Linus Torvalds    2005-04-16  1053  		break;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1054  	case PTRACE_GETEVENTMSG:
9fed81dc40f5a1 Namhyung Kim      2010-10-27  1055  		ret = put_user(child->ptrace_message, datalp);
^1da177e4c3f41 Linus Torvalds    2005-04-16  1056  		break;
e16b27816462de Roland McGrath    2008-04-20  1057  
84c751bd4aebba Andrey Vagin      2013-04-30  1058  	case PTRACE_PEEKSIGINFO:
84c751bd4aebba Andrey Vagin      2013-04-30  1059  		ret = ptrace_peek_siginfo(child, addr, data);
84c751bd4aebba Andrey Vagin      2013-04-30  1060  		break;
84c751bd4aebba Andrey Vagin      2013-04-30  1061  
^1da177e4c3f41 Linus Torvalds    2005-04-16  1062  	case PTRACE_GETSIGINFO:
e16b27816462de Roland McGrath    2008-04-20  1063  		ret = ptrace_getsiginfo(child, &siginfo);
e16b27816462de Roland McGrath    2008-04-20  1064  		if (!ret)
9fed81dc40f5a1 Namhyung Kim      2010-10-27  1065  			ret = copy_siginfo_to_user(datavp, &siginfo);
^1da177e4c3f41 Linus Torvalds    2005-04-16  1066  		break;
e16b27816462de Roland McGrath    2008-04-20  1067  
^1da177e4c3f41 Linus Torvalds    2005-04-16  1068  	case PTRACE_SETSIGINFO:
4cd2e0e70af689 Eric W. Biederman 2018-04-18  1069  		ret = copy_siginfo_from_user(&siginfo, datavp);
4cd2e0e70af689 Eric W. Biederman 2018-04-18  1070  		if (!ret)
e16b27816462de Roland McGrath    2008-04-20  1071  			ret = ptrace_setsiginfo(child, &siginfo);
^1da177e4c3f41 Linus Torvalds    2005-04-16  1072  		break;
e16b27816462de Roland McGrath    2008-04-20  1073  
fcfc2aa0185f4a Andrei Vagin      2019-03-28  1074  	case PTRACE_GETSIGMASK: {
fcfc2aa0185f4a Andrei Vagin      2019-03-28  1075  		sigset_t *mask;
fcfc2aa0185f4a Andrei Vagin      2019-03-28  1076  
29000caecbe87b Andrey Vagin      2013-07-03  1077  		if (addr != sizeof(sigset_t)) {
29000caecbe87b Andrey Vagin      2013-07-03  1078  			ret = -EINVAL;
29000caecbe87b Andrey Vagin      2013-07-03  1079  			break;
29000caecbe87b Andrey Vagin      2013-07-03  1080  		}
29000caecbe87b Andrey Vagin      2013-07-03  1081  
fcfc2aa0185f4a Andrei Vagin      2019-03-28  1082  		if (test_tsk_restore_sigmask(child))
fcfc2aa0185f4a Andrei Vagin      2019-03-28  1083  			mask = &child->saved_sigmask;
fcfc2aa0185f4a Andrei Vagin      2019-03-28  1084  		else
fcfc2aa0185f4a Andrei Vagin      2019-03-28  1085  			mask = &child->blocked;
fcfc2aa0185f4a Andrei Vagin      2019-03-28  1086  
fcfc2aa0185f4a Andrei Vagin      2019-03-28  1087  		if (copy_to_user(datavp, mask, sizeof(sigset_t)))
29000caecbe87b Andrey Vagin      2013-07-03  1088  			ret = -EFAULT;
29000caecbe87b Andrey Vagin      2013-07-03  1089  		else
29000caecbe87b Andrey Vagin      2013-07-03  1090  			ret = 0;
29000caecbe87b Andrey Vagin      2013-07-03  1091  
29000caecbe87b Andrey Vagin      2013-07-03  1092  		break;
fcfc2aa0185f4a Andrei Vagin      2019-03-28  1093  	}
29000caecbe87b Andrey Vagin      2013-07-03  1094  
29000caecbe87b Andrey Vagin      2013-07-03  1095  	case PTRACE_SETSIGMASK: {
29000caecbe87b Andrey Vagin      2013-07-03  1096  		sigset_t new_set;
29000caecbe87b Andrey Vagin      2013-07-03  1097  
29000caecbe87b Andrey Vagin      2013-07-03  1098  		if (addr != sizeof(sigset_t)) {
29000caecbe87b Andrey Vagin      2013-07-03  1099  			ret = -EINVAL;
29000caecbe87b Andrey Vagin      2013-07-03  1100  			break;
29000caecbe87b Andrey Vagin      2013-07-03  1101  		}
29000caecbe87b Andrey Vagin      2013-07-03  1102  
29000caecbe87b Andrey Vagin      2013-07-03  1103  		if (copy_from_user(&new_set, datavp, sizeof(sigset_t))) {
29000caecbe87b Andrey Vagin      2013-07-03  1104  			ret = -EFAULT;
29000caecbe87b Andrey Vagin      2013-07-03  1105  			break;
29000caecbe87b Andrey Vagin      2013-07-03  1106  		}
29000caecbe87b Andrey Vagin      2013-07-03  1107  
29000caecbe87b Andrey Vagin      2013-07-03  1108  		sigdelsetmask(&new_set, sigmask(SIGKILL)|sigmask(SIGSTOP));
29000caecbe87b Andrey Vagin      2013-07-03  1109  
29000caecbe87b Andrey Vagin      2013-07-03  1110  		/*
29000caecbe87b Andrey Vagin      2013-07-03  1111  		 * Every thread does recalc_sigpending() after resume, so
29000caecbe87b Andrey Vagin      2013-07-03  1112  		 * retarget_shared_pending() and recalc_sigpending() are not
29000caecbe87b Andrey Vagin      2013-07-03  1113  		 * called here.
29000caecbe87b Andrey Vagin      2013-07-03  1114  		 */
29000caecbe87b Andrey Vagin      2013-07-03  1115  		spin_lock_irq(&child->sighand->siglock);
29000caecbe87b Andrey Vagin      2013-07-03  1116  		child->blocked = new_set;
29000caecbe87b Andrey Vagin      2013-07-03  1117  		spin_unlock_irq(&child->sighand->siglock);
29000caecbe87b Andrey Vagin      2013-07-03  1118  
fcfc2aa0185f4a Andrei Vagin      2019-03-28  1119  		clear_tsk_restore_sigmask(child);
fcfc2aa0185f4a Andrei Vagin      2019-03-28  1120  
29000caecbe87b Andrey Vagin      2013-07-03  1121  		ret = 0;
29000caecbe87b Andrey Vagin      2013-07-03  1122  		break;
29000caecbe87b Andrey Vagin      2013-07-03  1123  	}
29000caecbe87b Andrey Vagin      2013-07-03  1124  
fca26f260c528e Tejun Heo         2011-06-14  1125  	case PTRACE_INTERRUPT:
fca26f260c528e Tejun Heo         2011-06-14  1126  		/*
fca26f260c528e Tejun Heo         2011-06-14  1127  		 * Stop tracee without any side-effect on signal or job
fca26f260c528e Tejun Heo         2011-06-14  1128  		 * control.  At least one trap is guaranteed to happen
fca26f260c528e Tejun Heo         2011-06-14  1129  		 * after this request.  If @child is already trapped, the
fca26f260c528e Tejun Heo         2011-06-14  1130  		 * current trap is not disturbed and another trap will
fca26f260c528e Tejun Heo         2011-06-14  1131  		 * happen after the current trap is ended with PTRACE_CONT.
fca26f260c528e Tejun Heo         2011-06-14  1132  		 *
fca26f260c528e Tejun Heo         2011-06-14  1133  		 * The actual trap might not be PTRACE_EVENT_STOP trap but
fca26f260c528e Tejun Heo         2011-06-14  1134  		 * the pending condition is cleared regardless.
fca26f260c528e Tejun Heo         2011-06-14  1135  		 */
fca26f260c528e Tejun Heo         2011-06-14  1136  		if (unlikely(!seized || !lock_task_sighand(child, &flags)))
fca26f260c528e Tejun Heo         2011-06-14  1137  			break;
fca26f260c528e Tejun Heo         2011-06-14  1138  
544b2c91a9f14f Tejun Heo         2011-06-14  1139  		/*
544b2c91a9f14f Tejun Heo         2011-06-14  1140  		 * INTERRUPT doesn't disturb existing trap sans one
544b2c91a9f14f Tejun Heo         2011-06-14  1141  		 * exception.  If ptracer issued LISTEN for the current
544b2c91a9f14f Tejun Heo         2011-06-14  1142  		 * STOP, this INTERRUPT should clear LISTEN and re-trap
544b2c91a9f14f Tejun Heo         2011-06-14  1143  		 * tracee into STOP.
544b2c91a9f14f Tejun Heo         2011-06-14  1144  		 */
fca26f260c528e Tejun Heo         2011-06-14  1145  		if (likely(task_set_jobctl_pending(child, JOBCTL_TRAP_STOP)))
910ffdb18a6408 Oleg Nesterov     2013-01-21  1146  			ptrace_signal_wake_up(child, child->jobctl & JOBCTL_LISTENING);
544b2c91a9f14f Tejun Heo         2011-06-14  1147  
544b2c91a9f14f Tejun Heo         2011-06-14  1148  		unlock_task_sighand(child, &flags);
544b2c91a9f14f Tejun Heo         2011-06-14  1149  		ret = 0;
544b2c91a9f14f Tejun Heo         2011-06-14  1150  		break;
544b2c91a9f14f Tejun Heo         2011-06-14  1151  
544b2c91a9f14f Tejun Heo         2011-06-14  1152  	case PTRACE_LISTEN:
544b2c91a9f14f Tejun Heo         2011-06-14  1153  		/*
544b2c91a9f14f Tejun Heo         2011-06-14  1154  		 * Listen for events.  Tracee must be in STOP.  It's not
544b2c91a9f14f Tejun Heo         2011-06-14  1155  		 * resumed per-se but is not considered to be in TRACED by
544b2c91a9f14f Tejun Heo         2011-06-14  1156  		 * wait(2) or ptrace(2).  If an async event (e.g. group
544b2c91a9f14f Tejun Heo         2011-06-14  1157  		 * stop state change) happens, tracee will enter STOP trap
544b2c91a9f14f Tejun Heo         2011-06-14  1158  		 * again.  Alternatively, ptracer can issue INTERRUPT to
544b2c91a9f14f Tejun Heo         2011-06-14  1159  		 * finish listening and re-trap tracee into STOP.
544b2c91a9f14f Tejun Heo         2011-06-14  1160  		 */
544b2c91a9f14f Tejun Heo         2011-06-14  1161  		if (unlikely(!seized || !lock_task_sighand(child, &flags)))
544b2c91a9f14f Tejun Heo         2011-06-14  1162  			break;
544b2c91a9f14f Tejun Heo         2011-06-14  1163  
544b2c91a9f14f Tejun Heo         2011-06-14  1164  		si = child->last_siginfo;
f9d81f61c84aca Oleg Nesterov     2011-09-25  1165  		if (likely(si && (si->si_code >> 8) == PTRACE_EVENT_STOP)) {
544b2c91a9f14f Tejun Heo         2011-06-14  1166  			child->jobctl |= JOBCTL_LISTENING;
544b2c91a9f14f Tejun Heo         2011-06-14  1167  			/*
f9d81f61c84aca Oleg Nesterov     2011-09-25  1168  			 * If NOTIFY is set, it means event happened between
f9d81f61c84aca Oleg Nesterov     2011-09-25  1169  			 * start of this trap and now.  Trigger re-trap.
544b2c91a9f14f Tejun Heo         2011-06-14  1170  			 */
544b2c91a9f14f Tejun Heo         2011-06-14  1171  			if (child->jobctl & JOBCTL_TRAP_NOTIFY)
910ffdb18a6408 Oleg Nesterov     2013-01-21  1172  				ptrace_signal_wake_up(child, true);
fca26f260c528e Tejun Heo         2011-06-14  1173  			ret = 0;
f9d81f61c84aca Oleg Nesterov     2011-09-25  1174  		}
f9d81f61c84aca Oleg Nesterov     2011-09-25  1175  		unlock_task_sighand(child, &flags);
fca26f260c528e Tejun Heo         2011-06-14  1176  		break;
fca26f260c528e Tejun Heo         2011-06-14  1177  
1bcf548293aef1 Alexey Dobriyan   2007-10-16  1178  	case PTRACE_DETACH:	 /* detach a process that was attached. */
1bcf548293aef1 Alexey Dobriyan   2007-10-16  1179  		ret = ptrace_detach(child, data);
1bcf548293aef1 Alexey Dobriyan   2007-10-16  1180  		break;
36df29d7994180 Roland McGrath    2008-01-30  1181  
9c1a125921d146 Mike Frysinger    2010-05-26  1182  #ifdef CONFIG_BINFMT_ELF_FDPIC
9c1a125921d146 Mike Frysinger    2010-05-26  1183  	case PTRACE_GETFDPIC: {
e0129ef91ed758 Oleg Nesterov     2010-05-26  1184  		struct mm_struct *mm = get_task_mm(child);
9c1a125921d146 Mike Frysinger    2010-05-26  1185  		unsigned long tmp = 0;
9c1a125921d146 Mike Frysinger    2010-05-26  1186  
e0129ef91ed758 Oleg Nesterov     2010-05-26  1187  		ret = -ESRCH;
e0129ef91ed758 Oleg Nesterov     2010-05-26  1188  		if (!mm)
e0129ef91ed758 Oleg Nesterov     2010-05-26  1189  			break;
e0129ef91ed758 Oleg Nesterov     2010-05-26  1190  
9c1a125921d146 Mike Frysinger    2010-05-26  1191  		switch (addr) {
9c1a125921d146 Mike Frysinger    2010-05-26  1192  		case PTRACE_GETFDPIC_EXEC:
e0129ef91ed758 Oleg Nesterov     2010-05-26 @1193  			tmp = mm->context.exec_fdpic_loadmap;
9c1a125921d146 Mike Frysinger    2010-05-26  1194  			break;
9c1a125921d146 Mike Frysinger    2010-05-26  1195  		case PTRACE_GETFDPIC_INTERP:
e0129ef91ed758 Oleg Nesterov     2010-05-26 @1196  			tmp = mm->context.interp_fdpic_loadmap;
9c1a125921d146 Mike Frysinger    2010-05-26  1197  			break;
9c1a125921d146 Mike Frysinger    2010-05-26  1198  		default:
9c1a125921d146 Mike Frysinger    2010-05-26  1199  			break;
9c1a125921d146 Mike Frysinger    2010-05-26  1200  		}
e0129ef91ed758 Oleg Nesterov     2010-05-26  1201  		mmput(mm);
9c1a125921d146 Mike Frysinger    2010-05-26  1202  
9fed81dc40f5a1 Namhyung Kim      2010-10-27  1203  		ret = put_user(tmp, datalp);
9c1a125921d146 Mike Frysinger    2010-05-26  1204  		break;
9c1a125921d146 Mike Frysinger    2010-05-26  1205  	}
9c1a125921d146 Mike Frysinger    2010-05-26  1206  #endif
9c1a125921d146 Mike Frysinger    2010-05-26  1207  
36df29d7994180 Roland McGrath    2008-01-30  1208  	case PTRACE_SINGLESTEP:
5b88abbf770a0e Roland McGrath    2008-01-30  1209  #ifdef PTRACE_SINGLEBLOCK
5b88abbf770a0e Roland McGrath    2008-01-30  1210  	case PTRACE_SINGLEBLOCK:
5b88abbf770a0e Roland McGrath    2008-01-30  1211  #endif
36df29d7994180 Roland McGrath    2008-01-30  1212  #ifdef PTRACE_SYSEMU
36df29d7994180 Roland McGrath    2008-01-30  1213  	case PTRACE_SYSEMU:
36df29d7994180 Roland McGrath    2008-01-30  1214  	case PTRACE_SYSEMU_SINGLESTEP:
36df29d7994180 Roland McGrath    2008-01-30  1215  #endif
36df29d7994180 Roland McGrath    2008-01-30  1216  	case PTRACE_SYSCALL:
36df29d7994180 Roland McGrath    2008-01-30  1217  	case PTRACE_CONT:
36df29d7994180 Roland McGrath    2008-01-30  1218  		return ptrace_resume(child, request, data);
36df29d7994180 Roland McGrath    2008-01-30  1219  
36df29d7994180 Roland McGrath    2008-01-30  1220  	case PTRACE_KILL:
6a2d90ba027adb Eric W. Biederman 2022-04-29  1221  		send_sig_info(SIGKILL, SEND_SIG_NOINFO, child);
36df29d7994180 Roland McGrath    2008-01-30  1222  		return 0;
36df29d7994180 Roland McGrath    2008-01-30  1223  

:::::: The code at line 1193 was first introduced by commit
:::::: e0129ef91ed758c06b6557c36124acfb2e1c7305 ptrace: PTRACE_GETFDPIC: fix the unsafe usage of child->mm

:::::: TO: Oleg Nesterov <oleg@redhat.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
