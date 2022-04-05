Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BA04F222C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbiDEELN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 00:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiDEEK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 00:10:56 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06325FF1
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 21:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649131725; x=1680667725;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zy4hoaYdClT/GTDOV0288HGQLnqQ9tl6vaEkZT0kWr4=;
  b=PvHJ4XxUAJ0DZQNsvhlfE6FQc1Cbi5kqwS6IiUsKnRPYc0tGKA6V9aSD
   UxP8+EP8VlvBsepBOhRk4ZX7n9X/OSWgOn2TMCFicpqwJzVf6i1JjHt5x
   dvXLtbFoA3wC5VB0/UmGSa3NLWLymcUjeYFi8t5SpXYPAhTF0+KE/CE6z
   9uyQFwCNcW0uXrxwxsXzb17+Q3jk8SYccJyjqIaBG8yoBm19fzswD/WXb
   zwtiKzNbw/GxxTXXnqD9gm3uAJjt2e2lPCiFVlGpra/wTRqUy96gWEVlD
   cyh3mjn67l3u3Y7/Cv+eX66FDTyVWqUMxv1oPm1x10VxMV11nYOpMxdlV
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="260357865"
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="260357865"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 21:08:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="523839920"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 04 Apr 2022 21:08:43 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbaUl-0002c5-3l;
        Tue, 05 Apr 2022 04:08:43 +0000
Date:   Tue, 5 Apr 2022 12:07:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 8/40]
 fs/netfs/internal.h:164:36: warning: format '%lx' expects argument of type
 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned int'}
Message-ID: <202204051231.5tNC2hZE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-maple
head:   674eea41fc70a740ff83ec590f9833f805852464
commit: cae8dd85733f703374474ed433b8263263d4fa7f [8/40] netfs: Provide invalidatepage and releasepage calls
config: parisc-randconfig-r003-20220405 (https://download.01.org/0day-ci/archive/20220405/202204051231.5tNC2hZE-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/cae8dd85733f703374474ed433b8263263d4fa7f
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout cae8dd85733f703374474ed433b8263263d4fa7f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:29,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/parisc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/swap.h:5,
                    from fs/netfs/misc.c:8:
   fs/netfs/misc.c: In function 'netfs_invalidate_folio':
>> fs/netfs/internal.h:164:36: warning: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
     164 | #define _enter(FMT, ...) no_printk("==> %s("FMT")", __func__, ##__VA_ARGS__)
         |                                    ^~~~~~~~~
   include/linux/printk.h:418:25: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:132:17: note: in expansion of macro 'printk'
     132 |                 printk(fmt, ##__VA_ARGS__);             \
         |                 ^~~~~~
   fs/netfs/internal.h:164:26: note: in expansion of macro 'no_printk'
     164 | #define _enter(FMT, ...) no_printk("==> %s("FMT")", __func__, ##__VA_ARGS__)
         |                          ^~~~~~~~~
   fs/netfs/misc.c:18:9: note: in expansion of macro '_enter'
      18 |         _enter("{%lx},%lx,%lx", folio_index(folio), offset, length);
         |         ^~~~~~
   fs/netfs/internal.h:164:36: warning: format '%lx' expects argument of type 'long unsigned int', but argument 5 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
     164 | #define _enter(FMT, ...) no_printk("==> %s("FMT")", __func__, ##__VA_ARGS__)
         |                                    ^~~~~~~~~
   include/linux/printk.h:418:25: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:132:17: note: in expansion of macro 'printk'
     132 |                 printk(fmt, ##__VA_ARGS__);             \
         |                 ^~~~~~
   fs/netfs/internal.h:164:26: note: in expansion of macro 'no_printk'
     164 | #define _enter(FMT, ...) no_printk("==> %s("FMT")", __func__, ##__VA_ARGS__)
         |                          ^~~~~~~~~
   fs/netfs/misc.c:18:9: note: in expansion of macro '_enter'
      18 |         _enter("{%lx},%lx,%lx", folio_index(folio), offset, length);
         |         ^~~~~~


vim +164 fs/netfs/internal.h

3d3c95046742e4 David Howells 2020-05-13  162  
3d3c95046742e4 David Howells 2020-05-13  163  #else
3d3c95046742e4 David Howells 2020-05-13 @164  #define _enter(FMT, ...) no_printk("==> %s("FMT")", __func__, ##__VA_ARGS__)

:::::: The code at line 164 was first introduced by commit
:::::: 3d3c95046742e4eebaa4b891b0b01cbbed94ebbd netfs: Provide readahead and readpage netfs helpers

:::::: TO: David Howells <dhowells@redhat.com>
:::::: CC: David Howells <dhowells@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
