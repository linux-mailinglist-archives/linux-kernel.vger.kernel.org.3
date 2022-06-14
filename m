Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181D454AC8E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 10:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355582AbiFNIw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 04:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242394AbiFNIw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 04:52:27 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962591054B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 01:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655196744; x=1686732744;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CK8MCnDGnqao3wbtn/IeDD8MXCitwD0hYvxOBcSBQ7A=;
  b=mKlNKv5J7V1wscHArv38v9lEJgnwl/Jjb4pSRMhxMfF38XSLPgsMyohg
   B+tIbVDmD6rMheYgCewpzt4yoVpkWDeQJFAsLBxUV/A2KpHyzFVBBCsW2
   A1VDTYDaKfPC4nh4+Lx4vCOejQGFtWGmUlU6be3rSwiAGPgXzOCy8tXfY
   Lh4v3Hi+or5fCE5iE5557dJa3IvijvEdj0K3qQcKSm6PHIreY+z9CRH+2
   HQJWazjZMtiKOmJZKz7qsdgxwQVnwxHY+9i9VMq639vX0L6/0OjmjDjp6
   YmIy1atrX5cqQUC/ShE2qHQ4stLkMjaGPdh9e72Yy4Sk/Lwh+6nd5ZGeN
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="279273635"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="279273635"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 01:52:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="686553902"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 14 Jun 2022 01:52:22 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o12Hd-000LgZ-MI;
        Tue, 14 Jun 2022 08:52:21 +0000
Date:   Tue, 14 Jun 2022 16:51:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: arch/powerpc/kvm/book3s_pr.c:660:22: sparse: sparse: cast to
 restricted __be32
Message-ID: <202206141636.NE1lb4tT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3
commit: cb53a93e33e108bfec00a13cd12696e1c0ccc8b6 KVM: PPC: Book3S PR: Declare kvmppc_handle_exit_pr()
date:   10 months ago
config: powerpc64-randconfig-s032-20220613 (https://download.01.org/0day-ci/archive/20220614/202206141636.NE1lb4tT-lkp@intel.com/config)
compiler: powerpc64le-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-30-g92122700-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cb53a93e33e108bfec00a13cd12696e1c0ccc8b6
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout cb53a93e33e108bfec00a13cd12696e1c0ccc8b6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/kvm/ arch/powerpc/platforms/powernv/ kernel/sched/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/powerpc/kvm/book3s_pr.c:660:22: sparse: sparse: cast to restricted __be32
>> arch/powerpc/kvm/book3s_pr.c:661:33: sparse: sparse: invalid assignment: &=
>> arch/powerpc/kvm/book3s_pr.c:661:33: sparse:    left side has type unsigned int
>> arch/powerpc/kvm/book3s_pr.c:661:33: sparse:    right side has type restricted __be32
   arch/powerpc/kvm/book3s_pr.c: note: in included file:
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
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
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:970:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] msr @@     got restricted __be64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:970:39: sparse:     expected unsigned long long [usertype] msr
   arch/powerpc/include/asm/kvm_ppc.h:970:39: sparse:     got restricted __be64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:972:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] msr @@     got restricted __le64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:972:39: sparse:     expected unsigned long long [usertype] msr
   arch/powerpc/include/asm/kvm_ppc.h:972:39: sparse:     got restricted __le64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:970:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] msr @@     got restricted __be64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:970:39: sparse:     expected unsigned long long [usertype] msr
   arch/powerpc/include/asm/kvm_ppc.h:970:39: sparse:     got restricted __be64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:972:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] msr @@     got restricted __le64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:972:39: sparse:     expected unsigned long long [usertype] msr
   arch/powerpc/include/asm/kvm_ppc.h:972:39: sparse:     got restricted __le64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] dar @@     got restricted __be64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse:     expected unsigned long long [usertype] dar
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse:     got restricted __be64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] dar @@     got restricted __le64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse:     expected unsigned long long [usertype] dar
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse:     got restricted __le64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] dar @@     got restricted __be64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse:     expected unsigned long long [usertype] dar
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse:     got restricted __be64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] dar @@     got restricted __le64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse:     expected unsigned long long [usertype] dar
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse:     got restricted __le64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:974:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] dsisr @@     got restricted __be32 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:974:1: sparse:     expected unsigned int [usertype] dsisr
   arch/powerpc/include/asm/kvm_ppc.h:974:1: sparse:     got restricted __be32 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:974:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] dsisr @@     got restricted __le32 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:974:1: sparse:     expected unsigned int [usertype] dsisr
   arch/powerpc/include/asm/kvm_ppc.h:974:1: sparse:     got restricted __le32 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] dar @@     got restricted __be64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse:     expected unsigned long long [usertype] dar
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse:     got restricted __be64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] dar @@     got restricted __le64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse:     expected unsigned long long [usertype] dar

vim +660 arch/powerpc/kvm/book3s_pr.c

f05ed4d56e9cff Paul Mackerras 2011-06-29  630  
f05ed4d56e9cff Paul Mackerras 2011-06-29  631  /* Book3s_32 CPUs always have 32 bytes cache line size, which Linux assumes. To
f05ed4d56e9cff Paul Mackerras 2011-06-29  632   * make Book3s_32 Linux work on Book3s_64, we have to make sure we trap dcbz to
f05ed4d56e9cff Paul Mackerras 2011-06-29  633   * emulate 32 bytes dcbz length.
f05ed4d56e9cff Paul Mackerras 2011-06-29  634   *
f05ed4d56e9cff Paul Mackerras 2011-06-29  635   * The Book3s_64 inventors also realized this case and implemented a special bit
f05ed4d56e9cff Paul Mackerras 2011-06-29  636   * in the HID5 register, which is a hypervisor ressource. Thus we can't use it.
f05ed4d56e9cff Paul Mackerras 2011-06-29  637   *
f05ed4d56e9cff Paul Mackerras 2011-06-29  638   * My approach here is to patch the dcbz instruction on executing pages.
f05ed4d56e9cff Paul Mackerras 2011-06-29  639   */
f05ed4d56e9cff Paul Mackerras 2011-06-29  640  static void kvmppc_patch_dcbz(struct kvm_vcpu *vcpu, struct kvmppc_pte *pte)
f05ed4d56e9cff Paul Mackerras 2011-06-29  641  {
f05ed4d56e9cff Paul Mackerras 2011-06-29  642  	struct page *hpage;
f05ed4d56e9cff Paul Mackerras 2011-06-29  643  	u64 hpage_offset;
f05ed4d56e9cff Paul Mackerras 2011-06-29  644  	u32 *page;
f05ed4d56e9cff Paul Mackerras 2011-06-29  645  	int i;
f05ed4d56e9cff Paul Mackerras 2011-06-29  646  
f05ed4d56e9cff Paul Mackerras 2011-06-29  647  	hpage = gfn_to_page(vcpu->kvm, pte->raddr >> PAGE_SHIFT);
32cad84f44d186 Xiao Guangrong 2012-08-03  648  	if (is_error_page(hpage))
f05ed4d56e9cff Paul Mackerras 2011-06-29  649  		return;
f05ed4d56e9cff Paul Mackerras 2011-06-29  650  
f05ed4d56e9cff Paul Mackerras 2011-06-29  651  	hpage_offset = pte->raddr & ~PAGE_MASK;
f05ed4d56e9cff Paul Mackerras 2011-06-29  652  	hpage_offset &= ~0xFFFULL;
f05ed4d56e9cff Paul Mackerras 2011-06-29  653  	hpage_offset /= 4;
f05ed4d56e9cff Paul Mackerras 2011-06-29  654  
f05ed4d56e9cff Paul Mackerras 2011-06-29  655  	get_page(hpage);
2480b2089210de Cong Wang      2011-11-25  656  	page = kmap_atomic(hpage);
f05ed4d56e9cff Paul Mackerras 2011-06-29  657  
f05ed4d56e9cff Paul Mackerras 2011-06-29  658  	/* patch dcbz into reserved instruction, so we trap */
f05ed4d56e9cff Paul Mackerras 2011-06-29  659  	for (i=hpage_offset; i < hpage_offset + (HW_PAGE_SIZE / 4); i++)
cd087eefe637d5 Alexander Graf 2014-04-24 @660  		if ((be32_to_cpu(page[i]) & 0xff0007ff) == INS_DCBZ)
cd087eefe637d5 Alexander Graf 2014-04-24 @661  			page[i] &= cpu_to_be32(0xfffffff7);
f05ed4d56e9cff Paul Mackerras 2011-06-29  662  
2480b2089210de Cong Wang      2011-11-25  663  	kunmap_atomic(page);
f05ed4d56e9cff Paul Mackerras 2011-06-29  664  	put_page(hpage);
f05ed4d56e9cff Paul Mackerras 2011-06-29  665  }
f05ed4d56e9cff Paul Mackerras 2011-06-29  666  

:::::: The code at line 660 was first introduced by commit
:::::: cd087eefe637d545345ea5f888d4ea4fe52e312c KVM: PPC: Book3S PR: Do dcbz32 patching with big endian instructions

:::::: TO: Alexander Graf <agraf@suse.de>
:::::: CC: Alexander Graf <agraf@suse.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
