Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9BDD491E6D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 05:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiAREOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 23:14:14 -0500
Received: from mga07.intel.com ([134.134.136.100]:42504 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230169AbiAREOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 23:14:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642479244; x=1674015244;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=N8StwKOUFN38Fg7Jp+n+nHXaNLN+HGpyfbNXMwx0E+w=;
  b=ZJTnepacG974z6+f9SZFlBkc0HhsNfypG/EVkRANFUZWt5bApRnIakwo
   QL1V0dHxE+qrH0faMIMP/g6NVsPr50Bdj/A4luBszax6KAQHFWNt4Htak
   3e+Ox6Wpzn/MQB30l6aE5YWSY6xyUP8H0zmXWQmTACJf0JftRnqJMRUuH
   VQkcnhVpl3BQhl47PncMFQV7nv9HbWNNcZdLWY9N3H8voVmE525tgLMY7
   3WsMvVumtVR+RIGYEdNSA3HvtMlNMqgv96q7nu3XLG9YyLOOW2PtN+Vhk
   Ysv7JZxeNptsikCKjx/xIm8CnGHffuQJn2PUQKbM06sIJzd0HE3HZz7iu
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="308074162"
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="308074162"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 20:14:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="476839197"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 17 Jan 2022 20:14:00 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9fse-000C95-9m; Tue, 18 Jan 2022 04:14:00 +0000
Date:   Tue, 18 Jan 2022 12:13:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <mbrugger@suse.com>
Subject: arch/arm64/kernel/hibernate.c:202:44: sparse: sparse: cast from
 restricted gfp_t
Message-ID: <202201181248.rDauB3ns-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0c947b893d69231a9add855939da7c66237ab44f
commit: 50f53fb721817a6efa541cca24f1b7caa84801c1 arm64: trans_pgd: make trans_pgd_map_page generic
date:   12 months ago
config: arm64-randconfig-s031-20220117 (https://download.01.org/0day-ci/archive/20220118/202201181248.rDauB3ns-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=50f53fb721817a6efa541cca24f1b7caa84801c1
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 50f53fb721817a6efa541cca24f1b7caa84801c1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   arch/arm64/kernel/hibernate.c:181:39: sparse: sparse: cast to restricted gfp_t
>> arch/arm64/kernel/hibernate.c:202:44: sparse: sparse: cast from restricted gfp_t

vim +202 arch/arm64/kernel/hibernate.c

   183	
   184	/*
   185	 * Copies length bytes, starting at src_start into an new page,
   186	 * perform cache maintenance, then maps it at the specified address low
   187	 * address as executable.
   188	 *
   189	 * This is used by hibernate to copy the code it needs to execute when
   190	 * overwriting the kernel text. This function generates a new set of page
   191	 * tables, which it loads into ttbr0.
   192	 *
   193	 * Length is provided as we probably only want 4K of data, even on a 64K
   194	 * page system.
   195	 */
   196	static int create_safe_exec_page(void *src_start, size_t length,
   197					 unsigned long dst_addr,
   198					 phys_addr_t *phys_dst_addr)
   199	{
   200		struct trans_pgd_info trans_info = {
   201			.trans_alloc_page	= hibernate_page_alloc,
 > 202			.trans_alloc_arg	= (void *)GFP_ATOMIC,
   203		};
   204	
   205		void *page = (void *)get_safe_page(GFP_ATOMIC);
   206		pgd_t *trans_pgd;
   207		int rc;
   208	
   209		if (!page)
   210			return -ENOMEM;
   211	
   212		memcpy(page, src_start, length);
   213		__flush_icache_range((unsigned long)page, (unsigned long)page + length);
   214	
   215		trans_pgd = (void *)get_safe_page(GFP_ATOMIC);
   216		if (!trans_pgd)
   217			return -ENOMEM;
   218	
   219		rc = trans_pgd_map_page(&trans_info, trans_pgd, page, dst_addr,
   220					PAGE_KERNEL_EXEC);
   221		if (rc)
   222			return rc;
   223	
   224		/*
   225		 * Load our new page tables. A strict BBM approach requires that we
   226		 * ensure that TLBs are free of any entries that may overlap with the
   227		 * global mappings we are about to install.
   228		 *
   229		 * For a real hibernate/resume cycle TTBR0 currently points to a zero
   230		 * page, but TLBs may contain stale ASID-tagged entries (e.g. for EFI
   231		 * runtime services), while for a userspace-driven test_resume cycle it
   232		 * points to userspace page tables (and we must point it at a zero page
   233		 * ourselves). Elsewhere we only (un)install the idmap with preemption
   234		 * disabled, so T0SZ should be as required regardless.
   235		 */
   236		cpu_set_reserved_ttbr0();
   237		local_flush_tlb_all();
   238		write_sysreg(phys_to_ttbr(virt_to_phys(trans_pgd)), ttbr0_el1);
   239		isb();
   240	
   241		*phys_dst_addr = virt_to_phys(page);
   242	
   243		return 0;
   244	}
   245	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
