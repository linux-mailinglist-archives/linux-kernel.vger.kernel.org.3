Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E984E73A6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 13:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354117AbiCYMma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 08:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243507AbiCYMm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 08:42:28 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D1E3616A
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 05:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648212054; x=1679748054;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=o2LFS03sDofrW+G9hmi3C61RnQvETQcPgiy633mrl5Y=;
  b=XBP0VhFIhISsXV/4eF8KVaL26sErm4em/h0TZQk3vvewU1e0lut5r6br
   dip6QeOvrpxJGNPlyoshQxWpit4QQXb0isBixPuXCLIeA5Z86Jx+LFhWf
   GXRVc16Xftadscwp0yf+ukT5JbZKePrlcwtn1YZAZDWzYfos5MQgUqdvH
   WL14IbTFZCkpgCWAKVPqo6EWcpVWF8MncKYradAy3qkmifVibSBXQbrAk
   OPkj1fDI0zab0gPwEP7829GrKR9o4gmhnF/36MByb6X3628/tvBlx7QJG
   x7fnbOhi9rkVVwOLoIECfda4+do4VIGH3e0H89ghSxaHC4saK4w+AnIkT
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="283494969"
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="283494969"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 05:40:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="718197765"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 25 Mar 2022 05:40:51 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nXjFK-000MBc-Rk; Fri, 25 Mar 2022 12:40:50 +0000
Date:   Fri, 25 Mar 2022 20:40:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: arch/mips/crypto/crc32-mips.c:40:1: error: expected identifier or '('
Message-ID: <202203252015.7q4sT1o2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   34af78c4e616c359ed428d79fe4758a35d2c5473
commit: 67512a8cf5a730938fdb1e48de33edfef6015e03 MIPS: Avoid macro redefinitions
date:   6 months ago
config: mips-randconfig-r001-20220324 (https://download.01.org/0day-ci/archive/20220325/202203252015.7q4sT1o2-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=67512a8cf5a730938fdb1e48de33edfef6015e03
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 67512a8cf5a730938fdb1e48de33edfef6015e03
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/mips/crypto/crc32-mips.c:40:1: error: expected identifier or '('
   _ASM_MACRO_CRC32(crc32b,  0, 0);
   ^
   arch/mips/crypto/crc32-mips.c:31:46: note: expanded from macro '_ASM_MACRO_CRC32'
   #define _ASM_MACRO_CRC32(OP, SZ, TYPE)                                    \
                                                                             ^
   arch/mips/include/asm/mipsregs.h:1346:3: note: expanded from macro '\
   _ASM_MACRO_3R'
                   ".macro " #OP " " #R1 ", " #R2 ", " #R3 "\n\t"          \
                   ^
   arch/mips/crypto/crc32-mips.c:41:1: error: expected identifier or '('
   _ASM_MACRO_CRC32(crc32h,  1, 0);
   ^
   arch/mips/crypto/crc32-mips.c:31:46: note: expanded from macro '_ASM_MACRO_CRC32'
   #define _ASM_MACRO_CRC32(OP, SZ, TYPE)                                    \
                                                                             ^
   arch/mips/include/asm/mipsregs.h:1346:3: note: expanded from macro '\
   _ASM_MACRO_3R'
                   ".macro " #OP " " #R1 ", " #R2 ", " #R3 "\n\t"          \
                   ^
   arch/mips/crypto/crc32-mips.c:42:1: error: expected identifier or '('
   _ASM_MACRO_CRC32(crc32w,  2, 0);
   ^
   arch/mips/crypto/crc32-mips.c:31:46: note: expanded from macro '_ASM_MACRO_CRC32'
   #define _ASM_MACRO_CRC32(OP, SZ, TYPE)                                    \
                                                                             ^
   arch/mips/include/asm/mipsregs.h:1346:3: note: expanded from macro '\
   _ASM_MACRO_3R'
                   ".macro " #OP " " #R1 ", " #R2 ", " #R3 "\n\t"          \
                   ^
   arch/mips/crypto/crc32-mips.c:43:1: error: expected identifier or '('
   _ASM_MACRO_CRC32(crc32d,  3, 0);
   ^
   arch/mips/crypto/crc32-mips.c:31:46: note: expanded from macro '_ASM_MACRO_CRC32'
   #define _ASM_MACRO_CRC32(OP, SZ, TYPE)                                    \
                                                                             ^
   arch/mips/include/asm/mipsregs.h:1346:3: note: expanded from macro '\
   _ASM_MACRO_3R'
                   ".macro " #OP " " #R1 ", " #R2 ", " #R3 "\n\t"          \
                   ^
   arch/mips/crypto/crc32-mips.c:44:1: error: expected identifier or '('
   _ASM_MACRO_CRC32(crc32cb, 0, 1);
   ^
   arch/mips/crypto/crc32-mips.c:31:46: note: expanded from macro '_ASM_MACRO_CRC32'
   #define _ASM_MACRO_CRC32(OP, SZ, TYPE)                                    \
                                                                             ^
   arch/mips/include/asm/mipsregs.h:1346:3: note: expanded from macro '\
   _ASM_MACRO_3R'
                   ".macro " #OP " " #R1 ", " #R2 ", " #R3 "\n\t"          \
                   ^
   arch/mips/crypto/crc32-mips.c:45:1: error: expected identifier or '('
   _ASM_MACRO_CRC32(crc32ch, 1, 1);
   ^
   arch/mips/crypto/crc32-mips.c:31:46: note: expanded from macro '_ASM_MACRO_CRC32'
   #define _ASM_MACRO_CRC32(OP, SZ, TYPE)                                    \
                                                                             ^
   arch/mips/include/asm/mipsregs.h:1346:3: note: expanded from macro '\
   _ASM_MACRO_3R'
                   ".macro " #OP " " #R1 ", " #R2 ", " #R3 "\n\t"          \
                   ^
   arch/mips/crypto/crc32-mips.c:46:1: error: expected identifier or '('
   _ASM_MACRO_CRC32(crc32cw, 2, 1);
   ^
   arch/mips/crypto/crc32-mips.c:31:46: note: expanded from macro '_ASM_MACRO_CRC32'
   #define _ASM_MACRO_CRC32(OP, SZ, TYPE)                                    \
                                                                             ^
   arch/mips/include/asm/mipsregs.h:1346:3: note: expanded from macro '\
   _ASM_MACRO_3R'
                   ".macro " #OP " " #R1 ", " #R2 ", " #R3 "\n\t"          \
                   ^
   arch/mips/crypto/crc32-mips.c:47:1: error: expected identifier or '('
   _ASM_MACRO_CRC32(crc32cd, 3, 1);
   ^
   arch/mips/crypto/crc32-mips.c:31:46: note: expanded from macro '_ASM_MACRO_CRC32'
   #define _ASM_MACRO_CRC32(OP, SZ, TYPE)                                    \
                                                                             ^
   arch/mips/include/asm/mipsregs.h:1346:3: note: expanded from macro '\
   _ASM_MACRO_3R'
                   ".macro " #OP " " #R1 ", " #R2 ", " #R3 "\n\t"          \
                   ^
   8 errors generated.


vim +40 arch/mips/crypto/crc32-mips.c

4a5dc51e93e8046 Marcin Nowakowski 2018-02-09  29  
4a5dc51e93e8046 Marcin Nowakowski 2018-02-09  30  #ifndef TOOLCHAIN_SUPPORTS_CRC
4a5dc51e93e8046 Marcin Nowakowski 2018-02-09  31  #define _ASM_MACRO_CRC32(OP, SZ, TYPE)					  \
4a5dc51e93e8046 Marcin Nowakowski 2018-02-09  32  _ASM_MACRO_3R(OP, rt, rs, rt2,						  \
4a5dc51e93e8046 Marcin Nowakowski 2018-02-09  33  	".ifnc	\\rt, \\rt2\n\t"					  \
4a5dc51e93e8046 Marcin Nowakowski 2018-02-09  34  	".error	\"invalid operands \\\"" #OP " \\rt,\\rs,\\rt2\\\"\"\n\t" \
4a5dc51e93e8046 Marcin Nowakowski 2018-02-09  35  	".endif\n\t"							  \
4a5dc51e93e8046 Marcin Nowakowski 2018-02-09  36  	_ASM_INSN_IF_MIPS(0x7c00000f | (__rt << 16) | (__rs << 21) |	  \
4a5dc51e93e8046 Marcin Nowakowski 2018-02-09  37  			  ((SZ) <<  6) | ((TYPE) << 8))			  \
4a5dc51e93e8046 Marcin Nowakowski 2018-02-09  38  	_ASM_INSN32_IF_MM(0x00000030 | (__rs << 16) | (__rt << 21) |	  \
4a5dc51e93e8046 Marcin Nowakowski 2018-02-09  39  			  ((SZ) << 14) | ((TYPE) << 3)))
4a5dc51e93e8046 Marcin Nowakowski 2018-02-09 @40  _ASM_MACRO_CRC32(crc32b,  0, 0);
4a5dc51e93e8046 Marcin Nowakowski 2018-02-09  41  _ASM_MACRO_CRC32(crc32h,  1, 0);
4a5dc51e93e8046 Marcin Nowakowski 2018-02-09  42  _ASM_MACRO_CRC32(crc32w,  2, 0);
4a5dc51e93e8046 Marcin Nowakowski 2018-02-09  43  _ASM_MACRO_CRC32(crc32d,  3, 0);
4a5dc51e93e8046 Marcin Nowakowski 2018-02-09  44  _ASM_MACRO_CRC32(crc32cb, 0, 1);
4a5dc51e93e8046 Marcin Nowakowski 2018-02-09  45  _ASM_MACRO_CRC32(crc32ch, 1, 1);
4a5dc51e93e8046 Marcin Nowakowski 2018-02-09  46  _ASM_MACRO_CRC32(crc32cw, 2, 1);
4a5dc51e93e8046 Marcin Nowakowski 2018-02-09  47  _ASM_MACRO_CRC32(crc32cd, 3, 1);
4a5dc51e93e8046 Marcin Nowakowski 2018-02-09  48  #define _ASM_SET_CRC ""
4a5dc51e93e8046 Marcin Nowakowski 2018-02-09  49  #else /* !TOOLCHAIN_SUPPORTS_CRC */
4a5dc51e93e8046 Marcin Nowakowski 2018-02-09  50  #define _ASM_SET_CRC ".set\tcrc\n\t"
4a5dc51e93e8046 Marcin Nowakowski 2018-02-09  51  #endif
4a5dc51e93e8046 Marcin Nowakowski 2018-02-09  52  

:::::: The code at line 40 was first introduced by commit
:::::: 4a5dc51e93e80463010ab4d8d00fc9cb6bc936fa MIPS: crypto: Add crc32 and crc32c hw accelerated module

:::::: TO: Marcin Nowakowski <marcin.nowakowski@mips.com>
:::::: CC: James Hogan <jhogan@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
