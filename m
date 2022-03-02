Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DAC4C9B80
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 03:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239181AbiCBCwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 21:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239165AbiCBCwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 21:52:18 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC2DAA2D7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 18:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646189496; x=1677725496;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iKL8VzAcdqc8mQmAFMZqc0dAz64uVOQbPqx2+7Bctbw=;
  b=j/gfnTrEHGLEznozfPEq/onxe+9JTLwEd+2H5qemFJ8zoVl+CTW3qQeC
   KLxdKiE4s2rn/gS9BLr3OakaxyrZylSCsnR7QTvzUGGxkZJovhcpHl4yJ
   PI9Rybb7fBjyKP3U1sVlu6I52xSI8wzWVFOajQEWrtjTnUX/7I4tsxdPG
   ugiKEglQfJm/rTp/VuRQRi0E3VI9iA8YCc4hClAviqSV9AUYU3GbzoLrd
   7wjZYPcXcgYP6n2NolgPMalaekmOSnQPlNA6mtluJHKgHAtdTCeBi0XUD
   1qTelInMhhO/NoAuhQYodYF5ZbACT4EdjSeAZWGZCl6s+SmhVek9nuCeA
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="253219461"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="253219461"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 18:51:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="551041637"
Received: from lkp-server02.sh.intel.com (HELO e9605edfa585) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 01 Mar 2022 18:51:34 -0800
Received: from kbuild by e9605edfa585 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPF5R-0000wV-K8; Wed, 02 Mar 2022 02:51:33 +0000
Date:   Wed, 2 Mar 2022 10:51:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:crng/random/jd/notifier 54/55]
 include/linux/notifier.h:75:15: error: field has incomplete type 'struct
 mutex'
Message-ID: <202203020718.3ho17ASv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block crng/random/jd/notifier
head:   3c87f9e874ba4807cbb5473bab3eb5c2f5d716db
commit: d8ac9430b0435d0f09b5c909f80f8980183c93d1 [54/55] random: replace custom notifier chain with standard one
config: arm64-randconfig-r022-20220301 (https://download.01.org/0day-ci/archive/20220302/202203020718.3ho17ASv-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/d8ac9430b0435d0f09b5c909f80f8980183c93d1
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block crng/random/jd/notifier
        git checkout d8ac9430b0435d0f09b5c909f80f8980183c93d1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/arm64/kernel/asm-offsets.c:10:
   In file included from include/linux/arm_sdei.h:8:
   In file included from include/acpi/ghes.h:5:
   In file included from include/acpi/apei.h:9:
   In file included from include/linux/acpi.h:13:
   In file included from include/linux/irqdomain.h:35:
   In file included from include/linux/of.h:17:
   In file included from include/linux/kobject.h:20:
   In file included from include/linux/sysfs.h:16:
   In file included from include/linux/kernfs.h:11:
   In file included from include/linux/mutex.h:19:
   In file included from arch/arm64/include/asm/processor.h:42:
   In file included from arch/arm64/include/asm/pointer_auth.h:7:
   In file included from include/linux/random.h:10:
   In file included from include/linux/notifier.h:16:
   In file included from include/linux/srcu.h:49:
>> include/linux/srcutree.h:68:15: error: field has incomplete type 'struct mutex'
           struct mutex srcu_cb_mutex;             /* Serialize CB preparation. */
                        ^
   include/linux/srcutree.h:68:9: note: forward declaration of 'struct mutex'
           struct mutex srcu_cb_mutex;             /* Serialize CB preparation. */
                  ^
   include/linux/srcutree.h:70:15: error: field has incomplete type 'struct mutex'
           struct mutex srcu_gp_mutex;             /* Serialize GP work. */
                        ^
   include/linux/srcutree.h:68:9: note: forward declaration of 'struct mutex'
           struct mutex srcu_cb_mutex;             /* Serialize CB preparation. */
                  ^
   include/linux/srcutree.h:78:15: error: field has incomplete type 'struct mutex'
           struct mutex srcu_barrier_mutex;        /* Serialize barrier ops. */
                        ^
   include/linux/srcutree.h:68:9: note: forward declaration of 'struct mutex'
           struct mutex srcu_cb_mutex;             /* Serialize CB preparation. */
                  ^
   In file included from arch/arm64/kernel/asm-offsets.c:10:
   In file included from include/linux/arm_sdei.h:8:
   In file included from include/acpi/ghes.h:5:
   In file included from include/acpi/apei.h:9:
   In file included from include/linux/acpi.h:13:
   In file included from include/linux/irqdomain.h:35:
   In file included from include/linux/of.h:17:
   In file included from include/linux/kobject.h:20:
   In file included from include/linux/sysfs.h:16:
   In file included from include/linux/kernfs.h:11:
   In file included from include/linux/mutex.h:19:
   In file included from arch/arm64/include/asm/processor.h:42:
   In file included from arch/arm64/include/asm/pointer_auth.h:7:
   In file included from include/linux/random.h:10:
>> include/linux/notifier.h:75:15: error: field has incomplete type 'struct mutex'
           struct mutex mutex;
                        ^
   include/linux/srcutree.h:68:9: note: forward declaration of 'struct mutex'
           struct mutex srcu_cb_mutex;             /* Serialize CB preparation. */
                  ^
   4 errors generated.
   make[2]: *** [scripts/Makefile.build:121: arch/arm64/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1191: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +75 include/linux/notifier.h

e041c683412d5b Alan Stern    2006-03-27  73  
eabc069401bcf4 Alan Stern    2006-10-04  74  struct srcu_notifier_head {
eabc069401bcf4 Alan Stern    2006-10-04 @75  	struct mutex mutex;
eabc069401bcf4 Alan Stern    2006-10-04  76  	struct srcu_struct srcu;
374a8e0dc33c98 Arnd Bergmann 2010-02-24  77  	struct notifier_block __rcu *head;
eabc069401bcf4 Alan Stern    2006-10-04  78  };
eabc069401bcf4 Alan Stern    2006-10-04  79  

:::::: The code at line 75 was first introduced by commit
:::::: eabc069401bcf45bcc3f19e643017bf761780aa8 [PATCH] Add SRCU-based notifier chains

:::::: TO: Alan Stern <stern@rowland.harvard.edu>
:::::: CC: Linus Torvalds <torvalds@g5.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
