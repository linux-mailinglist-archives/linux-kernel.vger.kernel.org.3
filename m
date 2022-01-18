Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1D6492D29
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 19:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244240AbiARSVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 13:21:40 -0500
Received: from mga17.intel.com ([192.55.52.151]:64639 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347954AbiARSVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 13:21:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642530074; x=1674066074;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UOgVvL6AZtTLUiFJpnPKvZKERlLo8UkYQMBkZa4cXYk=;
  b=I6UagdPSRiIgn3AcyUa3oOQ/a4++I7T7ipZM9vBoKN855QgPl1SWWmL8
   NUMqtx5Qu5R2NccThrrbTIWjAWfHkWFoJUH5d2/wJjNe5Ehl+SawCcwAR
   pT4peNul9k5XvekBT72JWDxfpnlzmXO3W/afOXIwvrFGCvsBF6+peBOVL
   egaG0NHiOA1q+kybgyPrkqGeff6eItklCHqhb+e0GcYB2zHbbxyZgfN4c
   Ma52c8xU0+Luk3Irn6I+VndBP016LUqSXnUT1MpVA2yzufDOVsCMV+/KK
   7l9rdMLIRXFb6UVtkaE8/9cJ7dlJY4QrUpMepUyg3OQkUIMLIe/b5ualm
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="225558683"
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="225558683"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 10:21:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="474850822"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 18 Jan 2022 10:21:04 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9t6N-000CpZ-F5; Tue, 18 Jan 2022 18:21:03 +0000
Date:   Wed, 19 Jan 2022 02:20:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jirislaby:devel 10/31] drivers/tty/serial/samsung_tty.c:2983:46:
 error: passing argument 4 of 'uart_console_write' from incompatible pointer
 type
Message-ID: <202201190244.I2BjsDwz-lkp@intel.com>
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
config: nds32-randconfig-r023-20220116 (https://download.01.org/0day-ci/archive/20220119/202201190244.I2BjsDwz-lkp@intel.com/config)
compiler: nds32le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?id=2258e16ea4fe67f9700294b439b7aa1669aef643
        git remote add jirislaby https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git
        git fetch --no-tags jirislaby devel
        git checkout 2258e16ea4fe67f9700294b439b7aa1669aef643
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash drivers/tty/serial/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/tty/serial/samsung_tty.c: In function 'samsung_early_write':
>> drivers/tty/serial/samsung_tty.c:2983:46: error: passing argument 4 of 'uart_console_write' from incompatible pointer type [-Werror=incompatible-pointer-types]
    2983 |         uart_console_write(&dev->port, s, n, samsung_early_putc);
         |                                              ^~~~~~~~~~~~~~~~~~
         |                                              |
         |                                              void (*)(struct uart_port *, int)
   In file included from drivers/tty/serial/samsung_tty.c:36:
   include/linux/serial_core.h:402:32: note: expected 'void (*)(struct uart_port *, char)' but argument is of type 'void (*)(struct uart_port *, int)'
     402 |                         void (*putchar)(struct uart_port *, char));
         |                         ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/uart_console_write +2983 drivers/tty/serial/samsung_tty.c

b94ba0328d3b36 drivers/tty/serial/samsung.c     Tomasz Figa        2015-01-23  2977  
90ece856a227c4 drivers/tty/serial/samsung_tty.c Greg Kroah-Hartman 2019-12-10  2978  static void samsung_early_write(struct console *con, const char *s,
90ece856a227c4 drivers/tty/serial/samsung_tty.c Greg Kroah-Hartman 2019-12-10  2979  				unsigned int n)
b94ba0328d3b36 drivers/tty/serial/samsung.c     Tomasz Figa        2015-01-23  2980  {
b94ba0328d3b36 drivers/tty/serial/samsung.c     Tomasz Figa        2015-01-23  2981  	struct earlycon_device *dev = con->data;
b94ba0328d3b36 drivers/tty/serial/samsung.c     Tomasz Figa        2015-01-23  2982  
b94ba0328d3b36 drivers/tty/serial/samsung.c     Tomasz Figa        2015-01-23 @2983  	uart_console_write(&dev->port, s, n, samsung_early_putc);
b94ba0328d3b36 drivers/tty/serial/samsung.c     Tomasz Figa        2015-01-23  2984  }
b94ba0328d3b36 drivers/tty/serial/samsung.c     Tomasz Figa        2015-01-23  2985  

:::::: The code at line 2983 was first introduced by commit
:::::: b94ba0328d3b36ff95f5074c0e9b44f90dc56bb5 serial: samsung: Add support for early console

:::::: TO: Tomasz Figa <t.figa@samsung.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
