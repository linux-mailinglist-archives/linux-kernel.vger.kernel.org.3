Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49A14E7E7B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 02:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiCZBx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 21:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiCZBx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 21:53:28 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF306217967
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 18:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648259511; x=1679795511;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XKeDtx+e7Z6XXOcCQX3+ybtBW979kFPfT0nbtssEJFg=;
  b=e5vY0FtJtlaQEkDUSiwR+Cj5jFudiIV6WIWDfNcCR1DMI63seAQC6yp5
   T9x5M5d0G8vOiIaiDvbfIEeQE7ebyoPV+rv+vw3WY1ZVXWWw7Qt5Dwt44
   U4d/B5AqeS+WMUN6iUlHutlkMCcq/VYHHDqejynqsDIAxa6pCzhh7w36Z
   nK1xR+SzXSl9LVXO4J279YBWFtT1G7eih+gPZbtN5hsIiVWfrAKPlUgAs
   CJH6SJi2iX8JsvnhNMzpTN7UwGRKdRNyONRzTlJjP3xKOByHgEh3kuVX7
   SvUW0TIh27MMhU9m4TkIyhc9r8fq32nqyhqwfqkNdNgaYm/1m9P3kdya2
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="258716874"
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="258716874"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 18:51:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="650425845"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 25 Mar 2022 18:51:50 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nXvan-000MrJ-4M; Sat, 26 Mar 2022 01:51:49 +0000
Date:   Sat, 26 Mar 2022 09:50:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/afs-testing 44/44]
 include/asm-generic/cmpxchg.h:35:39: sparse: sparse: cast truncates bits
 from constant value (5e5ee5e5 becomes e5)
Message-ID: <202203260941.OiKX28fM-lkp@intel.com>
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
config: nios2-randconfig-s032-20220324 (https://download.01.org/0day-ci/archive/20220326/202203260941.OiKX28fM-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=nios2 SHELL=/bin/bash kernel/time/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   kernel/time/timer.c: note: in included file (through arch/nios2/include/generated/asm/cmpxchg.h, include/asm-generic/atomic.h, arch/nios2/include/generated/asm/atomic.h, ...):
>> include/asm-generic/cmpxchg.h:35:39: sparse: sparse: cast truncates bits from constant value (5e5ee5e5 becomes e5)
>> include/asm-generic/cmpxchg.h:46:40: sparse: sparse: cast truncates bits from constant value (5e5ee5e5 becomes e5e5)

vim +35 include/asm-generic/cmpxchg.h

b4816afa3986704 David Howells 2012-03-28  22  
b4816afa3986704 David Howells 2012-03-28  23  static inline
82b993e8249ae3c Mark Rutland  2021-05-25  24  unsigned long __generic_xchg(unsigned long x, volatile void *ptr, int size)
b4816afa3986704 David Howells 2012-03-28  25  {
b4816afa3986704 David Howells 2012-03-28  26  	unsigned long ret, flags;
b4816afa3986704 David Howells 2012-03-28  27  
b4816afa3986704 David Howells 2012-03-28  28  	switch (size) {
b4816afa3986704 David Howells 2012-03-28  29  	case 1:
b4816afa3986704 David Howells 2012-03-28  30  #ifdef __xchg_u8
b4816afa3986704 David Howells 2012-03-28  31  		return __xchg_u8(x, ptr);
b4816afa3986704 David Howells 2012-03-28  32  #else
b4816afa3986704 David Howells 2012-03-28  33  		local_irq_save(flags);
b4816afa3986704 David Howells 2012-03-28  34  		ret = *(volatile u8 *)ptr;
b4816afa3986704 David Howells 2012-03-28 @35  		*(volatile u8 *)ptr = x;
b4816afa3986704 David Howells 2012-03-28  36  		local_irq_restore(flags);
b4816afa3986704 David Howells 2012-03-28  37  		return ret;
b4816afa3986704 David Howells 2012-03-28  38  #endif /* __xchg_u8 */
b4816afa3986704 David Howells 2012-03-28  39  
b4816afa3986704 David Howells 2012-03-28  40  	case 2:
b4816afa3986704 David Howells 2012-03-28  41  #ifdef __xchg_u16
b4816afa3986704 David Howells 2012-03-28  42  		return __xchg_u16(x, ptr);
b4816afa3986704 David Howells 2012-03-28  43  #else
b4816afa3986704 David Howells 2012-03-28  44  		local_irq_save(flags);
b4816afa3986704 David Howells 2012-03-28  45  		ret = *(volatile u16 *)ptr;
b4816afa3986704 David Howells 2012-03-28 @46  		*(volatile u16 *)ptr = x;
b4816afa3986704 David Howells 2012-03-28  47  		local_irq_restore(flags);
b4816afa3986704 David Howells 2012-03-28  48  		return ret;
b4816afa3986704 David Howells 2012-03-28  49  #endif /* __xchg_u16 */
b4816afa3986704 David Howells 2012-03-28  50  
b4816afa3986704 David Howells 2012-03-28  51  	case 4:
b4816afa3986704 David Howells 2012-03-28  52  #ifdef __xchg_u32
b4816afa3986704 David Howells 2012-03-28  53  		return __xchg_u32(x, ptr);
b4816afa3986704 David Howells 2012-03-28  54  #else
b4816afa3986704 David Howells 2012-03-28  55  		local_irq_save(flags);
b4816afa3986704 David Howells 2012-03-28  56  		ret = *(volatile u32 *)ptr;
b4816afa3986704 David Howells 2012-03-28  57  		*(volatile u32 *)ptr = x;
b4816afa3986704 David Howells 2012-03-28  58  		local_irq_restore(flags);
b4816afa3986704 David Howells 2012-03-28  59  		return ret;
b4816afa3986704 David Howells 2012-03-28  60  #endif /* __xchg_u32 */
b4816afa3986704 David Howells 2012-03-28  61  

:::::: The code at line 35 was first introduced by commit
:::::: b4816afa3986704d1404fc48e931da5135820472 Move the asm-generic/system.h xchg() implementation to asm-generic/cmpxchg.h

:::::: TO: David Howells <dhowells@redhat.com>
:::::: CC: David Howells <dhowells@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
