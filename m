Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F47C482159
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 02:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242533AbhLaB5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 20:57:43 -0500
Received: from mga18.intel.com ([134.134.136.126]:5098 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229890AbhLaB5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 20:57:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640915862; x=1672451862;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OoO/bz9BmVgd8MqTnGKt7OXOL+ceJ2zZdE8+/fq4lp0=;
  b=PQ2ANELc0Capr6D8L41Qgt6nj23HM3LJcR3PE+dsU4oaJlfpq+35iWU2
   /btgjuht+GFCL0+fK2P2wWz/Ls1qmOLhprPA06ZqBtUmlAtMDKyKa6Ajn
   xnH16gsC+oGCWLx3Y0TTFtjM2Na9mx+C0tiNVUWzMhxWmgNHT/bQvdJ4p
   r9KKSitIyXWIP7e6kxd+ZlOQXSzStj8S+eHgxbEf10EOClmT9FTz0KUEB
   vAYak2VdyLfi7ryXsuCozTWoYYb6puMorhKMotWgRQK56jqpUBmYXcTJE
   NykzpO/6P7GBjzZRYj+9/I9hsjZskalMpHCvqofvnIlWKba0/zeEUckAz
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10213"; a="228582234"
X-IronPort-AV: E=Sophos;i="5.88,250,1635231600"; 
   d="scan'208";a="228582234"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2021 17:57:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,250,1635231600"; 
   d="scan'208";a="619520975"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 30 Dec 2021 17:57:39 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n37Ao-000AqO-Mn; Fri, 31 Dec 2021 01:57:38 +0000
Date:   Fri, 31 Dec 2021 09:57:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Axtens <dja@axtens.net>
Subject: [linux-stable-rc:queue/5.4 3031/9999]
 arch/powerpc/kernel/setup_64.c:937:6: error: no previous prototype for
 'uaccess_flush_enable'
Message-ID: <202112310904.IyGN0xIx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git queue/5.4
head:   8119581dca11ec464922e85b5eaa28ed6558d619
commit: 09495b5f7aab84cf41ef54259cfea4da86a7df98 [3031/9999] powerpc/64s: flush L1D after user accesses
config: powerpc64-randconfig-r011-20211230 (https://download.01.org/0day-ci/archive/20211231/202112310904.IyGN0xIx-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=09495b5f7aab84cf41ef54259cfea4da86a7df98
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc queue/5.4
        git checkout 09495b5f7aab84cf41ef54259cfea4da86a7df98
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the linux-stable-rc/queue/5.4 HEAD 8119581dca11ec464922e85b5eaa28ed6558d619 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   arch/powerpc/kernel/setup_64.c:262:13: error: no previous prototype for 'record_spr_defaults' [-Werror=missing-prototypes]
     262 | void __init record_spr_defaults(void)
         |             ^~~~~~~~~~~~~~~~~~~
   arch/powerpc/kernel/setup_64.c:287:32: error: no previous prototype for 'early_setup' [-Werror=missing-prototypes]
     287 | void __init __nostackprotector early_setup(unsigned long dt_ptr)
         |                                ^~~~~~~~~~~
   arch/powerpc/kernel/setup_64.c:399:6: error: no previous prototype for 'early_setup_secondary' [-Werror=missing-prototypes]
     399 | void early_setup_secondary(void)
         |      ^~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/kernel/setup_64.c:420:6: error: no previous prototype for 'panic_smp_self_stop' [-Werror=missing-prototypes]
     420 | void panic_smp_self_stop(void)
         |      ^~~~~~~~~~~~~~~~~~~
   arch/powerpc/kernel/setup_64.c: In function 'initialize_cache_info':
   arch/powerpc/kernel/setup_64.c:599:70: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
     599 |                         DBG("Argh, can't find dcache properties !\n");
         |                                                                      ^
   arch/powerpc/kernel/setup_64.c:602:70: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
     602 |                         DBG("Argh, can't find icache properties !\n");
         |                                                                      ^
   arch/powerpc/kernel/setup_64.c: At top level:
   arch/powerpc/kernel/setup_64.c:925:6: error: no previous prototype for 'entry_flush_enable' [-Werror=missing-prototypes]
     925 | void entry_flush_enable(bool enable)
         |      ^~~~~~~~~~~~~~~~~~
>> arch/powerpc/kernel/setup_64.c:937:6: error: no previous prototype for 'uaccess_flush_enable' [-Werror=missing-prototypes]
     937 | void uaccess_flush_enable(bool enable)
         |      ^~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/uaccess_flush_enable +937 arch/powerpc/kernel/setup_64.c

   936	
 > 937	void uaccess_flush_enable(bool enable)
   938	{
   939		if (enable) {
   940			do_uaccess_flush_fixups(enabled_flush_types);
   941			static_branch_enable(&uaccess_flush_key);
   942			on_each_cpu(do_nothing, NULL, 1);
   943		} else {
   944			static_branch_disable(&uaccess_flush_key);
   945			do_uaccess_flush_fixups(L1D_FLUSH_NONE);
   946		}
   947	
   948		uaccess_flush = enable;
   949	}
   950	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
