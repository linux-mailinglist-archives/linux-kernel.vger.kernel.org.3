Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95DD15A6626
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 16:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiH3OVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 10:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiH3OVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 10:21:31 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CAE9E887
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 07:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661869291; x=1693405291;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Gab0fQ8LLtkIx4gW6tewqNTGr1n2r4adlax/JGQfgbQ=;
  b=nFXmsMrBw7L/qSmjSMcEvEzQIQSXzX3uf5+GeYPVgzr0ORe5w62LQjHF
   acYKNyTJiuJiC3GbtCh9k4rIN5Whp2EgSvg6Xm+XiB3cEJZ13iHUkQFeh
   eAjTc4igCCiODdMg9eEpwy8Ye2895NrGUCqaDMP3jHWrfVnjf1wQKV0w9
   MtKUrhBnPHwMJjGjDaUM0KSjpnC39SLfD1tdHIRB4ZDId5+WvW9j7Qaqs
   wWp8giVg4Y3hYI2RasLsWZUCM9zgev4mqIhOfk5JlVKi9m/X+AtrUFMSo
   ZifN8PpqcfvDGDFihfGDKIqPkuMoG5D+WRy7KJUctt3eHvelqxQv1ciVR
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="381482571"
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="381482571"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 07:21:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="562659970"
Received: from lkp-server02.sh.intel.com (HELO 77b6d4e16fc5) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 30 Aug 2022 07:21:20 -0700
Received: from kbuild by 77b6d4e16fc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oT27E-0000K5-0N;
        Tue, 30 Aug 2022 14:21:20 +0000
Date:   Tue, 30 Aug 2022 22:20:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [peterz-queue:perf/wip.rewrite 1/8]
 arch/s390/kernel/perf_pai_crypto.c:438:18: error: incompatible function
 pointer types initializing 'void (*)(struct perf_event_pmu_context *, bool)'
 (aka 'void (*)(struct perf_event_pmu_context *, _Bool)') with an expression
 of type 'void (struct perf_eve...
Message-ID: <202208302213.sLzUNO2y-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/wip.rewrite
head:   1a76bb2b00e68728753191bdc81ce890db4dd783
commit: 34b71f229ea6723f8ad70c1a9777f838873b78d0 [1/8] perf: Rewrite core context handling
config: s390-randconfig-r044-20220830 (https://download.01.org/0day-ci/archive/20220830/202208302213.sLzUNO2y-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project c7df82e4693c19e3fd2e25c83eb04d9deb7b7b59)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=34b71f229ea6723f8ad70c1a9777f838873b78d0
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue perf/wip.rewrite
        git checkout 34b71f229ea6723f8ad70c1a9777f838873b78d0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash arch/s390/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/s390/kernel/perf_pai_crypto.c:17:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                                                             ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
   #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
                                                        ^
   In file included from arch/s390/kernel/perf_pai_crypto.c:17:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
   #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
                                                        ^
   In file included from arch/s390/kernel/perf_pai_crypto.c:17:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
>> arch/s390/kernel/perf_pai_crypto.c:438:18: error: incompatible function pointer types initializing 'void (*)(struct perf_event_pmu_context *, bool)' (aka 'void (*)(struct perf_event_pmu_context *, _Bool)') with an expression of type 'void (struct perf_event_context *, bool)' (aka 'void (struct perf_event_context *, _Bool)') [-Wincompatible-function-pointer-types]
           .sched_task   = paicrypt_sched_task,
                           ^~~~~~~~~~~~~~~~~~~
   12 warnings and 1 error generated.


vim +438 arch/s390/kernel/perf_pai_crypto.c

39d62336f5c126 Thomas Richter 2022-05-04  428  
39d62336f5c126 Thomas Richter 2022-05-04  429  /* Performance monitoring unit for mapped counters */
39d62336f5c126 Thomas Richter 2022-05-04  430  static struct pmu paicrypt = {
39d62336f5c126 Thomas Richter 2022-05-04  431  	.task_ctx_nr  = perf_invalid_context,
39d62336f5c126 Thomas Richter 2022-05-04  432  	.event_init   = paicrypt_event_init,
39d62336f5c126 Thomas Richter 2022-05-04  433  	.add	      = paicrypt_add,
39d62336f5c126 Thomas Richter 2022-05-04  434  	.del	      = paicrypt_del,
39d62336f5c126 Thomas Richter 2022-05-04  435  	.start	      = paicrypt_start,
39d62336f5c126 Thomas Richter 2022-05-04  436  	.stop	      = paicrypt_stop,
39d62336f5c126 Thomas Richter 2022-05-04  437  	.read	      = paicrypt_read,
39d62336f5c126 Thomas Richter 2022-05-04 @438  	.sched_task   = paicrypt_sched_task,
39d62336f5c126 Thomas Richter 2022-05-04  439  	.attr_groups  = paicrypt_attr_groups
39d62336f5c126 Thomas Richter 2022-05-04  440  };
39d62336f5c126 Thomas Richter 2022-05-04  441  

:::::: The code at line 438 was first introduced by commit
:::::: 39d62336f5c126ad6dccdf66cd249f2d0e86d3c9 s390/pai: add support for cryptography counters

:::::: TO: Thomas Richter <tmricht@linux.ibm.com>
:::::: CC: Heiko Carstens <hca@linux.ibm.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
