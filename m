Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B56D48F7B6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 17:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbiAOQEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 11:04:10 -0500
Received: from mga17.intel.com ([192.55.52.151]:56827 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229732AbiAOQEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 11:04:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642262649; x=1673798649;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Rs4GPCKQxNaL4kGleAkZBSPLl3NhvNHqHaaIf9SwIcc=;
  b=bqq6OBA0Bs5QAwgN5Ip/CYGwaLknAm7VB/p960b/escGlZmXxFBe2K7Z
   n7kb+Loa0tb3KN8ugiXnnLncP4mYDYRD+omBD505yTP9mb7Pc8iJ1qoZv
   3Dy9NBgK7xbPZhp9kyQ8BuQ+E3OdetsoQZUSvOmSEC5sZcnM7Q4wKnko7
   /570z/WSIPS/m3StSwYe9BRoiYNgxExJ8VGPgLu5DJHVD69UAZUxtCsAu
   2tQVeBqPzPE3bQoqRLVt5P3jRsRXWjjQX2Z7vxL4RiNqc9GPV2Rs2sZu1
   T7KZjTPaL9klARMbu5KZ6+l5nCXVrG9uQ3//rRkleS+ZOwvZWZHLNIVTI
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="225105954"
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="225105954"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2022 08:04:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="624713173"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 15 Jan 2022 08:04:07 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8lXD-000A1k-0j; Sat, 15 Jan 2022 16:04:07 +0000
Date:   Sun, 16 Jan 2022 00:03:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1684/2384] arch/mips/kernel/rtlx.c:345:46:
 error: unknown type name 'poll_table'
Message-ID: <202201152345.4hznmFMe-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   4c707c1c0de83967079b4e385012fa5b00e2cd11
commit: 4e8d31a2893e3ef566a2e9860e746519711a0ed3 [1684/2384] headers/deps: tracing: Optimize <linux/ring_buffer.h>'s header dependencies, remove <linux/poll.h>
config: mips-maltaaprp_defconfig (https://download.01.org/0day-ci/archive/20220115/202201152345.4hznmFMe-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 650fc40b6d8d9a5869b4fca525d5f237b0ee2803)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=4e8d31a2893e3ef566a2e9860e746519711a0ed3
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 4e8d31a2893e3ef566a2e9860e746519711a0ed3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/mips/kernel/rtlx.c:14:
   In file included from include/linux/fs_api.h:2:
   In file included from include/linux/fs.h:6:
   include/linux/wait_bit.h:35:19: error: expected ';' after top level declarator
   extern void __init wait_bit_init(void);
                     ^
                     ;
>> arch/mips/kernel/rtlx.c:345:46: error: unknown type name 'poll_table'
   static __poll_t file_poll(struct file *file, poll_table *wait)
                                                ^
>> arch/mips/kernel/rtlx.c:350:2: error: implicit declaration of function 'poll_wait' [-Werror,-Wimplicit-function-declaration]
           poll_wait(file, &channel_wqs[minor].rt_queue, wait);
           ^
>> arch/mips/kernel/rtlx.c:358:11: error: use of undeclared identifier 'EPOLLIN'
                   mask |= EPOLLIN | EPOLLRDNORM;
                           ^
>> arch/mips/kernel/rtlx.c:358:21: error: use of undeclared identifier 'EPOLLRDNORM'
                   mask |= EPOLLIN | EPOLLRDNORM;
                                     ^
>> arch/mips/kernel/rtlx.c:362:11: error: use of undeclared identifier 'EPOLLOUT'
                   mask |= EPOLLOUT | EPOLLWRNORM;
                           ^
>> arch/mips/kernel/rtlx.c:362:22: error: use of undeclared identifier 'EPOLLWRNORM'
                   mask |= EPOLLOUT | EPOLLWRNORM;
                                      ^
   7 errors generated.


vim +/poll_table +345 arch/mips/kernel/rtlx.c

2600990e640e3b Ralf Baechle   2006-04-05  344  
8b9aab09aaf390 Al Viro        2017-07-02 @345  static __poll_t file_poll(struct file *file, poll_table *wait)
2600990e640e3b Ralf Baechle   2006-04-05  346  {
496ad9aa8ef448 Al Viro        2013-01-23  347  	int minor = iminor(file_inode(file));
8b9aab09aaf390 Al Viro        2017-07-02  348  	__poll_t mask = 0;
2600990e640e3b Ralf Baechle   2006-04-05  349  
2600990e640e3b Ralf Baechle   2006-04-05 @350  	poll_wait(file, &channel_wqs[minor].rt_queue, wait);
2600990e640e3b Ralf Baechle   2006-04-05  351  	poll_wait(file, &channel_wqs[minor].lx_queue, wait);
2600990e640e3b Ralf Baechle   2006-04-05  352  
2600990e640e3b Ralf Baechle   2006-04-05  353  	if (rtlx == NULL)
2600990e640e3b Ralf Baechle   2006-04-05  354  		return 0;
2600990e640e3b Ralf Baechle   2006-04-05  355  
2600990e640e3b Ralf Baechle   2006-04-05  356  	/* data available to read? */
2600990e640e3b Ralf Baechle   2006-04-05  357  	if (rtlx_read_poll(minor, 0))
a9a08845e9acbd Linus Torvalds 2018-02-11 @358  		mask |= EPOLLIN | EPOLLRDNORM;
2600990e640e3b Ralf Baechle   2006-04-05  359  
2600990e640e3b Ralf Baechle   2006-04-05  360  	/* space to write */
2600990e640e3b Ralf Baechle   2006-04-05  361  	if (rtlx_write_poll(minor))
a9a08845e9acbd Linus Torvalds 2018-02-11 @362  		mask |= EPOLLOUT | EPOLLWRNORM;
2600990e640e3b Ralf Baechle   2006-04-05  363  
2600990e640e3b Ralf Baechle   2006-04-05  364  	return mask;
2600990e640e3b Ralf Baechle   2006-04-05  365  }
2600990e640e3b Ralf Baechle   2006-04-05  366  

:::::: The code at line 345 was first introduced by commit
:::::: 8b9aab09aaf390b868359b9365b667cf6506473c mips: annotate ->poll() instances

:::::: TO: Al Viro <viro@zeniv.linux.org.uk>
:::::: CC: Al Viro <viro@zeniv.linux.org.uk>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
