Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9806253D64B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 11:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbiFDJqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 05:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234197AbiFDJqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 05:46:31 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC4E1C912
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 02:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654335991; x=1685871991;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EnzYIGPT8V3M8JQKqotcWukqJZS3TOLYvVbtCoLTi/c=;
  b=cnYXSrJbX6PBfnr3MT24X9yvxzzfIDkkT+v7uNemacvR0WLKBfR14xV3
   eVB+d9jzdtnRbcRBYkm+ewWtJFV62I7luFMx8xMn7pPDc+siStKskP/MR
   yZ0beNivzkLkszxL0K73tZhSw1xkL2SnA+gWuNQbMWgD6oxeUPDe45nPZ
   V69riN2AsobXeYeMclBH4vvtPyAJtuLu5pwqSERxH+oJB0UZep5kWnjDr
   Qj175MwzjpUEgQNpGlnHrPdQ9vSNZBs1GzwwC8EREJeupGieAw3oRWdhp
   lWw5vO16KukpQx+ThhL1U2L1P1BpeKov/WQNDo+gd7FARcx/XufV4hPwy
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10367"; a="301794403"
X-IronPort-AV: E=Sophos;i="5.91,277,1647327600"; 
   d="scan'208";a="301794403"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 02:46:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,277,1647327600"; 
   d="scan'208";a="757822366"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 04 Jun 2022 02:46:28 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxQMW-000Abf-91;
        Sat, 04 Jun 2022 09:46:28 +0000
Date:   Sat, 4 Jun 2022 17:46:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>, Kai Huang <kai.huang@intel.com>
Subject: arch/x86/kernel/cpu/sgx/virt.c:295:36: sparse: sparse: cast removes
 address space '__user' of expression
Message-ID: <202206041712.XoJv2ESx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   032dcf09e2bf7c822be25b4abef7a6c913870d98
commit: d155030b1e7c0e448aab22a803f7a71ea2e117d7 x86/sgx: Add helpers to expose ECREATE and EINIT to KVM
date:   1 year, 2 months ago
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220604/202206041712.XoJv2ESx-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-18-g56afb504-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d155030b1e7c0e448aab22a803f7a71ea2e117d7
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d155030b1e7c0e448aab22a803f7a71ea2e117d7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/cpu/sgx/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   arch/x86/kernel/cpu/sgx/virt.c:59:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected int [assigned] ret @@     got restricted vm_fault_t @@
   arch/x86/kernel/cpu/sgx/virt.c:59:13: sparse:     expected int [assigned] ret
   arch/x86/kernel/cpu/sgx/virt.c:59:13: sparse:     got restricted vm_fault_t
   arch/x86/kernel/cpu/sgx/virt.c:60:20: sparse: sparse: restricted vm_fault_t degrades to integer
   arch/x86/kernel/cpu/sgx/virt.c:95:35: sparse: sparse: symbol 'sgx_vepc_vm_ops' was not declared. Should it be static?
>> arch/x86/kernel/cpu/sgx/virt.c:295:36: sparse: sparse: cast removes address space '__user' of expression
   arch/x86/kernel/cpu/sgx/virt.c:326:24: sparse: sparse: cast removes address space '__user' of expression
   arch/x86/kernel/cpu/sgx/virt.c:326:43: sparse: sparse: cast removes address space '__user' of expression
   arch/x86/kernel/cpu/sgx/virt.c:326:58: sparse: sparse: cast removes address space '__user' of expression

vim +/__user +295 arch/x86/kernel/cpu/sgx/virt.c

   260	
   261	/**
   262	 * sgx_virt_ecreate() - Run ECREATE on behalf of guest
   263	 * @pageinfo:	Pointer to PAGEINFO structure
   264	 * @secs:	Userspace pointer to SECS page
   265	 * @trapnr:	trap number injected to guest in case of ECREATE error
   266	 *
   267	 * Run ECREATE on behalf of guest after KVM traps ECREATE for the purpose
   268	 * of enforcing policies of guest's enclaves, and return the trap number
   269	 * which should be injected to guest in case of any ECREATE error.
   270	 *
   271	 * Return:
   272	 * -  0:	ECREATE was successful.
   273	 * - <0:	on error.
   274	 */
   275	int sgx_virt_ecreate(struct sgx_pageinfo *pageinfo, void __user *secs,
   276			     int *trapnr)
   277	{
   278		int ret;
   279	
   280		/*
   281		 * @secs is an untrusted, userspace-provided address.  It comes from
   282		 * KVM and is assumed to be a valid pointer which points somewhere in
   283		 * userspace.  This can fault and call SGX or other fault handlers when
   284		 * userspace mapping @secs doesn't exist.
   285		 *
   286		 * Add a WARN() to make sure @secs is already valid userspace pointer
   287		 * from caller (KVM), who should already have handled invalid pointer
   288		 * case (for instance, made by malicious guest).  All other checks,
   289		 * such as alignment of @secs, are deferred to ENCLS itself.
   290		 */
   291		if (WARN_ON_ONCE(!access_ok(secs, PAGE_SIZE)))
   292			return -EINVAL;
   293	
   294		__uaccess_begin();
 > 295		ret = __ecreate(pageinfo, (void *)secs);
   296		__uaccess_end();
   297	
   298		if (encls_faulted(ret)) {
   299			*trapnr = ENCLS_TRAPNR(ret);
   300			return -EFAULT;
   301		}
   302	
   303		/* ECREATE doesn't return an error code, it faults or succeeds. */
   304		WARN_ON_ONCE(ret);
   305		return 0;
   306	}
   307	EXPORT_SYMBOL_GPL(sgx_virt_ecreate);
   308	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
