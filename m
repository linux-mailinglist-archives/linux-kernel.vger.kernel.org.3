Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A327565FF6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 02:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiGEAEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 20:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGEAEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 20:04:51 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646FE212
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 17:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656979490; x=1688515490;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=y8WMlfpx+XDvlZyqqlGTDUBrc8BizYD/wWxxlEzdZMc=;
  b=f2RyxGuGtwHCSASVNKGVvX4XyBRbEE80lxm8ifaRVOlpXAet5jqHtHb5
   BFOHwvcgVOtHpf/hlG6Eadd/dj/Z1xdzNsu2ooVuyPD6DxhJ2hx/NFCtP
   ne3HsOKAtKC3UEgUNy7bxAgvGf1dwXtcCogdaISckHCuT1TLyUqpiHkSW
   5w1ZG8gTHT6cFG1PMy2AWWUSBE49S3gVpv5wpN0hgpkHuecgv36zFFIyj
   uBhvRHGeKQ1zmwofLUTRPDia0p7+3dDekl64YFU+/JPBpgIHaIEF7dokM
   ma9AzZHWGEb77N+phKiRORVb0d0zupQ5tA7TAL4r8Y9Mzw6kQb+TgoZYF
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="284323842"
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="284323842"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 17:04:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="649822155"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 04 Jul 2022 17:04:48 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8W3b-000IRr-Vw;
        Tue, 05 Jul 2022 00:04:47 +0000
Date:   Tue, 5 Jul 2022 08:04:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [arm-integrator:kernel-in-vmalloc-v5.19-rc1 26/35]
 fs/proc/kcore.c:203:33: warning: passing argument 1 of 'virt_to_pfn' makes
 pointer from integer without a cast
Message-ID: <202207050828.nwj0mbUG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git kernel-in-vmalloc-v5.19-rc1
head:   144435741b0a6f31403d3084103678da3b4f9d11
commit: f598211d50cd617489ce5cdb7b01ed741334b66f [26/35] openrisc: Make virt_to_pfn() a static inline
config: openrisc-randconfig-r013-20220703 (https://download.01.org/0day-ci/archive/20220705/202207050828.nwj0mbUG-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/commit/?id=f598211d50cd617489ce5cdb7b01ed741334b66f
        git remote add arm-integrator https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
        git fetch --no-tags arm-integrator kernel-in-vmalloc-v5.19-rc1
        git checkout f598211d50cd617489ce5cdb7b01ed741334b66f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=openrisc SHELL=/bin/bash fs/proc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/openrisc/include/asm/processor.h:19,
                    from arch/openrisc/include/asm/thread_info.h:22,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/current.h:5,
                    from ./arch/openrisc/include/generated/asm/current.h:1,
                    from include/linux/sched.h:12,
                    from include/linux/sched/task_stack.h:9,
                    from include/linux/elfcore.h:7,
                    from include/linux/crash_core.h:6,
                    from fs/proc/kcore.c:13:
   fs/proc/kcore.c: In function 'kclist_add_private':
>> fs/proc/kcore.c:203:33: warning: passing argument 1 of 'virt_to_pfn' makes pointer from integer without a cast [-Wint-conversion]
     203 |         if (!virt_addr_valid(ent->addr))
         |                              ~~~^~~~~~
         |                                 |
         |                                 long unsigned int
   arch/openrisc/include/asm/page.h:86:35: note: in definition of macro 'pfn_valid'
      86 | #define pfn_valid(pfn)          ((pfn) < max_mapnr)
         |                                   ^~~
   fs/proc/kcore.c:203:14: note: in expansion of macro 'virt_addr_valid'
     203 |         if (!virt_addr_valid(ent->addr))
         |              ^~~~~~~~~~~~~~~
   arch/openrisc/include/asm/page.h:75:53: note: expected 'const void *' but argument is of type 'long unsigned int'
      75 | static inline unsigned long virt_to_pfn(const void *kaddr)
         |                                         ~~~~~~~~~~~~^~~~~


vim +/virt_to_pfn +203 fs/proc/kcore.c

26562c59fa9111 KAMEZAWA Hiroyuki 2009-09-22  184  
3089aa1b0c07fb KAMEZAWA Hiroyuki 2009-09-22  185  static int
3089aa1b0c07fb KAMEZAWA Hiroyuki 2009-09-22  186  kclist_add_private(unsigned long pfn, unsigned long nr_pages, void *arg)
3089aa1b0c07fb KAMEZAWA Hiroyuki 2009-09-22  187  {
3089aa1b0c07fb KAMEZAWA Hiroyuki 2009-09-22  188  	struct list_head *head = (struct list_head *)arg;
3089aa1b0c07fb KAMEZAWA Hiroyuki 2009-09-22  189  	struct kcore_list *ent;
3955333df9a50e Laura Abbott      2018-05-11  190  	struct page *p;
3955333df9a50e Laura Abbott      2018-05-11  191  
3955333df9a50e Laura Abbott      2018-05-11  192  	if (!pfn_valid(pfn))
3955333df9a50e Laura Abbott      2018-05-11  193  		return 1;
3955333df9a50e Laura Abbott      2018-05-11  194  
3955333df9a50e Laura Abbott      2018-05-11  195  	p = pfn_to_page(pfn);
3089aa1b0c07fb KAMEZAWA Hiroyuki 2009-09-22  196  
3089aa1b0c07fb KAMEZAWA Hiroyuki 2009-09-22  197  	ent = kmalloc(sizeof(*ent), GFP_KERNEL);
3089aa1b0c07fb KAMEZAWA Hiroyuki 2009-09-22  198  	if (!ent)
3089aa1b0c07fb KAMEZAWA Hiroyuki 2009-09-22  199  		return -ENOMEM;
3955333df9a50e Laura Abbott      2018-05-11  200  	ent->addr = (unsigned long)page_to_virt(p);
3089aa1b0c07fb KAMEZAWA Hiroyuki 2009-09-22  201  	ent->size = nr_pages << PAGE_SHIFT;
3089aa1b0c07fb KAMEZAWA Hiroyuki 2009-09-22  202  
3955333df9a50e Laura Abbott      2018-05-11 @203  	if (!virt_addr_valid(ent->addr))
3089aa1b0c07fb KAMEZAWA Hiroyuki 2009-09-22  204  		goto free_out;
3089aa1b0c07fb KAMEZAWA Hiroyuki 2009-09-22  205  
3089aa1b0c07fb KAMEZAWA Hiroyuki 2009-09-22  206  	/* cut not-mapped area. ....from ppc-32 code. */
3089aa1b0c07fb KAMEZAWA Hiroyuki 2009-09-22  207  	if (ULONG_MAX - ent->addr < ent->size)
3089aa1b0c07fb KAMEZAWA Hiroyuki 2009-09-22  208  		ent->size = ULONG_MAX - ent->addr;
3089aa1b0c07fb KAMEZAWA Hiroyuki 2009-09-22  209  
3955333df9a50e Laura Abbott      2018-05-11  210  	/*
3955333df9a50e Laura Abbott      2018-05-11  211  	 * We've already checked virt_addr_valid so we know this address
3955333df9a50e Laura Abbott      2018-05-11  212  	 * is a valid pointer, therefore we can check against it to determine
3955333df9a50e Laura Abbott      2018-05-11  213  	 * if we need to trim
3955333df9a50e Laura Abbott      2018-05-11  214  	 */
3955333df9a50e Laura Abbott      2018-05-11  215  	if (VMALLOC_START > ent->addr) {
3089aa1b0c07fb KAMEZAWA Hiroyuki 2009-09-22  216  		if (VMALLOC_START - ent->addr < ent->size)
3089aa1b0c07fb KAMEZAWA Hiroyuki 2009-09-22  217  			ent->size = VMALLOC_START - ent->addr;
3089aa1b0c07fb KAMEZAWA Hiroyuki 2009-09-22  218  	}
3089aa1b0c07fb KAMEZAWA Hiroyuki 2009-09-22  219  
3089aa1b0c07fb KAMEZAWA Hiroyuki 2009-09-22  220  	ent->type = KCORE_RAM;
3089aa1b0c07fb KAMEZAWA Hiroyuki 2009-09-22  221  	list_add_tail(&ent->list, head);
26562c59fa9111 KAMEZAWA Hiroyuki 2009-09-22  222  
26562c59fa9111 KAMEZAWA Hiroyuki 2009-09-22  223  	if (!get_sparsemem_vmemmap_info(ent, head)) {
26562c59fa9111 KAMEZAWA Hiroyuki 2009-09-22  224  		list_del(&ent->list);
26562c59fa9111 KAMEZAWA Hiroyuki 2009-09-22  225  		goto free_out;
26562c59fa9111 KAMEZAWA Hiroyuki 2009-09-22  226  	}
26562c59fa9111 KAMEZAWA Hiroyuki 2009-09-22  227  
3089aa1b0c07fb KAMEZAWA Hiroyuki 2009-09-22  228  	return 0;
3089aa1b0c07fb KAMEZAWA Hiroyuki 2009-09-22  229  free_out:
3089aa1b0c07fb KAMEZAWA Hiroyuki 2009-09-22  230  	kfree(ent);
3089aa1b0c07fb KAMEZAWA Hiroyuki 2009-09-22  231  	return 1;
3089aa1b0c07fb KAMEZAWA Hiroyuki 2009-09-22  232  }
3089aa1b0c07fb KAMEZAWA Hiroyuki 2009-09-22  233  

:::::: The code at line 203 was first introduced by commit
:::::: 3955333df9a50e8783d115613a397ae55d905080 proc/kcore: don't bounds check against address 0

:::::: TO: Laura Abbott <labbott@redhat.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
