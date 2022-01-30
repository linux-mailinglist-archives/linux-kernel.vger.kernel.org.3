Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B74614A3AB0
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 23:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356423AbiA3W26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 17:28:58 -0500
Received: from mga11.intel.com ([192.55.52.93]:29413 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233751AbiA3W24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 17:28:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643581736; x=1675117736;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KNbanrW5Y2SISPRQshbDtfjJ7LwU6KsPATMwtjqXW2M=;
  b=P8sjkWE9k/nsdKAgFBzmj7w9/KF+imiuH2VL0SuTp8RmKzvFAY3iQtAB
   72h8LdDwttMlbi1K6MCRF9HfkQqbm+lzlR9K+YZD2VkxYbfBCvV61eUN3
   kG5RLbh9/8sRDbcvPNan8peRDjGhTslXnTRhCz6yhs/uGf+PAAD1i766c
   nA58VfQPC4UizwTfrfv1g+5C3zdwFeXyqXWLpwxWMACqswKKr0YcQIXsK
   cbeDafh8IfMcJPp30bcvD5CZiPzKiCk+VwKFfeOpwxLGdSdKdSfo3JDXX
   FzXkGFaMk6hnFlhsiG1pNVJyZXPFZ3fD4ifq1RdgpqXyWri2A79nxFLgt
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="244973257"
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="244973257"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 14:28:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="582446670"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 30 Jan 2022 14:28:54 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEIgn-000R3W-TX; Sun, 30 Jan 2022 22:28:53 +0000
Date:   Mon, 31 Jan 2022 06:28:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>
Subject: arch/s390/lib/test_modules_helpers.c:13:14: warning: no previous
 prototype for function 'test_modules_return_0000'
Message-ID: <202201310518.38Y3LnES-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cb323ee75d24e7acc2f188d123ba6df46159cf09
commit: 90c5318795eefa09a9f9aef8d18a904e24962b5c s390/module: test loading modules with a lot of relocations
date:   7 days ago
config: s390-randconfig-r002-20220129 (https://download.01.org/0day-ci/archive/20220131/202201310518.38Y3LnES-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 33b45ee44b1f32ffdbc995e6fec806271b4b3ba4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=90c5318795eefa09a9f9aef8d18a904e24962b5c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 90c5318795eefa09a9f9aef8d18a904e24962b5c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/s390/lib/test_modules_helpers.c:13:14: warning: no previous prototype for function 'test_modules_return_0000' [-Wmissing-prototypes]
   REPEAT_10000(DEFINE_RETURN);
                ^
   arch/s390/lib/test_modules_helpers.c:13:14: note: declare 'static' if the function is not intended to be used outside of this translation unit
   REPEAT_10000(DEFINE_RETURN);
                ^
   static 
   arch/s390/lib/test_modules.h:39:19: note: expanded from macro 'REPEAT_10000'
           __REPEAT_10000_1(f, 0); \
                            ^
   arch/s390/lib/test_modules.h:28:19: note: expanded from macro '__REPEAT_10000_1'
           __REPEAT_10000_2(f, x ## 0); \
                            ^
   arch/s390/lib/test_modules.h:17:19: note: expanded from macro '__REPEAT_10000_2'
           __REPEAT_10000_3(f, x ## 0); \
                            ^
   arch/s390/lib/test_modules.h:6:2: note: expanded from macro '__REPEAT_10000_3'
           f(x ## 0); \
           ^
   arch/s390/lib/test_modules_helpers.c:8:2: note: expanded from macro 'DEFINE_RETURN'
           int test_modules_return_ ## i(void) \
           ^
>> arch/s390/lib/test_modules_helpers.c:13:14: warning: no previous prototype for function 'test_modules_return_0001' [-Wmissing-prototypes]
   REPEAT_10000(DEFINE_RETURN);
                ^
   arch/s390/lib/test_modules_helpers.c:13:14: note: declare 'static' if the function is not intended to be used outside of this translation unit
>> arch/s390/lib/test_modules_helpers.c:13:14: warning: no previous prototype for function 'test_modules_return_0002' [-Wmissing-prototypes]
   REPEAT_10000(DEFINE_RETURN);
                ^
   arch/s390/lib/test_modules_helpers.c:13:14: note: declare 'static' if the function is not intended to be used outside of this translation unit
>> arch/s390/lib/test_modules_helpers.c:13:14: warning: no previous prototype for function 'test_modules_return_0003' [-Wmissing-prototypes]
   REPEAT_10000(DEFINE_RETURN);
                ^
   arch/s390/lib/test_modules_helpers.c:13:14: note: declare 'static' if the function is not intended to be used outside of this translation unit
>> arch/s390/lib/test_modules_helpers.c:13:14: warning: no previous prototype for function 'test_modules_return_0004' [-Wmissing-prototypes]
   REPEAT_10000(DEFINE_RETURN);
                ^
   arch/s390/lib/test_modules_helpers.c:13:14: note: declare 'static' if the function is not intended to be used outside of this translation unit
>> arch/s390/lib/test_modules_helpers.c:13:14: warning: no previous prototype for function 'test_modules_return_0005' [-Wmissing-prototypes]
   REPEAT_10000(DEFINE_RETURN);
                ^
   arch/s390/lib/test_modules_helpers.c:13:14: note: declare 'static' if the function is not intended to be used outside of this translation unit
>> arch/s390/lib/test_modules_helpers.c:13:14: warning: no previous prototype for function 'test_modules_return_0006' [-Wmissing-prototypes]
   REPEAT_10000(DEFINE_RETURN);
                ^
   arch/s390/lib/test_modules_helpers.c:13:14: note: declare 'static' if the function is not intended to be used outside of this translation unit
>> arch/s390/lib/test_modules_helpers.c:13:14: warning: no previous prototype for function 'test_modules_return_0007' [-Wmissing-prototypes]
   REPEAT_10000(DEFINE_RETURN);
                ^
   arch/s390/lib/test_modules_helpers.c:13:14: note: declare 'static' if the function is not intended to be used outside of this translation unit
>> arch/s390/lib/test_modules_helpers.c:13:14: warning: no previous prototype for function 'test_modules_return_0008' [-Wmissing-prototypes]
   REPEAT_10000(DEFINE_RETURN);
                ^
   arch/s390/lib/test_modules_helpers.c:13:14: note: declare 'static' if the function is not intended to be used outside of this translation unit
>> arch/s390/lib/test_modules_helpers.c:13:14: warning: no previous prototype for function 'test_modules_return_0009' [-Wmissing-prototypes]
   REPEAT_10000(DEFINE_RETURN);
                ^
   arch/s390/lib/test_modules_helpers.c:13:14: note: declare 'static' if the function is not intended to be used outside of this translation unit
>> arch/s390/lib/test_modules_helpers.c:13:14: warning: no previous prototype for function 'test_modules_return_0010' [-Wmissing-prototypes]
   REPEAT_10000(DEFINE_RETURN);
                ^
   arch/s390/lib/test_modules_helpers.c:13:14: note: declare 'static' if the function is not intended to be used outside of this translation unit
>> arch/s390/lib/test_modules_helpers.c:13:14: warning: no previous prototype for function 'test_modules_return_0011' [-Wmissing-prototypes]
   REPEAT_10000(DEFINE_RETURN);
                ^
   arch/s390/lib/test_modules_helpers.c:13:14: note: declare 'static' if the function is not intended to be used outside of this translation unit
>> arch/s390/lib/test_modules_helpers.c:13:14: warning: no previous prototype for function 'test_modules_return_0012' [-Wmissing-prototypes]
   REPEAT_10000(DEFINE_RETURN);
                ^
   arch/s390/lib/test_modules_helpers.c:13:14: note: declare 'static' if the function is not intended to be used outside of this translation unit
>> arch/s390/lib/test_modules_helpers.c:13:14: warning: no previous prototype for function 'test_modules_return_0013' [-Wmissing-prototypes]
   REPEAT_10000(DEFINE_RETURN);
                ^
   arch/s390/lib/test_modules_helpers.c:13:14: note: declare 'static' if the function is not intended to be used outside of this translation unit
>> arch/s390/lib/test_modules_helpers.c:13:14: warning: no previous prototype for function 'test_modules_return_0014' [-Wmissing-prototypes]
   REPEAT_10000(DEFINE_RETURN);
                ^
   arch/s390/lib/test_modules_helpers.c:13:14: note: declare 'static' if the function is not intended to be used outside of this translation unit
>> arch/s390/lib/test_modules_helpers.c:13:14: warning: no previous prototype for function 'test_modules_return_0015' [-Wmissing-prototypes]
   REPEAT_10000(DEFINE_RETURN);
                ^
   arch/s390/lib/test_modules_helpers.c:13:14: note: declare 'static' if the function is not intended to be used outside of this translation unit
>> arch/s390/lib/test_modules_helpers.c:13:14: warning: no previous prototype for function 'test_modules_return_0016' [-Wmissing-prototypes]
   REPEAT_10000(DEFINE_RETURN);
                ^
   arch/s390/lib/test_modules_helpers.c:13:14: note: declare 'static' if the function is not intended to be used outside of this translation unit
>> arch/s390/lib/test_modules_helpers.c:13:14: warning: no previous prototype for function 'test_modules_return_0017' [-Wmissing-prototypes]
   REPEAT_10000(DEFINE_RETURN);
                ^
   arch/s390/lib/test_modules_helpers.c:13:14: note: declare 'static' if the function is not intended to be used outside of this translation unit
>> arch/s390/lib/test_modules_helpers.c:13:14: warning: no previous prototype for function 'test_modules_return_0018' [-Wmissing-prototypes]
   REPEAT_10000(DEFINE_RETURN);
                ^
   arch/s390/lib/test_modules_helpers.c:13:14: note: declare 'static' if the function is not intended to be used outside of this translation unit
>> arch/s390/lib/test_modules_helpers.c:13:14: warning: no previous prototype for function 'test_modules_return_0019' [-Wmissing-prototypes]
   REPEAT_10000(DEFINE_RETURN);
                ^
   arch/s390/lib/test_modules_helpers.c:13:14: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/s390/lib/test_modules_helpers.c:13:14: warning: no previous prototype for function 'test_modules_return_0020' [-Wmissing-prototypes]
   REPEAT_10000(DEFINE_RETURN);
                ^
   arch/s390/lib/test_modules_helpers.c:13:14: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/s390/lib/test_modules_helpers.c:13:14: warning: no previous prototype for function 'test_modules_return_0021' [-Wmissing-prototypes]
   REPEAT_10000(DEFINE_RETURN);
                ^
   arch/s390/lib/test_modules_helpers.c:13:14: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/s390/lib/test_modules_helpers.c:13:14: warning: no previous prototype for function 'test_modules_return_0022' [-Wmissing-prototypes]
   REPEAT_10000(DEFINE_RETURN);
                ^
   arch/s390/lib/test_modules_helpers.c:13:14: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/s390/lib/test_modules_helpers.c:13:14: warning: no previous prototype for function 'test_modules_return_0023' [-Wmissing-prototypes]
   REPEAT_10000(DEFINE_RETURN);
                ^
   arch/s390/lib/test_modules_helpers.c:13:14: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/s390/lib/test_modules_helpers.c:13:14: warning: no previous prototype for function 'test_modules_return_0024' [-Wmissing-prototypes]
   REPEAT_10000(DEFINE_RETURN);
                ^
   arch/s390/lib/test_modules_helpers.c:13:14: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/s390/lib/test_modules_helpers.c:13:14: warning: no previous prototype for function 'test_modules_return_0025' [-Wmissing-prototypes]
   REPEAT_10000(DEFINE_RETURN);
                ^
   arch/s390/lib/test_modules_helpers.c:13:14: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/s390/lib/test_modules_helpers.c:13:14: warning: no previous prototype for function 'test_modules_return_0026' [-Wmissing-prototypes]
   REPEAT_10000(DEFINE_RETURN);
                ^
   arch/s390/lib/test_modules_helpers.c:13:14: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/s390/lib/test_modules_helpers.c:13:14: warning: no previous prototype for function 'test_modules_return_0027' [-Wmissing-prototypes]
   REPEAT_10000(DEFINE_RETURN);
                ^
   arch/s390/lib/test_modules_helpers.c:13:14: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/s390/lib/test_modules_helpers.c:13:14: warning: no previous prototype for function 'test_modules_return_0028' [-Wmissing-prototypes]
   REPEAT_10000(DEFINE_RETURN);
                ^
   arch/s390/lib/test_modules_helpers.c:13:14: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/s390/lib/test_modules_helpers.c:13:14: warning: no previous prototype for function 'test_modules_return_0029' [-Wmissing-prototypes]
   REPEAT_10000(DEFINE_RETURN);
                ^
   arch/s390/lib/test_modules_helpers.c:13:14: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/s390/lib/test_modules_helpers.c:13:14: warning: no previous prototype for function 'test_modules_return_0030' [-Wmissing-prototypes]
   REPEAT_10000(DEFINE_RETURN);
                ^
   arch/s390/lib/test_modules_helpers.c:13:14: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/s390/lib/test_modules_helpers.c:13:14: warning: no previous prototype for function 'test_modules_return_0031' [-Wmissing-prototypes]
   REPEAT_10000(DEFINE_RETURN);
                ^
   arch/s390/lib/test_modules_helpers.c:13:14: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/s390/lib/test_modules_helpers.c:13:14: warning: no previous prototype for function 'test_modules_return_0032' [-Wmissing-prototypes]
   REPEAT_10000(DEFINE_RETURN);
                ^
   arch/s390/lib/test_modules_helpers.c:13:14: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/s390/lib/test_modules_helpers.c:13:14: warning: no previous prototype for function 'test_modules_return_0033' [-Wmissing-prototypes]
   REPEAT_10000(DEFINE_RETURN);
                ^
   arch/s390/lib/test_modules_helpers.c:13:14: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/s390/lib/test_modules_helpers.c:13:14: warning: no previous prototype for function 'test_modules_return_0034' [-Wmissing-prototypes]
   REPEAT_10000(DEFINE_RETURN);
                ^
   arch/s390/lib/test_modules_helpers.c:13:14: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/s390/lib/test_modules_helpers.c:13:14: warning: no previous prototype for function 'test_modules_return_0035' [-Wmissing-prototypes]
   REPEAT_10000(DEFINE_RETURN);
                ^
   arch/s390/lib/test_modules_helpers.c:13:14: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/s390/lib/test_modules_helpers.c:13:14: warning: no previous prototype for function 'test_modules_return_0036' [-Wmissing-prototypes]
   REPEAT_10000(DEFINE_RETURN);
                ^
   arch/s390/lib/test_modules_helpers.c:13:14: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/s390/lib/test_modules_helpers.c:13:14: warning: no previous prototype for function 'test_modules_return_0037' [-Wmissing-prototypes]
   REPEAT_10000(DEFINE_RETURN);
                ^
   arch/s390/lib/test_modules_helpers.c:13:14: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/s390/lib/test_modules_helpers.c:13:14: warning: no previous prototype for function 'test_modules_return_0038' [-Wmissing-prototypes]
   REPEAT_10000(DEFINE_RETURN);
                ^
   arch/s390/lib/test_modules_helpers.c:13:14: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/s390/lib/test_modules_helpers.c:13:14: warning: no previous prototype for function 'test_modules_return_0039' [-Wmissing-prototypes]
   REPEAT_10000(DEFINE_RETURN);
                ^
   arch/s390/lib/test_modules_helpers.c:13:14: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/s390/lib/test_modules_helpers.c:13:14: warning: no previous prototype for function 'test_modules_return_0040' [-Wmissing-prototypes]
   REPEAT_10000(DEFINE_RETURN);
                ^
   arch/s390/lib/test_modules_helpers.c:13:14: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/s390/lib/test_modules_helpers.c:13:14: warning: no previous prototype for function 'test_modules_return_0041' [-Wmissing-prototypes]
   REPEAT_10000(DEFINE_RETURN);
                ^
   arch/s390/lib/test_modules_helpers.c:13:14: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/s390/lib/test_modules_helpers.c:13:14: warning: no previous prototype for function 'test_modules_return_0042' [-Wmissing-prototypes]
   REPEAT_10000(DEFINE_RETURN);
                ^
   arch/s390/lib/test_modules_helpers.c:13:14: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/s390/lib/test_modules_helpers.c:13:14: warning: no previous prototype for function 'test_modules_return_0043' [-Wmissing-prototypes]
   REPEAT_10000(DEFINE_RETURN);
                ^
   arch/s390/lib/test_modules_helpers.c:13:14: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/s390/lib/test_modules_helpers.c:13:14: warning: no previous prototype for function 'test_modules_return_0044' [-Wmissing-prototypes]


vim +/test_modules_return_0000 +13 arch/s390/lib/test_modules_helpers.c

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
