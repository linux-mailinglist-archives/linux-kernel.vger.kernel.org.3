Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2D34B9A7A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 09:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236869AbiBQH6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 02:58:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236863AbiBQH6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 02:58:21 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3CCC9A39
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 23:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645084686; x=1676620686;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=E+S2XgOfKvZbrZXwYK6bp/IHd/T6iGi01fgJ6j+hiXo=;
  b=EAr3uNhDUTeraPLUsyOky0ymcpMYGeZ1Q6St3f8nczr/y/u0IEIcTtkD
   eB14fBHvmGO/uRXxEXGP/pqueTHnuzuQXhfvfMoftvgAvaFCIvq+TmP10
   3NGJrL798sp3b9gJ0ONbXM+NPaA0uCWqWGAtyr5lEIOg8Sjn0EWZcb7Fl
   qPUZ+2arcy7N+6Cj+zQbZt9TQDagzaTydMEp0WFLua31UL4OE16x4gUVo
   HvsefB4yXfqcH+BekH1QmguoZTZ14PZ2JjfTEvN8oVNoRXpVH2kEJo8eR
   yZJ594qckhgguTn+G1gCPEESM9YoP81ZhbEgm0I+7QrvzfHYFz34akpzE
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="234348260"
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="234348260"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 23:58:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="530022721"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 16 Feb 2022 23:58:04 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKbfv-000Bai-VH; Thu, 17 Feb 2022 07:58:03 +0000
Date:   Thu, 17 Feb 2022 15:57:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Vitor Massaru Iha <vitor@massaru.org>
Subject: [kees:for-next/overflow 4/4] lib/overflow_kunit.c:96:1: warning:
 unused variable 'u64_tests'
Message-ID: <202202171558.vQiKL7mj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/overflow
head:   df523415488222202d88ef6b3d0bad7276c52b85
commit: df523415488222202d88ef6b3d0bad7276c52b85 [4/4] lib: overflow: Convert to Kunit
config: mips-randconfig-r033-20220217 (https://download.01.org/0day-ci/archive/20220217/202202171558.vQiKL7mj-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0bad7cb56526f2572c74449fcf97c1fcda42b41d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?id=df523415488222202d88ef6b3d0bad7276c52b85
        git remote add kees https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
        git fetch --no-tags kees for-next/overflow
        git checkout df523415488222202d88ef6b3d0bad7276c52b85
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> lib/overflow_kunit.c:96:1: warning: unused variable 'u64_tests' [-Wunused-const-variable]
   DEFINE_TEST_ARRAY(u64) = {
   ^
   lib/overflow_kunit.c:26:4: note: expanded from macro 'DEFINE_TEST_ARRAY'
           } t ## _tests[]
             ^
   <scratch space>:110:1: note: expanded from here
   u64_tests
   ^
>> lib/overflow_kunit.c:193:1: warning: unused variable 's64_tests' [-Wunused-const-variable]
   DEFINE_TEST_ARRAY(s64) = {
   ^
   lib/overflow_kunit.c:26:4: note: expanded from macro 'DEFINE_TEST_ARRAY'
           } t ## _tests[]
             ^
   <scratch space>:118:1: note: expanded from here
   s64_tests
   ^
   2 warnings generated.


vim +/u64_tests +96 lib/overflow_kunit.c

455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08   95  
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  @96  DEFINE_TEST_ARRAY(u64) = {
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08   97  	{0, 0, 0, 0, 0, false, false, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08   98  	{1, 1, 2, 0, 1, false, false, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08   99  	{0, 1, 1, U64_MAX, 0, false, true, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  100  	{1, 0, 1, 1, 0, false, false, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  101  	{0, U64_MAX, U64_MAX, 1, 0, false, true, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  102  	{U64_MAX, 0, U64_MAX, U64_MAX, 0, false, false, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  103  	{1, U64_MAX, 0, 2, U64_MAX, true, true, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  104  	{U64_MAX, 1, 0, U64_MAX-1, U64_MAX, true, false, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  105  	{U64_MAX, U64_MAX, U64_MAX-1, 0, 1, true, false, true},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  106  
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  107  	{U64_MAX, U64_MAX-1, U64_MAX-2, 1, 2, true, false, true},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  108  	{U64_MAX-1, U64_MAX, U64_MAX-2, U64_MAX, 2, true, true, true},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  109  
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  110  	{1ULL << 31, 1ULL << 31, 1ULL << 32, 0, 1ULL << 62, false, false, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  111  	{1ULL << 32, 1ULL << 32, 1ULL << 33, 0, 0, false, false, true},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  112  	{1ULL << 32, 1ULL << 31, 3*(1ULL << 31), 1ULL << 31, 1ULL << 63, false, false, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  113  	{1ULL << 63, 1ULL << 63, 0, 0, 0, true, false, true},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  114  	{1000000000ULL /* 10^9 */, 10000000000ULL /* 10^10 */,
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  115  	 11000000000ULL, 18446744064709551616ULL, 10000000000000000000ULL,
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  116  	 false, true, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  117  	{-15ULL, 10ULL, -5ULL, -25ULL, -150ULL, false, false, true},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  118  };
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  119  
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  120  DEFINE_TEST_ARRAY(s8) = {
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  121  	{0, 0, 0, 0, 0, false, false, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  122  
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  123  	{0, S8_MAX, S8_MAX, -S8_MAX, 0, false, false, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  124  	{S8_MAX, 0, S8_MAX, S8_MAX, 0, false, false, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  125  	{0, S8_MIN, S8_MIN, S8_MIN, 0, false, true, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  126  	{S8_MIN, 0, S8_MIN, S8_MIN, 0, false, false, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  127  
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  128  	{-1, S8_MIN, S8_MAX, S8_MAX, S8_MIN, true, false, true},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  129  	{S8_MIN, -1, S8_MAX, -S8_MAX, S8_MIN, true, false, true},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  130  	{-1, S8_MAX, S8_MAX-1, S8_MIN, -S8_MAX, false, false, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  131  	{S8_MAX, -1, S8_MAX-1, S8_MIN, -S8_MAX, false, true, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  132  	{-1, -S8_MAX, S8_MIN, S8_MAX-1, S8_MAX, false, false, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  133  	{-S8_MAX, -1, S8_MIN, S8_MIN+2, S8_MAX, false, false, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  134  
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  135  	{1, S8_MIN, -S8_MAX, -S8_MAX, S8_MIN, false, true, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  136  	{S8_MIN, 1, -S8_MAX, S8_MAX, S8_MIN, false, true, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  137  	{1, S8_MAX, S8_MIN, S8_MIN+2, S8_MAX, true, false, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  138  	{S8_MAX, 1, S8_MIN, S8_MAX-1, S8_MAX, true, false, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  139  
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  140  	{S8_MIN, S8_MIN, 0, 0, 0, true, false, true},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  141  	{S8_MAX, S8_MAX, -2, 0, 1, true, false, true},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  142  
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  143  	{-4, -32, -36, 28, -128, false, false, true},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  144  	{-4, 32, 28, -36, -128, false, false, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  145  };
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  146  
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  147  DEFINE_TEST_ARRAY(s16) = {
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  148  	{0, 0, 0, 0, 0, false, false, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  149  
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  150  	{0, S16_MAX, S16_MAX, -S16_MAX, 0, false, false, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  151  	{S16_MAX, 0, S16_MAX, S16_MAX, 0, false, false, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  152  	{0, S16_MIN, S16_MIN, S16_MIN, 0, false, true, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  153  	{S16_MIN, 0, S16_MIN, S16_MIN, 0, false, false, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  154  
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  155  	{-1, S16_MIN, S16_MAX, S16_MAX, S16_MIN, true, false, true},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  156  	{S16_MIN, -1, S16_MAX, -S16_MAX, S16_MIN, true, false, true},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  157  	{-1, S16_MAX, S16_MAX-1, S16_MIN, -S16_MAX, false, false, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  158  	{S16_MAX, -1, S16_MAX-1, S16_MIN, -S16_MAX, false, true, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  159  	{-1, -S16_MAX, S16_MIN, S16_MAX-1, S16_MAX, false, false, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  160  	{-S16_MAX, -1, S16_MIN, S16_MIN+2, S16_MAX, false, false, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  161  
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  162  	{1, S16_MIN, -S16_MAX, -S16_MAX, S16_MIN, false, true, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  163  	{S16_MIN, 1, -S16_MAX, S16_MAX, S16_MIN, false, true, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  164  	{1, S16_MAX, S16_MIN, S16_MIN+2, S16_MAX, true, false, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  165  	{S16_MAX, 1, S16_MIN, S16_MAX-1, S16_MAX, true, false, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  166  
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  167  	{S16_MIN, S16_MIN, 0, 0, 0, true, false, true},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  168  	{S16_MAX, S16_MAX, -2, 0, 1, true, false, true},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  169  };
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  170  DEFINE_TEST_ARRAY(s32) = {
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  171  	{0, 0, 0, 0, 0, false, false, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  172  
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  173  	{0, S32_MAX, S32_MAX, -S32_MAX, 0, false, false, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  174  	{S32_MAX, 0, S32_MAX, S32_MAX, 0, false, false, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  175  	{0, S32_MIN, S32_MIN, S32_MIN, 0, false, true, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  176  	{S32_MIN, 0, S32_MIN, S32_MIN, 0, false, false, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  177  
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  178  	{-1, S32_MIN, S32_MAX, S32_MAX, S32_MIN, true, false, true},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  179  	{S32_MIN, -1, S32_MAX, -S32_MAX, S32_MIN, true, false, true},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  180  	{-1, S32_MAX, S32_MAX-1, S32_MIN, -S32_MAX, false, false, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  181  	{S32_MAX, -1, S32_MAX-1, S32_MIN, -S32_MAX, false, true, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  182  	{-1, -S32_MAX, S32_MIN, S32_MAX-1, S32_MAX, false, false, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  183  	{-S32_MAX, -1, S32_MIN, S32_MIN+2, S32_MAX, false, false, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  184  
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  185  	{1, S32_MIN, -S32_MAX, -S32_MAX, S32_MIN, false, true, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  186  	{S32_MIN, 1, -S32_MAX, S32_MAX, S32_MIN, false, true, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  187  	{1, S32_MAX, S32_MIN, S32_MIN+2, S32_MAX, true, false, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  188  	{S32_MAX, 1, S32_MIN, S32_MAX-1, S32_MAX, true, false, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  189  
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  190  	{S32_MIN, S32_MIN, 0, 0, 0, true, false, true},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  191  	{S32_MAX, S32_MAX, -2, 0, 1, true, false, true},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  192  };
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08 @193  DEFINE_TEST_ARRAY(s64) = {
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  194  	{0, 0, 0, 0, 0, false, false, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  195  
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  196  	{0, S64_MAX, S64_MAX, -S64_MAX, 0, false, false, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  197  	{S64_MAX, 0, S64_MAX, S64_MAX, 0, false, false, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  198  	{0, S64_MIN, S64_MIN, S64_MIN, 0, false, true, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  199  	{S64_MIN, 0, S64_MIN, S64_MIN, 0, false, false, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  200  
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  201  	{-1, S64_MIN, S64_MAX, S64_MAX, S64_MIN, true, false, true},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  202  	{S64_MIN, -1, S64_MAX, -S64_MAX, S64_MIN, true, false, true},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  203  	{-1, S64_MAX, S64_MAX-1, S64_MIN, -S64_MAX, false, false, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  204  	{S64_MAX, -1, S64_MAX-1, S64_MIN, -S64_MAX, false, true, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  205  	{-1, -S64_MAX, S64_MIN, S64_MAX-1, S64_MAX, false, false, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  206  	{-S64_MAX, -1, S64_MIN, S64_MIN+2, S64_MAX, false, false, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  207  
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  208  	{1, S64_MIN, -S64_MAX, -S64_MAX, S64_MIN, false, true, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  209  	{S64_MIN, 1, -S64_MAX, S64_MAX, S64_MIN, false, true, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  210  	{1, S64_MAX, S64_MIN, S64_MIN+2, S64_MAX, true, false, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  211  	{S64_MAX, 1, S64_MIN, S64_MAX-1, S64_MAX, true, false, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  212  
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  213  	{S64_MIN, S64_MIN, 0, 0, 0, true, false, true},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  214  	{S64_MAX, S64_MAX, -2, 0, 1, true, false, true},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  215  
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  216  	{-1, -1, -2, 0, 1, false, false, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  217  	{-1, -128, -129, 127, 128, false, false, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  218  	{-128, -1, -129, -127, 128, false, false, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  219  	{0, -S64_MAX, -S64_MAX, S64_MAX, 0, false, false, false},
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  220  };
455a35a6cdb6f5 lib/test_overflow.c Rasmus Villemoes 2018-05-08  221  

:::::: The code at line 96 was first introduced by commit
:::::: 455a35a6cdb6f53fe9294e23301eb056f2908bd9 lib: add runtime test of check_*_overflow functions

:::::: TO: Rasmus Villemoes <linux@rasmusvillemoes.dk>
:::::: CC: Kees Cook <keescook@chromium.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
