Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A2E54A7A8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 05:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348593AbiFNDvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 23:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiFNDvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 23:51:16 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9081BEB3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 20:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655178675; x=1686714675;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kEg7uOhfXo9ddWlHnx0SZS9c0JPMDXJoPAXbcxDBfT4=;
  b=iOMdbSpiPMMh9wl5vluHHSmiDS7kvwHjxFka5R3VyINO9lFkGp5NPRG7
   cb1YxKntpBYrVRm/QM4eXjK5ZXV2hCMwLGZwk6otoHSuzxb7n6YYwczKe
   qi2a/9dTZ5KTLHQsW/MYJ8XfljHC5ruGCTYQufmd/oCQuVZqllkjZR/jD
   fqjxAnPdMLLqTPPu3vRhqTRDqOzMCapZBD9tLbVtIq0KRlE/9OuMS3HTi
   O5Jt75xc2n8vq+SdJXUEpcK7sogYRxxnZAtjPV+6Wc3VES7FnlwfX66e1
   cZgr3nU1jq+yTnWTjsZj37Jx19czh0SHORzt18mp6Acn9ohY1N04KHxsh
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="258323556"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="258323556"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 20:51:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="558137413"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 13 Jun 2022 20:51:13 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0xaC-000LRr-BF;
        Tue, 14 Jun 2022 03:51:12 +0000
Date:   Tue, 14 Jun 2022 11:50:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: arch/powerpc/kvm/book3s_xive.c:151:41: sparse: sparse: incorrect
 type in assignment (different base types)
Message-ID: <202206141155.emjWGbvB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3
commit: 023c3c96ca4d196c09d554d5a98900406e4d7ecb KVM: PPC: Book3S HV P9: implement kvmppc_xive_pull_vcpu in C
date:   1 year ago
config: powerpc64-randconfig-s032-20220613 (https://download.01.org/0day-ci/archive/20220614/202206141155.emjWGbvB-lkp@intel.com/config)
compiler: powerpc64le-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-30-g92122700-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=023c3c96ca4d196c09d554d5a98900406e4d7ecb
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 023c3c96ca4d196c09d554d5a98900406e4d7ecb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/kvm/ arch/powerpc/platforms/powernv/ kernel/sched/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   arch/powerpc/kvm/book3s_xive.c: note: in included file:
   arch/powerpc/kvm/book3s_xive_template.c:26:15: sparse: sparse: cast to restricted __be16
   arch/powerpc/kvm/book3s_xive_template.c:339:39: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __be64 [usertype] qw1 @@     got unsigned long @@
   arch/powerpc/kvm/book3s_xive_template.c:339:39: sparse:     expected restricted __be64 [usertype] qw1
   arch/powerpc/kvm/book3s_xive_template.c:339:39: sparse:     got unsigned long
   arch/powerpc/kvm/book3s_xive.c:79:49: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long v @@     got restricted __be64 [usertype] w01 @@
   arch/powerpc/kvm/book3s_xive.c:79:49: sparse:     expected unsigned long v
   arch/powerpc/kvm/book3s_xive.c:79:49: sparse:     got restricted __be64 [usertype] w01
   arch/powerpc/kvm/book3s_xive.c:80:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int v @@     got restricted __be32 [usertype] xive_cam_word @@
   arch/powerpc/kvm/book3s_xive.c:80:32: sparse:     expected unsigned int v
   arch/powerpc/kvm/book3s_xive.c:80:32: sparse:     got restricted __be32 [usertype] xive_cam_word
>> arch/powerpc/kvm/book3s_xive.c:151:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be64 [usertype] w01 @@     got unsigned long @@
   arch/powerpc/kvm/book3s_xive.c:151:41: sparse:     expected restricted __be64 [usertype] w01
   arch/powerpc/kvm/book3s_xive.c:151:41: sparse:     got unsigned long

vim +151 arch/powerpc/kvm/book3s_xive.c

   129	
   130	/*
   131	 * Pull a vcpu's context from the XIVE on guest exit.
   132	 * This assumes we are in virtual mode (MMU on)
   133	 */
   134	void kvmppc_xive_pull_vcpu(struct kvm_vcpu *vcpu)
   135	{
   136		void __iomem *tima = local_paca->kvm_hstate.xive_tima_virt;
   137	
   138		if (!vcpu->arch.xive_pushed)
   139			return;
   140	
   141		/*
   142		 * Should not have been pushed if there is no tima
   143		 */
   144		if (WARN_ON(!tima))
   145			return;
   146	
   147		eieio();
   148		/* First load to pull the context, we ignore the value */
   149		__raw_readl(tima + TM_SPC_PULL_OS_CTX);
   150		/* Second load to recover the context state (Words 0 and 1) */
 > 151		vcpu->arch.xive_saved_state.w01 = __raw_readq(tima + TM_QW1_OS);
   152	
   153		/* Fixup some of the state for the next load */
   154		vcpu->arch.xive_saved_state.lsmfb = 0;
   155		vcpu->arch.xive_saved_state.ack = 0xff;
   156		vcpu->arch.xive_pushed = 0;
   157		eieio();
   158	}
   159	EXPORT_SYMBOL_GPL(kvmppc_xive_pull_vcpu);
   160	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
