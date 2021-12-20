Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A978547AA2D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 14:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbhLTNKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 08:10:17 -0500
Received: from mga03.intel.com ([134.134.136.65]:18828 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229845AbhLTNKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 08:10:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640005816; x=1671541816;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4q+wbaPXL0X+akHl5q8XnxXTKXTiORmA6Vv9SNX7l8o=;
  b=IuQTp3a8lM+EUeQdbRViyfPFAY0VP+z0PmZZxFYL2VjhimHFnEx/kU1r
   c/VrdKr8NN9L51J4ZOvfOqNYTuVkN9LT5eHhQZFQk0wd4mdzAMpyPlA9r
   Hlu4/f2kSMww8ZeFtbOoOwLKN63Ui6wh6gNB7iwGyQen40Sta2ASXqiTk
   kAywOTvR26o6++JseWI8cXKrfYDRfWDHTnVUa03qezjJDeIKGCTiqVfjY
   sderzsKCzalYeHt2Xe0P84RB1V6LIfrSaFPl0attsfyoqmSoUnmtzF1CH
   LZqSMXrzeW1dNDMQJ/od3RDjKQ7cF1GJSldaoezXcsNGrOVasUf033+ta
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10203"; a="240114659"
X-IronPort-AV: E=Sophos;i="5.88,220,1635231600"; 
   d="scan'208";a="240114659"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 05:10:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,220,1635231600"; 
   d="scan'208";a="684260280"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 20 Dec 2021 05:10:07 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzIQY-0007mb-LU; Mon, 20 Dec 2021 13:10:06 +0000
Date:   Mon, 20 Dec 2021 21:10:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tianyu Lan <Tianyu.Lan@microsoft.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: [hyperv:hyperv-next 1/5] kernel/dma/swiotlb.c:176:11: warning:
 format specifies type 'unsigned long long' but the argument has type
 'phys_addr_t' (aka 'unsigned int')
Message-ID: <202112202102.zfnhbn2Q-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git hyperv-next
head:   63cd06c67a2f46009da6e88ca46f9c7231ab8998
commit: f16dc95481e2ef2c385008f8b7bd382ea6919ee2 [1/5] swiotlb: Add swiotlb bounce buffer remap function for HV IVM
config: i386-randconfig-a001-20211219 (https://download.01.org/0day-ci/archive/20211220/202112202102.zfnhbn2Q-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 683cbc12b33e5c8dc8d29bf5ed79fbf45763aadd)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/commit/?id=f16dc95481e2ef2c385008f8b7bd382ea6919ee2
        git remote add hyperv https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
        git fetch --no-tags hyperv hyperv-next
        git checkout f16dc95481e2ef2c385008f8b7bd382ea6919ee2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash kernel/dma/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/dma/swiotlb.c:176:11: warning: format specifies type 'unsigned long long' but the argument has type 'phys_addr_t' (aka 'unsigned int') [-Wformat]
                                  paddr, bytes);
                                  ^~~~~
   include/linux/printk.h:493:33: note: expanded from macro 'pr_err'
           printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
                                  ~~~     ^~~~~~~~~~~
   include/linux/printk.h:450:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:422:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   1 warning generated.


vim +176 kernel/dma/swiotlb.c

   160	
   161	/*
   162	 * Remap swioltb memory in the unencrypted physical address space
   163	 * when swiotlb_unencrypted_base is set. (e.g. for Hyper-V AMD SEV-SNP
   164	 * Isolation VMs).
   165	 */
   166	static void *swiotlb_mem_remap(struct io_tlb_mem *mem, unsigned long bytes)
   167	{
   168		void *vaddr = NULL;
   169	
   170		if (swiotlb_unencrypted_base) {
   171			phys_addr_t paddr = mem->start + swiotlb_unencrypted_base;
   172	
   173			vaddr = memremap(paddr, bytes, MEMREMAP_WB);
   174			if (!vaddr)
   175				pr_err("Failed to map the unencrypted memory %llx size %lx.\n",
 > 176				       paddr, bytes);
   177		}
   178	
   179		return vaddr;
   180	}
   181	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
