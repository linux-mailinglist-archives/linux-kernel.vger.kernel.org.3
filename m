Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362CD54A939
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 08:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343551AbiFNGI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 02:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344415AbiFNGIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 02:08:19 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB68EE0B2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 23:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655186897; x=1686722897;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zE9NR3r7fgtr8+ItHBiDxWn/rDAjU6DXUqB0nZ5KxXo=;
  b=NT/zqxhiqzwr/UqWwG2kTNd5RUjAtqzl9sdPPqtyRdi6Ni2xdgXIXi4j
   eNqp6y50z318aXyVjMeIN3zDO37vdP451I6FYgg9yMMeOfueLuuuwOYsN
   hzE6Iw4Zud0z0hGHOnbNpqIZqk2JV62jVi4DiplPdGql5B19mTAa3Vbf2
   QiGuuaLAph1HWxFeqADCFQDULg2ASIBSNNW4D71ZlMeqDElERvvUIoQ9H
   xVq0NLvvgnVMAzR4OfKgZp5IxGkx/9irlQ4MAaLDkvNR1GVy/e/z2DMP4
   +diaJzW18MIJ9fJNQ0OTt/jA5apwsDRpzn/SAjN8GkhdBNCd7cE0xXEGI
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="258349376"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="258349376"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 23:08:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="588242463"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 13 Jun 2022 23:08:16 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0zip-000LYL-RA;
        Tue, 14 Jun 2022 06:08:15 +0000
Date:   Tue, 14 Jun 2022 14:08:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: arch/powerpc/kvm/book3s_hv_builtin.c:419:22: sparse: sparse:
 incorrect type in assignment (different base types)
Message-ID: <202206141321.MvbHDOEn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3
commit: 2ce008c8b25467ceacf45bcf0e183d660edb82f2 KVM: PPC: Book3S HV: Remove unused nested HV tests in XICS emulation
date:   1 year ago
config: powerpc64-randconfig-s032-20220613 (https://download.01.org/0day-ci/archive/20220614/202206141321.MvbHDOEn-lkp@intel.com/config)
compiler: powerpc64le-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-30-g92122700-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2ce008c8b25467ceacf45bcf0e183d660edb82f2
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 2ce008c8b25467ceacf45bcf0e183d660edb82f2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/kvm/ arch/powerpc/platforms/powernv/ kernel/sched/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   arch/powerpc/kvm/book3s_hv_builtin.c:417:41: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] *out_xirr @@     got restricted __be32 * @@
   arch/powerpc/kvm/book3s_hv_builtin.c:417:41: sparse:     expected unsigned int [usertype] *out_xirr
   arch/powerpc/kvm/book3s_hv_builtin.c:417:41: sparse:     got restricted __be32 *
>> arch/powerpc/kvm/book3s_hv_builtin.c:419:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [addressable] [usertype] xirr @@     got unsigned int @@
   arch/powerpc/kvm/book3s_hv_builtin.c:419:22: sparse:     expected restricted __be32 [addressable] [usertype] xirr
   arch/powerpc/kvm/book3s_hv_builtin.c:419:22: sparse:     got unsigned int
>> arch/powerpc/kvm/book3s_hv_builtin.c:450:41: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [addressable] [usertype] xirr @@
   arch/powerpc/kvm/book3s_hv_builtin.c:450:41: sparse:     expected unsigned int [usertype] val
   arch/powerpc/kvm/book3s_hv_builtin.c:450:41: sparse:     got restricted __be32 [addressable] [usertype] xirr
   arch/powerpc/kvm/book3s_hv_builtin.c: note: in included file:
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:962:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] srr0 @@     got restricted __be64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:962:1: sparse:     expected unsigned long long [usertype] srr0
   arch/powerpc/include/asm/kvm_ppc.h:962:1: sparse:     got restricted __be64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:962:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] srr0 @@     got restricted __le64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:962:1: sparse:     expected unsigned long long [usertype] srr0
   arch/powerpc/include/asm/kvm_ppc.h:962:1: sparse:     got restricted __le64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:963:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] srr1 @@     got restricted __be64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:963:1: sparse:     expected unsigned long long [usertype] srr1
   arch/powerpc/include/asm/kvm_ppc.h:963:1: sparse:     got restricted __be64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:963:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] srr1 @@     got restricted __le64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:963:1: sparse:     expected unsigned long long [usertype] srr1
   arch/powerpc/include/asm/kvm_ppc.h:963:1: sparse:     got restricted __le64 [usertype]

vim +419 arch/powerpc/kvm/book3s_hv_builtin.c

f725758b899f11 Paul Mackerras         2016-11-18  395  
f725758b899f11 Paul Mackerras         2016-11-18  396  static long kvmppc_read_one_intr(bool *again)
37f55d30df2eef Suresh Warrier         2016-08-19  397  {
d381d7caf812f7 Benjamin Herrenschmidt 2017-04-05  398  	void __iomem *xics_phys;
37f55d30df2eef Suresh Warrier         2016-08-19  399  	u32 h_xirr;
37f55d30df2eef Suresh Warrier         2016-08-19  400  	__be32 xirr;
37f55d30df2eef Suresh Warrier         2016-08-19  401  	u32 xisr;
37f55d30df2eef Suresh Warrier         2016-08-19  402  	u8 host_ipi;
f725758b899f11 Paul Mackerras         2016-11-18  403  	int64_t rc;
37f55d30df2eef Suresh Warrier         2016-08-19  404  
5af50993850a48 Benjamin Herrenschmidt 2017-04-05  405  	if (xive_enabled())
5af50993850a48 Benjamin Herrenschmidt 2017-04-05  406  		return 1;
5af50993850a48 Benjamin Herrenschmidt 2017-04-05  407  
37f55d30df2eef Suresh Warrier         2016-08-19  408  	/* see if a host IPI is pending */
37f55d30df2eef Suresh Warrier         2016-08-19  409  	host_ipi = local_paca->kvm_hstate.host_ipi;
37f55d30df2eef Suresh Warrier         2016-08-19  410  	if (host_ipi)
37f55d30df2eef Suresh Warrier         2016-08-19  411  		return 1;
37f55d30df2eef Suresh Warrier         2016-08-19  412  
37f55d30df2eef Suresh Warrier         2016-08-19  413  	/* Now read the interrupt from the ICP */
37f55d30df2eef Suresh Warrier         2016-08-19  414  	xics_phys = local_paca->kvm_hstate.xics_phys;
53af3ba2e8195f Paul Mackerras         2017-01-30  415  	rc = 0;
ab9bad0ead9ab1 Benjamin Herrenschmidt 2017-02-07  416  	if (!xics_phys)
53af3ba2e8195f Paul Mackerras         2017-01-30  417  		rc = opal_int_get_xirr(&xirr, false);
53af3ba2e8195f Paul Mackerras         2017-01-30  418  	else
d381d7caf812f7 Benjamin Herrenschmidt 2017-04-05 @419  		xirr = __raw_rm_readl(xics_phys + XICS_XIRR);
f725758b899f11 Paul Mackerras         2016-11-18  420  	if (rc < 0)
37f55d30df2eef Suresh Warrier         2016-08-19  421  		return 1;
37f55d30df2eef Suresh Warrier         2016-08-19  422  
37f55d30df2eef Suresh Warrier         2016-08-19  423  	/*
37f55d30df2eef Suresh Warrier         2016-08-19  424  	 * Save XIRR for later. Since we get control in reverse endian
37f55d30df2eef Suresh Warrier         2016-08-19  425  	 * on LE systems, save it byte reversed and fetch it back in
37f55d30df2eef Suresh Warrier         2016-08-19  426  	 * host endian. Note that xirr is the value read from the
37f55d30df2eef Suresh Warrier         2016-08-19  427  	 * XIRR register, while h_xirr is the host endian version.
37f55d30df2eef Suresh Warrier         2016-08-19  428  	 */
37f55d30df2eef Suresh Warrier         2016-08-19  429  	h_xirr = be32_to_cpu(xirr);
37f55d30df2eef Suresh Warrier         2016-08-19  430  	local_paca->kvm_hstate.saved_xirr = h_xirr;
37f55d30df2eef Suresh Warrier         2016-08-19  431  	xisr = h_xirr & 0xffffff;
37f55d30df2eef Suresh Warrier         2016-08-19  432  	/*
37f55d30df2eef Suresh Warrier         2016-08-19  433  	 * Ensure that the store/load complete to guarantee all side
37f55d30df2eef Suresh Warrier         2016-08-19  434  	 * effects of loading from XIRR has completed
37f55d30df2eef Suresh Warrier         2016-08-19  435  	 */
37f55d30df2eef Suresh Warrier         2016-08-19  436  	smp_mb();
37f55d30df2eef Suresh Warrier         2016-08-19  437  
37f55d30df2eef Suresh Warrier         2016-08-19  438  	/* if nothing pending in the ICP */
37f55d30df2eef Suresh Warrier         2016-08-19  439  	if (!xisr)
37f55d30df2eef Suresh Warrier         2016-08-19  440  		return 0;
37f55d30df2eef Suresh Warrier         2016-08-19  441  
37f55d30df2eef Suresh Warrier         2016-08-19  442  	/* We found something in the ICP...
37f55d30df2eef Suresh Warrier         2016-08-19  443  	 *
37f55d30df2eef Suresh Warrier         2016-08-19  444  	 * If it is an IPI, clear the MFRR and EOI it.
37f55d30df2eef Suresh Warrier         2016-08-19  445  	 */
37f55d30df2eef Suresh Warrier         2016-08-19  446  	if (xisr == XICS_IPI) {
53af3ba2e8195f Paul Mackerras         2017-01-30  447  		rc = 0;
2ce008c8b25467 Nicholas Piggin        2021-05-28  448  		if (xics_phys) {
d381d7caf812f7 Benjamin Herrenschmidt 2017-04-05  449  			__raw_rm_writeb(0xff, xics_phys + XICS_MFRR);
d381d7caf812f7 Benjamin Herrenschmidt 2017-04-05 @450  			__raw_rm_writel(xirr, xics_phys + XICS_XIRR);
f725758b899f11 Paul Mackerras         2016-11-18  451  		} else {
ab9bad0ead9ab1 Benjamin Herrenschmidt 2017-02-07  452  			opal_int_set_mfrr(hard_smp_processor_id(), 0xff);
ab9bad0ead9ab1 Benjamin Herrenschmidt 2017-02-07  453  			rc = opal_int_eoi(h_xirr);
53af3ba2e8195f Paul Mackerras         2017-01-30  454  		}
f725758b899f11 Paul Mackerras         2016-11-18  455  		/* If rc > 0, there is another interrupt pending */
f725758b899f11 Paul Mackerras         2016-11-18  456  		*again = rc > 0;
f725758b899f11 Paul Mackerras         2016-11-18  457  
37f55d30df2eef Suresh Warrier         2016-08-19  458  		/*
37f55d30df2eef Suresh Warrier         2016-08-19  459  		 * Need to ensure side effects of above stores
37f55d30df2eef Suresh Warrier         2016-08-19  460  		 * complete before proceeding.
37f55d30df2eef Suresh Warrier         2016-08-19  461  		 */
37f55d30df2eef Suresh Warrier         2016-08-19  462  		smp_mb();
37f55d30df2eef Suresh Warrier         2016-08-19  463  
37f55d30df2eef Suresh Warrier         2016-08-19  464  		/*
37f55d30df2eef Suresh Warrier         2016-08-19  465  		 * We need to re-check host IPI now in case it got set in the
37f55d30df2eef Suresh Warrier         2016-08-19  466  		 * meantime. If it's clear, we bounce the interrupt to the
37f55d30df2eef Suresh Warrier         2016-08-19  467  		 * guest
37f55d30df2eef Suresh Warrier         2016-08-19  468  		 */
37f55d30df2eef Suresh Warrier         2016-08-19  469  		host_ipi = local_paca->kvm_hstate.host_ipi;
37f55d30df2eef Suresh Warrier         2016-08-19  470  		if (unlikely(host_ipi != 0)) {
37f55d30df2eef Suresh Warrier         2016-08-19  471  			/* We raced with the host,
37f55d30df2eef Suresh Warrier         2016-08-19  472  			 * we need to resend that IPI, bummer
37f55d30df2eef Suresh Warrier         2016-08-19  473  			 */
2ce008c8b25467 Nicholas Piggin        2021-05-28  474  			if (xics_phys)
d381d7caf812f7 Benjamin Herrenschmidt 2017-04-05  475  				__raw_rm_writeb(IPI_PRIORITY,
d381d7caf812f7 Benjamin Herrenschmidt 2017-04-05  476  						xics_phys + XICS_MFRR);
f725758b899f11 Paul Mackerras         2016-11-18  477  			else
ab9bad0ead9ab1 Benjamin Herrenschmidt 2017-02-07  478  				opal_int_set_mfrr(hard_smp_processor_id(),
f725758b899f11 Paul Mackerras         2016-11-18  479  						  IPI_PRIORITY);
37f55d30df2eef Suresh Warrier         2016-08-19  480  			/* Let side effects complete */
37f55d30df2eef Suresh Warrier         2016-08-19  481  			smp_mb();
37f55d30df2eef Suresh Warrier         2016-08-19  482  			return 1;
37f55d30df2eef Suresh Warrier         2016-08-19  483  		}
37f55d30df2eef Suresh Warrier         2016-08-19  484  
37f55d30df2eef Suresh Warrier         2016-08-19  485  		/* OK, it's an IPI for us */
37f55d30df2eef Suresh Warrier         2016-08-19  486  		local_paca->kvm_hstate.saved_xirr = 0;
37f55d30df2eef Suresh Warrier         2016-08-19  487  		return -1;
37f55d30df2eef Suresh Warrier         2016-08-19  488  	}
37f55d30df2eef Suresh Warrier         2016-08-19  489  
f725758b899f11 Paul Mackerras         2016-11-18  490  	return kvmppc_check_passthru(xisr, xirr, again);
37f55d30df2eef Suresh Warrier         2016-08-19  491  }
5af50993850a48 Benjamin Herrenschmidt 2017-04-05  492  

:::::: The code at line 419 was first introduced by commit
:::::: d381d7caf812f7aa9f05cfeb858c9004ac654412 powerpc: Consolidate variants of real-mode MMIOs

:::::: TO: Benjamin Herrenschmidt <benh@kernel.crashing.org>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
