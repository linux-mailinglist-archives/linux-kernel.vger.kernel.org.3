Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AECB148842E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 16:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbiAHPUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 10:20:03 -0500
Received: from mga03.intel.com ([134.134.136.65]:33883 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234490AbiAHPUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 10:20:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641655199; x=1673191199;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=svBOowkOm8J4ELDOxUcaJphHaZa+bgCaZW7R055h9II=;
  b=jWjccWTYZtT21rto8aNRzYMQHoWVmH0wczHKWfHw+WU9RdVXRDEV5xQg
   2buumLs0uc+j7NTaMUHY41FCz7tC41Gm0AN+qP8a317+5FdQxQkbT+fbV
   HxhGtHwb2Qdvwk6qersv0er/i369o4gKgM3Fo3RUx2Rs5iMMoHELuZiys
   c5Yp3ZoHwflYE/3LDMIRej8dzeT2Q2+JpmtSnaZcGW2OXfVjX5kpJ3XOF
   emv6dO2YsBmjpU6UohNhnSDmlpmBOPnc0YMFdXx/1VgFWYSQjCxUNAPnl
   jKxK2SjP7iEn8ztiMeYj0qAtdtMwcQGgGHJiCLreQ3EKpqQKvWApbT6XZ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="242970287"
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="242970287"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2022 07:19:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="471616196"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 08 Jan 2022 07:19:58 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6DVd-0000jg-PP; Sat, 08 Jan 2022 15:19:57 +0000
Date:   Sat, 8 Jan 2022 23:19:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: arch/nds32/kernel/ftrace.c:24:35: warning: comparison of distinct
 pointer types lacks a cast
Message-ID: <202201082355.mNQ1jHlv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d1587f7bfe9a0f97a75d42ac1489aeda551106bc
commit: d19ad0775dcd64b49eecf4fa79c17959ebfbd26b ftrace: Have the callbacks receive a struct ftrace_regs instead of pt_regs
date:   1 year, 2 months ago
config: nds32-randconfig-r031-20220108 (https://download.01.org/0day-ci/archive/20220108/202201082355.mNQ1jHlv-lkp@intel.com/config)
compiler: nds32le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d19ad0775dcd64b49eecf4fa79c17959ebfbd26b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d19ad0775dcd64b49eecf4fa79c17959ebfbd26b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/nds32/kernel/ftrace.c: In function '_mcount':
>> arch/nds32/kernel/ftrace.c:24:35: warning: comparison of distinct pointer types lacks a cast
      24 |         if (ftrace_trace_function != ftrace_stub)
         |                                   ^~
>> arch/nds32/kernel/ftrace.c:29:36: warning: cast between incompatible function types from 'void (*)(long unsigned int,  long unsigned int,  struct ftrace_ops *, struct ftrace_regs *)' to 'void (*)(struct ftrace_graph_ret *)' [-Wcast-function-type]
      29 |         if (ftrace_graph_return != (trace_func_graph_ret_t)ftrace_stub
         |                                    ^
   arch/nds32/kernel/ftrace.c: At top level:
   arch/nds32/kernel/ftrace.c:198:6: warning: no previous prototype for 'prepare_ftrace_return' [-Wmissing-prototypes]
     198 | void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
         |      ^~~~~~~~~~~~~~~~~~~~~


vim +24 arch/nds32/kernel/ftrace.c

a18082575c6648 Zong Li 2018-08-15  17  
a18082575c6648 Zong Li 2018-08-15  18  noinline void _mcount(unsigned long parent_ip)
a18082575c6648 Zong Li 2018-08-15  19  {
a18082575c6648 Zong Li 2018-08-15  20  	/* save all state by the compiler prologue */
a18082575c6648 Zong Li 2018-08-15  21  
a18082575c6648 Zong Li 2018-08-15  22  	unsigned long ip = (unsigned long)__builtin_return_address(0);
a18082575c6648 Zong Li 2018-08-15  23  
a18082575c6648 Zong Li 2018-08-15 @24  	if (ftrace_trace_function != ftrace_stub)
a18082575c6648 Zong Li 2018-08-15  25  		ftrace_trace_function(ip - MCOUNT_INSN_SIZE, parent_ip,
a18082575c6648 Zong Li 2018-08-15  26  				      NULL, NULL);
a18082575c6648 Zong Li 2018-08-15  27  
1e9b14c0d92b61 Zong Li 2018-08-15  28  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
1e9b14c0d92b61 Zong Li 2018-08-15 @29  	if (ftrace_graph_return != (trace_func_graph_ret_t)ftrace_stub
1e9b14c0d92b61 Zong Li 2018-08-15  30  	    || ftrace_graph_entry != ftrace_graph_entry_stub)
1e9b14c0d92b61 Zong Li 2018-08-15  31  		ftrace_graph_caller();
1e9b14c0d92b61 Zong Li 2018-08-15  32  #endif
1e9b14c0d92b61 Zong Li 2018-08-15  33  
a18082575c6648 Zong Li 2018-08-15  34  	/* restore all state by the compiler epilogue */
a18082575c6648 Zong Li 2018-08-15  35  }
a18082575c6648 Zong Li 2018-08-15  36  EXPORT_SYMBOL(_mcount);
1e9b14c0d92b61 Zong Li 2018-08-15  37  

:::::: The code at line 24 was first introduced by commit
:::::: a18082575c664847d36c6ca030b09ce8d93aec2f nds32/ftrace: Support static function tracer

:::::: TO: Zong Li <zong@andestech.com>
:::::: CC: Greentime Hu <greentime@andestech.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
