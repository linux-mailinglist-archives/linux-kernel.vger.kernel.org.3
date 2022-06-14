Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B920A54B535
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 18:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234919AbiFNP7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 11:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355599AbiFNP6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 11:58:41 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB25C1F2C4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 08:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655222320; x=1686758320;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zVy8k8Vyusp4OzMae6bFcOlJglqMzolduq7h82yYWgY=;
  b=XpE+7B/vaSwa7ielZ0FnX6xM8lgzJ093IgMn+5B/JMZYt5814/1bk+kE
   r0mwEkRUwMPwcktTZRpTf3tL5F3SgzVtRKJMRYrEe5I0U+6sog/nNppzN
   b12JWKVOUoiTLGQm7dK9dcMTRKJMP26+PzycOS8OQj+Bx6t/HZHKwYNxG
   A+cKEthb4XOeNh8nxLEn6psFD7B6FAXqMQBsml8voZro9kRaTePhucmaN
   f2mGrRNx837rdcKi0ST1QXPoIOjkHRn7cFVjaxjj37lJ5jyOGS+3cKH0M
   NF3rsEqqCOlP6YpsSj5WFFJ5yxWCnH/tzArkSUu9Wc9Rn4SXcLTq+TOmm
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="278699701"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="278699701"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 08:58:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="588544173"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 14 Jun 2022 08:58:39 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o18wA-000M4P-RY;
        Tue, 14 Jun 2022 15:58:38 +0000
Date:   Tue, 14 Jun 2022 23:58:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: arch/powerpc/kvm/book3s_xive.c:51:15: sparse: sparse: cast to
 restricted __be16
Message-ID: <202206142322.McgZGdEj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3
commit: b22af9041927075b82bcaf4b6c7a354688198d47 KVM: PPC: Book3s: Remove real mode interrupt controller hcalls handlers
date:   4 weeks ago
config: powerpc64-randconfig-s032-20220613 (https://download.01.org/0day-ci/archive/20220614/202206142322.McgZGdEj-lkp@intel.com/config)
compiler: powerpc64le-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-30-g92122700-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b22af9041927075b82bcaf4b6c7a354688198d47
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout b22af9041927075b82bcaf4b6c7a354688198d47
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/kvm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/powerpc/kvm/book3s_xive.c:51:15: sparse: sparse: cast to restricted __be16
>> arch/powerpc/kvm/book3s_xive.c:357:41: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __be64 [usertype] qw1 @@     got unsigned long @@
   arch/powerpc/kvm/book3s_xive.c:357:41: sparse:     expected restricted __be64 [usertype] qw1
   arch/powerpc/kvm/book3s_xive.c:357:41: sparse:     got unsigned long
   arch/powerpc/kvm/book3s_xive.c:701:57: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long v @@     got restricted __be64 [usertype] w01 @@
   arch/powerpc/kvm/book3s_xive.c:701:57: sparse:     expected unsigned long v
   arch/powerpc/kvm/book3s_xive.c:701:57: sparse:     got restricted __be64 [usertype] w01
   arch/powerpc/kvm/book3s_xive.c:702:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int v @@     got restricted __be32 [usertype] xive_cam_word @@
   arch/powerpc/kvm/book3s_xive.c:702:32: sparse:     expected unsigned int v
   arch/powerpc/kvm/book3s_xive.c:702:32: sparse:     got restricted __be32 [usertype] xive_cam_word
   arch/powerpc/kvm/book3s_xive.c:774:49: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be64 [usertype] w01 @@     got unsigned long @@
   arch/powerpc/kvm/book3s_xive.c:774:49: sparse:     expected restricted __be64 [usertype] w01
   arch/powerpc/kvm/book3s_xive.c:774:49: sparse:     got unsigned long

vim +51 arch/powerpc/kvm/book3s_xive.c

    38	
    39	static void xive_vm_ack_pending(struct kvmppc_xive_vcpu *xc)
    40	{
    41		u8 cppr;
    42		u16 ack;
    43	
    44		/*
    45		 * Ensure any previous store to CPPR is ordered vs.
    46		 * the subsequent loads from PIPR or ACK.
    47		 */
    48		eieio();
    49	
    50		/* Perform the acknowledge OS to register cycle. */
  > 51		ack = be16_to_cpu(__raw_readw(xive_tima + TM_SPC_ACK_OS_REG));
    52	
    53		/* Synchronize subsequent queue accesses */
    54		mb();
    55	
    56		/* XXX Check grouping level */
    57	
    58		/* Anything ? */
    59		if (!((ack >> 8) & TM_QW1_NSR_EO))
    60			return;
    61	
    62		/* Grab CPPR of the most favored pending interrupt */
    63		cppr = ack & 0xff;
    64		if (cppr < 8)
    65			xc->pending |= 1 << cppr;
    66	
    67		/* Check consistency */
    68		if (cppr >= xc->hw_cppr)
    69			pr_warn("KVM-XIVE: CPU %d odd ack CPPR, got %d at %d\n",
    70				smp_processor_id(), cppr, xc->hw_cppr);
    71	
    72		/*
    73		 * Update our image of the HW CPPR. We don't yet modify
    74		 * xc->cppr, this will be done as we scan for interrupts
    75		 * in the queues.
    76		 */
    77		xc->hw_cppr = cppr;
    78	}
    79	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
