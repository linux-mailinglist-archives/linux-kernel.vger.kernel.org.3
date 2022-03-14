Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EA84D7B81
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 08:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236584AbiCNH11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 03:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiCNH1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 03:27:25 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1577A40A1C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 00:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647242776; x=1678778776;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bfWcMYWS2zvebQ7CpaRsDpVSYIbxbj/UAZ95la2dDTE=;
  b=geH2euoUBhvg4LRESCBT3QVwXlEsLQJoaJRgByNSd87yHIhEB11JwPyk
   B51arw1i+XbZW4SlXtl0hLG0xxF0HwI5aYu2li7DZ4k4R11R+vXavoksx
   L6Ocv8SDgpmG8JWHVs/NsFG3obiRcMsD1hd/IwZ0jUe7TmqWhPCaLg5B9
   TamLHKxEod9ccAkeRM62p7Hsun3XyRn5Bs2JiEA3AryMTnPaUSBhoSDw3
   AXDg8pGRAojRtXgfoOpAqkJjPjybAbD+YF5alL+ovdVR96OvTWOX0tw7e
   qMP3AgjFbzfBfl0dcsM6Ok/NYeVfDgidbTMc+GeXtvwatVJjyVLJ8aLht
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="255907169"
X-IronPort-AV: E=Sophos;i="5.90,180,1643702400"; 
   d="scan'208";a="255907169"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 00:26:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,180,1643702400"; 
   d="scan'208";a="515310957"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 14 Mar 2022 00:26:14 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTf5p-0009gq-Ct; Mon, 14 Mar 2022 07:26:13 +0000
Date:   Mon, 14 Mar 2022 15:25:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:herbert/cryptodev-2.6/master 137/137]
 include/linux/cacheflush.h:12:46: warning: 'struct folio' declared inside
 parameter list will not be visible outside of this definition or declaration
Message-ID: <202203141545.snRTl9jH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block herbert/cryptodev-2.6/master
head:   0e03b8fd29363f2df44e2a7a176d486de550757a
commit: 0e03b8fd29363f2df44e2a7a176d486de550757a [137/137] crypto: xilinx - Turn SHA into a tristate and allow COMPILE_TEST
config: h8300-allmodconfig (https://download.01.org/0day-ci/archive/20220314/202203141545.snRTl9jH-lkp@intel.com/config)
compiler: h8300-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/0e03b8fd29363f2df44e2a7a176d486de550757a
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block herbert/cryptodev-2.6/master
        git checkout 0e03b8fd29363f2df44e2a7a176d486de550757a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=h8300 SHELL=/bin/bash drivers/crypto/xilinx/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/crypto/xilinx/zynqmp-sha.c:6:
>> include/linux/cacheflush.h:12:46: warning: 'struct folio' declared inside parameter list will not be visible outside of this definition or declaration
      12 | static inline void flush_dcache_folio(struct folio *folio)
         |                                              ^~~~~
   In file included from include/asm-generic/percpu.h:5,
                    from ./arch/h8300/include/generated/asm/percpu.h:1,
                    from include/linux/irqflags.h:17,
                    from include/asm-generic/cmpxchg.h:15,
                    from ./arch/h8300/include/generated/asm/cmpxchg.h:1,
                    from include/asm-generic/atomic.h:12,
                    from ./arch/h8300/include/generated/asm/atomic.h:1,
                    from include/linux/atomic.h:7,
                    from include/linux/crypto.h:15,
                    from include/crypto/hash.h:11,
                    from drivers/crypto/xilinx/zynqmp-sha.c:7:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   include/asm-generic/page.h:89:51: warning: ordered comparison of pointer with null pointer [-Wextra]
      89 | #define virt_addr_valid(kaddr)  (((void *)(kaddr) >= (void *)PAGE_OFFSET) && \
         |                                                   ^~
   include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
      78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/scatterlist.h:160:9: note: in expansion of macro 'BUG_ON'
     160 |         BUG_ON(!virt_addr_valid(buf));
         |         ^~~~~~
   include/linux/scatterlist.h:160:17: note: in expansion of macro 'virt_addr_valid'
     160 |         BUG_ON(!virt_addr_valid(buf));
         |                 ^~~~~~~~~~~~~~~


vim +12 include/linux/cacheflush.h

522a0032af0055 Matthew Wilcox (Oracle  2021-11-06   6) 
522a0032af0055 Matthew Wilcox (Oracle  2021-11-06   7) #if ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
522a0032af0055 Matthew Wilcox (Oracle  2021-11-06   8) #ifndef ARCH_IMPLEMENTS_FLUSH_DCACHE_FOLIO
522a0032af0055 Matthew Wilcox (Oracle  2021-11-06   9) void flush_dcache_folio(struct folio *folio);
522a0032af0055 Matthew Wilcox (Oracle  2021-11-06  10) #endif
522a0032af0055 Matthew Wilcox (Oracle  2021-11-06  11) #else
522a0032af0055 Matthew Wilcox (Oracle  2021-11-06 @12) static inline void flush_dcache_folio(struct folio *folio)
522a0032af0055 Matthew Wilcox (Oracle  2021-11-06  13) {
522a0032af0055 Matthew Wilcox (Oracle  2021-11-06  14) }
522a0032af0055 Matthew Wilcox (Oracle  2021-11-06  15) #define ARCH_IMPLEMENTS_FLUSH_DCACHE_FOLIO 0
522a0032af0055 Matthew Wilcox (Oracle  2021-11-06  16) #endif /* ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE */
522a0032af0055 Matthew Wilcox (Oracle  2021-11-06  17) 

:::::: The code at line 12 was first introduced by commit
:::::: 522a0032af005502507f5f81ae64fdcc82b5d068 Add linux/cacheflush.h

:::::: TO: Matthew Wilcox (Oracle) <willy@infradead.org>
:::::: CC: Matthew Wilcox (Oracle) <willy@infradead.org>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
