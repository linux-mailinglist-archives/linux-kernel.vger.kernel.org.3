Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C190A4BDCEE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357882AbiBUM0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 07:26:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357840AbiBUM0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 07:26:40 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1922F13E2B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 04:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645446377; x=1676982377;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vrTPFZ3jtg+T5oSo9BkAv5karpdYsH1fOkNQ4RxBK+8=;
  b=UjmpFnn0e7FE1nZ0y1CrC9jdEjZDM5Mofj9YY2+yCKNIevQmZWswZyST
   h0wh6IMfjHDUXFmhG/gbV9kUjErL9hP2I4+JbR62INbKJe02TISy+fplk
   IRwdPXjhPpe5YNbRmEFKEMinNb2zM57jvl+iWDWNozEbd5iV1R/pb1Tup
   yIS++OO7sALyoIFr6aMlLNnMaGDs8zuHhLEYgvjmE+okOWSmdF61tIh2v
   aMqIcu1tF+E0+GUxZzedzlshO+oYIqcyr82CHB22Rk0zrMCI0zuIXDOJ0
   Z0CYP7lpk0uohKv0cbXiZTDVdKYGSBmZubR1m+ENQnn9C2VChhFXyzFCC
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="337930771"
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="337930771"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 04:26:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="490428113"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 21 Feb 2022 04:26:15 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nM7le-0001ag-AX; Mon, 21 Feb 2022 12:26:14 +0000
Date:   Mon, 21 Feb 2022 20:26:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Alistair Delva <adelva@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android-gs-raviole-5.10-android12-qpr1-d
 1249/8858] arch/mips/include/asm/page.h:12:10: fatal error: spaces.h: No
 such file or directory
Message-ID: <202202212057.fNaQFLep-lkp@intel.com>
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

Hi Sami,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android-gs-raviole-5.10-android12-qpr1-d
head:   9771767708df4fcf51cd1642e041c804a86e740c
commit: 08f67ef189ecce0f8330e53e5b78157f1b5afa19 [1249/8858] ANDROID: module: cfi: ensure __cfi_check alignment
config: mips-allmodconfig (https://download.01.org/0day-ci/archive/20220221/202202212057.fNaQFLep-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/08f67ef189ecce0f8330e53e5b78157f1b5afa19
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android-gs-raviole-5.10-android12-qpr1-d
        git checkout 08f67ef189ecce0f8330e53e5b78157f1b5afa19
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips modules_prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from scripts/module.lds.S:6:
>> arch/mips/include/asm/page.h:12:10: fatal error: spaces.h: No such file or directory
      12 | #include <spaces.h>
         |          ^~~~~~~~~~
   compilation terminated.
   make[2]: *** [scripts/Makefile.build:367: scripts/module.lds] Error 1
   make[1]: *** [Makefile:1469: modules_prepare] Error 2
   make: *** [Makefile:185: __sub-make] Error 2
   make: Target 'modules_prepare' not remade because of errors.


vim +12 arch/mips/include/asm/page.h

^1da177e4c3f41 include/asm-mips/page.h      Linus Torvalds  2005-04-16  11  
^1da177e4c3f41 include/asm-mips/page.h      Linus Torvalds  2005-04-16 @12  #include <spaces.h>
99502d94c3649c arch/mips/include/asm/page.h Nelson Elhage   2009-07-31  13  #include <linux/const.h>
75b5b5e0a26279 arch/mips/include/asm/page.h Leonid Yegoshin 2013-11-14  14  #include <linux/kernel.h>
75b5b5e0a26279 arch/mips/include/asm/page.h Leonid Yegoshin 2013-11-14  15  #include <asm/mipsregs.h>
^1da177e4c3f41 include/asm-mips/page.h      Linus Torvalds  2005-04-16  16  

:::::: The code at line 12 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
