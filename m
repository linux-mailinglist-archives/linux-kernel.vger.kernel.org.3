Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B62754734C5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 20:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242262AbhLMTR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 14:17:56 -0500
Received: from mga12.intel.com ([192.55.52.136]:23795 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242211AbhLMTRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 14:17:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639423056; x=1670959056;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=VHnDozIc4v7QpR3IRCWWh2AZ3tIbWgh1pH62gbq7Lbg=;
  b=MgLMW0oUOakek0lzcKrRxXnyQ7oRdk28kqi0HI1T4MtSFyl6gyWw4+A+
   CZA6SPm+4AiqCJlYNHMDrriUm+rGp2uqQ79jDzb8r0BEutGppVined8ho
   wkCQrOQyswVg7wbz6Y23buN55bAO70uDe5TrmqBuh/WghVCrQWe4mu32/
   b0BWu8ocvYxBhV3Pb9UcxayoKx2iS1+eep0bbiE7fPrGej4+mPSrl1EW7
   K8VUPg2SfeIjJTBmvMTgVqbDWvO9K1Rk7HWGONQJM0+L9PIc5C1Kpqg9X
   e1X/gliFqLdjhknJ3mUErM2JSjWkfegPq6jyzEl+5EwAC9Kw71No4ylRQ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="218824060"
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="218824060"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 11:16:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="544890170"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 13 Dec 2021 11:16:54 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mwqof-0006yP-BL; Mon, 13 Dec 2021 19:16:53 +0000
Date:   Tue, 14 Dec 2021 03:16:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     lianzhi chang <changlianzhi@uniontech.com>,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, andriy.shevchenko@linux.intel.com,
        282827961@qq.com, lianzhi chang <changlianzhi@uniontech.com>
Subject: Re: [PATCH v21] tty: Fix the keyboard led light display problem
Message-ID: <202112140304.qPpjdgPQ-lkp@intel.com>
References: <20211213124122.25605-1-changlianzhi@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211213124122.25605-1-changlianzhi@uniontech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi lianzhi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on linux/master linus/master v5.16-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/lianzhi-chang/tty-Fix-the-keyboard-led-light-display-problem/20211213-204404
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
config: mips-randconfig-r022-20211213 (https://download.01.org/0day-ci/archive/20211214/202112140304.qPpjdgPQ-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project b6a2ddb6c8ac29412b1361810972e15221fa021c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://github.com/0day-ci/linux/commit/8cc658e5dd82e5d70fa3ac9dace8fe62eaed325f
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review lianzhi-chang/tty-Fix-the-keyboard-led-light-display-problem/20211213-204404
        git checkout 8cc658e5dd82e5d70fa3ac9dace8fe62eaed325f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/tty/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/tty/sysrq.c:31:
   include/linux/kbd_kern.h:35:27: error: character <U+FF1B> not allowed in an identifier
           unsigned char kbdledctl:1； /* Whether to allow to control the led of the keyboard */
                                    ^~
   include/linux/kbd_kern.h:35:27: error: invalid suffix '；' on integer constant
   In file included from drivers/tty/sysrq.c:51:
   In file included from include/linux/syscalls.h:88:
   In file included from include/trace/syscall.h:7:
   In file included from include/linux/trace_events.h:6:
   In file included from include/linux/ring_buffer.h:7:
>> include/linux/poll.h:142:27: warning: division by zero is undefined [-Wdivision-by-zero]
                   M(RDNORM) | M(RDBAND) | M(WRNORM) | M(WRBAND) |
                                           ^~~~~~~~~
   include/linux/poll.h:140:32: note: expanded from macro 'M'
   #define M(X) (__force __poll_t)__MAP(val, POLL##X, (__force __u16)EPOLL##X)
                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/poll.h:126:51: note: expanded from macro '__MAP'
           (from < to ? (v & from) * (to/from) : (v & from) / (from/to))
                                                            ^ ~~~~~~~~~
   include/linux/poll.h:142:39: warning: division by zero is undefined [-Wdivision-by-zero]
                   M(RDNORM) | M(RDBAND) | M(WRNORM) | M(WRBAND) |
                                                       ^~~~~~~~~
   include/linux/poll.h:140:32: note: expanded from macro 'M'
   #define M(X) (__force __poll_t)__MAP(val, POLL##X, (__force __u16)EPOLL##X)
                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/poll.h:126:51: note: expanded from macro '__MAP'
           (from < to ? (v & from) * (to/from) : (v & from) / (from/to))
                                                            ^ ~~~~~~~~~
   2 warnings and 2 errors generated.


vim +142 include/linux/poll.h

7a163b2195cda0 Al Viro 2018-02-01  137  
7a163b2195cda0 Al Viro 2018-02-01  138  static inline __poll_t demangle_poll(u16 val)
7a163b2195cda0 Al Viro 2018-02-01  139  {
7a163b2195cda0 Al Viro 2018-02-01  140  #define M(X) (__force __poll_t)__MAP(val, POLL##X, (__force __u16)EPOLL##X)
7a163b2195cda0 Al Viro 2018-02-01  141  	return M(IN) | M(OUT) | M(PRI) | M(ERR) | M(NVAL) |
7a163b2195cda0 Al Viro 2018-02-01 @142  		M(RDNORM) | M(RDBAND) | M(WRNORM) | M(WRBAND) |
7a163b2195cda0 Al Viro 2018-02-01  143  		M(HUP) | M(RDHUP) | M(MSG);
7a163b2195cda0 Al Viro 2018-02-01  144  #undef M
7a163b2195cda0 Al Viro 2018-02-01  145  }
7a163b2195cda0 Al Viro 2018-02-01  146  #undef __MAP
7a163b2195cda0 Al Viro 2018-02-01  147  
7a163b2195cda0 Al Viro 2018-02-01  148  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
