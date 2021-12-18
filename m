Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B2047987E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 04:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhLRDng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 22:43:36 -0500
Received: from mga14.intel.com ([192.55.52.115]:1682 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230052AbhLRDnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 22:43:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639799015; x=1671335015;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GXptn5xPUR40U4QhdwFu1hawOnMsfvW05PjXCMVS+a4=;
  b=l/QyFrZbUur8RXZ7UQ8XgwoaND5CuRq+hCQg+FCusumvCsbd+7UQQjpr
   zP14n33KyWhlybia5pr0tWxZpFWydMV5YPgqjZ/h5Url1HSqRl2/QInLb
   2ul2Njn2Z2NZRr+lb/pHW+2OIYKj356CEYwnY6qajPDBjjNWhY8s/0iLY
   5tFftgOOvbzwXpejWsLJ/Vw5CZPVsj9Yw7Un4ROfHZOuHS/XQ622HYMQX
   MFL+JDt4Apcm/9F1lTuY8+hBTjkTnd+ITZSl301UK+VwOcMOnJU5HkJOt
   aEn+xeT6SaMCBIW4E3g+eqViV4fNHBYHO816yL4KEj/R4nhPAo8j0Sq9g
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="240104258"
X-IronPort-AV: E=Sophos;i="5.88,215,1635231600"; 
   d="scan'208";a="240104258"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 19:43:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,215,1635231600"; 
   d="scan'208";a="507009626"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 17 Dec 2021 19:43:31 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1myQd9-0005Yw-9y; Sat, 18 Dec 2021 03:43:31 +0000
Date:   Sat, 18 Dec 2021 11:42:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tianyu Lan <Tianyu.Lan@microsoft.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: [hyperv:hyperv-next 1/5] kernel/dma/swiotlb.c:166:7: warning: no
 previous prototype for function 'swiotlb_mem_remap'
Message-ID: <202112181133.7Ki4aggA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git hyperv-next
head:   19fd7ca00201c0525452dcf5a490e4b01674ef4c
commit: 32be866293fe5355adbf91da1cd612f439fc71e5 [1/5] swiotlb: Add swiotlb bounce buffer remap function for HV IVM
config: x86_64-randconfig-r025-20211216 (https://download.01.org/0day-ci/archive/20211218/202112181133.7Ki4aggA-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 9043c3d65b11b442226015acfbf8167684586cfa)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/commit/?id=32be866293fe5355adbf91da1cd612f439fc71e5
        git remote add hyperv https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
        git fetch --no-tags hyperv hyperv-next
        git checkout 32be866293fe5355adbf91da1cd612f439fc71e5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/dma/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/dma/swiotlb.c:166:7: warning: no previous prototype for function 'swiotlb_mem_remap' [-Wmissing-prototypes]
   void *swiotlb_mem_remap(struct io_tlb_mem *mem, unsigned long bytes)
         ^
   kernel/dma/swiotlb.c:166:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void *swiotlb_mem_remap(struct io_tlb_mem *mem, unsigned long bytes)
   ^
   static 
   1 warning generated.


vim +/swiotlb_mem_remap +166 kernel/dma/swiotlb.c

   160	
   161	/*
   162	 * Remap swioltb memory in the unencrypted physical address space
   163	 * when swiotlb_unencrypted_base is set. (e.g. for Hyper-V AMD SEV-SNP
   164	 * Isolation VMs).
   165	 */
 > 166	void *swiotlb_mem_remap(struct io_tlb_mem *mem, unsigned long bytes)
   167	{
   168		void *vaddr = NULL;
   169	
   170		if (swiotlb_unencrypted_base) {
   171			phys_addr_t paddr = mem->start + swiotlb_unencrypted_base;
   172	
   173			vaddr = memremap(paddr, bytes, MEMREMAP_WB);
   174			if (!vaddr)
   175				pr_err("Failed to map the unencrypted memory %llx size %lx.\n",
   176				       paddr, bytes);
   177		}
   178	
   179		return vaddr;
   180	}
   181	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
