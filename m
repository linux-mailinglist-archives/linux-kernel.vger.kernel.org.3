Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D396476055
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 19:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343509AbhLOSKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 13:10:32 -0500
Received: from mga11.intel.com ([192.55.52.93]:51206 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245728AbhLOSK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 13:10:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639591829; x=1671127829;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nkz4uq/rH0zcevft5h5f8WuuneRvuuT3ZQPtIxPLJ8s=;
  b=ihpoGh/zIQadzLCSquwoMso12QBIJ8NWhQkM/9IzuE5DtTCyWFCWxcnP
   waVvGNYAYXi40tjU74O0MJURKeUFtN6utAl9HtF7u75qzYG6nTvz2wiMH
   A/8ec++vi7jPGnEe2JBKX2V9D4MgTDLlgE4H3Fy9P5KFoycFFqC1tGCcb
   8JffK6pAZTn6QnJKTJwk882v1ra49D4pKRAJm9bSdt6jQgQ6SUU7LyJwf
   a6RvHxLvFek/k4M8Z3pTi0dn691yMK8yGeFHOGPcXpct1LXsdQBuYRmC4
   Fvt2qAzbQPofkwVoGUjPZQjbh32mjiNnyWE3HBc/uVN0Qo8zsuLpVmo4v
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="236836589"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="236836589"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 10:10:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="518880855"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 15 Dec 2021 10:10:14 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxYjF-00029q-Qr; Wed, 15 Dec 2021 18:10:13 +0000
Date:   Thu, 16 Dec 2021 02:09:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jirislaby:devel 8/33] include/linux/compiler.h:61:23: warning:
 'xmit_buf' is deprecated
Message-ID: <202112160239.cdlehqr0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git devel
head:   d61595c5423534810c1a3c0d4a88dd2fd81d750c
commit: 8825023d7d2eb9e5dc298ad1996a0c753b2c4580 [8/33] tty: add kfifo to tty_port
config: s390-randconfig-r044-20211215 (https://download.01.org/0day-ci/archive/20211216/202112160239.cdlehqr0-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?id=8825023d7d2eb9e5dc298ad1996a0c753b2c4580
        git remote add jirislaby https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git
        git fetch --no-tags jirislaby devel
        git checkout 8825023d7d2eb9e5dc298ad1996a0c753b2c4580
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/tty/tty_port.c: In function 'tty_port_alloc_xmit_buf':
   drivers/tty/tty_port.c:228:9: warning: 'xmit_buf' is deprecated [-Wdeprecated-declarations]
     228 |         if (port->xmit_buf == NULL)
         |         ^~
   In file included from include/linux/tty.h:12,
                    from drivers/tty/tty_port.c:8:
   include/linux/tty_port.h:115:34: note: declared here
     115 |                 unsigned char   *xmit_buf __attribute__((deprecated));
         |                                  ^~~~~~~~
   drivers/tty/tty_port.c:228:9: warning: 'xmit_buf' is deprecated [-Wdeprecated-declarations]
     228 |         if (port->xmit_buf == NULL)
         |         ^~
   In file included from include/linux/tty.h:12,
                    from drivers/tty/tty_port.c:8:
   include/linux/tty_port.h:115:34: note: declared here
     115 |                 unsigned char   *xmit_buf __attribute__((deprecated));
         |                                  ^~~~~~~~
   In file included from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/wait.h:7,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from include/linux/tty.h:5,
                    from drivers/tty/tty_port.c:8:
>> include/linux/compiler.h:61:23: warning: 'xmit_buf' is deprecated [-Wdeprecated-declarations]
      61 |         static struct ftrace_branch_data                \
         |                       ^~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:69: note: in expansion of macro '__trace_if_value'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                                     ^~~~~~~~~~~~~~~~
   include/linux/compiler.h:56:28: note: in expansion of macro '__trace_if_var'
      56 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~
   drivers/tty/tty_port.c:228:9: note: in expansion of macro 'if'
     228 |         if (port->xmit_buf == NULL)
         |         ^~
   In file included from include/linux/tty.h:12,
                    from drivers/tty/tty_port.c:8:
   include/linux/tty_port.h:115:34: note: declared here
     115 |                 unsigned char   *xmit_buf __attribute__((deprecated));
         |                                  ^~~~~~~~
   drivers/tty/tty_port.c:229:17: warning: 'xmit_buf' is deprecated [-Wdeprecated-declarations]
     229 |                 port->xmit_buf = (unsigned char *)get_zeroed_page(GFP_KERNEL);
         |                 ^~~~
   In file included from include/linux/tty.h:12,
                    from drivers/tty/tty_port.c:8:
   include/linux/tty_port.h:115:34: note: declared here
     115 |                 unsigned char   *xmit_buf __attribute__((deprecated));
         |                                  ^~~~~~~~
   drivers/tty/tty_port.c:231:9: warning: 'xmit_buf' is deprecated [-Wdeprecated-declarations]
     231 |         if (port->xmit_buf == NULL)
         |         ^~
   In file included from include/linux/tty.h:12,
                    from drivers/tty/tty_port.c:8:
   include/linux/tty_port.h:115:34: note: declared here
     115 |                 unsigned char   *xmit_buf __attribute__((deprecated));
         |                                  ^~~~~~~~
   drivers/tty/tty_port.c:231:9: warning: 'xmit_buf' is deprecated [-Wdeprecated-declarations]
     231 |         if (port->xmit_buf == NULL)
         |         ^~
   In file included from include/linux/tty.h:12,
                    from drivers/tty/tty_port.c:8:
   include/linux/tty_port.h:115:34: note: declared here
     115 |                 unsigned char   *xmit_buf __attribute__((deprecated));
         |                                  ^~~~~~~~
   In file included from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/wait.h:7,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from include/linux/tty.h:5,
                    from drivers/tty/tty_port.c:8:
>> include/linux/compiler.h:61:23: warning: 'xmit_buf' is deprecated [-Wdeprecated-declarations]
      61 |         static struct ftrace_branch_data                \
         |                       ^~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:69: note: in expansion of macro '__trace_if_value'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                                     ^~~~~~~~~~~~~~~~
   include/linux/compiler.h:56:28: note: in expansion of macro '__trace_if_var'
      56 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~
   drivers/tty/tty_port.c:231:9: note: in expansion of macro 'if'
     231 |         if (port->xmit_buf == NULL)
         |         ^~
   In file included from include/linux/tty.h:12,
                    from drivers/tty/tty_port.c:8:
   include/linux/tty_port.h:115:34: note: declared here
     115 |                 unsigned char   *xmit_buf __attribute__((deprecated));
         |                                  ^~~~~~~~
   drivers/tty/tty_port.c: In function 'tty_port_free_xmit_buf':
   drivers/tty/tty_port.c:240:9: warning: 'xmit_buf' is deprecated [-Wdeprecated-declarations]
     240 |         if (port->xmit_buf != NULL) {
         |         ^~
   In file included from include/linux/tty.h:12,
                    from drivers/tty/tty_port.c:8:
   include/linux/tty_port.h:115:34: note: declared here
     115 |                 unsigned char   *xmit_buf __attribute__((deprecated));
         |                                  ^~~~~~~~
   drivers/tty/tty_port.c:240:9: warning: 'xmit_buf' is deprecated [-Wdeprecated-declarations]
     240 |         if (port->xmit_buf != NULL) {
         |         ^~
   In file included from include/linux/tty.h:12,
                    from drivers/tty/tty_port.c:8:
   include/linux/tty_port.h:115:34: note: declared here
     115 |                 unsigned char   *xmit_buf __attribute__((deprecated));
         |                                  ^~~~~~~~
   In file included from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/wait.h:7,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from include/linux/tty.h:5,
                    from drivers/tty/tty_port.c:8:
>> include/linux/compiler.h:61:23: warning: 'xmit_buf' is deprecated [-Wdeprecated-declarations]
      61 |         static struct ftrace_branch_data                \
         |                       ^~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:69: note: in expansion of macro '__trace_if_value'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                                     ^~~~~~~~~~~~~~~~
   include/linux/compiler.h:56:28: note: in expansion of macro '__trace_if_var'
      56 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~
   drivers/tty/tty_port.c:240:9: note: in expansion of macro 'if'
     240 |         if (port->xmit_buf != NULL) {
         |         ^~
   In file included from include/linux/tty.h:12,
                    from drivers/tty/tty_port.c:8:
   include/linux/tty_port.h:115:34: note: declared here
     115 |                 unsigned char   *xmit_buf __attribute__((deprecated));
         |                                  ^~~~~~~~
   drivers/tty/tty_port.c:241:17: warning: 'xmit_buf' is deprecated [-Wdeprecated-declarations]
     241 |                 free_page((unsigned long)port->xmit_buf);
         |                 ^~~~~~~~~
   In file included from include/linux/tty.h:12,
                    from drivers/tty/tty_port.c:8:
   include/linux/tty_port.h:115:34: note: declared here
     115 |                 unsigned char   *xmit_buf __attribute__((deprecated));
         |                                  ^~~~~~~~
   drivers/tty/tty_port.c:242:17: warning: 'xmit_buf' is deprecated [-Wdeprecated-declarations]
     242 |                 port->xmit_buf = NULL;
         |                 ^~~~
   In file included from include/linux/tty.h:12,
                    from drivers/tty/tty_port.c:8:
   include/linux/tty_port.h:115:34: note: declared here
     115 |                 unsigned char   *xmit_buf __attribute__((deprecated));
         |                                  ^~~~~~~~
   drivers/tty/tty_port.c: In function 'tty_port_destructor':
   drivers/tty/tty_port.c:270:9: warning: 'xmit_buf' is deprecated [-Wdeprecated-declarations]
     270 |         if (port->xmit_buf)
         |         ^~
   In file included from include/linux/tty.h:12,
                    from drivers/tty/tty_port.c:8:
   include/linux/tty_port.h:115:34: note: declared here
     115 |                 unsigned char   *xmit_buf __attribute__((deprecated));
         |                                  ^~~~~~~~
   drivers/tty/tty_port.c:270:9: warning: 'xmit_buf' is deprecated [-Wdeprecated-declarations]
     270 |         if (port->xmit_buf)
         |         ^~
   In file included from include/linux/tty.h:12,
                    from drivers/tty/tty_port.c:8:
   include/linux/tty_port.h:115:34: note: declared here
     115 |                 unsigned char   *xmit_buf __attribute__((deprecated));
         |                                  ^~~~~~~~
   In file included from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/wait.h:7,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from include/linux/tty.h:5,
                    from drivers/tty/tty_port.c:8:
>> include/linux/compiler.h:61:23: warning: 'xmit_buf' is deprecated [-Wdeprecated-declarations]
      61 |         static struct ftrace_branch_data                \
         |                       ^~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:69: note: in expansion of macro '__trace_if_value'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                                     ^~~~~~~~~~~~~~~~
   include/linux/compiler.h:56:28: note: in expansion of macro '__trace_if_var'
      56 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~
   drivers/tty/tty_port.c:270:9: note: in expansion of macro 'if'
     270 |         if (port->xmit_buf)
         |         ^~
   In file included from include/linux/tty.h:12,
                    from drivers/tty/tty_port.c:8:
   include/linux/tty_port.h:115:34: note: declared here
     115 |                 unsigned char   *xmit_buf __attribute__((deprecated));
         |                                  ^~~~~~~~
   drivers/tty/tty_port.c:271:17: warning: 'xmit_buf' is deprecated [-Wdeprecated-declarations]
     271 |                 free_page((unsigned long)port->xmit_buf);
         |                 ^~~~~~~~~
   In file included from include/linux/tty.h:12,
                    from drivers/tty/tty_port.c:8:
   include/linux/tty_port.h:115:34: note: declared here
     115 |                 unsigned char   *xmit_buf __attribute__((deprecated));
         |                                  ^~~~~~~~


vim +/xmit_buf +61 include/linux/compiler.h

a15fd609ad53a6 Linus Torvalds 2019-03-20  59  
a15fd609ad53a6 Linus Torvalds 2019-03-20  60  #define __trace_if_value(cond) ({			\
2bcd521a684cc9 Steven Rostedt 2008-11-21 @61  	static struct ftrace_branch_data		\
e04462fb82f8dd Miguel Ojeda   2018-09-03  62  		__aligned(4)				\
33def8498fdde1 Joe Perches    2020-10-21  63  		__section("_ftrace_branch")		\
a15fd609ad53a6 Linus Torvalds 2019-03-20  64  		__if_trace = {				\
2bcd521a684cc9 Steven Rostedt 2008-11-21  65  			.func = __func__,		\
2bcd521a684cc9 Steven Rostedt 2008-11-21  66  			.file = __FILE__,		\
2bcd521a684cc9 Steven Rostedt 2008-11-21  67  			.line = __LINE__,		\
2bcd521a684cc9 Steven Rostedt 2008-11-21  68  		};					\
a15fd609ad53a6 Linus Torvalds 2019-03-20  69  	(cond) ?					\
a15fd609ad53a6 Linus Torvalds 2019-03-20  70  		(__if_trace.miss_hit[1]++,1) :		\
a15fd609ad53a6 Linus Torvalds 2019-03-20  71  		(__if_trace.miss_hit[0]++,0);		\
a15fd609ad53a6 Linus Torvalds 2019-03-20  72  })
a15fd609ad53a6 Linus Torvalds 2019-03-20  73  

:::::: The code at line 61 was first introduced by commit
:::::: 2bcd521a684cc94befbe2ce7d5b613c841b0d304 trace: profile all if conditionals

:::::: TO: Steven Rostedt <srostedt@redhat.com>
:::::: CC: Ingo Molnar <mingo@elte.hu>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
