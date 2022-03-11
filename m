Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D124D6AA5
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 00:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiCKXCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 18:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiCKXBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 18:01:47 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6409A24DD60
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 14:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647039298; x=1678575298;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eKBtcpoHrPqlKqhYnJeiJbBZO+7HypJb6qXhbR6fhOA=;
  b=BE+Y2Q3sDaMDsHHuAkmZfaCAFIBAOp+dOMnTRLJUVT2ReZiUPxaMuPEm
   Op+/sBGvIridRm6qYNRb2mFq532vu9aHEJqJKTlZF3d1JMHIOorD3HTxp
   zAbdELs8nY5Czb+3Su2v0xXd17BNsJyZX1kNpGya8yOwmzHb5VUjJ++Gm
   /2ygUrFYcfIo9XMh/4RRdqYn9jQBX/4S9CgQfwGnAT711qO+A6s7VQrLC
   hNAGlo92R1ljkZWOWIPPO3UVSdeQpPRMo5S1/8Co7VooKiKacWpWf8AvR
   uWdLMTI6sltsfg4KF1Y3Llhmei7Qk4peobfy99G8Vsx3LMscj4JEATC44
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="235620724"
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="235620724"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 14:54:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="712995916"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 11 Mar 2022 14:54:54 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSo9u-0007DK-05; Fri, 11 Mar 2022 22:54:54 +0000
Date:   Sat, 12 Mar 2022 06:54:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <mbrugger@suse.com>
Subject: arch/arm64/kernel/hibernate.c:202:44: sparse: sparse: cast from
 restricted gfp_t
Message-ID: <202203120653.S3Am11od-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   68453767131a5deec1e8f9ac92a9042f929e585d
commit: 50f53fb721817a6efa541cca24f1b7caa84801c1 arm64: trans_pgd: make trans_pgd_map_page generic
date:   1 year, 1 month ago
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20220312/202203120653.S3Am11od-lkp@intel.com/config)
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
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
