Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F3A4E78DC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 17:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355680AbiCYQ0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 12:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241341AbiCYQ0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 12:26:45 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8515DA6C7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 09:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648225509; x=1679761509;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JXFRJowpXkg5wPAjDQ9BVxvLpcYT1cI0KeHBJN3QkdQ=;
  b=FyvP9PKO8IsmHQ1pd7E26NVRDWZ9lFg81U05blnSVCGxT/bLIAqvR8CM
   rrnBeTkD9sZ6sYmr7/uTS2tvkgMSnMevYDzz5fXiU+nhd6WWzYwnbsagL
   LSMvwjVhLRH3J665ra2WfQT4MuYLdPFe04xz5XWHv4M2oB+rAWTDjA/Cc
   p1XELOjqxRzyDu/Y/26UK8xoehToAAFvKDu/uCVuLiDdCytiLEAcHjcLf
   bSEkJIQnSyTlRDSKHImNOVsHjW7ZzaEtE/zovQ5u0uLaFWs+lF+Fza5GL
   TuAraQ/6LNv8OlFqCWAMGwFrXvJ8/ZDDuAnBn78Ihn+5FP8GspfG+XBJb
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="238607040"
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="238607040"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 09:25:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="718258995"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 25 Mar 2022 09:25:02 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nXmkI-000MND-0D; Fri, 25 Mar 2022 16:25:02 +0000
Date:   Sat, 26 Mar 2022 00:24:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Vitor Massaru Iha <vitor@massaru.org>,
        Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>
Subject: lib/overflow_kunit.c:94:1: warning: unused variable 'u64_tests'
Message-ID: <202203260011.iRtCA9Kc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   34af78c4e616c359ed428d79fe4758a35d2c5473
commit: 617f55e20743fc50c989b498f9dee289eb644cfd lib: overflow: Convert to Kunit
date:   4 weeks ago
config: hexagon-buildonly-randconfig-r005-20220324 (https://download.01.org/0day-ci/archive/20220326/202203260011.iRtCA9Kc-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=617f55e20743fc50c989b498f9dee289eb644cfd
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 617f55e20743fc50c989b498f9dee289eb644cfd
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash lib/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> lib/overflow_kunit.c:94:1: warning: unused variable 'u64_tests' [-Wunused-const-variable]
   DEFINE_TEST_ARRAY(u64) = {
   ^
   lib/overflow_kunit.c:24:4: note: expanded from macro 'DEFINE_TEST_ARRAY'
           } t ## _tests[]
             ^
   <scratch space>:114:1: note: expanded from here
   u64_tests
   ^
>> lib/overflow_kunit.c:191:1: warning: unused variable 's64_tests' [-Wunused-const-variable]
   DEFINE_TEST_ARRAY(s64) = {
   ^
   lib/overflow_kunit.c:24:4: note: expanded from macro 'DEFINE_TEST_ARRAY'
           } t ## _tests[]
             ^
   <scratch space>:122:1: note: expanded from here
   s64_tests
   ^
   2 warnings generated.


vim +/u64_tests +94 lib/overflow_kunit.c

455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08   93  
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  @94  DEFINE_TEST_ARRAY(u64) = {
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08   95  	{0, 0, 0, 0, 0, false, false, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08   96  	{1, 1, 2, 0, 1, false, false, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08   97  	{0, 1, 1, U64_MAX, 0, false, true, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08   98  	{1, 0, 1, 1, 0, false, false, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08   99  	{0, U64_MAX, U64_MAX, 1, 0, false, true, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  100  	{U64_MAX, 0, U64_MAX, U64_MAX, 0, false, false, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  101  	{1, U64_MAX, 0, 2, U64_MAX, true, true, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  102  	{U64_MAX, 1, 0, U64_MAX-1, U64_MAX, true, false, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  103  	{U64_MAX, U64_MAX, U64_MAX-1, 0, 1, true, false, true},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  104  
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  105  	{U64_MAX, U64_MAX-1, U64_MAX-2, 1, 2, true, false, true},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  106  	{U64_MAX-1, U64_MAX, U64_MAX-2, U64_MAX, 2, true, true, true},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  107  
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  108  	{1ULL << 31, 1ULL << 31, 1ULL << 32, 0, 1ULL << 62, false, false, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  109  	{1ULL << 32, 1ULL << 32, 1ULL << 33, 0, 0, false, false, true},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  110  	{1ULL << 32, 1ULL << 31, 3*(1ULL << 31), 1ULL << 31, 1ULL << 63, false, false, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  111  	{1ULL << 63, 1ULL << 63, 0, 0, 0, true, false, true},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  112  	{1000000000ULL /* 10^9 */, 10000000000ULL /* 10^10 */,
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  113  	 11000000000ULL, 18446744064709551616ULL, 10000000000000000000ULL,
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  114  	 false, true, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  115  	{-15ULL, 10ULL, -5ULL, -25ULL, -150ULL, false, false, true},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  116  };
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  117  
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  118  DEFINE_TEST_ARRAY(s8) = {
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  119  	{0, 0, 0, 0, 0, false, false, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  120  
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  121  	{0, S8_MAX, S8_MAX, -S8_MAX, 0, false, false, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  122  	{S8_MAX, 0, S8_MAX, S8_MAX, 0, false, false, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  123  	{0, S8_MIN, S8_MIN, S8_MIN, 0, false, true, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  124  	{S8_MIN, 0, S8_MIN, S8_MIN, 0, false, false, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  125  
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  126  	{-1, S8_MIN, S8_MAX, S8_MAX, S8_MIN, true, false, true},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  127  	{S8_MIN, -1, S8_MAX, -S8_MAX, S8_MIN, true, false, true},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  128  	{-1, S8_MAX, S8_MAX-1, S8_MIN, -S8_MAX, false, false, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  129  	{S8_MAX, -1, S8_MAX-1, S8_MIN, -S8_MAX, false, true, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  130  	{-1, -S8_MAX, S8_MIN, S8_MAX-1, S8_MAX, false, false, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  131  	{-S8_MAX, -1, S8_MIN, S8_MIN+2, S8_MAX, false, false, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  132  
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  133  	{1, S8_MIN, -S8_MAX, -S8_MAX, S8_MIN, false, true, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  134  	{S8_MIN, 1, -S8_MAX, S8_MAX, S8_MIN, false, true, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  135  	{1, S8_MAX, S8_MIN, S8_MIN+2, S8_MAX, true, false, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  136  	{S8_MAX, 1, S8_MIN, S8_MAX-1, S8_MAX, true, false, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  137  
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  138  	{S8_MIN, S8_MIN, 0, 0, 0, true, false, true},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  139  	{S8_MAX, S8_MAX, -2, 0, 1, true, false, true},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  140  
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  141  	{-4, -32, -36, 28, -128, false, false, true},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  142  	{-4, 32, 28, -36, -128, false, false, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  143  };
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  144  
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  145  DEFINE_TEST_ARRAY(s16) = {
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  146  	{0, 0, 0, 0, 0, false, false, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  147  
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  148  	{0, S16_MAX, S16_MAX, -S16_MAX, 0, false, false, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  149  	{S16_MAX, 0, S16_MAX, S16_MAX, 0, false, false, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  150  	{0, S16_MIN, S16_MIN, S16_MIN, 0, false, true, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  151  	{S16_MIN, 0, S16_MIN, S16_MIN, 0, false, false, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  152  
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  153  	{-1, S16_MIN, S16_MAX, S16_MAX, S16_MIN, true, false, true},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  154  	{S16_MIN, -1, S16_MAX, -S16_MAX, S16_MIN, true, false, true},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  155  	{-1, S16_MAX, S16_MAX-1, S16_MIN, -S16_MAX, false, false, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  156  	{S16_MAX, -1, S16_MAX-1, S16_MIN, -S16_MAX, false, true, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  157  	{-1, -S16_MAX, S16_MIN, S16_MAX-1, S16_MAX, false, false, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  158  	{-S16_MAX, -1, S16_MIN, S16_MIN+2, S16_MAX, false, false, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  159  
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  160  	{1, S16_MIN, -S16_MAX, -S16_MAX, S16_MIN, false, true, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  161  	{S16_MIN, 1, -S16_MAX, S16_MAX, S16_MIN, false, true, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  162  	{1, S16_MAX, S16_MIN, S16_MIN+2, S16_MAX, true, false, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  163  	{S16_MAX, 1, S16_MIN, S16_MAX-1, S16_MAX, true, false, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  164  
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  165  	{S16_MIN, S16_MIN, 0, 0, 0, true, false, true},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  166  	{S16_MAX, S16_MAX, -2, 0, 1, true, false, true},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  167  };
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  168  DEFINE_TEST_ARRAY(s32) = {
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  169  	{0, 0, 0, 0, 0, false, false, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  170  
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  171  	{0, S32_MAX, S32_MAX, -S32_MAX, 0, false, false, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  172  	{S32_MAX, 0, S32_MAX, S32_MAX, 0, false, false, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  173  	{0, S32_MIN, S32_MIN, S32_MIN, 0, false, true, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  174  	{S32_MIN, 0, S32_MIN, S32_MIN, 0, false, false, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  175  
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  176  	{-1, S32_MIN, S32_MAX, S32_MAX, S32_MIN, true, false, true},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  177  	{S32_MIN, -1, S32_MAX, -S32_MAX, S32_MIN, true, false, true},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  178  	{-1, S32_MAX, S32_MAX-1, S32_MIN, -S32_MAX, false, false, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  179  	{S32_MAX, -1, S32_MAX-1, S32_MIN, -S32_MAX, false, true, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  180  	{-1, -S32_MAX, S32_MIN, S32_MAX-1, S32_MAX, false, false, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  181  	{-S32_MAX, -1, S32_MIN, S32_MIN+2, S32_MAX, false, false, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  182  
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  183  	{1, S32_MIN, -S32_MAX, -S32_MAX, S32_MIN, false, true, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  184  	{S32_MIN, 1, -S32_MAX, S32_MAX, S32_MIN, false, true, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  185  	{1, S32_MAX, S32_MIN, S32_MIN+2, S32_MAX, true, false, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  186  	{S32_MAX, 1, S32_MIN, S32_MAX-1, S32_MAX, true, false, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  187  
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  188  	{S32_MIN, S32_MIN, 0, 0, 0, true, false, true},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  189  	{S32_MAX, S32_MAX, -2, 0, 1, true, false, true},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  190  };
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08 @191  DEFINE_TEST_ARRAY(s64) = {
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  192  	{0, 0, 0, 0, 0, false, false, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  193  
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  194  	{0, S64_MAX, S64_MAX, -S64_MAX, 0, false, false, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  195  	{S64_MAX, 0, S64_MAX, S64_MAX, 0, false, false, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  196  	{0, S64_MIN, S64_MIN, S64_MIN, 0, false, true, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  197  	{S64_MIN, 0, S64_MIN, S64_MIN, 0, false, false, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  198  
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  199  	{-1, S64_MIN, S64_MAX, S64_MAX, S64_MIN, true, false, true},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  200  	{S64_MIN, -1, S64_MAX, -S64_MAX, S64_MIN, true, false, true},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  201  	{-1, S64_MAX, S64_MAX-1, S64_MIN, -S64_MAX, false, false, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  202  	{S64_MAX, -1, S64_MAX-1, S64_MIN, -S64_MAX, false, true, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  203  	{-1, -S64_MAX, S64_MIN, S64_MAX-1, S64_MAX, false, false, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  204  	{-S64_MAX, -1, S64_MIN, S64_MIN+2, S64_MAX, false, false, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  205  
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  206  	{1, S64_MIN, -S64_MAX, -S64_MAX, S64_MIN, false, true, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  207  	{S64_MIN, 1, -S64_MAX, S64_MAX, S64_MIN, false, true, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  208  	{1, S64_MAX, S64_MIN, S64_MIN+2, S64_MAX, true, false, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  209  	{S64_MAX, 1, S64_MIN, S64_MAX-1, S64_MAX, true, false, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  210  
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  211  	{S64_MIN, S64_MIN, 0, 0, 0, true, false, true},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  212  	{S64_MAX, S64_MAX, -2, 0, 1, true, false, true},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  213  
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  214  	{-1, -1, -2, 0, 1, false, false, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  215  	{-1, -128, -129, 127, 128, false, false, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  216  	{-128, -1, -129, -127, 128, false, false, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  217  	{0, -S64_MAX, -S64_MAX, S64_MAX, 0, false, false, false},
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  218  };
455a35a6cdb6f53 lib/test_overflow.c Rasmus Villemoes 2018-05-08  219  

:::::: The code at line 94 was first introduced by commit
:::::: 455a35a6cdb6f53fe9294e23301eb056f2908bd9 lib: add runtime test of check_*_overflow functions

:::::: TO: Rasmus Villemoes <linux@rasmusvillemoes.dk>
:::::: CC: Kees Cook <keescook@chromium.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
