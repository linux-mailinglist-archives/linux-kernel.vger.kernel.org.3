Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26264C3E10
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 06:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237268AbiBYFx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 00:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbiBYFxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 00:53:22 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4B017C415
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 21:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645768369; x=1677304369;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TA/k0CHLCiZ1r5tGqOAV5X4o5ff0zUY5Hb9mZJDsagM=;
  b=AYoqLoa4TP1RDOS/bnjuNEFXH+LpHVcG8kUIzkSO221hHUEbkXSqqu80
   7EuZL6XHv6Mz1yy1w3hf2WZTGvaBAJdBAsr6FvuDtXVMYcz2VGrDWBToG
   TZ1o/FTsh2vyqB33G1UMeFFNc/z6kl03TWX8gsITgTsgH9vdR/r4rpv16
   bialiTxJ1CVOfDkMQP85ZKR11iy6apo0NfZPy45PHlnW1wMQFnWAoSsIM
   LpkN/SWX6rMmMIeSVCqFRh1lixKVQiPiC/Iv7ozVxYjWSwgpsfJ6soXPo
   2yW5LOxumkGX9E4zVWQxvFwzb3P6GLAEf9VOSP0lk39f0tCA9SqZDsdw6
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="313146676"
X-IronPort-AV: E=Sophos;i="5.90,135,1643702400"; 
   d="scan'208";a="313146676"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 21:52:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,135,1643702400"; 
   d="scan'208";a="491875486"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 24 Feb 2022 21:52:46 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNTX3-0003tU-Uf; Fri, 25 Feb 2022 05:52:45 +0000
Date:   Fri, 25 Feb 2022 13:51:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [dinguyen:nios2_for_v5.18 6/6] include/asm-generic/uaccess.h:225:7:
 error: implicit declaration of function 'get_fs'
Message-ID: <202202251308.WOVSZ75H-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git nios2_for_v5.18
head:   048b7695b48a3a4523a7a7fbfedc396b40ccf62f
commit: 048b7695b48a3a4523a7a7fbfedc396b40ccf62f [6/6] uaccess: drop maining CONFIG_SET_FS users
config: hexagon-randconfig-r004-20220225 (https://download.01.org/0day-ci/archive/20220225/202202251308.WOVSZ75H-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git/commit/?id=048b7695b48a3a4523a7a7fbfedc396b40ccf62f
        git remote add dinguyen https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git
        git fetch --no-tags dinguyen nios2_for_v5.18
        git checkout 048b7695b48a3a4523a7a7fbfedc396b40ccf62f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconflicts-sr]
   scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconflicts-rr]
   In file included from arch/hexagon/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:9:
   In file included from include/linux/sched/task.h:11:
   In file included from include/linux/uaccess.h:11:
   In file included from arch/hexagon/include/asm/uaccess.h:60:
>> include/asm-generic/uaccess.h:225:7: error: implicit declaration of function 'get_fs' [-Werror,-Wimplicit-function-declaration]
           if (!access_ok(to, n))
                ^
   include/asm-generic/access_ok.h:48:38: note: expanded from macro 'access_ok'
   #define access_ok(addr, size) likely(__access_ok(addr, size))
                                        ^
   arch/hexagon/include/asm/uaccess.h:36:4: note: expanded from macro '__access_ok'
           ((get_fs().seg == KERNEL_DS.seg) || \
             ^
   In file included from arch/hexagon/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:9:
   In file included from include/linux/sched/task.h:11:
   In file included from include/linux/uaccess.h:11:
   In file included from arch/hexagon/include/asm/uaccess.h:60:
>> include/asm-generic/uaccess.h:225:7: error: member reference base type 'int' is not a structure or union
           if (!access_ok(to, n))
                ^~~~~~~~~~~~~~~~
   include/asm-generic/access_ok.h:48:38: note: expanded from macro 'access_ok'
   #define access_ok(addr, size) likely(__access_ok(addr, size))
                                        ^~~~~~~~~~~~~~~~~~~~~~~
   arch/hexagon/include/asm/uaccess.h:36:12: note: expanded from macro '__access_ok'
           ((get_fs().seg == KERNEL_DS.seg) || \
             ~~~~~~~~^~~~
   include/linux/compiler.h:45:39: note: expanded from macro 'likely'
   #  define likely(x)     (__branch_check__(x, 1, __builtin_constant_p(x)))
                                             ^
   include/linux/compiler.h:33:34: note: expanded from macro '__branch_check__'
                           ______r = __builtin_expect(!!(x), expect);      \
                                                         ^
   In file included from arch/hexagon/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:9:
   In file included from include/linux/sched/task.h:11:
   In file included from include/linux/uaccess.h:11:
   In file included from arch/hexagon/include/asm/uaccess.h:60:
>> include/asm-generic/uaccess.h:225:7: error: use of undeclared identifier 'KERNEL_DS'
   include/asm-generic/access_ok.h:48:38: note: expanded from macro 'access_ok'
   #define access_ok(addr, size) likely(__access_ok(addr, size))
                                        ^
   arch/hexagon/include/asm/uaccess.h:36:20: note: expanded from macro '__access_ok'
           ((get_fs().seg == KERNEL_DS.seg) || \
                             ^
   In file included from arch/hexagon/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:9:
   In file included from include/linux/sched/task.h:11:
   In file included from include/linux/uaccess.h:11:
   In file included from arch/hexagon/include/asm/uaccess.h:60:
>> include/asm-generic/uaccess.h:225:7: error: member reference base type 'int' is not a structure or union
           if (!access_ok(to, n))
                ^~~~~~~~~~~~~~~~
   include/asm-generic/access_ok.h:48:38: note: expanded from macro 'access_ok'
   #define access_ok(addr, size) likely(__access_ok(addr, size))
                                        ^~~~~~~~~~~~~~~~~~~~~~~
   arch/hexagon/include/asm/uaccess.h:37:34: note: expanded from macro '__access_ok'
           (((unsigned long)addr < get_fs().seg) && \
                                   ~~~~~~~~^~~~
   include/linux/compiler.h:45:39: note: expanded from macro 'likely'
   #  define likely(x)     (__branch_check__(x, 1, __builtin_constant_p(x)))
                                             ^
   include/linux/compiler.h:33:34: note: expanded from macro '__branch_check__'
                           ______r = __builtin_expect(!!(x), expect);      \
                                                         ^
   In file included from arch/hexagon/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:9:
   In file included from include/linux/sched/task.h:11:
   In file included from include/linux/uaccess.h:11:
   In file included from arch/hexagon/include/asm/uaccess.h:60:
>> include/asm-generic/uaccess.h:225:7: error: member reference base type 'int' is not a structure or union
           if (!access_ok(to, n))
                ^~~~~~~~~~~~~~~~
   include/asm-generic/access_ok.h:48:38: note: expanded from macro 'access_ok'
   #define access_ok(addr, size) likely(__access_ok(addr, size))
                                        ^~~~~~~~~~~~~~~~~~~~~~~
   arch/hexagon/include/asm/uaccess.h:38:35: note: expanded from macro '__access_ok'
             (unsigned long)size < (get_fs().seg - (unsigned long)addr)))
                                    ~~~~~~~~^~~~
   include/linux/compiler.h:45:39: note: expanded from macro 'likely'
   #  define likely(x)     (__branch_check__(x, 1, __builtin_constant_p(x)))
                                             ^
   include/linux/compiler.h:33:34: note: expanded from macro '__branch_check__'
                           ______r = __builtin_expect(!!(x), expect);      \
                                                         ^
   In file included from arch/hexagon/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:9:
   In file included from include/linux/sched/task.h:11:
   In file included from include/linux/uaccess.h:11:
   In file included from arch/hexagon/include/asm/uaccess.h:60:
>> include/asm-generic/uaccess.h:225:7: error: member reference base type 'int' is not a structure or union
           if (!access_ok(to, n))
                ^~~~~~~~~~~~~~~~
   include/asm-generic/access_ok.h:48:38: note: expanded from macro 'access_ok'
   #define access_ok(addr, size) likely(__access_ok(addr, size))
                                        ^~~~~~~~~~~~~~~~~~~~~~~
   arch/hexagon/include/asm/uaccess.h:36:12: note: expanded from macro '__access_ok'
           ((get_fs().seg == KERNEL_DS.seg) || \
             ~~~~~~~~^~~~
   include/linux/compiler.h:45:66: note: expanded from macro 'likely'
   #  define likely(x)     (__branch_check__(x, 1, __builtin_constant_p(x)))
                                                                        ^
   include/linux/compiler.h:35:19: note: expanded from macro '__branch_check__'
                                                expect, is_constant);      \
                                                        ^~~~~~~~~~~
   In file included from arch/hexagon/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:9:
   In file included from include/linux/sched/task.h:11:
   In file included from include/linux/uaccess.h:11:
   In file included from arch/hexagon/include/asm/uaccess.h:60:
>> include/asm-generic/uaccess.h:225:7: error: use of undeclared identifier 'KERNEL_DS'
   include/asm-generic/access_ok.h:48:38: note: expanded from macro 'access_ok'
   #define access_ok(addr, size) likely(__access_ok(addr, size))
                                        ^
   arch/hexagon/include/asm/uaccess.h:36:20: note: expanded from macro '__access_ok'
           ((get_fs().seg == KERNEL_DS.seg) || \
                             ^
   In file included from arch/hexagon/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:9:
   In file included from include/linux/sched/task.h:11:
   In file included from include/linux/uaccess.h:11:
   In file included from arch/hexagon/include/asm/uaccess.h:60:
>> include/asm-generic/uaccess.h:225:7: error: member reference base type 'int' is not a structure or union
           if (!access_ok(to, n))
                ^~~~~~~~~~~~~~~~
   include/asm-generic/access_ok.h:48:38: note: expanded from macro 'access_ok'
   #define access_ok(addr, size) likely(__access_ok(addr, size))
                                        ^~~~~~~~~~~~~~~~~~~~~~~
   arch/hexagon/include/asm/uaccess.h:37:34: note: expanded from macro '__access_ok'
           (((unsigned long)addr < get_fs().seg) && \
                                   ~~~~~~~~^~~~
   include/linux/compiler.h:45:66: note: expanded from macro 'likely'
   #  define likely(x)     (__branch_check__(x, 1, __builtin_constant_p(x)))
                                                                        ^
   include/linux/compiler.h:35:19: note: expanded from macro '__branch_check__'
                                                expect, is_constant);      \
                                                        ^~~~~~~~~~~
   In file included from arch/hexagon/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:9:
   In file included from include/linux/sched/task.h:11:
   In file included from include/linux/uaccess.h:11:
   In file included from arch/hexagon/include/asm/uaccess.h:60:
>> include/asm-generic/uaccess.h:225:7: error: member reference base type 'int' is not a structure or union
           if (!access_ok(to, n))
                ^~~~~~~~~~~~~~~~
   include/asm-generic/access_ok.h:48:38: note: expanded from macro 'access_ok'
   #define access_ok(addr, size) likely(__access_ok(addr, size))
                                        ^~~~~~~~~~~~~~~~~~~~~~~
   arch/hexagon/include/asm/uaccess.h:38:35: note: expanded from macro '__access_ok'
             (unsigned long)size < (get_fs().seg - (unsigned long)addr)))
                                    ~~~~~~~~^~~~
   include/linux/compiler.h:45:66: note: expanded from macro 'likely'
   #  define likely(x)     (__branch_check__(x, 1, __builtin_constant_p(x)))
                                                                        ^
   include/linux/compiler.h:35:19: note: expanded from macro '__branch_check__'
                                                expect, is_constant);      \
                                                        ^~~~~~~~~~~
   In file included from arch/hexagon/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:9:
   In file included from include/linux/sched/task.h:11:
>> include/linux/uaccess.h:117:40: error: implicit declaration of function 'get_fs' [-Werror,-Wimplicit-function-declaration]
           if (!should_fail_usercopy() && likely(access_ok(from, n))) {
                                                 ^
   include/asm-generic/access_ok.h:48:38: note: expanded from macro 'access_ok'
   #define access_ok(addr, size) likely(__access_ok(addr, size))
                                        ^
   arch/hexagon/include/asm/uaccess.h:36:4: note: expanded from macro '__access_ok'
           ((get_fs().seg == KERNEL_DS.seg) || \
             ^
   In file included from arch/hexagon/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:9:
   In file included from include/linux/sched/task.h:11:
>> include/linux/uaccess.h:117:40: error: member reference base type 'int' is not a structure or union
           if (!should_fail_usercopy() && likely(access_ok(from, n))) {
                                                 ^~~~~~~~~~~~~~~~~~
   include/asm-generic/access_ok.h:48:38: note: expanded from macro 'access_ok'
   #define access_ok(addr, size) likely(__access_ok(addr, size))
                                        ^~~~~~~~~~~~~~~~~~~~~~~
   arch/hexagon/include/asm/uaccess.h:36:12: note: expanded from macro '__access_ok'
           ((get_fs().seg == KERNEL_DS.seg) || \
             ~~~~~~~~^~~~
   include/linux/compiler.h:45:39: note: expanded from macro 'likely'
   #  define likely(x)     (__branch_check__(x, 1, __builtin_constant_p(x)))
                                             ^
   include/linux/compiler.h:33:34: note: expanded from macro '__branch_check__'
                           ______r = __builtin_expect(!!(x), expect);      \
                                                         ^
   include/linux/compiler.h:45:39: note: expanded from macro 'likely'
   #  define likely(x)     (__branch_check__(x, 1, __builtin_constant_p(x)))
                                             ^
   include/linux/compiler.h:33:34: note: expanded from macro '__branch_check__'
                           ______r = __builtin_expect(!!(x), expect);      \
                                                         ^
   In file included from arch/hexagon/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:9:
   In file included from include/linux/sched/task.h:11:
>> include/linux/uaccess.h:117:40: error: use of undeclared identifier 'KERNEL_DS'
   include/asm-generic/access_ok.h:48:38: note: expanded from macro 'access_ok'
   #define access_ok(addr, size) likely(__access_ok(addr, size))
                                        ^
   arch/hexagon/include/asm/uaccess.h:36:20: note: expanded from macro '__access_ok'
           ((get_fs().seg == KERNEL_DS.seg) || \
                             ^
   In file included from arch/hexagon/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:9:
   In file included from include/linux/sched/task.h:11:
>> include/linux/uaccess.h:117:40: error: member reference base type 'int' is not a structure or union
           if (!should_fail_usercopy() && likely(access_ok(from, n))) {
                                                 ^~~~~~~~~~~~~~~~~~
   include/asm-generic/access_ok.h:48:38: note: expanded from macro 'access_ok'
   #define access_ok(addr, size) likely(__access_ok(addr, size))
                                        ^~~~~~~~~~~~~~~~~~~~~~~
   arch/hexagon/include/asm/uaccess.h:37:34: note: expanded from macro '__access_ok'
           (((unsigned long)addr < get_fs().seg) && \
                                   ~~~~~~~~^~~~
   include/linux/compiler.h:45:39: note: expanded from macro 'likely'
   #  define likely(x)     (__branch_check__(x, 1, __builtin_constant_p(x)))
                                             ^
   include/linux/compiler.h:33:34: note: expanded from macro '__branch_check__'
                           ______r = __builtin_expect(!!(x), expect);      \
                                                         ^
   include/linux/compiler.h:45:39: note: expanded from macro 'likely'
   #  define likely(x)     (__branch_check__(x, 1, __builtin_constant_p(x)))
                                             ^
   include/linux/compiler.h:33:34: note: expanded from macro '__branch_check__'
                           ______r = __builtin_expect(!!(x), expect);      \
                                                         ^
   In file included from arch/hexagon/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:9:
   In file included from include/linux/sched/task.h:11:
>> include/linux/uaccess.h:117:40: error: member reference base type 'int' is not a structure or union
           if (!should_fail_usercopy() && likely(access_ok(from, n))) {
                                                 ^~~~~~~~~~~~~~~~~~
   include/asm-generic/access_ok.h:48:38: note: expanded from macro 'access_ok'
   #define access_ok(addr, size) likely(__access_ok(addr, size))
                                        ^~~~~~~~~~~~~~~~~~~~~~~
   arch/hexagon/include/asm/uaccess.h:38:35: note: expanded from macro '__access_ok'
             (unsigned long)size < (get_fs().seg - (unsigned long)addr)))
                                    ~~~~~~~~^~~~
   include/linux/compiler.h:45:39: note: expanded from macro 'likely'
   #  define likely(x)     (__branch_check__(x, 1, __builtin_constant_p(x)))
                                             ^
   include/linux/compiler.h:33:34: note: expanded from macro '__branch_check__'
                           ______r = __builtin_expect(!!(x), expect);      \
                                                         ^
   include/linux/compiler.h:45:39: note: expanded from macro 'likely'
   #  define likely(x)     (__branch_check__(x, 1, __builtin_constant_p(x)))
                                             ^
   include/linux/compiler.h:33:34: note: expanded from macro '__branch_check__'
                           ______r = __builtin_expect(!!(x), expect);      \
                                                         ^
   In file included from arch/hexagon/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:9:
   In file included from include/linux/sched/task.h:11:
>> include/linux/uaccess.h:117:40: error: member reference base type 'int' is not a structure or union
           if (!should_fail_usercopy() && likely(access_ok(from, n))) {
                                                 ^~~~~~~~~~~~~~~~~~
   include/asm-generic/access_ok.h:48:38: note: expanded from macro 'access_ok'
   #define access_ok(addr, size) likely(__access_ok(addr, size))
                                        ^~~~~~~~~~~~~~~~~~~~~~~
   arch/hexagon/include/asm/uaccess.h:36:12: note: expanded from macro '__access_ok'
           ((get_fs().seg == KERNEL_DS.seg) || \
             ~~~~~~~~^~~~
   include/linux/compiler.h:45:66: note: expanded from macro 'likely'
   #  define likely(x)     (__branch_check__(x, 1, __builtin_constant_p(x)))
                                                                        ^
   include/linux/compiler.h:35:19: note: expanded from macro '__branch_check__'
                                                expect, is_constant);      \
                                                        ^~~~~~~~~~~
   include/linux/compiler.h:45:39: note: expanded from macro 'likely'
   #  define likely(x)     (__branch_check__(x, 1, __builtin_constant_p(x)))
                                             ^
   include/linux/compiler.h:33:34: note: expanded from macro '__branch_check__'
                           ______r = __builtin_expect(!!(x), expect);      \
                                                         ^
   In file included from arch/hexagon/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:9:
   In file included from include/linux/sched/task.h:11:
>> include/linux/uaccess.h:117:40: error: use of undeclared identifier 'KERNEL_DS'
   include/asm-generic/access_ok.h:48:38: note: expanded from macro 'access_ok'
   #define access_ok(addr, size) likely(__access_ok(addr, size))
                                        ^
   arch/hexagon/include/asm/uaccess.h:36:20: note: expanded from macro '__access_ok'
           ((get_fs().seg == KERNEL_DS.seg) || \
                             ^
   In file included from arch/hexagon/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:9:
   In file included from include/linux/sched/task.h:11:
>> include/linux/uaccess.h:117:40: error: member reference base type 'int' is not a structure or union
           if (!should_fail_usercopy() && likely(access_ok(from, n))) {
                                                 ^~~~~~~~~~~~~~~~~~
   include/asm-generic/access_ok.h:48:38: note: expanded from macro 'access_ok'
   #define access_ok(addr, size) likely(__access_ok(addr, size))
                                        ^~~~~~~~~~~~~~~~~~~~~~~
   arch/hexagon/include/asm/uaccess.h:37:34: note: expanded from macro '__access_ok'
           (((unsigned long)addr < get_fs().seg) && \
                                   ~~~~~~~~^~~~
   include/linux/compiler.h:45:66: note: expanded from macro 'likely'
   #  define likely(x)     (__branch_check__(x, 1, __builtin_constant_p(x)))
                                                                        ^
   include/linux/compiler.h:35:19: note: expanded from macro '__branch_check__'
                                                expect, is_constant);      \
                                                        ^~~~~~~~~~~
   include/linux/compiler.h:45:39: note: expanded from macro 'likely'
   #  define likely(x)     (__branch_check__(x, 1, __builtin_constant_p(x)))
                                             ^
   include/linux/compiler.h:33:34: note: expanded from macro '__branch_check__'
                           ______r = __builtin_expect(!!(x), expect);      \
                                                         ^
   In file included from arch/hexagon/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:9:
   In file included from include/linux/sched/task.h:11:
>> include/linux/uaccess.h:117:40: error: member reference base type 'int' is not a structure or union
           if (!should_fail_usercopy() && likely(access_ok(from, n))) {
                                                 ^~~~~~~~~~~~~~~~~~
   include/asm-generic/access_ok.h:48:38: note: expanded from macro 'access_ok'
   #define access_ok(addr, size) likely(__access_ok(addr, size))
                                        ^~~~~~~~~~~~~~~~~~~~~~~
   arch/hexagon/include/asm/uaccess.h:38:35: note: expanded from macro '__access_ok'
             (unsigned long)size < (get_fs().seg - (unsigned long)addr)))
                                    ~~~~~~~~^~~~
   include/linux/compiler.h:45:66: note: expanded from macro 'likely'
   #  define likely(x)     (__branch_check__(x, 1, __builtin_constant_p(x)))
                                                                        ^
   include/linux/compiler.h:35:19: note: expanded from macro '__branch_check__'
                                                expect, is_constant);      \
                                                        ^~~~~~~~~~~
   include/linux/compiler.h:45:39: note: expanded from macro 'likely'
   #  define likely(x)     (__branch_check__(x, 1, __builtin_constant_p(x)))
                                             ^
   include/linux/compiler.h:33:34: note: expanded from macro '__branch_check__'
                           ______r = __builtin_expect(!!(x), expect);      \
                                                         ^
   In file included from arch/hexagon/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:9:
   In file included from include/linux/sched/task.h:11:
>> include/linux/uaccess.h:117:40: error: implicit declaration of function 'get_fs' [-Werror,-Wimplicit-function-declaration]
   include/asm-generic/access_ok.h:48:38: note: expanded from macro 'access_ok'
   #define access_ok(addr, size) likely(__access_ok(addr, size))
                                        ^
   arch/hexagon/include/asm/uaccess.h:36:4: note: expanded from macro '__access_ok'
           ((get_fs().seg == KERNEL_DS.seg) || \
             ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   20 errors generated.
   make[2]: *** [scripts/Makefile.build:121: arch/hexagon/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1191: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/get_fs +225 include/asm-generic/uaccess.h

eed417ddd52146 Arnd Bergmann      2009-05-13  220  
eed417ddd52146 Arnd Bergmann      2009-05-13  221  static inline __must_check unsigned long
eed417ddd52146 Arnd Bergmann      2009-05-13  222  clear_user(void __user *to, unsigned long n)
eed417ddd52146 Arnd Bergmann      2009-05-13  223  {
e0acd0bd059416 Michael S. Tsirkin 2013-05-26  224  	might_fault();
96d4f267e40f95 Linus Torvalds     2019-01-03 @225  	if (!access_ok(to, n))
eed417ddd52146 Arnd Bergmann      2009-05-13  226  		return n;
eed417ddd52146 Arnd Bergmann      2009-05-13  227  
eed417ddd52146 Arnd Bergmann      2009-05-13  228  	return __clear_user(to, n);
eed417ddd52146 Arnd Bergmann      2009-05-13  229  }
eed417ddd52146 Arnd Bergmann      2009-05-13  230  

:::::: The code at line 225 was first introduced by commit
:::::: 96d4f267e40f9509e8a66e2b39e8b95655617693 Remove 'type' argument from access_ok() function

:::::: TO: Linus Torvalds <torvalds@linux-foundation.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
