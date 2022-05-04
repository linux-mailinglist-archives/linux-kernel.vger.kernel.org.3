Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4919D51B2ED
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 01:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379944AbiEDXLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 19:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384490AbiEDXIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 19:08:01 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089D86248
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 16:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651705218; x=1683241218;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4iypyjPdosvd34wK65S8PSB5T1ThPt5c+8A/5+LYvI4=;
  b=XU0CrlayKutgqy7OVGeltf/0LvX130/pOxTE0b1Lqk6IOo6uSIFMPNim
   ysaDYBjk3QIjiLfA1bb8nL44974ypwSQYcAr6SYP4ZuF/bU94UQuQ+I+k
   Nv1uLr0swJWaS7HzXdSa36jQ1eRMT2/LB5ouo8zH0s1x3zKswUUn/LETN
   xRqIt5KTcoet2k228cKYh1DMw4B1pJDhn5UHJknpjt/hrFaBYRvKnU/LB
   4YfKW2LateLCeyh87AXG1JxA4lUQo8hvA9V3MWAXSk65QShh/UmE+vVkA
   8WejNcb+1SW2NQkFeuEd1/9XiH+mXYf857KRFrR6MMT2pCRUbUouUd7b8
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="255394366"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="255394366"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 15:59:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="694384941"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 04 May 2022 15:59:16 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmNxj-000BsQ-OG;
        Wed, 04 May 2022 22:59:15 +0000
Date:   Thu, 5 May 2022 06:58:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [niks:has_ioport_v3 39/39] include/asm-generic/io.h:542:15: error:
 call to '_outl' declared with attribute error: outl() requires
 CONFIG_HAS_IOPORT
Message-ID: <202205050650.TVKFsjio-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git has_ioport_v3
head:   2d239b86b347751644338b1dc5b64d25beb640ce
commit: 2d239b86b347751644338b1dc5b64d25beb640ce [39/39] asm-generic/io.h: drop inb() etc for HAS_IOPORT=n
config: xtensa-allyesconfig (https://download.01.org/0day-ci/archive/20220505/202205050650.TVKFsjio-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git/commit/?id=2d239b86b347751644338b1dc5b64d25beb640ce
        git remote add niks https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git
        git fetch --no-tags niks has_ioport_v3
        git checkout 2d239b86b347751644338b1dc5b64d25beb640ce
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/xtensa/include/asm/io.h:71,
                    from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from include/asm-generic/hardirq.h:17,
                    from ./arch/xtensa/include/generated/asm/hardirq.h:1,
                    from include/linux/hardirq.h:11,
                    from include/linux/highmem.h:11,
                    from include/linux/bvec.h:10,
                    from include/linux/blk_types.h:10,
                    from include/linux/blkdev.h:9,
                    from drivers/scsi/nsp32.c:23:
   In function 'nsp32_write2',
       inlined from 'nsp32_scsi_done' at drivers/scsi/nsp32.c:1538:2:
   include/asm-generic/io.h:527:15: error: call to '_outw' declared with attribute error: outw() requires CONFIG_HAS_IOPORT
     527 | #define _outw _outw
   include/asm-generic/io.h:575:14: note: in expansion of macro '_outw'
     575 | #define outw _outw
         |              ^~~~~
   drivers/scsi/nsp32_io.h:29:9: note: in expansion of macro 'outw'
      29 |         outw(val, (base + index));
         |         ^~~~
   In function 'nsp32_write4',
       inlined from 'nsp32_scsi_done' at drivers/scsi/nsp32.c:1539:2:
>> include/asm-generic/io.h:542:15: error: call to '_outl' declared with attribute error: outl() requires CONFIG_HAS_IOPORT
     542 | #define _outl _outl
   include/asm-generic/io.h:579:14: note: in expansion of macro '_outl'
     579 | #define outl _outl
         |              ^~~~~
   drivers/scsi/nsp32_io.h:42:9: note: in expansion of macro 'outl'
      42 |         outl(val, (base + index));
         |         ^~~~
   In function 'nsp32_write2',
       inlined from 'nsp32_eh_abort' at drivers/scsi/nsp32.c:2827:2:
   include/asm-generic/io.h:527:15: error: call to '_outw' declared with attribute error: outw() requires CONFIG_HAS_IOPORT
     527 | #define _outw _outw
   include/asm-generic/io.h:575:14: note: in expansion of macro '_outw'
     575 | #define outw _outw
         |              ^~~~~
   drivers/scsi/nsp32_io.h:29:9: note: in expansion of macro 'outw'
      29 |         outw(val, (base + index));
         |         ^~~~
   In function 'nsp32_write2',
       inlined from 'nsp32_eh_abort' at drivers/scsi/nsp32.c:2828:2:
   include/asm-generic/io.h:527:15: error: call to '_outw' declared with attribute error: outw() requires CONFIG_HAS_IOPORT
     527 | #define _outw _outw
   include/asm-generic/io.h:575:14: note: in expansion of macro '_outw'
     575 | #define outw _outw
         |              ^~~~~
   drivers/scsi/nsp32_io.h:29:9: note: in expansion of macro 'outw'
      29 |         outw(val, (base + index));
         |         ^~~~
   In function 'nsp32_write4',
       inlined from 'nsp32_busfree_occur' at drivers/scsi/nsp32.c:1574:2:
>> include/asm-generic/io.h:542:15: error: call to '_outl' declared with attribute error: outl() requires CONFIG_HAS_IOPORT
     542 | #define _outl _outl
   include/asm-generic/io.h:579:14: note: in expansion of macro '_outl'
     579 | #define outl _outl
         |              ^~~~~
   drivers/scsi/nsp32_io.h:42:9: note: in expansion of macro 'outl'
      42 |         outl(val, (base + index));
         |         ^~~~
   In function 'nsp32_write2',
       inlined from 'nsp32_busfree_occur' at drivers/scsi/nsp32.c:1575:2:
   include/asm-generic/io.h:527:15: error: call to '_outw' declared with attribute error: outw() requires CONFIG_HAS_IOPORT
     527 | #define _outw _outw
   include/asm-generic/io.h:575:14: note: in expansion of macro '_outw'
     575 | #define outw _outw
         |              ^~~~~
   drivers/scsi/nsp32_io.h:29:9: note: in expansion of macro 'outw'
      29 |         outw(val, (base + index));
         |         ^~~~
   In function 'nsp32_read4',
       inlined from 'nsp32_busfree_occur' at drivers/scsi/nsp32.c:1602:16:
>> include/asm-generic/io.h:494:14: error: call to '_inl' declared with attribute error: inl() requires CONFIG_HAS_IOPORT
     494 | #define _inl _inl
   include/asm-generic/io.h:567:13: note: in expansion of macro '_inl'
     567 | #define inl _inl
         |             ^~~~
   drivers/scsi/nsp32_io.h:48:16: note: in expansion of macro 'inl'
      48 |         return inl(base + index);
         |                ^~~
   In function 'nsp32_read4',
       inlined from 'nsp32_busfree_occur' at drivers/scsi/nsp32.c:1603:16:
>> include/asm-generic/io.h:494:14: error: call to '_inl' declared with attribute error: inl() requires CONFIG_HAS_IOPORT
     494 | #define _inl _inl
   include/asm-generic/io.h:567:13: note: in expansion of macro '_inl'
     567 | #define inl _inl
         |             ^~~~
   drivers/scsi/nsp32_io.h:48:16: note: in expansion of macro 'inl'
      48 |         return inl(base + index);
         |                ^~~
   In function 'nsp32_read1',
       inlined from 'nsp32_busfree_occur' at drivers/scsi/nsp32.c:1686:32:
   include/asm-generic/io.h:458:14: error: call to '_inb' declared with attribute error: inb()) requires CONFIG_HAS_IOPORT
     458 | #define _inb _inb
   include/asm-generic/io.h:559:13: note: in expansion of macro '_inb'
     559 | #define inb _inb
         |             ^~~~
   drivers/scsi/nsp32_io.h:22:16: note: in expansion of macro 'inb'
      22 |         return inb(base + index);
         |                ^~~
   In function 'nsp32_read1',
       inlined from 'nsp32_busfree_occur' at drivers/scsi/nsp32.c:1697:31:
   include/asm-generic/io.h:458:14: error: call to '_inb' declared with attribute error: inb()) requires CONFIG_HAS_IOPORT
     458 | #define _inb _inb
   include/asm-generic/io.h:559:13: note: in expansion of macro '_inb'
     559 | #define inb _inb
         |             ^~~~
   drivers/scsi/nsp32_io.h:22:16: note: in expansion of macro 'inb'
      22 |         return inb(base + index);
         |                ^~~
   In function 'nsp32_read2',
       inlined from 'nsp32_show_info' at drivers/scsi/nsp32.c:1469:7:
>> include/asm-generic/io.h:476:14: error: call to '_inw' declared with attribute error: inw() requires CONFIG_HAS_IOPORT
     476 | #define _inw _inw
   include/asm-generic/io.h:563:13: note: in expansion of macro '_inw'
     563 | #define inw _inw
         |             ^~~~
   drivers/scsi/nsp32_io.h:35:16: note: in expansion of macro 'inw'
      35 |         return inw(base + index);
         |                ^~~
   In function 'nsp32_index_read1',
       inlined from 'nsp32_show_info' at drivers/scsi/nsp32.c:1471:13:
   include/asm-generic/io.h:512:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     512 | #define _outb _outb
   include/asm-generic/io.h:571:14: note: in expansion of macro '_outb'
     571 | #define outb _outb
         |              ^~~~~
   drivers/scsi/nsp32_io.h:121:9: note: in expansion of macro 'outb'
     121 |         outb(reg, base + INDEX_REG);
         |         ^~~~
   include/asm-generic/io.h:458:14: error: call to '_inb' declared with attribute error: inb()) requires CONFIG_HAS_IOPORT
     458 | #define _inb _inb
   include/asm-generic/io.h:559:13: note: in expansion of macro '_inb'
     559 | #define inb _inb
         |             ^~~~
   drivers/scsi/nsp32_io.h:122:16: note: in expansion of macro 'inb'
     122 |         return inb(base + DATA_REG_LOW);
         |                ^~~
   In function 'nsp32_read1',
       inlined from 'nsp32_wait_req' at drivers/scsi/nsp32.c:2466:9:
   include/asm-generic/io.h:458:14: error: call to '_inb' declared with attribute error: inb()) requires CONFIG_HAS_IOPORT
     458 | #define _inb _inb
   include/asm-generic/io.h:559:13: note: in expansion of macro '_inb'
     559 | #define inb _inb
         |             ^~~~
   drivers/scsi/nsp32_io.h:22:16: note: in expansion of macro 'inb'
      22 |         return inb(base + index);
         |                ^~~
   In function 'nsp32_write2',
       inlined from 'nsp32_do_bus_reset' at drivers/scsi/nsp32.c:2850:2:
   include/asm-generic/io.h:527:15: error: call to '_outw' declared with attribute error: outw() requires CONFIG_HAS_IOPORT
     527 | #define _outw _outw
   include/asm-generic/io.h:575:14: note: in expansion of macro '_outw'
     575 | #define outw _outw
         |              ^~~~~
   drivers/scsi/nsp32_io.h:29:9: note: in expansion of macro 'outw'
      29 |         outw(val, (base + index));
         |         ^~~~
   In function 'nsp32_write4',
       inlined from 'nsp32_do_bus_reset' at drivers/scsi/nsp32.c:2851:2:
>> include/asm-generic/io.h:542:15: error: call to '_outl' declared with attribute error: outl() requires CONFIG_HAS_IOPORT
     542 | #define _outl _outl
   include/asm-generic/io.h:579:14: note: in expansion of macro '_outl'
     579 | #define outl _outl
         |              ^~~~~
   drivers/scsi/nsp32_io.h:42:9: note: in expansion of macro 'outl'
      42 |         outl(val, (base + index));
         |         ^~~~
   In function 'nsp32_write4',
       inlined from 'nsp32_do_bus_reset' at drivers/scsi/nsp32.c:2852:2:
>> include/asm-generic/io.h:542:15: error: call to '_outl' declared with attribute error: outl() requires CONFIG_HAS_IOPORT
     542 | #define _outl _outl
   include/asm-generic/io.h:579:14: note: in expansion of macro '_outl'
     579 | #define outl _outl
         |              ^~~~~
   drivers/scsi/nsp32_io.h:42:9: note: in expansion of macro 'outl'
      42 |         outl(val, (base + index));
         |         ^~~~
   In function 'nsp32_write1',
       inlined from 'nsp32_do_bus_reset' at drivers/scsi/nsp32.c:2868:2:
   include/asm-generic/io.h:512:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     512 | #define _outb _outb
   include/asm-generic/io.h:571:14: note: in expansion of macro '_outb'
     571 | #define outb _outb
         |              ^~~~~
   drivers/scsi/nsp32_io.h:16:9: note: in expansion of macro 'outb'
      16 |         outb(val, (base + index));
         |         ^~~~
   In function 'nsp32_write1',
       inlined from 'nsp32_do_bus_reset' at drivers/scsi/nsp32.c:2870:2:
   include/asm-generic/io.h:512:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     512 | #define _outb _outb
   include/asm-generic/io.h:571:14: note: in expansion of macro '_outb'
     571 | #define outb _outb
         |              ^~~~~
   drivers/scsi/nsp32_io.h:16:9: note: in expansion of macro 'outb'
      16 |         outb(val, (base + index));
         |         ^~~~
   In function 'nsp32_read2',
       inlined from 'nsp32_do_bus_reset' at drivers/scsi/nsp32.c:2872:13:
>> include/asm-generic/io.h:476:14: error: call to '_inw' declared with attribute error: inw() requires CONFIG_HAS_IOPORT
     476 | #define _inw _inw
   include/asm-generic/io.h:563:13: note: in expansion of macro '_inw'
     563 | #define inw _inw
         |             ^~~~
   drivers/scsi/nsp32_io.h:35:16: note: in expansion of macro 'inw'
      35 |         return inw(base + index);
         |                ^~~
>> include/asm-generic/io.h:476:14: error: call to '_inw' declared with attribute error: inw() requires CONFIG_HAS_IOPORT
     476 | #define _inw _inw
   include/asm-generic/io.h:563:13: note: in expansion of macro '_inw'
     563 | #define inw _inw
         |             ^~~~
   drivers/scsi/nsp32_io.h:35:16: note: in expansion of macro 'inw'
      35 |         return inw(base + index);
         |                ^~~
>> include/asm-generic/io.h:476:14: error: call to '_inw' declared with attribute error: inw() requires CONFIG_HAS_IOPORT
     476 | #define _inw _inw
   include/asm-generic/io.h:563:13: note: in expansion of macro '_inw'
     563 | #define inw _inw
         |             ^~~~
   drivers/scsi/nsp32_io.h:35:16: note: in expansion of macro 'inw'
      35 |         return inw(base + index);
         |                ^~~
>> include/asm-generic/io.h:476:14: error: call to '_inw' declared with attribute error: inw() requires CONFIG_HAS_IOPORT
     476 | #define _inw _inw
   include/asm-generic/io.h:563:13: note: in expansion of macro '_inw'
     563 | #define inw _inw
         |             ^~~~
   drivers/scsi/nsp32_io.h:35:16: note: in expansion of macro 'inw'
      35 |         return inw(base + index);
         |                ^~~
>> include/asm-generic/io.h:476:14: error: call to '_inw' declared with attribute error: inw() requires CONFIG_HAS_IOPORT
     476 | #define _inw _inw
   include/asm-generic/io.h:563:13: note: in expansion of macro '_inw'
     563 | #define inw _inw
         |             ^~~~
   drivers/scsi/nsp32_io.h:35:16: note: in expansion of macro 'inw'
      35 |         return inw(base + index);
         |                ^~~
   In function 'nsp32_read1',
       inlined from 'nsp32_msgin_occur' at drivers/scsi/nsp32.c:1945:8:
   include/asm-generic/io.h:458:14: error: call to '_inb' declared with attribute error: inb()) requires CONFIG_HAS_IOPORT
     458 | #define _inb _inb
   include/asm-generic/io.h:559:13: note: in expansion of macro '_inb'
     559 | #define inb _inb
         |             ^~~~
   drivers/scsi/nsp32_io.h:22:16: note: in expansion of macro 'inb'
      22 |         return inb(base + index);
         |                ^~~
   In function 'nsp32_read1',
       inlined from 'nsp32_sack_assert' at drivers/scsi/nsp32.c:2518:13,
       inlined from 'nsp32_msgin_occur' at drivers/scsi/nsp32.c:1959:2:
   include/asm-generic/io.h:458:14: error: call to '_inb' declared with attribute error: inb()) requires CONFIG_HAS_IOPORT
     458 | #define _inb _inb
   include/asm-generic/io.h:559:13: note: in expansion of macro '_inb'
     559 | #define inb _inb
         |             ^~~~
   drivers/scsi/nsp32_io.h:22:16: note: in expansion of macro 'inb'
      22 |         return inb(base + index);
         |                ^~~
   In function 'nsp32_write1',
       inlined from 'nsp32_sack_assert' at drivers/scsi/nsp32.c:2520:2,
       inlined from 'nsp32_msgin_occur' at drivers/scsi/nsp32.c:1959:2:
   include/asm-generic/io.h:512:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     512 | #define _outb _outb
   include/asm-generic/io.h:571:14: note: in expansion of macro '_outb'
     571 | #define outb _outb
         |              ^~~~~
   drivers/scsi/nsp32_io.h:16:9: note: in expansion of macro 'outb'
      16 |         outb(val, (base + index));
         |         ^~~~
   In function 'nsp32_read1',
       inlined from 'nsp32_reselection' at drivers/scsi/nsp32.c:818:10,
       inlined from 'nsp32_msgin_occur' at drivers/scsi/nsp32.c:1971:9:
   include/asm-generic/io.h:458:14: error: call to '_inb' declared with attribute error: inb()) requires CONFIG_HAS_IOPORT
     458 | #define _inb _inb
   include/asm-generic/io.h:559:13: note: in expansion of macro '_inb'
     559 | #define inb _inb
         |             ^~~~
   drivers/scsi/nsp32_io.h:22:16: note: in expansion of macro 'inb'
      22 |         return inb(base + index);
         |                ^~~
   In function 'nsp32_write4',
       inlined from 'nsp32_reselection' at drivers/scsi/nsp32.c:849:2,
       inlined from 'nsp32_msgin_occur' at drivers/scsi/nsp32.c:1971:9:
>> include/asm-generic/io.h:542:15: error: call to '_outl' declared with attribute error: outl() requires CONFIG_HAS_IOPORT
     542 | #define _outl _outl
   include/asm-generic/io.h:579:14: note: in expansion of macro '_outl'
     579 | #define outl _outl
         |              ^~~~~
   drivers/scsi/nsp32_io.h:42:9: note: in expansion of macro 'outl'
      42 |         outl(val, (base + index));
         |         ^~~~
   In function 'nsp32_read4',
       inlined from 'nsp32_msgin_occur' at drivers/scsi/nsp32.c:2006:16:
>> include/asm-generic/io.h:494:14: error: call to '_inl' declared with attribute error: inl() requires CONFIG_HAS_IOPORT
     494 | #define _inl _inl
   include/asm-generic/io.h:567:13: note: in expansion of macro '_inl'
     567 | #define inl _inl
         |             ^~~~
   drivers/scsi/nsp32_io.h:48:16: note: in expansion of macro 'inl'
      48 |         return inl(base + index);
         |                ^~~
   In function 'nsp32_write4',
       inlined from 'nsp32_msgin_occur' at drivers/scsi/nsp32.c:2018:3:
>> include/asm-generic/io.h:542:15: error: call to '_outl' declared with attribute error: outl() requires CONFIG_HAS_IOPORT
     542 | #define _outl _outl
   include/asm-generic/io.h:579:14: note: in expansion of macro '_outl'
     579 | #define outl _outl
         |              ^~~~~
   drivers/scsi/nsp32_io.h:42:9: note: in expansion of macro 'outl'
      42 |         outl(val, (base + index));
         |         ^~~~
   In function 'nsp32_write4',
       inlined from 'nsp32_msgin_occur' at drivers/scsi/nsp32.c:2025:3:
>> include/asm-generic/io.h:542:15: error: call to '_outl' declared with attribute error: outl() requires CONFIG_HAS_IOPORT
     542 | #define _outl _outl
   include/asm-generic/io.h:579:14: note: in expansion of macro '_outl'
     579 | #define outl _outl
         |              ^~~~~
   drivers/scsi/nsp32_io.h:42:9: note: in expansion of macro 'outl'
      42 |         outl(val, (base + index));
         |         ^~~~
   In function 'nsp32_write4',
       inlined from 'nsp32_msgin_occur' at drivers/scsi/nsp32.c:2169:4:
>> include/asm-generic/io.h:542:15: error: call to '_outl' declared with attribute error: outl() requires CONFIG_HAS_IOPORT
     542 | #define _outl _outl
   include/asm-generic/io.h:579:14: note: in expansion of macro '_outl'
     579 | #define outl _outl
         |              ^~~~~
   drivers/scsi/nsp32_io.h:42:9: note: in expansion of macro 'outl'
      42 |         outl(val, (base + index));
         |         ^~~~
   In function 'nsp32_write1',
       inlined from 'nsp32_restart_autoscsi' at drivers/scsi/nsp32.c:1876:2,
       inlined from 'nsp32_msgin_occur' at drivers/scsi/nsp32.c:2193:2:
   include/asm-generic/io.h:512:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     512 | #define _outb _outb
   include/asm-generic/io.h:571:14: note: in expansion of macro '_outb'
     571 | #define outb _outb
         |              ^~~~~
   drivers/scsi/nsp32_io.h:16:9: note: in expansion of macro 'outb'
      16 |         outb(val, (base + index));
         |         ^~~~
   In function 'nsp32_write1',
       inlined from 'nsp32_restart_autoscsi' at drivers/scsi/nsp32.c:1881:2,
       inlined from 'nsp32_msgin_occur' at drivers/scsi/nsp32.c:2193:2:
   include/asm-generic/io.h:512:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     512 | #define _outb _outb
   include/asm-generic/io.h:571:14: note: in expansion of macro '_outb'
     571 | #define outb _outb
         |              ^~~~~
   drivers/scsi/nsp32_io.h:16:9: note: in expansion of macro 'outb'
      16 |         outb(val, (base + index));
         |         ^~~~
   In function 'nsp32_write1',
       inlined from 'nsp32_restart_autoscsi' at drivers/scsi/nsp32.c:1886:2,
       inlined from 'nsp32_msgin_occur' at drivers/scsi/nsp32.c:2193:2:
   include/asm-generic/io.h:512:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     512 | #define _outb _outb
   include/asm-generic/io.h:571:14: note: in expansion of macro '_outb'
     571 | #define outb _outb
         |              ^~~~~
   drivers/scsi/nsp32_io.h:16:9: note: in expansion of macro 'outb'
      16 |         outb(val, (base + index));
         |         ^~~~
   In function 'nsp32_write4',
       inlined from 'nsp32_restart_autoscsi' at drivers/scsi/nsp32.c:1891:2,
       inlined from 'nsp32_msgin_occur' at drivers/scsi/nsp32.c:2193:2:
>> include/asm-generic/io.h:542:15: error: call to '_outl' declared with attribute error: outl() requires CONFIG_HAS_IOPORT
     542 | #define _outl _outl
   include/asm-generic/io.h:579:14: note: in expansion of macro '_outl'
     579 | #define outl _outl
         |              ^~~~~
   drivers/scsi/nsp32_io.h:42:9: note: in expansion of macro 'outl'
      42 |         outl(val, (base + index));
         |         ^~~~
   In function 'nsp32_write2',
       inlined from 'nsp32_restart_autoscsi' at drivers/scsi/nsp32.c:1907:2,
       inlined from 'nsp32_msgin_occur' at drivers/scsi/nsp32.c:2193:2:
   include/asm-generic/io.h:527:15: error: call to '_outw' declared with attribute error: outw() requires CONFIG_HAS_IOPORT
     527 | #define _outw _outw
   include/asm-generic/io.h:575:14: note: in expansion of macro '_outw'
     575 | #define outw _outw
         |              ^~~~~
   drivers/scsi/nsp32_io.h:29:9: note: in expansion of macro 'outw'
      29 |         outw(val, (base + index));
         |         ^~~~
   In function 'nsp32_write2',
       inlined from 'nsp32_restart_autoscsi' at drivers/scsi/nsp32.c:1917:2,
       inlined from 'nsp32_msgin_occur' at drivers/scsi/nsp32.c:2193:2:
   include/asm-generic/io.h:527:15: error: call to '_outw' declared with attribute error: outw() requires CONFIG_HAS_IOPORT
     527 | #define _outw _outw
   include/asm-generic/io.h:575:14: note: in expansion of macro '_outw'
     575 | #define outw _outw
         |              ^~~~~
   drivers/scsi/nsp32_io.h:29:9: note: in expansion of macro 'outw'
      29 |         outw(val, (base + index));
         |         ^~~~
   In function 'nsp32_read1',
       inlined from 'nsp32_sack_negate' at drivers/scsi/nsp32.c:2531:13,
       inlined from 'nsp32_msgin_occur' at drivers/scsi/nsp32.c:2203:2:
   include/asm-generic/io.h:458:14: error: call to '_inb' declared with attribute error: inb()) requires CONFIG_HAS_IOPORT
     458 | #define _inb _inb
   include/asm-generic/io.h:559:13: note: in expansion of macro '_inb'
     559 | #define inb _inb
         |             ^~~~
   drivers/scsi/nsp32_io.h:22:16: note: in expansion of macro 'inb'
      22 |         return inb(base + index);
         |                ^~~
   In function 'nsp32_write1',
       inlined from 'nsp32_sack_negate' at drivers/scsi/nsp32.c:2533:2,
       inlined from 'nsp32_msgin_occur' at drivers/scsi/nsp32.c:2203:2:
   include/asm-generic/io.h:512:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     512 | #define _outb _outb
   include/asm-generic/io.h:571:14: note: in expansion of macro '_outb'
     571 | #define outb _outb
         |              ^~~~~
   drivers/scsi/nsp32_io.h:16:9: note: in expansion of macro 'outb'
      16 |         outb(val, (base + index));
         |         ^~~~
   In function 'nsp32_read2',
       inlined from 'do_nsp32_isr' at drivers/scsi/nsp32.c:1173:13:
>> include/asm-generic/io.h:476:14: error: call to '_inw' declared with attribute error: inw() requires CONFIG_HAS_IOPORT
     476 | #define _inw _inw
   include/asm-generic/io.h:563:13: note: in expansion of macro '_inw'
     563 | #define inw _inw
         |             ^~~~
   drivers/scsi/nsp32_io.h:35:16: note: in expansion of macro 'inw'
      35 |         return inw(base + index);
         |                ^~~
   In function 'nsp32_write2',
       inlined from 'do_nsp32_isr' at drivers/scsi/nsp32.c:1183:2:
   include/asm-generic/io.h:527:15: error: call to '_outw' declared with attribute error: outw() requires CONFIG_HAS_IOPORT
     527 | #define _outw _outw
   include/asm-generic/io.h:575:14: note: in expansion of macro '_outw'
     575 | #define outw _outw
         |              ^~~~~
   drivers/scsi/nsp32_io.h:29:9: note: in expansion of macro 'outw'
      29 |         outw(val, (base + index));
         |         ^~~~
   In function 'nsp32_read1',
       inlined from 'do_nsp32_isr' at drivers/scsi/nsp32.c:1185:11:
   include/asm-generic/io.h:458:14: error: call to '_inb' declared with attribute error: inb()) requires CONFIG_HAS_IOPORT
     458 | #define _inb _inb
   include/asm-generic/io.h:559:13: note: in expansion of macro '_inb'
     559 | #define inb _inb
         |             ^~~~
   drivers/scsi/nsp32_io.h:22:16: note: in expansion of macro 'inb'
      22 |         return inb(base + index);
         |                ^~~
   In function 'nsp32_read2',
       inlined from 'do_nsp32_isr' at drivers/scsi/nsp32.c:1188:15:
>> include/asm-generic/io.h:476:14: error: call to '_inw' declared with attribute error: inw() requires CONFIG_HAS_IOPORT
     476 | #define _inw _inw
   include/asm-generic/io.h:563:13: note: in expansion of macro '_inw'
     563 | #define inw _inw
         |             ^~~~
   drivers/scsi/nsp32_io.h:35:16: note: in expansion of macro 'inw'
      35 |         return inw(base + index);
         |                ^~~
   In function 'nsp32_write2',
       inlined from 'do_nsp32_isr' at drivers/scsi/nsp32.c:1202:3:
   include/asm-generic/io.h:527:15: error: call to '_outw' declared with attribute error: outw() requires CONFIG_HAS_IOPORT
     527 | #define _outw _outw
   include/asm-generic/io.h:575:14: note: in expansion of macro '_outw'
     575 | #define outw _outw
         |              ^~~~~
   drivers/scsi/nsp32_io.h:29:9: note: in expansion of macro 'outw'
      29 |         outw(val, (base + index));
         |         ^~~~
   In function 'nsp32_read2',
       inlined from 'do_nsp32_isr' at drivers/scsi/nsp32.c:1232:15:
   include/asm-generic/io.h:476:14: error: call to '_inw' declared with attribute error: inw() requires CONFIG_HAS_IOPORT
     476 | #define _inw _inw
   include/asm-generic/io.h:563:13: note: in expansion of macro '_inw'
     563 | #define inw _inw
         |             ^~~~
   drivers/scsi/nsp32_io.h:35:16: note: in expansion of macro 'inw'
      35 |         return inw(base + index);
         |                ^~~
   In function 'nsp32_write2',
       inlined from 'do_nsp32_isr' at drivers/scsi/nsp32.c:1233:3:
   include/asm-generic/io.h:527:15: error: call to '_outw' declared with attribute error: outw() requires CONFIG_HAS_IOPORT
     527 | #define _outw _outw
   include/asm-generic/io.h:575:14: note: in expansion of macro '_outw'
     575 | #define outw _outw
         |              ^~~~~
   drivers/scsi/nsp32_io.h:29:9: note: in expansion of macro 'outw'
      29 |         outw(val, (base + index));
         |         ^~~~
   In function 'nsp32_read2',
       inlined from 'do_nsp32_isr' at drivers/scsi/nsp32.c:1267:9:
   include/asm-generic/io.h:476:14: error: call to '_inw' declared with attribute error: inw() requires CONFIG_HAS_IOPORT
     476 | #define _inw _inw
   include/asm-generic/io.h:563:13: note: in expansion of macro '_inw'
     563 | #define inw _inw
         |             ^~~~
   drivers/scsi/nsp32_io.h:35:16: note: in expansion of macro 'inw'
      35 |         return inw(base + index);
         |                ^~~
   In function 'nsp32_write2',
       inlined from 'nsp32_msgout_occur' at drivers/scsi/nsp32.c:1831:4,
       inlined from 'do_nsp32_isr' at drivers/scsi/nsp32.c:1301:4:
   include/asm-generic/io.h:527:15: error: call to '_outw' declared with attribute error: outw() requires CONFIG_HAS_IOPORT
     527 | #define _outw _outw
   include/asm-generic/io.h:575:14: note: in expansion of macro '_outw'
     575 | #define outw _outw
         |              ^~~~~
   drivers/scsi/nsp32_io.h:29:9: note: in expansion of macro 'outw'
      29 |         outw(val, (base + index));
         |         ^~~~
   In function 'nsp32_write1',
       inlined from 'nsp32_msgout_occur' at drivers/scsi/nsp32.c:1842:3,
       inlined from 'do_nsp32_isr' at drivers/scsi/nsp32.c:1301:4:
   include/asm-generic/io.h:512:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     512 | #define _outb _outb
   include/asm-generic/io.h:571:14: note: in expansion of macro '_outb'
     571 | #define outb _outb
         |              ^~~~~
   drivers/scsi/nsp32_io.h:16:9: note: in expansion of macro 'outb'
      16 |         outb(val, (base + index));
         |         ^~~~
   In function 'nsp32_read1',
       inlined from 'nsp32_wait_sack' at drivers/scsi/nsp32.c:2495:9,
       inlined from 'nsp32_msgout_occur' at drivers/scsi/nsp32.c:1843:3,
       inlined from 'do_nsp32_isr' at drivers/scsi/nsp32.c:1301:4:
   include/asm-generic/io.h:458:14: error: call to '_inb' declared with attribute error: inb()) requires CONFIG_HAS_IOPORT
     458 | #define _inb _inb
   include/asm-generic/io.h:559:13: note: in expansion of macro '_inb'
     559 | #define inb _inb
         |             ^~~~
   drivers/scsi/nsp32_io.h:22:16: note: in expansion of macro 'inb'
      22 |         return inb(base + index);
         |                ^~~
   In function 'nsp32_read1',
       inlined from 'do_nsp32_isr' at drivers/scsi/nsp32.c:1322:25:
   include/asm-generic/io.h:458:14: error: call to '_inb' declared with attribute error: inb()) requires CONFIG_HAS_IOPORT
     458 | #define _inb _inb
   include/asm-generic/io.h:559:13: note: in expansion of macro '_inb'
     559 | #define inb _inb
         |             ^~~~
   drivers/scsi/nsp32_io.h:22:16: note: in expansion of macro 'inb'
      22 |         return inb(base + index);
         |                ^~~
   In function 'nsp32_read1',
       inlined from 'nsp32_sack_assert' at drivers/scsi/nsp32.c:2518:13,
       inlined from 'do_nsp32_isr' at drivers/scsi/nsp32.c:1335:4:
   include/asm-generic/io.h:458:14: error: call to '_inb' declared with attribute error: inb()) requires CONFIG_HAS_IOPORT
     458 | #define _inb _inb
   include/asm-generic/io.h:559:13: note: in expansion of macro '_inb'
     559 | #define inb _inb
         |             ^~~~
   drivers/scsi/nsp32_io.h:22:16: note: in expansion of macro 'inb'
..


vim +/_outl +542 include/asm-generic/io.h

9216efafc52ff9 Thierry Reding  2014-10-01  474  
f009c89df79abe John Garry      2020-03-28  475  #if !defined(inw) && !defined(_inw)
f009c89df79abe John Garry      2020-03-28 @476  #define _inw _inw
2d239b86b34775 Niklas Schnelle 2021-12-20  477  #ifdef CONFIG_HAS_IOPORT
f009c89df79abe John Garry      2020-03-28  478  static inline u16 _inw(unsigned long addr)
9216efafc52ff9 Thierry Reding  2014-10-01  479  {
87fe2d543f8173 Sinan Kaya      2018-04-05  480  	u16 val;
87fe2d543f8173 Sinan Kaya      2018-04-05  481  
87fe2d543f8173 Sinan Kaya      2018-04-05  482  	__io_pbr();
c1d55d50139bea Stafford Horne  2020-07-29  483  	val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
abbbbc83a210e9 Will Deacon     2019-02-22  484  	__io_par(val);
87fe2d543f8173 Sinan Kaya      2018-04-05  485  	return val;
9216efafc52ff9 Thierry Reding  2014-10-01  486  }
2d239b86b34775 Niklas Schnelle 2021-12-20  487  #else
2d239b86b34775 Niklas Schnelle 2021-12-20  488  u16 _inw(unsigned long addr)
2d239b86b34775 Niklas Schnelle 2021-12-20  489  	__compiletime_error("inw() requires CONFIG_HAS_IOPORT");
2d239b86b34775 Niklas Schnelle 2021-12-20  490  #endif
9216efafc52ff9 Thierry Reding  2014-10-01  491  #endif
9216efafc52ff9 Thierry Reding  2014-10-01  492  
f009c89df79abe John Garry      2020-03-28  493  #if !defined(inl) && !defined(_inl)
f009c89df79abe John Garry      2020-03-28 @494  #define _inl _inl
2d239b86b34775 Niklas Schnelle 2021-12-20  495  #ifdef CONFIG_HAS_IOPORT
214ba3584b2e2c Stafford Horne  2020-07-26  496  static inline u32 _inl(unsigned long addr)
9216efafc52ff9 Thierry Reding  2014-10-01  497  {
87fe2d543f8173 Sinan Kaya      2018-04-05  498  	u32 val;
87fe2d543f8173 Sinan Kaya      2018-04-05  499  
87fe2d543f8173 Sinan Kaya      2018-04-05  500  	__io_pbr();
c1d55d50139bea Stafford Horne  2020-07-29  501  	val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
abbbbc83a210e9 Will Deacon     2019-02-22  502  	__io_par(val);
87fe2d543f8173 Sinan Kaya      2018-04-05  503  	return val;
9216efafc52ff9 Thierry Reding  2014-10-01  504  }
2d239b86b34775 Niklas Schnelle 2021-12-20  505  #else
2d239b86b34775 Niklas Schnelle 2021-12-20  506  u32 _inl(unsigned long addr)
2d239b86b34775 Niklas Schnelle 2021-12-20  507  	__compiletime_error("inl() requires CONFIG_HAS_IOPORT");
2d239b86b34775 Niklas Schnelle 2021-12-20  508  #endif
9216efafc52ff9 Thierry Reding  2014-10-01  509  #endif
9216efafc52ff9 Thierry Reding  2014-10-01  510  
f009c89df79abe John Garry      2020-03-28  511  #if !defined(outb) && !defined(_outb)
f009c89df79abe John Garry      2020-03-28  512  #define _outb _outb
2d239b86b34775 Niklas Schnelle 2021-12-20  513  #ifdef CONFIG_HAS_IOPORT
f009c89df79abe John Garry      2020-03-28  514  static inline void _outb(u8 value, unsigned long addr)
9216efafc52ff9 Thierry Reding  2014-10-01  515  {
a7851aa54c0cdd Sinan Kaya      2018-04-05  516  	__io_pbw();
a7851aa54c0cdd Sinan Kaya      2018-04-05  517  	__raw_writeb(value, PCI_IOBASE + addr);
a7851aa54c0cdd Sinan Kaya      2018-04-05  518  	__io_paw();
9216efafc52ff9 Thierry Reding  2014-10-01  519  }
2d239b86b34775 Niklas Schnelle 2021-12-20  520  #else
2d239b86b34775 Niklas Schnelle 2021-12-20  521  void _outb(u8 value, unsigned long addr)
2d239b86b34775 Niklas Schnelle 2021-12-20  522  	__compiletime_error("outb() requires CONFIG_HAS_IOPORT");
2d239b86b34775 Niklas Schnelle 2021-12-20  523  #endif
9216efafc52ff9 Thierry Reding  2014-10-01  524  #endif
9216efafc52ff9 Thierry Reding  2014-10-01  525  
f009c89df79abe John Garry      2020-03-28  526  #if !defined(outw) && !defined(_outw)
f009c89df79abe John Garry      2020-03-28  527  #define _outw _outw
2d239b86b34775 Niklas Schnelle 2021-12-20  528  #ifdef CONFIG_HAS_IOPORT
f009c89df79abe John Garry      2020-03-28  529  static inline void _outw(u16 value, unsigned long addr)
9216efafc52ff9 Thierry Reding  2014-10-01  530  {
a7851aa54c0cdd Sinan Kaya      2018-04-05  531  	__io_pbw();
c1d55d50139bea Stafford Horne  2020-07-29  532  	__raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
a7851aa54c0cdd Sinan Kaya      2018-04-05  533  	__io_paw();
9216efafc52ff9 Thierry Reding  2014-10-01  534  }
2d239b86b34775 Niklas Schnelle 2021-12-20  535  #else
2d239b86b34775 Niklas Schnelle 2021-12-20  536  void _outw(u16 value, unsigned long addr)
2d239b86b34775 Niklas Schnelle 2021-12-20  537  	__compiletime_error("outw() requires CONFIG_HAS_IOPORT");
2d239b86b34775 Niklas Schnelle 2021-12-20  538  #endif
9216efafc52ff9 Thierry Reding  2014-10-01  539  #endif
9216efafc52ff9 Thierry Reding  2014-10-01  540  
f009c89df79abe John Garry      2020-03-28  541  #if !defined(outl) && !defined(_outl)
f009c89df79abe John Garry      2020-03-28 @542  #define _outl _outl
2d239b86b34775 Niklas Schnelle 2021-12-20  543  #ifdef CONFIG_HAS_IOPORT
f009c89df79abe John Garry      2020-03-28  544  static inline void _outl(u32 value, unsigned long addr)
9216efafc52ff9 Thierry Reding  2014-10-01  545  {
a7851aa54c0cdd Sinan Kaya      2018-04-05  546  	__io_pbw();
c1d55d50139bea Stafford Horne  2020-07-29  547  	__raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
a7851aa54c0cdd Sinan Kaya      2018-04-05  548  	__io_paw();
9216efafc52ff9 Thierry Reding  2014-10-01  549  }
2d239b86b34775 Niklas Schnelle 2021-12-20  550  #else
2d239b86b34775 Niklas Schnelle 2021-12-20  551  void _outl(u32 value, unsigned long addr)
2d239b86b34775 Niklas Schnelle 2021-12-20  552  	__compiletime_error("outl() requires CONFIG_HAS_IOPORT");
2d239b86b34775 Niklas Schnelle 2021-12-20  553  #endif
9216efafc52ff9 Thierry Reding  2014-10-01  554  #endif
9216efafc52ff9 Thierry Reding  2014-10-01  555  
f009c89df79abe John Garry      2020-03-28  556  #include <linux/logic_pio.h>
f009c89df79abe John Garry      2020-03-28  557  
f009c89df79abe John Garry      2020-03-28  558  #ifndef inb
f009c89df79abe John Garry      2020-03-28 @559  #define inb _inb
f009c89df79abe John Garry      2020-03-28  560  #endif
f009c89df79abe John Garry      2020-03-28  561  
f009c89df79abe John Garry      2020-03-28  562  #ifndef inw
f009c89df79abe John Garry      2020-03-28  563  #define inw _inw
f009c89df79abe John Garry      2020-03-28  564  #endif
f009c89df79abe John Garry      2020-03-28  565  
f009c89df79abe John Garry      2020-03-28  566  #ifndef inl
f009c89df79abe John Garry      2020-03-28  567  #define inl _inl
f009c89df79abe John Garry      2020-03-28  568  #endif
f009c89df79abe John Garry      2020-03-28  569  
f009c89df79abe John Garry      2020-03-28  570  #ifndef outb
f009c89df79abe John Garry      2020-03-28 @571  #define outb _outb
f009c89df79abe John Garry      2020-03-28  572  #endif
f009c89df79abe John Garry      2020-03-28  573  
f009c89df79abe John Garry      2020-03-28  574  #ifndef outw
f009c89df79abe John Garry      2020-03-28  575  #define outw _outw
f009c89df79abe John Garry      2020-03-28  576  #endif
f009c89df79abe John Garry      2020-03-28  577  
f009c89df79abe John Garry      2020-03-28  578  #ifndef outl
f009c89df79abe John Garry      2020-03-28  579  #define outl _outl
f009c89df79abe John Garry      2020-03-28  580  #endif
f009c89df79abe John Garry      2020-03-28  581  
9216efafc52ff9 Thierry Reding  2014-10-01  582  #ifndef inb_p
9216efafc52ff9 Thierry Reding  2014-10-01  583  #define inb_p inb_p
9216efafc52ff9 Thierry Reding  2014-10-01  584  static inline u8 inb_p(unsigned long addr)
9216efafc52ff9 Thierry Reding  2014-10-01  585  {
9216efafc52ff9 Thierry Reding  2014-10-01  586  	return inb(addr);
9216efafc52ff9 Thierry Reding  2014-10-01  587  }
9216efafc52ff9 Thierry Reding  2014-10-01  588  #endif
9216efafc52ff9 Thierry Reding  2014-10-01  589  
9216efafc52ff9 Thierry Reding  2014-10-01  590  #ifndef inw_p
9216efafc52ff9 Thierry Reding  2014-10-01  591  #define inw_p inw_p
9216efafc52ff9 Thierry Reding  2014-10-01  592  static inline u16 inw_p(unsigned long addr)
9216efafc52ff9 Thierry Reding  2014-10-01  593  {
9216efafc52ff9 Thierry Reding  2014-10-01  594  	return inw(addr);
9216efafc52ff9 Thierry Reding  2014-10-01  595  }
9216efafc52ff9 Thierry Reding  2014-10-01  596  #endif
9216efafc52ff9 Thierry Reding  2014-10-01  597  
9216efafc52ff9 Thierry Reding  2014-10-01  598  #ifndef inl_p
9216efafc52ff9 Thierry Reding  2014-10-01  599  #define inl_p inl_p
9216efafc52ff9 Thierry Reding  2014-10-01  600  static inline u32 inl_p(unsigned long addr)
9216efafc52ff9 Thierry Reding  2014-10-01  601  {
9216efafc52ff9 Thierry Reding  2014-10-01  602  	return inl(addr);
9216efafc52ff9 Thierry Reding  2014-10-01  603  }
9216efafc52ff9 Thierry Reding  2014-10-01  604  #endif
9216efafc52ff9 Thierry Reding  2014-10-01  605  
9216efafc52ff9 Thierry Reding  2014-10-01  606  #ifndef outb_p
9216efafc52ff9 Thierry Reding  2014-10-01  607  #define outb_p outb_p
9216efafc52ff9 Thierry Reding  2014-10-01  608  static inline void outb_p(u8 value, unsigned long addr)
9216efafc52ff9 Thierry Reding  2014-10-01  609  {
9216efafc52ff9 Thierry Reding  2014-10-01  610  	outb(value, addr);
9216efafc52ff9 Thierry Reding  2014-10-01  611  }
9216efafc52ff9 Thierry Reding  2014-10-01  612  #endif
9216efafc52ff9 Thierry Reding  2014-10-01  613  
9216efafc52ff9 Thierry Reding  2014-10-01  614  #ifndef outw_p
9216efafc52ff9 Thierry Reding  2014-10-01  615  #define outw_p outw_p
9216efafc52ff9 Thierry Reding  2014-10-01  616  static inline void outw_p(u16 value, unsigned long addr)
9216efafc52ff9 Thierry Reding  2014-10-01  617  {
9216efafc52ff9 Thierry Reding  2014-10-01  618  	outw(value, addr);
9216efafc52ff9 Thierry Reding  2014-10-01  619  }
9216efafc52ff9 Thierry Reding  2014-10-01  620  #endif
9216efafc52ff9 Thierry Reding  2014-10-01  621  
9216efafc52ff9 Thierry Reding  2014-10-01  622  #ifndef outl_p
9216efafc52ff9 Thierry Reding  2014-10-01  623  #define outl_p outl_p
9216efafc52ff9 Thierry Reding  2014-10-01  624  static inline void outl_p(u32 value, unsigned long addr)
9216efafc52ff9 Thierry Reding  2014-10-01  625  {
9216efafc52ff9 Thierry Reding  2014-10-01  626  	outl(value, addr);
9216efafc52ff9 Thierry Reding  2014-10-01  627  }
9216efafc52ff9 Thierry Reding  2014-10-01  628  #endif
9216efafc52ff9 Thierry Reding  2014-10-01  629  
9ab3a7a0d2b417 Thierry Reding  2014-07-04  630  /*
9ab3a7a0d2b417 Thierry Reding  2014-07-04  631   * {in,out}s{b,w,l}{,_p}() are variants of the above that repeatedly access a
9ab3a7a0d2b417 Thierry Reding  2014-07-04  632   * single I/O port multiple times.
9ab3a7a0d2b417 Thierry Reding  2014-07-04  633   */
9ab3a7a0d2b417 Thierry Reding  2014-07-04  634  
9ab3a7a0d2b417 Thierry Reding  2014-07-04  635  #ifndef insb
9ab3a7a0d2b417 Thierry Reding  2014-07-04 @636  #define insb insb
2d239b86b34775 Niklas Schnelle 2021-12-20  637  #ifdef CONFIG_HAS_IOPORT
9ab3a7a0d2b417 Thierry Reding  2014-07-04  638  static inline void insb(unsigned long addr, void *buffer, unsigned int count)
9ab3a7a0d2b417 Thierry Reding  2014-07-04  639  {
9ab3a7a0d2b417 Thierry Reding  2014-07-04  640  	readsb(PCI_IOBASE + addr, buffer, count);
9ab3a7a0d2b417 Thierry Reding  2014-07-04  641  }
2d239b86b34775 Niklas Schnelle 2021-12-20  642  #else
2d239b86b34775 Niklas Schnelle 2021-12-20  643  void insb(unsigned long addr, void *buffer, unsigned int count)
2d239b86b34775 Niklas Schnelle 2021-12-20  644  	__compiletime_error("insb() requires HAS_IOPORT");
2d239b86b34775 Niklas Schnelle 2021-12-20  645  #endif
9ab3a7a0d2b417 Thierry Reding  2014-07-04  646  #endif
9ab3a7a0d2b417 Thierry Reding  2014-07-04  647  
9ab3a7a0d2b417 Thierry Reding  2014-07-04  648  #ifndef insw
9ab3a7a0d2b417 Thierry Reding  2014-07-04  649  #define insw insw
2d239b86b34775 Niklas Schnelle 2021-12-20  650  #ifdef CONFIG_HAS_IOPORT
9ab3a7a0d2b417 Thierry Reding  2014-07-04  651  static inline void insw(unsigned long addr, void *buffer, unsigned int count)
9ab3a7a0d2b417 Thierry Reding  2014-07-04  652  {
9ab3a7a0d2b417 Thierry Reding  2014-07-04  653  	readsw(PCI_IOBASE + addr, buffer, count);
9ab3a7a0d2b417 Thierry Reding  2014-07-04  654  }
2d239b86b34775 Niklas Schnelle 2021-12-20  655  #else
2d239b86b34775 Niklas Schnelle 2021-12-20  656  void insw(unsigned long addr, void *buffer, unsigned int count)
2d239b86b34775 Niklas Schnelle 2021-12-20  657  	__compiletime_error("insw() requires HAS_IOPORT");
2d239b86b34775 Niklas Schnelle 2021-12-20  658  #endif
9ab3a7a0d2b417 Thierry Reding  2014-07-04  659  #endif
9ab3a7a0d2b417 Thierry Reding  2014-07-04  660  
9ab3a7a0d2b417 Thierry Reding  2014-07-04  661  #ifndef insl
9ab3a7a0d2b417 Thierry Reding  2014-07-04  662  #define insl insl
2d239b86b34775 Niklas Schnelle 2021-12-20  663  #ifdef CONFIG_HAS_IOPORT
9ab3a7a0d2b417 Thierry Reding  2014-07-04  664  static inline void insl(unsigned long addr, void *buffer, unsigned int count)
9ab3a7a0d2b417 Thierry Reding  2014-07-04  665  {
9ab3a7a0d2b417 Thierry Reding  2014-07-04  666  	readsl(PCI_IOBASE + addr, buffer, count);
9ab3a7a0d2b417 Thierry Reding  2014-07-04  667  }
2d239b86b34775 Niklas Schnelle 2021-12-20  668  #else
2d239b86b34775 Niklas Schnelle 2021-12-20  669  void insl(unsigned long addr, void *buffer, unsigned int count)
2d239b86b34775 Niklas Schnelle 2021-12-20  670  	__compiletime_error("insl() requires HAS_IOPORT");
2d239b86b34775 Niklas Schnelle 2021-12-20  671  #endif
9ab3a7a0d2b417 Thierry Reding  2014-07-04  672  #endif
9ab3a7a0d2b417 Thierry Reding  2014-07-04  673  
9ab3a7a0d2b417 Thierry Reding  2014-07-04  674  #ifndef outsb
9ab3a7a0d2b417 Thierry Reding  2014-07-04 @675  #define outsb outsb
2d239b86b34775 Niklas Schnelle 2021-12-20  676  #ifdef CONFIG_HAS_IOPORT
9ab3a7a0d2b417 Thierry Reding  2014-07-04  677  static inline void outsb(unsigned long addr, const void *buffer,
9ab3a7a0d2b417 Thierry Reding  2014-07-04  678  			 unsigned int count)
9ab3a7a0d2b417 Thierry Reding  2014-07-04  679  {
9ab3a7a0d2b417 Thierry Reding  2014-07-04  680  	writesb(PCI_IOBASE + addr, buffer, count);
9ab3a7a0d2b417 Thierry Reding  2014-07-04  681  }
2d239b86b34775 Niklas Schnelle 2021-12-20  682  #else
2d239b86b34775 Niklas Schnelle 2021-12-20  683  void outsb(unsigned long addr, const void *buffer, unsigned int count)
2d239b86b34775 Niklas Schnelle 2021-12-20  684  	__compiletime_error("outsb() requires HAS_IOPORT");
2d239b86b34775 Niklas Schnelle 2021-12-20  685  #endif
9ab3a7a0d2b417 Thierry Reding  2014-07-04  686  #endif
9ab3a7a0d2b417 Thierry Reding  2014-07-04  687  

:::::: The code at line 542 was first introduced by commit
:::::: f009c89df79abea5f5244b8135a205f7d4352f86 io: Provide _inX() and _outX()

:::::: TO: John Garry <john.garry@huawei.com>
:::::: CC: Wei Xu <xuwei5@hisilicon.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
