Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C09A4D4882
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 15:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242635AbiCJODZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 09:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbiCJODX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 09:03:23 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D1D14E976
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 06:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646920942; x=1678456942;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uOwhborcRgavFTSUWMRWRCM1yBEHDdqFGkJhMAWS0dQ=;
  b=iXjdJ2TDjCoVC2Rr12YFWIoj8pOJ63fTfIgt6FYi9fpPnZkL5ncPnmeg
   byH//2WPT5qYB5VXB5fCfb5uLXVLkRO+jHnW43SGN63sfBykMQeDjmmM/
   np5h167Lzkf5k/u0n49JSce5KDH6CXpX47P63zoTlFhsEkj/LAU07OjC8
   Myanml3GeGDqXgGSFgw++B80VZPrTm5owOBa6iqX0pBsVXgu79IxBmM2a
   e0s9FepX6RBzmDlwbx5GI+OXOaAZxb1lPLL3osTOpFWFVSauo5NwYZD9i
   Af4tMJYgKn2vy8++FAY3g85EYHYgAlY0EAFIeBAqJv0xF61vFW8DTzkjq
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="235204068"
X-IronPort-AV: E=Sophos;i="5.90,170,1643702400"; 
   d="scan'208";a="235204068"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 06:02:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,170,1643702400"; 
   d="scan'208";a="548017116"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 10 Mar 2022 06:02:20 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSJMx-00050L-AI; Thu, 10 Mar 2022 14:02:19 +0000
Date:   Thu, 10 Mar 2022 22:01:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Alistair Delva <adelva@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android-gs-raviole-5.10-android12-qpr1-d
 1249/8858] arch/mips/include/asm/page.h:12:10: fatal error: 'spaces.h' file
 not found
Message-ID: <202203102157.Kyxw6NdP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android-gs-raviole-5.10-android12-qpr1-d
head:   9771767708df4fcf51cd1642e041c804a86e740c
commit: 08f67ef189ecce0f8330e53e5b78157f1b5afa19 [1249/8858] ANDROID: module: cfi: ensure __cfi_check alignment
config: mips-cavium_octeon_defconfig (https://download.01.org/0day-ci/archive/20220310/202203102157.Kyxw6NdP-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 276ca87382b8f16a65bddac700202924228982f6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/08f67ef189ecce0f8330e53e5b78157f1b5afa19
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android-gs-raviole-5.10-android12-qpr1-d
        git checkout 08f67ef189ecce0f8330e53e5b78157f1b5afa19
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips modules_prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from scripts/module.lds.S:6:
>> arch/mips/include/asm/page.h:12:10: fatal error: 'spaces.h' file not found
   #include <spaces.h>
            ^~~~~~~~~~
   1 error generated.
   make[2]: *** [scripts/Makefile.build:367: scripts/module.lds] Error 1
   make[1]: *** [Makefile:1469: modules_prepare] Error 2
   make: *** [Makefile:185: __sub-make] Error 2
   make: Target 'modules_prepare' not remade because of errors.


vim +12 arch/mips/include/asm/page.h

^1da177e4c3f415 include/asm-mips/page.h      Linus Torvalds  2005-04-16  11  
^1da177e4c3f415 include/asm-mips/page.h      Linus Torvalds  2005-04-16 @12  #include <spaces.h>
99502d94c3649c5 arch/mips/include/asm/page.h Nelson Elhage   2009-07-31  13  #include <linux/const.h>
75b5b5e0a262790 arch/mips/include/asm/page.h Leonid Yegoshin 2013-11-14  14  #include <linux/kernel.h>
75b5b5e0a262790 arch/mips/include/asm/page.h Leonid Yegoshin 2013-11-14  15  #include <asm/mipsregs.h>
^1da177e4c3f415 include/asm-mips/page.h      Linus Torvalds  2005-04-16  16  

:::::: The code at line 12 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
