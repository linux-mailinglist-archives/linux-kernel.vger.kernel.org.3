Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAA34BEE9C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 02:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237894AbiBVAoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 19:44:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbiBVAoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 19:44:14 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F4C255AF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 16:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645490629; x=1677026629;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5KSmrDjE0PlY8WIPbM1LjVwdaL4TI2g1llSFEX7T1cs=;
  b=VKdPzvn/uOa2ACyQHd+m2+jg70UqQCIJ9Ed/HmGrjsD8sg1eMDBjw4Nk
   IxLyitZal7ZakleJLcuwLhZn9YZNd4CzMRBxV/X8opr6WX8hJgNU03rXY
   kJ0wHNGLfsuwYe0W5L/5LjK38wUyNk20msCTrwI79StFUNB9PtXXOxN/i
   hD0t3jOsXb6QJEYF6PMQYcmsSQcW2n/gUOfT4pN+gEUrgN2sOTnPnzuhS
   u7TeV1tewM+t2hpJFdI4wwFeZ9jN9oYmH4BLVKWfnVmr1mljo6XeVYaeA
   N1r4FAbCKaJK0G/ix7Hrevu8vvzuOk/AIHpE182EEn4XdRASdvnbL9eFl
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="249164627"
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="249164627"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 16:43:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="778817080"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 21 Feb 2022 16:43:47 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMJHO-00029l-M8; Tue, 22 Feb 2022 00:43:46 +0000
Date:   Tue, 22 Feb 2022 08:42:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>, Kai Huang <kai.huang@intel.com>
Subject: arch/x86/kernel/cpu/sgx/virt.c:295:36: sparse: sparse: cast removes
 address space '__user' of expression
Message-ID: <202202220814.BN1x9yF4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   038101e6b2cd5c55f888f85db42ea2ad3aecb4b6
commit: d155030b1e7c0e448aab22a803f7a71ea2e117d7 x86/sgx: Add helpers to expose ECREATE and EINIT to KVM
date:   11 months ago
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220222/202202220814.BN1x9yF4-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d155030b1e7c0e448aab22a803f7a71ea2e117d7
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d155030b1e7c0e448aab22a803f7a71ea2e117d7
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/hyperv/ arch/x86/kernel/cpu/sgx/ drivers/staging/

If you fix the issue, kindly add following tag as appropriate
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
