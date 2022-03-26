Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B724E7E9D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 03:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbiCZCdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 22:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiCZCdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 22:33:50 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAED0593A5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 19:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648261934; x=1679797934;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=V331xQ5ByB0x2QMaL69g1ngRRXmUppECGTvzgEqID7k=;
  b=jQeizwqrxLRTMs6spu9+KpcW2ZEtwIJqkuzGYfqiqpdfwiqiMlByky/h
   +ZOMts/rc+UIfaCSqigki7vhOXVmmDmRsbtahRY6FLdq9ULzHf4zRPh4p
   68TmpUpPARDK4KZqn9vT2UQGY494e/5lBJVXNGSPKC0exvxfLHkE7i4yz
   MwrTcoMGN/144353OKnJ1k+EYXm6UyA4nzO/AXZw8aWLItnbnM7LC/yoC
   Tfi4po8DKDMIkLQ8Hxsy0KJJZx6Ra6Pp2PaoauyKoGqBvUoJpjmTvUm0h
   fOjBksoitPElMOnld+iHwpX8Umm/8jaldjcOBVhJY2lk25zHd9rRct/AS
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="258719577"
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="258719577"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 19:32:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="718406425"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 25 Mar 2022 19:32:13 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nXwDs-000MuS-Cr; Sat, 26 Mar 2022 02:32:12 +0000
Date:   Sat, 26 Mar 2022 10:31:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/afs-testing 44/44]
 arch/sh/include/asm/cmpxchg-irq.h:24:14: sparse: sparse: cast truncates bits
 from constant value (5e5ee5e5 becomes e5e5)
Message-ID: <202203261033.hVE2K2SZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/afs-testing
head:   1eba43e7cea9100a3767c5a7212ec5f1db4db4fd
commit: 1eba43e7cea9100a3767c5a7212ec5f1db4db4fd [44/44] Check for dead timer
config: sh-randconfig-s032-20220325 (https://download.01.org/0day-ci/archive/20220326/202203261033.hVE2K2SZ-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/1eba43e7cea9100a3767c5a7212ec5f1db4db4fd
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/afs-testing
        git checkout 1eba43e7cea9100a3767c5a7212ec5f1db4db4fd
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sh SHELL=/bin/bash kernel/time/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   kernel/time/timer.c: note: in included file (through arch/sh/include/asm/cmpxchg.h, arch/sh/include/asm/atomic.h, include/linux/atomic.h, ...):
>> arch/sh/include/asm/cmpxchg-irq.h:24:14: sparse: sparse: cast truncates bits from constant value (5e5ee5e5 becomes e5e5)

vim +24 arch/sh/include/asm/cmpxchg-irq.h

1efe4ce3ca126da include/asm-sh/cmpxchg-irq.h      Stuart Menefy      2007-11-30  17  
3226aad81aa6700 arch/sh/include/asm/cmpxchg-irq.h Michael S. Tsirkin 2016-01-07  18  static inline unsigned long xchg_u16(volatile u16 *m, unsigned long val)
3226aad81aa6700 arch/sh/include/asm/cmpxchg-irq.h Michael S. Tsirkin 2016-01-07  19  {
3226aad81aa6700 arch/sh/include/asm/cmpxchg-irq.h Michael S. Tsirkin 2016-01-07  20  	unsigned long flags, retval;
3226aad81aa6700 arch/sh/include/asm/cmpxchg-irq.h Michael S. Tsirkin 2016-01-07  21  
3226aad81aa6700 arch/sh/include/asm/cmpxchg-irq.h Michael S. Tsirkin 2016-01-07  22  	local_irq_save(flags);
3226aad81aa6700 arch/sh/include/asm/cmpxchg-irq.h Michael S. Tsirkin 2016-01-07  23  	retval = *m;
3226aad81aa6700 arch/sh/include/asm/cmpxchg-irq.h Michael S. Tsirkin 2016-01-07 @24  	*m = val;
3226aad81aa6700 arch/sh/include/asm/cmpxchg-irq.h Michael S. Tsirkin 2016-01-07  25  	local_irq_restore(flags);
3226aad81aa6700 arch/sh/include/asm/cmpxchg-irq.h Michael S. Tsirkin 2016-01-07  26  	return retval;
3226aad81aa6700 arch/sh/include/asm/cmpxchg-irq.h Michael S. Tsirkin 2016-01-07  27  }
3226aad81aa6700 arch/sh/include/asm/cmpxchg-irq.h Michael S. Tsirkin 2016-01-07  28  

:::::: The code at line 24 was first introduced by commit
:::::: 3226aad81aa670015a59e51458a0deb2d3bcb600 sh: support 1 and 2 byte xchg

:::::: TO: Michael S. Tsirkin <mst@redhat.com>
:::::: CC: Michael S. Tsirkin <mst@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
