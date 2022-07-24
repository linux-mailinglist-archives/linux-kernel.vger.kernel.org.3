Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E4457F6FE
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 22:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbiGXUP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 16:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiGXUPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 16:15:25 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3544FF05
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 13:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658693724; x=1690229724;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/XKglUVOJEyHIJU/H7Lc4uf6RHd+Ys8toBysJ7PENuc=;
  b=mFREogcfJAYzqYuq1R6CT36+kvIe7wojfUTxumFpK+nQM8HZZmNGyqNa
   xfhc3F98DkwRHC8BJ6H7d9VfUHVBqb5RDDezWzirq3crDQk3AKbKVh/ne
   swwQEP17CkFBE631LPd30ihTsglpwywfdHS3DAHTmw81lAl2p3TXAJDEp
   IfSYeRxfi2uQyHxuLlBH3ekZ/Ha1LMdDD8Sew0pwUx4/reLusxzFTXyrF
   dp7aPYnAhpbSNCySSRpjKx+YvGaPruUN46LKA7tGjZqdTP3PIAfWSIQK0
   U3ZRY85fNB/oxBLIyqRgPHq3Hwcuwu84PELCg2mRbqfSJqIf6zLkW6eE9
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="373872305"
X-IronPort-AV: E=Sophos;i="5.93,191,1654585200"; 
   d="scan'208";a="373872305"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 13:15:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,191,1654585200"; 
   d="scan'208";a="926656655"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 24 Jul 2022 13:15:22 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFi0X-0004EZ-1C;
        Sun, 24 Jul 2022 20:15:21 +0000
Date:   Mon, 25 Jul 2022 04:14:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Justin M. Forbes" <jforbes@fedoraproject.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Jason A. Donenfeld" <zx2c4@kernel.org>
Subject: [linux-stable-rc:linux-5.15.y 6874/8723]
 arch/arm/lib/xor-neon.c:30:2: warning: This code requires at least version
 4.6 of GCC
Message-ID: <202207250449.BYMZbIA2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
head:   a9e2d8e52e1c0d87c0fa4f9d2d38e210aabed515
commit: e16cc79b0f916069de223bdb567fa0bc2ccd18a5 [6874/8723] lib/crypto: add prompts back to crypto libraries
config: arm-buildonly-randconfig-r006-20220724 (https://download.01.org/0day-ci/archive/20220725/202207250449.BYMZbIA2-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 12fbd2d377e396ad61bce56d71c98a1eb1bebfa9)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=e16cc79b0f916069de223bdb567fa0bc2ccd18a5
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.15.y
        git checkout e16cc79b0f916069de223bdb567fa0bc2ccd18a5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm/lib/xor-neon.c:30:2: warning: This code requires at least version 4.6 of GCC [-W#warnings]
   #warning This code requires at least version 4.6 of GCC
    ^
   1 warning generated.


vim +30 arch/arm/lib/xor-neon.c

01956597cbc46d Ard Biesheuvel 2013-05-17  16  
01956597cbc46d Ard Biesheuvel 2013-05-17  17  /*
01956597cbc46d Ard Biesheuvel 2013-05-17  18   * Pull in the reference implementations while instructing GCC (through
01956597cbc46d Ard Biesheuvel 2013-05-17  19   * -ftree-vectorize) to attempt to exploit implicit parallelism and emit
01956597cbc46d Ard Biesheuvel 2013-05-17  20   * NEON instructions.
01956597cbc46d Ard Biesheuvel 2013-05-17  21   */
01956597cbc46d Ard Biesheuvel 2013-05-17  22  #if __GNUC__ > 4 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 6)
01956597cbc46d Ard Biesheuvel 2013-05-17  23  #pragma GCC optimize "tree-vectorize"
01956597cbc46d Ard Biesheuvel 2013-05-17  24  #else
01956597cbc46d Ard Biesheuvel 2013-05-17  25  /*
01956597cbc46d Ard Biesheuvel 2013-05-17  26   * While older versions of GCC do not generate incorrect code, they fail to
01956597cbc46d Ard Biesheuvel 2013-05-17  27   * recognize the parallel nature of these functions, and emit plain ARM code,
01956597cbc46d Ard Biesheuvel 2013-05-17  28   * which is known to be slower than the optimized ARM code in asm-arm/xor.h.
01956597cbc46d Ard Biesheuvel 2013-05-17  29   */
01956597cbc46d Ard Biesheuvel 2013-05-17 @30  #warning This code requires at least version 4.6 of GCC
01956597cbc46d Ard Biesheuvel 2013-05-17  31  #endif
01956597cbc46d Ard Biesheuvel 2013-05-17  32  

:::::: The code at line 30 was first introduced by commit
:::::: 01956597cbc46df072f20f90a40eebe356200c38 ARM: crypto: add NEON accelerated XOR implementation

:::::: TO: Ard Biesheuvel <ard.biesheuvel@linaro.org>
:::::: CC: Ard Biesheuvel <ard.biesheuvel@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
