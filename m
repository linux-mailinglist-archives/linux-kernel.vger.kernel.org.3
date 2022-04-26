Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3615108F6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 21:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354141AbiDZTae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 15:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241779AbiDZTaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 15:30:30 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490396E8C9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 12:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651001242; x=1682537242;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zEcnyTYpfpi+xvrA/4iSPgFr1ehTLK7seCqFqpN4H1Q=;
  b=jKVN5ZXcDP3dVRkELAkoBgNtWlPOXPsEgi4NF1RlFZ88p6IG/UDuOVxp
   wj944vscV5N5b1kin6UOXezUZ3cd+lhsNgq6JgwfvNrMAjy3JHr+cOxa6
   OLzN6Zb8PirdPkiNXDQpA9aapwchDjFv6cnoTCxqaC9gNAnhjEziQWvrs
   coyo5PCzVwXRMdf75PChN7R12h573V92luDFk9SMlRfABieLI7Y7EzCKe
   rfBJE5UeL2+KDjLghmc47FnM+98/DCVPoL9nEiINlAmsZ7giK62MdGlhr
   cbC+AWV7UbIaBcSZ3DEZtPS9TXk6df7oBs2qk5ShcV/xLejX0WX7qjcn8
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="326187679"
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="326187679"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 12:27:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="532825890"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 26 Apr 2022 12:27:20 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njQqF-0003v0-Rc;
        Tue, 26 Apr 2022 19:27:19 +0000
Date:   Wed, 27 Apr 2022 03:26:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [niks:has_ioport 37/37] drivers/tty/serial/8250/8250_port.c:398:9:
 error: implicit declaration of function 'outb'
Message-ID: <202204270334.n8Pu6AGm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git has_ioport
head:   497d83d316c82255fcfbbefd3be766eeb46926d7
commit: 497d83d316c82255fcfbbefd3be766eeb46926d7 [37/37] asm-generic/io.h: drop inb() etc for HAS_IOPORT=n
config: m68k-randconfig-r023-20220425 (https://download.01.org/0day-ci/archive/20220427/202204270334.n8Pu6AGm-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git/commit/?id=497d83d316c82255fcfbbefd3be766eeb46926d7
        git remote add niks https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git
        git fetch --no-tags niks has_ioport
        git checkout 497d83d316c82255fcfbbefd3be766eeb46926d7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/tty/serial/8250/ lib/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/tty/serial/8250/8250_port.c: In function 'hub6_serial_in':
>> drivers/tty/serial/8250/8250_port.c:398:9: error: implicit declaration of function 'outb' [-Werror=implicit-function-declaration]
     398 |         outb(p->hub6 - 1 + offset, p->iobase);
         |         ^~~~
>> drivers/tty/serial/8250/8250_port.c:399:16: error: implicit declaration of function 'inb' [-Werror=implicit-function-declaration]
     399 |         return inb(p->iobase + 1);
         |                ^~~
   drivers/tty/serial/8250/8250_port.c: In function 'autoconfig_irq':
>> drivers/tty/serial/8250/8250_port.c:1395:28: error: implicit declaration of function 'inb_p'; did you mean 'int_pow'? [-Werror=implicit-function-declaration]
    1395 |                 save_ICP = inb_p(ICP);
         |                            ^~~~~
         |                            int_pow
>> drivers/tty/serial/8250/8250_port.c:1396:17: error: implicit declaration of function 'outb_p' [-Werror=implicit-function-declaration]
    1396 |                 outb_p(0x80, ICP);
         |                 ^~~~~~
   cc1: some warnings being treated as errors
--
   lib/iomap.c: In function 'ioread8':
>> lib/iomap.c:75:30: error: implicit declaration of function 'inb' [-Werror=implicit-function-declaration]
      75 |         IO_COND(addr, return inb(port), return readb(addr));
         |                              ^~~
   lib/iomap.c:57:17: note: in definition of macro 'IO_COND'
      57 |                 is_pio;                                         \
         |                 ^~~~~~
   lib/iomap.c: In function 'ioread16':
>> lib/iomap.c:80:30: error: implicit declaration of function 'inw' [-Werror=implicit-function-declaration]
      80 |         IO_COND(addr, return inw(port), return readw(addr));
         |                              ^~~
   lib/iomap.c:57:17: note: in definition of macro 'IO_COND'
      57 |                 is_pio;                                         \
         |                 ^~~~~~
   lib/iomap.c: In function 'ioread32':
>> lib/iomap.c:90:30: error: implicit declaration of function 'inl' [-Werror=implicit-function-declaration]
      90 |         IO_COND(addr, return inl(port), return readl(addr));
         |                              ^~~
   lib/iomap.c:57:17: note: in definition of macro 'IO_COND'
      57 |                 is_pio;                                         \
         |                 ^~~~~~
   lib/iomap.c: In function 'iowrite8':
>> lib/iomap.c:191:23: error: implicit declaration of function 'outb' [-Werror=implicit-function-declaration]
     191 |         IO_COND(addr, outb(val,port), writeb(val, addr));
         |                       ^~~~
   lib/iomap.c:57:17: note: in definition of macro 'IO_COND'
      57 |                 is_pio;                                         \
         |                 ^~~~~~
   lib/iomap.c: In function 'iowrite16':
>> lib/iomap.c:195:23: error: implicit declaration of function 'outw' [-Werror=implicit-function-declaration]
     195 |         IO_COND(addr, outw(val,port), writew(val, addr));
         |                       ^~~~
   lib/iomap.c:57:17: note: in definition of macro 'IO_COND'
      57 |                 is_pio;                                         \
         |                 ^~~~~~
   lib/iomap.c: In function 'iowrite32':
>> lib/iomap.c:203:23: error: implicit declaration of function 'outl' [-Werror=implicit-function-declaration]
     203 |         IO_COND(addr, outl(val,port), writel(val, addr));
         |                       ^~~~
   lib/iomap.c:57:17: note: in definition of macro 'IO_COND'
      57 |                 is_pio;                                         \
         |                 ^~~~~~
   lib/iomap.c: In function 'ioread8_rep':
>> lib/iomap.c:330:23: error: implicit declaration of function 'insb' [-Werror=implicit-function-declaration]
     330 |         IO_COND(addr, insb(port,dst,count), mmio_insb(addr, dst, count));
         |                       ^~~~
   lib/iomap.c:57:17: note: in definition of macro 'IO_COND'
      57 |                 is_pio;                                         \
         |                 ^~~~~~
   lib/iomap.c: In function 'ioread16_rep':
>> lib/iomap.c:334:23: error: implicit declaration of function 'insw' [-Werror=implicit-function-declaration]
     334 |         IO_COND(addr, insw(port,dst,count), mmio_insw(addr, dst, count));
         |                       ^~~~
   lib/iomap.c:57:17: note: in definition of macro 'IO_COND'
      57 |                 is_pio;                                         \
         |                 ^~~~~~
   lib/iomap.c: In function 'ioread32_rep':
>> lib/iomap.c:338:23: error: implicit declaration of function 'insl' [-Werror=implicit-function-declaration]
     338 |         IO_COND(addr, insl(port,dst,count), mmio_insl(addr, dst, count));
         |                       ^~~~
   lib/iomap.c:57:17: note: in definition of macro 'IO_COND'
      57 |                 is_pio;                                         \
         |                 ^~~~~~
   lib/iomap.c: In function 'iowrite8_rep':
>> lib/iomap.c:346:23: error: implicit declaration of function 'outsb' [-Werror=implicit-function-declaration]
     346 |         IO_COND(addr, outsb(port, src, count), mmio_outsb(addr, src, count));
         |                       ^~~~~
   lib/iomap.c:57:17: note: in definition of macro 'IO_COND'
      57 |                 is_pio;                                         \
         |                 ^~~~~~
   lib/iomap.c: In function 'iowrite16_rep':
>> lib/iomap.c:350:23: error: implicit declaration of function 'outsw' [-Werror=implicit-function-declaration]
     350 |         IO_COND(addr, outsw(port, src, count), mmio_outsw(addr, src, count));
         |                       ^~~~~
   lib/iomap.c:57:17: note: in definition of macro 'IO_COND'
      57 |                 is_pio;                                         \
         |                 ^~~~~~
   lib/iomap.c: In function 'iowrite32_rep':
>> lib/iomap.c:354:23: error: implicit declaration of function 'outsl' [-Werror=implicit-function-declaration]
     354 |         IO_COND(addr, outsl(port, src,count), mmio_outsl(addr, src, count));
         |                       ^~~~~
   lib/iomap.c:57:17: note: in definition of macro 'IO_COND'
      57 |                 is_pio;                                         \
         |                 ^~~~~~
   cc1: some warnings being treated as errors


vim +/outb +398 drivers/tty/serial/8250/8250_port.c

b6830f6df8914fa Peter Hurley 2015-06-27  394  
b6830f6df8914fa Peter Hurley 2015-06-27  395  static unsigned int hub6_serial_in(struct uart_port *p, int offset)
b6830f6df8914fa Peter Hurley 2015-06-27  396  {
b6830f6df8914fa Peter Hurley 2015-06-27  397  	offset = offset << p->regshift;
b6830f6df8914fa Peter Hurley 2015-06-27 @398  	outb(p->hub6 - 1 + offset, p->iobase);
b6830f6df8914fa Peter Hurley 2015-06-27 @399  	return inb(p->iobase + 1);
b6830f6df8914fa Peter Hurley 2015-06-27  400  }
b6830f6df8914fa Peter Hurley 2015-06-27  401  

:::::: The code at line 398 was first introduced by commit
:::::: b6830f6df8914faae9561bb245860c21af9b9e9b serial: 8250: Split base port operations from universal driver

:::::: TO: Peter Hurley <peter@hurleysoftware.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
