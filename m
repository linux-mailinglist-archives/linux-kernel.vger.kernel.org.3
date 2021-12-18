Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4FA479BE7
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 18:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbhLRR54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 12:57:56 -0500
Received: from mga05.intel.com ([192.55.52.43]:1469 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229552AbhLRR5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 12:57:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639850275; x=1671386275;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eL6atpWvTyM+P3t0NlBStkzHNd9WYBegko0U6zf6mLg=;
  b=X9nGAWLWwxvwjg3NFtZfHW7vh4uTCRCP2lRgTTHH0Z/Lh6EW53XeA1UE
   VRuQSRwEMweFav2lpKby4VhajfkbVprrdXXyy3gxmqrQIdQM/MZisaQAL
   uAXcGm8yCQemONK9qr78yCZxz16hHfZfHWjDZtoLitY4jQ565qks9G8mu
   25wZHHzSOfkeFYEm4KikVVYLxwcVPpnyvgJ9fgVEPmFRU5PjHegzwpzVe
   csGMGgofEPol78a24OUzAcA0tRnQDip/i5AawvhGQSwwFhJMJZVmGCFBT
   u+2Oq04WnlRXyE2q2clnvwMYUh6ywZ+cJGNI8TNZaQ68+Bv+rPH03+XPj
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10202"; a="326232085"
X-IronPort-AV: E=Sophos;i="5.88,216,1635231600"; 
   d="scan'208";a="326232085"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2021 09:57:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,216,1635231600"; 
   d="scan'208";a="465474389"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 18 Dec 2021 09:57:53 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mydxw-0006GI-Nt; Sat, 18 Dec 2021 17:57:52 +0000
Date:   Sun, 19 Dec 2021 01:57:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: samples/ftrace/ftrace-direct-multi-modify.c:7:6: warning: no
 previous prototype for function 'my_direct_func1'
Message-ID: <202112190117.RKPcHQjE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9eaa88c7036eda3f6c215f87ca693594cf90559b
commit: e1067a07cfbc5a36abad3752fafe4c79e06db1bb ftrace/samples: Add module to test multi direct modify interface
date:   9 days ago
config: x86_64-randconfig-a001-20211219 (https://download.01.org/0day-ci/archive/20211219/202112190117.RKPcHQjE-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 4c9e31a4814592bbda7153833e46728dc7b21100)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e1067a07cfbc5a36abad3752fafe4c79e06db1bb
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e1067a07cfbc5a36abad3752fafe4c79e06db1bb
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash samples/ftrace/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> samples/ftrace/ftrace-direct-multi-modify.c:7:6: warning: no previous prototype for function 'my_direct_func1' [-Wmissing-prototypes]
   void my_direct_func1(unsigned long ip)
        ^
   samples/ftrace/ftrace-direct-multi-modify.c:7:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void my_direct_func1(unsigned long ip)
   ^
   static 
>> samples/ftrace/ftrace-direct-multi-modify.c:12:6: warning: no previous prototype for function 'my_direct_func2' [-Wmissing-prototypes]
   void my_direct_func2(unsigned long ip)
        ^
   samples/ftrace/ftrace-direct-multi-modify.c:12:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void my_direct_func2(unsigned long ip)
   ^
   static 
   2 warnings generated.


vim +/my_direct_func1 +7 samples/ftrace/ftrace-direct-multi-modify.c

     6	
   > 7	void my_direct_func1(unsigned long ip)
     8	{
     9		trace_printk("my direct func1 ip %lx\n", ip);
    10	}
    11	
  > 12	void my_direct_func2(unsigned long ip)
    13	{
    14		trace_printk("my direct func2 ip %lx\n", ip);
    15	}
    16	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
