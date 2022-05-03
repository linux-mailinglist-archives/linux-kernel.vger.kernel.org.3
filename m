Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B998F518D0A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 21:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240207AbiECTTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 15:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237094AbiECTTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 15:19:04 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5483C32ED5
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 12:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651605331; x=1683141331;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eh+UDDARYDIccIec6Kv8Mbf14Mzr9J6fFwI8Z7JunYE=;
  b=AwEEhdDvXHjwvVq5B+SEiJGVqPklStmU9eUR/h8XhmwQOaNEUOxqa/hX
   zGavoUhSFYY0b+uoHp8CMs5++h51dFTk1v7o3z9x+Wuc8lfoKhfaDHBrI
   QsJOr7vzV94P5jmjgOoH8hxWYfT8Ld9WTIhvW+N/bB5GMnaXf/hTIciiI
   eGDLuNowD2kafmaXTtQ5yOjtht2fXnGKMMkzDgcRwRnxhX+9nQf9zvb8M
   KoLOd2ttAUk/d7RBi56O01e32cF9k2pzqo9hLhnYqAg8rOxq4EGuEV3im
   PQTU2m24T0Xny+az+Pg113YY87+s0zbGluWOMCpz/GdvpN7nkmFjCWb+6
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="247472747"
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="247472747"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 12:15:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="562345430"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 03 May 2022 12:15:28 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlxzW-000AjR-G8;
        Tue, 03 May 2022 19:15:22 +0000
Date:   Wed, 4 May 2022 03:15:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [linux-stable-rc:queue/5.4 83/83] fs/hugetlbfs/inode.c:211:40:
 error: implicit declaration of function 'arch_get_mmap_end'
Message-ID: <202205040323.boErRvCI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git queue/5.4
head:   2d723d526f735966b904f52c02d035793882b005
commit: 2d723d526f735966b904f52c02d035793882b005 [83/83] mm, hugetlb: allow for "high" userspace addresses
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20220504/202205040323.boErRvCI-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=2d723d526f735966b904f52c02d035793882b005
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc queue/5.4
        git checkout 2d723d526f735966b904f52c02d035793882b005
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/hugetlbfs/inode.c: In function 'hugetlb_get_unmapped_area':
>> fs/hugetlbfs/inode.c:211:40: error: implicit declaration of function 'arch_get_mmap_end' [-Werror=implicit-function-declaration]
     211 |         const unsigned long mmap_end = arch_get_mmap_end(addr);
         |                                        ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/arch_get_mmap_end +211 fs/hugetlbfs/inode.c

   197	
   198	/*
   199	 * Called under down_write(mmap_sem).
   200	 */
   201	
   202	#ifndef HAVE_ARCH_HUGETLB_UNMAPPED_AREA
   203	static unsigned long
   204	hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
   205			unsigned long len, unsigned long pgoff, unsigned long flags)
   206	{
   207		struct mm_struct *mm = current->mm;
   208		struct vm_area_struct *vma;
   209		struct hstate *h = hstate_file(file);
   210		struct vm_unmapped_area_info info;
 > 211		const unsigned long mmap_end = arch_get_mmap_end(addr);
   212	
   213		if (len & ~huge_page_mask(h))
   214			return -EINVAL;
   215		if (len > TASK_SIZE)
   216			return -ENOMEM;
   217	
   218		if (flags & MAP_FIXED) {
   219			if (prepare_hugepage_range(file, addr, len))
   220				return -EINVAL;
   221			return addr;
   222		}
   223	
   224		if (addr) {
   225			addr = ALIGN(addr, huge_page_size(h));
   226			vma = find_vma(mm, addr);
   227			if (mmap_end - len >= addr &&
   228			    (!vma || addr + len <= vm_start_gap(vma)))
   229				return addr;
   230		}
   231	
   232		info.flags = 0;
   233		info.length = len;
   234		info.low_limit = TASK_UNMAPPED_BASE;
   235		info.high_limit = arch_get_mmap_end(addr);
   236		info.align_mask = PAGE_MASK & ~huge_page_mask(h);
   237		info.align_offset = 0;
   238		return vm_unmapped_area(&info);
   239	}
   240	#endif
   241	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
