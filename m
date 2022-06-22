Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E2B554C71
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358331AbiFVOOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357877AbiFVONx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:13:53 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49060B24
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655907230; x=1687443230;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zqFyLGLJ7DhoKiHZkVAFdtt7y+4WWO3jOSFhksvrO+0=;
  b=MdjgCwnnsTDw8inYIJp4fGadiqxNY5yu+c+Zy9Vyh6hqNvT+rwUxuCmL
   MXHpO4LAHXPmRVYNNSAPnLYCHD8cNiRxTLKYfnGbYk6bPcgDWpFI1C3j5
   23MwzO8nFQ+8Tq74qHfmySafykLSDA2YkiWum9vfJTSZgVy8lnl7W6fSC
   gRJlVViU0gmRuXIosb28KZyzUC/pVFFMNmxdmqb0JLYnsTf2GJEyrG/RS
   z8W17yQvPPFdiM6BViA/iCM42CWViCc6WIkNJVwoLEq81Qj5YMUz/CEW0
   D3tMNAHU/kdEQcBn8e3kKVfysw7ZQkQ2kuMxsh1NJvVA8YvKg6S+DAeAH
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="305879038"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="305879038"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 07:13:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="690519422"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 22 Jun 2022 07:13:49 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o4176-0001LX-Hw;
        Wed, 22 Jun 2022 14:13:48 +0000
Date:   Wed, 22 Jun 2022 22:12:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/xtensa/lib/kcsan-stubs.c:6:6: sparse: sparse: symbol
 '__atomic_store_8' was not declared. Should it be static?
Message-ID: <202206222246.W1MwwJo2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ca1fdab7fd27eb069df1384b2850dcd0c2bebe8d
commit: 725aea873261e8d986e527838fde2a721f0962d8 xtensa: enable KCSAN
date:   7 weeks ago
config: xtensa-randconfig-s032-20220622 (https://download.01.org/0day-ci/archive/20220622/202206222246.W1MwwJo2-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-31-g4880bd19-dirty
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
