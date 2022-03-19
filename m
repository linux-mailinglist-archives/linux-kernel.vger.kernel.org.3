Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D724DE977
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 18:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243700AbiCSRNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 13:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233507AbiCSRNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 13:13:50 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432C728AC5F
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 10:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647709949; x=1679245949;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BUwvXLk0z9f6orVXwJpvIG49e+rGly8WyYczrj8HHyg=;
  b=Uy5826tV25HYd7PZB7YsykBfZ/5EMk4QF+ZIFwDdEwBkfJlbZziPMvm7
   UFl2dHb8cEpj+cUj+zTD9SxoZ907v7QtN1Jdb5eEufQqRSwINtqMltmWs
   6/sMI6J1YNFkU1N1oKWbST4hspsALVPzKxen1Ce19egA1GId7AXZyEMqF
   S6vazoDX6PtQ0G0rYv1m3jGm133GGJcW0X+3DFpxgz1/o1MTnhYUcr+cz
   C4UKUyEa7vQa8Dds04UpFBFMkhY8m8sVy4B88zqtCey32Ntt1YeH9su7M
   3xn5Ppb6upSzATvFpfLGB5XojDyHpTL3WpPRvNlGlJ44ensizrF3AR/D6
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10291"; a="239473143"
X-IronPort-AV: E=Sophos;i="5.90,194,1643702400"; 
   d="scan'208";a="239473143"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 10:12:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,194,1643702400"; 
   d="scan'208";a="582338257"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 19 Mar 2022 10:12:26 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nVccs-000G9S-7W; Sat, 19 Mar 2022 17:12:26 +0000
Date:   Sun, 20 Mar 2022 01:11:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: arch/powerpc/kvm/book3s_xive.c:151:41: sparse: sparse: incorrect
 type in assignment (different base types)
Message-ID: <202203200134.Vp9bsSPI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   34e047aa16c0123bbae8e2f6df33e5ecc1f56601
commit: 023c3c96ca4d196c09d554d5a98900406e4d7ecb KVM: PPC: Book3S HV P9: implement kvmppc_xive_pull_vcpu in C
date:   9 months ago
config: powerpc64-randconfig-s031-20220319 (https://download.01.org/0day-ci/archive/20220320/202203200134.Vp9bsSPI-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=023c3c96ca4d196c09d554d5a98900406e4d7ecb
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 023c3c96ca4d196c09d554d5a98900406e4d7ecb
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/kvm/

If you fix the issue, kindly add following tag as appropriate
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
