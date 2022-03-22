Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CB34E37A6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 04:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236184AbiCVDlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 23:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236157AbiCVDlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 23:41:13 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37286262
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 20:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647920386; x=1679456386;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iNJVsi91LXwI+KDYvgStCpTZNqDYFiZwPuSi1+SqKLg=;
  b=Z2oYULGAcvE/1eFrdnXOIsWRUgzo8L34YGaVOIar/eK1oYVXW6ypfnq2
   /2art43Rs9qeIbRU3vYLJg2MT0koszO+d2CYuGaT+W94SbD3F+nJRewZL
   cqJ5/IVaEn8TdTmgK9tgVScyNiN3ttpvpY1njhHM2F13zLyquxwQZ1WIs
   ul8C0rfgUPexpd0Bm6RYQgaMM7OzS9hEwPMu3/fEx2oIfza6R7OMhk51o
   Kv+wjzaGff03SniCZHvi+q+WjbrWAKhZQ1nMNX9oCutzMddxfJ0zYl5DN
   4le9Hil3oP2bna9knY0dH3PBwH9woear5Mnjd2tFvCt9/vUOpDTFmfJjZ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="238318234"
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="238318234"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 20:39:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="648819314"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 21 Mar 2022 20:39:44 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWVN1-000IRL-Ct; Tue, 22 Mar 2022 03:39:43 +0000
Date:   Tue, 22 Mar 2022 11:38:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, build@wireguard.com,
        linux-kernel@vger.kernel.org
Subject: [zx2c4-wireguard:devel 1/2] lib/crypto/poly1305-selftest.c:1043:13:
 warning: no previous prototype for function 'poly1305_selftest'
Message-ID: <202203221101.Vd8pIU2T-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/wireguard-linux.git devel
head:   85edbe4cea2a4446b6425d67a00c04dce142b2f2
commit: 957612a1219877cad2e0fd43f89dea54575db069 [1/2] crypto: poly1305 - add library selftests
config: s390-randconfig-r044-20220320 (https://download.01.org/0day-ci/archive/20220322/202203221101.Vd8pIU2T-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 85e9b2687a13d1908aa86d1b89c5ce398a06cd39)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/wireguard-linux.git/commit/?id=957612a1219877cad2e0fd43f89dea54575db069
        git remote add zx2c4-wireguard https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/wireguard-linux.git
        git fetch --no-tags zx2c4-wireguard devel
        git checkout 957612a1219877cad2e0fd43f89dea54575db069
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash lib/crypto/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> lib/crypto/poly1305-selftest.c:1043:13: warning: no previous prototype for function 'poly1305_selftest' [-Wmissing-prototypes]
   bool __init poly1305_selftest(void)
               ^
   lib/crypto/poly1305-selftest.c:1043:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   bool __init poly1305_selftest(void)
   ^
   static 
   1 warning generated.


vim +/poly1305_selftest +1043 lib/crypto/poly1305-selftest.c

  1042	
> 1043	bool __init poly1305_selftest(void)
  1044	{
  1045		bool success = true;
  1046		size_t i, j;
  1047	
  1048		for (i = 0; i < ARRAY_SIZE(poly1305_testvecs); ++i) {
  1049			struct poly1305_desc_ctx poly1305;
  1050			u8 out[POLY1305_DIGEST_SIZE];
  1051	
  1052			memset(out, 0, sizeof(out));
  1053			memset(&poly1305, 0, sizeof(poly1305));
  1054			poly1305_init(&poly1305, poly1305_testvecs[i].key);
  1055			poly1305_update(&poly1305, poly1305_testvecs[i].input,
  1056					poly1305_testvecs[i].ilen);
  1057			poly1305_final(&poly1305, out);
  1058			if (memcmp(out, poly1305_testvecs[i].output,
  1059				   POLY1305_DIGEST_SIZE)) {
  1060				pr_err("poly1305 self-test %zu: FAIL\n", i + 1);
  1061				success = false;
  1062			}
  1063	
  1064			if (poly1305_testvecs[i].ilen <= 1)
  1065				continue;
  1066	
  1067			for (j = 1; j < poly1305_testvecs[i].ilen - 1; ++j) {
  1068				memset(out, 0, sizeof(out));
  1069				memset(&poly1305, 0, sizeof(poly1305));
  1070				poly1305_init(&poly1305, poly1305_testvecs[i].key);
  1071				poly1305_update(&poly1305, poly1305_testvecs[i].input, j);
  1072				poly1305_update(&poly1305,
  1073						poly1305_testvecs[i].input + j,
  1074						poly1305_testvecs[i].ilen - j);
  1075				poly1305_final(&poly1305, out);
  1076				if (memcmp(out, poly1305_testvecs[i].output,
  1077					   POLY1305_DIGEST_SIZE)) {
  1078					pr_err("poly1305 self-test %zu (split %zu): FAIL\n",
  1079					       i + 1, j);
  1080					success = false;
  1081				}
  1082	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
