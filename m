Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D074DBF97
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 07:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiCQGlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 02:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiCQGli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 02:41:38 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C370BF007
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 23:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647499222; x=1679035222;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=r7hl2LrJPwgi1RBOzhXRymcPhWFGbQY2+v5xbTf7Wwg=;
  b=W64HxG2WIUATCBqfgJZo1Cq3gO91udm8xwU9HT52JFCxNcWEyZkxqwyt
   hLNklzML9LH+AVTeWETlCpMeWyAWCECe4gC/iTDm1Bn5Cn2AQDi2YmsnY
   92pRJ+h3I9Vq8O8ipiSl42c0bvmRNJi/GFzkmfKIenQigwmZmTSdL2XG5
   WwDorj/c3ll8g+rNRrXFvqKDOWxzrqAGcu5NGel0418O6R1hbMCU3zf2Q
   Si9bA/+aeUi/T8vJW7btqfrGI08fOHsJ3QZpNAsYAlSO1cJa61g1FWxZX
   jdi/6gJ3aU7msWOc1zgZz30Vozzh9jq/B8BJ5uHyH1FWMwuaMKQGEN35R
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="238959187"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="238959187"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 23:40:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="516648606"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 16 Mar 2022 23:40:20 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUjo3-000DOc-MQ; Thu, 17 Mar 2022 06:40:19 +0000
Date:   Thu, 17 Mar 2022 14:39:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 221/2335] drivers/xen/grant-table.c:411:22: error:
 implicit declaration of function 'xen_gfn_to_pfn'
Message-ID: <202203171426.IezxkFRk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   85293bf3fca6d85608cff1447ce3097583f15fab
commit: dbfd8a446611c67366513c5798b018f9d1b6123b [221/2335] headers/prep: Rename API: gfn_to_pfn() => xen_gfn_to_pfn()
config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive/20220317/202203171426.IezxkFRk-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6ec1e3d798f8eab43fb3a91028c6ab04e115fcb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=dbfd8a446611c67366513c5798b018f9d1b6123b
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout dbfd8a446611c67366513c5798b018f9d1b6123b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/xen/grant-table.c:411:22: error: implicit declaration of function 'xen_gfn_to_pfn' [-Werror,-Wimplicit-function-declaration]
                   page = pfn_to_page(xen_gfn_to_pfn(gfn));
                                      ^
   include/asm-generic/memory_model.h:53:21: note: expanded from macro 'pfn_to_page'
   #define pfn_to_page __pfn_to_page
                       ^
   drivers/xen/grant-table.c:411:22: note: did you mean 'gfn_to_pfn'?
   include/asm-generic/memory_model.h:53:21: note: expanded from macro 'pfn_to_page'
   #define pfn_to_page __pfn_to_page
                       ^
   arch/x86/include/asm/xen/page.h:251:29: note: 'gfn_to_pfn' declared here
   static inline unsigned long gfn_to_pfn(unsigned long gfn)
                               ^
   1 error generated.


vim +/xen_gfn_to_pfn +411 drivers/xen/grant-table.c

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
