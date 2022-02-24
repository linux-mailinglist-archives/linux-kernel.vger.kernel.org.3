Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2564C356C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 20:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbiBXTL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 14:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233324AbiBXTLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:11:22 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA7920E785
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 11:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645729851; x=1677265851;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QtzrL0PflIvPK+q1/jEo82ohoM+GNPY29nMl8IZuArs=;
  b=KCQ0OOUsxP/XHQRFKcJSgJuBVpp/KLmTHXKZZdrzxD4D4FIVoJfh6kpM
   VVqQHQUYG7O2SAuEvNjExiLmhtJTQ9P1YIONmIEO7qATVEa7M+OLbkXWV
   +dMty6yycUTc1fyckOuZ9acJbR0MJF3VjxMSTswb5GUXPsLsKVnGOH+Lx
   d1fZtkUVkJQO6cJwriJE95cpqku7r7jiadJZAhram+GqkS5B7hmc2VsOV
   YdA2vPW0OV/laBxBls6aF0qnRvdemQcvastzO6Gdvs46suu5BcNCndIF7
   QL1QqOFB3vVFb8WveOpLP32LGFqbjGpOsJ4N+j7b2QrJHnWMBoSY5AZUC
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="239726510"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="239726510"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 11:10:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="574324648"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 24 Feb 2022 11:10:32 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNJVX-0003Ou-Pd; Thu, 24 Feb 2022 19:10:31 +0000
Date:   Fri, 25 Feb 2022 03:09:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jirislaby:devel 1/29] drivers/tty/serial/sunsab.c:869:45: error:
 passing argument 4 of 'uart_console_write' from incompatible pointer type
Message-ID: <202202250136.ZumlUcBa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git devel
head:   89830a2e427ed8ad318c6183ad524709ba507133
commit: 2f078dc9af6a2039313d845c99f8f16c36229608 [1/29] serial: make uart_console_write->putchar()'s character an unsigned char
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20220225/202202250136.ZumlUcBa-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?id=2f078dc9af6a2039313d845c99f8f16c36229608
        git remote add jirislaby https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git
        git fetch --no-tags jirislaby devel
        git checkout 2f078dc9af6a2039313d845c99f8f16c36229608
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/tty/serial/sunsab.c: In function 'sunsab_console_write':
>> drivers/tty/serial/sunsab.c:869:45: error: passing argument 4 of 'uart_console_write' from incompatible pointer type [-Werror=incompatible-pointer-types]
     869 |         uart_console_write(&up->port, s, n, sunsab_console_putchar);
         |                                             ^~~~~~~~~~~~~~~~~~~~~~
         |                                             |
         |                                             void (*)(struct uart_port *, int)
   In file included from drivers/tty/serial/sunsab.c:43:
   include/linux/serial_core.h:402:32: note: expected 'void (*)(struct uart_port *, unsigned char)' but argument is of type 'void (*)(struct uart_port *, int)'
     402 |                         void (*putchar)(struct uart_port *, unsigned char));
         |                         ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for OMAP_GPMC
   Depends on MEMORY && OF_ADDRESS
   Selected by
   - MTD_NAND_OMAP2 && MTD && MTD_RAW_NAND && (ARCH_OMAP2PLUS || ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST && HAS_IOMEM


vim +/uart_console_write +869 drivers/tty/serial/sunsab.c

^1da177e4c3f41 drivers/serial/sunsab.c     Linus Torvalds  2005-04-16  857  
^1da177e4c3f41 drivers/serial/sunsab.c     Linus Torvalds  2005-04-16  858  static void sunsab_console_write(struct console *con, const char *s, unsigned n)
^1da177e4c3f41 drivers/serial/sunsab.c     Linus Torvalds  2005-04-16  859  {
^1da177e4c3f41 drivers/serial/sunsab.c     Linus Torvalds  2005-04-16  860  	struct uart_sunsab_port *up = &sunsab_ports[con->index];
f3c681c028846b drivers/serial/sunsab.c     David S. Miller 2007-07-15  861  	unsigned long flags;
f3c681c028846b drivers/serial/sunsab.c     David S. Miller 2007-07-15  862  	int locked = 1;
f3c681c028846b drivers/serial/sunsab.c     David S. Miller 2007-07-15  863  
e58e241c178885 drivers/tty/serial/sunsab.c David Miller    2014-03-04  864  	if (up->port.sysrq || oops_in_progress)
e58e241c178885 drivers/tty/serial/sunsab.c David Miller    2014-03-04  865  		locked = spin_trylock_irqsave(&up->port.lock, flags);
e58e241c178885 drivers/tty/serial/sunsab.c David Miller    2014-03-04  866  	else
e58e241c178885 drivers/tty/serial/sunsab.c David Miller    2014-03-04  867  		spin_lock_irqsave(&up->port.lock, flags);
^1da177e4c3f41 drivers/serial/sunsab.c     Linus Torvalds  2005-04-16  868  
d358788f3f3011 drivers/serial/sunsab.c     Russell King    2006-03-20 @869  	uart_console_write(&up->port, s, n, sunsab_console_putchar);
^1da177e4c3f41 drivers/serial/sunsab.c     Linus Torvalds  2005-04-16  870  	sunsab_tec_wait(up);
f3c681c028846b drivers/serial/sunsab.c     David S. Miller 2007-07-15  871  
f3c681c028846b drivers/serial/sunsab.c     David S. Miller 2007-07-15  872  	if (locked)
e58e241c178885 drivers/tty/serial/sunsab.c David Miller    2014-03-04  873  		spin_unlock_irqrestore(&up->port.lock, flags);
^1da177e4c3f41 drivers/serial/sunsab.c     Linus Torvalds  2005-04-16  874  }
^1da177e4c3f41 drivers/serial/sunsab.c     Linus Torvalds  2005-04-16  875  

:::::: The code at line 869 was first introduced by commit
:::::: d358788f3f30113e49882187d794832905e42592 [SERIAL] kernel console should send CRLF not LFCR

:::::: TO: Russell King <rmk@dyn-67.arm.linux.org.uk>
:::::: CC: Russell King <rmk+kernel@arm.linux.org.uk>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
