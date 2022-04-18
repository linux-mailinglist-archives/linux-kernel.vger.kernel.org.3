Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463D0505E09
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 20:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347447AbiDRSqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 14:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347440AbiDRSq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 14:46:28 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACE12E68F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 11:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650307427; x=1681843427;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=N3A1POqgDp1mxQ9V0+SRZJCWPyA+HR3Nuje9R/F7YSA=;
  b=Ox+U6SKmsZFMG+axraum1aenSs/eGTQ6RIJG7H3BNbxwJjJPHT0A2hyu
   WceTLNAhH2dwnKFboAl3g6WtC6go3LnmFe+DLA+Mdr6J7sibk6EEMGog3
   hymFU6/iPGUmCre95cBsuA3/U7yqyIi7nNXFwp6g4qoKjH4wStFfhY59z
   DpSbstCAkID0uFXYkjPLYP/C5MyyatJhtoYQbl0udkwmE3a8WOEmCsg+G
   yQn6na4DoqOBX++iiMBFf/S1+gvHLCAaN9sjcwkKNIcY4s0k5qJL8Qi7y
   JN1w7vkZfA07s1w+IKZpNS+IzgG98sYxQj2kvJCf13IGDhpHNM+0myn3U
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="250889948"
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; 
   d="scan'208";a="250889948"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 11:43:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; 
   d="scan'208";a="646960579"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Apr 2022 11:43:45 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngWLh-0004sg-0E;
        Mon, 18 Apr 2022 18:43:45 +0000
Date:   Tue, 19 Apr 2022 02:43:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: arch/mips/boot/compressed/../../../../lib/lz4/lz4_decompress.c:506:5:
 warning: no previous prototype for function
 'LZ4_decompress_safe_forceExtDict'
Message-ID: <202204190231.jAoAYNgP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b2d229d4ddb17db541098b83524d901257e93845
commit: 84a0124a9d715d844675c8cfbe5bbc9147121f73 MIPS: ralink: define stubs for clk_set_parent to fix compile testing
date:   1 year, 1 month ago
config: mips-buildonly-randconfig-r002-20220418 (https://download.01.org/0day-ci/archive/20220419/202204190231.jAoAYNgP-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 429cbac0390654f90bba18a41799464adf31a5ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=84a0124a9d715d844675c8cfbe5bbc9147121f73
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 84a0124a9d715d844675c8cfbe5bbc9147121f73
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/mips/boot/compressed/decompress.c:40:6: warning: no previous prototype for function 'error' [-Wmissing-prototypes]
   void error(char *x)
        ^
   arch/mips/boot/compressed/decompress.c:40:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void error(char *x)
   ^
   static 
   In file included from arch/mips/boot/compressed/decompress.c:62:
   In file included from arch/mips/boot/compressed/../../../../lib/decompress_unlz4.c:10:
   arch/mips/boot/compressed/../../../../lib/lz4/lz4_decompress.c:484:5: warning: no previous prototype for function 'LZ4_decompress_safe_withPrefix64k' [-Wmissing-prototypes]
   int LZ4_decompress_safe_withPrefix64k(const char *source, char *dest,
       ^
   arch/mips/boot/compressed/../../../../lib/lz4/lz4_decompress.c:484:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int LZ4_decompress_safe_withPrefix64k(const char *source, char *dest,
   ^
   static 
>> arch/mips/boot/compressed/../../../../lib/lz4/lz4_decompress.c:506:5: warning: no previous prototype for function 'LZ4_decompress_safe_forceExtDict' [-Wmissing-prototypes]
   int LZ4_decompress_safe_forceExtDict(const char *source, char *dest,
       ^
   arch/mips/boot/compressed/../../../../lib/lz4/lz4_decompress.c:506:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int LZ4_decompress_safe_forceExtDict(const char *source, char *dest,
   ^
   static 
   arch/mips/boot/compressed/decompress.c:83:6: warning: no previous prototype for function '__stack_chk_fail' [-Wmissing-prototypes]
   void __stack_chk_fail(void)
        ^
   arch/mips/boot/compressed/decompress.c:83:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __stack_chk_fail(void)
   ^
   static 
   arch/mips/boot/compressed/decompress.c:88:6: warning: no previous prototype for function 'decompress_kernel' [-Wmissing-prototypes]
   void decompress_kernel(unsigned long boot_heap_start)
        ^
   arch/mips/boot/compressed/decompress.c:88:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void decompress_kernel(unsigned long boot_heap_start)
   ^
   static 
   5 warnings generated.


vim +/LZ4_decompress_safe_forceExtDict +506 arch/mips/boot/compressed/../../../../lib/lz4/lz4_decompress.c

2209fda323e2fd Gao Xiang    2018-10-30  483  
2209fda323e2fd Gao Xiang    2018-10-30 @484  int LZ4_decompress_safe_withPrefix64k(const char *source, char *dest,
2209fda323e2fd Gao Xiang    2018-10-30  485  				      int compressedSize, int maxOutputSize)
2209fda323e2fd Gao Xiang    2018-10-30  486  {
2209fda323e2fd Gao Xiang    2018-10-30  487  	return LZ4_decompress_generic(source, dest,
2209fda323e2fd Gao Xiang    2018-10-30  488  				      compressedSize, maxOutputSize,
2209fda323e2fd Gao Xiang    2018-10-30  489  				      endOnInputSize, decode_full_block,
2209fda323e2fd Gao Xiang    2018-10-30  490  				      withPrefix64k,
2209fda323e2fd Gao Xiang    2018-10-30  491  				      (BYTE *)dest - 64 * KB, NULL, 0);
2209fda323e2fd Gao Xiang    2018-10-30  492  }
2209fda323e2fd Gao Xiang    2018-10-30  493  
2209fda323e2fd Gao Xiang    2018-10-30  494  static int LZ4_decompress_safe_withSmallPrefix(const char *source, char *dest,
2209fda323e2fd Gao Xiang    2018-10-30  495  					       int compressedSize,
2209fda323e2fd Gao Xiang    2018-10-30  496  					       int maxOutputSize,
2209fda323e2fd Gao Xiang    2018-10-30  497  					       size_t prefixSize)
2209fda323e2fd Gao Xiang    2018-10-30  498  {
2209fda323e2fd Gao Xiang    2018-10-30  499  	return LZ4_decompress_generic(source, dest,
2209fda323e2fd Gao Xiang    2018-10-30  500  				      compressedSize, maxOutputSize,
2209fda323e2fd Gao Xiang    2018-10-30  501  				      endOnInputSize, decode_full_block,
2209fda323e2fd Gao Xiang    2018-10-30  502  				      noDict,
2209fda323e2fd Gao Xiang    2018-10-30  503  				      (BYTE *)dest - prefixSize, NULL, 0);
4e1a33b105ddf2 Sven Schmidt 2017-02-24  504  }
cffb78b0e0b3a3 Kyungsik Lee 2013-07-08  505  
2209fda323e2fd Gao Xiang    2018-10-30 @506  int LZ4_decompress_safe_forceExtDict(const char *source, char *dest,
2209fda323e2fd Gao Xiang    2018-10-30  507  				     int compressedSize, int maxOutputSize,
2209fda323e2fd Gao Xiang    2018-10-30  508  				     const void *dictStart, size_t dictSize)
2209fda323e2fd Gao Xiang    2018-10-30  509  {
2209fda323e2fd Gao Xiang    2018-10-30  510  	return LZ4_decompress_generic(source, dest,
2209fda323e2fd Gao Xiang    2018-10-30  511  				      compressedSize, maxOutputSize,
2209fda323e2fd Gao Xiang    2018-10-30  512  				      endOnInputSize, decode_full_block,
2209fda323e2fd Gao Xiang    2018-10-30  513  				      usingExtDict, (BYTE *)dest,
2209fda323e2fd Gao Xiang    2018-10-30  514  				      (const BYTE *)dictStart, dictSize);
2209fda323e2fd Gao Xiang    2018-10-30  515  }
2209fda323e2fd Gao Xiang    2018-10-30  516  

:::::: The code at line 506 was first introduced by commit
:::::: 2209fda323e2fd2a2d0885595fd5097717f8d2aa lib/lz4: update LZ4 decompressor module

:::::: TO: Gao Xiang <gaoxiang25@huawei.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
