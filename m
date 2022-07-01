Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457B0562B00
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 07:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbiGAFqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 01:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbiGAFqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 01:46:34 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970A668A38
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 22:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656654392; x=1688190392;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OC5SBKk0EhMnYvZ5BQayu9p4EnHpyiqYXsEjsljP2kc=;
  b=mpI96zbU5Jw+UEqrxGHwXq7y8dHNVqETo0W5pw4d4cJmBfZqQYa1Cuuu
   +HjU98ab6G6id/v2edMqIMJ2RdxcjCZGpmxRVROaP5Ju9AIqvR5G0yQFc
   U6Pf3Sbx16VPgWjdrjiL7OVIrKrM6c91NHCsdHj8rekgjDerbQPxWaQsJ
   rNFn5KpzyhlFPyz49V5322J13i+UfiN1EYTgf0RWkpzWlzyyuf1TWITaL
   DUXTRhoCnW5PmB6tk1w6BHmqrLaFklIxMDdNGbtZt0IMMmnMx92u2dokB
   fHI4deOB7dZ8oDnF03E3YVE38zetExI2xNmkVxH63t4a41Z7ZvvE/gXhX
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="283658977"
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="283658977"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 22:46:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="659303736"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 30 Jun 2022 22:46:28 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o79U4-000Dc6-3H;
        Fri, 01 Jul 2022 05:46:28 +0000
Date:   Fri, 1 Jul 2022 13:46:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-linked-list 53/56]
 fs/erofs/fscache.c:21:29: error: 'struct netfs_io_request' has no member
 named 'subrequests'
Message-ID: <202207011330.pej34H71-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-linked-list
head:   acac17cdb0f9f6db9fc03eea371e399906146f96
commit: e479d37c5fc583c860ac76575696ea8f69629cc7 [53/56] netfs: Add subrequest chains to I/O requests
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220701/202207011330.pej34H71-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/e479d37c5fc583c860ac76575696ea8f69629cc7
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-linked-list
        git checkout e479d37c5fc583c860ac76575696ea8f69629cc7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/gfp.h:5,
                    from include/linux/xarray.h:15,
                    from include/linux/list_lru.h:14,
                    from include/linux/fs.h:13,
                    from include/linux/fscache.h:17,
                    from fs/erofs/fscache.c:5:
   include/linux/page-flags.h: In function 'PageHead':
   include/linux/page-flags.h:788:27: warning: passing argument 1 of 'dump_page' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
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
   fs/erofs/fscache.c: In function 'erofs_fscache_alloc_request':
>> fs/erofs/fscache.c:21:29: error: 'struct netfs_io_request' has no member named 'subrequests'
      21 |         INIT_LIST_HEAD(&rreq->subrequests);
         |                             ^~
   fs/erofs/fscache.c: In function 'erofs_fscache_clear_subrequests':
   fs/erofs/fscache.c:47:33: error: 'struct netfs_io_request' has no member named 'subrequests'
      47 |         while (!list_empty(&rreq->subrequests)) {
         |                                 ^~
   In file included from include/linux/list.h:5,
                    from include/linux/wait.h:7,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from include/linux/fscache.h:17,
                    from fs/erofs/fscache.c:5:
   fs/erofs/fscache.c:48:48: error: 'struct netfs_io_request' has no member named 'subrequests'
      48 |                 subreq = list_first_entry(&rreq->subrequests,
         |                                                ^~
   include/linux/container_of.h:18:33: note: in definition of macro 'container_of'
      18 |         void *__mptr = (void *)(ptr);                                   \
         |                                 ^~~
   include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
     531 |         list_entry((ptr)->next, type, member)
         |         ^~~~~~~~~~
   fs/erofs/fscache.c:48:26: note: in expansion of macro 'list_first_entry'
      48 |                 subreq = list_first_entry(&rreq->subrequests,
         |                          ^~~~~~~~~~~~~~~~
   In file included from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/wait.h:7,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from include/linux/fscache.h:17,
                    from fs/erofs/fscache.c:5:
   fs/erofs/fscache.c:48:48: error: 'struct netfs_io_request' has no member named 'subrequests'
      48 |                 subreq = list_first_entry(&rreq->subrequests,
         |                                                ^~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:19:9: note: in expansion of macro 'static_assert'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:19:23: note: in expansion of macro '__same_type'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/list.h:520:9: note: in expansion of macro 'container_of'
     520 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
     531 |         list_entry((ptr)->next, type, member)
         |         ^~~~~~~~~~
   fs/erofs/fscache.c:48:26: note: in expansion of macro 'list_first_entry'
      48 |                 subreq = list_first_entry(&rreq->subrequests,
         |                          ^~~~~~~~~~~~~~~~
>> include/linux/container_of.h:19:54: error: 'struct netfs_io_subrequest' has no member named 'rreq_link'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                                                      ^~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:19:9: note: in expansion of macro 'static_assert'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:19:23: note: in expansion of macro '__same_type'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/list.h:520:9: note: in expansion of macro 'container_of'
     520 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
     531 |         list_entry((ptr)->next, type, member)
         |         ^~~~~~~~~~
   fs/erofs/fscache.c:48:26: note: in expansion of macro 'list_first_entry'
      48 |                 subreq = list_first_entry(&rreq->subrequests,
         |                          ^~~~~~~~~~~~~~~~
   fs/erofs/fscache.c:48:48: error: 'struct netfs_io_request' has no member named 'subrequests'
      48 |                 subreq = list_first_entry(&rreq->subrequests,
         |                                                ^~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:19:9: note: in expansion of macro 'static_assert'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |                       __same_type(*(ptr), void),                        \
         |                       ^~~~~~~~~~~
   include/linux/list.h:520:9: note: in expansion of macro 'container_of'
     520 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
     531 |         list_entry((ptr)->next, type, member)
         |         ^~~~~~~~~~
   fs/erofs/fscache.c:48:26: note: in expansion of macro 'list_first_entry'
      48 |                 subreq = list_first_entry(&rreq->subrequests,
         |                          ^~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:293:27: error: expression in static assertion is not an integer
     293 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:19:9: note: in expansion of macro 'static_assert'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:19:23: note: in expansion of macro '__same_type'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/list.h:520:9: note: in expansion of macro 'container_of'
     520 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
     531 |         list_entry((ptr)->next, type, member)
         |         ^~~~~~~~~~
   fs/erofs/fscache.c:48:26: note: in expansion of macro 'list_first_entry'
      48 |                 subreq = list_first_entry(&rreq->subrequests,
         |                          ^~~~~~~~~~~~~~~~
   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/kasan-checks.h:5,
                    from include/asm-generic/rwonce.h:26,
                    from ./arch/mips/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:248,
                    from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/wait.h:7,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from include/linux/fscache.h:17,
                    from fs/erofs/fscache.c:5:
>> include/linux/stddef.h:16:33: error: 'struct netfs_io_subrequest' has no member named 'rreq_link'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                 ^~~~~~~~~~~~~~~~~~
   include/linux/container_of.h:22:28: note: in expansion of macro 'offsetof'
      22 |         ((type *)(__mptr - offsetof(type, member))); })
         |                            ^~~~~~~~
   include/linux/list.h:520:9: note: in expansion of macro 'container_of'
     520 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
     531 |         list_entry((ptr)->next, type, member)
         |         ^~~~~~~~~~
   fs/erofs/fscache.c:48:26: note: in expansion of macro 'list_first_entry'
      48 |                 subreq = list_first_entry(&rreq->subrequests,
         |                          ^~~~~~~~~~~~~~~~
>> fs/erofs/fscache.c:50:33: error: 'struct netfs_io_subrequest' has no member named 'rreq_link'
      50 |                 list_del(&subreq->rreq_link);
         |                                 ^~
   In file included from include/linux/list.h:5,
                    from include/linux/wait.h:7,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from include/linux/fscache.h:17,
                    from fs/erofs/fscache.c:5:
   fs/erofs/fscache.c: In function 'erofs_fscache_rreq_unlock_folios':
   fs/erofs/fscache.c:66:40: error: 'struct netfs_io_request' has no member named 'subrequests'
      66 |         subreq = list_first_entry(&rreq->subrequests,
         |                                        ^~
   include/linux/container_of.h:18:33: note: in definition of macro 'container_of'
      18 |         void *__mptr = (void *)(ptr);                                   \
         |                                 ^~~
   include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
     531 |         list_entry((ptr)->next, type, member)
         |         ^~~~~~~~~~
   fs/erofs/fscache.c:66:18: note: in expansion of macro 'list_first_entry'
      66 |         subreq = list_first_entry(&rreq->subrequests,
         |                  ^~~~~~~~~~~~~~~~
   In file included from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/wait.h:7,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from include/linux/fscache.h:17,
                    from fs/erofs/fscache.c:5:
   fs/erofs/fscache.c:66:40: error: 'struct netfs_io_request' has no member named 'subrequests'
      66 |         subreq = list_first_entry(&rreq->subrequests,
         |                                        ^~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:19:9: note: in expansion of macro 'static_assert'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:19:23: note: in expansion of macro '__same_type'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/list.h:520:9: note: in expansion of macro 'container_of'
     520 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
     531 |         list_entry((ptr)->next, type, member)
         |         ^~~~~~~~~~
   fs/erofs/fscache.c:66:18: note: in expansion of macro 'list_first_entry'
      66 |         subreq = list_first_entry(&rreq->subrequests,
         |                  ^~~~~~~~~~~~~~~~
>> include/linux/container_of.h:19:54: error: 'struct netfs_io_subrequest' has no member named 'rreq_link'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                                                      ^~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:19:9: note: in expansion of macro 'static_assert'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:19:23: note: in expansion of macro '__same_type'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/list.h:520:9: note: in expansion of macro 'container_of'
     520 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
     531 |         list_entry((ptr)->next, type, member)
         |         ^~~~~~~~~~
   fs/erofs/fscache.c:66:18: note: in expansion of macro 'list_first_entry'
      66 |         subreq = list_first_entry(&rreq->subrequests,
         |                  ^~~~~~~~~~~~~~~~
   fs/erofs/fscache.c:66:40: error: 'struct netfs_io_request' has no member named 'subrequests'
      66 |         subreq = list_first_entry(&rreq->subrequests,
         |                                        ^~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:19:9: note: in expansion of macro 'static_assert'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |                       __same_type(*(ptr), void),                        \
         |                       ^~~~~~~~~~~
   include/linux/list.h:520:9: note: in expansion of macro 'container_of'
     520 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
     531 |         list_entry((ptr)->next, type, member)
         |         ^~~~~~~~~~
   fs/erofs/fscache.c:66:18: note: in expansion of macro 'list_first_entry'
      66 |         subreq = list_first_entry(&rreq->subrequests,
         |                  ^~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:293:27: error: expression in static assertion is not an integer
     293 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:19:9: note: in expansion of macro 'static_assert'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:19:23: note: in expansion of macro '__same_type'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/list.h:520:9: note: in expansion of macro 'container_of'
     520 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
     531 |         list_entry((ptr)->next, type, member)
         |         ^~~~~~~~~~
   fs/erofs/fscache.c:66:18: note: in expansion of macro 'list_first_entry'
      66 |         subreq = list_first_entry(&rreq->subrequests,
         |                  ^~~~~~~~~~~~~~~~
   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/kasan-checks.h:5,
                    from include/asm-generic/rwonce.h:26,
                    from ./arch/mips/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:248,
                    from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/wait.h:7,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from include/linux/fscache.h:17,
                    from fs/erofs/fscache.c:5:
>> include/linux/stddef.h:16:33: error: 'struct netfs_io_subrequest' has no member named 'rreq_link'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                 ^~~~~~~~~~~~~~~~~~
   include/linux/container_of.h:22:28: note: in expansion of macro 'offsetof'
      22 |         ((type *)(__mptr - offsetof(type, member))); })
         |                            ^~~~~~~~
   include/linux/list.h:520:9: note: in expansion of macro 'container_of'
     520 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
     531 |         list_entry((ptr)->next, type, member)
         |         ^~~~~~~~~~
   fs/erofs/fscache.c:66:18: note: in expansion of macro 'list_first_entry'
      66 |         subreq = list_first_entry(&rreq->subrequests,
         |                  ^~~~~~~~~~~~~~~~
   fs/erofs/fscache.c:88:50: error: 'struct netfs_io_subrequest' has no member named 'rreq_link'
      88 |                         if (!list_is_last(&subreq->rreq_link,
         |                                                  ^~
   fs/erofs/fscache.c:89:48: error: 'struct netfs_io_request' has no member named 'subrequests'
      89 |                                           &rreq->subrequests)) {
         |                                                ^~
   In file included from include/linux/list.h:5,
                    from include/linux/wait.h:7,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from include/linux/fscache.h:17,
                    from fs/erofs/fscache.c:5:
>> include/linux/list.h:564:25: error: 'struct netfs_io_subrequest' has no member named 'rreq_link'
     564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |                         ^~
   include/linux/container_of.h:18:33: note: in definition of macro 'container_of'
      18 |         void *__mptr = (void *)(ptr);                                   \
         |                                 ^~~
   include/linux/list.h:564:9: note: in expansion of macro 'list_entry'
     564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |         ^~~~~~~~~~
   fs/erofs/fscache.c:90:42: note: in expansion of macro 'list_next_entry'
      90 |                                 subreq = list_next_entry(subreq, rreq_link);
         |                                          ^~~~~~~~~~~~~~~
   In file included from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/wait.h:7,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from include/linux/fscache.h:17,
                    from fs/erofs/fscache.c:5:
>> include/linux/list.h:564:25: error: 'struct netfs_io_subrequest' has no member named 'rreq_link'
     564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |                         ^~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:19:9: note: in expansion of macro 'static_assert'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:19:23: note: in expansion of macro '__same_type'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/list.h:520:9: note: in expansion of macro 'container_of'
     520 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:564:9: note: in expansion of macro 'list_entry'
     564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |         ^~~~~~~~~~
   fs/erofs/fscache.c:90:42: note: in expansion of macro 'list_next_entry'
      90 |                                 subreq = list_next_entry(subreq, rreq_link);
         |                                          ^~~~~~~~~~~~~~~
>> include/linux/container_of.h:19:54: error: 'struct netfs_io_subrequest' has no member named 'rreq_link'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                                                      ^~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:19:9: note: in expansion of macro 'static_assert'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:19:23: note: in expansion of macro '__same_type'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/list.h:520:9: note: in expansion of macro 'container_of'
     520 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:564:9: note: in expansion of macro 'list_entry'
     564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |         ^~~~~~~~~~
   fs/erofs/fscache.c:90:42: note: in expansion of macro 'list_next_entry'
      90 |                                 subreq = list_next_entry(subreq, rreq_link);
         |                                          ^~~~~~~~~~~~~~~
>> include/linux/list.h:564:25: error: 'struct netfs_io_subrequest' has no member named 'rreq_link'
     564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |                         ^~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:19:9: note: in expansion of macro 'static_assert'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |                       __same_type(*(ptr), void),                        \
         |                       ^~~~~~~~~~~
   include/linux/list.h:520:9: note: in expansion of macro 'container_of'
     520 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:564:9: note: in expansion of macro 'list_entry'
     564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |         ^~~~~~~~~~
   fs/erofs/fscache.c:90:42: note: in expansion of macro 'list_next_entry'
      90 |                                 subreq = list_next_entry(subreq, rreq_link);
         |                                          ^~~~~~~~~~~~~~~
   include/linux/compiler_types.h:293:27: error: expression in static assertion is not an integer
     293 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:19:9: note: in expansion of macro 'static_assert'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:19:23: note: in expansion of macro '__same_type'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/list.h:520:9: note: in expansion of macro 'container_of'
     520 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:564:9: note: in expansion of macro 'list_entry'
     564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |         ^~~~~~~~~~
   fs/erofs/fscache.c:90:42: note: in expansion of macro 'list_next_entry'
      90 |                                 subreq = list_next_entry(subreq, rreq_link);
         |                                          ^~~~~~~~~~~~~~~
   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/kasan-checks.h:5,
                    from include/asm-generic/rwonce.h:26,
                    from ./arch/mips/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:248,
                    from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/wait.h:7,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from include/linux/fscache.h:17,
                    from fs/erofs/fscache.c:5:
>> include/linux/stddef.h:16:33: error: 'struct netfs_io_subrequest' has no member named 'rreq_link'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                 ^~~~~~~~~~~~~~~~~~
   include/linux/container_of.h:22:28: note: in expansion of macro 'offsetof'
      22 |         ((type *)(__mptr - offsetof(type, member))); })
         |                            ^~~~~~~~
   include/linux/list.h:520:9: note: in expansion of macro 'container_of'
     520 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:564:9: note: in expansion of macro 'list_entry'
     564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |         ^~~~~~~~~~
   fs/erofs/fscache.c:90:42: note: in expansion of macro 'list_next_entry'
      90 |                                 subreq = list_next_entry(subreq, rreq_link);
         |                                          ^~~~~~~~~~~~~~~
   fs/erofs/fscache.c: In function 'erofs_fscache_read_folios_async':
   fs/erofs/fscache.c:158:47: error: 'struct netfs_io_subrequest' has no member named 'rreq_link'
     158 |                         INIT_LIST_HEAD(&subreq->rreq_link);
         |                                               ^~
   fs/erofs/fscache.c:171:38: error: 'struct netfs_io_subrequest' has no member named 'rreq_link'
     171 |                 list_add_tail(&subreq->rreq_link, &rreq->subrequests);
         |                                      ^~
   fs/erofs/fscache.c:171:56: error: 'struct netfs_io_request' has no member named 'subrequests'
     171 |                 list_add_tail(&subreq->rreq_link, &rreq->subrequests);
         |                                                        ^~


vim +21 fs/erofs/fscache.c

c6be2bd0a5dd91 Jeffle Xu 2022-04-25   7  
d435d53228dd03 Xin Yin   2022-05-09   8  static struct netfs_io_request *erofs_fscache_alloc_request(struct address_space *mapping,
d435d53228dd03 Xin Yin   2022-05-09   9  					     loff_t start, size_t len)
d435d53228dd03 Xin Yin   2022-05-09  10  {
d435d53228dd03 Xin Yin   2022-05-09  11  	struct netfs_io_request *rreq;
d435d53228dd03 Xin Yin   2022-05-09  12  
d435d53228dd03 Xin Yin   2022-05-09  13  	rreq = kzalloc(sizeof(struct netfs_io_request), GFP_KERNEL);
d435d53228dd03 Xin Yin   2022-05-09  14  	if (!rreq)
d435d53228dd03 Xin Yin   2022-05-09  15  		return ERR_PTR(-ENOMEM);
d435d53228dd03 Xin Yin   2022-05-09  16  
d435d53228dd03 Xin Yin   2022-05-09  17  	rreq->start	= start;
d435d53228dd03 Xin Yin   2022-05-09  18  	rreq->len	= len;
d435d53228dd03 Xin Yin   2022-05-09  19  	rreq->mapping	= mapping;
b5cb79dcfd03e7 Xin Yin   2022-05-27  20  	rreq->inode	= mapping->host;
d435d53228dd03 Xin Yin   2022-05-09 @21  	INIT_LIST_HEAD(&rreq->subrequests);
d435d53228dd03 Xin Yin   2022-05-09  22  	refcount_set(&rreq->ref, 1);
d435d53228dd03 Xin Yin   2022-05-09  23  	return rreq;
d435d53228dd03 Xin Yin   2022-05-09  24  }
d435d53228dd03 Xin Yin   2022-05-09  25  
d435d53228dd03 Xin Yin   2022-05-09  26  static void erofs_fscache_put_request(struct netfs_io_request *rreq)
d435d53228dd03 Xin Yin   2022-05-09  27  {
d435d53228dd03 Xin Yin   2022-05-09  28  	if (!refcount_dec_and_test(&rreq->ref))
d435d53228dd03 Xin Yin   2022-05-09  29  		return;
d435d53228dd03 Xin Yin   2022-05-09  30  	if (rreq->cache_resources.ops)
d435d53228dd03 Xin Yin   2022-05-09  31  		rreq->cache_resources.ops->end_operation(&rreq->cache_resources);
d435d53228dd03 Xin Yin   2022-05-09  32  	kfree(rreq);
d435d53228dd03 Xin Yin   2022-05-09  33  }
d435d53228dd03 Xin Yin   2022-05-09  34  
d435d53228dd03 Xin Yin   2022-05-09  35  static void erofs_fscache_put_subrequest(struct netfs_io_subrequest *subreq)
d435d53228dd03 Xin Yin   2022-05-09  36  {
d435d53228dd03 Xin Yin   2022-05-09  37  	if (!refcount_dec_and_test(&subreq->ref))
d435d53228dd03 Xin Yin   2022-05-09  38  		return;
d435d53228dd03 Xin Yin   2022-05-09  39  	erofs_fscache_put_request(subreq->rreq);
d435d53228dd03 Xin Yin   2022-05-09  40  	kfree(subreq);
d435d53228dd03 Xin Yin   2022-05-09  41  }
d435d53228dd03 Xin Yin   2022-05-09  42  
d435d53228dd03 Xin Yin   2022-05-09  43  static void erofs_fscache_clear_subrequests(struct netfs_io_request *rreq)
d435d53228dd03 Xin Yin   2022-05-09  44  {
d435d53228dd03 Xin Yin   2022-05-09  45  	struct netfs_io_subrequest *subreq;
d435d53228dd03 Xin Yin   2022-05-09  46  
d435d53228dd03 Xin Yin   2022-05-09  47  	while (!list_empty(&rreq->subrequests)) {
d435d53228dd03 Xin Yin   2022-05-09  48  		subreq = list_first_entry(&rreq->subrequests,
d435d53228dd03 Xin Yin   2022-05-09  49  				struct netfs_io_subrequest, rreq_link);
d435d53228dd03 Xin Yin   2022-05-09 @50  		list_del(&subreq->rreq_link);
d435d53228dd03 Xin Yin   2022-05-09  51  		erofs_fscache_put_subrequest(subreq);
d435d53228dd03 Xin Yin   2022-05-09  52  	}
d435d53228dd03 Xin Yin   2022-05-09  53  }
d435d53228dd03 Xin Yin   2022-05-09  54  

:::::: The code at line 21 was first introduced by commit
:::::: d435d53228dd039fffecae123b8c138af6f96f99 erofs: change to use asynchronous io for fscache readpage/readahead

:::::: TO: Xin Yin <yinxin.x@bytedance.com>
:::::: CC: Gao Xiang <hsiangkao@linux.alibaba.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
