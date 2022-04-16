Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2255032E7
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiDPFe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 01:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiDPFeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 01:34:23 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E994610EC52
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 22:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650087112; x=1681623112;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rLPtG68LKPVQQ2lNZup3QBG+A11ilTtoScYVnIjD3QE=;
  b=IzUG0xHqiIK/pcYT9wzealKtOhim+7j/e0tC3o9XzUjsRPoXvqHSRizB
   aM3QcFI8YlV0IHtEpzjUnUtXZ1VwX2FqqxyZGAja+kvfTu0MJQswi3Z43
   7QECO0lJwzo0aYsvHVhpxpbwcahoU3nuI6FHQXx075ElMMD2j61kE4VcZ
   ctUCR+8gHp9GgoEcSuW6TeGcm2UV3PxuioI5YPB+tO6OH/mnxVxPyD28u
   NiBpUvGAIBzOQImOvjtEpQzd+FotcWbsP8Ym+BHB2dIwRCcWTXbHEp6PG
   JJ+5LhuRM5HL7HM3cHR2ePHEuq0Sg7BtqKNrWU0j6Ch2QECkTUy/c7zKM
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="243201045"
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="243201045"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 22:31:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="662654045"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 15 Apr 2022 22:31:50 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfb2E-0002p3-8O;
        Sat, 16 Apr 2022 05:31:50 +0000
Date:   Sat, 16 Apr 2022 13:30:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/fixes 1/4] do_mounts.c:(.text+0x5): multiple
 definition of `kallsyms_lookup_names'; init/main.o:main.c:(.text+0x32):
 first defined here
Message-ID: <202204161311.5fyXs0HO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/fixes
head:   ba203a35f44376540c3c5dd72bf9ba0b9cfc4473
commit: c42ec4e0334aacc783148e3571f3e0db53e4220a [1/4] kallsyms: Add kallsyms_lookup_names function
config: i386-tinyconfig (https://download.01.org/0day-ci/archive/20220416/202204161311.5fyXs0HO-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=c42ec4e0334aacc783148e3571f3e0db53e4220a
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/fixes
        git checkout c42ec4e0334aacc783148e3571f3e0db53e4220a
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: init/do_mounts.o: in function `kallsyms_lookup_names':
>> do_mounts.c:(.text+0x5): multiple definition of `kallsyms_lookup_names'; init/main.o:main.c:(.text+0x32): first defined here
   ld: init/noinitramfs.o: in function `kallsyms_lookup_names':
   noinitramfs.c:(.text+0x0): multiple definition of `kallsyms_lookup_names'; init/main.o:main.c:(.text+0x32): first defined here
   ld: init/init_task.o: in function `kallsyms_lookup_names':
   init_task.c:(.text+0x0): multiple definition of `kallsyms_lookup_names'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/entry/syscall_32.o: in function `kallsyms_lookup_names':
   syscall_32.c:(.text+0x0): multiple definition of `kallsyms_lookup_names'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/entry/common.o: in function `kallsyms_lookup_names':
   common.c:(.text+0x0): multiple definition of `kallsyms_lookup_names'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/entry/vdso/extable.o: in function `kallsyms_lookup_names':
   extable.c:(.text+0x0): multiple definition of `kallsyms_lookup_names'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/events/core.o: in function `kallsyms_lookup_names':
   core.c:(.text+0x9da): multiple definition of `kallsyms_lookup_names'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/events/amd/core.o: in function `kallsyms_lookup_names':
   core.c:(.text+0x71c): multiple definition of `kallsyms_lookup_names'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/events/intel/core.o: in function `kallsyms_lookup_names':
   core.c:(.text+0x1e5a): multiple definition of `kallsyms_lookup_names'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/events/intel/bts.o: in function `kallsyms_lookup_names':
   bts.c:(.text+0x6de): multiple definition of `kallsyms_lookup_names'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/events/intel/ds.o: in function `kallsyms_lookup_names':
   ds.c:(.text+0x14cf): multiple definition of `kallsyms_lookup_names'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/events/intel/knc.o: in function `kallsyms_lookup_names':
   knc.c:(.text+0x2b2): multiple definition of `kallsyms_lookup_names'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/events/intel/lbr.o: in function `kallsyms_lookup_names':
   lbr.c:(.text+0x8ce): multiple definition of `kallsyms_lookup_names'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/events/intel/p4.o: in function `kallsyms_lookup_names':
   p4.c:(.text+0x5c6): multiple definition of `kallsyms_lookup_names'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/events/intel/p6.o: in function `kallsyms_lookup_names':
   p6.c:(.text+0xcb): multiple definition of `kallsyms_lookup_names'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/events/intel/pt.o: in function `kallsyms_lookup_names':
   pt.c:(.text+0x829): multiple definition of `kallsyms_lookup_names'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/events/zhaoxin/core.o: in function `kallsyms_lookup_names':
   core.c:(.text+0x486): multiple definition of `kallsyms_lookup_names'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/kernel/process_32.o: in function `kallsyms_lookup_names':
   process_32.c:(.text+0x0): multiple definition of `kallsyms_lookup_names'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/kernel/signal.o: in function `kallsyms_lookup_names':
   signal.c:(.text+0x5aa): multiple definition of `kallsyms_lookup_names'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/kernel/traps.o: in function `kallsyms_lookup_names':
   traps.c:(.text+0x2ce): multiple definition of `kallsyms_lookup_names'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/kernel/idt.o: in function `kallsyms_lookup_names':
   idt.c:(.text+0x0): multiple definition of `kallsyms_lookup_names'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/kernel/irq.o: in function `kallsyms_lookup_names':
   irq.c:(.text+0x4f): multiple definition of `kallsyms_lookup_names'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/kernel/dumpstack_32.o: in function `kallsyms_lookup_names':
   dumpstack_32.c:(.text+0x0): multiple definition of `kallsyms_lookup_names'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/kernel/ioport.o: in function `kallsyms_lookup_names':
   ioport.c:(.text+0x0): multiple definition of `kallsyms_lookup_names'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/kernel/dumpstack.o: in function `kallsyms_lookup_names':
   dumpstack.c:(.text+0x11e): multiple definition of `kallsyms_lookup_names'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/kernel/nmi.o: in function `kallsyms_lookup_names':
   nmi.c:(.text+0x74): multiple definition of `kallsyms_lookup_names'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/kernel/setup.o: in function `kallsyms_lookup_names':
   setup.c:(.text+0x3): multiple definition of `kallsyms_lookup_names'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/kernel/irqinit.o: in function `kallsyms_lookup_names':
   irqinit.c:(.text+0x0): multiple definition of `kallsyms_lookup_names'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/kernel/irq_work.o: in function `kallsyms_lookup_names':
   irq_work.c:(.text+0x0): multiple definition of `kallsyms_lookup_names'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/kernel/sys_ia32.o: in function `kallsyms_lookup_names':
   sys_ia32.c:(.text+0x0): multiple definition of `kallsyms_lookup_names'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/kernel/alternative.o: in function `kallsyms_lookup_names':
   alternative.c:(.text+0x304): multiple definition of `kallsyms_lookup_names'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/kernel/hw_breakpoint.o: in function `kallsyms_lookup_names':
   hw_breakpoint.c:(.text+0x165): multiple definition of `kallsyms_lookup_names'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/kernel/pci-iommu_table.o: in function `kallsyms_lookup_names':
   pci-iommu_table.c:(.text+0x0): multiple definition of `kallsyms_lookup_names'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/kernel/process.o: in function `kallsyms_lookup_names':
   process.c:(.text+0xce): multiple definition of `kallsyms_lookup_names'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/kernel/fpu/core.o: in function `kallsyms_lookup_names':
   core.c:(.text+0x71): multiple definition of `kallsyms_lookup_names'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/kernel/ptrace.o: in function `kallsyms_lookup_names':
   ptrace.c:(.text+0x5bf): multiple definition of `kallsyms_lookup_names'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/kernel/tls.o: in function `kallsyms_lookup_names':
   tls.c:(.text+0x26f): multiple definition of `kallsyms_lookup_names'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/kernel/stacktrace.o: in function `kallsyms_lookup_names':
   stacktrace.c:(.text+0x2d): multiple definition of `kallsyms_lookup_names'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/kernel/cpu/common.o: in function `kallsyms_lookup_names':
   common.c:(.text+0x1ff): multiple definition of `kallsyms_lookup_names'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/kernel/cpu/bugs.o: in function `kallsyms_lookup_names':
   bugs.c:(.text+0xb9): multiple definition of `kallsyms_lookup_names'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/kernel/cpu/intel.o: in function `kallsyms_lookup_names':
   intel.c:(.text+0xa28): multiple definition of `kallsyms_lookup_names'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/kernel/apic/hw_nmi.o: in function `kallsyms_lookup_names':
   hw_nmi.c:(.text+0x0): multiple definition of `kallsyms_lookup_names'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/kernel/doublefault_32.o: in function `kallsyms_lookup_names':
   doublefault_32.c:(.text+0x4c): multiple definition of `kallsyms_lookup_names'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/kernel/perf_regs.o: in function `kallsyms_lookup_names':
   perf_regs.c:(.text+0x0): multiple definition of `kallsyms_lookup_names'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/kernel/unwind_guess.o: in function `kallsyms_lookup_names':
   unwind_guess.c:(.text+0x0): multiple definition of `kallsyms_lookup_names'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/mm/fault.o: in function `kallsyms_lookup_names':
   fault.c:(.text+0x897): multiple definition of `kallsyms_lookup_names'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/mm/extable.o: in function `kallsyms_lookup_names':
   extable.c:(.text+0x79): multiple definition of `kallsyms_lookup_names'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/mm/cpu_entry_area.o: in function `kallsyms_lookup_names':
   cpu_entry_area.c:(.text+0x0): multiple definition of `kallsyms_lookup_names'; init/main.o:main.c:(.text+0x32): first defined here
   ld: kernel/fork.o: in function `kallsyms_lookup_names':
   fork.c:(.text+0x568): multiple definition of `kallsyms_lookup_names'; init/main.o:main.c:(.text+0x32): first defined here
   ld: kernel/exec_domain.o: in function `kallsyms_lookup_names':
   exec_domain.c:(.text+0x0): multiple definition of `kallsyms_lookup_names'; init/main.o:main.c:(.text+0x32): first defined here
   ld: kernel/panic.o: in function `kallsyms_lookup_names':
   panic.c:(.text+0x73): multiple definition of `kallsyms_lookup_names'; init/main.o:main.c:(.text+0x32): first defined here

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
