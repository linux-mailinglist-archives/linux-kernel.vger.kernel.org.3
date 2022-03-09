Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF8A4D273F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbiCIDry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 22:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbiCIDru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 22:47:50 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B474A3FD
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 19:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646797612; x=1678333612;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+XoGocbZi1cgmzEERFKFOdrREAn1nTxyNcMKoacKCLQ=;
  b=LuQJ2Zi4VOghwZq8QdXK5xC24tgr37NA+iINHBOhcfnizdyvxAvlLYgN
   deR/Qsr+eK9phfJyEhQQ+07o2aomggWK5ZxNNBrZ2+io9UNDEJN6I7psG
   giS/E1YoQXfcFd/Gk+cfYl9dsIR+XcV9LioOWIJnKrUQ1CtqiNhWxxaFI
   bi2Wmco2uKmBGgEuHgJ6tpJES9LyUwskY39+Q1VAqHuGnq1T03F0Qv6av
   43d0q/OAu6/BIxaTzDlUT3XRe8r5f7JhhaTPnvYQsU247RuFDGGosS4ol
   fqdJVoiESrCdJhDbkZwzPZ2a2/2SI8KQfGv0Jfh8aRqLRXz9DFox87GKp
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="255068636"
X-IronPort-AV: E=Sophos;i="5.90,166,1643702400"; 
   d="scan'208";a="255068636"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 19:46:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,166,1643702400"; 
   d="scan'208";a="711788810"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 08 Mar 2022 19:46:50 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRnHl-0002WO-9U; Wed, 09 Mar 2022 03:46:49 +0000
Date:   Wed, 9 Mar 2022 11:45:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huang Pei <huangpei@loongson.cn>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:queue/5.15 4120/4370]
 arch/mips/include/asm/asm.h:68:9: warning: 'END' macro redefined
Message-ID: <202203091113.kxjEu6kW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git queue/5.15
head:   93b383f9f7788c5ac3ebc43f7405e1924037224e
commit: f98371d2ac835f1fa0705978623e051dc1397f20 [4120/4370] MIPS: fix local_{add,sub}_return on MIPS64
config: mips-randconfig-r015-20220308 (https://download.01.org/0day-ci/archive/20220309/202203091113.kxjEu6kW-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 276ca87382b8f16a65bddac700202924228982f6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=f98371d2ac835f1fa0705978623e051dc1397f20
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc queue/5.15
        git checkout f98371d2ac835f1fa0705978623e051dc1397f20
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/net/slip/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from drivers/net/slip/slip.c:91:
   In file included from include/linux/tcp.h:19:
   In file included from include/net/sock.h:53:
   In file included from include/linux/memcontrol.h:22:
   In file included from include/linux/writeback.h:14:
   In file included from include/linux/blk-cgroup.h:23:
   In file included from include/linux/blkdev.h:8:
   In file included from include/linux/genhd.h:20:
   In file included from arch/mips/include/asm/local.h:8:
>> arch/mips/include/asm/asm.h:68:9: warning: 'END' macro redefined [-Wmacro-redefined]
   #define END(function)                                   \
           ^
   drivers/net/slip/slip.h:44:9: note: previous definition is here
   #define END             0300            /* indicates end of frame       */
           ^
>> drivers/net/slip/slip.c:930:11: error: use of undeclared identifier 'END'
           *ptr++ = END;
                    ^
   drivers/net/slip/slip.c:939:8: error: use of undeclared identifier 'END'
                   case END:
                        ^
   drivers/net/slip/slip.c:952:11: error: use of undeclared identifier 'END'
           *ptr++ = END;
                    ^
   drivers/net/slip/slip.c:960:7: error: use of undeclared identifier 'END'
           case END:
                ^
   drivers/net/slip/slip.c:983:8: error: use of undeclared identifier 'END'
                           s = END;
                               ^
   drivers/net/slip/slip.c:1395:22: error: use of undeclared identifier 'END'
                           unsigned char s = END;
                                             ^
   1 warning and 6 errors generated.


vim +/END +68 arch/mips/include/asm/asm.h

894ef530012fb50 arch/mips/include/asm/asm.h Alexander Lobakin 2021-01-10  38  
^1da177e4c3f415 include/asm-mips/asm.h      Linus Torvalds    2005-04-16  39  /*
^1da177e4c3f415 include/asm-mips/asm.h      Linus Torvalds    2005-04-16  40   * LEAF - declare leaf routine
^1da177e4c3f415 include/asm-mips/asm.h      Linus Torvalds    2005-04-16  41   */
^1da177e4c3f415 include/asm-mips/asm.h      Linus Torvalds    2005-04-16  42  #define LEAF(symbol)					\
894ef530012fb50 arch/mips/include/asm/asm.h Alexander Lobakin 2021-01-10  43  		CFI_SECTIONS;				\
^1da177e4c3f415 include/asm-mips/asm.h      Linus Torvalds    2005-04-16  44  		.globl	symbol;				\
^1da177e4c3f415 include/asm-mips/asm.h      Linus Torvalds    2005-04-16  45  		.align	2;				\
^1da177e4c3f415 include/asm-mips/asm.h      Linus Torvalds    2005-04-16  46  		.type	symbol, @function;		\
^1da177e4c3f415 include/asm-mips/asm.h      Linus Torvalds    2005-04-16  47  		.ent	symbol, 0;			\
08889582b8aa0bb arch/mips/include/asm/asm.h Paul Burton       2016-11-07  48  symbol:		.frame	sp, 0, ra;			\
866b6a89c6d1876 arch/mips/include/asm/asm.h Corey Minyard     2017-08-10  49  		.cfi_startproc;				\
08889582b8aa0bb arch/mips/include/asm/asm.h Paul Burton       2016-11-07  50  		.insn
^1da177e4c3f415 include/asm-mips/asm.h      Linus Torvalds    2005-04-16  51  
^1da177e4c3f415 include/asm-mips/asm.h      Linus Torvalds    2005-04-16  52  /*
^1da177e4c3f415 include/asm-mips/asm.h      Linus Torvalds    2005-04-16  53   * NESTED - declare nested routine entry point
^1da177e4c3f415 include/asm-mips/asm.h      Linus Torvalds    2005-04-16  54   */
^1da177e4c3f415 include/asm-mips/asm.h      Linus Torvalds    2005-04-16  55  #define NESTED(symbol, framesize, rpc)			\
894ef530012fb50 arch/mips/include/asm/asm.h Alexander Lobakin 2021-01-10  56  		CFI_SECTIONS;				\
^1da177e4c3f415 include/asm-mips/asm.h      Linus Torvalds    2005-04-16  57  		.globl	symbol;				\
^1da177e4c3f415 include/asm-mips/asm.h      Linus Torvalds    2005-04-16  58  		.align	2;				\
^1da177e4c3f415 include/asm-mips/asm.h      Linus Torvalds    2005-04-16  59  		.type	symbol, @function;		\
^1da177e4c3f415 include/asm-mips/asm.h      Linus Torvalds    2005-04-16  60  		.ent	symbol, 0;			\
08889582b8aa0bb arch/mips/include/asm/asm.h Paul Burton       2016-11-07  61  symbol:		.frame	sp, framesize, rpc;		\
866b6a89c6d1876 arch/mips/include/asm/asm.h Corey Minyard     2017-08-10  62  		.cfi_startproc;				\
08889582b8aa0bb arch/mips/include/asm/asm.h Paul Burton       2016-11-07  63  		.insn
^1da177e4c3f415 include/asm-mips/asm.h      Linus Torvalds    2005-04-16  64  
^1da177e4c3f415 include/asm-mips/asm.h      Linus Torvalds    2005-04-16  65  /*
^1da177e4c3f415 include/asm-mips/asm.h      Linus Torvalds    2005-04-16  66   * END - mark end of function
^1da177e4c3f415 include/asm-mips/asm.h      Linus Torvalds    2005-04-16  67   */
^1da177e4c3f415 include/asm-mips/asm.h      Linus Torvalds    2005-04-16 @68  #define END(function)					\
866b6a89c6d1876 arch/mips/include/asm/asm.h Corey Minyard     2017-08-10  69  		.cfi_endproc;				\
^1da177e4c3f415 include/asm-mips/asm.h      Linus Torvalds    2005-04-16  70  		.end	function;			\
^1da177e4c3f415 include/asm-mips/asm.h      Linus Torvalds    2005-04-16  71  		.size	function, .-function
^1da177e4c3f415 include/asm-mips/asm.h      Linus Torvalds    2005-04-16  72  

:::::: The code at line 68 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
