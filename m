Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6371455AE21
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 04:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbiFZCFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 22:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbiFZCFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 22:05:47 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8A913E87
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 19:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656209146; x=1687745146;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mCarAyWC+otJD1oXPZsVsSW56BCUzmm6bXZLmfj9BZw=;
  b=kwPLRPk6RHD0JWZyr+PC9OSpl1wqnCDgaD0iG192Jr+wzk8DBuHWT0N9
   csUNcPKEnWN2gsOJa6Zr40ouboRG03jB0jLZNN728Y87DzFGkfZNWNFAK
   NZS9fcJd+o+SV811/j1TOZsZJo2I75M3cnlwwNaUgZziCExB2jQ/oTHFN
   24JmOQVlZydqqTu9pPW2yp1fAdiLngw51eKVaXH2/pz7lyKa/KIu87WAj
   +lR/HixRqWbLHUWDIFgc3C8R8w7u53oec1RjONU0q33YC/5AatZdeD6SV
   6l0T0xE5LvqkSRR2oDjM1OztPCuNXE4eGEbAoq4UBerq2zCHD8hQfo6Zr
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10389"; a="342923931"
X-IronPort-AV: E=Sophos;i="5.92,223,1650956400"; 
   d="scan'208";a="342923931"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 19:05:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,223,1650956400"; 
   d="scan'208";a="835665819"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 25 Jun 2022 19:05:44 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o5Heh-0006bf-MN;
        Sun, 26 Jun 2022 02:05:43 +0000
Date:   Sun, 26 Jun 2022 10:04:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [norov:fns 24/24] lib/test_bitmap.c:226:30: error: use of undeclared
 identifier 'EXP1_IN_BITS'
Message-ID: <202206260952.cf6IJRdW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/norov/linux fns
head:   c6f11d769095eb58ae2f05e3df1d8e71b7ccc5d7
commit: c6f11d769095eb58ae2f05e3df1d8e71b7ccc5d7 [24/24] fixes
config: arm64-randconfig-r015-20220626
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b0d6dd3905db145853c7c744ac92d49b00b1fa20)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/norov/linux/commit/c6f11d769095eb58ae2f05e3df1d8e71b7ccc5d7
        git remote add norov https://github.com/norov/linux
        git fetch --no-tags norov fns
        git checkout c6f11d769095eb58ae2f05e3df1d8e71b7ccc5d7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash lib/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> lib/test_bitmap.c:226:30: error: use of undeclared identifier 'EXP1_IN_BITS'
           for_each_set_bit(bit, exp1, EXP1_IN_BITS) {
                                       ^
>> lib/test_bitmap.c:226:30: error: use of undeclared identifier 'EXP1_IN_BITS'
>> lib/test_bitmap.c:226:30: error: use of undeclared identifier 'EXP1_IN_BITS'
   lib/test_bitmap.c:227:26: error: use of undeclared identifier 'EXP1_IN_BITS'
                   b = find_nth_bit(exp1, EXP1_IN_BITS, ++cnt);
                                          ^
   lib/test_bitmap.c:234:46: error: use of undeclared identifier 'EXP1_IN_BITS'
           const unsigned long w = bitmap_weight(exp1, EXP1_IN_BITS);
                                                       ^
   lib/test_bitmap.c:237:26: error: use of undeclared identifier 'EXP1_IN_BITS'
           for (start = 0; start < EXP1_IN_BITS; start++) {
                                   ^
   lib/test_bitmap.c:240:36: error: use of undeclared identifier 'EXP1_IN_BITS'
                   for_each_set_bit_wrap(bit, exp1, EXP1_IN_BITS, start)
                                                    ^
   lib/test_bitmap.c:240:36: error: use of undeclared identifier 'EXP1_IN_BITS'
   lib/test_bitmap.c:240:36: error: use of undeclared identifier 'EXP1_IN_BITS'
   9 errors generated.


vim +/EXP1_IN_BITS +226 lib/test_bitmap.c

   221	
   222	static void __init test_find_nth_bit(void)
   223	{
   224		unsigned long b, bit, cnt = 0;
   225	
 > 226		for_each_set_bit(bit, exp1, EXP1_IN_BITS) {
   227			b = find_nth_bit(exp1, EXP1_IN_BITS, ++cnt);
   228			expect_eq_uint(b, bit);
   229		}
   230	}
   231	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
