Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAA748E008
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 23:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236328AbiAMWEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 17:04:07 -0500
Received: from mga17.intel.com ([192.55.52.151]:30066 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232985AbiAMWEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 17:04:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642111446; x=1673647446;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AVmkdUeFwJb0tVoFQbBzCeaOX4Nv73NqE4k9TM+rAd8=;
  b=ehqRHFVYIln6k3Q1dNhcXr4RUIdP9v4kQ4D23le/zKvvm1P90wmLcTv9
   nBB8ofrucdT+BWYkmwC6hiZdsUWLBMQe2AEmZdUz53ceZZbxwevTUn7r1
   0SJjKyawSPw8w+HB6RRQgTrwn965eeM6dWBf5FE4KHgXjnHO8wAZmrEj+
   wHtONWGEGvC5CvSGsswX8h7H7rBUf+/8ffmdGygucvHnl6KUn1zsOjXWY
   fn4u529ysxyFQH9YBMXbHS7LnVps9Q468uv9OO8AjElQJO/sKWPenUihz
   D6uxPtHXkWydiFy8wayEfN3vbyZpbDM5greSxYdVNCrMjgdQGahagedOX
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="224812154"
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="224812154"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 14:04:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="691961912"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 13 Jan 2022 14:04:05 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n88CS-0007gs-G0; Thu, 13 Jan 2022 22:04:04 +0000
Date:   Fri, 14 Jan 2022 06:03:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mark:treewide/gnu99 2/2] arch/sh/include/asm/pgtable.h:39:31:
 error: left shift of negative value
Message-ID: <202201140534.ii9mlcnU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git treewide/gnu99
head:   4c56f3c557cbc276326c329e05f64a53398affec
commit: 4c56f3c557cbc276326c329e05f64a53398affec [2/2] treewide: use -std=gnu99
config: sh-randconfig-r026-20220113 (https://download.01.org/0day-ci/archive/20220114/202201140534.ii9mlcnU-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=4c56f3c557cbc276326c329e05f64a53398affec
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark treewide/gnu99
        git checkout 4c56f3c557cbc276326c329e05f64a53398affec
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sh SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   cc1: error: arch/sh/include/mach-hp6xx: No such file or directory [-Werror=missing-include-dirs]
   cc1: error: arch/sh/include/mach-hp6xx: No such file or directory [-Werror=missing-include-dirs]
   In file included from include/linux/pgtable.h:6,
                    from arch/sh/include/asm/io.h:21,
                    from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from include/asm-generic/hardirq.h:17,
                    from arch/sh/include/asm/hardirq.h:9,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from arch/sh/cchips/hd6446x/hd64461.c:11:
   arch/sh/include/asm/pgtable.h: In function 'neff_sign_extend':
>> arch/sh/include/asm/pgtable.h:39:31: error: left shift of negative value [-Werror=shift-negative-value]
      39 | #define NEFF_MASK       (-1LL << NEFF)
         |                               ^~
   arch/sh/include/asm/pgtable.h:44:53: note: in expansion of macro 'NEFF_MASK'
      44 |         return (extended & NEFF_SIGN) ? (extended | NEFF_MASK) : extended;
         |                                                     ^~~~~~~~~
   arch/sh/cchips/hd6446x/hd64461.c: At top level:
   arch/sh/cchips/hd6446x/hd64461.c:75:12: error: no previous prototype for 'setup_hd64461' [-Werror=missing-prototypes]
      75 | int __init setup_hd64461(void)
         |            ^~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +39 arch/sh/include/asm/pgtable.h

^1da177e4c3f41 include/asm-sh/pgtable.h Linus Torvalds 2005-04-16  32  
36bcd39dbca824 include/asm-sh/pgtable.h Paul Mundt     2007-11-10  33  /*
36bcd39dbca824 include/asm-sh/pgtable.h Paul Mundt     2007-11-10  34   * Effective and physical address definitions, to aid with sign
36bcd39dbca824 include/asm-sh/pgtable.h Paul Mundt     2007-11-10  35   * extension.
36bcd39dbca824 include/asm-sh/pgtable.h Paul Mundt     2007-11-10  36   */
36bcd39dbca824 include/asm-sh/pgtable.h Paul Mundt     2007-11-10  37  #define NEFF		32
36bcd39dbca824 include/asm-sh/pgtable.h Paul Mundt     2007-11-10  38  #define	NEFF_SIGN	(1LL << (NEFF - 1))
36bcd39dbca824 include/asm-sh/pgtable.h Paul Mundt     2007-11-10 @39  #define	NEFF_MASK	(-1LL << NEFF)
36bcd39dbca824 include/asm-sh/pgtable.h Paul Mundt     2007-11-10  40  

:::::: The code at line 39 was first introduced by commit
:::::: 36bcd39dbca824daffe16d607ae574b6edc7d31a sh: Split out 29-bit and 32-bit physical mode definitions.

:::::: TO: Paul Mundt <lethal@linux-sh.org>
:::::: CC: Paul Mundt <lethal@linux-sh.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
