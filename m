Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6393A591E5B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 07:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbiHNFAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 01:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiHNFAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 01:00:50 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F426B86C
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 22:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660453246; x=1691989246;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JfbmgZZf67YTtdXfk/MS+HFqwS/t/thrrC+Ax5PyX2s=;
  b=UOX3R1PE8xUhuK5eHPILjPROOj9SuURVTi72LYy4e7+ggIAvwWfMAOD+
   0miosPXpIdRk28V7lgHG4ZXNnb5HjpPOVq/4x9ZrGpz61uufnAzprTw0K
   uweGbia5l+8nKMAYqEZOnSPSvEeGdEIb1CGR4eyrL71Bvg18CNjWHcjq1
   C8CGAUttkbrPxYLsZd5rBdJzM/MXOBOaGAXojH+gVrBoNzGzALwxd0yjq
   LbWrNO7pE1k/erZVYdKMydNqjIPl3ozqIacjFdHt318+tTTtAd8QePoGw
   1dsv8GOvFP9cbAvecZR6iAccdN5FAztHm7nkRh58hX2uNfWb7OKsyxo6T
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="317775467"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="317775467"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 22:00:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="695659490"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Aug 2022 22:00:42 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oN5ju-0002Vb-0r;
        Sun, 14 Aug 2022 05:00:42 +0000
Date:   Sun, 14 Aug 2022 12:59:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [stable:linux-5.10.y 499/7445] arch/powerpc/kernel/smp.c:1380:7:
 warning: variable 'ret' set but not used
Message-ID: <202208141236.5SC5FZl2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="v29I7G6zRZmhEUUb"
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v29I7G6zRZmhEUUb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
head:   6eae1503ddf94b4c3581092d566b17ed12d80f20
commit: e91077cf1780108dc586cedf1d19f65b44fa3870 [499/7445] powerpc/smp: Update cpu_core_map on all PowerPc systems
config: powerpc-randconfig-r011-20220811
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 5f1c7e2cc5a3c07cbc2412e851a7283c1841f520)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?id=e91077cf1780108dc586cedf1d19f65b44fa3870
        git remote add stable https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
        git fetch --no-tags stable linux-5.10.y
        git checkout e91077cf1780108dc586cedf1d19f65b44fa3870
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/powerpc/kernel/smp.c:551:6: warning: no previous prototype for function 'tick_broadcast' [-Wmissing-prototypes]
   void tick_broadcast(const struct cpumask *mask)
        ^
   arch/powerpc/kernel/smp.c:551:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void tick_broadcast(const struct cpumask *mask)
   ^
   static 
>> arch/powerpc/kernel/smp.c:1380:7: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
           bool ret;
                ^
   arch/powerpc/kernel/smp.c:1491:5: warning: no previous prototype for function 'setup_profiling_timer' [-Wmissing-prototypes]
   int setup_profiling_timer(unsigned int multiplier)
       ^
   arch/powerpc/kernel/smp.c:1491:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int setup_profiling_timer(unsigned int multiplier)
   ^
   static 
   3 warnings generated.


vim +/ret +1380 arch/powerpc/kernel/smp.c

b8a97cb4599cda2 Srikar Dronamraju 2020-09-21  1373  
df52f6714071c49 Oliver O'Halloran 2017-06-29  1374  static void add_cpu_to_masks(int cpu)
df52f6714071c49 Oliver O'Halloran 2017-06-29  1375  {
bf6476152a0a084 Srikar Dronamraju 2021-04-15  1376  	struct cpumask *(*submask_fn)(int) = cpu_sibling_mask;
df52f6714071c49 Oliver O'Halloran 2017-06-29  1377  	int first_thread = cpu_first_thread_sibling(cpu);
bf6476152a0a084 Srikar Dronamraju 2021-04-15  1378  	int chip_id = cpu_to_chip_id(cpu);
84dbf66c6347206 Srikar Dronamraju 2020-10-19  1379  	cpumask_var_t mask;
bf6476152a0a084 Srikar Dronamraju 2021-04-15 @1380  	bool ret;
df52f6714071c49 Oliver O'Halloran 2017-06-29  1381  	int i;
df52f6714071c49 Oliver O'Halloran 2017-06-29  1382  
df52f6714071c49 Oliver O'Halloran 2017-06-29  1383  	/*
df52f6714071c49 Oliver O'Halloran 2017-06-29  1384  	 * This CPU will not be in the online mask yet so we need to manually
df52f6714071c49 Oliver O'Halloran 2017-06-29  1385  	 * add it to it's own thread sibling mask.
df52f6714071c49 Oliver O'Halloran 2017-06-29  1386  	 */
df52f6714071c49 Oliver O'Halloran 2017-06-29  1387  	cpumask_set_cpu(cpu, cpu_sibling_mask(cpu));
e91077cf1780108 Srikar Dronamraju 2021-08-26  1388  	cpumask_set_cpu(cpu, cpu_core_mask(cpu));
df52f6714071c49 Oliver O'Halloran 2017-06-29  1389  
df52f6714071c49 Oliver O'Halloran 2017-06-29  1390  	for (i = first_thread; i < first_thread + threads_per_core; i++)
df52f6714071c49 Oliver O'Halloran 2017-06-29  1391  		if (cpu_online(i))
df52f6714071c49 Oliver O'Halloran 2017-06-29  1392  			set_cpus_related(i, cpu, cpu_sibling_mask);
df52f6714071c49 Oliver O'Halloran 2017-06-29  1393  
425752c63b6f3fe Gautham R. Shenoy 2018-10-11  1394  	add_cpu_to_smallcore_masks(cpu);
84dbf66c6347206 Srikar Dronamraju 2020-10-19  1395  
84dbf66c6347206 Srikar Dronamraju 2020-10-19  1396  	/* In CPU-hotplug path, hence use GFP_ATOMIC */
bf6476152a0a084 Srikar Dronamraju 2021-04-15  1397  	ret = alloc_cpumask_var_node(&mask, GFP_ATOMIC, cpu_to_node(cpu));
84dbf66c6347206 Srikar Dronamraju 2020-10-19  1398  	update_mask_by_l2(cpu, &mask);
2a636a56d2d3967 Oliver O'Halloran 2017-06-29  1399  
b8a97cb4599cda2 Srikar Dronamraju 2020-09-21  1400  	if (has_coregroup_support())
84dbf66c6347206 Srikar Dronamraju 2020-10-19  1401  		update_coregroup_mask(cpu, &mask);
84dbf66c6347206 Srikar Dronamraju 2020-10-19  1402  
bf6476152a0a084 Srikar Dronamraju 2021-04-15  1403  	if (shared_caches)
bf6476152a0a084 Srikar Dronamraju 2021-04-15  1404  		submask_fn = cpu_l2_cache_mask;
bf6476152a0a084 Srikar Dronamraju 2021-04-15  1405  
bf6476152a0a084 Srikar Dronamraju 2021-04-15  1406  	/* Update core_mask with all the CPUs that are part of submask */
bf6476152a0a084 Srikar Dronamraju 2021-04-15  1407  	or_cpumasks_related(cpu, cpu, submask_fn, cpu_core_mask);
bf6476152a0a084 Srikar Dronamraju 2021-04-15  1408  
bf6476152a0a084 Srikar Dronamraju 2021-04-15  1409  	/* Skip all CPUs already part of current CPU core mask */
bf6476152a0a084 Srikar Dronamraju 2021-04-15  1410  	cpumask_andnot(mask, cpu_online_mask, cpu_core_mask(cpu));
bf6476152a0a084 Srikar Dronamraju 2021-04-15  1411  
e91077cf1780108 Srikar Dronamraju 2021-08-26  1412  	/* If chip_id is -1; limit the cpu_core_mask to within DIE*/
e91077cf1780108 Srikar Dronamraju 2021-08-26  1413  	if (chip_id == -1)
e91077cf1780108 Srikar Dronamraju 2021-08-26  1414  		cpumask_and(mask, mask, cpu_cpu_mask(cpu));
e91077cf1780108 Srikar Dronamraju 2021-08-26  1415  
bf6476152a0a084 Srikar Dronamraju 2021-04-15  1416  	for_each_cpu(i, mask) {
bf6476152a0a084 Srikar Dronamraju 2021-04-15  1417  		if (chip_id == cpu_to_chip_id(i)) {
bf6476152a0a084 Srikar Dronamraju 2021-04-15  1418  			or_cpumasks_related(cpu, i, submask_fn, cpu_core_mask);
bf6476152a0a084 Srikar Dronamraju 2021-04-15  1419  			cpumask_andnot(mask, mask, submask_fn(i));
bf6476152a0a084 Srikar Dronamraju 2021-04-15  1420  		} else {
bf6476152a0a084 Srikar Dronamraju 2021-04-15  1421  			cpumask_andnot(mask, mask, cpu_core_mask(i));
bf6476152a0a084 Srikar Dronamraju 2021-04-15  1422  		}
bf6476152a0a084 Srikar Dronamraju 2021-04-15  1423  	}
bf6476152a0a084 Srikar Dronamraju 2021-04-15  1424  
84dbf66c6347206 Srikar Dronamraju 2020-10-19  1425  	free_cpumask_var(mask);
a8a5356cd511db2 Paul Mackerras    2013-08-12  1426  }
a8a5356cd511db2 Paul Mackerras    2013-08-12  1427  

:::::: The code at line 1380 was first introduced by commit
:::::: bf6476152a0a084038b12b9d770e32717f54a6ab powerpc/smp: Reintroduce cpu_core_mask

:::::: TO: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

--v29I7G6zRZmhEUUb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=config

#
# Automatically generated file; DO NOT EDIT.
# Linux/powerpc 5.10.66 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="clang version 16.0.0 (git://gitmirror/llvm_project 3329cec2f79185bafd678f310fafadba2a8c76d2)"
CONFIG_GCC_VERSION=0
CONFIG_LD_VERSION=0
CONFIG_CC_IS_CLANG=y
CONFIG_LD_IS_LLD=y
CONFIG_CLANG_VERSION=160000
CONFIG_LLD_VERSION=160000
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_TOOLS_SUPPORT_RELR=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_COMPILE_TEST=y
CONFIG_LOCALVERSION=""
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_XZ is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_WATCH_QUEUE=y
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_USELIB=y
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_SHOW_LEVEL=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_ARCH_HAS_TICK_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
# CONFIG_NO_HZ is not set
# CONFIG_HIGH_RES_TIMERS is not set
# end of Timers subsystem

CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_NATIVE is not set
# CONFIG_IRQ_TIME_ACCOUNTING is not set
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_TASKSTATS=y
# CONFIG_TASK_DELAY_ACCT is not set
# CONFIG_TASK_XACCT is not set
CONFIG_PSI=y
# CONFIG_PSI_DEFAULT_DISABLED is not set
# end of CPU/Task time and stats accounting

# CONFIG_CPU_ISOLATION is not set

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
# end of RCU Subsystem

# CONFIG_IKCONFIG is not set
CONFIG_IKHEADERS=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_CGROUPS=y
# CONFIG_MEMCG is not set
CONFIG_CGROUP_SCHED=y
# CONFIG_FAIR_GROUP_SCHED is not set
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CPUSETS=y
# CONFIG_PROC_PID_CPUSET is not set
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
# CONFIG_NAMESPACES is not set
CONFIG_CHECKPOINT_RESTORE=y
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_BOOT_CONFIG is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_HAVE_LD_DEAD_CODE_DATA_ELIMINATION=y
# CONFIG_LD_DEAD_CODE_DATA_ELIMINATION is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
# CONFIG_SYSFS_SYSCALL is not set
# CONFIG_FHANDLE is not set
# CONFIG_POSIX_TIMERS is not set
# CONFIG_PRINTK is not set
CONFIG_BUG=y
# CONFIG_ELF_CORE is not set
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
# CONFIG_TIMERFD is not set
CONFIG_EVENTFD=y
# CONFIG_SHMEM is not set
CONFIG_AIO=y
# CONFIG_IO_URING is not set
CONFIG_ADVISE_SYSCALLS=y
# CONFIG_MEMBARRIER is not set
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
# CONFIG_BPF_SYSCALL is not set
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_CALLBACKS=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
# CONFIG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
# CONFIG_PERF_EVENTS is not set
# end of Kernel Performance Events And Counters

# CONFIG_VM_EVENT_COUNTERS is not set
# CONFIG_SLUB_DEBUG is not set
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
# CONFIG_SLAB_MERGE_DEFAULT is not set
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
# CONFIG_SLUB_CPU_PARTIAL is not set
# CONFIG_PROFILING is not set
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_PPC32=y
# CONFIG_PPC64 is not set
CONFIG_PPC_BOOK3S_32=y

#
# Processor support
#
CONFIG_PPC_BOOK3S_6xx=y
# CONFIG_PPC_85xx is not set
# CONFIG_PPC_8xx is not set
# CONFIG_40x is not set
# CONFIG_44x is not set
# CONFIG_E200 is not set
CONFIG_GENERIC_CPU=y
# CONFIG_E300C2_CPU is not set
# CONFIG_E300C3_CPU is not set
# CONFIG_G4_CPU is not set
CONFIG_PPC_BOOK3S=y
CONFIG_PPC_FPU=y
# CONFIG_ALTIVEC is not set
CONFIG_PPC_HAVE_KUEP=y
CONFIG_PPC_KUEP=y
CONFIG_PPC_HAVE_KUAP=y
# CONFIG_PPC_KUAP is not set
CONFIG_PPC_HAVE_PMU_SUPPORT=y
# CONFIG_PMU_SYSFS is not set
CONFIG_SMP=y
CONFIG_NR_CPUS=32
# end of Processor support

CONFIG_VDSO32=y
CONFIG_CPU_BIG_ENDIAN=y
CONFIG_32BIT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MAX=17
CONFIG_ARCH_MMAP_RND_BITS_MIN=11
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=17
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=11
CONFIG_NR_IRQS=512
CONFIG_NMI_IPI=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_PPC=y
CONFIG_EARLY_PRINTK=y
CONFIG_PANIC_TIMEOUT=180
CONFIG_SCHED_OMIT_FRAME_POINTER=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_PPC_UDBG_16550=y
CONFIG_GENERIC_TBSYNC=y
CONFIG_AUDIT_ARCH=y
CONFIG_GENERIC_BUG=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_ZONE_DMA=y
CONFIG_PGTABLE_LEVELS=2

#
# Platform support
#
CONFIG_SCOM_DEBUGFS=y
CONFIG_PPC_CHRP=y
# CONFIG_PPC_MPC512x is not set
# CONFIG_PPC_MPC52xx is not set
CONFIG_PPC_PMAC=y
CONFIG_PPC_PMAC32_PSURGE=y
# CONFIG_PPC_82xx is not set
# CONFIG_PPC_83xx is not set
# CONFIG_PPC_86xx is not set
CONFIG_KVM_GUEST=y
CONFIG_EPAPR_PARAVIRT=y
CONFIG_PPC_NATIVE=y
# CONFIG_PPC_OF_BOOT_TRAMPOLINE is not set
# CONFIG_UDBG_RTAS_CONSOLE is not set
CONFIG_PPC_SMP_MUXED_IPI=y
CONFIG_MPIC=y
# CONFIG_MPIC_MSGR is not set
CONFIG_PPC_I8259=y
CONFIG_PPC_RTAS=y
CONFIG_RTAS_ERROR_LOGGING=y
CONFIG_PPC_RTAS_DAEMON=y
CONFIG_RTAS_PROC=y
CONFIG_PPC_MPC106=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
# CONFIG_CPU_FREQ_STAT is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
# CONFIG_CPU_FREQ_GOV_PERFORMANCE is not set
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
# CONFIG_CPU_FREQ_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_GOV_SCHEDUTIL is not set

#
# CPU frequency scaling drivers
#
# CONFIG_CPUFREQ_DT is not set
CONFIG_QORIQ_CPUFREQ=y
# end of CPU Frequency scaling

#
# CPUIdle driver
#

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y
CONFIG_CPU_IDLE_GOV_TEO=y
CONFIG_CPU_IDLE_GOV_HALTPOLL=y

#
# POWERPC CPU Idle Drivers
#
# end of POWERPC CPU Idle Drivers
# end of CPU Idle
# end of CPUIdle driver

# CONFIG_TAU is not set
CONFIG_GEN_RTC=y
# end of Platform support

#
# Kernel options
#
# CONFIG_HIGHMEM is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_300=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=300
# CONFIG_HOTPLUG_CPU is not set
CONFIG_PPC_QUEUED_SPINLOCKS=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_KEXEC=y
CONFIG_CRASH_DUMP=y
# CONFIG_IRQ_ALL_CPUS is not set
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ILLEGAL_POINTER_VALUE=0
CONFIG_PPC_4K_PAGES=y
CONFIG_PPC_PAGE_SHIFT=12
CONFIG_THREAD_SHIFT=14
CONFIG_DATA_SHIFT=18
CONFIG_FORCE_MAX_ZONEORDER=13
CONFIG_CMDLINE=""
CONFIG_EXTRA_TARGETS=""
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
CONFIG_DPM_WATCHDOG=y
CONFIG_DPM_WATCHDOG_TIMEOUT=120
CONFIG_PM_CLK=y
CONFIG_PM_GENERIC_DOMAINS=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_PM_GENERIC_DOMAINS_OF=y
# CONFIG_ENERGY_MODEL is not set
CONFIG_PPC_RTAS_FILTER=y
# end of Kernel options

CONFIG_ISA_DMA_API=y

#
# Bus options
#
# CONFIG_ISA is not set
CONFIG_GENERIC_ISA_DMA=y
CONFIG_PPC_INDIRECT_PCI=y
# CONFIG_FSL_LBC is not set
# end of Bus options

#
# Advanced setup
#
# CONFIG_ADVANCED_OPTIONS is not set

#
# Default settings for advanced configuration options are used
#
CONFIG_LOWMEM_SIZE=0x30000000
CONFIG_PAGE_OFFSET=0xc0000000
CONFIG_KERNEL_START=0xc2000000
CONFIG_PHYSICAL_START=0x02000000
CONFIG_TASK_SIZE=0xc0000000
# end of Advanced setup

# CONFIG_VIRTUALIZATION is not set

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HAVE_OPROFILE=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_32BIT_OFF_T=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_MMU_GATHER_PAGE_SIZE=y
CONFIG_ARCH_WANT_IRQS_OFF_ACTIVATE_MM=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_ARCH_WEAK_RELEASE_ACQUIRE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_ARCH_MMAP_RND_BITS=11
CONFIG_HAVE_ARCH_NVRAM_OPS=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND=y
CONFIG_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_ARCH_OPTIONAL_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
# CONFIG_STRICT_KERNEL_RWX is not set
CONFIG_ARCH_HAS_PHYS_TO_DMA=y
CONFIG_LOCK_EVENT_COUNTS=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
# CONFIG_MODULES is not set
CONFIG_MODULES_TREE_LOOKUP=y
# CONFIG_BLOCK is not set
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
# CONFIG_BINFMT_SCRIPT is not set
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_ARCH_KEEP_MEMBLOCK=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_COMPACTION=y
# CONFIG_PAGE_REPORTING is not set
CONFIG_MIGRATION=y
CONFIG_VIRT_TO_BUS=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
# CONFIG_CLEANCACHE is not set
# CONFIG_CMA is not set
# CONFIG_ZPOOL is not set
# CONFIG_ZBUD is not set
# CONFIG_ZSMALLOC is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_FRAME_VECTOR=y
CONFIG_PERCPU_STATS=y
# CONFIG_GUP_BENCHMARK is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
# CONFIG_PACKET is not set
# CONFIG_UNIX is not set
# CONFIG_INET is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y

#
# DECnet: Netfilter Configuration
#
# CONFIG_DECNET_NF_GRABULATOR is not set
# end of DECnet: Netfilter Configuration

CONFIG_ATM=y
# CONFIG_ATM_LANE is not set
# CONFIG_BRIDGE is not set
CONFIG_VLAN_8021Q=y
# CONFIG_VLAN_8021Q_GVRP is not set
# CONFIG_VLAN_8021Q_MVRP is not set
CONFIG_DECNET=y
CONFIG_DECNET_ROUTER=y
CONFIG_LLC=y
# CONFIG_LLC2 is not set
CONFIG_ATALK=y
CONFIG_DEV_APPLETALK=y
CONFIG_IPDDP=y
CONFIG_IPDDP_ENCAP=y
# CONFIG_X25 is not set
CONFIG_LAPB=y
CONFIG_PHONET=y
CONFIG_IEEE802154=y
CONFIG_IEEE802154_NL802154_EXPERIMENTAL=y
CONFIG_IEEE802154_SOCKET=y
# CONFIG_MAC802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=y
CONFIG_NET_SCH_HTB=y
CONFIG_NET_SCH_HFSC=y
# CONFIG_NET_SCH_ATM is not set
CONFIG_NET_SCH_PRIO=y
# CONFIG_NET_SCH_MULTIQ is not set
CONFIG_NET_SCH_RED=y
# CONFIG_NET_SCH_SFB is not set
CONFIG_NET_SCH_SFQ=y
# CONFIG_NET_SCH_TEQL is not set
# CONFIG_NET_SCH_TBF is not set
CONFIG_NET_SCH_CBS=y
# CONFIG_NET_SCH_ETF is not set
CONFIG_NET_SCH_TAPRIO=y
# CONFIG_NET_SCH_GRED is not set
# CONFIG_NET_SCH_DSMARK is not set
# CONFIG_NET_SCH_NETEM is not set
CONFIG_NET_SCH_DRR=y
CONFIG_NET_SCH_MQPRIO=y
# CONFIG_NET_SCH_SKBPRIO is not set
# CONFIG_NET_SCH_CHOKE is not set
CONFIG_NET_SCH_QFQ=y
CONFIG_NET_SCH_CODEL=y
CONFIG_NET_SCH_FQ_CODEL=y
CONFIG_NET_SCH_CAKE=y
CONFIG_NET_SCH_FQ=y
# CONFIG_NET_SCH_HHF is not set
# CONFIG_NET_SCH_PIE is not set
CONFIG_NET_SCH_INGRESS=y
# CONFIG_NET_SCH_PLUG is not set
CONFIG_NET_SCH_ETS=y
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
# CONFIG_DEFAULT_FQ_CODEL is not set
# CONFIG_DEFAULT_SFQ is not set
CONFIG_DEFAULT_PFIFO_FAST=y
CONFIG_DEFAULT_NET_SCH="pfifo_fast"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=y
# CONFIG_NET_CLS_TCINDEX is not set
CONFIG_NET_CLS_FW=y
CONFIG_NET_CLS_U32=y
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
# CONFIG_NET_CLS_RSVP is not set
CONFIG_NET_CLS_RSVP6=y
CONFIG_NET_CLS_FLOW=y
CONFIG_NET_CLS_CGROUP=y
# CONFIG_NET_CLS_BPF is not set
# CONFIG_NET_CLS_FLOWER is not set
CONFIG_NET_CLS_MATCHALL=y
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
# CONFIG_NET_EMATCH_CMP is not set
CONFIG_NET_EMATCH_NBYTE=y
# CONFIG_NET_EMATCH_U32 is not set
# CONFIG_NET_EMATCH_META is not set
# CONFIG_NET_EMATCH_TEXT is not set
# CONFIG_NET_EMATCH_CANID is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=y
CONFIG_NET_ACT_GACT=y
# CONFIG_GACT_PROB is not set
# CONFIG_NET_ACT_MIRRED is not set
CONFIG_NET_ACT_SAMPLE=y
# CONFIG_NET_ACT_NAT is not set
CONFIG_NET_ACT_PEDIT=y
# CONFIG_NET_ACT_SIMP is not set
CONFIG_NET_ACT_SKBEDIT=y
CONFIG_NET_ACT_MPLS=y
CONFIG_NET_ACT_VLAN=y
# CONFIG_NET_ACT_BPF is not set
# CONFIG_NET_ACT_SKBMOD is not set
CONFIG_NET_ACT_IFE=y
CONFIG_NET_ACT_TUNNEL_KEY=y
CONFIG_NET_ACT_GATE=y
# CONFIG_NET_IFE_SKBMARK is not set
CONFIG_NET_IFE_SKBPRIO=y
CONFIG_NET_IFE_SKBTCINDEX=y
CONFIG_NET_TC_SKB_EXT=y
CONFIG_NET_SCH_FIFO=y
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=y
# CONFIG_BATMAN_ADV is not set
CONFIG_VSOCKETS=y
# CONFIG_VSOCKETS_DIAG is not set
# CONFIG_VSOCKETS_LOOPBACK is not set
CONFIG_VIRTIO_VSOCKETS=y
CONFIG_VIRTIO_VSOCKETS_COMMON=y
CONFIG_NETLINK_DIAG=y
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
CONFIG_HSR=y
CONFIG_QRTR=y
CONFIG_QRTR_SMD=y
# CONFIG_QRTR_TUN is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=y
CONFIG_CAN_RAW=y
# CONFIG_CAN_BCM is not set
CONFIG_CAN_GW=y
CONFIG_CAN_J1939=y
# CONFIG_CAN_ISOTP is not set

#
# CAN Device Drivers
#
# CONFIG_CAN_VCAN is not set
# CONFIG_CAN_VXCAN is not set
# CONFIG_CAN_SLCAN is not set
CONFIG_CAN_DEV=y
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_AT91 is not set
# CONFIG_CAN_FLEXCAN is not set
# CONFIG_CAN_GRCAN is not set
# CONFIG_CAN_KVASER_PCIEFD is not set
# CONFIG_CAN_SUN4I is not set
# CONFIG_CAN_XILINXCAN is not set
# CONFIG_PCH_CAN is not set
# CONFIG_CAN_C_CAN is not set
# CONFIG_CAN_CC770 is not set
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_MSCAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
# CONFIG_CAN_SJA1000 is not set
# CONFIG_CAN_SOFTING is not set

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set
# CONFIG_CAN_MCP251XFD is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
# CONFIG_CAN_8DEV_USB is not set
# CONFIG_CAN_EMS_USB is not set
# CONFIG_CAN_ESD_USB2 is not set
# CONFIG_CAN_GS_USB is not set
# CONFIG_CAN_KVASER_USB is not set
# CONFIG_CAN_MCBA_USB is not set
# CONFIG_CAN_PEAK_USB is not set
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

CONFIG_BT=y
# CONFIG_BT_BREDR is not set
CONFIG_BT_LE=y
CONFIG_BT_LEDS=y
CONFIG_BT_MSFTEXT=y
CONFIG_BT_DEBUGFS=y
# CONFIG_BT_SELFTEST is not set
# CONFIG_BT_FEATURE_DEBUG is not set

#
# Bluetooth device drivers
#
CONFIG_BT_INTEL=y
CONFIG_BT_BCM=y
CONFIG_BT_HCIBTUSB=y
CONFIG_BT_HCIBTUSB_AUTOSUSPEND=y
CONFIG_BT_HCIBTUSB_BCM=y
# CONFIG_BT_HCIBTUSB_MTK is not set
# CONFIG_BT_HCIBTUSB_RTL is not set
# CONFIG_BT_HCIUART is not set
CONFIG_BT_HCIBCM203X=y
CONFIG_BT_HCIBPA10X=y
CONFIG_BT_HCIBFUSB=y
CONFIG_BT_HCIVHCI=y
# CONFIG_BT_MRVL is not set
# CONFIG_BT_ATH3K is not set
# CONFIG_BT_QCOMSMD is not set
# end of Bluetooth device drivers

CONFIG_FIB_RULES=y
# CONFIG_WIRELESS is not set
# CONFIG_WIMAX is not set
CONFIG_RFKILL=y
CONFIG_RFKILL_LEDS=y
# CONFIG_RFKILL_INPUT is not set
CONFIG_RFKILL_GPIO=y
# CONFIG_NET_9P is not set
CONFIG_CAIF=y
CONFIG_CAIF_DEBUG=y
CONFIG_CAIF_NETDEV=y
CONFIG_CAIF_USB=y
CONFIG_NFC=y
CONFIG_NFC_DIGITAL=y
# CONFIG_NFC_NCI is not set
CONFIG_NFC_HCI=y
# CONFIG_NFC_SHDLC is not set

#
# Near Field Communication (NFC) devices
#
CONFIG_NFC_TRF7970A=y
CONFIG_NFC_SIM=y
CONFIG_NFC_PORT100=y
CONFIG_NFC_PN533=y
CONFIG_NFC_PN533_USB=y
# CONFIG_NFC_PN533_I2C is not set
CONFIG_NFC_ST95HF=y
# end of Near Field Communication (NFC) devices

CONFIG_PSAMPLE=y
CONFIG_NET_IFE=y
# CONFIG_LWTUNNEL is not set
CONFIG_FAILOVER=y
CONFIG_ETHTOOL_NETLINK=y
CONFIG_HAVE_CBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_PCI=y
CONFIG_FORCE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCI_SYSCALL=y
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
# CONFIG_PCIE_PTM is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_STUB is not set
# CONFIG_PCI_IOV is not set
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#
# CONFIG_PCI_FTPCI100 is not set
# CONFIG_PCI_HOST_GENERIC is not set
# CONFIG_PCIE_XILINX is not set
# CONFIG_PCIE_XILINX_CPM is not set
# CONFIG_PCI_XGENE is not set
# CONFIG_PCI_V3_SEMI is not set
# CONFIG_PCI_VERSATILE is not set
# CONFIG_PCIE_ALTERA is not set
# CONFIG_PCI_HOST_THUNDER_PEM is not set
# CONFIG_PCI_HOST_THUNDER_ECAM is not set
# CONFIG_PCI_LOONGSON is not set

#
# DesignWare PCI Core Support
#
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# CONFIG_PCIE_CADENCE_PLAT_HOST is not set
# CONFIG_PCI_J721E_HOST is not set
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
# CONFIG_DEVTMPFS is not set
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
CONFIG_FW_LOADER_COMPRESS=y
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEBUG_DRIVER=y
CONFIG_DEBUG_DEVRES=y
CONFIG_DEBUG_TEST_DRIVER_REMOVE=y
CONFIG_PM_QOS_KUNIT_TEST=y
CONFIG_KUNIT_DRIVER_PE_TEST=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_SOC_BUS=y
CONFIG_REGMAP=y
CONFIG_REGMAP_AC97=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_SPMI=y
CONFIG_REGMAP_W1=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_SOUNDWIRE=y
CONFIG_REGMAP_SCCB=y
CONFIG_REGMAP_SPI_AVMM=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_ARM_INTEGRATOR_LM is not set
# CONFIG_BT1_APB is not set
CONFIG_BT1_AXI=y
CONFIG_MOXTET=y
CONFIG_HISILICON_LPC=y
# CONFIG_QCOM_EBI2 is not set
# CONFIG_SIMPLE_PM_BUS is not set
# CONFIG_FSL_MC_BUS is not set
# CONFIG_MHI_BUS is not set
# end of Bus devices

# CONFIG_CONNECTOR is not set
CONFIG_GNSS=y
CONFIG_MTD=y

#
# Partition parsers
#
CONFIG_MTD_AR7_PARTS=y
CONFIG_MTD_BCM63XX_PARTS=y
CONFIG_MTD_CMDLINE_PARTS=y
CONFIG_MTD_OF_PARTS=y
CONFIG_MTD_PARSER_IMAGETAG=y
# CONFIG_MTD_PARSER_TRX is not set
CONFIG_MTD_SHARPSL_PARTS=y
CONFIG_MTD_REDBOOT_PARTS=y
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED=y
# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
# CONFIG_MTD_OOPS is not set
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
CONFIG_MTD_JEDECPROBE=y
CONFIG_MTD_GEN_PROBE=y
CONFIG_MTD_CFI_ADV_OPTIONS=y
# CONFIG_MTD_CFI_NOSWAP is not set
# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
CONFIG_MTD_CFI_LE_BYTE_SWAP=y
CONFIG_MTD_CFI_GEOMETRY=y
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_MAP_BANK_WIDTH_8=y
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
# CONFIG_MTD_CFI_I1 is not set
# CONFIG_MTD_CFI_I2 is not set
CONFIG_MTD_CFI_I4=y
# CONFIG_MTD_CFI_I8 is not set
# CONFIG_MTD_OTP is not set
# CONFIG_MTD_CFI_INTELEXT is not set
CONFIG_MTD_CFI_AMDSTD=y
CONFIG_MTD_CFI_STAA=y
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
# CONFIG_MTD_ROM is not set
CONFIG_MTD_ABSENT=y
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
# CONFIG_MTD_PHYSMAP is not set
CONFIG_MTD_SC520CDP=y
CONFIG_MTD_NETSC520=y
# CONFIG_MTD_TS5500 is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
CONFIG_MTD_PLATRAM=y
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
CONFIG_MTD_DATAFLASH=y
# CONFIG_MTD_DATAFLASH_WRITE_VERIFY is not set
CONFIG_MTD_DATAFLASH_OTP=y
# CONFIG_MTD_MCHP23K256 is not set
CONFIG_MTD_SPEAR_SMI=y
CONFIG_MTD_SST25L=y
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOCG3=y
CONFIG_BCH_CONST_M=14
CONFIG_BCH_CONST_T=4
# end of Self-contained MTD device drivers

#
# NAND
#
CONFIG_MTD_NAND_CORE=y
CONFIG_MTD_ONENAND=y
CONFIG_MTD_ONENAND_VERIFY_WRITE=y
CONFIG_MTD_ONENAND_GENERIC=y
# CONFIG_MTD_ONENAND_SAMSUNG is not set
# CONFIG_MTD_ONENAND_OTP is not set
CONFIG_MTD_ONENAND_2X_PROGRAM=y
CONFIG_MTD_NAND_ECC_SW_HAMMING=y
# CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC is not set
CONFIG_MTD_RAW_NAND=y
# CONFIG_MTD_NAND_ECC_SW_BCH is not set

#
# Raw/parallel NAND flash controllers
#
# CONFIG_MTD_NAND_DENALI_PCI is not set
# CONFIG_MTD_NAND_DENALI_DT is not set
CONFIG_MTD_NAND_AMS_DELTA=y
# CONFIG_MTD_NAND_OMAP2 is not set
# CONFIG_MTD_NAND_TANGO is not set
CONFIG_MTD_NAND_SHARPSL=y
# CONFIG_MTD_NAND_CAFE is not set
CONFIG_MTD_NAND_ATMEL=y
CONFIG_MTD_NAND_MARVELL=y
CONFIG_MTD_NAND_SLC_LPC32XX=y
# CONFIG_MTD_NAND_MLC_LPC32XX is not set
CONFIG_MTD_NAND_BRCMNAND=y
CONFIG_MTD_NAND_OXNAS=y
CONFIG_MTD_NAND_FSL_IFC=y
CONFIG_MTD_NAND_VF610_NFC=y
CONFIG_MTD_NAND_MXC=y
CONFIG_MTD_NAND_SH_FLCTL=y
CONFIG_MTD_NAND_DAVINCI=y
CONFIG_MTD_NAND_TXX9NDFMC=y
CONFIG_MTD_NAND_JZ4780=y
CONFIG_MTD_NAND_INGENIC_ECC=y
CONFIG_MTD_NAND_JZ4740_ECC=y
CONFIG_MTD_NAND_JZ4725B_BCH=y
CONFIG_MTD_NAND_JZ4780_BCH=y
CONFIG_MTD_NAND_FSMC=y
CONFIG_MTD_NAND_SUNXI=y
# CONFIG_MTD_NAND_HISI504 is not set
# CONFIG_MTD_NAND_QCOM is not set
# CONFIG_MTD_NAND_MTK is not set
CONFIG_MTD_NAND_MXIC=y
CONFIG_MTD_NAND_TEGRA=y
CONFIG_MTD_NAND_STM32_FMC2=y
# CONFIG_MTD_NAND_MESON is not set
# CONFIG_MTD_NAND_GPIO is not set
CONFIG_MTD_NAND_PLATFORM=y
CONFIG_MTD_NAND_CADENCE=y
# CONFIG_MTD_NAND_ARASAN is not set

#
# Misc
#
# CONFIG_MTD_NAND_NANDSIM is not set
# CONFIG_MTD_NAND_RICOH is not set
# CONFIG_MTD_NAND_DISKONCHIP is not set
# CONFIG_MTD_SPI_NAND is not set

#
# ECC engine support
#
CONFIG_MTD_NAND_ECC=y
# end of ECC engine support
# end of NAND

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=y
CONFIG_MTD_QINFO_PROBE=y
# end of LPDDR & LPDDR2 PCM memory drivers

CONFIG_MTD_SPI_NOR=y
# CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
CONFIG_SPI_ASPEED_SMC=y
CONFIG_SPI_HISI_SFC=y
CONFIG_SPI_NXP_SPIFI=y
# CONFIG_MTD_UBI is not set
# CONFIG_MTD_HYPERBUS is not set
CONFIG_DTC=y
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
# CONFIG_OF_ALL_DTBS is not set
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_RESERVED_MEM=y
# CONFIG_OF_OVERLAY is not set
CONFIG_OF_DMA_DEFAULT_COHERENT=y
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set

#
# NVME Support
#
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
CONFIG_AD525X_DPOT=y
CONFIG_AD525X_DPOT_I2C=y
# CONFIG_AD525X_DPOT_SPI is not set
CONFIG_DUMMY_IRQ=y
# CONFIG_PHANTOM is not set
# CONFIG_INTEL_MID_PTI is not set
# CONFIG_TIFM_CORE is not set
# CONFIG_ICS932S401 is not set
CONFIG_ATMEL_SSC=y
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HP_ILO is not set
# CONFIG_QCOM_COINCELL is not set
# CONFIG_QCOM_FASTRPC is not set
# CONFIG_APDS9802ALS is not set
CONFIG_ISL29003=y
CONFIG_ISL29020=y
CONFIG_SENSORS_TSL2550=y
# CONFIG_SENSORS_BH1770 is not set
CONFIG_SENSORS_APDS990X=y
CONFIG_HMC6352=y
CONFIG_DS1682=y
# CONFIG_PCH_PHUB is not set
# CONFIG_LATTICE_ECP3_CONFIG is not set
CONFIG_SRAM=y
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_XILINX_SDFEC=y
CONFIG_MISC_RTSX=y
CONFIG_PVPANIC=y
CONFIG_HISI_HIKEY_USB=y
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
CONFIG_EEPROM_AT25=y
CONFIG_EEPROM_LEGACY=y
# CONFIG_EEPROM_MAX6875 is not set
CONFIG_EEPROM_93CX6=y
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
CONFIG_TI_ST=y
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_SPI=y
CONFIG_SENSORS_LIS3_I2C=y
CONFIG_ALTERA_STAPL=y
CONFIG_ECHO=y
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
CONFIG_MISC_RTSX_USB=y
# CONFIG_HABANA_AI is not set
# end of Misc devices

CONFIG_HAVE_IDE=y

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# end of SCSI device support

# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
# CONFIG_FIREWIRE_OHCI is not set
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
# CONFIG_ADB is not set
# CONFIG_ADB_CUDA is not set
# CONFIG_ADB_PMU is not set
CONFIG_MAC_EMUMOUSEBTN=y
# CONFIG_THERM_WINDTUNNEL is not set
# CONFIG_THERM_ADT746X is not set
CONFIG_WINDFARM=y
# CONFIG_PMAC_RACKMETER is not set
# CONFIG_SENSORS_AMS is not set
# CONFIG_NETDEVICES is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
# CONFIG_INPUT_POLLDEV is not set
# CONFIG_INPUT_SPARSEKMAP is not set
CONFIG_INPUT_MATRIXKMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=y
# CONFIG_INPUT_EVDEV is not set
CONFIG_INPUT_EVBUG=y

#
# Input Device Drivers
#
# CONFIG_INPUT_KEYBOARD is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
# CONFIG_MOUSE_PS2_BYD is not set
# CONFIG_MOUSE_PS2_LOGIPS2PP is not set
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
# CONFIG_MOUSE_PS2_TRACKPOINT is not set
CONFIG_MOUSE_PS2_ELANTECH=y
# CONFIG_MOUSE_PS2_ELANTECH_SMBUS is not set
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_SMBUS=y
# CONFIG_MOUSE_SERIAL is not set
CONFIG_MOUSE_APPLETOUCH=y
CONFIG_MOUSE_BCM5974=y
# CONFIG_MOUSE_CYAPA is not set
CONFIG_MOUSE_ELAN_I2C=y
CONFIG_MOUSE_ELAN_I2C_I2C=y
# CONFIG_MOUSE_ELAN_I2C_SMBUS is not set
CONFIG_MOUSE_VSXXXAA=y
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=y
CONFIG_MOUSE_SYNAPTICS_USB=y
CONFIG_INPUT_JOYSTICK=y
# CONFIG_JOYSTICK_ANALOG is not set
# CONFIG_JOYSTICK_A3D is not set
CONFIG_JOYSTICK_ADI=y
# CONFIG_JOYSTICK_COBRA is not set
CONFIG_JOYSTICK_GF2K=y
CONFIG_JOYSTICK_GRIP=y
CONFIG_JOYSTICK_GRIP_MP=y
CONFIG_JOYSTICK_GUILLEMOT=y
CONFIG_JOYSTICK_INTERACT=y
CONFIG_JOYSTICK_SIDEWINDER=y
CONFIG_JOYSTICK_TMDC=y
# CONFIG_JOYSTICK_IFORCE is not set
CONFIG_JOYSTICK_WARRIOR=y
CONFIG_JOYSTICK_MAGELLAN=y
# CONFIG_JOYSTICK_SPACEORB is not set
# CONFIG_JOYSTICK_SPACEBALL is not set
CONFIG_JOYSTICK_STINGER=y
CONFIG_JOYSTICK_TWIDJOY=y
CONFIG_JOYSTICK_ZHENHUA=y
CONFIG_JOYSTICK_AS5011=y
CONFIG_JOYSTICK_JOYDUMP=y
CONFIG_JOYSTICK_XPAD=y
CONFIG_JOYSTICK_XPAD_FF=y
CONFIG_JOYSTICK_XPAD_LEDS=y
CONFIG_JOYSTICK_PSXPAD_SPI=y
CONFIG_JOYSTICK_PSXPAD_SPI_FF=y
CONFIG_JOYSTICK_PXRC=y
CONFIG_JOYSTICK_FSIA6B=y
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_88PM80X_ONKEY is not set
CONFIG_INPUT_AD714X=y
# CONFIG_INPUT_AD714X_I2C is not set
CONFIG_INPUT_AD714X_SPI=y
CONFIG_INPUT_ATMEL_CAPTOUCH=y
CONFIG_INPUT_BMA150=y
CONFIG_INPUT_E3X0_BUTTON=y
# CONFIG_INPUT_PCSPKR is not set
CONFIG_INPUT_PM8941_PWRKEY=y
CONFIG_INPUT_PM8XXX_VIBRATOR=y
CONFIG_INPUT_PMIC8XXX_PWRKEY=y
CONFIG_INPUT_MAX77650_ONKEY=y
CONFIG_INPUT_MAX77693_HAPTIC=y
# CONFIG_INPUT_MAX8925_ONKEY is not set
CONFIG_INPUT_MMA8450=y
# CONFIG_INPUT_GPIO_BEEPER is not set
# CONFIG_INPUT_GPIO_DECODER is not set
# CONFIG_INPUT_GPIO_VIBRA is not set
# CONFIG_INPUT_CPCAP_PWRBUTTON is not set
CONFIG_INPUT_ATI_REMOTE2=y
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
CONFIG_INPUT_KXTJ9=y
CONFIG_INPUT_POWERMATE=y
CONFIG_INPUT_YEALINK=y
CONFIG_INPUT_CM109=y
# CONFIG_INPUT_REGULATOR_HAPTIC is not set
# CONFIG_INPUT_RETU_PWRBUTTON is not set
CONFIG_INPUT_TPS65218_PWRBUTTON=y
CONFIG_INPUT_AXP20X_PEK=y
# CONFIG_INPUT_TWL6040_VIBRA is not set
# CONFIG_INPUT_UINPUT is not set
# CONFIG_INPUT_PALMAS_PWRBUTTON is not set
# CONFIG_INPUT_PCF8574 is not set
CONFIG_INPUT_PWM_BEEPER=y
CONFIG_INPUT_PWM_VIBRA=y
CONFIG_INPUT_GPIO_ROTARY_ENCODER=y
# CONFIG_INPUT_DA9052_ONKEY is not set
CONFIG_INPUT_PCAP=y
CONFIG_INPUT_ADXL34X=y
CONFIG_INPUT_ADXL34X_I2C=y
CONFIG_INPUT_ADXL34X_SPI=y
CONFIG_INPUT_IMS_PCU=y
CONFIG_INPUT_IQS269A=y
CONFIG_INPUT_CMA3000=y
CONFIG_INPUT_CMA3000_I2C=y
CONFIG_INPUT_IDEAPAD_SLIDEBAR=y
CONFIG_INPUT_DRV260X_HAPTICS=y
CONFIG_INPUT_DRV2665_HAPTICS=y
# CONFIG_INPUT_DRV2667_HAPTICS is not set
CONFIG_INPUT_HISI_POWERKEY=y
CONFIG_INPUT_SC27XX_VIBRA=y
CONFIG_INPUT_STPMIC1_ONKEY=y
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=y
CONFIG_RMI4_SPI=y
CONFIG_RMI4_SMB=y
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
# CONFIG_RMI4_F3A is not set
CONFIG_RMI4_F54=y
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
CONFIG_SERIO_XILINX_XPS_PS2=y
# CONFIG_SERIO_ALTERA_PS2 is not set
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=y
CONFIG_SERIO_APBPS2=y
CONFIG_SERIO_OLPC_APSP=y
CONFIG_SERIO_SUN4I_PS2=y
CONFIG_SERIO_GPIO_PS2=y
CONFIG_USERIO=y
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=y
# CONFIG_GAMEPORT_L4 is not set
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_FM801 is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
# CONFIG_VT_CONSOLE is not set
CONFIG_HW_CONSOLE=y
# CONFIG_VT_HW_CONSOLE_BINDING is not set
# CONFIG_UNIX98_PTYS is not set
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_LDISC_AUTOLOAD is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_16550A_VARIANTS=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
# CONFIG_SERIAL_8250_DMA is not set
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_MEN_MCB=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
CONFIG_SERIAL_8250_ASPEED_VUART=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_FSL=y
CONFIG_SERIAL_8250_DW=y
CONFIG_SERIAL_8250_RT288X=y
# CONFIG_SERIAL_8250_LPC18XX is not set
CONFIG_SERIAL_8250_UNIPHIER=y
# CONFIG_SERIAL_8250_INGENIC is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_TEGRA is not set
CONFIG_SERIAL_OF_PLATFORM=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_ATMEL is not set
# CONFIG_SERIAL_CLPS711X is not set
CONFIG_SERIAL_SAMSUNG=y
CONFIG_SERIAL_SAMSUNG_UARTS_4=y
CONFIG_SERIAL_SAMSUNG_UARTS=4
CONFIG_SERIAL_SAMSUNG_CONSOLE=y
CONFIG_SERIAL_MAX3100=y
CONFIG_SERIAL_MAX310X=y
CONFIG_SERIAL_IMX=y
CONFIG_SERIAL_IMX_CONSOLE=y
# CONFIG_SERIAL_IMX_EARLYCON is not set
CONFIG_SERIAL_UARTLITE=y
# CONFIG_SERIAL_UARTLITE_CONSOLE is not set
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_SH_SCI=y
CONFIG_SERIAL_SH_SCI_NR_UARTS=2
CONFIG_SERIAL_SH_SCI_CONSOLE=y
CONFIG_SERIAL_SH_SCI_EARLYCON=y
# CONFIG_SERIAL_SH_SCI_DMA is not set
# CONFIG_SERIAL_HS_LPC32XX is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_PMACZILOG is not set
# CONFIG_SERIAL_JSM is not set
CONFIG_SERIAL_SIFIVE=y
# CONFIG_SERIAL_SIFIVE_CONSOLE is not set
CONFIG_SERIAL_LANTIQ=y
# CONFIG_SERIAL_LANTIQ_CONSOLE is not set
CONFIG_SERIAL_SCCNXP=y
CONFIG_SERIAL_SCCNXP_CONSOLE=y
CONFIG_SERIAL_SC16IS7XX_CORE=y
CONFIG_SERIAL_SC16IS7XX=y
# CONFIG_SERIAL_SC16IS7XX_I2C is not set
CONFIG_SERIAL_SC16IS7XX_SPI=y
CONFIG_SERIAL_TIMBERDALE=y
# CONFIG_SERIAL_BCM63XX is not set
CONFIG_SERIAL_ALTERA_JTAGUART=y
CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE=y
# CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE_BYPASS is not set
CONFIG_SERIAL_ALTERA_UART=y
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
CONFIG_SERIAL_ALTERA_UART_CONSOLE=y
# CONFIG_SERIAL_IFX6X60 is not set
# CONFIG_SERIAL_PCH_UART is not set
# CONFIG_SERIAL_MXS_AUART is not set
CONFIG_SERIAL_XILINX_PS_UART=y
# CONFIG_SERIAL_XILINX_PS_UART_CONSOLE is not set
CONFIG_SERIAL_MPS2_UART_CONSOLE=y
CONFIG_SERIAL_MPS2_UART=y
CONFIG_SERIAL_ARC=y
# CONFIG_SERIAL_ARC_CONSOLE is not set
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
CONFIG_SERIAL_FSL_LPUART=y
CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
CONFIG_SERIAL_CONEXANT_DIGICOLOR=y
CONFIG_SERIAL_CONEXANT_DIGICOLOR_CONSOLE=y
# CONFIG_SERIAL_ST_ASC is not set
CONFIG_SERIAL_MEN_Z135=y
CONFIG_SERIAL_SPRD=y
# CONFIG_SERIAL_SPRD_CONSOLE is not set
# CONFIG_SERIAL_STM32 is not set
CONFIG_SERIAL_MVEBU_UART=y
CONFIG_SERIAL_MVEBU_CONSOLE=y
CONFIG_SERIAL_OWL=y
CONFIG_SERIAL_OWL_CONSOLE=y
# CONFIG_SERIAL_RDA is not set
# CONFIG_SERIAL_MILBEAUT_USIO is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
# CONFIG_CYCLADES is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
# CONFIG_SYNCLINK is not set
# CONFIG_SYNCLINKMP is not set
# CONFIG_SYNCLINK_GT is not set
# CONFIG_ISI is not set
CONFIG_N_HDLC=y
CONFIG_PPC_EPAPR_HV_BYTECHAN=y
CONFIG_PPC_EARLY_DEBUG_EHV_BC=y
CONFIG_PPC_EARLY_DEBUG_EHV_BC_HANDLE=0
CONFIG_N_GSM=y
# CONFIG_NOZOMI is not set
# CONFIG_NULL_TTY is not set
# CONFIG_TRACE_SINK is not set
# CONFIG_HVC_RTAS is not set
# CONFIG_HVC_UDBG is not set
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_TTY_PRINTK=y
CONFIG_TTY_PRINTK_LEVEL=6
# CONFIG_VIRTIO_CONSOLE is not set
# CONFIG_IPMI_HANDLER is not set
CONFIG_IPMI_KCS_BMC=y
# CONFIG_ASPEED_KCS_IPMI_BMC is not set
CONFIG_NPCM7XX_KCS_IPMI_BMC=y
CONFIG_ASPEED_BT_IPMI_BMC=y
CONFIG_IPMB_DEVICE_INTERFACE=y
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=y
CONFIG_HW_RANDOM_BA431=y
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_HW_RANDOM_IMX_RNGC=y
CONFIG_HW_RANDOM_STM32=y
CONFIG_HW_RANDOM_MESON=y
CONFIG_HW_RANDOM_MTK=y
CONFIG_HW_RANDOM_EXYNOS=y
# CONFIG_HW_RANDOM_NPCM is not set
CONFIG_HW_RANDOM_KEYSTONE=y
CONFIG_HW_RANDOM_CCTRNG=y
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_DEVMEM is not set
# CONFIG_DEVKMEM is not set
CONFIG_NVRAM=y
CONFIG_DEVPORT=y
# CONFIG_TCG_TPM is not set
# CONFIG_XILLYBUS is not set
# end of Character devices

CONFIG_RANDOM_TRUST_BOOTLOADER=y

#
# I2C support
#
CONFIG_I2C=y
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=y
CONFIG_I2C_MUX_GPIO=y
CONFIG_I2C_MUX_GPMUX=y
# CONFIG_I2C_MUX_LTC4306 is not set
CONFIG_I2C_MUX_PCA9541=y
CONFIG_I2C_MUX_PCA954x=y
# CONFIG_I2C_MUX_PINCTRL is not set
CONFIG_I2C_MUX_REG=y
CONFIG_I2C_DEMUX_PINCTRL=y
CONFIG_I2C_MUX_MLXCPLD=y
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_HIX5HD2 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# Mac SMBus host controller drivers
#
# CONFIG_I2C_HYDRA is not set
CONFIG_I2C_POWERMAC=y

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_ALTERA=y
CONFIG_I2C_ASPEED=y
# CONFIG_I2C_AT91 is not set
CONFIG_I2C_AXXIA=y
# CONFIG_I2C_BCM2835 is not set
CONFIG_I2C_BCM_IPROC=y
CONFIG_I2C_BCM_KONA=y
CONFIG_I2C_BRCMSTB=y
# CONFIG_I2C_CBUS_GPIO is not set
# CONFIG_I2C_DAVINCI is not set
CONFIG_I2C_DESIGNWARE_CORE=y
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_DIGICOLOR is not set
# CONFIG_I2C_EFM32 is not set
# CONFIG_I2C_EG20T is not set
CONFIG_I2C_EMEV2=y
CONFIG_I2C_EXYNOS5=y
CONFIG_I2C_GPIO=y
# CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
# CONFIG_I2C_HIGHLANDER is not set
CONFIG_I2C_IMG=y
CONFIG_I2C_IMX_LPI2C=y
CONFIG_I2C_IOP3XX=y
# CONFIG_I2C_JZ4780 is not set
# CONFIG_I2C_LPC2K is not set
CONFIG_I2C_MESON=y
CONFIG_I2C_MPC=y
CONFIG_I2C_MT65XX=y
CONFIG_I2C_MT7621=y
CONFIG_I2C_MV64XXX=y
# CONFIG_I2C_MXS is not set
# CONFIG_I2C_NPCM7XX is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_OMAP=y
# CONFIG_I2C_OWL is not set
CONFIG_I2C_PCA_PLATFORM=y
# CONFIG_I2C_PMCMSP is not set
CONFIG_I2C_PNX=y
CONFIG_I2C_PXA=y
CONFIG_I2C_PXA_SLAVE=y
# CONFIG_I2C_QCOM_CCI is not set
# CONFIG_I2C_RIIC is not set
CONFIG_I2C_RK3X=y
# CONFIG_I2C_S3C2410 is not set
CONFIG_I2C_SH_MOBILE=y
CONFIG_I2C_SIMTEC=y
# CONFIG_I2C_SIRF is not set
CONFIG_I2C_SPRD=y
CONFIG_I2C_ST=y
CONFIG_I2C_STM32F4=y
CONFIG_I2C_STM32F7=y
# CONFIG_I2C_STU300 is not set
# CONFIG_I2C_SUN6I_P2WI is not set
# CONFIG_I2C_SYNQUACER is not set
# CONFIG_I2C_TEGRA_BPMP is not set
CONFIG_I2C_UNIPHIER=y
# CONFIG_I2C_UNIPHIER_F is not set
CONFIG_I2C_VERSATILE=y
# CONFIG_I2C_WMT is not set
CONFIG_I2C_XILINX=y
# CONFIG_I2C_XLR is not set
CONFIG_I2C_XLP9XX=y
CONFIG_I2C_RCAR=y

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_DLN2 is not set
CONFIG_I2C_ROBOTFUZZ_OSIF=y
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=y

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=y
# CONFIG_I2C_FSI is not set
# end of I2C Hardware Bus support

CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
# CONFIG_I2C_SLAVE_TESTUNIT is not set
# CONFIG_I2C_DEBUG_CORE is not set
CONFIG_I2C_DEBUG_ALGO=y
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

CONFIG_I3C=y
CONFIG_CDNS_I3C_MASTER=y
CONFIG_DW_I3C_MASTER=y
CONFIG_SPI=y
CONFIG_SPI_DEBUG=y
CONFIG_SPI_MASTER=y
CONFIG_SPI_MEM=y

#
# SPI Master Controller Drivers
#
CONFIG_SPI_ALTERA=y
# CONFIG_SPI_AR934X is not set
CONFIG_SPI_ATH79=y
CONFIG_SPI_ARMADA_3700=y
CONFIG_SPI_ATMEL=y
# CONFIG_SPI_AT91_USART is not set
CONFIG_SPI_ATMEL_QUADSPI=y
CONFIG_SPI_AXI_SPI_ENGINE=y
# CONFIG_SPI_BCM2835 is not set
CONFIG_SPI_BCM2835AUX=y
CONFIG_SPI_BCM63XX=y
CONFIG_SPI_BCM63XX_HSSPI=y
CONFIG_SPI_BCM_QSPI=y
CONFIG_SPI_BITBANG=y
CONFIG_SPI_CADENCE=y
CONFIG_SPI_CADENCE_QUADSPI=y
CONFIG_SPI_CLPS711X=y
# CONFIG_SPI_DESIGNWARE is not set
CONFIG_SPI_DLN2=y
CONFIG_SPI_EP93XX=y
# CONFIG_SPI_FSI is not set
CONFIG_SPI_FSL_LPSPI=y
CONFIG_SPI_FSL_QUADSPI=y
CONFIG_SPI_HISI_SFC_V3XX=y
CONFIG_SPI_NXP_FLEXSPI=y
CONFIG_SPI_GPIO=y
CONFIG_SPI_IMG_SPFI=y
CONFIG_SPI_IMX=y
CONFIG_SPI_JCORE=y
# CONFIG_SPI_LP8841_RTC is not set
CONFIG_SPI_FSL_LIB=y
CONFIG_SPI_FSL_SPI=y
# CONFIG_SPI_FSL_DSPI is not set
CONFIG_SPI_MESON_SPICC=y
CONFIG_SPI_MESON_SPIFC=y
CONFIG_SPI_MT65XX=y
# CONFIG_SPI_MT7621 is not set
CONFIG_SPI_MTK_NOR=y
CONFIG_SPI_NPCM_FIU=y
CONFIG_SPI_NPCM_PSPI=y
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
CONFIG_SPI_OMAP24XX=y
CONFIG_SPI_TI_QSPI=y
CONFIG_SPI_OMAP_100K=y
# CONFIG_SPI_ORION is not set
# CONFIG_SPI_PIC32 is not set
# CONFIG_SPI_PIC32_SQI is not set
CONFIG_SPI_PXA2XX=y
CONFIG_SPI_PXA2XX_PCI=y
CONFIG_SPI_ROCKCHIP=y
# CONFIG_SPI_RSPI is not set
CONFIG_SPI_QUP=y
CONFIG_SPI_S3C64XX=y
CONFIG_SPI_SC18IS602=y
CONFIG_SPI_SH_MSIOF=y
CONFIG_SPI_SH=y
CONFIG_SPI_SH_HSPI=y
# CONFIG_SPI_SIFIVE is not set
CONFIG_SPI_SPRD=y
# CONFIG_SPI_SPRD_ADI is not set
CONFIG_SPI_STM32=y
CONFIG_SPI_STM32_QSPI=y
CONFIG_SPI_ST_SSC4=y
# CONFIG_SPI_SUN4I is not set
CONFIG_SPI_SUN6I=y
CONFIG_SPI_SYNQUACER=y
# CONFIG_SPI_MXIC is not set
CONFIG_SPI_TEGRA114=y
# CONFIG_SPI_TEGRA20_SFLASH is not set
CONFIG_SPI_TEGRA20_SLINK=y
# CONFIG_SPI_TOPCLIFF_PCH is not set
# CONFIG_SPI_TXX9 is not set
# CONFIG_SPI_UNIPHIER is not set
CONFIG_SPI_XCOMM=y
CONFIG_SPI_XILINX=y
CONFIG_SPI_XLP=y
CONFIG_SPI_XTENSA_XTFPGA=y
# CONFIG_SPI_ZYNQ_QSPI is not set
CONFIG_SPI_ZYNQMP_GQSPI=y
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
CONFIG_SPI_MUX=y

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=y
CONFIG_SPI_TLE62X0=y
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
CONFIG_SPMI=y
CONFIG_SPMI_MSM_PMIC_ARB=y
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
CONFIG_HSI_CHAR=y
CONFIG_PPS=y
CONFIG_PPS_DEBUG=y
# CONFIG_NTP_PPS is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=y
CONFIG_PPS_CLIENT_GPIO=y

#
# PPS generators support
#

#
# PTP clock support
#

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# CONFIG_PTP_1588_CLOCK_PCH is not set
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AXP209 is not set
CONFIG_PINCTRL_AT91PIO4=y
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_BM1880 is not set
CONFIG_PINCTRL_DA850_PUPD=y
CONFIG_PINCTRL_LPC18XX=y
CONFIG_PINCTRL_MCP23S08_I2C=y
CONFIG_PINCTRL_MCP23S08_SPI=y
CONFIG_PINCTRL_MCP23S08=y
CONFIG_PINCTRL_SINGLE=y
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_STMFX=y
CONFIG_PINCTRL_PALMAS=y
# CONFIG_PINCTRL_INGENIC is not set
# CONFIG_PINCTRL_OCELOT is not set
CONFIG_PINCTRL_OWL=y
# CONFIG_PINCTRL_S500 is not set
# CONFIG_PINCTRL_S700 is not set
# CONFIG_PINCTRL_S900 is not set
CONFIG_PINCTRL_ASPEED=y
CONFIG_PINCTRL_ASPEED_G4=y
# CONFIG_PINCTRL_ASPEED_G5 is not set
CONFIG_PINCTRL_ASPEED_G6=y
CONFIG_PINCTRL_BCM281XX=y
# CONFIG_PINCTRL_BCM2835 is not set
# CONFIG_PINCTRL_IPROC_GPIO is not set
# CONFIG_PINCTRL_CYGNUS_MUX is not set
CONFIG_PINCTRL_NS=y
CONFIG_PINCTRL_NSP_GPIO=y
# CONFIG_PINCTRL_NS2_MUX is not set
# CONFIG_PINCTRL_NSP_MUX is not set
CONFIG_PINCTRL_BERLIN=y
CONFIG_PINCTRL_AS370=y
CONFIG_PINCTRL_BERLIN_BG4CT=y
CONFIG_PINCTRL_NPCM7XX=y
CONFIG_PINCTRL_PXA=y
# CONFIG_PINCTRL_PXA25X is not set
CONFIG_PINCTRL_PXA27X=y
# CONFIG_PINCTRL_APQ8064 is not set
# CONFIG_PINCTRL_APQ8084 is not set
# CONFIG_PINCTRL_IPQ4019 is not set
# CONFIG_PINCTRL_IPQ8064 is not set
# CONFIG_PINCTRL_IPQ8074 is not set
# CONFIG_PINCTRL_IPQ6018 is not set
# CONFIG_PINCTRL_MSM8226 is not set
# CONFIG_PINCTRL_MSM8660 is not set
# CONFIG_PINCTRL_MSM8960 is not set
# CONFIG_PINCTRL_MDM9615 is not set
# CONFIG_PINCTRL_MSM8X74 is not set
# CONFIG_PINCTRL_MSM8916 is not set
# CONFIG_PINCTRL_MSM8976 is not set
# CONFIG_PINCTRL_MSM8994 is not set
# CONFIG_PINCTRL_MSM8996 is not set
# CONFIG_PINCTRL_MSM8998 is not set
# CONFIG_PINCTRL_QCS404 is not set
CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
CONFIG_PINCTRL_QCOM_SSBI_PMIC=y
# CONFIG_PINCTRL_SC7180 is not set
# CONFIG_PINCTRL_SDM660 is not set
# CONFIG_PINCTRL_SDM845 is not set
# CONFIG_PINCTRL_SM8150 is not set
# CONFIG_PINCTRL_SM8250 is not set

#
# Renesas pinctrl drivers
#
CONFIG_PINCTRL_RENESAS=y
CONFIG_PINCTRL_SH_PFC=y
CONFIG_PINCTRL_SH_PFC_GPIO=y
CONFIG_PINCTRL_SH_FUNC_GPIO=y
# CONFIG_PINCTRL_PFC_EMEV2 is not set
# CONFIG_PINCTRL_PFC_R8A77995 is not set
CONFIG_PINCTRL_PFC_R8A7794=y
CONFIG_PINCTRL_PFC_R8A77990=y
CONFIG_PINCTRL_PFC_R8A7779=y
# CONFIG_PINCTRL_PFC_R8A7790 is not set
# CONFIG_PINCTRL_PFC_R8A77950 is not set
CONFIG_PINCTRL_PFC_R8A77951=y
# CONFIG_PINCTRL_PFC_R8A7778 is not set
CONFIG_PINCTRL_PFC_R8A7793=y
CONFIG_PINCTRL_PFC_R8A7791=y
# CONFIG_PINCTRL_PFC_R8A77965 is not set
# CONFIG_PINCTRL_PFC_R8A77960 is not set
CONFIG_PINCTRL_PFC_R8A77961=y
CONFIG_PINCTRL_PFC_R8A7792=y
# CONFIG_PINCTRL_PFC_R8A77980 is not set
CONFIG_PINCTRL_PFC_R8A77970=y
# CONFIG_PINCTRL_PFC_R8A7740 is not set
# CONFIG_PINCTRL_PFC_R8A73A4 is not set
CONFIG_PINCTRL_RZA1=y
CONFIG_PINCTRL_RZA2=y
CONFIG_PINCTRL_PFC_R8A77470=y
CONFIG_PINCTRL_PFC_R8A7745=y
CONFIG_PINCTRL_PFC_R8A7742=y
CONFIG_PINCTRL_PFC_R8A7743=y
# CONFIG_PINCTRL_PFC_R8A7744 is not set
CONFIG_PINCTRL_PFC_R8A774C0=y
# CONFIG_PINCTRL_PFC_R8A774E1 is not set
CONFIG_PINCTRL_PFC_R8A774A1=y
CONFIG_PINCTRL_PFC_R8A774B1=y
# CONFIG_PINCTRL_RZN1 is not set
# CONFIG_PINCTRL_PFC_SH7203 is not set
CONFIG_PINCTRL_PFC_SH7264=y
# CONFIG_PINCTRL_PFC_SH7269 is not set
# CONFIG_PINCTRL_PFC_SH7720 is not set
CONFIG_PINCTRL_PFC_SH7722=y
# CONFIG_PINCTRL_PFC_SH7734 is not set
CONFIG_PINCTRL_PFC_SH7757=y
# CONFIG_PINCTRL_PFC_SH7785 is not set
# CONFIG_PINCTRL_PFC_SH7786 is not set
CONFIG_PINCTRL_PFC_SH73A0=y
# CONFIG_PINCTRL_PFC_SH7723 is not set
CONFIG_PINCTRL_PFC_SH7724=y
# CONFIG_PINCTRL_PFC_SHX3 is not set
# end of Renesas pinctrl drivers

CONFIG_PINCTRL_SAMSUNG=y
CONFIG_PINCTRL_EXYNOS=y
CONFIG_PINCTRL_EXYNOS_ARM=y
CONFIG_PINCTRL_EXYNOS_ARM64=y
# CONFIG_PINCTRL_S3C24XX is not set
# CONFIG_PINCTRL_S3C64XX is not set
CONFIG_PINCTRL_SPRD=y
CONFIG_PINCTRL_SPRD_SC9860=y
CONFIG_PINCTRL_STM32=y
# CONFIG_PINCTRL_STM32F429 is not set
CONFIG_PINCTRL_STM32F469=y
# CONFIG_PINCTRL_STM32F746 is not set
# CONFIG_PINCTRL_STM32F769 is not set
# CONFIG_PINCTRL_STM32H743 is not set
CONFIG_PINCTRL_STM32MP157=y
CONFIG_PINCTRL_TI_IODELAY=y
# CONFIG_PINCTRL_UNIPHIER is not set

#
# MediaTek pinctrl drivers
#
CONFIG_EINT_MTK=y
CONFIG_PINCTRL_MTK=y
CONFIG_PINCTRL_MTK_V2=y
CONFIG_PINCTRL_MTK_PARIS=y
CONFIG_PINCTRL_MT2701=y
# CONFIG_PINCTRL_MT7623 is not set
# CONFIG_PINCTRL_MT7629 is not set
# CONFIG_PINCTRL_MT8135 is not set
# CONFIG_PINCTRL_MT8127 is not set
CONFIG_PINCTRL_MT2712=y
CONFIG_PINCTRL_MT6765=y
# CONFIG_PINCTRL_MT6779 is not set
# CONFIG_PINCTRL_MT6797 is not set
# CONFIG_PINCTRL_MT7622 is not set
CONFIG_PINCTRL_MT8167=y
CONFIG_PINCTRL_MT8173=y
# CONFIG_PINCTRL_MT8183 is not set
CONFIG_PINCTRL_MT8192=y
CONFIG_PINCTRL_MT8516=y
# CONFIG_PINCTRL_MT6397 is not set
# end of MediaTek pinctrl drivers

CONFIG_PINCTRL_LOCHNAGAR=y
CONFIG_PINCTRL_MADERA=y
CONFIG_PINCTRL_CS47L15=y
CONFIG_PINCTRL_CS47L90=y
CONFIG_PINCTRL_CS47L92=y
CONFIG_PINCTRL_VISCONTI=y
CONFIG_PINCTRL_TMPV7700=y
CONFIG_PINCTRL_EQUILIBRIUM=y
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
# CONFIG_GPIO_SYSFS is not set
CONFIG_GPIO_CDEV=y
# CONFIG_GPIO_CDEV_V1 is not set
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=y
CONFIG_GPIO_ALTERA=y
CONFIG_GPIO_ASPEED=y
# CONFIG_GPIO_ASPEED_SGPIO is not set
CONFIG_GPIO_ATH79=y
CONFIG_GPIO_RASPBERRYPI_EXP=y
CONFIG_GPIO_BCM_KONA=y
CONFIG_GPIO_BCM_XGS_IPROC=y
# CONFIG_GPIO_BRCMSTB is not set
# CONFIG_GPIO_CADENCE is not set
CONFIG_GPIO_CLPS711X=y
CONFIG_GPIO_DWAPB=y
CONFIG_GPIO_EIC_SPRD=y
# CONFIG_GPIO_EM is not set
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_FTGPIO010=y
CONFIG_GPIO_GENERIC_PLATFORM=y
CONFIG_GPIO_GRGPIO=y
# CONFIG_GPIO_HLWD is not set
CONFIG_GPIO_IOP=y
CONFIG_GPIO_LOGICVC=y
CONFIG_GPIO_LPC18XX=y
# CONFIG_GPIO_LPC32XX is not set
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_MENZ127 is not set
# CONFIG_GPIO_MPC8XXX is not set
# CONFIG_GPIO_MT7621 is not set
CONFIG_GPIO_MXC=y
# CONFIG_GPIO_MXS is not set
CONFIG_GPIO_PMIC_EIC_SPRD=y
CONFIG_GPIO_PXA=y
CONFIG_GPIO_RCAR=y
CONFIG_GPIO_RDA=y
CONFIG_GPIO_SAMA5D2_PIOBU=y
# CONFIG_GPIO_SIFIVE is not set
# CONFIG_GPIO_SIOX is not set
CONFIG_GPIO_SNPS_CREG=y
# CONFIG_GPIO_SPRD is not set
# CONFIG_GPIO_STP_XWAY is not set
CONFIG_GPIO_SYSCON=y
CONFIG_GPIO_TEGRA=y
CONFIG_GPIO_TEGRA186=y
# CONFIG_GPIO_TS4800 is not set
CONFIG_GPIO_UNIPHIER=y
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_XGENE_SB is not set
CONFIG_GPIO_XILINX=y
CONFIG_GPIO_XLP=y
# CONFIG_GPIO_ZX is not set
CONFIG_GPIO_AMD_FCH=y
# end of Memory mapped GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=y
# CONFIG_GPIO_ADP5588_IRQ is not set
CONFIG_GPIO_ADNP=y
# CONFIG_GPIO_GW_PLD is not set
CONFIG_GPIO_MAX7300=y
CONFIG_GPIO_MAX732X=y
# CONFIG_GPIO_MAX732X_IRQ is not set
CONFIG_GPIO_PCA953X=y
CONFIG_GPIO_PCA953X_IRQ=y
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
CONFIG_GPIO_TPIC2810=y
CONFIG_GPIO_TS4900=y
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_BD9571MWV=y
CONFIG_GPIO_DA9052=y
# CONFIG_GPIO_DLN2 is not set
# CONFIG_GPIO_LP873X is not set
# CONFIG_GPIO_LP87565 is not set
# CONFIG_GPIO_MADERA is not set
# CONFIG_GPIO_MAX77650 is not set
# CONFIG_GPIO_PALMAS is not set
# CONFIG_GPIO_SL28CPLD is not set
# CONFIG_GPIO_TC3589X is not set
# CONFIG_GPIO_TPS65218 is not set
# CONFIG_GPIO_TPS6586X is not set
# CONFIG_GPIO_TPS65910 is not set
CONFIG_GPIO_TPS65912=y
# CONFIG_GPIO_TQMX86 is not set
CONFIG_GPIO_TWL6040=y
# CONFIG_GPIO_WM8350 is not set
CONFIG_GPIO_WM8994=y
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_74X164 is not set
CONFIG_GPIO_MAX3191X=y
# CONFIG_GPIO_MAX7301 is not set
CONFIG_GPIO_MC33880=y
# CONFIG_GPIO_PISOSR is not set
CONFIG_GPIO_XRA1403=y
CONFIG_GPIO_MOXTET=y
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

# CONFIG_GPIO_AGGREGATOR is not set
CONFIG_GPIO_MOCKUP=y
CONFIG_W1=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2490=y
CONFIG_W1_MASTER_DS2482=y
CONFIG_W1_MASTER_MXC=y
# CONFIG_W1_MASTER_DS1WM is not set
CONFIG_W1_MASTER_GPIO=y
CONFIG_W1_MASTER_SGI=y
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
CONFIG_W1_SLAVE_SMEM=y
CONFIG_W1_SLAVE_DS2405=y
CONFIG_W1_SLAVE_DS2408=y
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
# CONFIG_W1_SLAVE_DS2413 is not set
CONFIG_W1_SLAVE_DS2406=y
CONFIG_W1_SLAVE_DS2423=y
# CONFIG_W1_SLAVE_DS2805 is not set
CONFIG_W1_SLAVE_DS2430=y
CONFIG_W1_SLAVE_DS2431=y
# CONFIG_W1_SLAVE_DS2433 is not set
CONFIG_W1_SLAVE_DS2438=y
# CONFIG_W1_SLAVE_DS250X is not set
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
# CONFIG_W1_SLAVE_DS28E04 is not set
CONFIG_W1_SLAVE_DS28E17=y
# end of 1-wire Slaves

CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_BRCMKONA=y
# CONFIG_POWER_RESET_BRCMSTB is not set
# CONFIG_POWER_RESET_GEMINI_POWEROFF is not set
# CONFIG_POWER_RESET_GPIO is not set
# CONFIG_POWER_RESET_GPIO_RESTART is not set
# CONFIG_POWER_RESET_OCELOT_RESET is not set
# CONFIG_POWER_RESET_PIIX4_POWEROFF is not set
# CONFIG_POWER_RESET_LTC2952 is not set
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_RESET_KEYSTONE=y
CONFIG_POWER_RESET_SYSCON=y
# CONFIG_POWER_RESET_SYSCON_POWEROFF is not set
# CONFIG_POWER_RESET_RMOBILE is not set
# CONFIG_POWER_RESET_ZX is not set
CONFIG_REBOOT_MODE=y
# CONFIG_SYSCON_REBOOT_MODE is not set
CONFIG_POWER_RESET_SC27XX=y
CONFIG_NVMEM_REBOOT_MODE=y
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
CONFIG_PDA_POWER=y
CONFIG_MAX8925_POWER=y
CONFIG_WM8350_POWER=y
CONFIG_TEST_POWER=y
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_ACT8945A is not set
CONFIG_BATTERY_CW2015=y
CONFIG_BATTERY_DS2760=y
CONFIG_BATTERY_DS2780=y
# CONFIG_BATTERY_DS2781 is not set
CONFIG_BATTERY_DS2782=y
CONFIG_BATTERY_SBS=y
CONFIG_CHARGER_SBS=y
CONFIG_MANAGER_SBS=y
CONFIG_BATTERY_BQ27XXX=y
# CONFIG_BATTERY_BQ27XXX_I2C is not set
CONFIG_BATTERY_BQ27XXX_HDQ=y
# CONFIG_BATTERY_DA9030 is not set
# CONFIG_BATTERY_DA9052 is not set
# CONFIG_BATTERY_DA9150 is not set
CONFIG_BATTERY_MAX17040=y
# CONFIG_BATTERY_MAX17042 is not set
CONFIG_BATTERY_MAX1721X=y
# CONFIG_CHARGER_ISP1704 is not set
CONFIG_CHARGER_MAX8903=y
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
CONFIG_CHARGER_MANAGER=y
CONFIG_CHARGER_LT3651=y
CONFIG_CHARGER_DETECTOR_MAX14656=y
CONFIG_CHARGER_MAX77650=y
# CONFIG_CHARGER_MAX77693 is not set
CONFIG_CHARGER_QCOM_SMBB=y
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24190 is not set
CONFIG_CHARGER_BQ24257=y
CONFIG_CHARGER_BQ24735=y
# CONFIG_CHARGER_BQ2515X is not set
CONFIG_CHARGER_BQ25890=y
CONFIG_CHARGER_BQ25980=y
# CONFIG_CHARGER_SMB347 is not set
CONFIG_CHARGER_TPS65090=y
# CONFIG_CHARGER_TPS65217 is not set
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_BATTERY_GOLDFISH=y
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_SC2731 is not set
CONFIG_CHARGER_UCS1002=y
CONFIG_CHARGER_BD99954=y
# CONFIG_RN5T618_POWER is not set
# CONFIG_HWMON is not set
CONFIG_THERMAL=y
CONFIG_THERMAL_NETLINK=y
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_OF=y
# CONFIG_THERMAL_WRITABLE_TRIPS is not set
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_GOV_STEP_WISE is not set
CONFIG_THERMAL_GOV_BANG_BANG=y
# CONFIG_THERMAL_GOV_USER_SPACE is not set
CONFIG_CPU_THERMAL=y
CONFIG_CPU_FREQ_THERMAL=y
CONFIG_DEVFREQ_THERMAL=y
CONFIG_THERMAL_EMULATION=y
CONFIG_THERMAL_MMIO=y
CONFIG_HISI_THERMAL=y
CONFIG_IMX_THERMAL=y
CONFIG_IMX8MM_THERMAL=y
CONFIG_K3_THERMAL=y
CONFIG_QORIQ_THERMAL=y
CONFIG_SPEAR_THERMAL=y
CONFIG_SUN8I_THERMAL=y
CONFIG_ROCKCHIP_THERMAL=y
CONFIG_RCAR_THERMAL=y
CONFIG_RCAR_GEN3_THERMAL=y
CONFIG_KIRKWOOD_THERMAL=y
# CONFIG_DOVE_THERMAL is not set
CONFIG_ARMADA_THERMAL=y
# CONFIG_DA9062_THERMAL is not set
# CONFIG_MTK_THERMAL is not set

#
# Intel thermal drivers
#

#
# ACPI INT340X thermal drivers
#
# end of ACPI INT340X thermal drivers
# end of Intel thermal drivers

#
# Broadcom thermal drivers
#
CONFIG_BCM2711_THERMAL=y
# CONFIG_BCM2835_THERMAL is not set
CONFIG_BRCMSTB_THERMAL=y
# CONFIG_BCM_NS_THERMAL is not set
# CONFIG_BCM_SR_THERMAL is not set
# end of Broadcom thermal drivers

#
# Texas Instruments thermal drivers
#
# CONFIG_TI_SOC_THERMAL is not set
# end of Texas Instruments thermal drivers

#
# Samsung thermal drivers
#
# CONFIG_EXYNOS_THERMAL is not set
# end of Samsung thermal drivers

# CONFIG_TANGO_THERMAL is not set

#
# Qualcomm thermal drivers
#
CONFIG_QCOM_TSENS=y
# end of Qualcomm thermal drivers

# CONFIG_ZX2967_THERMAL is not set
CONFIG_UNIPHIER_THERMAL=y
CONFIG_SPRD_THERMAL=y
CONFIG_KHADAS_MCU_FAN_THERMAL=y
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
# CONFIG_WATCHDOG_SYSFS is not set

#
# Watchdog Pretimeout Governors
#
CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL=y
# CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP is not set
CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC=y
CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC=y

#
# Watchdog Device Drivers
#
# CONFIG_SOFT_WATCHDOG is not set
CONFIG_DA9052_WATCHDOG=y
# CONFIG_DA9055_WATCHDOG is not set
CONFIG_DA9063_WATCHDOG=y
CONFIG_DA9062_WATCHDOG=y
CONFIG_GPIO_WATCHDOG=y
CONFIG_GPIO_WATCHDOG_ARCH_INITCALL=y
CONFIG_MENF21BMC_WATCHDOG=y
# CONFIG_MENZ069_WATCHDOG is not set
# CONFIG_TANGOX_WATCHDOG is not set
# CONFIG_WM8350_WATCHDOG is not set
CONFIG_XILINX_WATCHDOG=y
CONFIG_ZIIRAVE_WATCHDOG=y
# CONFIG_MLX_WDT is not set
CONFIG_SL28CPLD_WATCHDOG=y
CONFIG_ARMADA_37XX_WATCHDOG=y
CONFIG_ASM9260_WATCHDOG=y
# CONFIG_AT91RM9200_WATCHDOG is not set
CONFIG_AT91SAM9X_WATCHDOG=y
CONFIG_SAMA5D4_WATCHDOG=y
# CONFIG_CADENCE_WATCHDOG is not set
CONFIG_FTWDT010_WATCHDOG=y
CONFIG_S3C2410_WATCHDOG=y
CONFIG_DW_WATCHDOG=y
# CONFIG_EP93XX_WATCHDOG is not set
CONFIG_OMAP_WATCHDOG=y
CONFIG_PNX4008_WATCHDOG=y
CONFIG_DAVINCI_WATCHDOG=y
CONFIG_K3_RTI_WATCHDOG=y
CONFIG_RN5T618_WATCHDOG=y
CONFIG_SUNXI_WATCHDOG=y
CONFIG_NPCM7XX_WATCHDOG=y
CONFIG_STMP3XXX_RTC_WATCHDOG=y
# CONFIG_TS4800_WATCHDOG is not set
CONFIG_TS72XX_WATCHDOG=y
CONFIG_MAX63XX_WATCHDOG=y
# CONFIG_MAX77620_WATCHDOG is not set
CONFIG_IMX2_WDT=y
CONFIG_IMX7ULP_WDT=y
CONFIG_RETU_WATCHDOG=y
# CONFIG_MOXART_WDT is not set
CONFIG_SIRFSOC_WATCHDOG=y
# CONFIG_ST_LPC_WATCHDOG is not set
CONFIG_TEGRA_WATCHDOG=y
# CONFIG_QCOM_WDT is not set
CONFIG_MESON_GXBB_WATCHDOG=y
CONFIG_MESON_WATCHDOG=y
# CONFIG_MEDIATEK_WATCHDOG is not set
CONFIG_DIGICOLOR_WATCHDOG=y
CONFIG_LPC18XX_WATCHDOG=y
# CONFIG_ATLAS7_WATCHDOG is not set
CONFIG_RENESAS_WDT=y
CONFIG_RENESAS_RZAWDT=y
CONFIG_ASPEED_WATCHDOG=y
# CONFIG_STPMIC1_WATCHDOG is not set
CONFIG_UNIPHIER_WATCHDOG=y
# CONFIG_RTD119X_WATCHDOG is not set
CONFIG_SPRD_WATCHDOG=y
CONFIG_PM8916_WATCHDOG=y
# CONFIG_VISCONTI_WATCHDOG is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_SC520_WDT is not set
# CONFIG_I6300ESB_WDT is not set
# CONFIG_RDC321X_WDT is not set
CONFIG_BCM47XX_WDT=y
CONFIG_BCM2835_WDT=y
# CONFIG_BCM_KONA_WDT is not set
CONFIG_BCM7038_WDT=y
CONFIG_IMGPDC_WDT=y
# CONFIG_MPC5200_WDT is not set
# CONFIG_MV64X60_WDT is not set
CONFIG_MEN_A21_WDT=y
# CONFIG_WATCHDOG_RTAS is not set
CONFIG_UML_WATCHDOG=y

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=y
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
# CONFIG_SSB_DRIVER_PCICORE is not set
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
# CONFIG_BCMA_DRIVER_MIPS is not set
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
# CONFIG_BCMA_DRIVER_GPIO is not set
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_ACT8945A=y
CONFIG_MFD_SUN4I_GPADC=y
CONFIG_MFD_AS3711=y
# CONFIG_MFD_AS3722 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
CONFIG_MFD_AT91_USART=y
CONFIG_MFD_ATMEL_FLEXCOM=y
# CONFIG_MFD_ATMEL_HLCDC is not set
CONFIG_MFD_ATMEL_SMC=y
# CONFIG_MFD_BCM590XX is not set
CONFIG_MFD_BD9571MWV=y
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
CONFIG_MFD_MADERA=y
# CONFIG_MFD_MADERA_I2C is not set
CONFIG_MFD_MADERA_SPI=y
CONFIG_MFD_CS47L15=y
# CONFIG_MFD_CS47L35 is not set
# CONFIG_MFD_CS47L85 is not set
CONFIG_MFD_CS47L90=y
CONFIG_MFD_CS47L92=y
# CONFIG_MFD_ASIC3 is not set
CONFIG_PMIC_DA903X=y
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_SPI=y
CONFIG_MFD_DA9052_I2C=y
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
CONFIG_MFD_DA9150=y
CONFIG_MFD_DLN2=y
CONFIG_MFD_ENE_KB3930=y
CONFIG_MFD_EXYNOS_LPASS=y
CONFIG_MFD_GATEWORKS_GSC=y
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
CONFIG_MFD_MP2629=y
CONFIG_MFD_MXS_LRADC=y
CONFIG_MFD_MX25_TSADC=y
CONFIG_MFD_HI6421_PMIC=y
CONFIG_MFD_HI655X_PMIC=y
CONFIG_HTC_PASIC3=y
CONFIG_HTC_I2CPLD=y
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
CONFIG_MFD_88PM800=y
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77620 is not set
CONFIG_MFD_MAX77650=y
# CONFIG_MFD_MAX77686 is not set
CONFIG_MFD_MAX77693=y
CONFIG_MFD_MAX77843=y
CONFIG_MFD_MAX8907=y
CONFIG_MFD_MAX8925=y
# CONFIG_MFD_MAX8997 is not set
CONFIG_MFD_MAX8998=y
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6397 is not set
CONFIG_MFD_MENF21BMC=y
CONFIG_EZX_PCAP=y
CONFIG_MFD_CPCAP=y
# CONFIG_MFD_VIPERBOARD is not set
CONFIG_MFD_RETU=y
# CONFIG_MFD_PCF50633 is not set
# CONFIG_UCB1400_CORE is not set
CONFIG_MFD_PM8XXX=y
CONFIG_MFD_SPMI_PMIC=y
# CONFIG_MFD_RDC321X is not set
CONFIG_MFD_RT5033=y
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_RK808 is not set
CONFIG_MFD_RN5T618=y
CONFIG_MFD_SEC_CORE=y
# CONFIG_MFD_SI476X_CORE is not set
# CONFIG_MFD_SL28CPLD is not set
CONFIG_MFD_SM501=y
# CONFIG_MFD_SM501_GPIO is not set
CONFIG_MFD_SKY81452=y
CONFIG_MFD_SC27XX_PMIC=y
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_STMPE is not set
CONFIG_MFD_SUN6I_PRCM=y
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
CONFIG_MFD_TI_LMU=y
CONFIG_MFD_OMAP_USB_HOST=y
CONFIG_MFD_PALMAS=y
CONFIG_TPS6105X=y
CONFIG_TPS65010=y
CONFIG_TPS6507X=y
# CONFIG_MFD_TPS65086 is not set
CONFIG_MFD_TPS65090=y
CONFIG_MFD_TPS65217=y
CONFIG_MFD_TI_LP873X=y
CONFIG_MFD_TI_LP87565=y
CONFIG_MFD_TPS65218=y
CONFIG_MFD_TPS6586X=y
CONFIG_MFD_TPS65910=y
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
CONFIG_MFD_TPS65912_SPI=y
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=y
# CONFIG_MFD_TIMBERDALE is not set
CONFIG_MFD_TC3589X=y
CONFIG_MFD_TQMX86=y
# CONFIG_MFD_VX855 is not set
CONFIG_MFD_LOCHNAGAR=y
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
CONFIG_MFD_WM8400=y
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
CONFIG_MFD_WM8994=y
# CONFIG_MFD_STW481X is not set
CONFIG_MFD_ROHM_BD718XX=y
# CONFIG_MFD_ROHM_BD70528 is not set
# CONFIG_MFD_ROHM_BD71828 is not set
CONFIG_MFD_STM32_LPTIMER=y
CONFIG_MFD_STM32_TIMERS=y
CONFIG_MFD_STPMIC1=y
CONFIG_MFD_STMFX=y
CONFIG_MFD_KHADAS_MCU=y
CONFIG_MFD_INTEL_M10_BMC=y
# end of Multifunction device drivers

CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=y
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
CONFIG_REGULATOR_88PG86X=y
# CONFIG_REGULATOR_88PM800 is not set
# CONFIG_REGULATOR_ACT8865 is not set
CONFIG_REGULATOR_ACT8945A=y
CONFIG_REGULATOR_AD5398=y
CONFIG_REGULATOR_ANATOP=y
# CONFIG_REGULATOR_ARIZONA_LDO1 is not set
CONFIG_REGULATOR_ARIZONA_MICSUPP=y
CONFIG_REGULATOR_AS3711=y
CONFIG_REGULATOR_AXP20X=y
# CONFIG_REGULATOR_BD718XX is not set
CONFIG_REGULATOR_BD9571MWV=y
CONFIG_REGULATOR_CPCAP=y
# CONFIG_REGULATOR_DA9052 is not set
# CONFIG_REGULATOR_DA9210 is not set
CONFIG_REGULATOR_DA9211=y
# CONFIG_REGULATOR_FAN53555 is not set
CONFIG_REGULATOR_FAN53880=y
CONFIG_REGULATOR_GPIO=y
# CONFIG_REGULATOR_HI6421 is not set
CONFIG_REGULATOR_HI6421V530=y
CONFIG_REGULATOR_HI655X=y
CONFIG_REGULATOR_ISL9305=y
CONFIG_REGULATOR_ISL6271A=y
CONFIG_REGULATOR_LM363X=y
CONFIG_REGULATOR_LOCHNAGAR=y
CONFIG_REGULATOR_LP3971=y
CONFIG_REGULATOR_LP3972=y
CONFIG_REGULATOR_LP872X=y
CONFIG_REGULATOR_LP873X=y
CONFIG_REGULATOR_LP8755=y
CONFIG_REGULATOR_LP87565=y
# CONFIG_REGULATOR_LTC3589 is not set
CONFIG_REGULATOR_LTC3676=y
# CONFIG_REGULATOR_MAX1586 is not set
# CONFIG_REGULATOR_MAX77620 is not set
# CONFIG_REGULATOR_MAX77650 is not set
CONFIG_REGULATOR_MAX8649=y
CONFIG_REGULATOR_MAX8660=y
CONFIG_REGULATOR_MAX8907=y
# CONFIG_REGULATOR_MAX8925 is not set
CONFIG_REGULATOR_MAX8952=y
CONFIG_REGULATOR_MAX8973=y
# CONFIG_REGULATOR_MAX8998 is not set
CONFIG_REGULATOR_MAX77686=y
CONFIG_REGULATOR_MAX77693=y
CONFIG_REGULATOR_MAX77802=y
CONFIG_REGULATOR_MAX77826=y
CONFIG_REGULATOR_MCP16502=y
CONFIG_REGULATOR_MP5416=y
CONFIG_REGULATOR_MP8859=y
CONFIG_REGULATOR_MP886X=y
CONFIG_REGULATOR_MPQ7920=y
CONFIG_REGULATOR_MT6311=y
CONFIG_REGULATOR_MT6380=y
CONFIG_REGULATOR_PALMAS=y
CONFIG_REGULATOR_PBIAS=y
CONFIG_REGULATOR_PCA9450=y
CONFIG_REGULATOR_PCAP=y
# CONFIG_REGULATOR_PFUZE100 is not set
CONFIG_REGULATOR_PV88060=y
CONFIG_REGULATOR_PV88080=y
# CONFIG_REGULATOR_PV88090 is not set
CONFIG_REGULATOR_PWM=y
CONFIG_REGULATOR_QCOM_RPMH=y
CONFIG_REGULATOR_QCOM_SMD_RPM=y
CONFIG_REGULATOR_QCOM_SPMI=y
CONFIG_REGULATOR_QCOM_USB_VBUS=y
CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY=y
# CONFIG_REGULATOR_RN5T618 is not set
# CONFIG_REGULATOR_RT4801 is not set
CONFIG_REGULATOR_RT5033=y
CONFIG_REGULATOR_RTMV20=y
# CONFIG_REGULATOR_S2MPA01 is not set
# CONFIG_REGULATOR_S2MPS11 is not set
CONFIG_REGULATOR_S5M8767=y
CONFIG_REGULATOR_SC2731=y
CONFIG_REGULATOR_SKY81452=y
CONFIG_REGULATOR_SLG51000=y
# CONFIG_REGULATOR_STM32_BOOSTER is not set
CONFIG_REGULATOR_STM32_VREFBUF=y
# CONFIG_REGULATOR_STM32_PWR is not set
# CONFIG_REGULATOR_STPMIC1 is not set
CONFIG_REGULATOR_STW481X_VMMC=y
CONFIG_REGULATOR_SY8106A=y
CONFIG_REGULATOR_SY8824X=y
CONFIG_REGULATOR_SY8827N=y
CONFIG_REGULATOR_TPS51632=y
# CONFIG_REGULATOR_TPS6105X is not set
# CONFIG_REGULATOR_TPS62360 is not set
CONFIG_REGULATOR_TPS65023=y
CONFIG_REGULATOR_TPS6507X=y
# CONFIG_REGULATOR_TPS65090 is not set
# CONFIG_REGULATOR_TPS65132 is not set
CONFIG_REGULATOR_TPS65217=y
# CONFIG_REGULATOR_TPS65218 is not set
# CONFIG_REGULATOR_TPS6524X is not set
CONFIG_REGULATOR_TPS6586X=y
CONFIG_REGULATOR_TPS65910=y
CONFIG_REGULATOR_TPS65912=y
CONFIG_REGULATOR_UNIPHIER=y
CONFIG_REGULATOR_VCTRL=y
CONFIG_REGULATOR_WM8350=y
# CONFIG_REGULATOR_WM8400 is not set
CONFIG_REGULATOR_WM8994=y
CONFIG_REGULATOR_QCOM_LABIBB=y
# CONFIG_RC_CORE is not set
CONFIG_CEC_CORE=y
CONFIG_CEC_NOTIFIER=y
CONFIG_CEC_PIN=y
CONFIG_CEC_PIN_ERROR_INJ=y
CONFIG_MEDIA_CEC_SUPPORT=y
CONFIG_CEC_CH7322=y
# CONFIG_CEC_MESON_AO is not set
CONFIG_CEC_MESON_G12A_AO=y
CONFIG_CEC_GPIO=y
CONFIG_CEC_SAMSUNG_S5P=y
CONFIG_CEC_STI=y
CONFIG_CEC_STM32=y
CONFIG_CEC_TEGRA=y
# CONFIG_USB_PULSE8_CEC is not set
CONFIG_USB_RAINSHADOW_CEC=y
CONFIG_MEDIA_SUPPORT=y
# CONFIG_MEDIA_SUPPORT_FILTER is not set
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_PLATFORM_SUPPORT=y
CONFIG_MEDIA_TEST_SUPPORT=y
# end of Media device types

#
# Media core support
#
CONFIG_VIDEO_DEV=y
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=y
# end of Media core support

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2=y
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
CONFIG_VIDEO_ADV_DEBUG=y
CONFIG_VIDEO_FIXED_MINOR_RANGES=y
CONFIG_V4L2_JPEG_HELPER=y
CONFIG_V4L2_MEM2MEM_DEV=y
CONFIG_V4L2_FLASH_LED_CLASS=y
CONFIG_V4L2_FWNODE=y
# end of Video4Linux options

#
# Media controller options
#
CONFIG_MEDIA_CONTROLLER_DVB=y
# end of Media controller options

#
# Digital TV options
#
CONFIG_DVB_MMAP=y
CONFIG_DVB_MAX_ADAPTERS=16
# CONFIG_DVB_DYNAMIC_MINORS is not set
CONFIG_DVB_DEMUX_SECTION_LOSS_LOG=y
CONFIG_DVB_ULE_DEBUG=y
# end of Digital TV options

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
CONFIG_RADIO_ADAPTERS=y
CONFIG_RADIO_TEA575X=y
# CONFIG_RADIO_SI470X is not set
# CONFIG_RADIO_SI4713 is not set
CONFIG_USB_MR800=y
# CONFIG_USB_DSBR is not set
# CONFIG_RADIO_MAXIRADIO is not set
CONFIG_RADIO_SHARK=y
# CONFIG_RADIO_SHARK2 is not set
# CONFIG_USB_KEENE is not set
# CONFIG_USB_RAREMONO is not set
CONFIG_USB_MA901=y
CONFIG_RADIO_TEA5764=y
# CONFIG_RADIO_TEA5764_XTAL is not set
CONFIG_RADIO_SAA7706H=y
# CONFIG_RADIO_TEF6862 is not set
CONFIG_RADIO_WL1273=y
# CONFIG_RADIO_WL128X is not set
# CONFIG_V4L_RADIO_ISA_DRIVERS is not set
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_V4L2=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_DMA_CONTIG=y
CONFIG_VIDEOBUF2_VMALLOC=y
# CONFIG_V4L_PLATFORM_DRIVERS is not set
CONFIG_V4L_MEM2MEM_DRIVERS=y
CONFIG_VIDEO_CODA=y
CONFIG_VIDEO_IMX_VDOA=y
CONFIG_VIDEO_IMX_PXP=y
CONFIG_VIDEO_MEDIATEK_JPEG=y
CONFIG_VIDEO_MEDIATEK_VPU=y
CONFIG_VIDEO_MEDIATEK_MDP=y
# CONFIG_VIDEO_MEDIATEK_VCODEC is not set
CONFIG_VIDEO_MEM2MEM_DEINTERLACE=y
CONFIG_VIDEO_SAMSUNG_S5P_G2D=y
CONFIG_VIDEO_SAMSUNG_S5P_JPEG=y
CONFIG_VIDEO_SAMSUNG_S5P_MFC=y
CONFIG_VIDEO_MX2_EMMAPRP=y
CONFIG_VIDEO_SAMSUNG_EXYNOS_GSC=y
CONFIG_VIDEO_STI_BDISP=y
CONFIG_VIDEO_STI_HVA=y
# CONFIG_VIDEO_STI_HVA_DEBUGFS is not set
# CONFIG_VIDEO_STI_DELTA is not set
# CONFIG_VIDEO_RENESAS_FDP1 is not set
CONFIG_VIDEO_RENESAS_JPU=y
CONFIG_VIDEO_RENESAS_FCP=y
CONFIG_VIDEO_RENESAS_VSP1=y
# CONFIG_VIDEO_ROCKCHIP_RGA is not set
CONFIG_VIDEO_TI_VPE=y
# CONFIG_VIDEO_TI_VPE_DEBUG is not set
# CONFIG_VIDEO_QCOM_VENUS is not set
# CONFIG_VIDEO_SUN8I_DEINTERLACE is not set
CONFIG_VIDEO_SUN8I_ROTATE=y
CONFIG_VIDEO_TI_VPDMA=y
CONFIG_VIDEO_TI_SC=y
CONFIG_VIDEO_TI_CSC=y
CONFIG_DVB_PLATFORM_DRIVERS=y
# CONFIG_DVB_C8SECTPFE is not set
# CONFIG_SDR_PLATFORM_DRIVERS is not set
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_TEST_DRIVERS is not set

#
# FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=y
CONFIG_DVB_FIREDTV_INPUT=y
# end of Media drivers

#
# Media ancillary drivers
#

#
# Audio decoders, processors and mixers
#
# CONFIG_VIDEO_TVAUDIO is not set
CONFIG_VIDEO_TDA7432=y
CONFIG_VIDEO_TDA9840=y
CONFIG_VIDEO_TDA1997X=y
# CONFIG_VIDEO_TEA6415C is not set
CONFIG_VIDEO_TEA6420=y
CONFIG_VIDEO_MSP3400=y
# CONFIG_VIDEO_CS3308 is not set
CONFIG_VIDEO_CS5345=y
CONFIG_VIDEO_CS53L32A=y
CONFIG_VIDEO_TLV320AIC23B=y
# CONFIG_VIDEO_UDA1342 is not set
CONFIG_VIDEO_WM8775=y
# CONFIG_VIDEO_WM8739 is not set
CONFIG_VIDEO_VP27SMPX=y
CONFIG_VIDEO_SONY_BTF_MPX=y
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=y
# end of RDS decoders

#
# Video decoders
#
CONFIG_VIDEO_ADV7180=y
# CONFIG_VIDEO_ADV7183 is not set
CONFIG_VIDEO_ADV748X=y
# CONFIG_VIDEO_ADV7604 is not set
CONFIG_VIDEO_ADV7842=y
# CONFIG_VIDEO_ADV7842_CEC is not set
CONFIG_VIDEO_BT819=y
# CONFIG_VIDEO_BT856 is not set
CONFIG_VIDEO_BT866=y
CONFIG_VIDEO_KS0127=y
# CONFIG_VIDEO_ML86V7667 is not set
CONFIG_VIDEO_SAA7110=y
CONFIG_VIDEO_SAA711X=y
CONFIG_VIDEO_TC358743=y
# CONFIG_VIDEO_TC358743_CEC is not set
# CONFIG_VIDEO_TVP514X is not set
CONFIG_VIDEO_TVP5150=y
CONFIG_VIDEO_TVP7002=y
# CONFIG_VIDEO_TW2804 is not set
# CONFIG_VIDEO_TW9903 is not set
# CONFIG_VIDEO_TW9906 is not set
CONFIG_VIDEO_TW9910=y
# CONFIG_VIDEO_VPX3220 is not set
CONFIG_VIDEO_MAX9286=y

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=y
CONFIG_VIDEO_CX25840=y
# end of Video decoders

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=y
CONFIG_VIDEO_SAA7185=y
CONFIG_VIDEO_ADV7170=y
CONFIG_VIDEO_ADV7175=y
# CONFIG_VIDEO_ADV7343 is not set
# CONFIG_VIDEO_ADV7393 is not set
# CONFIG_VIDEO_ADV7511 is not set
# CONFIG_VIDEO_AD9389B is not set
CONFIG_VIDEO_AK881X=y
# CONFIG_VIDEO_THS8200 is not set
# end of Video encoders

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=y
CONFIG_VIDEO_UPD64083=y
# end of Video improvement chips

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=y
# end of Audio/Video compression chips

#
# SDR tuner chips
#
# CONFIG_SDR_MAX2175 is not set
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_THS7303=y
CONFIG_VIDEO_M52790=y
# CONFIG_VIDEO_I2C is not set
CONFIG_VIDEO_ST_MIPID02=y
# end of Miscellaneous helper chips

#
# Camera sensor devices
#
CONFIG_VIDEO_APTINA_PLL=y
CONFIG_VIDEO_HI556=y
# CONFIG_VIDEO_IMX214 is not set
CONFIG_VIDEO_IMX219=y
CONFIG_VIDEO_IMX258=y
CONFIG_VIDEO_IMX274=y
CONFIG_VIDEO_IMX290=y
CONFIG_VIDEO_IMX319=y
CONFIG_VIDEO_IMX355=y
CONFIG_VIDEO_OV2640=y
CONFIG_VIDEO_OV2659=y
CONFIG_VIDEO_OV2680=y
# CONFIG_VIDEO_OV2685 is not set
CONFIG_VIDEO_OV2740=y
# CONFIG_VIDEO_OV5640 is not set
CONFIG_VIDEO_OV5645=y
CONFIG_VIDEO_OV5647=y
CONFIG_VIDEO_OV6650=y
CONFIG_VIDEO_OV5670=y
CONFIG_VIDEO_OV5675=y
# CONFIG_VIDEO_OV5695 is not set
CONFIG_VIDEO_OV7251=y
CONFIG_VIDEO_OV772X=y
CONFIG_VIDEO_OV7640=y
# CONFIG_VIDEO_OV7670 is not set
CONFIG_VIDEO_OV7740=y
CONFIG_VIDEO_OV8856=y
CONFIG_VIDEO_OV9640=y
CONFIG_VIDEO_OV9650=y
CONFIG_VIDEO_OV13858=y
# CONFIG_VIDEO_VS6624 is not set
CONFIG_VIDEO_MT9M001=y
CONFIG_VIDEO_MT9M032=y
CONFIG_VIDEO_MT9M111=y
# CONFIG_VIDEO_MT9P031 is not set
# CONFIG_VIDEO_MT9T001 is not set
# CONFIG_VIDEO_MT9T112 is not set
CONFIG_VIDEO_MT9V011=y
CONFIG_VIDEO_MT9V032=y
CONFIG_VIDEO_MT9V111=y
# CONFIG_VIDEO_SR030PC30 is not set
CONFIG_VIDEO_NOON010PC30=y
CONFIG_VIDEO_M5MOLS=y
CONFIG_VIDEO_RDACM20=y
# CONFIG_VIDEO_RJ54N1 is not set
# CONFIG_VIDEO_S5K6AA is not set
CONFIG_VIDEO_S5K6A3=y
# CONFIG_VIDEO_S5K4ECGX is not set
CONFIG_VIDEO_S5K5BAF=y
# CONFIG_VIDEO_SMIAPP is not set
CONFIG_VIDEO_ET8EK8=y
CONFIG_VIDEO_S5C73M3=y
# end of Camera sensor devices

#
# Lens drivers
#
CONFIG_VIDEO_AD5820=y
CONFIG_VIDEO_AK7375=y
# CONFIG_VIDEO_DW9714 is not set
CONFIG_VIDEO_DW9768=y
CONFIG_VIDEO_DW9807_VCM=y
# end of Lens drivers

#
# Flash devices
#
CONFIG_VIDEO_ADP1653=y
# CONFIG_VIDEO_LM3560 is not set
CONFIG_VIDEO_LM3646=y
# end of Flash devices

#
# SPI helper chips
#
# CONFIG_VIDEO_GS1662 is not set
# end of SPI helper chips

#
# Media SPI Adapters
#
CONFIG_CXD2880_SPI_DRV=y
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=y

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=y
CONFIG_MEDIA_TUNER_TDA18250=y
CONFIG_MEDIA_TUNER_TDA8290=y
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA9887=y
CONFIG_MEDIA_TUNER_TEA5761=y
CONFIG_MEDIA_TUNER_TEA5767=y
# CONFIG_MEDIA_TUNER_MSI001 is not set
CONFIG_MEDIA_TUNER_MT20XX=y
CONFIG_MEDIA_TUNER_MT2060=y
CONFIG_MEDIA_TUNER_MT2063=y
CONFIG_MEDIA_TUNER_MT2266=y
CONFIG_MEDIA_TUNER_MT2131=y
CONFIG_MEDIA_TUNER_QT1010=y
CONFIG_MEDIA_TUNER_XC2028=y
CONFIG_MEDIA_TUNER_XC5000=y
CONFIG_MEDIA_TUNER_XC4000=y
CONFIG_MEDIA_TUNER_MXL5005S=y
CONFIG_MEDIA_TUNER_MXL5007T=y
CONFIG_MEDIA_TUNER_MC44S803=y
CONFIG_MEDIA_TUNER_MAX2165=y
CONFIG_MEDIA_TUNER_TDA18218=y
# CONFIG_MEDIA_TUNER_FC0011 is not set
# CONFIG_MEDIA_TUNER_FC0012 is not set
CONFIG_MEDIA_TUNER_FC0013=y
CONFIG_MEDIA_TUNER_TDA18212=y
# CONFIG_MEDIA_TUNER_E4000 is not set
CONFIG_MEDIA_TUNER_FC2580=y
# CONFIG_MEDIA_TUNER_M88RS6000T is not set
# CONFIG_MEDIA_TUNER_TUA9001 is not set
CONFIG_MEDIA_TUNER_SI2157=y
CONFIG_MEDIA_TUNER_IT913X=y
# CONFIG_MEDIA_TUNER_R820T is not set
CONFIG_MEDIA_TUNER_MXL301RF=y
# CONFIG_MEDIA_TUNER_QM1D1C0042 is not set
CONFIG_MEDIA_TUNER_QM1D1B0004=y
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=y
CONFIG_DVB_STB6100=y
CONFIG_DVB_STV090x=y
# CONFIG_DVB_STV0910 is not set
# CONFIG_DVB_STV6110x is not set
# CONFIG_DVB_STV6111 is not set
CONFIG_DVB_MXL5XX=y
CONFIG_DVB_M88DS3103=y

#
# Multistandard (cable + terrestrial) frontends
#
# CONFIG_DVB_DRXK is not set
CONFIG_DVB_TDA18271C2DD=y
CONFIG_DVB_SI2165=y
CONFIG_DVB_MN88472=y
CONFIG_DVB_MN88473=y

#
# DVB-S (satellite) frontends
#
# CONFIG_DVB_CX24110 is not set
CONFIG_DVB_CX24123=y
# CONFIG_DVB_MT312 is not set
# CONFIG_DVB_ZL10036 is not set
CONFIG_DVB_ZL10039=y
CONFIG_DVB_S5H1420=y
CONFIG_DVB_STV0288=y
# CONFIG_DVB_STB6000 is not set
# CONFIG_DVB_STV0299 is not set
CONFIG_DVB_STV6110=y
# CONFIG_DVB_STV0900 is not set
CONFIG_DVB_TDA8083=y
CONFIG_DVB_TDA10086=y
CONFIG_DVB_TDA8261=y
CONFIG_DVB_VES1X93=y
CONFIG_DVB_TUNER_ITD1000=y
CONFIG_DVB_TUNER_CX24113=y
# CONFIG_DVB_TDA826X is not set
# CONFIG_DVB_TUA6100 is not set
CONFIG_DVB_CX24116=y
CONFIG_DVB_CX24117=y
CONFIG_DVB_CX24120=y
# CONFIG_DVB_SI21XX is not set
CONFIG_DVB_TS2020=y
CONFIG_DVB_DS3000=y
# CONFIG_DVB_MB86A16 is not set
CONFIG_DVB_TDA10071=y

#
# DVB-T (terrestrial) frontends
#
# CONFIG_DVB_SP8870 is not set
CONFIG_DVB_SP887X=y
CONFIG_DVB_CX22700=y
CONFIG_DVB_CX22702=y
CONFIG_DVB_S5H1432=y
CONFIG_DVB_DRXD=y
# CONFIG_DVB_L64781 is not set
CONFIG_DVB_TDA1004X=y
CONFIG_DVB_NXT6000=y
# CONFIG_DVB_MT352 is not set
# CONFIG_DVB_ZL10353 is not set
CONFIG_DVB_DIB3000MB=y
CONFIG_DVB_DIB3000MC=y
CONFIG_DVB_DIB7000M=y
CONFIG_DVB_DIB7000P=y
CONFIG_DVB_DIB9000=y
# CONFIG_DVB_TDA10048 is not set
# CONFIG_DVB_AF9013 is not set
CONFIG_DVB_EC100=y
# CONFIG_DVB_STV0367 is not set
CONFIG_DVB_CXD2820R=y
# CONFIG_DVB_CXD2841ER is not set
CONFIG_DVB_RTL2830=y
CONFIG_DVB_RTL2832=y
# CONFIG_DVB_RTL2832_SDR is not set
CONFIG_DVB_SI2168=y
CONFIG_DVB_ZD1301_DEMOD=y
# CONFIG_DVB_CXD2880 is not set

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=y
# CONFIG_DVB_TDA10021 is not set
CONFIG_DVB_TDA10023=y
CONFIG_DVB_STV0297=y

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=y
# CONFIG_DVB_OR51211 is not set
CONFIG_DVB_OR51132=y
CONFIG_DVB_BCM3510=y
CONFIG_DVB_LGDT330X=y
CONFIG_DVB_LGDT3305=y
# CONFIG_DVB_LGDT3306A is not set
CONFIG_DVB_LG2160=y
# CONFIG_DVB_S5H1409 is not set
CONFIG_DVB_AU8522=y
# CONFIG_DVB_AU8522_DTV is not set
CONFIG_DVB_AU8522_V4L=y
CONFIG_DVB_S5H1411=y

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=y
CONFIG_DVB_DIB8000=y
CONFIG_DVB_MB86A20S=y

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=y
# CONFIG_DVB_MN88443X is not set

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=y
CONFIG_DVB_TUNER_DIB0070=y
# CONFIG_DVB_TUNER_DIB0090 is not set

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=y
CONFIG_DVB_LNBH25=y
# CONFIG_DVB_LNBH29 is not set
CONFIG_DVB_LNBP21=y
CONFIG_DVB_LNBP22=y
# CONFIG_DVB_ISL6405 is not set
CONFIG_DVB_ISL6421=y
CONFIG_DVB_ISL6423=y
# CONFIG_DVB_A8293 is not set
CONFIG_DVB_LGS8GL5=y
CONFIG_DVB_LGS8GXX=y
CONFIG_DVB_ATBM8830=y
CONFIG_DVB_TDA665x=y
CONFIG_DVB_IX2505V=y
CONFIG_DVB_M88RS2000=y
CONFIG_DVB_AF9033=y
CONFIG_DVB_HORUS3A=y
CONFIG_DVB_ASCOT2E=y
# CONFIG_DVB_HELENE is not set

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=y
CONFIG_DVB_SP2=y
# end of Customise DVB Frontends

#
# Tools to develop new frontends
#
# CONFIG_DVB_DUMMY_FE is not set
# end of Media ancillary drivers

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_IMX_IPUV3_CORE is not set
# CONFIG_DRM is not set

#
# ARM devices
#
# end of ARM devices

#
# Frame buffer Devices
#
# CONFIG_FB is not set
# CONFIG_MMP_DISP is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
CONFIG_LCD_L4F00242T03=y
CONFIG_LCD_LMS283GF05=y
# CONFIG_LCD_LTV350QV is not set
CONFIG_LCD_ILI922X=y
CONFIG_LCD_ILI9320=y
CONFIG_LCD_TDO24M=y
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=y
CONFIG_LCD_AMS369FG06=y
CONFIG_LCD_LMS501KF03=y
CONFIG_LCD_HX8357=y
CONFIG_LCD_OTM3225A=y
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_LM3533 is not set
# CONFIG_BACKLIGHT_PWM is not set
# CONFIG_BACKLIGHT_DA903X is not set
CONFIG_BACKLIGHT_DA9052=y
CONFIG_BACKLIGHT_MAX8925=y
CONFIG_BACKLIGHT_QCOM_WLED=y
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
CONFIG_BACKLIGHT_LM3639=y
CONFIG_BACKLIGHT_LP855X=y
CONFIG_BACKLIGHT_SKY81452=y
CONFIG_BACKLIGHT_TPS65217=y
# CONFIG_BACKLIGHT_AS3711 is not set
CONFIG_BACKLIGHT_GPIO=y
CONFIG_BACKLIGHT_LV5207LP=y
CONFIG_BACKLIGHT_BD6107=y
CONFIG_BACKLIGHT_ARCXCNN=y
# CONFIG_BACKLIGHT_LED is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
# CONFIG_VGA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
# end of Console display driver support
# end of Graphics support

CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_PCM_ELD=y
CONFIG_SND_PCM_IEC958=y
CONFIG_SND_DMAENGINE_PCM=y
CONFIG_SND_SEQ_DEVICE=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_COMPRESS_OFFLOAD=y
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
# CONFIG_SND_OSSEMUL is not set
# CONFIG_SND_PCM_TIMER is not set
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_SEQ_DUMMY=y
CONFIG_SND_SEQ_MIDI_EVENT=y
CONFIG_SND_SEQ_MIDI=y
CONFIG_SND_SEQ_VIRMIDI=y
CONFIG_SND_MPU401_UART=y
CONFIG_SND_DRIVERS=y
# CONFIG_SND_DUMMY is not set
CONFIG_SND_ALOOP=y
CONFIG_SND_VIRMIDI=y
CONFIG_SND_MTPAV=y
# CONFIG_SND_SERIAL_U16550 is not set
CONFIG_SND_MPU401=y
CONFIG_SND_ISA=y
# CONFIG_SND_ADLIB is not set
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_AZT1605 is not set
# CONFIG_SND_AZT2316 is not set
# CONFIG_SND_CMI8328 is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4236 is not set
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_SC6000 is not set
# CONFIG_SND_GUSCLASSIC is not set
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_JAZZ16 is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
# CONFIG_SND_MIRO is not set
# CONFIG_SND_SB8 is not set
# CONFIG_SND_SB16 is not set
# CONFIG_SND_SBAWE is not set
# CONFIG_SND_SSCAPE is not set
# CONFIG_SND_WAVEFRONT is not set
CONFIG_SND_PCI=y
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_OXYGEN is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS5530 is not set
# CONFIG_SND_CS5535AUDIO is not set
# CONFIG_SND_CTXFI is not set
# CONFIG_SND_DARLA20 is not set
# CONFIG_SND_GINA20 is not set
# CONFIG_SND_LAYLA20 is not set
# CONFIG_SND_DARLA24 is not set
# CONFIG_SND_GINA24 is not set
# CONFIG_SND_LAYLA24 is not set
# CONFIG_SND_MONA is not set
# CONFIG_SND_MIA is not set
# CONFIG_SND_ECHO3G is not set
# CONFIG_SND_INDIGO is not set
# CONFIG_SND_INDIGOIO is not set
# CONFIG_SND_INDIGODJ is not set
# CONFIG_SND_INDIGOIOX is not set
# CONFIG_SND_INDIGODJX is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_LOLA is not set
# CONFIG_SND_LX6464ES is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RIPTIDE is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SE6X is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VIRTUOSO is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=y
CONFIG_SND_HDA_GENERIC_LEDS=y
# CONFIG_SND_HDA_INTEL is not set
# CONFIG_SND_HDA_HWDEP is not set
# CONFIG_SND_HDA_RECONFIG is not set
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=1
# CONFIG_SND_HDA_PATCH_LOADER is not set
CONFIG_SND_HDA_CODEC_REALTEK=y
# CONFIG_SND_HDA_CODEC_ANALOG is not set
CONFIG_SND_HDA_CODEC_SIGMATEL=y
# CONFIG_SND_HDA_CODEC_VIA is not set
CONFIG_SND_HDA_CODEC_HDMI=y
# CONFIG_SND_HDA_CODEC_CIRRUS is not set
CONFIG_SND_HDA_CODEC_CONEXANT=y
CONFIG_SND_HDA_CODEC_CA0110=y
CONFIG_SND_HDA_CODEC_CA0132=y
# CONFIG_SND_HDA_CODEC_CA0132_DSP is not set
CONFIG_SND_HDA_CODEC_CMEDIA=y
# CONFIG_SND_HDA_CODEC_SI3054 is not set
CONFIG_SND_HDA_GENERIC=y
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
# end of HD-Audio

CONFIG_SND_HDA_CORE=y
CONFIG_SND_HDA_EXT_CORE=y
CONFIG_SND_HDA_PREALLOC_SIZE=64
CONFIG_SND_PPC=y
# CONFIG_SND_POWERMAC is not set
# CONFIG_SND_AOA is not set
CONFIG_SND_SPI=y
# CONFIG_SND_AT73C213 is not set
# CONFIG_SND_USB is not set
# CONFIG_SND_FIREWIRE is not set
CONFIG_SND_SOC=y
CONFIG_SND_SOC_AC97_BUS=y
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_ADI=y
CONFIG_SND_SOC_ADI_AXI_I2S=y
CONFIG_SND_SOC_ADI_AXI_SPDIF=y
# CONFIG_SND_SOC_AMD_ACP is not set
CONFIG_SND_ATMEL_SOC=y
CONFIG_SND_ATMEL_SOC_PDC=y
CONFIG_SND_ATMEL_SOC_DMA=y
CONFIG_SND_ATMEL_SOC_SSC=y
CONFIG_SND_ATMEL_SOC_SSC_PDC=y
CONFIG_SND_ATMEL_SOC_SSC_DMA=y
# CONFIG_SND_AT91_SOC_SAM9G20_WM8731 is not set
CONFIG_SND_ATMEL_SOC_WM8904=y
CONFIG_SND_AT91_SOC_SAM9X5_WM8731=y
CONFIG_SND_ATMEL_SOC_CLASSD=y
CONFIG_SND_ATMEL_SOC_PDMIC=y
CONFIG_SND_ATMEL_SOC_I2S=y
# CONFIG_SND_SOC_MIKROE_PROTO is not set
# CONFIG_SND_MCHP_SOC_I2S_MCC is not set
# CONFIG_SND_MCHP_SOC_SPDIFTX is not set
CONFIG_SND_MCHP_SOC_SPDIFRX=y
CONFIG_SND_BCM2835_SOC_I2S=y
# CONFIG_SND_SOC_CYGNUS is not set
# CONFIG_SND_BCM63XX_I2S_WHISTLER is not set
CONFIG_SND_EP93XX_SOC=y
CONFIG_SND_DESIGNWARE_I2S=y
# CONFIG_SND_DESIGNWARE_PCM is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
CONFIG_SND_SOC_FSL_ASRC=y
CONFIG_SND_SOC_FSL_SAI=y
# CONFIG_SND_SOC_FSL_MQS is not set
# CONFIG_SND_SOC_FSL_AUDMIX is not set
CONFIG_SND_SOC_FSL_SSI=y
CONFIG_SND_SOC_FSL_SPDIF=y
CONFIG_SND_SOC_FSL_ESAI=y
CONFIG_SND_SOC_FSL_MICFIL=y
# CONFIG_SND_SOC_FSL_EASRC is not set
CONFIG_SND_SOC_IMX_AUDMUX=y
# CONFIG_SND_IMX_SOC is not set
# end of SoC Audio for Freescale CPUs

# CONFIG_SND_I2S_HI6210_I2S is not set
CONFIG_SND_JZ4740_SOC_I2S=y
# CONFIG_SND_KIRKWOOD_SOC is not set
# CONFIG_SND_SOC_IMG is not set
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
CONFIG_SND_SOC_INTEL_KEEMBAY=y
CONFIG_SND_SOC_INTEL_MACH=y
# CONFIG_SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES is not set
# CONFIG_SND_SOC_MTK_BTCVSD is not set

#
# ASoC support for Amlogic platforms
#
CONFIG_SND_MESON_AIU=y
CONFIG_SND_MESON_AXG_FIFO=y
CONFIG_SND_MESON_AXG_FRDDR=y
CONFIG_SND_MESON_AXG_TODDR=y
CONFIG_SND_MESON_AXG_TDM_FORMATTER=y
CONFIG_SND_MESON_AXG_TDM_INTERFACE=y
CONFIG_SND_MESON_AXG_TDMIN=y
CONFIG_SND_MESON_AXG_TDMOUT=y
# CONFIG_SND_MESON_AXG_SOUND_CARD is not set
CONFIG_SND_MESON_AXG_SPDIFOUT=y
CONFIG_SND_MESON_AXG_SPDIFIN=y
CONFIG_SND_MESON_AXG_PDM=y
CONFIG_SND_MESON_CODEC_GLUE=y
# CONFIG_SND_MESON_GX_SOUND_CARD is not set
CONFIG_SND_MESON_G12A_TOACODEC=y
CONFIG_SND_MESON_G12A_TOHDMITX=y
CONFIG_SND_SOC_MESON_T9015=y
# end of ASoC support for Amlogic platforms

# CONFIG_SND_MXS_SOC is not set
# CONFIG_SND_PXA2XX_SOC is not set
CONFIG_SND_SOC_QCOM=y
CONFIG_SND_SOC_LPASS_CPU=y
CONFIG_SND_SOC_LPASS_PLATFORM=y
CONFIG_SND_SOC_LPASS_APQ8016=y
# CONFIG_SND_SOC_STORM is not set
CONFIG_SND_SOC_APQ8016_SBC=y
CONFIG_SND_SOC_QCOM_COMMON=y
CONFIG_SND_SOC_ROCKCHIP=y
CONFIG_SND_SOC_ROCKCHIP_I2S=y
CONFIG_SND_SOC_ROCKCHIP_PDM=y
# CONFIG_SND_SOC_ROCKCHIP_SPDIF is not set
CONFIG_SND_SOC_ROCKCHIP_MAX98090=y
# CONFIG_SND_SOC_ROCKCHIP_RT5645 is not set
CONFIG_SND_SOC_RK3288_HDMI_ANALOG=y
# CONFIG_SND_SOC_RK3399_GRU_SOUND is not set
# CONFIG_SND_SOC_SAMSUNG is not set

#
# SoC Audio support for Renesas SoCs
#
CONFIG_SND_SOC_SH4_FSI=y
CONFIG_SND_SOC_RCAR=y
# end of SoC Audio support for Renesas SoCs

# CONFIG_SND_SOC_SIRF is not set
# CONFIG_SND_SOC_SOF_TOPLEVEL is not set
CONFIG_SND_SOC_SPRD=y
CONFIG_SND_SOC_SPRD_MCDT=y
CONFIG_SND_SOC_STI=y

#
# STMicroelectronics STM32 SOC audio support
#
CONFIG_SND_SOC_STM32_SAI=y
CONFIG_SND_SOC_STM32_I2S=y
CONFIG_SND_SOC_STM32_SPDIFRX=y
# end of STMicroelectronics STM32 SOC audio support

#
# Allwinner SoC Audio support
#
CONFIG_SND_SUN4I_CODEC=y
CONFIG_SND_SUN8I_CODEC=y
CONFIG_SND_SUN8I_CODEC_ANALOG=y
CONFIG_SND_SUN50I_CODEC_ANALOG=y
CONFIG_SND_SUN4I_I2S=y
CONFIG_SND_SUN4I_SPDIF=y
CONFIG_SND_SUN8I_ADDA_PR_REGMAP=y
# end of Allwinner SoC Audio support

CONFIG_SND_SOC_TEGRA=y
CONFIG_SND_SOC_TEGRA20_AC97=y
CONFIG_SND_SOC_TEGRA20_DAS=y
CONFIG_SND_SOC_TEGRA20_I2S=y
CONFIG_SND_SOC_TEGRA20_SPDIF=y
CONFIG_SND_SOC_TEGRA30_AHUB=y
CONFIG_SND_SOC_TEGRA30_I2S=y
# CONFIG_SND_SOC_TEGRA210_AHUB is not set
CONFIG_SND_SOC_TEGRA210_DMIC=y
CONFIG_SND_SOC_TEGRA210_I2S=y
CONFIG_SND_SOC_TEGRA186_DSPK=y
CONFIG_SND_SOC_TEGRA210_ADMAIF=y
CONFIG_SND_SOC_TEGRA_RT5640=y
# CONFIG_SND_SOC_TEGRA_WM8753 is not set
CONFIG_SND_SOC_TEGRA_WM8903=y
CONFIG_SND_SOC_TEGRA_WM9712=y
CONFIG_SND_SOC_TEGRA_TRIMSLICE=y
CONFIG_SND_SOC_TEGRA_ALC5632=y
CONFIG_SND_SOC_TEGRA_MAX98090=y
CONFIG_SND_SOC_TEGRA_RT5677=y
# CONFIG_SND_SOC_TEGRA_SGTL5000 is not set

#
# Audio support for Texas Instruments SoCs
#
CONFIG_SND_SOC_TI_EDMA_PCM=y
CONFIG_SND_SOC_TI_SDMA_PCM=y
CONFIG_SND_SOC_TI_UDMA_PCM=y

#
# Texas Instruments DAI support for:
#
CONFIG_SND_SOC_DAVINCI_ASP=y
CONFIG_SND_SOC_DAVINCI_MCASP=y
# CONFIG_SND_SOC_DAVINCI_VCIF is not set
CONFIG_SND_SOC_OMAP_DMIC=y
# CONFIG_SND_SOC_OMAP_MCBSP is not set
CONFIG_SND_SOC_OMAP_MCPDM=y

#
# Audio support for boards with Texas Instruments SoCs
#
CONFIG_SND_SOC_OMAP_ABE_TWL6040=y
CONFIG_SND_SOC_OMAP_HDMI=y
CONFIG_SND_SOC_J721E_EVM=y
# end of Audio support for Texas Instruments SoCs

CONFIG_SND_SOC_UNIPHIER=y
CONFIG_SND_SOC_UNIPHIER_AIO=y
CONFIG_SND_SOC_UNIPHIER_LD11=y
CONFIG_SND_SOC_UNIPHIER_PXS2=y
CONFIG_SND_SOC_UNIPHIER_EVEA_CODEC=y
CONFIG_SND_SOC_XILINX_I2S=y
CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER=y
# CONFIG_SND_SOC_XILINX_SPDIF is not set
CONFIG_SND_SOC_XTFPGA_I2S=y
# CONFIG_ZX_SPDIF is not set
# CONFIG_ZX_I2S is not set
# CONFIG_ZX_TDM is not set
CONFIG_SND_SOC_I2C_AND_SPI=y

#
# CODEC drivers
#
CONFIG_SND_SOC_ALL_CODECS=y
# CONFIG_SND_SOC_88PM860X is not set
CONFIG_SND_SOC_WM_HUBS=y
CONFIG_SND_SOC_WM_ADSP=y
# CONFIG_SND_SOC_AB8500_CODEC is not set
# CONFIG_SND_SOC_AC97_CODEC is not set
CONFIG_SND_SOC_AD1836=y
CONFIG_SND_SOC_AD193X=y
CONFIG_SND_SOC_AD193X_SPI=y
CONFIG_SND_SOC_AD193X_I2C=y
CONFIG_SND_SOC_AD1980=y
CONFIG_SND_SOC_AD73311=y
CONFIG_SND_SOC_ADAU_UTILS=y
CONFIG_SND_SOC_ADAU1373=y
CONFIG_SND_SOC_ADAU1701=y
CONFIG_SND_SOC_ADAU17X1=y
CONFIG_SND_SOC_ADAU1761=y
# CONFIG_SND_SOC_ADAU1761_I2C is not set
CONFIG_SND_SOC_ADAU1761_SPI=y
CONFIG_SND_SOC_ADAU1781=y
CONFIG_SND_SOC_ADAU1781_I2C=y
CONFIG_SND_SOC_ADAU1781_SPI=y
CONFIG_SND_SOC_ADAU1977=y
CONFIG_SND_SOC_ADAU1977_SPI=y
CONFIG_SND_SOC_ADAU1977_I2C=y
CONFIG_SND_SOC_ADAU7002=y
CONFIG_SND_SOC_ADAU7118=y
CONFIG_SND_SOC_ADAU7118_HW=y
CONFIG_SND_SOC_ADAU7118_I2C=y
CONFIG_SND_SOC_ADAV80X=y
CONFIG_SND_SOC_ADAV801=y
CONFIG_SND_SOC_ADAV803=y
CONFIG_SND_SOC_ADS117X=y
# CONFIG_SND_SOC_AK4104 is not set
CONFIG_SND_SOC_AK4118=y
# CONFIG_SND_SOC_AK4458 is not set
CONFIG_SND_SOC_AK4535=y
CONFIG_SND_SOC_AK4554=y
# CONFIG_SND_SOC_AK4613 is not set
CONFIG_SND_SOC_AK4641=y
CONFIG_SND_SOC_AK4642=y
CONFIG_SND_SOC_AK4671=y
CONFIG_SND_SOC_AK5386=y
# CONFIG_SND_SOC_AK5558 is not set
CONFIG_SND_SOC_ALC5623=y
CONFIG_SND_SOC_ALC5632=y
CONFIG_SND_SOC_BD28623=y
CONFIG_SND_SOC_BT_SCO=y
CONFIG_SND_SOC_CPCAP=y
CONFIG_SND_SOC_CQ0093VC=y
# CONFIG_SND_SOC_CROS_EC_CODEC is not set
CONFIG_SND_SOC_CS35L32=y
CONFIG_SND_SOC_CS35L33=y
CONFIG_SND_SOC_CS35L34=y
CONFIG_SND_SOC_CS35L35=y
# CONFIG_SND_SOC_CS35L36 is not set
CONFIG_SND_SOC_CS42L42=y
# CONFIG_SND_SOC_CS42L51_I2C is not set
CONFIG_SND_SOC_CS42L52=y
CONFIG_SND_SOC_CS42L56=y
CONFIG_SND_SOC_CS42L73=y
# CONFIG_SND_SOC_CS4234 is not set
# CONFIG_SND_SOC_CS4265 is not set
CONFIG_SND_SOC_CS4270=y
CONFIG_SND_SOC_CS4271=y
CONFIG_SND_SOC_CS4271_I2C=y
CONFIG_SND_SOC_CS4271_SPI=y
CONFIG_SND_SOC_CS42XX8=y
CONFIG_SND_SOC_CS42XX8_I2C=y
CONFIG_SND_SOC_CS43130=y
# CONFIG_SND_SOC_CS4341 is not set
# CONFIG_SND_SOC_CS4349 is not set
CONFIG_SND_SOC_CS47L15=y
# CONFIG_SND_SOC_CS47L24 is not set
CONFIG_SND_SOC_CS47L35=y
CONFIG_SND_SOC_CS47L85=y
CONFIG_SND_SOC_CS47L90=y
CONFIG_SND_SOC_CS47L92=y
CONFIG_SND_SOC_CS53L30=y
CONFIG_SND_SOC_CX20442=y
CONFIG_SND_SOC_CX2072X=y
CONFIG_SND_SOC_JZ4740_CODEC=y
CONFIG_SND_SOC_JZ4725B_CODEC=y
# CONFIG_SND_SOC_JZ4770_CODEC is not set
CONFIG_SND_SOC_L3=y
CONFIG_SND_SOC_DA7210=y
CONFIG_SND_SOC_DA7213=y
CONFIG_SND_SOC_DA7218=y
CONFIG_SND_SOC_DA7219=y
CONFIG_SND_SOC_DA732X=y
CONFIG_SND_SOC_DA9055=y
CONFIG_SND_SOC_DMIC=y
CONFIG_SND_SOC_HDMI_CODEC=y
CONFIG_SND_SOC_ES7134=y
CONFIG_SND_SOC_ES7241=y
CONFIG_SND_SOC_ES8316=y
CONFIG_SND_SOC_ES8328=y
CONFIG_SND_SOC_ES8328_I2C=y
CONFIG_SND_SOC_ES8328_SPI=y
CONFIG_SND_SOC_GTM601=y
CONFIG_SND_SOC_HDAC_HDMI=y
CONFIG_SND_SOC_HDAC_HDA=y
CONFIG_SND_SOC_ICS43432=y
CONFIG_SND_SOC_INNO_RK3036=y
CONFIG_SND_SOC_ISABELLE=y
CONFIG_SND_SOC_LM49453=y
CONFIG_SND_SOC_LOCHNAGAR_SC=y
CONFIG_SND_SOC_MADERA=y
CONFIG_SND_SOC_MAX98088=y
CONFIG_SND_SOC_MAX98090=y
CONFIG_SND_SOC_MAX98095=y
CONFIG_SND_SOC_MAX98357A=y
CONFIG_SND_SOC_MAX98371=y
CONFIG_SND_SOC_MAX98504=y
CONFIG_SND_SOC_MAX9867=y
CONFIG_SND_SOC_MAX98925=y
CONFIG_SND_SOC_MAX98926=y
# CONFIG_SND_SOC_MAX98927 is not set
# CONFIG_SND_SOC_MAX98373_I2C is not set
# CONFIG_SND_SOC_MAX98373_SDW is not set
CONFIG_SND_SOC_MAX98390=y
CONFIG_SND_SOC_MAX9850=y
CONFIG_SND_SOC_MAX9860=y
# CONFIG_SND_SOC_MSM8916_WCD_ANALOG is not set
# CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set
CONFIG_SND_SOC_PCM1681=y
CONFIG_SND_SOC_PCM1789=y
CONFIG_SND_SOC_PCM1789_I2C=y
# CONFIG_SND_SOC_PCM179X_I2C is not set
# CONFIG_SND_SOC_PCM179X_SPI is not set
CONFIG_SND_SOC_PCM186X=y
# CONFIG_SND_SOC_PCM186X_I2C is not set
CONFIG_SND_SOC_PCM186X_SPI=y
CONFIG_SND_SOC_PCM3008=y
CONFIG_SND_SOC_PCM3060=y
CONFIG_SND_SOC_PCM3060_I2C=y
CONFIG_SND_SOC_PCM3060_SPI=y
CONFIG_SND_SOC_PCM3168A=y
CONFIG_SND_SOC_PCM3168A_I2C=y
CONFIG_SND_SOC_PCM3168A_SPI=y
CONFIG_SND_SOC_PCM5102A=y
CONFIG_SND_SOC_PCM512x=y
CONFIG_SND_SOC_PCM512x_I2C=y
# CONFIG_SND_SOC_PCM512x_SPI is not set
# CONFIG_SND_SOC_RK3328 is not set
CONFIG_SND_SOC_RL6231=y
CONFIG_SND_SOC_RL6347A=y
CONFIG_SND_SOC_RT274=y
CONFIG_SND_SOC_RT286=y
CONFIG_SND_SOC_RT298=y
CONFIG_SND_SOC_RT1011=y
CONFIG_SND_SOC_RT1015=y
CONFIG_SND_SOC_RT1015P=y
CONFIG_SND_SOC_RT1305=y
CONFIG_SND_SOC_RT1308=y
CONFIG_SND_SOC_RT1308_SDW=y
CONFIG_SND_SOC_RT5514=y
CONFIG_SND_SOC_RT5616=y
# CONFIG_SND_SOC_RT5631 is not set
CONFIG_SND_SOC_RT5640=y
CONFIG_SND_SOC_RT5645=y
CONFIG_SND_SOC_RT5651=y
CONFIG_SND_SOC_RT5659=y
CONFIG_SND_SOC_RT5660=y
CONFIG_SND_SOC_RT5663=y
CONFIG_SND_SOC_RT5665=y
CONFIG_SND_SOC_RT5668=y
CONFIG_SND_SOC_RT5670=y
CONFIG_SND_SOC_RT5677=y
CONFIG_SND_SOC_RT5677_SPI=y
CONFIG_SND_SOC_RT5682=y
CONFIG_SND_SOC_RT5682_I2C=y
CONFIG_SND_SOC_RT5682_SDW=y
CONFIG_SND_SOC_RT700=y
CONFIG_SND_SOC_RT700_SDW=y
CONFIG_SND_SOC_RT711=y
CONFIG_SND_SOC_RT711_SDW=y
CONFIG_SND_SOC_RT715=y
CONFIG_SND_SOC_RT715_SDW=y
# CONFIG_SND_SOC_SGTL5000 is not set
CONFIG_SND_SOC_SI476X=y
CONFIG_SND_SOC_SIGMADSP=y
CONFIG_SND_SOC_SIGMADSP_I2C=y
CONFIG_SND_SOC_SIGMADSP_REGMAP=y
CONFIG_SND_SOC_SIMPLE_AMPLIFIER=y
CONFIG_SND_SOC_SIRF_AUDIO_CODEC=y
CONFIG_SND_SOC_SPDIF=y
# CONFIG_SND_SOC_SSM2305 is not set
CONFIG_SND_SOC_SSM2518=y
CONFIG_SND_SOC_SSM2602=y
# CONFIG_SND_SOC_SSM2602_SPI is not set
CONFIG_SND_SOC_SSM2602_I2C=y
CONFIG_SND_SOC_SSM4567=y
CONFIG_SND_SOC_STA32X=y
# CONFIG_SND_SOC_STA350 is not set
CONFIG_SND_SOC_STA529=y
CONFIG_SND_SOC_STAC9766=y
# CONFIG_SND_SOC_STI_SAS is not set
CONFIG_SND_SOC_TAS2552=y
CONFIG_SND_SOC_TAS2562=y
CONFIG_SND_SOC_TAS2764=y
CONFIG_SND_SOC_TAS2770=y
# CONFIG_SND_SOC_TAS5086 is not set
CONFIG_SND_SOC_TAS571X=y
CONFIG_SND_SOC_TAS5720=y
# CONFIG_SND_SOC_TAS6424 is not set
CONFIG_SND_SOC_TDA7419=y
CONFIG_SND_SOC_TFA9879=y
CONFIG_SND_SOC_TLV320AIC23=y
CONFIG_SND_SOC_TLV320AIC23_I2C=y
# CONFIG_SND_SOC_TLV320AIC23_SPI is not set
CONFIG_SND_SOC_TLV320AIC26=y
CONFIG_SND_SOC_TLV320AIC31XX=y
# CONFIG_SND_SOC_TLV320AIC32X4_I2C is not set
# CONFIG_SND_SOC_TLV320AIC32X4_SPI is not set
CONFIG_SND_SOC_TLV320AIC3X=y
CONFIG_SND_SOC_TLV320DAC33=y
CONFIG_SND_SOC_TLV320ADCX140=y
CONFIG_SND_SOC_TS3A227E=y
# CONFIG_SND_SOC_TSCS42XX is not set
CONFIG_SND_SOC_TSCS454=y
# CONFIG_SND_SOC_TWL4030 is not set
CONFIG_SND_SOC_TWL6040=y
CONFIG_SND_SOC_UDA1334=y
CONFIG_SND_SOC_UDA134X=y
CONFIG_SND_SOC_UDA1380=y
# CONFIG_SND_SOC_WCD9335 is not set
# CONFIG_SND_SOC_WCD934X is not set
CONFIG_SND_SOC_WL1273=y
CONFIG_SND_SOC_WM0010=y
CONFIG_SND_SOC_WM1250_EV1=y
CONFIG_SND_SOC_WM2000=y
CONFIG_SND_SOC_WM2200=y
CONFIG_SND_SOC_WM5100=y
# CONFIG_SND_SOC_WM5102 is not set
# CONFIG_SND_SOC_WM5110 is not set
CONFIG_SND_SOC_WM8350=y
CONFIG_SND_SOC_WM8400=y
CONFIG_SND_SOC_WM8510=y
CONFIG_SND_SOC_WM8523=y
CONFIG_SND_SOC_WM8524=y
# CONFIG_SND_SOC_WM8580 is not set
CONFIG_SND_SOC_WM8711=y
CONFIG_SND_SOC_WM8727=y
CONFIG_SND_SOC_WM8728=y
CONFIG_SND_SOC_WM8731=y
CONFIG_SND_SOC_WM8737=y
CONFIG_SND_SOC_WM8741=y
# CONFIG_SND_SOC_WM8750 is not set
CONFIG_SND_SOC_WM8753=y
# CONFIG_SND_SOC_WM8770 is not set
# CONFIG_SND_SOC_WM8776 is not set
CONFIG_SND_SOC_WM8782=y
CONFIG_SND_SOC_WM8804=y
CONFIG_SND_SOC_WM8804_I2C=y
# CONFIG_SND_SOC_WM8804_SPI is not set
CONFIG_SND_SOC_WM8900=y
CONFIG_SND_SOC_WM8903=y
CONFIG_SND_SOC_WM8904=y
CONFIG_SND_SOC_WM8940=y
CONFIG_SND_SOC_WM8955=y
CONFIG_SND_SOC_WM8960=y
CONFIG_SND_SOC_WM8961=y
CONFIG_SND_SOC_WM8962=y
CONFIG_SND_SOC_WM8971=y
CONFIG_SND_SOC_WM8974=y
# CONFIG_SND_SOC_WM8978 is not set
CONFIG_SND_SOC_WM8983=y
CONFIG_SND_SOC_WM8985=y
CONFIG_SND_SOC_WM8988=y
CONFIG_SND_SOC_WM8990=y
CONFIG_SND_SOC_WM8991=y
CONFIG_SND_SOC_WM8993=y
CONFIG_SND_SOC_WM8994=y
CONFIG_SND_SOC_WM8995=y
CONFIG_SND_SOC_WM8996=y
# CONFIG_SND_SOC_WM8997 is not set
# CONFIG_SND_SOC_WM8998 is not set
CONFIG_SND_SOC_WM9081=y
CONFIG_SND_SOC_WM9090=y
CONFIG_SND_SOC_WM9705=y
CONFIG_SND_SOC_WM9712=y
CONFIG_SND_SOC_WM9713=y
# CONFIG_SND_SOC_WSA881X is not set
# CONFIG_SND_SOC_ZL38060 is not set
# CONFIG_SND_SOC_ZX_AUD96P22 is not set
CONFIG_SND_SOC_LM4857=y
# CONFIG_SND_SOC_MAX9759 is not set
CONFIG_SND_SOC_MAX9768=y
CONFIG_SND_SOC_MAX9877=y
# CONFIG_SND_SOC_MC13783 is not set
CONFIG_SND_SOC_ML26124=y
CONFIG_SND_SOC_MT6351=y
CONFIG_SND_SOC_MT6358=y
CONFIG_SND_SOC_MT6359=y
CONFIG_SND_SOC_MT6660=y
CONFIG_SND_SOC_NAU8540=y
# CONFIG_SND_SOC_NAU8810 is not set
CONFIG_SND_SOC_NAU8822=y
CONFIG_SND_SOC_NAU8824=y
CONFIG_SND_SOC_NAU8825=y
# CONFIG_SND_SOC_TPA6130A2 is not set
# end of CODEC drivers

CONFIG_SND_SIMPLE_CARD_UTILS=y
CONFIG_SND_SIMPLE_CARD=y
CONFIG_SND_AUDIO_GRAPH_CARD=y
CONFIG_AC97_BUS=y

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
# CONFIG_HIDRAW is not set
# CONFIG_UHID is not set
# CONFIG_HID_GENERIC is not set

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
CONFIG_HID_ACCUTOUCH=y
# CONFIG_HID_ACRUX is not set
CONFIG_HID_APPLE=y
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=y
# CONFIG_HID_AUREAL is not set
# CONFIG_HID_BELKIN is not set
CONFIG_HID_BETOP_FF=y
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=y
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
CONFIG_HID_MACALLY=y
# CONFIG_HID_PRODIKEYS is not set
CONFIG_HID_CMEDIA=y
CONFIG_HID_CREATIVE_SB0540=y
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=y
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
# CONFIG_HID_ELECOM is not set
CONFIG_HID_ELO=y
# CONFIG_HID_EZKEY is not set
# CONFIG_HID_GEMBIRD is not set
CONFIG_HID_GFRM=y
CONFIG_HID_GLORIOUS=y
# CONFIG_HID_HOLTEK is not set
CONFIG_HID_VIVALDI=y
CONFIG_HID_GT683R=y
CONFIG_HID_KEYTOUCH=y
CONFIG_HID_KYE=y
CONFIG_HID_UCLOGIC=y
CONFIG_HID_WALTOP=y
CONFIG_HID_VIEWSONIC=y
# CONFIG_HID_GYRATION is not set
CONFIG_HID_ICADE=y
CONFIG_HID_ITE=y
# CONFIG_HID_JABRA is not set
# CONFIG_HID_TWINHAN is not set
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=y
# CONFIG_HID_LED is not set
CONFIG_HID_LENOVO=y
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_HIDPP=y
CONFIG_LOGITECH_FF=y
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
CONFIG_HID_MALTRON=y
# CONFIG_HID_MAYFLASH is not set
CONFIG_HID_REDRAGON=y
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
CONFIG_HID_MULTITOUCH=y
CONFIG_HID_NTI=y
CONFIG_HID_NTRIG=y
CONFIG_HID_ORTEK=y
CONFIG_HID_PANTHERLORD=y
# CONFIG_PANTHERLORD_FF is not set
CONFIG_HID_PENMOUNT=y
CONFIG_HID_PETALYNX=y
CONFIG_HID_PICOLCD=y
# CONFIG_HID_PICOLCD_BACKLIGHT is not set
# CONFIG_HID_PICOLCD_LCD is not set
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PLANTRONICS=y
# CONFIG_HID_PRIMAX is not set
# CONFIG_HID_RETRODE is not set
CONFIG_HID_ROCCAT=y
# CONFIG_HID_SAITEK is not set
CONFIG_HID_SAMSUNG=y
# CONFIG_HID_SONY is not set
CONFIG_HID_SPEEDLINK=y
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=y
CONFIG_HID_SUNPLUS=y
CONFIG_HID_RMI=y
CONFIG_HID_GREENASIA=y
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_SMARTJOYPLUS=y
CONFIG_SMARTJOYPLUS_FF=y
CONFIG_HID_TIVO=y
CONFIG_HID_TOPSEED=y
# CONFIG_HID_THINGM is not set
CONFIG_HID_THRUSTMASTER=y
# CONFIG_THRUSTMASTER_FF is not set
CONFIG_HID_UDRAW_PS3=y
CONFIG_HID_U2FZERO=y
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=y
# CONFIG_HID_XINMO is not set
CONFIG_HID_ZEROPLUS=y
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=y
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=y
CONFIG_HID_ALPS=y
CONFIG_HID_MCP2221=y
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
CONFIG_USB_HIDDEV=y
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID is not set
# end of I2C HID support

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
# end of Intel ISH HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_LED_TRIG=y
CONFIG_USB_ULPI_BUS=y
CONFIG_USB_CONN_GPIO=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=y
# CONFIG_USB_XHCI_HCD is not set
CONFIG_USB_BRCMSTB=y
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_OXU210HP_HCD is not set
CONFIG_USB_ISP116X_HCD=y
# CONFIG_USB_ISP1362_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
CONFIG_USB_MAX3421_HCD=y
CONFIG_USB_OHCI_HCD=y
# CONFIG_USB_OHCI_HCD_SPEAR is not set
# CONFIG_USB_OHCI_HCD_STI is not set
CONFIG_USB_OHCI_HCD_S3C2410=y
# CONFIG_USB_OHCI_HCD_LPC32XX is not set
CONFIG_USB_OHCI_HCD_AT91=y
CONFIG_USB_OHCI_HCD_OMAP3=y
CONFIG_USB_OHCI_HCD_DAVINCI=y
# CONFIG_USB_OHCI_HCD_PPC_OF_BE is not set
# CONFIG_USB_OHCI_HCD_PPC_OF_LE is not set
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_SSB is not set
CONFIG_USB_OHCI_SH=y
# CONFIG_USB_OHCI_EXYNOS is not set
CONFIG_USB_CNS3XXX_OHCI=y
CONFIG_USB_OHCI_HCD_PLATFORM=y
# CONFIG_USB_UHCI_HCD is not set
CONFIG_USB_SL811_HCD=y
CONFIG_USB_SL811_HCD_ISO=y
# CONFIG_USB_R8A66597_HCD is not set
CONFIG_USB_RENESAS_USBHS_HCD=y
CONFIG_USB_HCD_BCMA=y
CONFIG_USB_HCD_SSB=y
# CONFIG_USB_HCD_TEST_MODE is not set
CONFIG_USB_RENESAS_USBHS=y

#
# USB Device Class drivers
#
CONFIG_USB_ACM=y
CONFIG_USB_PRINTER=y
CONFIG_USB_WDM=y
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#

#
# USB Imaging devices
#
CONFIG_USB_MDC800=y
CONFIG_USBIP_CORE=y
CONFIG_USBIP_VHCI_HCD=y
CONFIG_USBIP_VHCI_HC_PORTS=8
CONFIG_USBIP_VHCI_NR_HCS=1
# CONFIG_USBIP_HOST is not set
# CONFIG_USBIP_VUDC is not set
CONFIG_USBIP_DEBUG=y
CONFIG_USB_CDNS3=y
# CONFIG_USB_CDNS3_GADGET is not set
# CONFIG_USB_CDNS3_HOST is not set
CONFIG_USB_CDNS3_TI=y
# CONFIG_USB_CDNS3_IMX is not set
CONFIG_USB_MTU3=y
# CONFIG_USB_MTU3_HOST is not set
# CONFIG_USB_MTU3_GADGET is not set
CONFIG_USB_MTU3_DUAL_ROLE=y
CONFIG_USB_MTU3_DEBUG=y
# CONFIG_USB_MUSB_HDRC is not set
CONFIG_USB_DWC3=y
CONFIG_USB_DWC3_ULPI=y
# CONFIG_USB_DWC3_HOST is not set
# CONFIG_USB_DWC3_GADGET is not set
CONFIG_USB_DWC3_DUAL_ROLE=y

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_OMAP=y
CONFIG_USB_DWC3_EXYNOS=y
CONFIG_USB_DWC3_HAPS=y
CONFIG_USB_DWC3_KEYSTONE=y
CONFIG_USB_DWC3_MESON_G12A=y
CONFIG_USB_DWC3_OF_SIMPLE=y
CONFIG_USB_DWC3_ST=y
CONFIG_USB_DWC3_QCOM=y
# CONFIG_USB_DWC2 is not set
CONFIG_USB_CHIPIDEA=y
CONFIG_USB_CHIPIDEA_UDC=y
CONFIG_USB_CHIPIDEA_MSM=y
CONFIG_USB_CHIPIDEA_IMX=y
# CONFIG_USB_CHIPIDEA_GENERIC is not set
# CONFIG_USB_CHIPIDEA_TEGRA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
CONFIG_USB_SERIAL=y
CONFIG_USB_SERIAL_CONSOLE=y
# CONFIG_USB_SERIAL_GENERIC is not set
# CONFIG_USB_SERIAL_SIMPLE is not set
CONFIG_USB_SERIAL_AIRCABLE=y
CONFIG_USB_SERIAL_ARK3116=y
CONFIG_USB_SERIAL_BELKIN=y
CONFIG_USB_SERIAL_CH341=y
CONFIG_USB_SERIAL_WHITEHEAT=y
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=y
CONFIG_USB_SERIAL_CP210X=y
CONFIG_USB_SERIAL_CYPRESS_M8=y
# CONFIG_USB_SERIAL_EMPEG is not set
CONFIG_USB_SERIAL_FTDI_SIO=y
CONFIG_USB_SERIAL_VISOR=y
CONFIG_USB_SERIAL_IPAQ=y
CONFIG_USB_SERIAL_IR=y
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
CONFIG_USB_SERIAL_F81232=y
# CONFIG_USB_SERIAL_F8153X is not set
CONFIG_USB_SERIAL_GARMIN=y
# CONFIG_USB_SERIAL_IPW is not set
CONFIG_USB_SERIAL_IUU=y
CONFIG_USB_SERIAL_KEYSPAN_PDA=y
CONFIG_USB_SERIAL_KEYSPAN=y
# CONFIG_USB_SERIAL_KLSI is not set
CONFIG_USB_SERIAL_KOBIL_SCT=y
CONFIG_USB_SERIAL_MCT_U232=y
# CONFIG_USB_SERIAL_METRO is not set
CONFIG_USB_SERIAL_MOS7720=y
CONFIG_USB_SERIAL_MOS7840=y
CONFIG_USB_SERIAL_MXUPORT=y
CONFIG_USB_SERIAL_NAVMAN=y
CONFIG_USB_SERIAL_PL2303=y
# CONFIG_USB_SERIAL_OTI6858 is not set
CONFIG_USB_SERIAL_QCAUX=y
CONFIG_USB_SERIAL_QUALCOMM=y
CONFIG_USB_SERIAL_SPCP8X5=y
CONFIG_USB_SERIAL_SAFE=y
# CONFIG_USB_SERIAL_SAFE_PADDED is not set
CONFIG_USB_SERIAL_SIERRAWIRELESS=y
CONFIG_USB_SERIAL_SYMBOL=y
CONFIG_USB_SERIAL_TI=y
CONFIG_USB_SERIAL_CYBERJACK=y
# CONFIG_USB_SERIAL_XIRCOM is not set
CONFIG_USB_SERIAL_WWAN=y
# CONFIG_USB_SERIAL_OPTION is not set
CONFIG_USB_SERIAL_OMNINET=y
# CONFIG_USB_SERIAL_OPTICON is not set
CONFIG_USB_SERIAL_XSENS_MT=y
CONFIG_USB_SERIAL_WISHBONE=y
CONFIG_USB_SERIAL_SSU100=y
CONFIG_USB_SERIAL_QT2=y
CONFIG_USB_SERIAL_UPD78F0730=y
CONFIG_USB_SERIAL_DEBUG=y

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=y
# CONFIG_USB_EMI26 is not set
CONFIG_USB_ADUTUX=y
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
CONFIG_USB_LCD=y
# CONFIG_USB_CYPRESS_CY7C63 is not set
CONFIG_USB_CYTHERM=y
CONFIG_USB_IDMOUSE=y
# CONFIG_USB_FTDI_ELAN is not set
CONFIG_USB_APPLEDISPLAY=y
# CONFIG_APPLE_MFI_FASTCHARGE is not set
CONFIG_USB_LD=y
CONFIG_USB_TRANCEVIBRATOR=y
CONFIG_USB_IOWARRIOR=y
CONFIG_USB_TEST=y
CONFIG_USB_EHSET_TEST_FIXTURE=y
CONFIG_USB_ISIGHTFW=y
CONFIG_USB_YUREX=y
CONFIG_USB_EZUSB_FX2=y
CONFIG_USB_HUB_USB251XB=y
CONFIG_USB_HSIC_USB3503=y
# CONFIG_USB_HSIC_USB4604 is not set
CONFIG_USB_LINK_LAYER_TEST=y
# CONFIG_USB_CHAOSKEY is not set
CONFIG_USB_ATM=y
CONFIG_USB_SPEEDTOUCH=y
# CONFIG_USB_CXACRU is not set
CONFIG_USB_UEAGLEATM=y
CONFIG_USB_XUSBATM=y

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
# CONFIG_NOP_USB_XCEIV is not set
CONFIG_USB_GPIO_VBUS=y
# CONFIG_TAHVO_USB is not set
CONFIG_USB_ISP1301=y
CONFIG_USB_TEGRA_PHY=y
CONFIG_USB_ULPI=y
CONFIG_USB_ULPI_VIEWPORT=y
# CONFIG_JZ4770_PHY is not set
# end of USB Physical Layer drivers

CONFIG_USB_GADGET=y
CONFIG_USB_GADGET_DEBUG=y
# CONFIG_USB_GADGET_VERBOSE is not set
CONFIG_USB_GADGET_DEBUG_FILES=y
CONFIG_USB_GADGET_DEBUG_FS=y
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2
CONFIG_U_SERIAL_CONSOLE=y

#
# USB Peripheral Controller
#
CONFIG_USB_LPC32XX=y
# CONFIG_USB_FUSB300 is not set
CONFIG_USB_FOTG210_UDC=y
CONFIG_USB_GR_UDC=y
CONFIG_USB_R8A66597=y
# CONFIG_USB_RENESAS_USBHS_UDC is not set
CONFIG_USB_RENESAS_USB3=y
# CONFIG_USB_PXA27X is not set
# CONFIG_USB_MV_UDC is not set
CONFIG_USB_MV_U3D=y
CONFIG_USB_SNP_CORE=y
CONFIG_USB_SNP_UDC_PLAT=y
CONFIG_USB_M66592=y
# CONFIG_USB_BDC_UDC is not set
# CONFIG_USB_AMD5536UDC is not set
# CONFIG_USB_NET2272 is not set
# CONFIG_USB_NET2280 is not set
# CONFIG_USB_GOKU is not set
# CONFIG_USB_EG20T is not set
CONFIG_USB_GADGET_XILINX=y
CONFIG_USB_MAX3420_UDC=y
# CONFIG_USB_ASPEED_VHUB is not set
# CONFIG_USB_DUMMY_HCD is not set
# end of USB Peripheral Controller

CONFIG_USB_LIBCOMPOSITE=y
CONFIG_USB_F_ACM=y
CONFIG_USB_F_SS_LB=y
CONFIG_USB_U_SERIAL=y
CONFIG_USB_U_ETHER=y
CONFIG_USB_U_AUDIO=y
CONFIG_USB_F_SERIAL=y
CONFIG_USB_F_OBEX=y
CONFIG_USB_F_NCM=y
CONFIG_USB_F_ECM=y
CONFIG_USB_F_PHONET=y
CONFIG_USB_F_EEM=y
CONFIG_USB_F_SUBSET=y
CONFIG_USB_F_RNDIS=y
CONFIG_USB_F_FS=y
CONFIG_USB_F_UAC1=y
CONFIG_USB_F_UAC1_LEGACY=y
CONFIG_USB_F_UAC2=y
CONFIG_USB_F_UVC=y
CONFIG_USB_F_MIDI=y
CONFIG_USB_F_PRINTER=y
CONFIG_USB_CONFIGFS=y
CONFIG_USB_CONFIGFS_SERIAL=y
CONFIG_USB_CONFIGFS_ACM=y
# CONFIG_USB_CONFIGFS_OBEX is not set
CONFIG_USB_CONFIGFS_NCM=y
CONFIG_USB_CONFIGFS_ECM=y
# CONFIG_USB_CONFIGFS_ECM_SUBSET is not set
# CONFIG_USB_CONFIGFS_RNDIS is not set
# CONFIG_USB_CONFIGFS_EEM is not set
CONFIG_USB_CONFIGFS_PHONET=y
CONFIG_USB_CONFIGFS_F_LB_SS=y
CONFIG_USB_CONFIGFS_F_FS=y
CONFIG_USB_CONFIGFS_F_UAC1=y
CONFIG_USB_CONFIGFS_F_UAC1_LEGACY=y
CONFIG_USB_CONFIGFS_F_UAC2=y
# CONFIG_USB_CONFIGFS_F_MIDI is not set
# CONFIG_USB_CONFIGFS_F_HID is not set
CONFIG_USB_CONFIGFS_F_UVC=y
# CONFIG_USB_CONFIGFS_F_PRINTER is not set

#
# USB Gadget precomposed configurations
#
CONFIG_USB_ZERO=y
# CONFIG_USB_AUDIO is not set
CONFIG_USB_ETH=y
CONFIG_USB_ETH_RNDIS=y
CONFIG_USB_ETH_EEM=y
# CONFIG_USB_G_NCM is not set
CONFIG_USB_GADGETFS=y
# CONFIG_USB_FUNCTIONFS is not set
CONFIG_USB_G_SERIAL=y
CONFIG_USB_MIDI_GADGET=y
CONFIG_USB_G_PRINTER=y
CONFIG_USB_CDC_COMPOSITE=y
# CONFIG_USB_G_HID is not set
# CONFIG_USB_G_DBGP is not set
CONFIG_USB_G_WEBCAM=y
# CONFIG_USB_RAW_GADGET is not set
# end of USB Gadget precomposed configurations

# CONFIG_TYPEC is not set
CONFIG_USB_ROLE_SWITCH=y
# CONFIG_MMC is not set
CONFIG_MEMSTICK=y
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
# CONFIG_MEMSTICK_JMICRON_38X is not set
# CONFIG_MEMSTICK_R592 is not set
CONFIG_MEMSTICK_REALTEK_USB=y
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
CONFIG_LEDS_AAT1290=y
# CONFIG_LEDS_AN30259A is not set
CONFIG_LEDS_ARIEL=y
CONFIG_LEDS_AS3645A=y
CONFIG_LEDS_AW2013=y
CONFIG_LEDS_BCM6328=y
CONFIG_LEDS_BCM6358=y
CONFIG_LEDS_CPCAP=y
# CONFIG_LEDS_CR0014114 is not set
# CONFIG_LEDS_EL15203000 is not set
# CONFIG_LEDS_LM3530 is not set
CONFIG_LEDS_LM3532=y
CONFIG_LEDS_LM3533=y
CONFIG_LEDS_LM3642=y
CONFIG_LEDS_LM3692X=y
CONFIG_LEDS_LM3601X=y
CONFIG_LEDS_S3C24XX=y
CONFIG_LEDS_COBALT_QUBE=y
CONFIG_LEDS_COBALT_RAQ=y
CONFIG_LEDS_PCA9532=y
CONFIG_LEDS_PCA9532_GPIO=y
CONFIG_LEDS_GPIO=y
# CONFIG_LEDS_LP3944 is not set
CONFIG_LEDS_LP3952=y
# CONFIG_LEDS_LP50XX is not set
CONFIG_LEDS_LP55XX_COMMON=y
CONFIG_LEDS_LP5521=y
CONFIG_LEDS_LP5523=y
CONFIG_LEDS_LP5562=y
CONFIG_LEDS_LP8501=y
CONFIG_LEDS_LP8860=y
CONFIG_LEDS_PCA955X=y
CONFIG_LEDS_PCA955X_GPIO=y
CONFIG_LEDS_PCA963X=y
CONFIG_LEDS_WM8350=y
CONFIG_LEDS_DA903X=y
CONFIG_LEDS_DA9052=y
# CONFIG_LEDS_DAC124S085 is not set
CONFIG_LEDS_PWM=y
CONFIG_LEDS_REGULATOR=y
CONFIG_LEDS_BD2802=y
CONFIG_LEDS_LT3593=y
CONFIG_LEDS_NS2=y
CONFIG_LEDS_NETXBIG=y
CONFIG_LEDS_TCA6507=y
CONFIG_LEDS_TLC591XX=y
# CONFIG_LEDS_MAX77650 is not set
# CONFIG_LEDS_MAX77693 is not set
CONFIG_LEDS_LM355x=y
CONFIG_LEDS_OT200=y
CONFIG_LEDS_MENF21BMC=y
# CONFIG_LEDS_KTD2692 is not set
# CONFIG_LEDS_IS31FL319X is not set
CONFIG_LEDS_IS31FL32XX=y
# CONFIG_LEDS_SC27XX_BLTC is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
# CONFIG_LEDS_SYSCON is not set
# CONFIG_LEDS_PM8058 is not set
CONFIG_LEDS_MLXREG=y
CONFIG_LEDS_USER=y
CONFIG_LEDS_SPI_BYTE=y
CONFIG_LEDS_TI_LMU_COMMON=y
CONFIG_LEDS_LM3697=y
CONFIG_LEDS_LM36274=y
CONFIG_LEDS_TPS6105X=y
CONFIG_LEDS_IP30=y
# CONFIG_LEDS_SGM3140 is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
CONFIG_LEDS_TRIGGER_ONESHOT=y
# CONFIG_LEDS_TRIGGER_MTD is not set
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
CONFIG_LEDS_TRIGGER_CPU=y
CONFIG_LEDS_TRIGGER_ACTIVITY=y
CONFIG_LEDS_TRIGGER_GPIO=y
# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
CONFIG_LEDS_TRIGGER_CAMERA=y
# CONFIG_LEDS_TRIGGER_PANIC is not set
CONFIG_LEDS_TRIGGER_NETDEV=y
CONFIG_LEDS_TRIGGER_PATTERN=y
CONFIG_LEDS_TRIGGER_AUDIO=y
CONFIG_ACCESSIBILITY=y
# CONFIG_A11Y_BRAILLE_CONSOLE is not set

#
# Speakup console speech
#
# CONFIG_SPEAKUP is not set
# end of Speakup console speech

CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_AL_MC=y
CONFIG_EDAC_XGENE=y
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
CONFIG_RTC_DEBUG=y
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
# CONFIG_RTC_INTF_PROC is not set
# CONFIG_RTC_INTF_DEV is not set
CONFIG_RTC_DRV_TEST=y

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_88PM80X=y
# CONFIG_RTC_DRV_ABB5ZES3 is not set
CONFIG_RTC_DRV_ABEOZ9=y
CONFIG_RTC_DRV_ABX80X=y
CONFIG_RTC_DRV_BRCMSTB=y
# CONFIG_RTC_DRV_DS1307 is not set
# CONFIG_RTC_DRV_DS1374 is not set
CONFIG_RTC_DRV_DS1672=y
# CONFIG_RTC_DRV_HYM8563 is not set
# CONFIG_RTC_DRV_MAX6900 is not set
CONFIG_RTC_DRV_MAX8907=y
# CONFIG_RTC_DRV_MAX8925 is not set
CONFIG_RTC_DRV_MAX8998=y
CONFIG_RTC_DRV_MAX77686=y
CONFIG_RTC_DRV_RS5C372=y
CONFIG_RTC_DRV_ISL1208=y
CONFIG_RTC_DRV_ISL12022=y
CONFIG_RTC_DRV_ISL12026=y
# CONFIG_RTC_DRV_X1205 is not set
CONFIG_RTC_DRV_PCF8523=y
CONFIG_RTC_DRV_PCF85063=y
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=y
CONFIG_RTC_DRV_PCF8583=y
CONFIG_RTC_DRV_M41T80=y
# CONFIG_RTC_DRV_M41T80_WDT is not set
CONFIG_RTC_DRV_BQ32K=y
# CONFIG_RTC_DRV_PALMAS is not set
# CONFIG_RTC_DRV_TPS6586X is not set
# CONFIG_RTC_DRV_TPS65910 is not set
# CONFIG_RTC_DRV_RC5T619 is not set
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=y
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=y
# CONFIG_RTC_DRV_RX8025 is not set
# CONFIG_RTC_DRV_EM3027 is not set
# CONFIG_RTC_DRV_RV3028 is not set
CONFIG_RTC_DRV_RV3032=y
# CONFIG_RTC_DRV_RV8803 is not set
CONFIG_RTC_DRV_S5M=y
CONFIG_RTC_DRV_SD3078=y

#
# SPI RTC drivers
#
CONFIG_RTC_DRV_M41T93=y
CONFIG_RTC_DRV_M41T94=y
CONFIG_RTC_DRV_DS1302=y
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
CONFIG_RTC_DRV_DS1390=y
CONFIG_RTC_DRV_MAX6916=y
# CONFIG_RTC_DRV_R9701 is not set
# CONFIG_RTC_DRV_RX4581 is not set
CONFIG_RTC_DRV_RX6110=y
# CONFIG_RTC_DRV_RS5C348 is not set
CONFIG_RTC_DRV_MAX6902=y
CONFIG_RTC_DRV_PCF2123=y
CONFIG_RTC_DRV_MCP795=y
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=y

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
# CONFIG_RTC_DRV_DS1286 is not set
CONFIG_RTC_DRV_DS1511=y
# CONFIG_RTC_DRV_DS1553 is not set
CONFIG_RTC_DRV_DS1685_FAMILY=y
CONFIG_RTC_DRV_DS1685=y
# CONFIG_RTC_DRV_DS1689 is not set
# CONFIG_RTC_DRV_DS17285 is not set
# CONFIG_RTC_DRV_DS17485 is not set
# CONFIG_RTC_DRV_DS17885 is not set
CONFIG_RTC_DRV_DS1742=y
CONFIG_RTC_DRV_DS2404=y
CONFIG_RTC_DRV_DA9052=y
CONFIG_RTC_DRV_STK17TA8=y
# CONFIG_RTC_DRV_M48T86 is not set
# CONFIG_RTC_DRV_M48T35 is not set
# CONFIG_RTC_DRV_M48T59 is not set
CONFIG_RTC_DRV_MSM6242=y
# CONFIG_RTC_DRV_BQ4802 is not set
CONFIG_RTC_DRV_RP5C01=y
# CONFIG_RTC_DRV_V3020 is not set
CONFIG_RTC_DRV_WM8350=y
CONFIG_RTC_DRV_SC27XX=y
CONFIG_RTC_DRV_SPEAR=y
CONFIG_RTC_DRV_ZYNQMP=y

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_ASM9260=y
# CONFIG_RTC_DRV_DAVINCI is not set
CONFIG_RTC_DRV_DIGICOLOR=y
CONFIG_RTC_DRV_FSL_FTM_ALARM=y
CONFIG_RTC_DRV_MESON=y
CONFIG_RTC_DRV_MESON_VRTC=y
CONFIG_RTC_DRV_OMAP=y
CONFIG_RTC_DRV_S3C=y
# CONFIG_RTC_DRV_EP93XX is not set
CONFIG_RTC_DRV_VR41XX=y
CONFIG_RTC_DRV_AT91RM9200=y
# CONFIG_RTC_DRV_AT91SAM9 is not set
CONFIG_RTC_DRV_GENERIC=y
# CONFIG_RTC_DRV_VT8500 is not set
# CONFIG_RTC_DRV_SUN6I is not set
CONFIG_RTC_DRV_SUNXI=y
# CONFIG_RTC_DRV_TX4939 is not set
CONFIG_RTC_DRV_MV=y
CONFIG_RTC_DRV_ARMADA38X=y
CONFIG_RTC_DRV_CADENCE=y
# CONFIG_RTC_DRV_FTRTC010 is not set
# CONFIG_RTC_DRV_COH901331 is not set
CONFIG_RTC_DRV_STMP=y
CONFIG_RTC_DRV_PCAP=y
CONFIG_RTC_DRV_JZ4740=y
CONFIG_RTC_DRV_LPC24XX=y
# CONFIG_RTC_DRV_LPC32XX is not set
CONFIG_RTC_DRV_PM8XXX=y
# CONFIG_RTC_DRV_TEGRA is not set
# CONFIG_RTC_DRV_SNVS is not set
# CONFIG_RTC_DRV_MOXART is not set
CONFIG_RTC_DRV_MT2712=y
CONFIG_RTC_DRV_MT6397=y
# CONFIG_RTC_DRV_MT7622 is not set
CONFIG_RTC_DRV_XGENE=y
# CONFIG_RTC_DRV_R7301 is not set
CONFIG_RTC_DRV_STM32=y
# CONFIG_RTC_DRV_CPCAP is not set
CONFIG_RTC_DRV_RTD119X=y
CONFIG_RTC_DRV_ASPEED=y

#
# HID Sensor RTC drivers
#
CONFIG_RTC_DRV_GOLDFISH=y
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_ASYNC_TX_ENABLE_CHANNEL_SWITCH=y
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_OF=y
CONFIG_ALTERA_MSGDMA=y
CONFIG_AXI_DMAC=y
# CONFIG_COH901318 is not set
CONFIG_DMA_JZ4780=y
CONFIG_DMA_SA11X0=y
CONFIG_DMA_SUN6I=y
CONFIG_DW_AXI_DMAC=y
# CONFIG_EP93XX_DMA is not set
# CONFIG_FSL_EDMA is not set
CONFIG_IMG_MDC_DMA=y
CONFIG_INTEL_IDMA64=y
CONFIG_INTEL_IOP_ADMA=y
CONFIG_K3_DMA=y
# CONFIG_MCF_EDMA is not set
# CONFIG_MILBEAUT_HDMAC is not set
CONFIG_MILBEAUT_XDMAC=y
# CONFIG_MMP_PDMA is not set
CONFIG_MMP_TDMA=y
# CONFIG_MV_XOR is not set
# CONFIG_MXS_DMA is not set
# CONFIG_NBPFAXI_DMA is not set
# CONFIG_PCH_DMA is not set
# CONFIG_PLX_DMA is not set
CONFIG_STM32_DMA=y
# CONFIG_STM32_DMAMUX is not set
CONFIG_STM32_MDMA=y
# CONFIG_SPRD_DMA is not set
CONFIG_S3C24XX_DMAC=y
CONFIG_TEGRA20_APB_DMA=y
# CONFIG_TEGRA210_ADMA is not set
CONFIG_TIMB_DMA=y
# CONFIG_UNIPHIER_MDMAC is not set
CONFIG_UNIPHIER_XDMAC=y
CONFIG_XGENE_DMA=y
CONFIG_XILINX_ZYNQMP_DPDMA=y
# CONFIG_ZX_DMA is not set
# CONFIG_MTK_HSDMA is not set
CONFIG_MTK_CQDMA=y
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
# CONFIG_DW_DMAC is not set
# CONFIG_DW_DMAC_PCI is not set
CONFIG_SF_PDMA=y
CONFIG_RENESAS_DMA=y
# CONFIG_SH_DMAE_BASE is not set
CONFIG_RCAR_DMAC=y
CONFIG_RENESAS_USB_DMAC=y
CONFIG_TI_EDMA=y
CONFIG_DMA_OMAP=y
CONFIG_TI_DMA_CROSSBAR=y

#
# DMA Clients
#
# CONFIG_ASYNC_TX_DMA is not set
CONFIG_DMATEST=y
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
# CONFIG_SYNC_FILE is not set
# CONFIG_UDMABUF is not set
CONFIG_DMABUF_MOVE_NOTIFY=y
CONFIG_DMABUF_SELFTESTS=y
CONFIG_DMABUF_HEAPS=y
# CONFIG_DMABUF_HEAPS_SYSTEM is not set
# end of DMABUF options

CONFIG_AUXDISPLAY=y
# CONFIG_HD44780 is not set
# CONFIG_IMG_ASCII_LCD is not set
CONFIG_PANEL_CHANGE_MESSAGE=y
CONFIG_PANEL_BOOT_MESSAGE=""
# CONFIG_CHARLCD_BL_OFF is not set
# CONFIG_CHARLCD_BL_ON is not set
CONFIG_CHARLCD_BL_FLASH=y
CONFIG_CHARLCD=y
CONFIG_UIO=y
# CONFIG_UIO_CIF is not set
# CONFIG_UIO_PDRV_GENIRQ is not set
# CONFIG_UIO_DMEM_GENIRQ is not set
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
# CONFIG_VFIO is not set
CONFIG_VIRT_DRIVERS=y
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set
# CONFIG_VDPA is not set
CONFIG_VHOST_MENU=y
# CONFIG_VHOST_NET is not set
# CONFIG_VHOST_VSOCK is not set
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
CONFIG_STAGING=y
CONFIG_COMEDI=y
CONFIG_COMEDI_DEBUG=y
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
# CONFIG_COMEDI_MISC_DRIVERS is not set
CONFIG_COMEDI_ISA_DRIVERS=y
# CONFIG_COMEDI_PCL711 is not set
CONFIG_COMEDI_PCL724=y
# CONFIG_COMEDI_PCL726 is not set
# CONFIG_COMEDI_PCL730 is not set
# CONFIG_COMEDI_PCL812 is not set
CONFIG_COMEDI_PCL816=y
# CONFIG_COMEDI_PCL818 is not set
CONFIG_COMEDI_PCM3724=y
# CONFIG_COMEDI_AMPLC_DIO200_ISA is not set
CONFIG_COMEDI_AMPLC_PC236_ISA=y
CONFIG_COMEDI_AMPLC_PC263_ISA=y
# CONFIG_COMEDI_RTI800 is not set
# CONFIG_COMEDI_RTI802 is not set
CONFIG_COMEDI_DAC02=y
# CONFIG_COMEDI_DAS16M1 is not set
# CONFIG_COMEDI_DAS08_ISA is not set
# CONFIG_COMEDI_DAS16 is not set
# CONFIG_COMEDI_DAS800 is not set
CONFIG_COMEDI_DAS1800=y
CONFIG_COMEDI_DAS6402=y
CONFIG_COMEDI_DT2801=y
CONFIG_COMEDI_DT2811=y
CONFIG_COMEDI_DT2814=y
CONFIG_COMEDI_DT2815=y
# CONFIG_COMEDI_DT2817 is not set
# CONFIG_COMEDI_DT282X is not set
CONFIG_COMEDI_DMM32AT=y
# CONFIG_COMEDI_FL512 is not set
CONFIG_COMEDI_AIO_AIO12_8=y
# CONFIG_COMEDI_AIO_IIRO_16 is not set
CONFIG_COMEDI_II_PCI20KC=y
CONFIG_COMEDI_C6XDIGIO=y
CONFIG_COMEDI_MPC624=y
CONFIG_COMEDI_ADQ12B=y
# CONFIG_COMEDI_NI_AT_A2150 is not set
# CONFIG_COMEDI_NI_AT_AO is not set
CONFIG_COMEDI_NI_ATMIO=y
CONFIG_COMEDI_NI_ATMIO16D=y
CONFIG_COMEDI_NI_LABPC_ISA=y
CONFIG_COMEDI_PCMAD=y
CONFIG_COMEDI_PCMDA12=y
# CONFIG_COMEDI_PCMMIO is not set
CONFIG_COMEDI_PCMUIO=y
CONFIG_COMEDI_MULTIQ3=y
CONFIG_COMEDI_S526=y
# CONFIG_COMEDI_PCI_DRIVERS is not set
# CONFIG_COMEDI_USB_DRIVERS is not set
CONFIG_COMEDI_8254=y
CONFIG_COMEDI_8255=y
CONFIG_COMEDI_8255_SA=y
CONFIG_COMEDI_KCOMEDILIB=y
CONFIG_COMEDI_AMPLC_PC236=y
CONFIG_COMEDI_ISADMA=y
CONFIG_COMEDI_NI_LABPC=y
CONFIG_COMEDI_NI_LABPC_ISADMA=y
CONFIG_COMEDI_NI_TIO=y
CONFIG_COMEDI_NI_ROUTING=y
# CONFIG_USB_EMXX is not set
# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# end of Android

CONFIG_STAGING_BOARD=y
CONFIG_FIREWIRE_SERIAL=y
CONFIG_FWTTY_MAX_TOTAL_PORTS=64
CONFIG_FWTTY_MAX_CARD_PORTS=32
# CONFIG_GS_FPGABOOT is not set
# CONFIG_UNISYSSPAR is not set
# CONFIG_COMMON_CLK_XLNX_CLKWZRD is not set
CONFIG_MOST_COMPONENTS=y
# CONFIG_MOST_NET is not set
# CONFIG_MOST_SOUND is not set
CONFIG_MOST_VIDEO=y
# CONFIG_MOST_DIM2 is not set
# CONFIG_MOST_I2C is not set
CONFIG_BCM_VIDEOCORE=y
CONFIG_BCM2835_VCHIQ=y
CONFIG_SND_BCM2835=y
CONFIG_VIDEO_BCM2835=y
CONFIG_BCM2835_VCHIQ_MMAL=y
CONFIG_PI433=y

#
# Gasket devices
#
# end of Gasket devices

CONFIG_XIL_AXIS_FIFO=y
CONFIG_FIELDBUS_DEV=y
CONFIG_HMS_ANYBUSS_BUS=y
CONFIG_ARCX_ANYBUS_CONTROLLER=y
CONFIG_HMS_PROFINET=y
# CONFIG_KPC2000 is not set
# CONFIG_PHY_HI3670_USB is not set
CONFIG_SPMI_HISI3670=y
CONFIG_MFD_HI6421_SPMI=y
# CONFIG_REGULATOR_HI6421V600 is not set
# CONFIG_GOLDFISH is not set
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
# CONFIG_OLPC_XO175 is not set
CONFIG_HAVE_CLK=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Clock driver for ARM Reference designs
#
# CONFIG_ICST is not set
# CONFIG_CLK_SP810 is not set
# end of Clock driver for ARM Reference designs

# CONFIG_CLK_HSDK is not set
# CONFIG_COMMON_CLK_MAX77686 is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_HI655X is not set
CONFIG_COMMON_CLK_SCMI=y
CONFIG_COMMON_CLK_SCPI=y
CONFIG_COMMON_CLK_SI5341=y
CONFIG_COMMON_CLK_SI5351=y
# CONFIG_COMMON_CLK_SI514 is not set
CONFIG_COMMON_CLK_SI544=y
CONFIG_COMMON_CLK_SI570=y
# CONFIG_COMMON_CLK_BM1880 is not set
CONFIG_COMMON_CLK_CDCE706=y
CONFIG_COMMON_CLK_CDCE925=y
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_FSL_SAI is not set
CONFIG_COMMON_CLK_GEMINI=y
CONFIG_COMMON_CLK_ASPEED=y
CONFIG_COMMON_CLK_S2MPS11=y
# CONFIG_CLK_TWL6040 is not set
# CONFIG_COMMON_CLK_AXI_CLKGEN is not set
CONFIG_CLK_QORIQ=y
# CONFIG_CLK_LS1028A_PLLDIG is not set
CONFIG_COMMON_CLK_XGENE=y
# CONFIG_COMMON_CLK_LOCHNAGAR is not set
CONFIG_COMMON_CLK_PALMAS=y
CONFIG_COMMON_CLK_PWM=y
CONFIG_COMMON_CLK_OXNAS=y
# CONFIG_COMMON_CLK_VC5 is not set
CONFIG_COMMON_CLK_MMP2_AUDIO=y
# CONFIG_COMMON_CLK_BD718XX is not set
CONFIG_COMMON_CLK_FIXED_MMIO=y
CONFIG_CLK_ACTIONS=y
CONFIG_CLK_OWL_S500=y
CONFIG_CLK_OWL_S700=y
# CONFIG_CLK_OWL_S900 is not set
# CONFIG_CLK_BAIKAL_T1 is not set
# CONFIG_CLK_BCM2711_DVP is not set
CONFIG_CLK_BCM2835=y
# CONFIG_CLK_BCM_63XX is not set
# CONFIG_CLK_BCM_63XX_GATE is not set
CONFIG_CLK_BCM_KONA=y
CONFIG_COMMON_CLK_IPROC=y
# CONFIG_CLK_BCM_CYGNUS is not set
CONFIG_CLK_BCM_HR2=y
# CONFIG_CLK_BCM_NSP is not set
CONFIG_CLK_BCM_NS2=y
# CONFIG_CLK_BCM_SR is not set
# CONFIG_CLK_RASPBERRYPI is not set
CONFIG_COMMON_CLK_HI3516CV300=y
# CONFIG_COMMON_CLK_HI3519 is not set
# CONFIG_COMMON_CLK_HI3660 is not set
CONFIG_COMMON_CLK_HI3670=y
CONFIG_COMMON_CLK_HI3798CV200=y
# CONFIG_COMMON_CLK_HI6220 is not set
CONFIG_RESET_HISI=y
# CONFIG_STUB_CLK_HI6220 is not set
CONFIG_STUB_CLK_HI3660=y
CONFIG_COMMON_CLK_BOSTON=y
CONFIG_MXC_CLK=y
CONFIG_CLK_IMX8MM=y
# CONFIG_CLK_IMX8MN is not set
CONFIG_CLK_IMX8MP=y
# CONFIG_CLK_IMX8MQ is not set

#
# Ingenic SoCs drivers
#
CONFIG_INGENIC_CGU_COMMON=y
# CONFIG_INGENIC_CGU_JZ4740 is not set
# CONFIG_INGENIC_CGU_JZ4725B is not set
CONFIG_INGENIC_CGU_JZ4770=y
CONFIG_INGENIC_CGU_JZ4780=y
# CONFIG_INGENIC_CGU_X1000 is not set
CONFIG_INGENIC_CGU_X1830=y
CONFIG_INGENIC_TCU_CLK=y
# end of Ingenic SoCs drivers

CONFIG_COMMON_CLK_KEYSTONE=y
# CONFIG_TI_SYSCON_CLK is not set

#
# Clock driver for MediaTek SoC
#
CONFIG_COMMON_CLK_MEDIATEK=y
CONFIG_COMMON_CLK_MT2701=y
# CONFIG_COMMON_CLK_MT2701_MMSYS is not set
CONFIG_COMMON_CLK_MT2701_IMGSYS=y
# CONFIG_COMMON_CLK_MT2701_VDECSYS is not set
# CONFIG_COMMON_CLK_MT2701_HIFSYS is not set
CONFIG_COMMON_CLK_MT2701_ETHSYS=y
CONFIG_COMMON_CLK_MT2701_BDPSYS=y
CONFIG_COMMON_CLK_MT2701_AUDSYS=y
CONFIG_COMMON_CLK_MT2701_G3DSYS=y
# CONFIG_COMMON_CLK_MT2712 is not set
CONFIG_COMMON_CLK_MT6765=y
CONFIG_COMMON_CLK_MT6765_AUDIOSYS=y
# CONFIG_COMMON_CLK_MT6765_CAMSYS is not set
CONFIG_COMMON_CLK_MT6765_GCESYS=y
# CONFIG_COMMON_CLK_MT6765_MMSYS is not set
CONFIG_COMMON_CLK_MT6765_IMGSYS=y
CONFIG_COMMON_CLK_MT6765_VCODECSYS=y
# CONFIG_COMMON_CLK_MT6765_MFGSYS is not set
# CONFIG_COMMON_CLK_MT6765_MIPI0ASYS is not set
# CONFIG_COMMON_CLK_MT6765_MIPI0BSYS is not set
# CONFIG_COMMON_CLK_MT6765_MIPI1ASYS is not set
CONFIG_COMMON_CLK_MT6765_MIPI1BSYS=y
# CONFIG_COMMON_CLK_MT6765_MIPI2ASYS is not set
# CONFIG_COMMON_CLK_MT6765_MIPI2BSYS is not set
CONFIG_COMMON_CLK_MT6779=y
# CONFIG_COMMON_CLK_MT6779_MMSYS is not set
# CONFIG_COMMON_CLK_MT6779_IMGSYS is not set
# CONFIG_COMMON_CLK_MT6779_IPESYS is not set
CONFIG_COMMON_CLK_MT6779_CAMSYS=y
# CONFIG_COMMON_CLK_MT6779_VDECSYS is not set
CONFIG_COMMON_CLK_MT6779_VENCSYS=y
# CONFIG_COMMON_CLK_MT6779_MFGCFG is not set
CONFIG_COMMON_CLK_MT6779_AUDSYS=y
CONFIG_COMMON_CLK_MT6797=y
CONFIG_COMMON_CLK_MT6797_MMSYS=y
# CONFIG_COMMON_CLK_MT6797_IMGSYS is not set
# CONFIG_COMMON_CLK_MT6797_VDECSYS is not set
# CONFIG_COMMON_CLK_MT6797_VENCSYS is not set
CONFIG_COMMON_CLK_MT7622=y
# CONFIG_COMMON_CLK_MT7622_ETHSYS is not set
CONFIG_COMMON_CLK_MT7622_HIFSYS=y
CONFIG_COMMON_CLK_MT7622_AUDSYS=y
CONFIG_COMMON_CLK_MT7629=y
CONFIG_COMMON_CLK_MT7629_ETHSYS=y
# CONFIG_COMMON_CLK_MT7629_HIFSYS is not set
CONFIG_COMMON_CLK_MT8135=y
# CONFIG_COMMON_CLK_MT8167 is not set
# CONFIG_COMMON_CLK_MT8167_AUDSYS is not set
# CONFIG_COMMON_CLK_MT8167_IMGSYS is not set
# CONFIG_COMMON_CLK_MT8167_MFGCFG is not set
# CONFIG_COMMON_CLK_MT8167_MMSYS is not set
# CONFIG_COMMON_CLK_MT8167_VDECSYS is not set
CONFIG_COMMON_CLK_MT8173=y
# CONFIG_COMMON_CLK_MT8173_MMSYS is not set
# CONFIG_COMMON_CLK_MT8183 is not set
# CONFIG_COMMON_CLK_MT8516 is not set
# end of Clock driver for MediaTek SoC

#
# Clock support for Amlogic platforms
#
# CONFIG_COMMON_CLK_AXG_AUDIO is not set
# end of Clock support for Amlogic platforms

# CONFIG_COMMON_CLK_QCOM is not set
# CONFIG_CLK_RENESAS is not set
CONFIG_COMMON_CLK_SAMSUNG=y
CONFIG_EXYNOS_ARM64_COMMON_CLK=y
# CONFIG_EXYNOS_AUDSS_CLK_CON is not set
CONFIG_S3C2410_COMMON_CLK=y
# CONFIG_S3C2412_COMMON_CLK is not set
CONFIG_S3C2443_COMMON_CLK=y
CONFIG_CLK_SIFIVE=y
# CONFIG_CLK_SIFIVE_FU540_PRCI is not set
CONFIG_SPRD_COMMON_CLK=y
# CONFIG_SPRD_SC9860_CLK is not set
CONFIG_SPRD_SC9863A_CLK=y
CONFIG_CLK_SUNXI=y
# CONFIG_CLK_SUNXI_CLOCKS is not set
# CONFIG_CLK_SUNXI_PRCM_SUN6I is not set
CONFIG_CLK_SUNXI_PRCM_SUN8I=y
CONFIG_CLK_SUNXI_PRCM_SUN9I=y
CONFIG_SUNXI_CCU=y
# CONFIG_SUNIV_F1C100S_CCU is not set
# CONFIG_SUN50I_A64_CCU is not set
# CONFIG_SUN50I_A100_CCU is not set
# CONFIG_SUN50I_A100_R_CCU is not set
# CONFIG_SUN50I_H6_CCU is not set
CONFIG_SUN50I_H6_R_CCU=y
# CONFIG_SUN4I_A10_CCU is not set
CONFIG_SUN5I_CCU=y
# CONFIG_SUN6I_A31_CCU is not set
CONFIG_SUN8I_A23_CCU=y
CONFIG_SUN8I_A33_CCU=y
# CONFIG_SUN8I_A83T_CCU is not set
CONFIG_SUN8I_H3_CCU=y
# CONFIG_SUN8I_V3S_CCU is not set
CONFIG_SUN8I_DE2_CCU=y
CONFIG_SUN8I_R40_CCU=y
CONFIG_SUN9I_A80_CCU=y
CONFIG_SUN8I_R_CCU=y
CONFIG_COMMON_CLK_TI_ADPLL=y
# CONFIG_CLK_UNIPHIER is not set
# CONFIG_CLK_LGM_CGU is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_TIMER_OF=y
CONFIG_TIMER_PROBE=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
CONFIG_CLKSRC_MMIO=y
# CONFIG_BCM2835_TIMER is not set
# CONFIG_BCM_KONA_TIMER is not set
# CONFIG_DAVINCI_TIMER is not set
# CONFIG_DIGICOLOR_TIMER is not set
# CONFIG_DW_APB_TIMER is not set
# CONFIG_FTTMR010_TIMER is not set
# CONFIG_IXP4XX_TIMER is not set
CONFIG_MESON6_TIMER=y
CONFIG_OWL_TIMER=y
# CONFIG_RDA_TIMER is not set
CONFIG_SUN4I_TIMER=y
# CONFIG_SUN5I_HSTIMER is not set
# CONFIG_TEGRA_TIMER is not set
# CONFIG_VT8500_TIMER is not set
CONFIG_NPCM7XX_TIMER=y
# CONFIG_CADENCE_TTC_TIMER is not set
CONFIG_ASM9260_TIMER=y
# CONFIG_CLKSRC_DBX500_PRCMU is not set
# CONFIG_CLPS711X_TIMER is not set
# CONFIG_ATLAS7_TIMER is not set
# CONFIG_MXS_TIMER is not set
# CONFIG_PRIMA2_TIMER is not set
# CONFIG_NSPIRE_TIMER is not set
CONFIG_INTEGRATOR_AP_TIMER=y
# CONFIG_CLKSRC_PISTACHIO is not set
# CONFIG_CLKSRC_NPS is not set
# CONFIG_CLKSRC_STM32_LP is not set
CONFIG_ARMV7M_SYSTICK=y
CONFIG_ATMEL_PIT=y
CONFIG_ATMEL_ST=y
CONFIG_CLKSRC_SAMSUNG_PWM=y
# CONFIG_FSL_FTM_TIMER is not set
CONFIG_OXNAS_RPS_TIMER=y
# CONFIG_MTK_TIMER is not set
CONFIG_SPRD_TIMER=y
# CONFIG_CLKSRC_JCORE_PIT is not set
# CONFIG_SH_TIMER_CMT is not set
# CONFIG_SH_TIMER_MTU2 is not set
# CONFIG_RENESAS_OSTM is not set
# CONFIG_SH_TIMER_TMU is not set
# CONFIG_EM_TIMER_STI is not set
# CONFIG_CLKSRC_PXA is not set
# CONFIG_H8300_TMR8 is not set
# CONFIG_H8300_TMR16 is not set
# CONFIG_H8300_TPU is not set
# CONFIG_TIMER_IMX_SYS_CTR is not set
CONFIG_CLKSRC_ST_LPC=y
# CONFIG_ATCPIT100_TIMER is not set
# CONFIG_INGENIC_TIMER is not set
CONFIG_INGENIC_SYSOST=y
CONFIG_INGENIC_OST=y
# CONFIG_MICROCHIP_PIT64B is not set
# end of Clock Source drivers

CONFIG_MAILBOX=y
# CONFIG_IMX_MBOX is not set
CONFIG_PLATFORM_MHU=y
CONFIG_ARMADA_37XX_RWTM_MBOX=y
# CONFIG_ROCKCHIP_MBOX is not set
CONFIG_ALTERA_MBOX=y
CONFIG_HI3660_MBOX=y
CONFIG_HI6220_MBOX=y
# CONFIG_MAILBOX_TEST is not set
# CONFIG_QCOM_APCS_IPC is not set
CONFIG_BCM_PDC_MBOX=y
CONFIG_MTK_CMDQ_MBOX=y
CONFIG_SUN6I_MSGBOX=y
CONFIG_SPRD_MBOX=y
# CONFIG_QCOM_IPCC is not set
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
CONFIG_RPMSG_CHAR=y
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
CONFIG_RPMSG_VIRTIO=y
# end of Rpmsg drivers

CONFIG_SOUNDWIRE=y

#
# SoundWire Devices
#
CONFIG_SOUNDWIRE_QCOM=y

#
# SOC (System On Chip) specific Drivers
#
# CONFIG_OWL_PM_DOMAINS is not set

#
# Amlogic SoC drivers
#
# CONFIG_MESON_CANVAS is not set
# CONFIG_MESON_CLK_MEASURE is not set
# CONFIG_MESON_GX_SOCINFO is not set
CONFIG_MESON_GX_PM_DOMAINS=y
# CONFIG_MESON_EE_PM_DOMAINS is not set
# CONFIG_MESON_MX_SOCINFO is not set
# end of Amlogic SoC drivers

#
# Aspeed SoC drivers
#
CONFIG_SOC_ASPEED=y
CONFIG_ASPEED_LPC_CTRL=y
CONFIG_ASPEED_LPC_SNOOP=y
CONFIG_ASPEED_P2A_CTRL=y
# end of Aspeed SoC drivers

CONFIG_AT91_SOC_ID=y
CONFIG_AT91_SOC_SFR=y

#
# Broadcom SoC drivers
#
CONFIG_BCM2835_POWER=y
CONFIG_SOC_BCM63XX=y
CONFIG_SOC_BRCMSTB=y
CONFIG_BCM63XX_POWER=y
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# CONFIG_QUICC_ENGINE is not set
CONFIG_DPAA2_CONSOLE=y
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
CONFIG_IMX_GPCV2_PM_DOMAINS=y
# CONFIG_SOC_IMX8M is not set
# end of i.MX SoC drivers

#
# IXP4xx SoC drivers
#
# CONFIG_IXP4XX_QMGR is not set
CONFIG_IXP4XX_NPE=y
# end of IXP4xx SoC drivers

#
# MediaTek SoC drivers
#
CONFIG_MTK_CMDQ=y
CONFIG_MTK_INFRACFG=y
CONFIG_MTK_PMIC_WRAP=y
# CONFIG_MTK_SCPSYS is not set
# CONFIG_MTK_MMSYS is not set
# end of MediaTek SoC drivers

#
# Qualcomm SoC drivers
#
# CONFIG_QCOM_AOSS_QMP is not set
CONFIG_QCOM_COMMAND_DB=y
# CONFIG_QCOM_GENI_SE is not set
# CONFIG_QCOM_GSBI is not set
CONFIG_QCOM_LLCC=y
CONFIG_QCOM_RPMH=y
CONFIG_QCOM_RPMHPD=y
CONFIG_QCOM_RPMPD=y
CONFIG_QCOM_SMD_RPM=y
CONFIG_QCOM_WCNSS_CTRL=y
# CONFIG_QCOM_APR is not set
# end of Qualcomm SoC drivers

CONFIG_SOC_RENESAS=y
# CONFIG_RST_RCAR is not set
CONFIG_SYSC_RCAR=y
CONFIG_SYSC_R8A77995=y
# CONFIG_SYSC_R8A7794 is not set
CONFIG_SYSC_R8A77990=y
CONFIG_SYSC_R8A7779=y
CONFIG_SYSC_R8A7790=y
# CONFIG_SYSC_R8A7795 is not set
CONFIG_SYSC_R8A7791=y
CONFIG_SYSC_R8A77965=y
CONFIG_SYSC_R8A77960=y
CONFIG_SYSC_R8A77961=y
CONFIG_SYSC_R8A7792=y
# CONFIG_SYSC_R8A77980 is not set
CONFIG_SYSC_R8A77970=y
CONFIG_SYSC_R8A779A0=y
CONFIG_SYSC_RMOBILE=y
# CONFIG_SYSC_R8A77470 is not set
# CONFIG_SYSC_R8A7745 is not set
# CONFIG_SYSC_R8A7742 is not set
CONFIG_SYSC_R8A7743=y
# CONFIG_SYSC_R8A774C0 is not set
CONFIG_SYSC_R8A774E1=y
# CONFIG_SYSC_R8A774A1 is not set
CONFIG_SYSC_R8A774B1=y
# CONFIG_ROCKCHIP_GRF is not set
# CONFIG_ROCKCHIP_IODOMAIN is not set
# CONFIG_ROCKCHIP_PM_DOMAINS is not set
CONFIG_SOC_SAMSUNG=y
# CONFIG_EXYNOS_ASV is not set
# CONFIG_EXYNOS_CHIPID is not set
# CONFIG_EXYNOS_PM_DOMAINS is not set
CONFIG_EXYNOS_REGULATOR_COUPLER=y
CONFIG_SOC_TEGRA20_VOLTAGE_COUPLER=y
CONFIG_SOC_TEGRA30_VOLTAGE_COUPLER=y
CONFIG_SOC_TI=y
CONFIG_UX500_SOC_ID=y

#
# Xilinx SoC drivers
#
CONFIG_XILINX_VCU=y
# end of Xilinx SoC drivers

# CONFIG_SOC_ZTE is not set
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
CONFIG_DEVFREQ_GOV_PERFORMANCE=y
CONFIG_DEVFREQ_GOV_POWERSAVE=y
CONFIG_DEVFREQ_GOV_USERSPACE=y
CONFIG_DEVFREQ_GOV_PASSIVE=y

#
# DEVFREQ Drivers
#
CONFIG_ARM_EXYNOS_BUS_DEVFREQ=y
CONFIG_ARM_IMX_BUS_DEVFREQ=y
# CONFIG_ARM_TEGRA_DEVFREQ is not set
# CONFIG_ARM_TEGRA20_DEVFREQ is not set
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_DEVFREQ_EVENT_EXYNOS_NOCP=y
CONFIG_DEVFREQ_EVENT_EXYNOS_PPMU=y
# CONFIG_DEVFREQ_EVENT_ROCKCHIP_DFI is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_FSA9480 is not set
# CONFIG_EXTCON_GPIO is not set
CONFIG_EXTCON_MAX3355=y
CONFIG_EXTCON_MAX77693=y
# CONFIG_EXTCON_MAX77843 is not set
CONFIG_EXTCON_PALMAS=y
CONFIG_EXTCON_PTN5150=y
CONFIG_EXTCON_QCOM_SPMI_MISC=y
CONFIG_EXTCON_RT8973A=y
CONFIG_EXTCON_SM5502=y
CONFIG_EXTCON_USB_GPIO=y
CONFIG_MEMORY=y
CONFIG_DDR=y
CONFIG_ATMEL_SDRAMC=y
CONFIG_ATMEL_EBI=y
CONFIG_BRCMSTB_DPFE=y
CONFIG_BT1_L2_CTL=y
# CONFIG_TI_AEMIF is not set
CONFIG_TI_EMIF=y
# CONFIG_OMAP_GPMC is not set
CONFIG_MVEBU_DEVBUS=y
# CONFIG_FSL_CORENET_CF is not set
CONFIG_FSL_IFC=y
CONFIG_JZ4780_NEMC=y
# CONFIG_MTK_SMI is not set
CONFIG_DA8XX_DDRCTL=y
# CONFIG_RENESAS_RPCIF is not set
CONFIG_STM32_FMC2_EBI=y
CONFIG_SAMSUNG_MC=y
CONFIG_EXYNOS5422_DMC=y
# CONFIG_EXYNOS_SROM is not set
# CONFIG_IIO is not set
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_DEBUG=y
# CONFIG_PWM_ATMEL is not set
CONFIG_PWM_BCM_IPROC=y
CONFIG_PWM_BCM_KONA=y
CONFIG_PWM_BCM2835=y
CONFIG_PWM_BERLIN=y
CONFIG_PWM_BRCMSTB=y
# CONFIG_PWM_CLPS711X is not set
# CONFIG_PWM_EP93XX is not set
# CONFIG_PWM_FSL_FTM is not set
CONFIG_PWM_HIBVT=y
CONFIG_PWM_IMG=y
# CONFIG_PWM_IMX1 is not set
# CONFIG_PWM_IMX27 is not set
CONFIG_PWM_IMX_TPM=y
CONFIG_PWM_IQS620A=y
# CONFIG_PWM_LPC18XX_SCT is not set
# CONFIG_PWM_LPC32XX is not set
# CONFIG_PWM_MESON is not set
# CONFIG_PWM_MTK_DISP is not set
CONFIG_PWM_MEDIATEK=y
# CONFIG_PWM_MXS is not set
CONFIG_PWM_OMAP_DMTIMER=y
CONFIG_PWM_PCA9685=y
CONFIG_PWM_PXA=y
# CONFIG_PWM_RCAR is not set
CONFIG_PWM_RENESAS_TPU=y
# CONFIG_PWM_ROCKCHIP is not set
# CONFIG_PWM_SAMSUNG is not set
CONFIG_PWM_SIFIVE=y
# CONFIG_PWM_SL28CPLD is not set
# CONFIG_PWM_SPEAR is not set
# CONFIG_PWM_SPRD is not set
CONFIG_PWM_STI=y
CONFIG_PWM_STM32=y
CONFIG_PWM_STM32_LP=y
CONFIG_PWM_SUN4I=y
CONFIG_PWM_TEGRA=y
CONFIG_PWM_TIECAP=y
CONFIG_PWM_TIEHRPWM=y
CONFIG_PWM_VT8500=y
# CONFIG_PWM_ZX is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
# CONFIG_AL_FIC is not set
CONFIG_MADERA_IRQ=y
CONFIG_JCORE_AIC=y
# CONFIG_RENESAS_INTC_IRQPIN is not set
CONFIG_RENESAS_IRQC=y
# CONFIG_RENESAS_RZA1_IRQC is not set
CONFIG_SL28CPLD_INTC=y
CONFIG_TS4800_IRQ=y
CONFIG_INGENIC_TCU_IRQ=y
# CONFIG_RENESAS_H8S_INTC is not set
# CONFIG_EZNPS_GIC is not set
CONFIG_IRQ_UNIPHIER_AIDET=y
CONFIG_IMX_IRQSTEER=y
# CONFIG_IMX_INTMUX is not set
# CONFIG_EXYNOS_IRQ_COMBINER is not set
# CONFIG_LOONGSON_PCH_PIC is not set
# CONFIG_LOONGSON_PCH_MSI is not set
CONFIG_MST_IRQ=y
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_ATH79 is not set
# CONFIG_RESET_AXS10X is not set
# CONFIG_RESET_BERLIN is not set
CONFIG_RESET_BRCMSTB=y
CONFIG_RESET_BRCMSTB_RESCAL=y
# CONFIG_RESET_HSDK is not set
# CONFIG_RESET_IMX7 is not set
CONFIG_RESET_INTEL_GW=y
CONFIG_RESET_LANTIQ=y
# CONFIG_RESET_LPC18XX is not set
# CONFIG_RESET_MESON is not set
CONFIG_RESET_MESON_AUDIO_ARB=y
# CONFIG_RESET_NPCM is not set
# CONFIG_RESET_PISTACHIO is not set
# CONFIG_RESET_QCOM_AOSS is not set
CONFIG_RESET_QCOM_PDC=y
CONFIG_RESET_SCMI=y
CONFIG_RESET_SIMPLE=y
# CONFIG_RESET_STM32MP157 is not set
# CONFIG_RESET_SOCFPGA is not set
CONFIG_RESET_SUNXI=y
CONFIG_RESET_TI_SYSCON=y
CONFIG_RESET_UNIPHIER=y
CONFIG_RESET_UNIPHIER_GLUE=y
CONFIG_RESET_ZYNQ=y
CONFIG_COMMON_RESET_HI3660=y
CONFIG_COMMON_RESET_HI6220=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
# CONFIG_PHY_LPC18XX_USB_OTG is not set
CONFIG_PHY_XGENE=y
CONFIG_USB_LGM_PHY=y
CONFIG_PHY_SUN4I_USB=y
# CONFIG_PHY_SUN6I_MIPI_DPHY is not set
# CONFIG_PHY_SUN9I_USB is not set
# CONFIG_PHY_SUN50I_USB3 is not set
CONFIG_PHY_MESON8B_USB2=y
CONFIG_PHY_MESON_GXL_USB2=y
# CONFIG_PHY_MESON_G12A_USB2 is not set
CONFIG_PHY_MESON_G12A_USB3_PCIE=y
CONFIG_PHY_MESON_AXG_PCIE=y
CONFIG_PHY_MESON_AXG_MIPI_PCIE_ANALOG=y
CONFIG_PHY_BCM63XX_USBH=y
CONFIG_PHY_CYGNUS_PCIE=y
CONFIG_PHY_BCM_SR_USB=y
# CONFIG_BCM_KONA_USB2_PHY is not set
CONFIG_PHY_BCM_NS_USB2=y
CONFIG_PHY_NS2_USB_DRD=y
CONFIG_PHY_BRCM_SATA=y
CONFIG_PHY_BRCM_USB=y
# CONFIG_PHY_BCM_SR_PCIE is not set
# CONFIG_PHY_CADENCE_TORRENT is not set
CONFIG_PHY_CADENCE_DPHY=y
CONFIG_PHY_CADENCE_SIERRA=y
# CONFIG_PHY_CADENCE_SALVO is not set
CONFIG_PHY_FSL_IMX8MQ_USB=y
CONFIG_PHY_MIXEL_MIPI_DPHY=y
CONFIG_PHY_HI6220_USB=y
CONFIG_PHY_HI3660_USB=y
# CONFIG_PHY_HISTB_COMBPHY is not set
# CONFIG_PHY_HISI_INNO_USB2 is not set
CONFIG_PHY_LANTIQ_VRX200_PCIE=y
# CONFIG_PHY_LANTIQ_RCU_USB2 is not set
# CONFIG_ARMADA375_USBCLUSTER_PHY is not set
CONFIG_PHY_BERLIN_SATA=y
CONFIG_PHY_BERLIN_USB=y
CONFIG_PHY_MVEBU_A3700_UTMI=y
CONFIG_PHY_MVEBU_A38X_COMPHY=y
CONFIG_PHY_PXA_28NM_HSIC=y
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_PXA_USB is not set
# CONFIG_PHY_MMP3_USB is not set
CONFIG_PHY_MTK_TPHY=y
CONFIG_PHY_MTK_UFS=y
# CONFIG_PHY_MTK_XSPHY is not set
CONFIG_PHY_MTK_HDMI=y
# CONFIG_PHY_MAPPHONE_MDM6600 is not set
CONFIG_PHY_OCELOT_SERDES=y
# CONFIG_PHY_ATH79_USB is not set
CONFIG_PHY_QCOM_IPQ4019_USB=y
CONFIG_PHY_QCOM_PCIE2=y
CONFIG_PHY_QCOM_QMP=y
CONFIG_PHY_QCOM_QUSB2=y
CONFIG_PHY_QCOM_USB_HS=y
CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=y
# CONFIG_PHY_QCOM_USB_HSIC is not set
CONFIG_PHY_QCOM_USB_HS_28NM=y
CONFIG_PHY_QCOM_USB_SS=y
CONFIG_PHY_QCOM_IPQ806X_USB=y
CONFIG_PHY_RALINK_USB=y
CONFIG_PHY_RCAR_GEN3_USB3=y
CONFIG_PHY_ROCKCHIP_DPHY_RX0=y
# CONFIG_PHY_ROCKCHIP_INNO_HDMI is not set
CONFIG_PHY_ROCKCHIP_INNO_USB2=y
CONFIG_PHY_ROCKCHIP_INNO_DSIDPHY=y
# CONFIG_PHY_ROCKCHIP_PCIE is not set
CONFIG_PHY_ROCKCHIP_TYPEC=y
# CONFIG_PHY_EXYNOS_DP_VIDEO is not set
CONFIG_PHY_EXYNOS_MIPI_VIDEO=y
# CONFIG_PHY_EXYNOS_PCIE is not set
# CONFIG_PHY_SAMSUNG_UFS is not set
# CONFIG_PHY_SAMSUNG_USB2 is not set
# CONFIG_PHY_EXYNOS5_USBDRD is not set
CONFIG_PHY_UNIPHIER_USB2=y
# CONFIG_PHY_UNIPHIER_USB3 is not set
# CONFIG_PHY_UNIPHIER_PCIE is not set
CONFIG_PHY_UNIPHIER_AHCI=y
# CONFIG_PHY_ST_SPEAR1310_MIPHY is not set
CONFIG_PHY_ST_SPEAR1340_MIPHY=y
CONFIG_PHY_STIH407_USB=y
# CONFIG_PHY_STM32_USBPHYC is not set
CONFIG_PHY_TEGRA194_P2U=y
CONFIG_PHY_DA8XX_USB=y
CONFIG_PHY_DM816X_USB=y
# CONFIG_PHY_AM654_SERDES is not set
# CONFIG_PHY_J721E_WIZ is not set
CONFIG_OMAP_CONTROL_PHY=y
# CONFIG_TI_PIPE3 is not set
CONFIG_PHY_TUSB1210=y
CONFIG_PHY_INTEL_KEEMBAY_EMMC=y
CONFIG_PHY_INTEL_LGM_COMBO=y
CONFIG_PHY_INTEL_LGM_EMMC=y
# CONFIG_PHY_XILINX_ZYNQMP is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
# CONFIG_IDLE_INJECT is not set
CONFIG_MCB=y
# CONFIG_MCB_PCI is not set
CONFIG_MCB_LPC=y
CONFIG_RAS=y
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID is not set
# end of Android

CONFIG_DAX=y
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_IMX_IIM is not set
CONFIG_NVMEM_IMX_OCOTP=y
CONFIG_JZ4780_EFUSE=y
# CONFIG_NVMEM_LPC18XX_EEPROM is not set
CONFIG_NVMEM_LPC18XX_OTP=y
CONFIG_NVMEM_MXS_OCOTP=y
# CONFIG_MTK_EFUSE is not set
CONFIG_QCOM_QFPROM=y
CONFIG_NVMEM_SPMI_SDAM=y
CONFIG_ROCKCHIP_EFUSE=y
CONFIG_ROCKCHIP_OTP=y
CONFIG_NVMEM_BCM_OCOTP=y
# CONFIG_NVMEM_STM32_ROMEM is not set
CONFIG_UNIPHIER_EFUSE=y
CONFIG_NVMEM_VF610_OCOTP=y
# CONFIG_MESON_MX_EFUSE is not set
CONFIG_NVMEM_SNVS_LPGPR=y
# CONFIG_SC27XX_EFUSE is not set
CONFIG_SPRD_EFUSE=y

#
# HW tracing support
#
# CONFIG_STM is not set
CONFIG_INTEL_TH=y
# CONFIG_INTEL_TH_PCI is not set
CONFIG_INTEL_TH_GTH=y
CONFIG_INTEL_TH_MSU=y
# CONFIG_INTEL_TH_PTI is not set
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

CONFIG_FPGA=y
CONFIG_FPGA_MGR_SOCFPGA=y
CONFIG_FPGA_MGR_SOCFPGA_A10=y
CONFIG_ALTERA_PR_IP_CORE=y
CONFIG_ALTERA_PR_IP_CORE_PLAT=y
CONFIG_FPGA_MGR_ALTERA_PS_SPI=y
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
CONFIG_FPGA_MGR_ZYNQ_FPGA=y
CONFIG_FPGA_MGR_XILINX_SPI=y
CONFIG_FPGA_MGR_ICE40_SPI=y
CONFIG_FPGA_MGR_MACHXO2_SPI=y
CONFIG_FPGA_BRIDGE=y
# CONFIG_ALTERA_FREEZE_BRIDGE is not set
CONFIG_XILINX_PR_DECOUPLER=y
CONFIG_FPGA_REGION=y
CONFIG_OF_FPGA_REGION=y
CONFIG_FPGA_DFL=y
CONFIG_FPGA_DFL_AFU=y
# CONFIG_FPGA_DFL_PCI is not set
# CONFIG_FPGA_MGR_ZYNQMP_FPGA is not set
CONFIG_FSI=y
CONFIG_FSI_NEW_DEV_NODE=y
CONFIG_FSI_MASTER_GPIO=y
CONFIG_FSI_MASTER_HUB=y
CONFIG_FSI_MASTER_AST_CF=y
# CONFIG_FSI_MASTER_ASPEED is not set
CONFIG_FSI_SCOM=y
CONFIG_FSI_SBEFIFO=y
CONFIG_FSI_OCC=y
# CONFIG_TEE is not set
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=y
# CONFIG_MUX_ADGS1408 is not set
CONFIG_MUX_GPIO=y
CONFIG_MUX_MMIO=y
# end of Multiplexer drivers

CONFIG_PM_OPP=y
CONFIG_SIOX=y
# CONFIG_SIOX_BUS_GPIO is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
CONFIG_COUNTER=y
CONFIG_STM32_TIMER_CNT=y
CONFIG_TI_EQEP=y
# CONFIG_FTM_QUADDEC is not set
# CONFIG_MICROCHIP_TCB_CAPTURE is not set
CONFIG_MOST=y
CONFIG_MOST_USB_HDM=y
# CONFIG_MOST_CDEV is not set
# end of Device Drivers

#
# File systems
#
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
# CONFIG_FILE_LOCKING is not set
CONFIG_FS_ENCRYPTION=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
# CONFIG_PRINT_QUOTA_WARNING is not set
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
CONFIG_QFMT_V1=y
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=y
CONFIG_CUSE=y
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=y
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
CONFIG_OVERLAY_FS_METACOPY=y

#
# Caches
#
# CONFIG_FSCACHE is not set
# end of Caches

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
# CONFIG_PROC_VMCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ECRYPT_FS is not set
CONFIG_JFFS2_FS=y
CONFIG_JFFS2_FS_DEBUG=0
# CONFIG_JFFS2_FS_WRITEBUFFER is not set
# CONFIG_JFFS2_SUMMARY is not set
CONFIG_JFFS2_FS_XATTR=y
CONFIG_JFFS2_FS_POSIX_ACL=y
CONFIG_JFFS2_FS_SECURITY=y
# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
CONFIG_JFFS2_ZLIB=y
CONFIG_JFFS2_RTIME=y
CONFIG_CRAMFS=y
# CONFIG_CRAMFS_MTD is not set
CONFIG_ROMFS_FS=y
CONFIG_ROMFS_BACKED_BY_MTD=y
CONFIG_ROMFS_ON_MTD=y
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFLATE_COMPRESS=y
CONFIG_PSTORE_LZO_COMPRESS=y
CONFIG_PSTORE_LZ4_COMPRESS=y
CONFIG_PSTORE_LZ4HC_COMPRESS=y
CONFIG_PSTORE_842_COMPRESS=y
CONFIG_PSTORE_ZSTD_COMPRESS=y
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
# CONFIG_PSTORE_LZO_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_LZ4_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_842_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_ZSTD_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
CONFIG_PSTORE_RAM=y
# CONFIG_NETWORK_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=y
# CONFIG_NLS_CODEPAGE_855 is not set
CONFIG_NLS_CODEPAGE_857=y
CONFIG_NLS_CODEPAGE_860=y
# CONFIG_NLS_CODEPAGE_861 is not set
CONFIG_NLS_CODEPAGE_862=y
CONFIG_NLS_CODEPAGE_863=y
CONFIG_NLS_CODEPAGE_864=y
CONFIG_NLS_CODEPAGE_865=y
# CONFIG_NLS_CODEPAGE_866 is not set
CONFIG_NLS_CODEPAGE_869=y
# CONFIG_NLS_CODEPAGE_936 is not set
CONFIG_NLS_CODEPAGE_950=y
CONFIG_NLS_CODEPAGE_932=y
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=y
CONFIG_NLS_ISO8859_8=y
CONFIG_NLS_CODEPAGE_1250=y
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=y
# CONFIG_NLS_ISO8859_1 is not set
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=y
# CONFIG_NLS_ISO8859_4 is not set
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=y
CONFIG_NLS_ISO8859_7=y
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=y
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=y
# CONFIG_NLS_KOI8_R is not set
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_MAC_ROMAN=y
# CONFIG_NLS_MAC_CELTIC is not set
# CONFIG_NLS_MAC_CENTEURO is not set
# CONFIG_NLS_MAC_CROATIAN is not set
CONFIG_NLS_MAC_CYRILLIC=y
CONFIG_NLS_MAC_GAELIC=y
CONFIG_NLS_MAC_GREEK=y
CONFIG_NLS_MAC_ICELAND=y
CONFIG_NLS_MAC_INUIT=y
# CONFIG_NLS_MAC_ROMANIAN is not set
CONFIG_NLS_MAC_TURKISH=y
CONFIG_NLS_UTF8=y
CONFIG_UNICODE=y
# CONFIG_UNICODE_NORMALIZATION_SELFTEST is not set
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_ENCRYPTED_KEYS is not set
# CONFIG_KEY_DH_OPERATIONS is not set
CONFIG_KEY_NOTIFICATIONS=y
CONFIG_SECURITY_DMESG_RESTRICT=y
# CONFIG_SECURITY is not set
# CONFIG_SECURITYFS is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_FALLBACK=y
# CONFIG_HARDENED_USERCOPY_PAGESPAN is not set
CONFIG_FORTIFY_SOURCE=y
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
# CONFIG_INIT_STACK_NONE is not set
CONFIG_INIT_STACK_ALL_PATTERN=y
# CONFIG_INIT_STACK_ALL_ZERO is not set
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_CRYPTO=y

#
# Crypto core or helper
#
# CONFIG_CRYPTO_FIPS is not set
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=y
# CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
# CONFIG_CRYPTO_MANAGER_EXTRA_TESTS is not set
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=y
# CONFIG_CRYPTO_CRYPTD is not set
CONFIG_CRYPTO_AUTHENC=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
# CONFIG_CRYPTO_DH is not set
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_ECRDSA=y
CONFIG_CRYPTO_SM2=y
CONFIG_CRYPTO_CURVE25519=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
# CONFIG_CRYPTO_AEGIS128 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=y
# CONFIG_CRYPTO_OFB is not set
# CONFIG_CRYPTO_PCBC is not set
# CONFIG_CRYPTO_XTS is not set
CONFIG_CRYPTO_KEYWRAP=y
CONFIG_CRYPTO_NHPOLY1305=y
CONFIG_CRYPTO_ADIANTUM=y
CONFIG_CRYPTO_ESSIV=y

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=y
CONFIG_CRYPTO_VMAC=y

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
# CONFIG_CRYPTO_CRC32 is not set
CONFIG_CRYPTO_XXHASH=y
CONFIG_CRYPTO_BLAKE2B=y
# CONFIG_CRYPTO_BLAKE2S is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MD5_PPC=y
CONFIG_CRYPTO_MICHAEL_MIC=y
# CONFIG_CRYPTO_RMD128 is not set
CONFIG_CRYPTO_RMD160=y
# CONFIG_CRYPTO_RMD256 is not set
# CONFIG_CRYPTO_RMD320 is not set
# CONFIG_CRYPTO_SHA1 is not set
CONFIG_CRYPTO_SHA1_PPC=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=y
CONFIG_CRYPTO_STREEBOG=y
# CONFIG_CRYPTO_TGR192 is not set
CONFIG_CRYPTO_WP512=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_ANUBIS=y
# CONFIG_CRYPTO_ARC4 is not set
# CONFIG_CRYPTO_BLOWFISH is not set
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=y
# CONFIG_CRYPTO_CAST5 is not set
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_KHAZAD=y
# CONFIG_CRYPTO_SALSA20 is not set
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_SEED=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_TEA=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=y
CONFIG_CRYPTO_ZSTD=y

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
# CONFIG_CRYPTO_USER_API_HASH is not set
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
CONFIG_CRYPTO_STATS=y
CONFIG_CRYPTO_HASH_INFO=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
# CONFIG_CRYPTO_LIB_BLAKE2S is not set
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
CONFIG_CRYPTO_LIB_CURVE25519=y
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=y
CONFIG_CRYPTO_LIB_SHA256=y
# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
# CONFIG_X509_CERTIFICATE_PARSER is not set
CONFIG_PKCS8_PRIVATE_KEY_PARSER=y

#
# Certificates for signature checking
#
# CONFIG_SYSTEM_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_LINEAR_RANGES=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
# CONFIG_CORDIC is not set
CONFIG_PRIME_NUMBERS=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_STMP_DEVICE=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=y
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
CONFIG_CRC32_BIT=y
CONFIG_CRC64=y
CONFIG_CRC4=y
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
# CONFIG_XZ_DEC_X86 is not set
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
# CONFIG_XZ_DEC_ARM is not set
# CONFIG_XZ_DEC_ARMTHUMB is not set
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=y
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_BCH=y
CONFIG_BCH_CONST_PARAMS=y
CONFIG_BTREE=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_DMA_DECLARE_COHERENT=y
CONFIG_DMA_API_DEBUG=y
# CONFIG_DMA_API_DEBUG_SG is not set
CONFIG_SGL_ALLOC=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=y
CONFIG_NLATTR=y
CONFIG_GENERIC_ATOMIC64=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_SG_SPLIT=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_MEMREMAP_COMPAT_ALIGN=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_STACKDEPOT=y
CONFIG_PARMAN=y
CONFIG_OBJAGG=y
# CONFIG_STRING_SELFTEST is not set
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_SYMBOLIC_ERRNAME is not set
# CONFIG_DEBUG_BUGVERBOSE is not set
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=1024
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_32B is not set
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
# CONFIG_MAGIC_SYSRQ is not set
CONFIG_DEBUG_FS=y
# CONFIG_DEBUG_FS_ALLOW_ALL is not set
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
CONFIG_DEBUG_FS_ALLOW_NONE=y
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_TRAP is not set
# CONFIG_UBSAN_BOUNDS is not set
CONFIG_UBSAN_MISC=y
# CONFIG_UBSAN_ALIGNMENT is not set
# end of Generic Kernel Debugging Instruments

CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_MISC is not set

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
CONFIG_DEBUG_PAGEALLOC=y
CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT=y
CONFIG_PAGE_OWNER=y
CONFIG_PAGE_POISONING=y
# CONFIG_PAGE_POISONING_NO_SANITY is not set
# CONFIG_PAGE_POISONING_ZERO is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_OBJECTS is not set
CONFIG_SLUB_STATS=y
CONFIG_HAVE_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=16000
# CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF is not set
CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_MEMORY_INIT is not set
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# CONFIG_KASAN is not set
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
# CONFIG_SOFTLOCKUP_DETECTOR is not set
# CONFIG_DETECT_HUNG_TASK is not set
CONFIG_WQ_WATCHDOG=y
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
CONFIG_PROVE_RAW_LOCK_NESTING=y
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_DEBUG_LOCKDEP=y
CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
CONFIG_LOCK_TORTURE_TEST=y
CONFIG_WW_MUTEX_SELFTEST=y
# CONFIG_SCF_TORTURE_TEST is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_STACKTRACE=y
CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
CONFIG_DEBUG_KOBJECT=y

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PLIST=y
CONFIG_DEBUG_SG=y
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
CONFIG_TORTURE_TEST=y
CONFIG_RCU_SCALE_TEST=y
CONFIG_RCU_TORTURE_TEST=y
CONFIG_RCU_REF_SCALE_TEST=y
CONFIG_RCU_CPU_STALL_TIMEOUT=21
# CONFIG_RCU_TRACE is not set
CONFIG_RCU_EQS_DEBUG=y
# end of RCU Debugging

CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
CONFIG_LATENCYTOP=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
# CONFIG_SAMPLES is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
# CONFIG_STRICT_DEVMEM is not set

#
# powerpc Debugging
#
CONFIG_PPC_DISABLE_WERROR=y
CONFIG_PRINT_STACK_DEPTH=64
CONFIG_PPC_EMULATED_STATS=y
CONFIG_CODE_PATCHING_SELFTEST=y
# CONFIG_JUMP_LABEL_FEATURE_CHECKS is not set
CONFIG_FTR_FIXUP_SELFTEST=y
CONFIG_MSI_BITMAP_SELFTEST=y
# CONFIG_PPC_IRQ_SOFT_MASK_DEBUG is not set
# CONFIG_XMON is not set
# CONFIG_BDI_SWITCH is not set
# CONFIG_BOOTX_TEXT is not set
# CONFIG_PPC_EARLY_DEBUG is not set
# CONFIG_PPC_PTDUMP is not set
# end of powerpc Debugging

#
# Kernel Testing and Coverage
#
CONFIG_KUNIT=y
CONFIG_KUNIT_DEBUGFS=y
CONFIG_KUNIT_TEST=y
CONFIG_KUNIT_EXAMPLE_TEST=y
CONFIG_KUNIT_ALL_TESTS=y
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_PM_NOTIFIER_ERROR_INJECT=y
CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT=y
CONFIG_NETDEV_NOTIFIER_ERROR_INJECT=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
# CONFIG_RUNTIME_TESTING_MENU is not set
CONFIG_MEMTEST=y
# end of Kernel Testing and Coverage

# CONFIG_WARN_MISSING_DOCUMENTS is not set
# CONFIG_WARN_ABI_ERRORS is not set
# end of Kernel hacking

--v29I7G6zRZmhEUUb--
