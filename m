Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F3B48CE9D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 23:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbiALW70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 17:59:26 -0500
Received: from mga07.intel.com ([134.134.136.100]:60005 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234747AbiALW7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 17:59:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642028363; x=1673564363;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fzQ91e0kvTUkLIey14pwHxSkllZrr7kOgv2IcWh5jto=;
  b=RZ56JA3iE0aDFU+o+lyoDhjPKWuRUPiAI58CmEBnCUJFlEUJQNIY5Kp4
   evYsXl3miZ6o7eb9MQzmdPdRoZ4b3mqeDqB8Zn7Wxjlr982Ig2olYivRl
   jqedu+wimRYV+S0aP0K2CCH3cYtgFH8V3jT1fGQ+rqOJWw1LUvdCTWTwm
   7VZC0YinPdxX+7VQS/PawwAqKR0RATLl7tXTkMf45c3orl6x/pK3rGJn+
   ByoCc1B3jUEXR7N7zqt/aS3MITiXItOUoKjYIj34KUTUSCqOf4uLRMxIN
   goUoOdKEWv01XPXJb12EK7fcxfSSjlbDRNkc0vC+SRTFE06+34aOAT1sJ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="307220355"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="307220355"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 14:59:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="515689182"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 12 Jan 2022 14:59:21 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7maO-0006WN-NR; Wed, 12 Jan 2022 22:59:20 +0000
Date:   Thu, 13 Jan 2022 06:59:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mark:treewide/gnu99 1/1] net/netfilter/xt_hashlimit.c:608:40:
 warning: left shift of negative value
Message-ID: <202201130653.9pXG19yX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git treewide/gnu99
head:   df0f3c59f076be0ab4a6d8de53fdeef871394594
commit: df0f3c59f076be0ab4a6d8de53fdeef871394594 [1/1] treewide: use -std=gnu99
config: m68k-defconfig (https://download.01.org/0day-ci/archive/20220113/202201130653.9pXG19yX-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=df0f3c59f076be0ab4a6d8de53fdeef871394594
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark treewide/gnu99
        git checkout df0f3c59f076be0ab4a6d8de53fdeef871394594
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash drivers/block/drbd/ net/netfilter/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/byteorder/big_endian.h:5,
                    from arch/m68k/include/uapi/asm/byteorder.h:5,
                    from include/asm-generic/bitops/le.h:7,
                    from arch/m68k/include/asm/bitops.h:529,
                    from include/linux/bitops.h:33,
                    from include/linux/thread_info.h:27,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/m68k/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from arch/m68k/include/asm/irqflags.h:6,
                    from include/linux/irqflags.h:16,
                    from arch/m68k/include/asm/atomic.h:6,
                    from include/linux/atomic.h:7,
                    from include/linux/mm_types_task.h:13,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from net/netfilter/xt_hashlimit.c:13:
   net/netfilter/xt_hashlimit.c: In function 'maskl':
>> net/netfilter/xt_hashlimit.c:608:40: warning: left shift of negative value [-Wshift-negative-value]
     608 |         return l ? htonl(ntohl(a) & ~0 << (32 - l)) : 0;
         |                                        ^~
   include/uapi/linux/byteorder/big_endian.h:40:51: note: in definition of macro '__cpu_to_be32'
      40 | #define __cpu_to_be32(x) ((__force __be32)(__u32)(x))
         |                                                   ^
   include/linux/byteorder/generic.h:139:18: note: in expansion of macro '___htonl'
     139 | #define htonl(x) ___htonl(x)
         |                  ^~~~~~~~
   net/netfilter/xt_hashlimit.c:608:20: note: in expansion of macro 'htonl'
     608 |         return l ? htonl(ntohl(a) & ~0 << (32 - l)) : 0;
         |                    ^~~~~
--
   drivers/block/drbd/drbd_main.c: In function 'dcbp_set_pad_bits':
>> drivers/block/drbd/drbd_main.c:1095:44: warning: left shift of negative value [-Wshift-negative-value]
    1095 |         p->encoding = (p->encoding & (~0x7 << 4)) | (n << 4);
         |                                            ^~


vim +608 net/netfilter/xt_hashlimit.c

817e076f61bca3 Florian Westphal 2012-05-07  605  
09e410def64324 Jan Engelhardt   2008-01-31  606  static inline __be32 maskl(__be32 a, unsigned int l)
09e410def64324 Jan Engelhardt   2008-01-31  607  {
1b9b70ea2ebaab Patrick McHardy  2008-04-09 @608  	return l ? htonl(ntohl(a) & ~0 << (32 - l)) : 0;
09e410def64324 Jan Engelhardt   2008-01-31  609  }
09e410def64324 Jan Engelhardt   2008-01-31  610  

:::::: The code at line 608 was first introduced by commit
:::::: 1b9b70ea2ebaab26c3e4fed385dfab6fc16359ed [NETFILTER]: xt_hashlimit: fix mask calculation

:::::: TO: Patrick McHardy <kaber@trash.net>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
