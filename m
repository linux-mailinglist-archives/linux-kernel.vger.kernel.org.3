Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A47D53D71F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 15:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236709AbiFDN4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 09:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236962AbiFDN4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 09:56:43 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43C037AA4
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 06:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654351000; x=1685887000;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=foAqGXpo4IZDRXr1TxDyG07xIQUds9rCu87I+NyeAus=;
  b=MVljXIv0fGuzgPyPNtIZ0v/YaxDPU2dcfF95nAydOFZ7+ou+wmS0hjwz
   ivJ/lpKqmpxcLUq/SaSSiSwenPlrg7yQUsHsHeQvb4Y/6lXZBO9Cj7s4h
   OY9WFiJwxSHL1stJyPJDaP3X73wELBmUXzZqp1hyTaw6yU6n1ZqnAYx1C
   Qbjo4Kf/bPWgzD8jnJmB7xEFKY2PYkrA37sZQBSdvWA10vGOvJM6KsVm2
   9gAjXwLYB9l2LC20ZadS47DOIpIcArZPCEqua/Ym4awTqDWPb6vk2rzdf
   49jHMdpdIsQt6brm2A7s3d6ewXaYfocq6a4qbc+ca3lvktOjx0PLurROH
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10368"; a="275236018"
X-IronPort-AV: E=Sophos;i="5.91,277,1647327600"; 
   d="scan'208";a="275236018"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 06:56:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,277,1647327600"; 
   d="scan'208";a="646855449"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 04 Jun 2022 06:56:39 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxUGc-000Avr-KU;
        Sat, 04 Jun 2022 13:56:38 +0000
Date:   Sat, 4 Jun 2022 21:55:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jcmvbkbc-xtensa:xtensa-5.18-esp32 45/45] kernel/ptrace.c:1209:42:
 error: 'mm_context_t' has no member named 'exec_fdpic_loadmap'
Message-ID: <202206042111.7TXeQiVP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jcmvbkbc/linux-xtensa xtensa-5.18-esp32
head:   137adeae90088411fe27a1be624afd8336542302
commit: 137adeae90088411fe27a1be624afd8336542302 [45/45] WIP: xtensa: add FDPIC support
config: xtensa-allyesconfig (https://download.01.org/0day-ci/archive/20220604/202206042111.7TXeQiVP-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jcmvbkbc/linux-xtensa/commit/137adeae90088411fe27a1be624afd8336542302
        git remote add jcmvbkbc-xtensa https://github.com/jcmvbkbc/linux-xtensa
        git fetch --no-tags jcmvbkbc-xtensa xtensa-5.18-esp32
        git checkout 137adeae90088411fe27a1be624afd8336542302
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/ptrace.c: In function 'ptrace_request':
>> kernel/ptrace.c:1209:42: error: 'mm_context_t' has no member named 'exec_fdpic_loadmap'
    1209 |                         tmp = mm->context.exec_fdpic_loadmap;
         |                                          ^
>> kernel/ptrace.c:1212:42: error: 'mm_context_t' has no member named 'interp_fdpic_loadmap'
    1212 |                         tmp = mm->context.interp_fdpic_loadmap;
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


vim +1209 kernel/ptrace.c

2225a122ae26d5 Suresh Siddha     2010-02-11  1045  
^1da177e4c3f41 Linus Torvalds    2005-04-16  1046  int ptrace_request(struct task_struct *child, long request,
4abf986960ecda Namhyung Kim      2010-10-27  1047  		   unsigned long addr, unsigned long data)
^1da177e4c3f41 Linus Torvalds    2005-04-16  1048  {
fca26f260c528e Tejun Heo         2011-06-14  1049  	bool seized = child->ptrace & PT_SEIZED;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1050  	int ret = -EIO;
ae7795bc6187a1 Eric W. Biederman 2018-09-25  1051  	kernel_siginfo_t siginfo, *si;
9fed81dc40f5a1 Namhyung Kim      2010-10-27  1052  	void __user *datavp = (void __user *) data;
9fed81dc40f5a1 Namhyung Kim      2010-10-27  1053  	unsigned long __user *datalp = datavp;
fca26f260c528e Tejun Heo         2011-06-14  1054  	unsigned long flags;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1055  
^1da177e4c3f41 Linus Torvalds    2005-04-16  1056  	switch (request) {
16c3e389e7a725 Roland McGrath    2008-01-30  1057  	case PTRACE_PEEKTEXT:
16c3e389e7a725 Roland McGrath    2008-01-30  1058  	case PTRACE_PEEKDATA:
16c3e389e7a725 Roland McGrath    2008-01-30  1059  		return generic_ptrace_peekdata(child, addr, data);
16c3e389e7a725 Roland McGrath    2008-01-30  1060  	case PTRACE_POKETEXT:
16c3e389e7a725 Roland McGrath    2008-01-30  1061  	case PTRACE_POKEDATA:
16c3e389e7a725 Roland McGrath    2008-01-30  1062  		return generic_ptrace_pokedata(child, addr, data);
16c3e389e7a725 Roland McGrath    2008-01-30  1063  
^1da177e4c3f41 Linus Torvalds    2005-04-16  1064  #ifdef PTRACE_OLDSETOPTIONS
^1da177e4c3f41 Linus Torvalds    2005-04-16  1065  	case PTRACE_OLDSETOPTIONS:
^1da177e4c3f41 Linus Torvalds    2005-04-16  1066  #endif
^1da177e4c3f41 Linus Torvalds    2005-04-16  1067  	case PTRACE_SETOPTIONS:
^1da177e4c3f41 Linus Torvalds    2005-04-16  1068  		ret = ptrace_setoptions(child, data);
^1da177e4c3f41 Linus Torvalds    2005-04-16  1069  		break;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1070  	case PTRACE_GETEVENTMSG:
9fed81dc40f5a1 Namhyung Kim      2010-10-27  1071  		ret = put_user(child->ptrace_message, datalp);
^1da177e4c3f41 Linus Torvalds    2005-04-16  1072  		break;
e16b27816462de Roland McGrath    2008-04-20  1073  
84c751bd4aebba Andrey Vagin      2013-04-30  1074  	case PTRACE_PEEKSIGINFO:
84c751bd4aebba Andrey Vagin      2013-04-30  1075  		ret = ptrace_peek_siginfo(child, addr, data);
84c751bd4aebba Andrey Vagin      2013-04-30  1076  		break;
84c751bd4aebba Andrey Vagin      2013-04-30  1077  
^1da177e4c3f41 Linus Torvalds    2005-04-16  1078  	case PTRACE_GETSIGINFO:
e16b27816462de Roland McGrath    2008-04-20  1079  		ret = ptrace_getsiginfo(child, &siginfo);
e16b27816462de Roland McGrath    2008-04-20  1080  		if (!ret)
9fed81dc40f5a1 Namhyung Kim      2010-10-27  1081  			ret = copy_siginfo_to_user(datavp, &siginfo);
^1da177e4c3f41 Linus Torvalds    2005-04-16  1082  		break;
e16b27816462de Roland McGrath    2008-04-20  1083  
^1da177e4c3f41 Linus Torvalds    2005-04-16  1084  	case PTRACE_SETSIGINFO:
4cd2e0e70af689 Eric W. Biederman 2018-04-18  1085  		ret = copy_siginfo_from_user(&siginfo, datavp);
4cd2e0e70af689 Eric W. Biederman 2018-04-18  1086  		if (!ret)
e16b27816462de Roland McGrath    2008-04-20  1087  			ret = ptrace_setsiginfo(child, &siginfo);
^1da177e4c3f41 Linus Torvalds    2005-04-16  1088  		break;
e16b27816462de Roland McGrath    2008-04-20  1089  
fcfc2aa0185f4a Andrei Vagin      2019-03-28  1090  	case PTRACE_GETSIGMASK: {
fcfc2aa0185f4a Andrei Vagin      2019-03-28  1091  		sigset_t *mask;
fcfc2aa0185f4a Andrei Vagin      2019-03-28  1092  
29000caecbe87b Andrey Vagin      2013-07-03  1093  		if (addr != sizeof(sigset_t)) {
29000caecbe87b Andrey Vagin      2013-07-03  1094  			ret = -EINVAL;
29000caecbe87b Andrey Vagin      2013-07-03  1095  			break;
29000caecbe87b Andrey Vagin      2013-07-03  1096  		}
29000caecbe87b Andrey Vagin      2013-07-03  1097  
fcfc2aa0185f4a Andrei Vagin      2019-03-28  1098  		if (test_tsk_restore_sigmask(child))
fcfc2aa0185f4a Andrei Vagin      2019-03-28  1099  			mask = &child->saved_sigmask;
fcfc2aa0185f4a Andrei Vagin      2019-03-28  1100  		else
fcfc2aa0185f4a Andrei Vagin      2019-03-28  1101  			mask = &child->blocked;
fcfc2aa0185f4a Andrei Vagin      2019-03-28  1102  
fcfc2aa0185f4a Andrei Vagin      2019-03-28  1103  		if (copy_to_user(datavp, mask, sizeof(sigset_t)))
29000caecbe87b Andrey Vagin      2013-07-03  1104  			ret = -EFAULT;
29000caecbe87b Andrey Vagin      2013-07-03  1105  		else
29000caecbe87b Andrey Vagin      2013-07-03  1106  			ret = 0;
29000caecbe87b Andrey Vagin      2013-07-03  1107  
29000caecbe87b Andrey Vagin      2013-07-03  1108  		break;
fcfc2aa0185f4a Andrei Vagin      2019-03-28  1109  	}
29000caecbe87b Andrey Vagin      2013-07-03  1110  
29000caecbe87b Andrey Vagin      2013-07-03  1111  	case PTRACE_SETSIGMASK: {
29000caecbe87b Andrey Vagin      2013-07-03  1112  		sigset_t new_set;
29000caecbe87b Andrey Vagin      2013-07-03  1113  
29000caecbe87b Andrey Vagin      2013-07-03  1114  		if (addr != sizeof(sigset_t)) {
29000caecbe87b Andrey Vagin      2013-07-03  1115  			ret = -EINVAL;
29000caecbe87b Andrey Vagin      2013-07-03  1116  			break;
29000caecbe87b Andrey Vagin      2013-07-03  1117  		}
29000caecbe87b Andrey Vagin      2013-07-03  1118  
29000caecbe87b Andrey Vagin      2013-07-03  1119  		if (copy_from_user(&new_set, datavp, sizeof(sigset_t))) {
29000caecbe87b Andrey Vagin      2013-07-03  1120  			ret = -EFAULT;
29000caecbe87b Andrey Vagin      2013-07-03  1121  			break;
29000caecbe87b Andrey Vagin      2013-07-03  1122  		}
29000caecbe87b Andrey Vagin      2013-07-03  1123  
29000caecbe87b Andrey Vagin      2013-07-03  1124  		sigdelsetmask(&new_set, sigmask(SIGKILL)|sigmask(SIGSTOP));
29000caecbe87b Andrey Vagin      2013-07-03  1125  
29000caecbe87b Andrey Vagin      2013-07-03  1126  		/*
29000caecbe87b Andrey Vagin      2013-07-03  1127  		 * Every thread does recalc_sigpending() after resume, so
29000caecbe87b Andrey Vagin      2013-07-03  1128  		 * retarget_shared_pending() and recalc_sigpending() are not
29000caecbe87b Andrey Vagin      2013-07-03  1129  		 * called here.
29000caecbe87b Andrey Vagin      2013-07-03  1130  		 */
29000caecbe87b Andrey Vagin      2013-07-03  1131  		spin_lock_irq(&child->sighand->siglock);
29000caecbe87b Andrey Vagin      2013-07-03  1132  		child->blocked = new_set;
29000caecbe87b Andrey Vagin      2013-07-03  1133  		spin_unlock_irq(&child->sighand->siglock);
29000caecbe87b Andrey Vagin      2013-07-03  1134  
fcfc2aa0185f4a Andrei Vagin      2019-03-28  1135  		clear_tsk_restore_sigmask(child);
fcfc2aa0185f4a Andrei Vagin      2019-03-28  1136  
29000caecbe87b Andrey Vagin      2013-07-03  1137  		ret = 0;
29000caecbe87b Andrey Vagin      2013-07-03  1138  		break;
29000caecbe87b Andrey Vagin      2013-07-03  1139  	}
29000caecbe87b Andrey Vagin      2013-07-03  1140  
fca26f260c528e Tejun Heo         2011-06-14  1141  	case PTRACE_INTERRUPT:
fca26f260c528e Tejun Heo         2011-06-14  1142  		/*
fca26f260c528e Tejun Heo         2011-06-14  1143  		 * Stop tracee without any side-effect on signal or job
fca26f260c528e Tejun Heo         2011-06-14  1144  		 * control.  At least one trap is guaranteed to happen
fca26f260c528e Tejun Heo         2011-06-14  1145  		 * after this request.  If @child is already trapped, the
fca26f260c528e Tejun Heo         2011-06-14  1146  		 * current trap is not disturbed and another trap will
fca26f260c528e Tejun Heo         2011-06-14  1147  		 * happen after the current trap is ended with PTRACE_CONT.
fca26f260c528e Tejun Heo         2011-06-14  1148  		 *
fca26f260c528e Tejun Heo         2011-06-14  1149  		 * The actual trap might not be PTRACE_EVENT_STOP trap but
fca26f260c528e Tejun Heo         2011-06-14  1150  		 * the pending condition is cleared regardless.
fca26f260c528e Tejun Heo         2011-06-14  1151  		 */
fca26f260c528e Tejun Heo         2011-06-14  1152  		if (unlikely(!seized || !lock_task_sighand(child, &flags)))
fca26f260c528e Tejun Heo         2011-06-14  1153  			break;
fca26f260c528e Tejun Heo         2011-06-14  1154  
544b2c91a9f14f Tejun Heo         2011-06-14  1155  		/*
544b2c91a9f14f Tejun Heo         2011-06-14  1156  		 * INTERRUPT doesn't disturb existing trap sans one
544b2c91a9f14f Tejun Heo         2011-06-14  1157  		 * exception.  If ptracer issued LISTEN for the current
544b2c91a9f14f Tejun Heo         2011-06-14  1158  		 * STOP, this INTERRUPT should clear LISTEN and re-trap
544b2c91a9f14f Tejun Heo         2011-06-14  1159  		 * tracee into STOP.
544b2c91a9f14f Tejun Heo         2011-06-14  1160  		 */
fca26f260c528e Tejun Heo         2011-06-14  1161  		if (likely(task_set_jobctl_pending(child, JOBCTL_TRAP_STOP)))
910ffdb18a6408 Oleg Nesterov     2013-01-21  1162  			ptrace_signal_wake_up(child, child->jobctl & JOBCTL_LISTENING);
544b2c91a9f14f Tejun Heo         2011-06-14  1163  
544b2c91a9f14f Tejun Heo         2011-06-14  1164  		unlock_task_sighand(child, &flags);
544b2c91a9f14f Tejun Heo         2011-06-14  1165  		ret = 0;
544b2c91a9f14f Tejun Heo         2011-06-14  1166  		break;
544b2c91a9f14f Tejun Heo         2011-06-14  1167  
544b2c91a9f14f Tejun Heo         2011-06-14  1168  	case PTRACE_LISTEN:
544b2c91a9f14f Tejun Heo         2011-06-14  1169  		/*
544b2c91a9f14f Tejun Heo         2011-06-14  1170  		 * Listen for events.  Tracee must be in STOP.  It's not
544b2c91a9f14f Tejun Heo         2011-06-14  1171  		 * resumed per-se but is not considered to be in TRACED by
544b2c91a9f14f Tejun Heo         2011-06-14  1172  		 * wait(2) or ptrace(2).  If an async event (e.g. group
544b2c91a9f14f Tejun Heo         2011-06-14  1173  		 * stop state change) happens, tracee will enter STOP trap
544b2c91a9f14f Tejun Heo         2011-06-14  1174  		 * again.  Alternatively, ptracer can issue INTERRUPT to
544b2c91a9f14f Tejun Heo         2011-06-14  1175  		 * finish listening and re-trap tracee into STOP.
544b2c91a9f14f Tejun Heo         2011-06-14  1176  		 */
544b2c91a9f14f Tejun Heo         2011-06-14  1177  		if (unlikely(!seized || !lock_task_sighand(child, &flags)))
544b2c91a9f14f Tejun Heo         2011-06-14  1178  			break;
544b2c91a9f14f Tejun Heo         2011-06-14  1179  
544b2c91a9f14f Tejun Heo         2011-06-14  1180  		si = child->last_siginfo;
f9d81f61c84aca Oleg Nesterov     2011-09-25  1181  		if (likely(si && (si->si_code >> 8) == PTRACE_EVENT_STOP)) {
544b2c91a9f14f Tejun Heo         2011-06-14  1182  			child->jobctl |= JOBCTL_LISTENING;
544b2c91a9f14f Tejun Heo         2011-06-14  1183  			/*
f9d81f61c84aca Oleg Nesterov     2011-09-25  1184  			 * If NOTIFY is set, it means event happened between
f9d81f61c84aca Oleg Nesterov     2011-09-25  1185  			 * start of this trap and now.  Trigger re-trap.
544b2c91a9f14f Tejun Heo         2011-06-14  1186  			 */
544b2c91a9f14f Tejun Heo         2011-06-14  1187  			if (child->jobctl & JOBCTL_TRAP_NOTIFY)
910ffdb18a6408 Oleg Nesterov     2013-01-21  1188  				ptrace_signal_wake_up(child, true);
fca26f260c528e Tejun Heo         2011-06-14  1189  			ret = 0;
f9d81f61c84aca Oleg Nesterov     2011-09-25  1190  		}
f9d81f61c84aca Oleg Nesterov     2011-09-25  1191  		unlock_task_sighand(child, &flags);
fca26f260c528e Tejun Heo         2011-06-14  1192  		break;
fca26f260c528e Tejun Heo         2011-06-14  1193  
1bcf548293aef1 Alexey Dobriyan   2007-10-16  1194  	case PTRACE_DETACH:	 /* detach a process that was attached. */
1bcf548293aef1 Alexey Dobriyan   2007-10-16  1195  		ret = ptrace_detach(child, data);
1bcf548293aef1 Alexey Dobriyan   2007-10-16  1196  		break;
36df29d7994180 Roland McGrath    2008-01-30  1197  
9c1a125921d146 Mike Frysinger    2010-05-26  1198  #ifdef CONFIG_BINFMT_ELF_FDPIC
9c1a125921d146 Mike Frysinger    2010-05-26  1199  	case PTRACE_GETFDPIC: {
e0129ef91ed758 Oleg Nesterov     2010-05-26  1200  		struct mm_struct *mm = get_task_mm(child);
9c1a125921d146 Mike Frysinger    2010-05-26  1201  		unsigned long tmp = 0;
9c1a125921d146 Mike Frysinger    2010-05-26  1202  
e0129ef91ed758 Oleg Nesterov     2010-05-26  1203  		ret = -ESRCH;
e0129ef91ed758 Oleg Nesterov     2010-05-26  1204  		if (!mm)
e0129ef91ed758 Oleg Nesterov     2010-05-26  1205  			break;
e0129ef91ed758 Oleg Nesterov     2010-05-26  1206  
9c1a125921d146 Mike Frysinger    2010-05-26  1207  		switch (addr) {
9c1a125921d146 Mike Frysinger    2010-05-26  1208  		case PTRACE_GETFDPIC_EXEC:
e0129ef91ed758 Oleg Nesterov     2010-05-26 @1209  			tmp = mm->context.exec_fdpic_loadmap;
9c1a125921d146 Mike Frysinger    2010-05-26  1210  			break;
9c1a125921d146 Mike Frysinger    2010-05-26  1211  		case PTRACE_GETFDPIC_INTERP:
e0129ef91ed758 Oleg Nesterov     2010-05-26 @1212  			tmp = mm->context.interp_fdpic_loadmap;
9c1a125921d146 Mike Frysinger    2010-05-26  1213  			break;
9c1a125921d146 Mike Frysinger    2010-05-26  1214  		default:
9c1a125921d146 Mike Frysinger    2010-05-26  1215  			break;
9c1a125921d146 Mike Frysinger    2010-05-26  1216  		}
e0129ef91ed758 Oleg Nesterov     2010-05-26  1217  		mmput(mm);
9c1a125921d146 Mike Frysinger    2010-05-26  1218  
9fed81dc40f5a1 Namhyung Kim      2010-10-27  1219  		ret = put_user(tmp, datalp);
9c1a125921d146 Mike Frysinger    2010-05-26  1220  		break;
9c1a125921d146 Mike Frysinger    2010-05-26  1221  	}
9c1a125921d146 Mike Frysinger    2010-05-26  1222  #endif
9c1a125921d146 Mike Frysinger    2010-05-26  1223  

:::::: The code at line 1209 was first introduced by commit
:::::: e0129ef91ed758c06b6557c36124acfb2e1c7305 ptrace: PTRACE_GETFDPIC: fix the unsafe usage of child->mm

:::::: TO: Oleg Nesterov <oleg@redhat.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
