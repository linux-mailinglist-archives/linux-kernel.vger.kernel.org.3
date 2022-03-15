Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394C44DA017
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 17:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350067AbiCOQbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 12:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241640AbiCOQbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 12:31:20 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34EC57141
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 09:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647361807; x=1678897807;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Da2k6eW98vruEKeM8z2Ow1a0M/FYP+28YcrLDcmE30Y=;
  b=jHQtXPRz5DbpCGCp69nfdwO9A8Z5zsG+JVdDfmarxbESo/kH0cU5qTB4
   IyhPb1MKsFCQe/oQYSPmtm0CFDehaHYWnqpS2xY/uHL+V57lWIAbcvKRg
   ImggaV41dtAtOhbuPdzL4rUUcqYjlvshSNl5VjYddvQfH4CFjPcniDsP2
   gVf9nr1tzW2s/b6BTkeTlRSdcFIAhKnIFgCE1GqFjjyLxlh9VtsXzDJ7b
   0Pg/Akxjjt6w6Q4WbfCgupG28ax42f3yn8oJ3ElLU3F13V9SZflZGs3U7
   x2Y2iMkKSyyXHGBQeWFGXHA5lVTcbYjq/rkCYelUmjzRy/4vC+ZhV11I5
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="238519201"
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="238519201"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 09:30:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="557003551"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 15 Mar 2022 09:30:06 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUA3i-000BD5-7L; Tue, 15 Mar 2022 16:30:06 +0000
Date:   Wed, 16 Mar 2022 00:29:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 626/2335] include/asm-generic/barrier.h:16:10:
 fatal error: asm/vdso/processor.h: No such file or directory
Message-ID: <202203160030.wPWzftrx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   85293bf3fca6d85608cff1447ce3097583f15fab
commit: 708c40d754d1dc6e28031a2c4d86adce8f27b85b [626/2335] headers/deps: Add header dependencies to .h files: <asm/vdso/processor.h>
config: nds32-allnoconfig (https://download.01.org/0day-ci/archive/20220316/202203160030.wPWzftrx-lkp@intel.com/config)
compiler: nds32le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=708c40d754d1dc6e28031a2c4d86adce8f27b85b
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout 708c40d754d1dc6e28031a2c4d86adce8f27b85b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/nds32/include/asm/barrier.h:11,
                    from arch/nds32/include/asm/nds32.h:12,
                    from arch/nds32/include/asm/irqflags.h:4,
                    from include/linux/irqflags.h:16,
                    from include/asm-generic/bitops.h:14,
                    from ./arch/nds32/include/generated/asm/bitops.h:1,
                    from include/linux/bitops.h:28,
                    from include/linux/log2.h:12,
                    from kernel/bounds.c:13:
>> include/asm-generic/barrier.h:16:10: fatal error: asm/vdso/processor.h: No such file or directory
      16 | #include <asm/vdso/processor.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.
   make[2]: *** [scripts/Makefile.build:121: kernel/bounds.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1191: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +16 include/asm-generic/barrier.h

    15	
  > 16	#include <asm/vdso/processor.h>
    17	#include <linux/compiler.h>
    18	#include <linux/kcsan-checks.h>
    19	#include <asm/rwonce.h>
    20	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
