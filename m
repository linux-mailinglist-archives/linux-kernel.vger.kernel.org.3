Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3B651B56E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 03:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbiEEB6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 21:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235781AbiEEB6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 21:58:39 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9104D254
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 18:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651715700; x=1683251700;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=f//6Jn7PXdISOa4/n20Dz2TwJTb+EVmfayJ5QPI0PGM=;
  b=OpJbZUTZ8D0YJUovqb9O12zDLSV6RaHYFdpkjkgRuevyNTv1wmlIVHLs
   FqZ2HFV2Cra1qSOjdy1Pq/kCToLAAtUcRCGa062FNbti68HEAtYvdULbx
   3g4mpB3PDBeVrOJEN+pXQhczS02D4ddSOia/wWCDYinkIhNfyAkeuhbVX
   8AFrqLwQXnqGpLRUork31Sn8JZpADNmew2CdhPxUragHyfDZzdyb/c0KX
   YpSqp5y+DS2MWLL95UglhCDewc8n6JlKh1nFL8wPDhUxzCwyfOzk+eTue
   a66Ify5qT5poXp2oHMv79qrZN/xrfI+hsPNXly+mQHn378lBwDaYMYhte
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="255429508"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="255429508"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 18:54:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="537105274"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 04 May 2022 18:54:51 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmQhf-000ByZ-5K;
        Thu, 05 May 2022 01:54:51 +0000
Date:   Thu, 5 May 2022 09:53:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [niks:has_ioport_v3 39/39] include/asm-generic/io.h:512:15: error:
 call to '_outb' declared with attribute error: outb() requires
 CONFIG_HAS_IOPORT
Message-ID: <202205050953.WF8KVF3I-lkp@intel.com>
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
config: nios2-allyesconfig (https://download.01.org/0day-ci/archive/20220505/202205050953.WF8KVF3I-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git/commit/?id=2d239b86b347751644338b1dc5b64d25beb640ce
        git remote add niks https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git
        git fetch --no-tags niks has_ioport_v3
        git checkout 2d239b86b347751644338b1dc5b64d25beb640ce
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/nios2/include/asm/io.h:41,
                    from include/linux/io.h:13,
                    from arch/nios2/include/asm/pgtable.h:18,
                    from include/linux/pgtable.h:6,
                    from include/linux/mm.h:29,
                    from include/linux/pid_namespace.h:7,
                    from include/linux/ptrace.h:10,
                    from arch/nios2/include/uapi/asm/elf.h:24,
                    from arch/nios2/include/asm/elf.h:9,
                    from include/linux/elf.h:6,
                    from include/linux/module.h:19,
                    from drivers/video/console/vgacon.c:36:
   In function 'outb_p',
       inlined from 'vgacon_adjust_height' at drivers/video/console/vgacon.c:993:2:
>> include/asm-generic/io.h:512:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     512 | #define _outb _outb
         |               ^
   include/asm-generic/io.h:571:14: note: in expansion of macro '_outb'
     571 | #define outb _outb
         |              ^~~~~
   include/asm-generic/io.h:610:9: note: in expansion of macro 'outb'
     610 |         outb(value, addr);
         |         ^~~~
   In function 'inb_p',
       inlined from 'vgacon_adjust_height' at drivers/video/console/vgacon.c:994:8:
>> include/asm-generic/io.h:458:14: error: call to '_inb' declared with attribute error: inb()) requires CONFIG_HAS_IOPORT
     458 | #define _inb _inb
         |              ^
   include/asm-generic/io.h:559:13: note: in expansion of macro '_inb'
     559 | #define inb _inb
         |             ^~~~
   include/asm-generic/io.h:586:16: note: in expansion of macro 'inb'
     586 |         return inb(addr);
         |                ^~~
   In function 'outb_p',
       inlined from 'vgacon_adjust_height' at drivers/video/console/vgacon.c:995:2:
>> include/asm-generic/io.h:512:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     512 | #define _outb _outb
         |               ^
   include/asm-generic/io.h:571:14: note: in expansion of macro '_outb'
     571 | #define outb _outb
         |              ^~~~~
   include/asm-generic/io.h:610:9: note: in expansion of macro 'outb'
     610 |         outb(value, addr);
         |         ^~~~
   In function 'inb_p',
       inlined from 'vgacon_adjust_height' at drivers/video/console/vgacon.c:996:8:
>> include/asm-generic/io.h:458:14: error: call to '_inb' declared with attribute error: inb()) requires CONFIG_HAS_IOPORT
     458 | #define _inb _inb
         |              ^
   include/asm-generic/io.h:559:13: note: in expansion of macro '_inb'
     559 | #define inb _inb
         |             ^~~~
   include/asm-generic/io.h:586:16: note: in expansion of macro 'inb'
     586 |         return inb(addr);
         |                ^~~
   In function 'outb_p',
       inlined from 'vgacon_adjust_height' at drivers/video/console/vgacon.c:1005:2:
>> include/asm-generic/io.h:512:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     512 | #define _outb _outb
         |               ^
   include/asm-generic/io.h:571:14: note: in expansion of macro '_outb'
     571 | #define outb _outb
         |              ^~~~~
   include/asm-generic/io.h:610:9: note: in expansion of macro 'outb'
     610 |         outb(value, addr);
         |         ^~~~
   In function 'outb_p',
       inlined from 'vgacon_adjust_height' at drivers/video/console/vgacon.c:1006:2:
>> include/asm-generic/io.h:512:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     512 | #define _outb _outb
         |               ^
   include/asm-generic/io.h:571:14: note: in expansion of macro '_outb'
     571 | #define outb _outb
         |              ^~~~~
   include/asm-generic/io.h:610:9: note: in expansion of macro 'outb'
     610 |         outb(value, addr);
         |         ^~~~
   In function 'outb_p',
       inlined from 'vgacon_adjust_height' at drivers/video/console/vgacon.c:1007:2:
>> include/asm-generic/io.h:512:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     512 | #define _outb _outb
         |               ^
   include/asm-generic/io.h:571:14: note: in expansion of macro '_outb'
     571 | #define outb _outb
         |              ^~~~~
   include/asm-generic/io.h:610:9: note: in expansion of macro 'outb'
     610 |         outb(value, addr);
         |         ^~~~
   In function 'outb_p',
       inlined from 'vgacon_adjust_height' at drivers/video/console/vgacon.c:1008:2:
>> include/asm-generic/io.h:512:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     512 | #define _outb _outb
         |               ^
   include/asm-generic/io.h:571:14: note: in expansion of macro '_outb'
     571 | #define outb _outb
         |              ^~~~~
   include/asm-generic/io.h:610:9: note: in expansion of macro 'outb'
     610 |         outb(value, addr);
         |         ^~~~
   In function 'outb_p',
       inlined from 'vgacon_adjust_height' at drivers/video/console/vgacon.c:1009:2:
>> include/asm-generic/io.h:512:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     512 | #define _outb _outb
         |               ^
   include/asm-generic/io.h:571:14: note: in expansion of macro '_outb'
     571 | #define outb _outb
         |              ^~~~~
   include/asm-generic/io.h:610:9: note: in expansion of macro 'outb'
     610 |         outb(value, addr);
         |         ^~~~
   In function 'outb_p',
       inlined from 'vgacon_adjust_height' at drivers/video/console/vgacon.c:1010:2:
>> include/asm-generic/io.h:512:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     512 | #define _outb _outb
         |               ^
   include/asm-generic/io.h:571:14: note: in expansion of macro '_outb'
     571 | #define outb _outb
         |              ^~~~~
   include/asm-generic/io.h:610:9: note: in expansion of macro 'outb'
     610 |         outb(value, addr);
         |         ^~~~
   In function 'inb_p',
       inlined from 'vgacon_startup' at drivers/video/console/vgacon.c:267:6:
>> include/asm-generic/io.h:458:14: error: call to '_inb' declared with attribute error: inb()) requires CONFIG_HAS_IOPORT
     458 | #define _inb _inb
         |              ^
   include/asm-generic/io.h:559:13: note: in expansion of macro '_inb'
     559 | #define inb _inb
         |             ^~~~
   include/asm-generic/io.h:586:16: note: in expansion of macro 'inb'
     586 |         return inb(addr);
         |                ^~~
   In function 'outb_p',
       inlined from 'vgacon_startup' at drivers/video/console/vgacon.c:268:6:
>> include/asm-generic/io.h:512:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     512 | #define _outb _outb
         |               ^
   include/asm-generic/io.h:571:14: note: in expansion of macro '_outb'
     571 | #define outb _outb
         |              ^~~~~
   include/asm-generic/io.h:610:9: note: in expansion of macro 'outb'
     610 |         outb(value, addr);
         |         ^~~~
   In function 'outb_p',
       inlined from 'vgacon_startup' at drivers/video/console/vgacon.c:269:6:
>> include/asm-generic/io.h:512:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     512 | #define _outb _outb
         |               ^
   include/asm-generic/io.h:571:14: note: in expansion of macro '_outb'
     571 | #define outb _outb
         |              ^~~~~
   include/asm-generic/io.h:610:9: note: in expansion of macro 'outb'
     610 |         outb(value, addr);
         |         ^~~~
   In function 'outb_p',
       inlined from 'vgacon_startup' at drivers/video/console/vgacon.c:271:5:
>> include/asm-generic/io.h:512:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     512 | #define _outb _outb
         |               ^
   include/asm-generic/io.h:571:14: note: in expansion of macro '_outb'
     571 | #define outb _outb
         |              ^~~~~
   include/asm-generic/io.h:610:9: note: in expansion of macro 'outb'
     610 |         outb(value, addr);
         |         ^~~~
   In function 'outb_p',
       inlined from 'vgacon_startup' at drivers/video/console/vgacon.c:278:6:
>> include/asm-generic/io.h:512:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     512 | #define _outb _outb
         |               ^
   include/asm-generic/io.h:571:14: note: in expansion of macro '_outb'
     571 | #define outb _outb
         |              ^~~~~
   include/asm-generic/io.h:610:9: note: in expansion of macro 'outb'
     610 |         outb(value, addr);
         |         ^~~~
   In function 'outb_p',
       inlined from 'vgacon_startup' at drivers/video/console/vgacon.c:279:6:
>> include/asm-generic/io.h:512:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     512 | #define _outb _outb
         |               ^
   include/asm-generic/io.h:571:14: note: in expansion of macro '_outb'
     571 | #define outb _outb
         |              ^~~~~
   include/asm-generic/io.h:610:9: note: in expansion of macro 'outb'
     610 |         outb(value, addr);
         |         ^~~~
   In function 'outb_p',
       inlined from 'vgacon_startup' at drivers/video/console/vgacon.c:280:6:
>> include/asm-generic/io.h:512:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     512 | #define _outb _outb
         |               ^
   include/asm-generic/io.h:571:14: note: in expansion of macro '_outb'
     571 | #define outb _outb
         |              ^~~~~
   include/asm-generic/io.h:610:9: note: in expansion of macro 'outb'
     610 |         outb(value, addr);
         |         ^~~~
   In function 'outb_p',
       inlined from 'vgacon_startup' at drivers/video/console/vgacon.c:281:6:
>> include/asm-generic/io.h:512:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     512 | #define _outb _outb
         |               ^
   include/asm-generic/io.h:571:14: note: in expansion of macro '_outb'
     571 | #define outb _outb
         |              ^~~~~
   include/asm-generic/io.h:610:9: note: in expansion of macro 'outb'
     610 |         outb(value, addr);
         |         ^~~~
   In function 'inb_p',
       inlined from 'vgacon_do_font_op.constprop' at drivers/video/console/vgacon.c:945:3:
>> include/asm-generic/io.h:458:14: error: call to '_inb' declared with attribute error: inb()) requires CONFIG_HAS_IOPORT
     458 | #define _inb _inb
         |              ^
   include/asm-generic/io.h:559:13: note: in expansion of macro '_inb'
     559 | #define inb _inb
         |             ^~~~
   include/asm-generic/io.h:586:16: note: in expansion of macro 'inb'
     586 |         return inb(addr);
         |                ^~~
   In function 'inb_p',
       inlined from 'vgacon_do_font_op.constprop' at drivers/video/console/vgacon.c:950:3:
>> include/asm-generic/io.h:458:14: error: call to '_inb' declared with attribute error: inb()) requires CONFIG_HAS_IOPORT
     458 | #define _inb _inb
         |              ^
   include/asm-generic/io.h:559:13: note: in expansion of macro '_inb'
     559 | #define inb _inb
         |             ^~~~
   include/asm-generic/io.h:586:16: note: in expansion of macro 'inb'
     586 |         return inb(addr);
         |                ^~~
   In function 'outb_p',
       inlined from 'vga_vesa_unblank.constprop' at drivers/video/console/vgacon.c:751:2:
   include/asm-generic/io.h:512:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     512 | #define _outb _outb
         |               ^
   include/asm-generic/io.h:571:14: note: in expansion of macro '_outb'
     571 | #define outb _outb
         |              ^~~~~
   include/asm-generic/io.h:610:9: note: in expansion of macro 'outb'
     610 |         outb(value, addr);
         |         ^~~~
   In function 'outb_p',
       inlined from 'vga_vesa_unblank.constprop' at drivers/video/console/vgacon.c:752:2:
   include/asm-generic/io.h:512:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     512 | #define _outb _outb
         |               ^
   include/asm-generic/io.h:571:14: note: in expansion of macro '_outb'
     571 | #define outb _outb
         |              ^~~~~
   include/asm-generic/io.h:610:9: note: in expansion of macro 'outb'
     610 |         outb(value, addr);
         |         ^~~~
   In function 'outb_p',
       inlined from 'vga_vesa_unblank.constprop' at drivers/video/console/vgacon.c:753:2:
   include/asm-generic/io.h:512:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     512 | #define _outb _outb
         |               ^
   include/asm-generic/io.h:571:14: note: in expansion of macro '_outb'
     571 | #define outb _outb
         |              ^~~~~
   include/asm-generic/io.h:610:9: note: in expansion of macro 'outb'
     610 |         outb(value, addr);
         |         ^~~~
   In function 'outb_p',
       inlined from 'vga_vesa_unblank.constprop' at drivers/video/console/vgacon.c:754:2:
   include/asm-generic/io.h:512:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     512 | #define _outb _outb
         |               ^
   include/asm-generic/io.h:571:14: note: in expansion of macro '_outb'
     571 | #define outb _outb
         |              ^~~~~
   include/asm-generic/io.h:610:9: note: in expansion of macro 'outb'
     610 |         outb(value, addr);
         |         ^~~~
   In function 'outb_p',
       inlined from 'vga_vesa_unblank.constprop' at drivers/video/console/vgacon.c:755:2:
   include/asm-generic/io.h:512:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     512 | #define _outb _outb
         |               ^
   include/asm-generic/io.h:571:14: note: in expansion of macro '_outb'
     571 | #define outb _outb
         |              ^~~~~
   include/asm-generic/io.h:610:9: note: in expansion of macro 'outb'
     610 |         outb(value, addr);
         |         ^~~~
   In function 'outb_p',
       inlined from 'vga_vesa_unblank.constprop' at drivers/video/console/vgacon.c:756:2:
   include/asm-generic/io.h:512:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     512 | #define _outb _outb
         |               ^
   include/asm-generic/io.h:571:14: note: in expansion of macro '_outb'
     571 | #define outb _outb
         |              ^~~~~
   include/asm-generic/io.h:610:9: note: in expansion of macro 'outb'
     610 |         outb(value, addr);
         |         ^~~~
   In function 'outb_p',
       inlined from 'vga_vesa_unblank.constprop' at drivers/video/console/vgacon.c:757:2:
   include/asm-generic/io.h:512:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     512 | #define _outb _outb
         |               ^
   include/asm-generic/io.h:571:14: note: in expansion of macro '_outb'
     571 | #define outb _outb
         |              ^~~~~
   include/asm-generic/io.h:610:9: note: in expansion of macro 'outb'
     610 |         outb(value, addr);
         |         ^~~~
   In function 'outb_p',
       inlined from 'vga_vesa_unblank.constprop' at drivers/video/console/vgacon.c:758:2:
   include/asm-generic/io.h:512:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     512 | #define _outb _outb
         |               ^
   include/asm-generic/io.h:571:14: note: in expansion of macro '_outb'
     571 | #define outb _outb
         |              ^~~~~
   include/asm-generic/io.h:610:9: note: in expansion of macro 'outb'
     610 |         outb(value, addr);
         |         ^~~~
   In function 'outb_p',
       inlined from 'vga_vesa_unblank.constprop' at drivers/video/console/vgacon.c:759:2:
   include/asm-generic/io.h:512:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     512 | #define _outb _outb


vim +/_outb +512 include/asm-generic/io.h

3f7e212df82ca0 Arnd Bergmann   2009-05-13  450  
9216efafc52ff9 Thierry Reding  2014-10-01  451  /*
9216efafc52ff9 Thierry Reding  2014-10-01  452   * {in,out}{b,w,l}() access little endian I/O. {in,out}{b,w,l}_p() can be
9216efafc52ff9 Thierry Reding  2014-10-01  453   * implemented on hardware that needs an additional delay for I/O accesses to
9216efafc52ff9 Thierry Reding  2014-10-01  454   * take effect.
9216efafc52ff9 Thierry Reding  2014-10-01  455   */
9216efafc52ff9 Thierry Reding  2014-10-01  456  
f009c89df79abe John Garry      2020-03-28  457  #if !defined(inb) && !defined(_inb)
f009c89df79abe John Garry      2020-03-28 @458  #define _inb _inb
2d239b86b34775 Niklas Schnelle 2021-12-20  459  #ifdef CONFIG_HAS_IOPORT
214ba3584b2e2c Stafford Horne  2020-07-26  460  static inline u8 _inb(unsigned long addr)
9216efafc52ff9 Thierry Reding  2014-10-01  461  {
87fe2d543f8173 Sinan Kaya      2018-04-05  462  	u8 val;
87fe2d543f8173 Sinan Kaya      2018-04-05  463  
87fe2d543f8173 Sinan Kaya      2018-04-05  464  	__io_pbr();
87fe2d543f8173 Sinan Kaya      2018-04-05  465  	val = __raw_readb(PCI_IOBASE + addr);
abbbbc83a210e9 Will Deacon     2019-02-22  466  	__io_par(val);
87fe2d543f8173 Sinan Kaya      2018-04-05  467  	return val;
9216efafc52ff9 Thierry Reding  2014-10-01  468  }
2d239b86b34775 Niklas Schnelle 2021-12-20  469  #else
2d239b86b34775 Niklas Schnelle 2021-12-20  470  u8 _inb(unsigned long addr)
2d239b86b34775 Niklas Schnelle 2021-12-20  471  	__compiletime_error("inb()) requires CONFIG_HAS_IOPORT");
2d239b86b34775 Niklas Schnelle 2021-12-20  472  #endif
9216efafc52ff9 Thierry Reding  2014-10-01  473  #endif
9216efafc52ff9 Thierry Reding  2014-10-01  474  
f009c89df79abe John Garry      2020-03-28  475  #if !defined(inw) && !defined(_inw)
f009c89df79abe John Garry      2020-03-28  476  #define _inw _inw
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
f009c89df79abe John Garry      2020-03-28  494  #define _inl _inl
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
f009c89df79abe John Garry      2020-03-28 @512  #define _outb _outb
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
f009c89df79abe John Garry      2020-03-28 @527  #define _outw _outw
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

:::::: The code at line 512 was first introduced by commit
:::::: f009c89df79abea5f5244b8135a205f7d4352f86 io: Provide _inX() and _outX()

:::::: TO: John Garry <john.garry@huawei.com>
:::::: CC: Wei Xu <xuwei5@hisilicon.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
