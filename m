Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48AFB4BD1CD
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 22:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245075AbiBTVNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 16:13:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242699AbiBTVNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 16:13:15 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE125E48
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 13:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645391573; x=1676927573;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kDvBkajyuI0yMdhFNn9L6trMYaOtPexxgVyu4XYgKR0=;
  b=AAz78Mvt7KWByf9zz7Krex+sXk1n9ZD1ydRyQ21BnGF87ba6uOng11xa
   48yxT4kCC0RmB5NuzERgw/APYIRjNe6A8DC9p1NUO09A3fB7nuRC/0pjY
   jCqFg7jnakDDVFrQ9qhI7GUHbHXznvoG9UabWRMs4uzo/apHZ44tv5uUj
   zxbrCE8hOsZhCOUPV1REy8hsEm97rxobdiNZPcMnSSrFGJs0QA4bRKYeb
   wAvTV3i8WwW9llHUg5FSpadFbKYV8hFzjDjw9FHZuyhbVuMfHOFm5fZMg
   zSOI2AdeXq0Tzx1dM2ndIZ+xy5qynJG0q+6lBlDbSUCtUV2VcmI2sV6wX
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="250221609"
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="250221609"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 13:12:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="504639535"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 20 Feb 2022 13:12:51 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLtVj-0000lz-5N; Sun, 20 Feb 2022 21:12:51 +0000
Date:   Mon, 21 Feb 2022 05:12:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 643/2574]
 include/asm-generic/barrier.h:16:10: fatal error: 'asm/vdso/processor.h'
 file not found
Message-ID: <202202210526.ll6ZQU7s-lkp@intel.com>
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

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   39e8a0edc8fae20758051dadf7846849edc18b88
commit: 121f4f0dd58c5fa0666a732d13b7ad770af3559b [643/2574] headers/deps: Add header dependencies to .h files: <asm/vdso/processor.h>
config: hexagon-randconfig-r045-20220220 (https://download.01.org/0day-ci/archive/20220221/202202210526.ll6ZQU7s-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=121f4f0dd58c5fa0666a732d13b7ad770af3559b
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 121f4f0dd58c5fa0666a732d13b7ad770af3559b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from kernel/bounds.c:13:
   In file included from include/linux/log2.h:12:
   In file included from include/linux/bitops.h:28:
   In file included from arch/hexagon/include/asm/bitops.h:13:
   In file included from arch/hexagon/include/asm/atomic.h:13:
   In file included from ./arch/hexagon/include/generated/asm/barrier.h:1:
>> include/asm-generic/barrier.h:16:10: fatal error: 'asm/vdso/processor.h' file not found
   #include <asm/vdso/processor.h>
            ^~~~~~~~~~~~~~~~~~~~~~
   1 error generated.
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
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
