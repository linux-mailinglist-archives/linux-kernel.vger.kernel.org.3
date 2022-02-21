Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FFF4BECA6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 22:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234919AbiBUV3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 16:29:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiBUV3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 16:29:09 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A741BE26
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 13:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645478925; x=1677014925;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=okt3s0b4q169db83r7USlJRhD2RDFsrd56GhcrAKdPs=;
  b=fndVTaqm8++noz2dKuTyteNlfBKIsj6Dg+y2hOK58CkAHOGa0mmpvkmA
   uRc9XSWxJnw+Raa7nXNr93QHptdZa+SJ1AyBMwX6xB+ozVKkdYmHulwWK
   4X+y75YKaYwW4aLZD5dfAeSn6QJ1evL1C6hoOHHBJCk43WwJVlQXAY10T
   nawk909cGu/V3tMf45RxCWioDR0mH6XfwmRH8Vk2Nqp7IlbuJXBXCSQoc
   APrDO2zEHHqLa6rbSwk5Zr2/IXgmQcPMA5poQyeQCOYOMcE7KYNYpcp7U
   xKyiabiFWMHnxR+cBsCikdav0/Yb0g0DQXacioE2tFE5gynLRkqebixue
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="231538524"
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="231538524"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 13:28:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="531975328"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 21 Feb 2022 13:28:42 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMGEb-0001zh-VX; Mon, 21 Feb 2022 21:28:41 +0000
Date:   Tue, 22 Feb 2022 05:28:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>, Kai Huang <kai.huang@intel.com>
Subject: arch/x86/kernel/cpu/sgx/virt.c:59:13: sparse: sparse: incorrect type
 in assignment (different base types)
Message-ID: <202202220503.9FyCsWJL-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   038101e6b2cd5c55f888f85db42ea2ad3aecb4b6
commit: 540745ddbc70eabdc7dbd3fcc00fe4fb17cd59ba x86/sgx: Introduce virtual EPC for use by KVM guests
date:   11 months ago
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220222/202202220503.9FyCsWJL-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=540745ddbc70eabdc7dbd3fcc00fe4fb17cd59ba
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 540745ddbc70eabdc7dbd3fcc00fe4fb17cd59ba
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/hyperv/ arch/x86/kernel/cpu/sgx/ drivers/staging/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/x86/kernel/cpu/sgx/virt.c:59:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected int [assigned] ret @@     got restricted vm_fault_t @@
   arch/x86/kernel/cpu/sgx/virt.c:59:13: sparse:     expected int [assigned] ret
   arch/x86/kernel/cpu/sgx/virt.c:59:13: sparse:     got restricted vm_fault_t
>> arch/x86/kernel/cpu/sgx/virt.c:60:20: sparse: sparse: restricted vm_fault_t degrades to integer
   arch/x86/kernel/cpu/sgx/virt.c:95:35: sparse: sparse: symbol 'sgx_vepc_vm_ops' was not declared. Should it be static?

vim +59 arch/x86/kernel/cpu/sgx/virt.c

    32	
    33	static int __sgx_vepc_fault(struct sgx_vepc *vepc,
    34				    struct vm_area_struct *vma, unsigned long addr)
    35	{
    36		struct sgx_epc_page *epc_page;
    37		unsigned long index, pfn;
    38		int ret;
    39	
    40		WARN_ON(!mutex_is_locked(&vepc->lock));
    41	
    42		/* Calculate index of EPC page in virtual EPC's page_array */
    43		index = vma->vm_pgoff + PFN_DOWN(addr - vma->vm_start);
    44	
    45		epc_page = xa_load(&vepc->page_array, index);
    46		if (epc_page)
    47			return 0;
    48	
    49		epc_page = sgx_alloc_epc_page(vepc, false);
    50		if (IS_ERR(epc_page))
    51			return PTR_ERR(epc_page);
    52	
    53		ret = xa_err(xa_store(&vepc->page_array, index, epc_page, GFP_KERNEL));
    54		if (ret)
    55			goto err_free;
    56	
    57		pfn = PFN_DOWN(sgx_get_epc_phys_addr(epc_page));
    58	
  > 59		ret = vmf_insert_pfn(vma, addr, pfn);
  > 60		if (ret != VM_FAULT_NOPAGE) {
    61			ret = -EFAULT;
    62			goto err_delete;
    63		}
    64	
    65		return 0;
    66	
    67	err_delete:
    68		xa_erase(&vepc->page_array, index);
    69	err_free:
    70		sgx_free_epc_page(epc_page);
    71		return ret;
    72	}
    73	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
