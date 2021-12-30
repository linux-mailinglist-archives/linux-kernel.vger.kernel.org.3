Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89BE04820B9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 23:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242313AbhL3Wui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 17:50:38 -0500
Received: from mga01.intel.com ([192.55.52.88]:14522 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237492AbhL3Wuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 17:50:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640904636; x=1672440636;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Xf5Kl/wdtk5xovpWbkikpID0dE3m9N1GHAN9BXCevtA=;
  b=a3L++qvntuNhpG1Tjf1j0VfGrj2C9L66mwnkL44QBnlxdFR1KWw0ttLM
   P6f36gN8Wi7yWQ98TeZ8LzN1xopOz+gQJpAJlzft7Qg5Whu4lIURy4oIx
   a62ada8aU6dMYv6ipCSOd2i0+hawnAep1EvdsqdGZcen3ourFI0keu9Fo
   pHQx+/7lTdNXFG6vCEFYZ8EVR+BobtE1hACBITa7ZjeDjPpbS+avUD7FO
   goemdcHpPsPG6S0tR0CPTMjv9H4cmndFvKouOdBMB4sJP0VNo0a+sxRek
   xjaFet58eJDQBN/2gj353NoqyxNsvLFWwnp69/pWlBUwLHER/CcILb7En
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10213"; a="265989765"
X-IronPort-AV: E=Sophos;i="5.88,248,1635231600"; 
   d="scan'208";a="265989765"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2021 14:50:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,248,1635231600"; 
   d="scan'208";a="610019439"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Dec 2021 14:50:34 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n34Fl-000Agz-IT; Thu, 30 Dec 2021 22:50:33 +0000
Date:   Fri, 31 Dec 2021 06:49:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Axtens <dja@axtens.net>
Subject: [linux-stable-rc:queue/5.4 3030/9999]
 arch/powerpc/kernel/setup_64.c:913:6: error: no previous prototype for
 'entry_flush_enable'
Message-ID: <202112310631.xDknJR1R-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git queue/5.4
head:   8119581dca11ec464922e85b5eaa28ed6558d619
commit: b65458b6be8032c5179d4f562038575d7b3a6be3 [3030/9999] powerpc/64s: flush L1D on kernel entry
config: powerpc64-randconfig-r011-20211230 (https://download.01.org/0day-ci/archive/20211231/202112310631.xDknJR1R-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=b65458b6be8032c5179d4f562038575d7b3a6be3
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc queue/5.4
        git checkout b65458b6be8032c5179d4f562038575d7b3a6be3
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
>> arch/powerpc/kernel/setup_64.c:913:6: error: no previous prototype for 'entry_flush_enable' [-Werror=missing-prototypes]
     913 | void entry_flush_enable(bool enable)
         |      ^~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/entry_flush_enable +913 arch/powerpc/kernel/setup_64.c

   912	
 > 913	void entry_flush_enable(bool enable)
   914	{
   915		if (enable) {
   916			do_entry_flush_fixups(enabled_flush_types);
   917			on_each_cpu(do_nothing, NULL, 1);
   918		} else {
   919			do_entry_flush_fixups(L1D_FLUSH_NONE);
   920		}
   921	
   922		entry_flush = enable;
   923	}
   924	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
