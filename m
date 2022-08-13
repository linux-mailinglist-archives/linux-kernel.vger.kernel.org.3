Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDB55917EB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 02:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237198AbiHMA6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 20:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbiHMA6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 20:58:04 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AAC4B4AC
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 17:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660352283; x=1691888283;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GqyOW4leQ2nz+DRKS+Yb5uj7Wm6Y4VqGQHqmdBbkWzk=;
  b=ORYnSS6thcD+yoBrP6/5blV91xlLWPT5xmOxSo+vBybPwAcQHxLT3Kq5
   jCJo7g8LPMz5pk08VCHwncssmhy+lPNGay/gy3FvW3H/MNtBW1DDMLsOI
   HYdg5On5tLW4aQVer/6/wMmv3x+ZCM5LWaFmfag31lc+/Qn+N5B/J6BMP
   DcVwnRI1rLkZ583gPFNeV3Ip6QZjGieB2lhMm1wga7tj2/t/0aQplcB3p
   gHl5bw8ny2twLdsK9pbij6z1uenN2eNOTh1HWRXqfe+tOtl6NKhCd2LOb
   l7F+KXOPoZ2NtCnwymfk2m+Rl9JRx5c/uHX9SSX0qBmLJwccZxk3EhYDZ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="292984177"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="292984177"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 17:58:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="933908113"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 12 Aug 2022 17:58:01 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMfTV-00018T-1G;
        Sat, 13 Aug 2022 00:58:01 +0000
Date:   Sat, 13 Aug 2022 08:57:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/xtensa/lib/kcsan-stubs.c:6:6: sparse: sparse: symbol
 '__atomic_store_8' was not declared. Should it be static?
Message-ID: <202208130854.GerXgHrP-lkp@intel.com>
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
head:   4a9350597aff50bbd0f4b80ccf49d2e02d1111f5
commit: 725aea873261e8d986e527838fde2a721f0962d8 xtensa: enable KCSAN
date:   3 months ago
config: xtensa-randconfig-s031-20220811 (https://download.01.org/0day-ci/archive/20220813/202208130854.GerXgHrP-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=725aea873261e8d986e527838fde2a721f0962d8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 725aea873261e8d986e527838fde2a721f0962d8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=xtensa SHELL=/bin/bash

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
