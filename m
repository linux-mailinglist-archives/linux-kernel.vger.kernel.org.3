Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233D453D5FA
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 09:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbiFDHne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 03:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbiFDHna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 03:43:30 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8730F27B02
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 00:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654328609; x=1685864609;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=y+24kAa+SFMhBQSj2/01dltHkZD9TuYmX7E816Ly8NU=;
  b=brjz8qweqeKQX2Bqxwe4KzqXFSpqiw7fukb0DuBPR4W4NdoQLGETNQ+g
   8kli1xQDicsM4F5SHendAgiomYM9nn36SuFjWCo5qH4M9gNGcNvGjCf7/
   0tFF8ejtitCEME10wqtSXjwgzRgwHR2tXJl/QdPFHMnHPYSfnlgzEoS9z
   Ir8e7eBmwZiHGU5CreyLHpcGyzvLLTLmd/Fr9oAf3P1KhskQZdvXP2TYf
   24+fn/6xdPtIc960g4qzGvf8FVlCTNfTAIVmoz+/dq8baSzlZtIJJSWdF
   YGc/gRj34YVZPJmObo/e2f71sQA1ZS2pG0AEPQm4m+voOAVCN04YmdYxS
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10367"; a="276449917"
X-IronPort-AV: E=Sophos;i="5.91,277,1647327600"; 
   d="scan'208";a="276449917"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 00:43:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,277,1647327600"; 
   d="scan'208";a="905797902"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 04 Jun 2022 00:43:22 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxORN-000ART-RP;
        Sat, 04 Jun 2022 07:43:21 +0000
Date:   Sat, 4 Jun 2022 15:43:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>, Kai Huang <kai.huang@intel.com>
Subject: arch/x86/kernel/cpu/sgx/virt.c:59:13: sparse: sparse: incorrect type
 in assignment (different base types)
Message-ID: <202206041508.vR5NoxR4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   032dcf09e2bf7c822be25b4abef7a6c913870d98
commit: 540745ddbc70eabdc7dbd3fcc00fe4fb17cd59ba x86/sgx: Introduce virtual EPC for use by KVM guests
date:   1 year, 2 months ago
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220604/202206041508.vR5NoxR4-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-18-g56afb504-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=540745ddbc70eabdc7dbd3fcc00fe4fb17cd59ba
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 540745ddbc70eabdc7dbd3fcc00fe4fb17cd59ba
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/cpu/sgx/

If you fix the issue, kindly add following tag where applicable
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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
