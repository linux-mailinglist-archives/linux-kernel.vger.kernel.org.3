Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75C44DE518
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 02:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241795AbiCSB5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 21:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234358AbiCSB5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 21:57:38 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8D12DF3DC
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 18:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647654978; x=1679190978;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sWnJUofww7turhwDyuiBzaZ/P/p8Lx1HnfGJwYBWq5k=;
  b=Og+yjvKY8p6YbW7Yi03y4ZTihv5fmjAYsb77REVJVVDZm6TIrlMRFoP/
   2ZxCDpnHrGbnDy8xAKu9fsD4H2J846mnzAQiGk8PWHToDh8ZTMpuJC5Yh
   ZAIyRKQB2JuGUVYlhX0BVfrmDnLpz5j0g5DK6iX1pXslYAuP4//xbi7TE
   k/d194ukt1GnKBxoPN6m9yejflgVR4xhmyP7rZZQFOz+WhhJMbD3wLoCp
   YqFh+L8QmFjYcdBsmyle+dFAG0g16CgIVZh6YQ7fLR8685RNp9axw44qo
   2DK0WD3UChcdWVbCNE3NqBgzWtj19du2SsalR8h8ONyCnudAW1o5ZFRw/
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="343699510"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="343699510"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 18:55:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="715738408"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 18 Mar 2022 18:55:56 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nVOJw-000FPT-9Q; Sat, 19 Mar 2022 01:55:56 +0000
Date:   Sat, 19 Mar 2022 09:55:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 221/2335] drivers/xen/grant-table.c:411:22: error:
 implicit declaration of function 'xen_gfn_to_pfn'; did you mean
 'xen_cr3_to_pfn'?
Message-ID: <202203190905.87HwuS9w-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   85293bf3fca6d85608cff1447ce3097583f15fab
commit: dbfd8a446611c67366513c5798b018f9d1b6123b [221/2335] headers/prep: Rename API: gfn_to_pfn() => xen_gfn_to_pfn()
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220319/202203190905.87HwuS9w-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=dbfd8a446611c67366513c5798b018f9d1b6123b
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout dbfd8a446611c67366513c5798b018f9d1b6123b
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/x86/include/asm/page.h:76,
                    from arch/x86/include/asm/thread_info.h:12,
                    from include/linux/thread_info.h:59,
                    from arch/x86/include/asm/preempt.h:7,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:10,
                    from include/linux/memblock.h:12,
                    from drivers/xen/grant-table.c:36:
   drivers/xen/grant-table.c: In function 'gnttab_add_deferred':
>> drivers/xen/grant-table.c:411:22: error: implicit declaration of function 'xen_gfn_to_pfn'; did you mean 'xen_cr3_to_pfn'? [-Werror=implicit-function-declaration]
     411 |   page = pfn_to_page(xen_gfn_to_pfn(gfn));
         |                      ^~~~~~~~~~~~~~
   include/asm-generic/memory_model.h:25:40: note: in definition of macro '__pfn_to_page'
      25 | #define __pfn_to_page(pfn) (vmemmap + (pfn))
         |                                        ^~~
   drivers/xen/grant-table.c:411:10: note: in expansion of macro 'pfn_to_page'
     411 |   page = pfn_to_page(xen_gfn_to_pfn(gfn));
         |          ^~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +411 drivers/xen/grant-table.c

   399	
   400	static void gnttab_add_deferred(grant_ref_t ref, bool readonly,
   401					struct page *page)
   402	{
   403		struct deferred_entry *entry;
   404		gfp_t gfp = (in_atomic() || irqs_disabled()) ? GFP_ATOMIC : GFP_KERNEL;
   405		const char *what = KERN_WARNING "leaking";
   406	
   407		entry = kmalloc(sizeof(*entry), gfp);
   408		if (!page) {
   409			unsigned long gfn = gnttab_interface->read_frame(ref);
   410	
 > 411			page = pfn_to_page(xen_gfn_to_pfn(gfn));
   412			get_page(page);
   413		}
   414	
   415		if (entry) {
   416			unsigned long flags;
   417	
   418			entry->ref = ref;
   419			entry->ro = readonly;
   420			entry->page = page;
   421			entry->warn_delay = 60;
   422			spin_lock_irqsave(&gnttab_list_lock, flags);
   423			list_add_tail(&entry->list, &deferred_list);
   424			if (!timer_pending(&deferred_timer)) {
   425				deferred_timer.expires = jiffies + HZ;
   426				add_timer(&deferred_timer);
   427			}
   428			spin_unlock_irqrestore(&gnttab_list_lock, flags);
   429			what = KERN_DEBUG "deferring";
   430		}
   431		printk("%s g.e. %#x (pfn %#lx)\n",
   432		       what, ref, page ? page_to_pfn(page) : -1);
   433	}
   434	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
