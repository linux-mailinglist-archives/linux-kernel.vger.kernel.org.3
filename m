Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2B4492D28
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 19:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244268AbiARSVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 13:21:36 -0500
Received: from mga05.intel.com ([192.55.52.43]:62782 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347997AbiARSVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 13:21:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642530066; x=1674066066;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mDfn1FpOw7NLcGoQ7zlzVgfDXagzmr6ntkFGvUWdi6U=;
  b=QWBV/R9msggTLeEZFArFNu8/Gx4kkSN/rmU95y5VMI6PFHDAMgH3/iQj
   Y69lIOrSqiAAVIdLX/HYYh3CnIwJ25XuQSz9IODzGlRMBx9zAPPPIaW3l
   JRrLUNA5idWVJfUFNmbqJTCZZNYPEEJry966WjpHRnfVG4x32cvvUCBqx
   8bQ8DMOcPH7qfUz7poesHe4CvkN0Su7EE1EHGPXwtAhz2dbQ3QwUqS3aj
   fjeLXT0q8oyR9uWLtcX99pt/f+PoJd43MpRTZ2KyclezEB7vSd1VhO4Lk
   Quwod9sO/bp6XYCHwfr4NcE7uI5wrIGXpnDklze9v6jhHZR0MG8WSmTZ6
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="331234111"
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="331234111"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 10:21:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="531905962"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 18 Jan 2022 10:21:04 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9t6N-000CpT-Cy; Tue, 18 Jan 2022 18:21:03 +0000
Date:   Wed, 19 Jan 2022 02:20:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jirislaby:devel 10/31] drivers/tty/serial/uartlite.c:508:37: error:
 incompatible function pointer types passing 'void (struct uart_port *, int)'
 to parameter of type 'void (*)(struct uart_port *, char)'
Message-ID: <202201190250.HH3mpoB9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git devel
head:   0ecc0cdeaabd6b08ef3ec6dfaf724139031c00b8
commit: 2258e16ea4fe67f9700294b439b7aa1669aef643 [10/31] serial: make uart_console_write->putchar's character a char
config: i386-randconfig-a002-20220117 (https://download.01.org/0day-ci/archive/20220119/202201190250.HH3mpoB9-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project c10cbb243cafc0cf42c3e922cb29183279444432)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?id=2258e16ea4fe67f9700294b439b7aa1669aef643
        git remote add jirislaby https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git
        git fetch --no-tags jirislaby devel
        git checkout 2258e16ea4fe67f9700294b439b7aa1669aef643
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/tty/serial/uartlite.c:508:37: error: incompatible function pointer types passing 'void (struct uart_port *, int)' to parameter of type 'void (*)(struct uart_port *, char)' [-Werror,-Wincompatible-function-pointer-types]
           uart_console_write(port, s, count, ulite_console_putchar);
                                              ^~~~~~~~~~~~~~~~~~~~~
   include/linux/serial_core.h:402:11: note: passing argument to parameter 'putchar' here
                           void (*putchar)(struct uart_port *, char));
                                  ^
   1 error generated.


vim +508 drivers/tty/serial/uartlite.c

238b8721a554a3 drivers/serial/uartlite.c     Peter Korsgaard    2006-12-06  490  
238b8721a554a3 drivers/serial/uartlite.c     Peter Korsgaard    2006-12-06  491  static void ulite_console_write(struct console *co, const char *s,
238b8721a554a3 drivers/serial/uartlite.c     Peter Korsgaard    2006-12-06  492  				unsigned int count)
238b8721a554a3 drivers/serial/uartlite.c     Peter Korsgaard    2006-12-06  493  {
deeb33e8fdd834 drivers/tty/serial/uartlite.c Shubhrajyoti Datta 2018-08-06  494  	struct uart_port *port = console_port;
238b8721a554a3 drivers/serial/uartlite.c     Peter Korsgaard    2006-12-06  495  	unsigned long flags;
238b8721a554a3 drivers/serial/uartlite.c     Peter Korsgaard    2006-12-06  496  	unsigned int ier;
238b8721a554a3 drivers/serial/uartlite.c     Peter Korsgaard    2006-12-06  497  	int locked = 1;
238b8721a554a3 drivers/serial/uartlite.c     Peter Korsgaard    2006-12-06  498  
238b8721a554a3 drivers/serial/uartlite.c     Peter Korsgaard    2006-12-06  499  	if (oops_in_progress) {
238b8721a554a3 drivers/serial/uartlite.c     Peter Korsgaard    2006-12-06  500  		locked = spin_trylock_irqsave(&port->lock, flags);
238b8721a554a3 drivers/serial/uartlite.c     Peter Korsgaard    2006-12-06  501  	} else
238b8721a554a3 drivers/serial/uartlite.c     Peter Korsgaard    2006-12-06  502  		spin_lock_irqsave(&port->lock, flags);
238b8721a554a3 drivers/serial/uartlite.c     Peter Korsgaard    2006-12-06  503  
238b8721a554a3 drivers/serial/uartlite.c     Peter Korsgaard    2006-12-06  504  	/* save and disable interrupt */
6d53c3b71d32da drivers/tty/serial/uartlite.c Michal Simek       2013-02-11  505  	ier = uart_in32(ULITE_STATUS, port) & ULITE_STATUS_IE;
6d53c3b71d32da drivers/tty/serial/uartlite.c Michal Simek       2013-02-11  506  	uart_out32(0, ULITE_CONTROL, port);
238b8721a554a3 drivers/serial/uartlite.c     Peter Korsgaard    2006-12-06  507  
238b8721a554a3 drivers/serial/uartlite.c     Peter Korsgaard    2006-12-06 @508  	uart_console_write(port, s, count, ulite_console_putchar);
238b8721a554a3 drivers/serial/uartlite.c     Peter Korsgaard    2006-12-06  509  
238b8721a554a3 drivers/serial/uartlite.c     Peter Korsgaard    2006-12-06  510  	ulite_console_wait_tx(port);
238b8721a554a3 drivers/serial/uartlite.c     Peter Korsgaard    2006-12-06  511  
238b8721a554a3 drivers/serial/uartlite.c     Peter Korsgaard    2006-12-06  512  	/* restore interrupt state */
238b8721a554a3 drivers/serial/uartlite.c     Peter Korsgaard    2006-12-06  513  	if (ier)
6d53c3b71d32da drivers/tty/serial/uartlite.c Michal Simek       2013-02-11  514  		uart_out32(ULITE_CONTROL_IE, ULITE_CONTROL, port);
238b8721a554a3 drivers/serial/uartlite.c     Peter Korsgaard    2006-12-06  515  
238b8721a554a3 drivers/serial/uartlite.c     Peter Korsgaard    2006-12-06  516  	if (locked)
238b8721a554a3 drivers/serial/uartlite.c     Peter Korsgaard    2006-12-06  517  		spin_unlock_irqrestore(&port->lock, flags);
238b8721a554a3 drivers/serial/uartlite.c     Peter Korsgaard    2006-12-06  518  }
238b8721a554a3 drivers/serial/uartlite.c     Peter Korsgaard    2006-12-06  519  

:::::: The code at line 508 was first introduced by commit
:::::: 238b8721a554a33a451a3f13bdb5be8fe5cfc927 [PATCH] serial uartlite driver

:::::: TO: Peter Korsgaard <jacmet@sunsite.dk>
:::::: CC: Linus Torvalds <torvalds@woody.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
