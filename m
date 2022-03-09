Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8814D28FC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 07:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiCIGb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 01:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiCIGbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 01:31:55 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A871390E6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 22:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646807457; x=1678343457;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8hoFVocM0OPzK/8uk2k/0MdxFwzM0jMpOpo4BpqyI2Y=;
  b=YSNwDwTaR9/kxWNGFWlt3ubxlq+Itp99G1zfP2jFzBZWz5FBEHsqar+I
   9VJOAsiq3OSdwxksLxO+ztodJsybH6JCU9PM24HMFnxK//BuvmV6NXSYT
   GqHm/+Gxb/qaAyhS68m+Dj8IiqXzSP80+OOU4mQk17CI6RyPw1rVFnGZH
   AbgpweeiqmYkEWSSD3242EyZarcUVnWP9E7B/VHrCHFnpoFClOW9x6ld0
   cAjvuYcV2eSWbwgGu9uHB2Vjx7auTZDpoy7gFV04suyCEotWWuQ9v5iLK
   b2mhN3JkWEVsFb6rp86QGjCwwGA0T52rlsO8cvyTQLltRA8wuWYLuKpq3
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="234852399"
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="234852399"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 22:30:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="495736191"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 08 Mar 2022 22:30:55 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRpqY-0002kE-V3; Wed, 09 Mar 2022 06:30:54 +0000
Date:   Wed, 9 Mar 2022 14:30:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mhiramat:kprobes/fprobe 12/12] test_fprobe.c:undefined reference to
 `kunit_do_assertion'
Message-ID: <202203091456.318D4uj5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git kprobes/fprobe
head:   0bd36e652ac2be74b19f414d0b20aaef6521ac82
commit: 0bd36e652ac2be74b19f414d0b20aaef6521ac82 [12/12] fprobe: Add a selftest for fprobe
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20220309/202203091456.318D4uj5-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/commit/?id=0bd36e652ac2be74b19f414d0b20aaef6521ac82
        git remote add mhiramat https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git
        git fetch --no-tags mhiramat kprobes/fprobe
        git checkout 0bd36e652ac2be74b19f414d0b20aaef6521ac82
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: lib/test_fprobe.o: in function `fp_exit_handler':
>> test_fprobe.c:(.text+0x1b0): undefined reference to `kunit_do_assertion'
>> arm-linux-gnueabi-ld: test_fprobe.c:(.text+0x268): undefined reference to `kunit_do_assertion'
   arm-linux-gnueabi-ld: test_fprobe.c:(.text+0x304): undefined reference to `kunit_do_assertion'
   arm-linux-gnueabi-ld: test_fprobe.c:(.text+0x3b0): undefined reference to `kunit_do_assertion'
   arm-linux-gnueabi-ld: test_fprobe.c:(.text+0x444): undefined reference to `kunit_do_assertion'
>> arm-linux-gnueabi-ld: test_fprobe.c:(.text+0x4d0): undefined reference to `kunit_unary_assert_format'
>> arm-linux-gnueabi-ld: test_fprobe.c:(.text+0x4d4): undefined reference to `kunit_binary_assert_format'
   arm-linux-gnueabi-ld: lib/test_fprobe.o: in function `fp_entry_handler':
   test_fprobe.c:(.text+0x630): undefined reference to `kunit_do_assertion'
   arm-linux-gnueabi-ld: test_fprobe.c:(.text+0x6cc): undefined reference to `kunit_do_assertion'
   arm-linux-gnueabi-ld: test_fprobe.c:(.text+0x760): undefined reference to `kunit_unary_assert_format'
   arm-linux-gnueabi-ld: test_fprobe.c:(.text+0x770): undefined reference to `kunit_binary_assert_format'
   arm-linux-gnueabi-ld: lib/test_fprobe.o: in function `test_fprobe_syms':
   test_fprobe.c:(.text+0x8d8): undefined reference to `kunit_do_assertion'
   arm-linux-gnueabi-ld: test_fprobe.c:(.text+0x96c): undefined reference to `kunit_do_assertion'
   arm-linux-gnueabi-ld: test_fprobe.c:(.text+0x9f8): undefined reference to `kunit_do_assertion'
   arm-linux-gnueabi-ld: test_fprobe.c:(.text+0xa8c): undefined reference to `kunit_do_assertion'
   arm-linux-gnueabi-ld: test_fprobe.c:(.text+0xb14): undefined reference to `kunit_do_assertion'
   arm-linux-gnueabi-ld: lib/test_fprobe.o:test_fprobe.c:(.text+0xb9c): more undefined references to `kunit_do_assertion' follow
   arm-linux-gnueabi-ld: lib/test_fprobe.o: in function `test_fprobe_syms':
>> test_fprobe.c:(.text+0xc30): undefined reference to `kunit_binary_assert_format'
   arm-linux-gnueabi-ld: lib/test_fprobe.o: in function `test_fprobe':
   test_fprobe.c:(.text+0xd98): undefined reference to `kunit_do_assertion'
   arm-linux-gnueabi-ld: test_fprobe.c:(.text+0xe2c): undefined reference to `kunit_do_assertion'
   arm-linux-gnueabi-ld: test_fprobe.c:(.text+0xeb8): undefined reference to `kunit_do_assertion'
   arm-linux-gnueabi-ld: test_fprobe.c:(.text+0xf4c): undefined reference to `kunit_do_assertion'
   arm-linux-gnueabi-ld: test_fprobe.c:(.text+0xfd4): undefined reference to `kunit_do_assertion'
   arm-linux-gnueabi-ld: lib/test_fprobe.o:test_fprobe.c:(.text+0x105c): more undefined references to `kunit_do_assertion' follow
   arm-linux-gnueabi-ld: lib/test_fprobe.o: in function `test_fprobe':
   test_fprobe.c:(.text+0x10ec): undefined reference to `kunit_binary_assert_format'
   arm-linux-gnueabi-ld: lib/test_fprobe.o: in function `test_fprobe_entry':
   test_fprobe.c:(.text+0x1244): undefined reference to `kunit_do_assertion'
   arm-linux-gnueabi-ld: test_fprobe.c:(.text+0x12d8): undefined reference to `kunit_do_assertion'
   arm-linux-gnueabi-ld: test_fprobe.c:(.text+0x136c): undefined reference to `kunit_do_assertion'
   arm-linux-gnueabi-ld: test_fprobe.c:(.text+0x13ec): undefined reference to `kunit_do_assertion'
   arm-linux-gnueabi-ld: test_fprobe.c:(.text+0x1480): undefined reference to `kunit_do_assertion'
   arm-linux-gnueabi-ld: lib/test_fprobe.o:test_fprobe.c:(.text+0x14fc): more undefined references to `kunit_do_assertion' follow
   arm-linux-gnueabi-ld: lib/test_fprobe.o: in function `test_fprobe_entry':
   test_fprobe.c:(.text+0x1610): undefined reference to `kunit_binary_assert_format'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
