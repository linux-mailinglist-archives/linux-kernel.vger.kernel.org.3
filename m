Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660954C2CFA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 14:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234919AbiBXN3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 08:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234875AbiBXN25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 08:28:57 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBE7B0E89
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 05:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645709307; x=1677245307;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LoqcSXr8ZR938wLLsg1RNHp6T8lxDPpNtf7BGbJ/kUM=;
  b=eyQDuXfIAxFkC3iq8gdKJiKzzCQE9Djew5ih+TNRSNb5wfKW5ni0bpwF
   +QdhGsMTPRMOpsi811i9llxuGt0N37uatNEMfpmGf+TLoz7Sa9ApaCVhL
   sUns4D7995qGG+8df3VgeKAC+znWFgV52OKYcVOcbHsTsXrLj74H26UWy
   EKrxSf1ocaMYKZG1Y3sgEsS0t0rxZGsod4EDvN3A5jwHCpMNPUkDdIgcR
   zkMxBvCyUqXm0wHTM9NbVZvhCR/trPiGknk1PVtkQXJ9LBfCfdm2XIv7f
   UM6Cpmdg+HNTkiPHyfOsXHoRgpOxAkAnlKzW+lWq8uSzPd5hh1i9IM7Xq
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="315455426"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="315455426"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 05:28:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="777053010"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 24 Feb 2022 05:28:23 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNEAQ-00038M-JZ; Thu, 24 Feb 2022 13:28:22 +0000
Date:   Thu, 24 Feb 2022 21:27:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kees:for-next/overflow 5/7] lib/stackinit_kunit.c:440:1: sparse:
 sparse: Using plain integer as NULL pointer
Message-ID: <202202242127.wh8nEbxG-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/overflow
head:   2ee9b438ef95e4d1a41fba18fd837d1cea67d4a8
commit: 29b768fc54fe40d97b8aef390ab9dc4ec74cf773 [5/7] lib: stackinit: Convert to KUnit
config: arm-randconfig-s031-20220223 (https://download.01.org/0day-ci/archive/20220224/202202242127.wh8nEbxG-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?id=29b768fc54fe40d97b8aef390ab9dc4ec74cf773
        git remote add kees https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
        git fetch --no-tags kees for-next/overflow
        git checkout 29b768fc54fe40d97b8aef390ab9dc4ec74cf773
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> lib/stackinit_kunit.c:440:1: sparse: sparse: Using plain integer as NULL pointer
>> lib/stackinit_kunit.c:440:1: sparse: sparse: Using plain integer as NULL pointer
>> lib/stackinit_kunit.c:440:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:442:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:442:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:442:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:442:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:442:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:442:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:442:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:442:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:442:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:442:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:443:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:443:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:443:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:443:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:443:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:443:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:444:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:444:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:444:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:444:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:444:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:444:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:444:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:444:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:444:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:444:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:445:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:445:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:445:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:445:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:445:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:445:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:445:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:445:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:445:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:445:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:446:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:446:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:446:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:446:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:446:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:446:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:447:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:447:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:447:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:450:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:450:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:450:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:452:1: sparse: sparse: Using plain integer as NULL pointer

vim +440 lib/stackinit_kunit.c

50ceaa95ea0970 lib/test_stackinit.c Kees Cook 2019-01-23  408  
a8fc576d4af2f2 lib/test_stackinit.c Kees Cook 2021-07-23  409  #define DEFINE_SCALAR_TEST(name, init, xfail)			\
a8fc576d4af2f2 lib/test_stackinit.c Kees Cook 2021-07-23  410  		DEFINE_TEST(name ## _ ## init, name, SCALAR,	\
a8fc576d4af2f2 lib/test_stackinit.c Kees Cook 2021-07-23  411  			    init, xfail)
50ceaa95ea0970 lib/test_stackinit.c Kees Cook 2019-01-23  412  
a8fc576d4af2f2 lib/test_stackinit.c Kees Cook 2021-07-23  413  #define DEFINE_SCALAR_TESTS(init, xfail)			\
a8fc576d4af2f2 lib/test_stackinit.c Kees Cook 2021-07-23  414  		DEFINE_SCALAR_TEST(u8, init, xfail);		\
a8fc576d4af2f2 lib/test_stackinit.c Kees Cook 2021-07-23  415  		DEFINE_SCALAR_TEST(u16, init, xfail);		\
a8fc576d4af2f2 lib/test_stackinit.c Kees Cook 2021-07-23  416  		DEFINE_SCALAR_TEST(u32, init, xfail);		\
a8fc576d4af2f2 lib/test_stackinit.c Kees Cook 2021-07-23  417  		DEFINE_SCALAR_TEST(u64, init, xfail);		\
a8fc576d4af2f2 lib/test_stackinit.c Kees Cook 2021-07-23  418  		DEFINE_TEST(char_array_ ## init, unsigned char,	\
a8fc576d4af2f2 lib/test_stackinit.c Kees Cook 2021-07-23  419  			    STRING, init, xfail)
50ceaa95ea0970 lib/test_stackinit.c Kees Cook 2019-01-23  420  
a8fc576d4af2f2 lib/test_stackinit.c Kees Cook 2021-07-23  421  #define DEFINE_STRUCT_TEST(name, init, xfail)			\
50ceaa95ea0970 lib/test_stackinit.c Kees Cook 2019-01-23  422  		DEFINE_TEST(name ## _ ## init,			\
a8fc576d4af2f2 lib/test_stackinit.c Kees Cook 2021-07-23  423  			    struct test_ ## name, STRUCT, init, \
a8fc576d4af2f2 lib/test_stackinit.c Kees Cook 2021-07-23  424  			    xfail)
a8fc576d4af2f2 lib/test_stackinit.c Kees Cook 2021-07-23  425  
a8fc576d4af2f2 lib/test_stackinit.c Kees Cook 2021-07-23  426  #define DEFINE_STRUCT_TESTS(init, xfail)			\
a8fc576d4af2f2 lib/test_stackinit.c Kees Cook 2021-07-23  427  		DEFINE_STRUCT_TEST(small_hole, init, xfail);	\
a8fc576d4af2f2 lib/test_stackinit.c Kees Cook 2021-07-23  428  		DEFINE_STRUCT_TEST(big_hole, init, xfail);	\
a8fc576d4af2f2 lib/test_stackinit.c Kees Cook 2021-07-23  429  		DEFINE_STRUCT_TEST(trailing_hole, init, xfail);	\
a8fc576d4af2f2 lib/test_stackinit.c Kees Cook 2021-07-23  430  		DEFINE_STRUCT_TEST(packed, init, xfail)
50ceaa95ea0970 lib/test_stackinit.c Kees Cook 2019-01-23  431  
a8fc576d4af2f2 lib/test_stackinit.c Kees Cook 2021-07-23  432  #define DEFINE_STRUCT_INITIALIZER_TESTS(base)			\
a8fc576d4af2f2 lib/test_stackinit.c Kees Cook 2021-07-23  433  		DEFINE_STRUCT_TESTS(base ## _ ## partial,	\
a8fc576d4af2f2 lib/test_stackinit.c Kees Cook 2021-07-23  434  				    WANT_SUCCESS);		\
a8fc576d4af2f2 lib/test_stackinit.c Kees Cook 2021-07-23  435  		DEFINE_STRUCT_TESTS(base ## _ ## all,		\
a8fc576d4af2f2 lib/test_stackinit.c Kees Cook 2021-07-23  436  				    WANT_SUCCESS)
50ceaa95ea0970 lib/test_stackinit.c Kees Cook 2019-01-23  437  
50ceaa95ea0970 lib/test_stackinit.c Kees Cook 2019-01-23  438  /* These should be fully initialized all the time! */
a8fc576d4af2f2 lib/test_stackinit.c Kees Cook 2021-07-23  439  DEFINE_SCALAR_TESTS(zero, WANT_SUCCESS);
a8fc576d4af2f2 lib/test_stackinit.c Kees Cook 2021-07-23 @440  DEFINE_STRUCT_TESTS(zero, WANT_SUCCESS);
a8fc576d4af2f2 lib/test_stackinit.c Kees Cook 2021-07-23  441  /* Struct initializers: padding may be left uninitialized. */
a8fc576d4af2f2 lib/test_stackinit.c Kees Cook 2021-07-23  442  DEFINE_STRUCT_INITIALIZER_TESTS(static);
a8fc576d4af2f2 lib/test_stackinit.c Kees Cook 2021-07-23  443  DEFINE_STRUCT_INITIALIZER_TESTS(dynamic);
a8fc576d4af2f2 lib/test_stackinit.c Kees Cook 2021-07-23  444  DEFINE_STRUCT_INITIALIZER_TESTS(runtime);
a8fc576d4af2f2 lib/test_stackinit.c Kees Cook 2021-07-23  445  DEFINE_STRUCT_INITIALIZER_TESTS(assigned_static);
a8fc576d4af2f2 lib/test_stackinit.c Kees Cook 2021-07-23  446  DEFINE_STRUCT_INITIALIZER_TESTS(assigned_dynamic);
a8fc576d4af2f2 lib/test_stackinit.c Kees Cook 2021-07-23  447  DEFINE_STRUCT_TESTS(assigned_copy, XFAIL);
50ceaa95ea0970 lib/test_stackinit.c Kees Cook 2019-01-23  448  /* No initialization without compiler instrumentation. */
a8fc576d4af2f2 lib/test_stackinit.c Kees Cook 2021-07-23  449  DEFINE_SCALAR_TESTS(none, WANT_SUCCESS);
a8fc576d4af2f2 lib/test_stackinit.c Kees Cook 2021-07-23  450  DEFINE_STRUCT_TESTS(none, WANT_SUCCESS);
a8fc576d4af2f2 lib/test_stackinit.c Kees Cook 2021-07-23  451  /* Initialization of members with __user attribute. */
a8fc576d4af2f2 lib/test_stackinit.c Kees Cook 2021-07-23  452  DEFINE_TEST(user, struct test_user, STRUCT, none, WANT_SUCCESS);
50ceaa95ea0970 lib/test_stackinit.c Kees Cook 2019-01-23  453  

:::::: The code at line 440 was first introduced by commit
:::::: a8fc576d4af2f23a87a586424252df97f0ad0b06 lib/test_stackinit: Add assigned initializers

:::::: TO: Kees Cook <keescook@chromium.org>
:::::: CC: Kees Cook <keescook@chromium.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
