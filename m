Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA61354F6D3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 13:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381804AbiFQLhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 07:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380908AbiFQLhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 07:37:45 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723EBE0F7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 04:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655465862; x=1687001862;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Zulo6yS+yManqrgp8P27sEz2+gG7alfNtP7H2VV0GpI=;
  b=SGSs5v5f1bvJ2R6Lxtxj+TXvwpyg+2EICX0KVXYmMRqBR8SXbIOSZV+X
   ZEefWBFDH4/Zolrv8WrXgjC9jvEiMVvmPcz/HurvlObF+/EX6DQ/ZeOAo
   +YW2ED/nhPlR83PRQNyLr0VQuyfajrBiQr8l2iI6UKqzeiiiXbLTJ4l5M
   izXYGrWn7jHaTIRgp9CsTGTwrv0yyMNpZLyx8IxRFVFhgoO47hBCSAlb3
   8gUNv0uzs0BtHtqxJ3Tlu31V04k3uX00IUPbo5LICfcFjVwRtmdCnrrAm
   ePb6lrJPXiBW9IuK+KAj+5N2b593q3FJzIgQAKglmmB1OGlMc1jgpb+U5
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="341146160"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="341146160"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 04:37:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="713746988"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 17 Jun 2022 04:37:40 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o2AIG-000PPd-Ac;
        Fri, 17 Jun 2022 11:37:40 +0000
Date:   Fri, 17 Jun 2022 19:36:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/xtensa/lib/kcsan-stubs.c:6:6: sparse: sparse: symbol
 '__atomic_store_8' was not declared. Should it be static?
Message-ID: <202206171905.uDkZBJUr-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   47700948a4abb4a5ae13ef943ff682a7f327547a
commit: 725aea873261e8d986e527838fde2a721f0962d8 xtensa: enable KCSAN
date:   7 weeks ago
config: xtensa-randconfig-s031-20220617 (https://download.01.org/0day-ci/archive/20220617/202206171905.uDkZBJUr-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-30-g92122700-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=725aea873261e8d986e527838fde2a721f0962d8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 725aea873261e8d986e527838fde2a721f0962d8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/xtensa/lib/kcsan-stubs.c:6:6: sparse: sparse: symbol '__atomic_store_8' was not declared. Should it be static?
>> arch/xtensa/lib/kcsan-stubs.c:11:5: sparse: sparse: symbol '__atomic_load_8' was not declared. Should it be static?
>> arch/xtensa/lib/kcsan-stubs.c:16:5: sparse: sparse: symbol '__atomic_exchange_8' was not declared. Should it be static?
>> arch/xtensa/lib/kcsan-stubs.c:21:6: sparse: sparse: symbol '__atomic_compare_exchange_8' was not declared. Should it be static?
>> arch/xtensa/lib/kcsan-stubs.c:26:5: sparse: sparse: symbol '__atomic_fetch_add_8' was not declared. Should it be static?
>> arch/xtensa/lib/kcsan-stubs.c:31:5: sparse: sparse: symbol '__atomic_fetch_sub_8' was not declared. Should it be static?
>> arch/xtensa/lib/kcsan-stubs.c:36:5: sparse: sparse: symbol '__atomic_fetch_and_8' was not declared. Should it be static?
>> arch/xtensa/lib/kcsan-stubs.c:41:5: sparse: sparse: symbol '__atomic_fetch_or_8' was not declared. Should it be static?
>> arch/xtensa/lib/kcsan-stubs.c:46:5: sparse: sparse: symbol '__atomic_fetch_xor_8' was not declared. Should it be static?
>> arch/xtensa/lib/kcsan-stubs.c:51:5: sparse: sparse: symbol '__atomic_fetch_nand_8' was not declared. Should it be static?

vim +/__atomic_store_8 +6 arch/xtensa/lib/kcsan-stubs.c

     5	
   > 6	void __atomic_store_8(volatile void *p, u64 v, int i)
     7	{
     8		BUG();
     9	}
    10	
  > 11	u64 __atomic_load_8(const volatile void *p, int i)
    12	{
    13		BUG();
    14	}
    15	
  > 16	u64 __atomic_exchange_8(volatile void *p, u64 v, int i)
    17	{
    18		BUG();
    19	}
    20	
  > 21	bool __atomic_compare_exchange_8(volatile void *p1, void *p2, u64 v, bool b, int i1, int i2)
    22	{
    23		BUG();
    24	}
    25	
  > 26	u64 __atomic_fetch_add_8(volatile void *p, u64 v, int i)
    27	{
    28		BUG();
    29	}
    30	
  > 31	u64 __atomic_fetch_sub_8(volatile void *p, u64 v, int i)
    32	{
    33		BUG();
    34	}
    35	
  > 36	u64 __atomic_fetch_and_8(volatile void *p, u64 v, int i)
    37	{
    38		BUG();
    39	}
    40	
  > 41	u64 __atomic_fetch_or_8(volatile void *p, u64 v, int i)
    42	{
    43		BUG();
    44	}
    45	
  > 46	u64 __atomic_fetch_xor_8(volatile void *p, u64 v, int i)
    47	{
    48		BUG();
    49	}
    50	
  > 51	u64 __atomic_fetch_nand_8(volatile void *p, u64 v, int i)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
