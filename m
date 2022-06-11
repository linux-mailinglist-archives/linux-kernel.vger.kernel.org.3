Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925ED54718D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 05:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349767AbiFKDTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 23:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236391AbiFKDTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 23:19:04 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26971FD3DB
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 20:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654917542; x=1686453542;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BawRY861fwQuKRem7KOqSNVlXQXLixNJYY9rLROhjT4=;
  b=B0F7uDCka0vOnLw3XM1RhOmvSjFJlHYAI8hfVhgTk5BiLULiOm8jpd+3
   6NCMTPKIUp5tu/GWLVELBiEPxfVCE2BX50U3tsueturiYk9abYb9Ij2l2
   Wh49SjtDqepOb0LdfB4qyF64xG0yYfD0Jxsf1ybT2CeIziCZxdarUfJ8/
   n3ZmcPYhxRmOfb3HJ8/SWLwdgOdgR43lG4JBrT2yGSNHOrAIIR+q1sxQJ
   gb1/QzrvfntAPuvEAd+zCz8CBYh2FWkN2V1w6B3wN0phoU2UE2+FdoZaR
   axzIWbreiXsphpgYZ+e/it8dV35q/ozRqJFaIAK2eIIN43gBk7pXQCmEa
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="258246465"
X-IronPort-AV: E=Sophos;i="5.91,292,1647327600"; 
   d="scan'208";a="258246465"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 20:19:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,292,1647327600"; 
   d="scan'208";a="828578832"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 10 Jun 2022 20:19:00 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzreN-000IVF-Ub;
        Sat, 11 Jun 2022 03:18:59 +0000
Date:   Sat, 11 Jun 2022 11:18:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-linked-list 29/57]
 include/linux/page-flags.h:788:27: warning: passing argument 1 of
 'dump_page' discards 'const' qualifier from pointer target type
Message-ID: <202206111120.hjvhr7ho-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-linked-list
head:   c19d336b7f0c53bd31e73f6d7d6c1524f0df55b8
commit: f951c9604853872cf088bb3dbf7d49e3f96b090d [29/57] mm: Make some folio function arguments const
config: i386-randconfig-a001 (https://download.01.org/0day-ci/archive/20220611/202206111120.hjvhr7ho-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/f951c9604853872cf088bb3dbf7d49e3f96b090d
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-linked-list
        git checkout f951c9604853872cf088bb3dbf7d49e3f96b090d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/gfp.h:5,
                    from include/linux/slab.h:15,
                    from include/linux/crypto.h:20,
                    from arch/x86/kernel/asm-offsets.c:9:
   include/linux/page-flags.h: In function 'PageHead':
>> include/linux/page-flags.h:788:27: warning: passing argument 1 of 'dump_page' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     788 |         PF_POISONED_CHECK(page);
         |                           ^~~~
   include/linux/mmdebug.h:21:35: note: in definition of macro 'VM_BUG_ON_PAGE'
      21 |                         dump_page(page, "VM_BUG_ON_PAGE(" __stringify(cond)")");\
         |                                   ^~~~
   include/linux/page-flags.h:370:17: note: in expansion of macro 'VM_BUG_ON_PGFLAGS'
     370 |                 VM_BUG_ON_PGFLAGS(PagePoisoned(page), page);            \
         |                 ^~~~~~~~~~~~~~~~~
   include/linux/page-flags.h:788:9: note: in expansion of macro 'PF_POISONED_CHECK'
     788 |         PF_POISONED_CHECK(page);
         |         ^~~~~~~~~~~~~~~~~
   include/linux/mmdebug.h:12:29: note: expected 'struct page *' but argument is of type 'const struct page *'
      12 | void dump_page(struct page *page, const char *reason);
         |                ~~~~~~~~~~~~~^~~~
--
   In file included from include/linux/percpu.h:5,
                    from include/linux/hrtimer.h:19,
                    from include/linux/sched.h:19,
                    from include/linux/ptrace.h:6,
                    from lib/syscall.c:2:
   include/linux/page-flags.h: In function 'PageHead':
>> include/linux/page-flags.h:788:27: warning: passing argument 1 of 'dump_page' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     788 |         PF_POISONED_CHECK(page);
         |                           ^~~~
   include/linux/mmdebug.h:21:35: note: in definition of macro 'VM_BUG_ON_PAGE'
      21 |                         dump_page(page, "VM_BUG_ON_PAGE(" __stringify(cond)")");\
         |                                   ^~~~
   include/linux/page-flags.h:370:17: note: in expansion of macro 'VM_BUG_ON_PGFLAGS'
     370 |                 VM_BUG_ON_PGFLAGS(PagePoisoned(page), page);            \
         |                 ^~~~~~~~~~~~~~~~~
   include/linux/page-flags.h:788:9: note: in expansion of macro 'PF_POISONED_CHECK'
     788 |         PF_POISONED_CHECK(page);
         |         ^~~~~~~~~~~~~~~~~
   include/linux/mmdebug.h:12:29: note: expected 'struct page *' but argument is of type 'const struct page *'
      12 | void dump_page(struct page *page, const char *reason);
         |                ~~~~~~~~~~~~~^~~~
   In file included from include/linux/string.h:253,
                    from arch/x86/include/asm/page_32.h:22,
                    from arch/x86/include/asm/page.h:14,
                    from arch/x86/include/asm/thread_info.h:12,
                    from include/linux/thread_info.h:60,
                    from arch/x86/include/asm/preempt.h:7,
                    from include/linux/preempt.h:78,
                    from include/linux/rcupdate.h:27,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/ptrace.h:6,
                    from lib/syscall.c:2:
   In function 'fortify_memcpy_chk',
       inlined from 'syscall_get_arguments' at arch/x86/include/asm/syscall.h:87:2,
       inlined from 'collect_syscall' at lib/syscall.c:31:3:
   include/linux/fortify-string.h:352:25: warning: call to '__read_overflow2_field' declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Wattribute-warning]
     352 |                         __read_overflow2_field(q_size_field, size);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/gfp.h:5,
                    from include/linux/xarray.h:15,
                    from include/linux/list_lru.h:14,
                    from include/linux/fs.h:13,
                    from include/linux/decompress/mm.h:80,
                    from lib/decompress_inflate.c:32:
   include/linux/page-flags.h: In function 'PageHead':
>> include/linux/page-flags.h:788:27: warning: passing argument 1 of 'dump_page' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     788 |         PF_POISONED_CHECK(page);
         |                           ^~~~
   include/linux/mmdebug.h:21:35: note: in definition of macro 'VM_BUG_ON_PAGE'
      21 |                         dump_page(page, "VM_BUG_ON_PAGE(" __stringify(cond)")");\
         |                                   ^~~~
   include/linux/page-flags.h:370:17: note: in expansion of macro 'VM_BUG_ON_PGFLAGS'
     370 |                 VM_BUG_ON_PGFLAGS(PagePoisoned(page), page);            \
         |                 ^~~~~~~~~~~~~~~~~
   include/linux/page-flags.h:788:9: note: in expansion of macro 'PF_POISONED_CHECK'
     788 |         PF_POISONED_CHECK(page);
         |         ^~~~~~~~~~~~~~~~~
   include/linux/mmdebug.h:12:29: note: expected 'struct page *' but argument is of type 'const struct page *'
      12 | void dump_page(struct page *page, const char *reason);
         |                ~~~~~~~~~~~~~^~~~
   lib/decompress_inflate.c: At top level:
   lib/decompress_inflate.c:42:17: warning: no previous prototype for '__gunzip' [-Wmissing-prototypes]
      42 | STATIC int INIT __gunzip(unsigned char *buf, long len,
         |                 ^~~~~~~~
--
   In file included from include/linux/gfp.h:5,
                    from include/linux/xarray.h:15,
                    from include/linux/list_lru.h:14,
                    from include/linux/fs.h:13,
                    from include/linux/decompress/mm.h:80,
                    from lib/decompress_unxz.c:107:
   include/linux/page-flags.h: In function 'PageHead':
>> include/linux/page-flags.h:788:27: warning: passing argument 1 of 'dump_page' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     788 |         PF_POISONED_CHECK(page);
         |                           ^~~~
   include/linux/mmdebug.h:21:35: note: in definition of macro 'VM_BUG_ON_PAGE'
      21 |                         dump_page(page, "VM_BUG_ON_PAGE(" __stringify(cond)")");\
         |                                   ^~~~
   include/linux/page-flags.h:370:17: note: in expansion of macro 'VM_BUG_ON_PGFLAGS'
     370 |                 VM_BUG_ON_PGFLAGS(PagePoisoned(page), page);            \
         |                 ^~~~~~~~~~~~~~~~~
   include/linux/page-flags.h:788:9: note: in expansion of macro 'PF_POISONED_CHECK'
     788 |         PF_POISONED_CHECK(page);
         |         ^~~~~~~~~~~~~~~~~
   include/linux/mmdebug.h:12:29: note: expected 'struct page *' but argument is of type 'const struct page *'
      12 | void dump_page(struct page *page, const char *reason);
         |                ~~~~~~~~~~~~~^~~~
   lib/decompress_unxz.c: At top level:
   lib/decompress_unxz.c:251:17: warning: no previous prototype for 'unxz' [-Wmissing-prototypes]
     251 | STATIC int INIT unxz(unsigned char *in, long in_size,
         |                 ^~~~
--
   In file included from include/linux/percpu.h:5,
                    from include/linux/hrtimer.h:19,
                    from include/linux/sched.h:19,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from lib/radix-tree.c:15:
   include/linux/page-flags.h: In function 'PageHead':
>> include/linux/page-flags.h:788:27: warning: passing argument 1 of 'dump_page' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     788 |         PF_POISONED_CHECK(page);
         |                           ^~~~
   include/linux/mmdebug.h:21:35: note: in definition of macro 'VM_BUG_ON_PAGE'
      21 |                         dump_page(page, "VM_BUG_ON_PAGE(" __stringify(cond)")");\
         |                                   ^~~~
   include/linux/page-flags.h:370:17: note: in expansion of macro 'VM_BUG_ON_PGFLAGS'
     370 |                 VM_BUG_ON_PGFLAGS(PagePoisoned(page), page);            \
         |                 ^~~~~~~~~~~~~~~~~
   include/linux/page-flags.h:788:9: note: in expansion of macro 'PF_POISONED_CHECK'
     788 |         PF_POISONED_CHECK(page);
         |         ^~~~~~~~~~~~~~~~~
   include/linux/mmdebug.h:12:29: note: expected 'struct page *' but argument is of type 'const struct page *'
      12 | void dump_page(struct page *page, const char *reason);
         |                ~~~~~~~~~~~~~^~~~
   lib/radix-tree.c: At top level:
   lib/radix-tree.c:288:6: warning: no previous prototype for 'radix_tree_node_rcu_free' [-Wmissing-prototypes]
     288 | void radix_tree_node_rcu_free(struct rcu_head *head)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/gfp.h:5,
                    from include/linux/radix-tree.h:12,
                    from include/linux/idr.h:15,
                    from include/linux/kernfs.h:12,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from include/linux/clk-provider.h:9,
                    from lib/vsprintf.c:23:
   include/linux/page-flags.h: In function 'PageHead':
>> include/linux/page-flags.h:788:27: warning: passing argument 1 of 'dump_page' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     788 |         PF_POISONED_CHECK(page);
         |                           ^~~~
   include/linux/mmdebug.h:21:35: note: in definition of macro 'VM_BUG_ON_PAGE'
      21 |                         dump_page(page, "VM_BUG_ON_PAGE(" __stringify(cond)")");\
         |                                   ^~~~
   include/linux/page-flags.h:370:17: note: in expansion of macro 'VM_BUG_ON_PGFLAGS'
     370 |                 VM_BUG_ON_PGFLAGS(PagePoisoned(page), page);            \
         |                 ^~~~~~~~~~~~~~~~~
   include/linux/page-flags.h:788:9: note: in expansion of macro 'PF_POISONED_CHECK'
     788 |         PF_POISONED_CHECK(page);
         |         ^~~~~~~~~~~~~~~~~
   include/linux/mmdebug.h:12:29: note: expected 'struct page *' but argument is of type 'const struct page *'
      12 | void dump_page(struct page *page, const char *reason);
         |                ~~~~~~~~~~~~~^~~~
   lib/vsprintf.c: In function 'va_format':
   lib/vsprintf.c:1681:9: warning: function 'va_format' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    1681 |         buf += vsnprintf(buf, end > buf ? end - buf : 0, va_fmt->fmt, va);
         |         ^~~
--
   In file included from include/linux/gfp.h:5,
                    from include/linux/radix-tree.h:12,
                    from include/linux/idr.h:15,
                    from include/linux/kernfs.h:12,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from drivers/i2c/busses/i2c-cros-ec-tunnel.c:6:
   include/linux/page-flags.h: In function 'PageHead':
>> include/linux/page-flags.h:788:27: warning: passing argument 1 of 'dump_page' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     788 |         PF_POISONED_CHECK(page);
         |                           ^~~~
   include/linux/mmdebug.h:21:35: note: in definition of macro 'VM_BUG_ON_PAGE'
      21 |                         dump_page(page, "VM_BUG_ON_PAGE(" __stringify(cond)")");\
         |                                   ^~~~
   include/linux/page-flags.h:370:17: note: in expansion of macro 'VM_BUG_ON_PGFLAGS'
     370 |                 VM_BUG_ON_PGFLAGS(PagePoisoned(page), page);            \
         |                 ^~~~~~~~~~~~~~~~~
   include/linux/page-flags.h:788:9: note: in expansion of macro 'PF_POISONED_CHECK'
     788 |         PF_POISONED_CHECK(page);
         |         ^~~~~~~~~~~~~~~~~
   include/linux/mmdebug.h:12:29: note: expected 'struct page *' but argument is of type 'const struct page *'
      12 | void dump_page(struct page *page, const char *reason);
         |                ~~~~~~~~~~~~~^~~~
   At top level:
   drivers/i2c/busses/i2c-cros-ec-tunnel.c:295:34: warning: 'cros_ec_i2c_of_match' defined but not used [-Wunused-const-variable=]
     295 | static const struct of_device_id cros_ec_i2c_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/gfp.h:5,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from include/linux/module.h:17,
                    from lib/lz4/lz4_decompress.c:39:
   include/linux/page-flags.h: In function 'PageHead':
>> include/linux/page-flags.h:788:27: warning: passing argument 1 of 'dump_page' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     788 |         PF_POISONED_CHECK(page);
         |                           ^~~~
   include/linux/mmdebug.h:21:35: note: in definition of macro 'VM_BUG_ON_PAGE'
      21 |                         dump_page(page, "VM_BUG_ON_PAGE(" __stringify(cond)")");\
         |                                   ^~~~
   include/linux/page-flags.h:370:17: note: in expansion of macro 'VM_BUG_ON_PGFLAGS'
     370 |                 VM_BUG_ON_PGFLAGS(PagePoisoned(page), page);            \
         |                 ^~~~~~~~~~~~~~~~~
   include/linux/page-flags.h:788:9: note: in expansion of macro 'PF_POISONED_CHECK'
     788 |         PF_POISONED_CHECK(page);
         |         ^~~~~~~~~~~~~~~~~
   include/linux/mmdebug.h:12:29: note: expected 'struct page *' but argument is of type 'const struct page *'
      12 | void dump_page(struct page *page, const char *reason);
         |                ~~~~~~~~~~~~~^~~~
   lib/lz4/lz4_decompress.c: At top level:
   lib/lz4/lz4_decompress.c:510:5: warning: no previous prototype for 'LZ4_decompress_safe_forceExtDict' [-Wmissing-prototypes]
     510 | int LZ4_decompress_safe_forceExtDict(const char *source, char *dest,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/gfp.h:5,
                    from include/linux/slab.h:15,
                    from include/linux/crypto.h:20,
                    from arch/x86/kernel/asm-offsets.c:9:
   include/linux/page-flags.h: In function 'PageHead':
>> include/linux/page-flags.h:788:27: warning: passing argument 1 of 'dump_page' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     788 |         PF_POISONED_CHECK(page);
         |                           ^~~~
   include/linux/mmdebug.h:21:35: note: in definition of macro 'VM_BUG_ON_PAGE'
      21 |                         dump_page(page, "VM_BUG_ON_PAGE(" __stringify(cond)")");\
         |                                   ^~~~
   include/linux/page-flags.h:370:17: note: in expansion of macro 'VM_BUG_ON_PGFLAGS'
     370 |                 VM_BUG_ON_PGFLAGS(PagePoisoned(page), page);            \
         |                 ^~~~~~~~~~~~~~~~~
   include/linux/page-flags.h:788:9: note: in expansion of macro 'PF_POISONED_CHECK'
     788 |         PF_POISONED_CHECK(page);
         |         ^~~~~~~~~~~~~~~~~
   include/linux/mmdebug.h:12:29: note: expected 'struct page *' but argument is of type 'const struct page *'
      12 | void dump_page(struct page *page, const char *reason);
         |                ~~~~~~~~~~~~~^~~~


vim +788 include/linux/page-flags.h

e7d324850bfcb3 Muchun Song   2022-03-22  785  
f951c960485387 David Howells 2022-06-08  786  static __always_inline int PageHead(const struct page *page)
e7d324850bfcb3 Muchun Song   2022-03-22  787  {
e7d324850bfcb3 Muchun Song   2022-03-22 @788  	PF_POISONED_CHECK(page);
e7d324850bfcb3 Muchun Song   2022-03-22  789  	return test_bit(PG_head, &page->flags) && !page_is_fake_head(page);
e7d324850bfcb3 Muchun Song   2022-03-22  790  }
e7d324850bfcb3 Muchun Song   2022-03-22  791  

:::::: The code at line 788 was first introduced by commit
:::::: e7d324850bfcb30df563d144c0363cc44595277d mm: hugetlb: free the 2nd vmemmap page associated with each HugeTLB page

:::::: TO: Muchun Song <songmuchun@bytedance.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
