Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6DC55EDF5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 21:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbiF1Tna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 15:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbiF1Tmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 15:42:53 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C460A3F329
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 12:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656444932; x=1687980932;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2oUw14+QB/xaskcnfyCWcya1uXzyvTLVtoyz0zSKhs8=;
  b=UQeniPKvHPGJyonpeT7vLZc4aWUdXKNTXfelygJ7NVsER6bdCQvOfSMu
   uzC3v+4lGVDZGIRH6a2zxPN4V3bT4njiKonhVNjSBEgEcNyD6w2sD2Uda
   oRZsKYBbLcobJowwSs2uV0UEAg1VB4Yuc2rXll/NwlTyGMeqCU9SEAnrg
   9AKuaL7DjEloOmV//j16Z+kowAIIu3PxImZVe5mEuNHcanRU45lOt4YIh
   YmKU+evgbzMV0j8EIishUs8Y/+tTmc+FkVTQACqxDzmsxFhSG/udhUYDI
   m18NkE+A/JQuCzRAozDA2GLnVsEVyBvd+tAhe3JWveNaXQ84LVpO6biZz
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="264871805"
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="264871805"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 12:35:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="658253835"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jun 2022 12:35:30 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o6Gzi-000AZA-2Y;
        Tue, 28 Jun 2022 19:35:30 +0000
Date:   Wed, 29 Jun 2022 03:35:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Subject: [jlayton:netfs-linked-list 26/54] include/linux/page-flags.h:788:20:
 error: passing 'const struct page *' to parameter of type 'struct page *'
 discards qualifiers
Message-ID: <202206290318.tpiiSqSW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git netfs-linked-list
head:   d35a2461e039c9131e97bb125eac59a0f04e9161
commit: 06b03c53376206f3b98cc4dbb1f061a10085309b [26/54] mm: Make some folio function arguments const
config: x86_64-randconfig-a003-20220627 (https://download.01.org/0day-ci/archive/20220629/202206290318.tpiiSqSW-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project df18167ac56d05f2ab55f9d874aee7ab6d5bc9a2)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git/commit/?id=06b03c53376206f3b98cc4dbb1f061a10085309b
        git remote add jlayton https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git
        git fetch --no-tags jlayton netfs-linked-list
        git checkout 06b03c53376206f3b98cc4dbb1f061a10085309b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/x86/kernel/asm-offsets.c:9:
   In file included from include/linux/crypto.h:20:
   In file included from include/linux/slab.h:15:
   In file included from include/linux/gfp.h:6:
   In file included from include/linux/mmzone.h:22:
>> include/linux/page-flags.h:788:20: error: passing 'const struct page *' to parameter of type 'struct page *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
           PF_POISONED_CHECK(page);
                             ^~~~
   include/linux/page-flags.h:370:41: note: expanded from macro 'PF_POISONED_CHECK'
                   VM_BUG_ON_PGFLAGS(PagePoisoned(page), page);            \
                                                         ^~~~
   include/linux/mmdebug.h:94:60: note: expanded from macro 'VM_BUG_ON_PGFLAGS'
   #define VM_BUG_ON_PGFLAGS(cond, page) VM_BUG_ON_PAGE(cond, page)
                                                              ^~~~
   include/linux/mmdebug.h:21:14: note: expanded from macro 'VM_BUG_ON_PAGE'
                           dump_page(page, "VM_BUG_ON_PAGE(" __stringify(cond)")");\
                                     ^~~~
   include/linux/mmdebug.h:12:29: note: passing argument to parameter 'page' here
   void dump_page(struct page *page, const char *reason);
                               ^
   1 error generated.
   make[2]: *** [scripts/Makefile.build:117: arch/x86/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1200: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +788 include/linux/page-flags.h

e7d324850bfcb30 Muchun Song   2022-03-22  785  
06b03c53376206f David Howells 2022-06-08  786  static __always_inline int PageHead(const struct page *page)
e7d324850bfcb30 Muchun Song   2022-03-22  787  {
e7d324850bfcb30 Muchun Song   2022-03-22 @788  	PF_POISONED_CHECK(page);
e7d324850bfcb30 Muchun Song   2022-03-22  789  	return test_bit(PG_head, &page->flags) && !page_is_fake_head(page);
e7d324850bfcb30 Muchun Song   2022-03-22  790  }
e7d324850bfcb30 Muchun Song   2022-03-22  791  

:::::: The code at line 788 was first introduced by commit
:::::: e7d324850bfcb30df563d144c0363cc44595277d mm: hugetlb: free the 2nd vmemmap page associated with each HugeTLB page

:::::: TO: Muchun Song <songmuchun@bytedance.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
