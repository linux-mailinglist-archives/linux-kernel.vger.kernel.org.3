Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD24B55418C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 06:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356517AbiFVEYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 00:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344613AbiFVEYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:24:37 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D6234B9A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 21:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655871874; x=1687407874;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=O6xYWgQemG6nr5bhS6m6jeRB5zczhAPkWsbAdKfjEBg=;
  b=dxXvTdOd9VeRc8of1lr32hQuXllvOneDoGqqXrw7JGNUsLN7z9z+6QPy
   E5dG0LqAOGY0sRrlyT7rVF38sWv9YL5EZbVdbLlSEdcEz/SlyvecuXyZS
   XY+mxJxKoTNKeG+MaQYHqyNgj4JbBjZrTaFtcm8E6BrTx56KVnHcCWMx8
   rCeSHMGk8j8+XbN/muVrZQWy2c19oIXKI5XbfNbGcsGQYRWCP/FR+a8Yh
   /wC8Ci8exOIgyQ1Id2GdtTyHgaSROTzaQiiU1iQqGRaGOr2Yo+XlNjm5C
   /4sEAMqu0CGo54F4tMpy9VlYkR+bdCgspJTsGtTmXcLbBxpojJilRvR/b
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="269028000"
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; 
   d="scan'208";a="269028000"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 21:24:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; 
   d="scan'208";a="690281812"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 21 Jun 2022 21:24:31 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3ruo-0000pd-VM;
        Wed, 22 Jun 2022 04:24:30 +0000
Date:   Wed, 22 Jun 2022 12:23:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Gow <davidgow@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>
Subject: aarch64-linux-ld: test.c:undefined reference to
 `kunit_binary_ptr_assert_format'
Message-ID: <202206221211.7TdoqtLb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel-lab-lkp/linux/commits/David-Gow/Rework-KUnit-test-execution-in-modules/20220621-165710
head:   7bfabdc25e47572121004b8e6bcfc74d4bda3252
commit: 645eaaa1b362ad721c49e0bb208f95f068dfed46 thunderbolt: test: Use kunit_test_suite() macro
date:   19 hours ago
config: arm64-randconfig-r002-20220620 (https://download.01.org/0day-ci/archive/20220622/202206221211.7TdoqtLb-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/645eaaa1b362ad721c49e0bb208f95f068dfed46
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review David-Gow/Rework-KUnit-test-execution-in-modules/20220621-165710
        git checkout 645eaaa1b362ad721c49e0bb208f95f068dfed46
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   aarch64-linux-ld: Unexpected GOT/PLT entries detected!
   aarch64-linux-ld: Unexpected run-time procedure linkages detected!
   aarch64-linux-ld: ID map text too big or misaligned
   aarch64-linux-ld: drivers/thunderbolt/test.o: in function `compare_dirs':
   test.c:(.text+0x1c0): undefined reference to `kunit_binary_ptr_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_ptr_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x1c0): dangerous relocation: unsupported relocation
>> aarch64-linux-ld: test.c:(.text+0x1c4): undefined reference to `kunit_binary_ptr_assert_format'
>> aarch64-linux-ld: test.c:(.text+0x39c): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x39c): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x3a0): undefined reference to `kunit_binary_assert_format'
>> aarch64-linux-ld: test.c:(.text+0x3c8): undefined reference to `kunit_do_failed_assertion'
>> aarch64-linux-ld: test.c:(.text+0x41c): undefined reference to `kunit_fail_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_fail_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x41c): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x420): undefined reference to `kunit_fail_assert_format'
   aarch64-linux-ld: test.c:(.text+0x438): undefined reference to `kunit_do_failed_assertion'
>> aarch64-linux-ld: test.c:(.text+0x494): undefined reference to `kunit_binary_str_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_str_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x494): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x498): undefined reference to `kunit_binary_str_assert_format'
   aarch64-linux-ld: test.c:(.text+0x4bc): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x4c8): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x4c8): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x4cc): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: test.c:(.text+0x4f0): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x500): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x500): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x504): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: test.c:(.text+0x52c): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x538): undefined reference to `kunit_binary_str_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_str_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x538): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x53c): undefined reference to `kunit_binary_str_assert_format'
   aarch64-linux-ld: test.c:(.text+0x560): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x590): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x5c0): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x5d8): undefined reference to `kunit_binary_ptr_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_ptr_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x5d8): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x5dc): undefined reference to `kunit_binary_ptr_assert_format'
   aarch64-linux-ld: test.c:(.text+0x5fc): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x618): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x618): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x61c): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: test.c:(.text+0x640): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x654): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x654): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x65c): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: test.c:(.text+0x680): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x6a4): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x6a4): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x6ac): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: test.c:(.text+0x6d0): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x700): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x734): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x774): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x7ac): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: drivers/thunderbolt/test.o:test.c:(.text+0x7f0): more undefined references to `kunit_do_failed_assertion' follow
   aarch64-linux-ld: drivers/thunderbolt/test.o: in function `compare_dirs':
   test.c:(.text+0x86c): undefined reference to `kunit_binary_ptr_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_ptr_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x86c): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x874): undefined reference to `kunit_binary_ptr_assert_format'
   aarch64-linux-ld: test.c:(.text+0x894): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x8e0): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: drivers/thunderbolt/test.o: in function `tb_test_property_copy':
   test.c:(.text+0x9cc): undefined reference to `kunit_kmalloc_array'
   aarch64-linux-ld: test.c:(.text+0x9fc): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x9fc): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0xa04): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: test.c:(.text+0xa6c): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0xaf4): undefined reference to `kunit_binary_ptr_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_ptr_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0xaf4): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0xaf8): undefined reference to `kunit_binary_ptr_assert_format'
   aarch64-linux-ld: test.c:(.text+0xb18): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0xb34): undefined reference to `kunit_binary_ptr_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_ptr_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0xb34): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0xb38): undefined reference to `kunit_binary_ptr_assert_format'
   aarch64-linux-ld: test.c:(.text+0xb58): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0xb6c): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0xb6c): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0xb70): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: test.c:(.text+0xb94): undefined reference to `kunit_do_failed_assertion'
>> aarch64-linux-ld: test.c:(.text+0xba8): undefined reference to `kunit_kmalloc_array'
   aarch64-linux-ld: test.c:(.text+0xbbc): undefined reference to `kunit_binary_ptr_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_ptr_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0xbbc): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0xbc0): undefined reference to `kunit_binary_ptr_assert_format'
   aarch64-linux-ld: test.c:(.text+0xbe0): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0xc20): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: drivers/thunderbolt/test.o: in function `tb_test_property_format':
   test.c:(.text+0xce0): undefined reference to `kunit_kmalloc_array'
   aarch64-linux-ld: test.c:(.text+0xd14): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0xd14): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0xd1c): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: test.c:(.text+0xd7c): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0xdf0): undefined reference to `kunit_binary_ptr_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_ptr_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0xdf0): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0xdf4): undefined reference to `kunit_binary_ptr_assert_format'
   aarch64-linux-ld: test.c:(.text+0xe14): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0xe3c): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0xe3c): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0xe40): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: test.c:(.text+0xe64): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0xe78): undefined reference to `kunit_kmalloc_array'
   aarch64-linux-ld: test.c:(.text+0xe8c): undefined reference to `kunit_binary_ptr_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_ptr_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0xe8c): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0xe90): undefined reference to `kunit_binary_ptr_assert_format'
   aarch64-linux-ld: test.c:(.text+0xeb0): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0xed4): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0xed4): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0xed8): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: test.c:(.text+0xef8): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: drivers/thunderbolt/test.o: in function `TB_TEST_DMA_TUNNEL2.isra.0':
   test.c:(.text+0x1158): undefined reference to `kunit_binary_ptr_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_ptr_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x1158): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x115c): undefined reference to `kunit_binary_ptr_assert_format'
   aarch64-linux-ld: test.c:(.text+0x117c): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x11a4): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x11a4): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x11ac): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: test.c:(.text+0x11d0): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x11ec): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x11ec): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x11f0): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: test.c:(.text+0x1218): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x124c): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x124c): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x1254): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: test.c:(.text+0x1270): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x12ac): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x12ac): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x12b4): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: test.c:(.text+0x12d4): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x130c): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x130c): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x1314): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: test.c:(.text+0x1330): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x136c): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x136c): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x1370): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: test.c:(.text+0x1394): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x13b0): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x13b0): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x13b4): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: test.c:(.text+0x13dc): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x1414): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x1414): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x141c): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: test.c:(.text+0x1438): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x146c): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x146c): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x1474): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: test.c:(.text+0x1490): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x14cc): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x14cc): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x14d4): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: test.c:(.text+0x14f0): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x152c): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x152c): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x1530): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: test.c:(.text+0x1554): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: drivers/thunderbolt/test.o: in function `TB_TEST_DMA_TUNNEL1.isra.0':
   test.c:(.text+0x1778): undefined reference to `kunit_binary_ptr_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_ptr_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x1778): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x177c): undefined reference to `kunit_binary_ptr_assert_format'
--
   aarch64-linux-ld: test.c:(.text+0x2fac): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x2fe4): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x2fe4): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x2fec): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: test.c:(.text+0x3008): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x3044): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x3044): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x3048): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: test.c:(.text+0x306c): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x3088): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x3088): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x308c): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: test.c:(.text+0x30b4): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x30ec): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x30ec): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x30f4): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: test.c:(.text+0x3110): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x314c): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x314c): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x3154): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: test.c:(.text+0x3174): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x31ac): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x31ac): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x31b4): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: test.c:(.text+0x31d0): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x320c): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x320c): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x3210): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: test.c:(.text+0x3234): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: drivers/thunderbolt/test.o: in function `TB_TEST_PCIE_TUNNEL.isra.0':
   test.c:(.text+0x3450): undefined reference to `kunit_binary_ptr_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_ptr_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x3450): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x3454): undefined reference to `kunit_binary_ptr_assert_format'
   aarch64-linux-ld: test.c:(.text+0x3474): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x349c): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x349c): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x34a4): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: test.c:(.text+0x34c8): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x34e4): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x34e4): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x34e8): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: test.c:(.text+0x3510): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x3544): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x3544): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x354c): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: test.c:(.text+0x3568): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x35a4): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x35a4): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x35ac): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: test.c:(.text+0x35cc): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x3604): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x3604): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x360c): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: test.c:(.text+0x3628): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x3664): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x3664): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x3668): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: test.c:(.text+0x368c): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x36a8): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x36a8): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x36ac): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: test.c:(.text+0x36d4): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x370c): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x370c): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x3714): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: test.c:(.text+0x3730): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x376c): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x376c): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x3774): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: test.c:(.text+0x3794): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x37cc): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x37cc): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x37d4): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: test.c:(.text+0x37f0): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x382c): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x382c): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x3830): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: test.c:(.text+0x3854): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: drivers/thunderbolt/test.o: in function `alloc_switch':
   test.c:(.text+0x3898): undefined reference to `kunit_kmalloc_array'
   aarch64-linux-ld: test.c:(.text+0x3948): undefined reference to `kunit_kmalloc_array'
>> aarch64-linux-ld: test.c:(.text+0x3a84): undefined reference to `__kunit_add_resource'
   aarch64-linux-ld: test.c:(.text+0x3b04): undefined reference to `__kunit_add_resource'
   aarch64-linux-ld: drivers/thunderbolt/test.o: in function `tb_test_tunnel_dma_tx':
   test.c:(.text+0x4464): undefined reference to `kunit_binary_ptr_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_ptr_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x4464): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x4468): undefined reference to `kunit_binary_ptr_assert_format'
   aarch64-linux-ld: test.c:(.text+0x4488): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x44b4): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x44b4): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x44b8): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: test.c:(.text+0x44dc): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x4504): undefined reference to `kunit_binary_ptr_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_ptr_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x4504): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x450c): undefined reference to `kunit_binary_ptr_assert_format'
   aarch64-linux-ld: test.c:(.text+0x452c): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x4554): undefined reference to `kunit_binary_ptr_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_ptr_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x4554): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x455c): undefined reference to `kunit_binary_ptr_assert_format'
   aarch64-linux-ld: test.c:(.text+0x457c): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x45a4): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x45a4): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x45ac): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: test.c:(.text+0x45d0): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x45ec): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x45ec): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x45f4): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: test.c:(.text+0x4614): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x465c): undefined reference to `kunit_binary_ptr_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_ptr_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x465c): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x4664): undefined reference to `kunit_binary_ptr_assert_format'
   aarch64-linux-ld: test.c:(.text+0x4684): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x46d4): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x46d4): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x46dc): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: test.c:(.text+0x46fc): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x4744): undefined reference to `kunit_binary_ptr_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_ptr_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x4744): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x474c): undefined reference to `kunit_binary_ptr_assert_format'
   aarch64-linux-ld: test.c:(.text+0x476c): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x47bc): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x47bc): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x47c0): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: test.c:(.text+0x47e4): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: drivers/thunderbolt/test.o: in function `tb_test_tunnel_dma_rx':
   test.c:(.text+0x49e4): undefined reference to `kunit_binary_ptr_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_ptr_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x49e4): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x49e8): undefined reference to `kunit_binary_ptr_assert_format'
   aarch64-linux-ld: test.c:(.text+0x4a08): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x4a34): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x4a34): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x4a38): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: test.c:(.text+0x4a5c): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x4a84): undefined reference to `kunit_binary_ptr_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_ptr_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x4a84): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x4a8c): undefined reference to `kunit_binary_ptr_assert_format'
   aarch64-linux-ld: test.c:(.text+0x4aac): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x4ad4): undefined reference to `kunit_binary_ptr_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_ptr_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x4ad4): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x4adc): undefined reference to `kunit_binary_ptr_assert_format'
   aarch64-linux-ld: test.c:(.text+0x4afc): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x4b24): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x4b24): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x4b2c): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: test.c:(.text+0x4b50): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x4b6c): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x4b6c): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x4b74): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: test.c:(.text+0x4b94): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x4bdc): undefined reference to `kunit_binary_ptr_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_ptr_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x4bdc): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x4be4): undefined reference to `kunit_binary_ptr_assert_format'
   aarch64-linux-ld: test.c:(.text+0x4c04): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x4c54): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x4c54): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x4c5c): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: test.c:(.text+0x4c7c): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x4cc4): undefined reference to `kunit_binary_ptr_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_ptr_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC
   test.c:(.text+0x4cc4): dangerous relocation: unsupported relocation
   aarch64-linux-ld: test.c:(.text+0x4ccc): undefined reference to `kunit_binary_ptr_assert_format'
   aarch64-linux-ld: test.c:(.text+0x4cec): undefined reference to `kunit_do_failed_assertion'
   aarch64-linux-ld: test.c:(.text+0x4d3c): undefined reference to `kunit_binary_assert_format'
   aarch64-linux-ld: drivers/thunderbolt/test.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kunit_binary_assert_format' which may bind externally can not be used when making a shared object; recompile with -fPIC

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
