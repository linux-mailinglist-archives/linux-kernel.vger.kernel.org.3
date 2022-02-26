Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83434C5362
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 03:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiBZCeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 21:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiBZCeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 21:34:12 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B0C1AEEDE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 18:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645842816; x=1677378816;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7D2r85Uwz0Z5IABKnR6r5ET9fkhKx0yU3xEnD/Vax8o=;
  b=hAEl+KUrFWBuhzDh6ZpqxU2g9V/9V1VzRRRidMjGPk2Jisqb0g2uS/wa
   Pgqj2ZzyPPH7qSC1EjuUqcv+tRhn4b474+/wR8IyV5a64opp+pjFdtISv
   taunMNWXLOBVxceiSLqkExPeF05fpqepTY4p5rD+uHsT0bfdCcdPJ3WsR
   MImSt+d81OtZrAiydmiVMhNe3BCmAbx+y6lp+6S++HOffpiq4FLRMWAOW
   uJii0lk5/YqeHtUPcDN5nfOdvz2xtU4gbTvk9LdOgjEBtf/JagIC22u+R
   ddy33jp0tLb9NYKQOCz3HB4K7cix2D1zOFfAQzJ4OTMBupfMa43rS28qD
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10269"; a="232594759"
X-IronPort-AV: E=Sophos;i="5.90,138,1643702400"; 
   d="scan'208";a="232594759"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 18:33:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,138,1643702400"; 
   d="scan'208";a="574789080"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 25 Feb 2022 18:33:33 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNmto-0004yI-Pc; Sat, 26 Feb 2022 02:33:32 +0000
Date:   Sat, 26 Feb 2022 10:32:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Collingbourne <pcc@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [ammarfaizi2-block:arm64/linux/for-next/mte 2/6]
 include/linux/kasan-enabled.h:7:26: error: a parameter list without types is
 only allowed in a function definition
Message-ID: <202202261019.v5uTU7PH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block arm64/linux/for-next/mte
head:   766121ba5de38a6f67980ec24a6af76c55def100
commit: 38ddf7dafaeaf3fcdea65b3b4dfb06b4bcd9cc15 [2/6] arm64: mte: avoid clearing PSTATE.TCO on entry unless necessary
config: arm64-randconfig-r011-20220225 (https://download.01.org/0day-ci/archive/20220226/202202261019.v5uTU7PH-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/38ddf7dafaeaf3fcdea65b3b4dfb06b4bcd9cc15
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block arm64/linux/for-next/mte
        git checkout 38ddf7dafaeaf3fcdea65b3b4dfb06b4bcd9cc15
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/tty/serial/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from drivers/tty/serial/earlycon.c:16:
   In file included from include/linux/io.h:13:
   In file included from arch/arm64/include/asm/io.h:12:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/arm64/include/asm/pgtable.h:12:
   In file included from arch/arm64/include/asm/mte.h:14:
>> include/linux/kasan-enabled.h:7:1: warning: declaration specifier missing, defaulting to 'int'
   DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
   ^
   int
>> include/linux/kasan-enabled.h:7:26: error: a parameter list without types is only allowed in a function definition
   DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
                            ^
>> include/linux/kasan-enabled.h:11:9: error: implicit declaration of function 'static_branch_likely' [-Werror,-Wimplicit-function-declaration]
           return static_branch_likely(&kasan_flag_enabled);
                  ^
>> include/linux/kasan-enabled.h:11:31: error: use of undeclared identifier 'kasan_flag_enabled'; did you mean 'kasan_enabled'?
           return static_branch_likely(&kasan_flag_enabled);
                                        ^~~~~~~~~~~~~~~~~~
                                        kasan_enabled
   include/linux/kasan-enabled.h:9:29: note: 'kasan_enabled' declared here
   static __always_inline bool kasan_enabled(void)
                               ^
   1 warning and 3 errors generated.


vim +7 include/linux/kasan-enabled.h

f9b5e46f4097eb2 Peter Collingbourne 2022-02-18   6  
f9b5e46f4097eb2 Peter Collingbourne 2022-02-18  @7  DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
f9b5e46f4097eb2 Peter Collingbourne 2022-02-18   8  
f9b5e46f4097eb2 Peter Collingbourne 2022-02-18   9  static __always_inline bool kasan_enabled(void)
f9b5e46f4097eb2 Peter Collingbourne 2022-02-18  10  {
f9b5e46f4097eb2 Peter Collingbourne 2022-02-18 @11  	return static_branch_likely(&kasan_flag_enabled);
f9b5e46f4097eb2 Peter Collingbourne 2022-02-18  12  }
f9b5e46f4097eb2 Peter Collingbourne 2022-02-18  13  

:::::: The code at line 7 was first introduced by commit
:::::: f9b5e46f4097eb298f68e5b02f70697a90a44739 kasan: split kasan_*enabled() functions into a separate header

:::::: TO: Peter Collingbourne <pcc@google.com>
:::::: CC: Will Deacon <will@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
