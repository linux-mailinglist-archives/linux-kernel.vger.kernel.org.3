Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A894E46890A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 05:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbhLEETs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 23:19:48 -0500
Received: from mga17.intel.com ([192.55.52.151]:31887 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229557AbhLEETr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 23:19:47 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10188"; a="217848531"
X-IronPort-AV: E=Sophos;i="5.87,288,1631602800"; 
   d="scan'208";a="217848531"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2021 20:16:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,288,1631602800"; 
   d="scan'208";a="461429476"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 04 Dec 2021 20:16:19 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mtiwk-000Jmt-QD; Sun, 05 Dec 2021 04:16:18 +0000
Date:   Sun, 5 Dec 2021 12:15:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tianyu Lan <Tianyu.Lan@microsoft.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: arch/x86/hyperv/ivm.c:39:30: sparse: sparse: incorrect type in
 initializer (different address spaces)
Message-ID: <202112051255.MPUcV06E-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   79a72162048e42a677bc7336a9f5d86fc3ff9558
commit: faff44069ff538ccdfef187c4d7ec83d22dfb3a4 x86/hyperv: Add Write/Read MSR registers via ghcb page
date:   5 weeks ago
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20211205/202112051255.MPUcV06E-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=faff44069ff538ccdfef187c4d7ec83d22dfb3a4
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout faff44069ff538ccdfef187c4d7ec83d22dfb3a4
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/hyperv/ drivers/hv/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/x86/hyperv/ivm.c:39:30: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got union hv_ghcb [noderef] __percpu ** @@
   arch/x86/hyperv/ivm.c:39:30: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/x86/hyperv/ivm.c:39:30: sparse:     got union hv_ghcb [noderef] __percpu **
   arch/x86/hyperv/ivm.c:74:30: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got union hv_ghcb [noderef] __percpu ** @@
   arch/x86/hyperv/ivm.c:74:30: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/x86/hyperv/ivm.c:74:30: sparse:     got union hv_ghcb [noderef] __percpu **
   arch/x86/hyperv/ivm.c:154:25: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu ** @@
   arch/x86/hyperv/ivm.c:154:25: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/x86/hyperv/ivm.c:154:25: sparse:     got void [noderef] __percpu **
--
   drivers/hv/vmbus_drv.c: note: in included file (through arch/x86/include/asm/msr.h, arch/x86/include/asm/processor.h, arch/x86/include/asm/timex.h, ...):
>> arch/x86/include/asm/paravirt.h:221:9: sparse: sparse: cast truncates bits from constant value (c000000000100000 becomes 100000)
   arch/x86/include/asm/paravirt.h:221:9: sparse: sparse: cast truncates bits from constant value (c000000000000000 becomes 0)

vim +39 arch/x86/hyperv/ivm.c

    25	
    26	void hv_ghcb_msr_write(u64 msr, u64 value)
    27	{
    28		union hv_ghcb *hv_ghcb;
    29		void **ghcb_base;
    30		unsigned long flags;
    31		struct es_em_ctxt ctxt;
    32	
    33		if (!hv_ghcb_pg)
    34			return;
    35	
    36		WARN_ON(in_nmi());
    37	
    38		local_irq_save(flags);
  > 39		ghcb_base = (void **)this_cpu_ptr(hv_ghcb_pg);
    40		hv_ghcb = (union hv_ghcb *)*ghcb_base;
    41		if (!hv_ghcb) {
    42			local_irq_restore(flags);
    43			return;
    44		}
    45	
    46		ghcb_set_rcx(&hv_ghcb->ghcb, msr);
    47		ghcb_set_rax(&hv_ghcb->ghcb, lower_32_bits(value));
    48		ghcb_set_rdx(&hv_ghcb->ghcb, upper_32_bits(value));
    49	
    50		if (sev_es_ghcb_hv_call(&hv_ghcb->ghcb, false, &ctxt,
    51					SVM_EXIT_MSR, 1, 0))
    52			pr_warn("Fail to write msr via ghcb %llx.\n", msr);
    53	
    54		local_irq_restore(flags);
    55	}
    56	EXPORT_SYMBOL_GPL(hv_ghcb_msr_write);
    57	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
