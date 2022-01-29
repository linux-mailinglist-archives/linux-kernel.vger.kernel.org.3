Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDD24A2D02
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 09:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352487AbiA2IPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 03:15:50 -0500
Received: from mga12.intel.com ([192.55.52.136]:59787 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235255AbiA2IPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 03:15:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643444103; x=1674980103;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xiKxwkxZGpQUMiR5hd0P3B1nnjHl7/YchFR5kJxvI9o=;
  b=m3bNOL13TSYXBsw+O4srjVT8YoI6nVNzU8kD73NUbIcnkSnpA2qQgGmM
   rS7pmr5OQlYPtCR/lF9/OBfbSZMKhvyjmvgI88gv7ApAoH7JJgf4p4yDZ
   03ohqVgRqYCORksO0wHhHvwQqO04SpwC5RHJEGs98VXyvnWfwgd1ewrFz
   VRnbS8RZJBDYLsRNG4QZODbueim6CPnZhqtl/xkym0Q0sPJLK4hQ9ce5q
   p2CbCGDvVIuw8uAoy/gbAyR5XXocIrIKV0J8g3QsxJytGDWC4xoEMOPfW
   TxoyLslnkgX/7naPlF5XLantgieotyGqQqoBIy7wXb5p+CwdJ3Ky9rWiD
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="227230680"
X-IronPort-AV: E=Sophos;i="5.88,326,1635231600"; 
   d="scan'208";a="227230680"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2022 00:14:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,326,1635231600"; 
   d="scan'208";a="697342462"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 29 Jan 2022 00:14:48 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDisi-000Oxr-Ai; Sat, 29 Jan 2022 08:14:48 +0000
Date:   Sat, 29 Jan 2022 16:14:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>
Subject: [s390:fixes 5/6] arch/s390/lib/test_modules_helpers.c:8:13: warning:
 no previous prototype for 'test_modules_return_0000'
Message-ID: <202201291658.maxSRfHd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git fixes
head:   c9bb19368b3ab111aedf3297e65bf84c9d3aa005
commit: 90c5318795eefa09a9f9aef8d18a904e24962b5c [5/6] s390/module: test loading modules with a lot of relocations
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20220129/202201291658.maxSRfHd-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/commit/?id=90c5318795eefa09a9f9aef8d18a904e24962b5c
        git remote add s390 https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git
        git fetch --no-tags s390 fixes
        git checkout 90c5318795eefa09a9f9aef8d18a904e24962b5c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/s390/lib/test_modules_helpers.c:8:13: warning: no previous prototype for 'test_modules_return_0000' [-Wmissing-prototypes]
       8 |         int test_modules_return_ ## i(void) \
         |             ^~~~~~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:6:9: note: in expansion of macro 'DEFINE_RETURN'
       6 |         f(x ## 0); \
         |         ^
   arch/s390/lib/test_modules.h:17:9: note: in expansion of macro '__REPEAT_10000_3'
      17 |         __REPEAT_10000_3(f, x ## 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:28:9: note: in expansion of macro '__REPEAT_10000_2'
      28 |         __REPEAT_10000_2(f, x ## 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:39:9: note: in expansion of macro '__REPEAT_10000_1'
      39 |         __REPEAT_10000_1(f, 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules_helpers.c:13:1: note: in expansion of macro 'REPEAT_10000'
      13 | REPEAT_10000(DEFINE_RETURN);
         | ^~~~~~~~~~~~
>> arch/s390/lib/test_modules_helpers.c:8:13: warning: no previous prototype for 'test_modules_return_0001' [-Wmissing-prototypes]
       8 |         int test_modules_return_ ## i(void) \
         |             ^~~~~~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:7:9: note: in expansion of macro 'DEFINE_RETURN'
       7 |         f(x ## 1); \
         |         ^
   arch/s390/lib/test_modules.h:17:9: note: in expansion of macro '__REPEAT_10000_3'
      17 |         __REPEAT_10000_3(f, x ## 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:28:9: note: in expansion of macro '__REPEAT_10000_2'
      28 |         __REPEAT_10000_2(f, x ## 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:39:9: note: in expansion of macro '__REPEAT_10000_1'
      39 |         __REPEAT_10000_1(f, 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules_helpers.c:13:1: note: in expansion of macro 'REPEAT_10000'
      13 | REPEAT_10000(DEFINE_RETURN);
         | ^~~~~~~~~~~~
>> arch/s390/lib/test_modules_helpers.c:8:13: warning: no previous prototype for 'test_modules_return_0002' [-Wmissing-prototypes]
       8 |         int test_modules_return_ ## i(void) \
         |             ^~~~~~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:8:9: note: in expansion of macro 'DEFINE_RETURN'
       8 |         f(x ## 2); \
         |         ^
   arch/s390/lib/test_modules.h:17:9: note: in expansion of macro '__REPEAT_10000_3'
      17 |         __REPEAT_10000_3(f, x ## 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:28:9: note: in expansion of macro '__REPEAT_10000_2'
      28 |         __REPEAT_10000_2(f, x ## 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:39:9: note: in expansion of macro '__REPEAT_10000_1'
      39 |         __REPEAT_10000_1(f, 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules_helpers.c:13:1: note: in expansion of macro 'REPEAT_10000'
      13 | REPEAT_10000(DEFINE_RETURN);
         | ^~~~~~~~~~~~
>> arch/s390/lib/test_modules_helpers.c:8:13: warning: no previous prototype for 'test_modules_return_0003' [-Wmissing-prototypes]
       8 |         int test_modules_return_ ## i(void) \
         |             ^~~~~~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:9:9: note: in expansion of macro 'DEFINE_RETURN'
       9 |         f(x ## 3); \
         |         ^
   arch/s390/lib/test_modules.h:17:9: note: in expansion of macro '__REPEAT_10000_3'
      17 |         __REPEAT_10000_3(f, x ## 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:28:9: note: in expansion of macro '__REPEAT_10000_2'
      28 |         __REPEAT_10000_2(f, x ## 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:39:9: note: in expansion of macro '__REPEAT_10000_1'
      39 |         __REPEAT_10000_1(f, 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules_helpers.c:13:1: note: in expansion of macro 'REPEAT_10000'
      13 | REPEAT_10000(DEFINE_RETURN);
         | ^~~~~~~~~~~~
>> arch/s390/lib/test_modules_helpers.c:8:13: warning: no previous prototype for 'test_modules_return_0004' [-Wmissing-prototypes]
       8 |         int test_modules_return_ ## i(void) \
         |             ^~~~~~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:10:9: note: in expansion of macro 'DEFINE_RETURN'
      10 |         f(x ## 4); \
         |         ^
   arch/s390/lib/test_modules.h:17:9: note: in expansion of macro '__REPEAT_10000_3'
      17 |         __REPEAT_10000_3(f, x ## 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:28:9: note: in expansion of macro '__REPEAT_10000_2'
      28 |         __REPEAT_10000_2(f, x ## 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:39:9: note: in expansion of macro '__REPEAT_10000_1'
      39 |         __REPEAT_10000_1(f, 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules_helpers.c:13:1: note: in expansion of macro 'REPEAT_10000'
      13 | REPEAT_10000(DEFINE_RETURN);
         | ^~~~~~~~~~~~
>> arch/s390/lib/test_modules_helpers.c:8:13: warning: no previous prototype for 'test_modules_return_0005' [-Wmissing-prototypes]
       8 |         int test_modules_return_ ## i(void) \
         |             ^~~~~~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:11:9: note: in expansion of macro 'DEFINE_RETURN'
      11 |         f(x ## 5); \
         |         ^
   arch/s390/lib/test_modules.h:17:9: note: in expansion of macro '__REPEAT_10000_3'
      17 |         __REPEAT_10000_3(f, x ## 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:28:9: note: in expansion of macro '__REPEAT_10000_2'
      28 |         __REPEAT_10000_2(f, x ## 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:39:9: note: in expansion of macro '__REPEAT_10000_1'
      39 |         __REPEAT_10000_1(f, 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules_helpers.c:13:1: note: in expansion of macro 'REPEAT_10000'
      13 | REPEAT_10000(DEFINE_RETURN);
         | ^~~~~~~~~~~~
>> arch/s390/lib/test_modules_helpers.c:8:13: warning: no previous prototype for 'test_modules_return_0006' [-Wmissing-prototypes]
       8 |         int test_modules_return_ ## i(void) \
         |             ^~~~~~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:12:9: note: in expansion of macro 'DEFINE_RETURN'
      12 |         f(x ## 6); \
         |         ^
   arch/s390/lib/test_modules.h:17:9: note: in expansion of macro '__REPEAT_10000_3'
      17 |         __REPEAT_10000_3(f, x ## 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:28:9: note: in expansion of macro '__REPEAT_10000_2'
      28 |         __REPEAT_10000_2(f, x ## 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:39:9: note: in expansion of macro '__REPEAT_10000_1'
      39 |         __REPEAT_10000_1(f, 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules_helpers.c:13:1: note: in expansion of macro 'REPEAT_10000'
      13 | REPEAT_10000(DEFINE_RETURN);
         | ^~~~~~~~~~~~
>> arch/s390/lib/test_modules_helpers.c:8:13: warning: no previous prototype for 'test_modules_return_0007' [-Wmissing-prototypes]
       8 |         int test_modules_return_ ## i(void) \
         |             ^~~~~~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:13:9: note: in expansion of macro 'DEFINE_RETURN'
      13 |         f(x ## 7); \
         |         ^
   arch/s390/lib/test_modules.h:17:9: note: in expansion of macro '__REPEAT_10000_3'
      17 |         __REPEAT_10000_3(f, x ## 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:28:9: note: in expansion of macro '__REPEAT_10000_2'
      28 |         __REPEAT_10000_2(f, x ## 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:39:9: note: in expansion of macro '__REPEAT_10000_1'
      39 |         __REPEAT_10000_1(f, 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules_helpers.c:13:1: note: in expansion of macro 'REPEAT_10000'
      13 | REPEAT_10000(DEFINE_RETURN);
         | ^~~~~~~~~~~~
>> arch/s390/lib/test_modules_helpers.c:8:13: warning: no previous prototype for 'test_modules_return_0008' [-Wmissing-prototypes]
       8 |         int test_modules_return_ ## i(void) \
         |             ^~~~~~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:14:9: note: in expansion of macro 'DEFINE_RETURN'
      14 |         f(x ## 8); \
         |         ^
   arch/s390/lib/test_modules.h:17:9: note: in expansion of macro '__REPEAT_10000_3'
      17 |         __REPEAT_10000_3(f, x ## 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:28:9: note: in expansion of macro '__REPEAT_10000_2'
      28 |         __REPEAT_10000_2(f, x ## 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:39:9: note: in expansion of macro '__REPEAT_10000_1'
      39 |         __REPEAT_10000_1(f, 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules_helpers.c:13:1: note: in expansion of macro 'REPEAT_10000'
      13 | REPEAT_10000(DEFINE_RETURN);
         | ^~~~~~~~~~~~
>> arch/s390/lib/test_modules_helpers.c:8:13: warning: no previous prototype for 'test_modules_return_0009' [-Wmissing-prototypes]
       8 |         int test_modules_return_ ## i(void) \
         |             ^~~~~~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:15:9: note: in expansion of macro 'DEFINE_RETURN'
      15 |         f(x ## 9)
         |         ^
   arch/s390/lib/test_modules.h:17:9: note: in expansion of macro '__REPEAT_10000_3'
      17 |         __REPEAT_10000_3(f, x ## 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:28:9: note: in expansion of macro '__REPEAT_10000_2'
      28 |         __REPEAT_10000_2(f, x ## 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:39:9: note: in expansion of macro '__REPEAT_10000_1'
      39 |         __REPEAT_10000_1(f, 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules_helpers.c:13:1: note: in expansion of macro 'REPEAT_10000'
      13 | REPEAT_10000(DEFINE_RETURN);
         | ^~~~~~~~~~~~
>> arch/s390/lib/test_modules_helpers.c:8:13: warning: no previous prototype for 'test_modules_return_0010' [-Wmissing-prototypes]
       8 |         int test_modules_return_ ## i(void) \
         |             ^~~~~~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:6:9: note: in expansion of macro 'DEFINE_RETURN'
       6 |         f(x ## 0); \
         |         ^
   arch/s390/lib/test_modules.h:18:9: note: in expansion of macro '__REPEAT_10000_3'
      18 |         __REPEAT_10000_3(f, x ## 1); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:28:9: note: in expansion of macro '__REPEAT_10000_2'
      28 |         __REPEAT_10000_2(f, x ## 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:39:9: note: in expansion of macro '__REPEAT_10000_1'
      39 |         __REPEAT_10000_1(f, 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules_helpers.c:13:1: note: in expansion of macro 'REPEAT_10000'
      13 | REPEAT_10000(DEFINE_RETURN);
         | ^~~~~~~~~~~~
>> arch/s390/lib/test_modules_helpers.c:8:13: warning: no previous prototype for 'test_modules_return_0011' [-Wmissing-prototypes]
       8 |         int test_modules_return_ ## i(void) \
         |             ^~~~~~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:7:9: note: in expansion of macro 'DEFINE_RETURN'
       7 |         f(x ## 1); \
         |         ^
   arch/s390/lib/test_modules.h:18:9: note: in expansion of macro '__REPEAT_10000_3'
      18 |         __REPEAT_10000_3(f, x ## 1); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:28:9: note: in expansion of macro '__REPEAT_10000_2'
      28 |         __REPEAT_10000_2(f, x ## 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:39:9: note: in expansion of macro '__REPEAT_10000_1'
      39 |         __REPEAT_10000_1(f, 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules_helpers.c:13:1: note: in expansion of macro 'REPEAT_10000'
      13 | REPEAT_10000(DEFINE_RETURN);
         | ^~~~~~~~~~~~
>> arch/s390/lib/test_modules_helpers.c:8:13: warning: no previous prototype for 'test_modules_return_0012' [-Wmissing-prototypes]
       8 |         int test_modules_return_ ## i(void) \
         |             ^~~~~~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:8:9: note: in expansion of macro 'DEFINE_RETURN'
       8 |         f(x ## 2); \
         |         ^
   arch/s390/lib/test_modules.h:18:9: note: in expansion of macro '__REPEAT_10000_3'
      18 |         __REPEAT_10000_3(f, x ## 1); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:28:9: note: in expansion of macro '__REPEAT_10000_2'
      28 |         __REPEAT_10000_2(f, x ## 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:39:9: note: in expansion of macro '__REPEAT_10000_1'
      39 |         __REPEAT_10000_1(f, 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules_helpers.c:13:1: note: in expansion of macro 'REPEAT_10000'
      13 | REPEAT_10000(DEFINE_RETURN);
         | ^~~~~~~~~~~~
>> arch/s390/lib/test_modules_helpers.c:8:13: warning: no previous prototype for 'test_modules_return_0013' [-Wmissing-prototypes]
       8 |         int test_modules_return_ ## i(void) \
         |             ^~~~~~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:9:9: note: in expansion of macro 'DEFINE_RETURN'
       9 |         f(x ## 3); \
         |         ^
   arch/s390/lib/test_modules.h:18:9: note: in expansion of macro '__REPEAT_10000_3'
      18 |         __REPEAT_10000_3(f, x ## 1); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:28:9: note: in expansion of macro '__REPEAT_10000_2'
      28 |         __REPEAT_10000_2(f, x ## 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:39:9: note: in expansion of macro '__REPEAT_10000_1'
      39 |         __REPEAT_10000_1(f, 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules_helpers.c:13:1: note: in expansion of macro 'REPEAT_10000'
      13 | REPEAT_10000(DEFINE_RETURN);
         | ^~~~~~~~~~~~
>> arch/s390/lib/test_modules_helpers.c:8:13: warning: no previous prototype for 'test_modules_return_0014' [-Wmissing-prototypes]
       8 |         int test_modules_return_ ## i(void) \
         |             ^~~~~~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:10:9: note: in expansion of macro 'DEFINE_RETURN'
      10 |         f(x ## 4); \
         |         ^
   arch/s390/lib/test_modules.h:18:9: note: in expansion of macro '__REPEAT_10000_3'
      18 |         __REPEAT_10000_3(f, x ## 1); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:28:9: note: in expansion of macro '__REPEAT_10000_2'
      28 |         __REPEAT_10000_2(f, x ## 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:39:9: note: in expansion of macro '__REPEAT_10000_1'
      39 |         __REPEAT_10000_1(f, 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules_helpers.c:13:1: note: in expansion of macro 'REPEAT_10000'
      13 | REPEAT_10000(DEFINE_RETURN);
         | ^~~~~~~~~~~~
>> arch/s390/lib/test_modules_helpers.c:8:13: warning: no previous prototype for 'test_modules_return_0015' [-Wmissing-prototypes]
       8 |         int test_modules_return_ ## i(void) \
         |             ^~~~~~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:11:9: note: in expansion of macro 'DEFINE_RETURN'
      11 |         f(x ## 5); \
         |         ^
   arch/s390/lib/test_modules.h:18:9: note: in expansion of macro '__REPEAT_10000_3'
      18 |         __REPEAT_10000_3(f, x ## 1); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:28:9: note: in expansion of macro '__REPEAT_10000_2'
      28 |         __REPEAT_10000_2(f, x ## 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:39:9: note: in expansion of macro '__REPEAT_10000_1'
      39 |         __REPEAT_10000_1(f, 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules_helpers.c:13:1: note: in expansion of macro 'REPEAT_10000'
      13 | REPEAT_10000(DEFINE_RETURN);
         | ^~~~~~~~~~~~
>> arch/s390/lib/test_modules_helpers.c:8:13: warning: no previous prototype for 'test_modules_return_0016' [-Wmissing-prototypes]
       8 |         int test_modules_return_ ## i(void) \
         |             ^~~~~~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:12:9: note: in expansion of macro 'DEFINE_RETURN'
      12 |         f(x ## 6); \
         |         ^
   arch/s390/lib/test_modules.h:18:9: note: in expansion of macro '__REPEAT_10000_3'
      18 |         __REPEAT_10000_3(f, x ## 1); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:28:9: note: in expansion of macro '__REPEAT_10000_2'
      28 |         __REPEAT_10000_2(f, x ## 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:39:9: note: in expansion of macro '__REPEAT_10000_1'
      39 |         __REPEAT_10000_1(f, 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules_helpers.c:13:1: note: in expansion of macro 'REPEAT_10000'
      13 | REPEAT_10000(DEFINE_RETURN);
         | ^~~~~~~~~~~~
>> arch/s390/lib/test_modules_helpers.c:8:13: warning: no previous prototype for 'test_modules_return_0017' [-Wmissing-prototypes]
       8 |         int test_modules_return_ ## i(void) \
         |             ^~~~~~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:13:9: note: in expansion of macro 'DEFINE_RETURN'
      13 |         f(x ## 7); \
         |         ^
   arch/s390/lib/test_modules.h:18:9: note: in expansion of macro '__REPEAT_10000_3'
      18 |         __REPEAT_10000_3(f, x ## 1); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:28:9: note: in expansion of macro '__REPEAT_10000_2'
      28 |         __REPEAT_10000_2(f, x ## 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:39:9: note: in expansion of macro '__REPEAT_10000_1'
      39 |         __REPEAT_10000_1(f, 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules_helpers.c:13:1: note: in expansion of macro 'REPEAT_10000'
      13 | REPEAT_10000(DEFINE_RETURN);
         | ^~~~~~~~~~~~
>> arch/s390/lib/test_modules_helpers.c:8:13: warning: no previous prototype for 'test_modules_return_0018' [-Wmissing-prototypes]
       8 |         int test_modules_return_ ## i(void) \
         |             ^~~~~~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:14:9: note: in expansion of macro 'DEFINE_RETURN'
      14 |         f(x ## 8); \
         |         ^
   arch/s390/lib/test_modules.h:18:9: note: in expansion of macro '__REPEAT_10000_3'
      18 |         __REPEAT_10000_3(f, x ## 1); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:28:9: note: in expansion of macro '__REPEAT_10000_2'
      28 |         __REPEAT_10000_2(f, x ## 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:39:9: note: in expansion of macro '__REPEAT_10000_1'
      39 |         __REPEAT_10000_1(f, 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules_helpers.c:13:1: note: in expansion of macro 'REPEAT_10000'
      13 | REPEAT_10000(DEFINE_RETURN);
         | ^~~~~~~~~~~~
>> arch/s390/lib/test_modules_helpers.c:8:13: warning: no previous prototype for 'test_modules_return_0019' [-Wmissing-prototypes]
       8 |         int test_modules_return_ ## i(void) \
         |             ^~~~~~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:15:9: note: in expansion of macro 'DEFINE_RETURN'
      15 |         f(x ## 9)
         |         ^
   arch/s390/lib/test_modules.h:18:9: note: in expansion of macro '__REPEAT_10000_3'
      18 |         __REPEAT_10000_3(f, x ## 1); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:28:9: note: in expansion of macro '__REPEAT_10000_2'
      28 |         __REPEAT_10000_2(f, x ## 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:39:9: note: in expansion of macro '__REPEAT_10000_1'
      39 |         __REPEAT_10000_1(f, 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules_helpers.c:13:1: note: in expansion of macro 'REPEAT_10000'
      13 | REPEAT_10000(DEFINE_RETURN);
         | ^~~~~~~~~~~~
   arch/s390/lib/test_modules_helpers.c:8:13: warning: no previous prototype for 'test_modules_return_0020' [-Wmissing-prototypes]
       8 |         int test_modules_return_ ## i(void) \
         |             ^~~~~~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:6:9: note: in expansion of macro 'DEFINE_RETURN'
       6 |         f(x ## 0); \
         |         ^
   arch/s390/lib/test_modules.h:19:9: note: in expansion of macro '__REPEAT_10000_3'
      19 |         __REPEAT_10000_3(f, x ## 2); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:28:9: note: in expansion of macro '__REPEAT_10000_2'
      28 |         __REPEAT_10000_2(f, x ## 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:39:9: note: in expansion of macro '__REPEAT_10000_1'
      39 |         __REPEAT_10000_1(f, 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules_helpers.c:13:1: note: in expansion of macro 'REPEAT_10000'
      13 | REPEAT_10000(DEFINE_RETURN);
         | ^~~~~~~~~~~~
   arch/s390/lib/test_modules_helpers.c:8:13: warning: no previous prototype for 'test_modules_return_0021' [-Wmissing-prototypes]
       8 |         int test_modules_return_ ## i(void) \
         |             ^~~~~~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:7:9: note: in expansion of macro 'DEFINE_RETURN'
       7 |         f(x ## 1); \
         |         ^
   arch/s390/lib/test_modules.h:19:9: note: in expansion of macro '__REPEAT_10000_3'
      19 |         __REPEAT_10000_3(f, x ## 2); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:28:9: note: in expansion of macro '__REPEAT_10000_2'
      28 |         __REPEAT_10000_2(f, x ## 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:39:9: note: in expansion of macro '__REPEAT_10000_1'
      39 |         __REPEAT_10000_1(f, 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules_helpers.c:13:1: note: in expansion of macro 'REPEAT_10000'
      13 | REPEAT_10000(DEFINE_RETURN);
         | ^~~~~~~~~~~~
   arch/s390/lib/test_modules_helpers.c:8:13: warning: no previous prototype for 'test_modules_return_0022' [-Wmissing-prototypes]
       8 |         int test_modules_return_ ## i(void) \
         |             ^~~~~~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:8:9: note: in expansion of macro 'DEFINE_RETURN'
       8 |         f(x ## 2); \
         |         ^
   arch/s390/lib/test_modules.h:19:9: note: in expansion of macro '__REPEAT_10000_3'
      19 |         __REPEAT_10000_3(f, x ## 2); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:28:9: note: in expansion of macro '__REPEAT_10000_2'
      28 |         __REPEAT_10000_2(f, x ## 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:39:9: note: in expansion of macro '__REPEAT_10000_1'
      39 |         __REPEAT_10000_1(f, 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules_helpers.c:13:1: note: in expansion of macro 'REPEAT_10000'
      13 | REPEAT_10000(DEFINE_RETURN);
         | ^~~~~~~~~~~~
   arch/s390/lib/test_modules_helpers.c:8:13: warning: no previous prototype for 'test_modules_return_0023' [-Wmissing-prototypes]
       8 |         int test_modules_return_ ## i(void) \
         |             ^~~~~~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:9:9: note: in expansion of macro 'DEFINE_RETURN'
       9 |         f(x ## 3); \
         |         ^
   arch/s390/lib/test_modules.h:19:9: note: in expansion of macro '__REPEAT_10000_3'
      19 |         __REPEAT_10000_3(f, x ## 2); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:28:9: note: in expansion of macro '__REPEAT_10000_2'
      28 |         __REPEAT_10000_2(f, x ## 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:39:9: note: in expansion of macro '__REPEAT_10000_1'
      39 |         __REPEAT_10000_1(f, 0); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules_helpers.c:13:1: note: in expansion of macro 'REPEAT_10000'
      13 | REPEAT_10000(DEFINE_RETURN);
         | ^~~~~~~~~~~~
   arch/s390/lib/test_modules_helpers.c:8:13: warning: no previous prototype for 'test_modules_return_0024' [-Wmissing-prototypes]
       8 |         int test_modules_return_ ## i(void) \
         |             ^~~~~~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:10:9: note: in expansion of macro 'DEFINE_RETURN'
      10 |         f(x ## 4); \
         |         ^
   arch/s390/lib/test_modules.h:19:9: note: in expansion of macro '__REPEAT_10000_3'
      19 |         __REPEAT_10000_3(f, x ## 2); \
         |         ^~~~~~~~~~~~~~~~
   arch/s390/lib/test_modules.h:28:9: note: in expansion of macro '__REPEAT_10000_2'
      28 |         __REPEAT_10000_2(f, x ## 0); \


vim +/test_modules_return_0000 +8 arch/s390/lib/test_modules_helpers.c

     6	
     7	#define DEFINE_RETURN(i) \
   > 8		int test_modules_return_ ## i(void) \
     9		{ \
    10			return 1 ## i - 10000; \
    11		} \
    12		EXPORT_SYMBOL_GPL(test_modules_return_ ## i)
  > 13	REPEAT_10000(DEFINE_RETURN);

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
