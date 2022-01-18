Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D20492C33
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 18:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347159AbiARRVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 12:21:33 -0500
Received: from mga07.intel.com ([134.134.136.100]:39099 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347151AbiARRVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 12:21:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642526492; x=1674062492;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QHTl9o5Gs3pPX65V4raS2341N/gKD8noQB/ZI9pdSX8=;
  b=kMMZt0S0o9xLiP5lx6YIVO/tKxdiIEwjBVpEPxQKKLjYHlCQwitZT6J+
   ysFF6+iPlq3lVsXXhQXxIsSsA9u+qAHiT5IrCbXPxuYi4q3WQvaGGl7yP
   7WDNWvHE0FtiFdeLkr3Ox5cnsrnshJ82V1l7kaOqbZeO5EXPr3HtKp32i
   HXq9BVb9mRL/kKk5pQvBwyFKGgT7AjDxXfIysDaunRhBLT1+DQGoO4Wlb
   eOz8c22x31dfeUciVCATEsqMyMqOP2+AoQXh86bl8hfAOhnTgRP3F2NS0
   ftWJmi2omn9061HTO5370/TgJtg/pbJxl+iVu80lAh3WHvAdk+A+IqnO7
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="308205930"
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="308205930"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 09:20:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="477060502"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 18 Jan 2022 09:20:03 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9s9K-000Cmq-D0; Tue, 18 Jan 2022 17:20:02 +0000
Date:   Wed, 19 Jan 2022 01:19:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jirislaby:devel 10/31] drivers/tty/serial/sunzilog.c:103:13:
 warning: 'sunzilog_putchar' used but never defined
Message-ID: <202201190151.92tNhDTm-lkp@intel.com>
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
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20220119/202201190151.92tNhDTm-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?id=2258e16ea4fe67f9700294b439b7aa1669aef643
        git remote add jirislaby https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git
        git fetch --no-tags jirislaby devel
        git checkout 2258e16ea4fe67f9700294b439b7aa1669aef643
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc SHELL=/bin/bash drivers/tty/serial/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/tty/serial/sunzilog.c:1128:28: error: conflicting types for 'sunzilog_putchar'; have 'void(struct uart_port *, char)'
    1128 | static void __maybe_unused sunzilog_putchar(struct uart_port *port, char ch)
         |                            ^~~~~~~~~~~~~~~~
   drivers/tty/serial/sunzilog.c:103:13: note: previous declaration of 'sunzilog_putchar' with type 'void(struct uart_port *, int)'
     103 | static void sunzilog_putchar(struct uart_port *port, int ch);
         |             ^~~~~~~~~~~~~~~~
>> drivers/tty/serial/sunzilog.c:103:13: warning: 'sunzilog_putchar' used but never defined


vim +/sunzilog_putchar +103 drivers/tty/serial/sunzilog.c

^1da177e4c3f41 drivers/serial/sunzilog.c Linus Torvalds 2005-04-16  102  
6d45a1aed34b0c drivers/serial/sunzilog.c Jason Wessel   2010-05-20 @103  static void sunzilog_putchar(struct uart_port *port, int ch);
6d45a1aed34b0c drivers/serial/sunzilog.c Jason Wessel   2010-05-20  104  

:::::: The code at line 103 was first introduced by commit
:::::: 6d45a1aed34b0cd7b298967eb9cb72b77afcb33b sparc,sunzilog: Add console polling support for sunzilog serial driver

:::::: TO: Jason Wessel <jason.wessel@windriver.com>
:::::: CC: Jason Wessel <jason.wessel@windriver.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
