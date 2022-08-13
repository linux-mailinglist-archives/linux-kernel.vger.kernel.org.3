Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8E6591BF3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 18:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239865AbiHMQNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 12:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240013AbiHMQN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 12:13:28 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8E7F5BA
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 09:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660407206; x=1691943206;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1yrstnfDk5KgWdIT6bKwxKR4lbPL+BI8TOdYfG49N3Y=;
  b=WldNzZxCaoC8cm4jaiw0VbOEUi7p5HC6iKQ0Z8012mZtvNqfRoMtvCgL
   CHCFn+yQk1WwTvFaPcyoHX9nJqGmm7syvAFDX5l9OSJqnVNOa+lUjtDJn
   Yy41JWbqehHCfsPZ9bXeiHorUdRPGqPb2iZPLsb/pogV4HkE4+IRfGTKK
   o2+xzDGJ423GhIXNzM3EiwZdDJfxXSaP4U7DtkzhOQrkOCv25cxbHWYuI
   Oy1aL1yXxP3M9MEi7oxa+bYegFx8lLuvtsGxCA2TYTTZPqzqtQS3LpNuJ
   sZwBzKzr8Xu9+zAFmaUlWwQ4eTNYdyfLCrmJPp8VqHwxvJuBNruNYRob5
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="278717824"
X-IronPort-AV: E=Sophos;i="5.93,235,1654585200"; 
   d="scan'208";a="278717824"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 09:13:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,235,1654585200"; 
   d="scan'208";a="602782977"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 13 Aug 2022 09:13:24 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMtlL-0001rD-1h;
        Sat, 13 Aug 2022 16:13:23 +0000
Date:   Sun, 14 Aug 2022 00:12:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [tip:timers/urgent 3/3] fs/exec.c:1307:26: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202208140040.MMi4z6Ek-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/urgent
head:   e362359ace6f87c201531872486ff295df306d13
commit: e362359ace6f87c201531872486ff295df306d13 [3/3] posix-cpu-timers: Cleanup CPU timers before freeing them during exec
config: arc-randconfig-s033-20220811 (https://download.01.org/0day-ci/archive/20220814/202208140040.MMi4z6Ek-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=e362359ace6f87c201531872486ff295df306d13
        git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
        git fetch --no-tags tip timers/urgent
        git checkout e362359ace6f87c201531872486ff295df306d13
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   fs/exec.c:422:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected char const [noderef] __user * @@     got void * @@
   fs/exec.c:422:31: sparse:     expected char const [noderef] __user *
   fs/exec.c:422:31: sparse:     got void *
   fs/exec.c:1051:48: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sighand_struct *oldsighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   fs/exec.c:1051:48: sparse:     expected struct sighand_struct *oldsighand
   fs/exec.c:1051:48: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   fs/exec.c:1158:56: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *parent @@
   fs/exec.c:1158:56: sparse:     expected struct task_struct *parent
   fs/exec.c:1158:56: sparse:     got struct task_struct [noderef] __rcu *parent
   fs/exec.c:1193:47: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sighand_struct *oldsighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   fs/exec.c:1193:47: sparse:     expected struct sighand_struct *oldsighand
   fs/exec.c:1193:47: sparse:     got struct sighand_struct [noderef] __rcu *sighand
>> fs/exec.c:1307:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   fs/exec.c:1307:26: sparse:     expected struct spinlock [usertype] *lock
   fs/exec.c:1307:26: sparse:     got struct spinlock [noderef] __rcu *
   fs/exec.c:1309:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   fs/exec.c:1309:28: sparse:     expected struct spinlock [usertype] *lock
   fs/exec.c:1309:28: sparse:     got struct spinlock [noderef] __rcu *
   fs/exec.c:1766:70: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *parent @@
   fs/exec.c:1766:70: sparse:     expected struct task_struct *tsk
   fs/exec.c:1766:70: sparse:     got struct task_struct [noderef] __rcu *parent
   fs/exec.c: note: in included file (through arch/arc/include/asm/irqflags.h, include/linux/irqflags.h, arch/arc/include/asm/smp.h, ...):
   arch/arc/include/asm/irqflags-arcv2.h:80:31: sparse: sparse: undefined identifier '__builtin_arc_lr'
   arch/arc/include/asm/irqflags-arcv2.h:83:17: sparse: sparse: undefined identifier '__builtin_arc_sr'
   fs/exec.c: note: in included file (through arch/arc/include/asm/mmu.h, include/linux/mm_types.h, include/linux/mmzone.h, ...):
   arch/arc/include/asm/mmu-arcv2.h:89:9: sparse: sparse: undefined identifier '__builtin_arc_sr'
   arch/arc/include/asm/mmu-arcv2.h:82:9: sparse: sparse: undefined identifier '__builtin_arc_sr'

vim +1307 fs/exec.c

  1243	
  1244	/*
  1245	 * Calling this is the point of no return. None of the failures will be
  1246	 * seen by userspace since either the process is already taking a fatal
  1247	 * signal (via de_thread() or coredump), or will have SEGV raised
  1248	 * (after exec_mmap()) by search_binary_handler (see below).
  1249	 */
  1250	int begin_new_exec(struct linux_binprm * bprm)
  1251	{
  1252		struct task_struct *me = current;
  1253		int retval;
  1254	
  1255		/* Once we are committed compute the creds */
  1256		retval = bprm_creds_from_file(bprm);
  1257		if (retval)
  1258			return retval;
  1259	
  1260		/*
  1261		 * Ensure all future errors are fatal.
  1262		 */
  1263		bprm->point_of_no_return = true;
  1264	
  1265		/*
  1266		 * Make this the only thread in the thread group.
  1267		 */
  1268		retval = de_thread(me);
  1269		if (retval)
  1270			goto out;
  1271	
  1272		/*
  1273		 * Cancel any io_uring activity across execve
  1274		 */
  1275		io_uring_task_cancel();
  1276	
  1277		/* Ensure the files table is not shared. */
  1278		retval = unshare_files();
  1279		if (retval)
  1280			goto out;
  1281	
  1282		/*
  1283		 * Must be called _before_ exec_mmap() as bprm->mm is
  1284		 * not visible until then. This also enables the update
  1285		 * to be lockless.
  1286		 */
  1287		retval = set_mm_exe_file(bprm->mm, bprm->file);
  1288		if (retval)
  1289			goto out;
  1290	
  1291		/* If the binary is not readable then enforce mm->dumpable=0 */
  1292		would_dump(bprm, bprm->file);
  1293		if (bprm->have_execfd)
  1294			would_dump(bprm, bprm->executable);
  1295	
  1296		/*
  1297		 * Release all of the old mmap stuff
  1298		 */
  1299		acct_arg_size(bprm, 0);
  1300		retval = exec_mmap(bprm->mm);
  1301		if (retval)
  1302			goto out;
  1303	
  1304		bprm->mm = NULL;
  1305	
  1306	#ifdef CONFIG_POSIX_TIMERS
> 1307		spin_lock_irq(&me->sighand->siglock);
  1308		posix_cpu_timers_exit(me);
  1309		spin_unlock_irq(&me->sighand->siglock);
  1310		exit_itimers(me);
  1311		flush_itimer_signals();
  1312	#endif
  1313	
  1314		/*
  1315		 * Make the signal table private.
  1316		 */
  1317		retval = unshare_sighand(me);
  1318		if (retval)
  1319			goto out_unlock;
  1320	
  1321		me->flags &= ~(PF_RANDOMIZE | PF_FORKNOEXEC |
  1322						PF_NOFREEZE | PF_NO_SETAFFINITY);
  1323		flush_thread();
  1324		me->personality &= ~bprm->per_clear;
  1325	
  1326		clear_syscall_work_syscall_user_dispatch(me);
  1327	
  1328		/*
  1329		 * We have to apply CLOEXEC before we change whether the process is
  1330		 * dumpable (in setup_new_exec) to avoid a race with a process in userspace
  1331		 * trying to access the should-be-closed file descriptors of a process
  1332		 * undergoing exec(2).
  1333		 */
  1334		do_close_on_exec(me->files);
  1335	
  1336		if (bprm->secureexec) {
  1337			/* Make sure parent cannot signal privileged process. */
  1338			me->pdeath_signal = 0;
  1339	
  1340			/*
  1341			 * For secureexec, reset the stack limit to sane default to
  1342			 * avoid bad behavior from the prior rlimits. This has to
  1343			 * happen before arch_pick_mmap_layout(), which examines
  1344			 * RLIMIT_STACK, but after the point of no return to avoid
  1345			 * needing to clean up the change on failure.
  1346			 */
  1347			if (bprm->rlim_stack.rlim_cur > _STK_LIM)
  1348				bprm->rlim_stack.rlim_cur = _STK_LIM;
  1349		}
  1350	
  1351		me->sas_ss_sp = me->sas_ss_size = 0;
  1352	
  1353		/*
  1354		 * Figure out dumpability. Note that this checking only of current
  1355		 * is wrong, but userspace depends on it. This should be testing
  1356		 * bprm->secureexec instead.
  1357		 */
  1358		if (bprm->interp_flags & BINPRM_FLAGS_ENFORCE_NONDUMP ||
  1359		    !(uid_eq(current_euid(), current_uid()) &&
  1360		      gid_eq(current_egid(), current_gid())))
  1361			set_dumpable(current->mm, suid_dumpable);
  1362		else
  1363			set_dumpable(current->mm, SUID_DUMP_USER);
  1364	
  1365		perf_event_exec();
  1366		__set_task_comm(me, kbasename(bprm->filename), true);
  1367	
  1368		/* An exec changes our domain. We are no longer part of the thread
  1369		   group */
  1370		WRITE_ONCE(me->self_exec_id, me->self_exec_id + 1);
  1371		flush_signal_handlers(me, 0);
  1372	
  1373		retval = set_cred_ucounts(bprm->cred);
  1374		if (retval < 0)
  1375			goto out_unlock;
  1376	
  1377		/*
  1378		 * install the new credentials for this executable
  1379		 */
  1380		security_bprm_committing_creds(bprm);
  1381	
  1382		commit_creds(bprm->cred);
  1383		bprm->cred = NULL;
  1384	
  1385		/*
  1386		 * Disable monitoring for regular users
  1387		 * when executing setuid binaries. Must
  1388		 * wait until new credentials are committed
  1389		 * by commit_creds() above
  1390		 */
  1391		if (get_dumpable(me->mm) != SUID_DUMP_USER)
  1392			perf_event_exit_task(me);
  1393		/*
  1394		 * cred_guard_mutex must be held at least to this point to prevent
  1395		 * ptrace_attach() from altering our determination of the task's
  1396		 * credentials; any time after this it may be unlocked.
  1397		 */
  1398		security_bprm_committed_creds(bprm);
  1399	
  1400		/* Pass the opened binary to the interpreter. */
  1401		if (bprm->have_execfd) {
  1402			retval = get_unused_fd_flags(0);
  1403			if (retval < 0)
  1404				goto out_unlock;
  1405			fd_install(retval, bprm->executable);
  1406			bprm->executable = NULL;
  1407			bprm->execfd = retval;
  1408		}
  1409		return 0;
  1410	
  1411	out_unlock:
  1412		up_write(&me->signal->exec_update_lock);
  1413	out:
  1414		return retval;
  1415	}
  1416	EXPORT_SYMBOL(begin_new_exec);
  1417	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
