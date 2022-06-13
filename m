Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0045B54A09C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351525AbiFMU6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352307AbiFMUyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:54:24 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14AF2AE27
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655151781; x=1686687781;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=N038XF4yXax+ax5Xz1/KbtiavNJ/kZQoXcCHh/Meig8=;
  b=PWzfZulGB07/wsdJKQtRLtJxJQYzKGqYSibX9cMwLc/qoRTAqnd+paNY
   8He8clQMcrUmFLMtKz3rzFFVwNn9XWHQwWiEzzp8pWLiIRqNPz9HZzC/G
   0WuH0YzNueFvjEEYJNJIcWmPCcN4Rs22EaWCl4MsBSYK7227bjXjmqzb/
   5q8bp7FC9YubwRPpmuYcUHgHrYwuPdfA0GfxVg7fZd7I2eZ51zBY+rrxr
   +cEJlt8kAa26KI5389g+kgHqj7thv81LewDSOfP83SSudTqfYeoE/Rip4
   Z6qBBXWukTbFeDV0+jABStq19YW9K6cayPZPsRt4VF1QpxjfGgXIZfqgw
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="261438422"
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="261438422"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 13:23:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="617659921"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 13 Jun 2022 13:22:59 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0qaR-000L6i-1j;
        Mon, 13 Jun 2022 20:22:59 +0000
Date:   Tue, 14 Jun 2022 04:22:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>
Subject: [alobakin:bitops 3/6] include/linux/bitops.h:42:1: error: use of
 undeclared identifier 'arch___set_bit'
Message-ID: <202206140447.OqHwRDRY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/alobakin/linux bitops
head:   d8371d0e4328c4cb6fa25350bd5132f25b386672
commit: 4f9a98e0945a7cb9130bb04be4b3ecec35e16a81 [3/6] bitops: unify non-atomic bitops prototypes across architectures
config: hexagon-buildonly-randconfig-r001-20220613 (https://download.01.org/0day-ci/archive/20220614/202206140447.OqHwRDRY-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d378268ead93c85803c270277f0243737b536ae7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/alobakin/linux/commit/4f9a98e0945a7cb9130bb04be4b3ecec35e16a81
        git remote add alobakin https://github.com/alobakin/linux
        git fetch --no-tags alobakin bitops
        git checkout 4f9a98e0945a7cb9130bb04be4b3ecec35e16a81
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from kernel/bounds.c:13:
   In file included from include/linux/log2.h:12:
>> include/linux/bitops.h:42:1: error: use of undeclared identifier 'arch___set_bit'
   __check_bitop_pr(__set_bit);
   ^
   include/linux/bitops.h:39:28: note: expanded from macro '__check_bitop_pr'
           static_assert(__same_type(arch_##name, generic_##name) &&       \
                                     ^
   <scratch space>:111:1: note: expanded from here
   arch___set_bit
   ^
   In file included from kernel/bounds.c:13:
   In file included from include/linux/log2.h:12:
>> include/linux/bitops.h:43:1: error: use of undeclared identifier 'arch___clear_bit'; did you mean '__clear_bit'?
   __check_bitop_pr(__clear_bit);
   ^
   include/linux/bitops.h:39:28: note: expanded from macro '__check_bitop_pr'
           static_assert(__same_type(arch_##name, generic_##name) &&       \
                                     ^
   <scratch space>:115:1: note: expanded from here
   arch___clear_bit
   ^
   arch/hexagon/include/asm/bitops.h:131:1: note: '__clear_bit' declared here
   __clear_bit(unsigned long nr, volatile unsigned long *addr)
   ^
   In file included from kernel/bounds.c:13:
   In file included from include/linux/log2.h:12:
>> include/linux/bitops.h:44:1: error: use of undeclared identifier 'arch___change_bit'; did you mean '__change_bit'?
   __check_bitop_pr(__change_bit);
   ^
   include/linux/bitops.h:39:28: note: expanded from macro '__check_bitop_pr'
           static_assert(__same_type(arch_##name, generic_##name) &&       \
                                     ^
   <scratch space>:119:1: note: expanded from here
   arch___change_bit
   ^
   arch/hexagon/include/asm/bitops.h:143:1: note: '__change_bit' declared here
   __change_bit(unsigned long nr, volatile unsigned long *addr)
   ^
   In file included from kernel/bounds.c:13:
   In file included from include/linux/log2.h:12:
>> include/linux/bitops.h:45:1: error: use of undeclared identifier 'arch___test_and_set_bit'; did you mean '__test_and_set_bit'?
   __check_bitop_pr(__test_and_set_bit);
   ^
   include/linux/bitops.h:39:28: note: expanded from macro '__check_bitop_pr'
           static_assert(__same_type(arch_##name, generic_##name) &&       \
                                     ^
   <scratch space>:123:1: note: expanded from here
   arch___test_and_set_bit
   ^
   arch/hexagon/include/asm/bitops.h:156:1: note: '__test_and_set_bit' declared here
   __test_and_set_bit(unsigned long nr, volatile unsigned long *addr)
   ^
   In file included from kernel/bounds.c:13:
   In file included from include/linux/log2.h:12:
>> include/linux/bitops.h:46:1: error: use of undeclared identifier 'arch___test_and_clear_bit'; did you mean '__test_and_clear_bit'?
   __check_bitop_pr(__test_and_clear_bit);
   ^
   include/linux/bitops.h:39:28: note: expanded from macro '__check_bitop_pr'
           static_assert(__same_type(arch_##name, generic_##name) &&       \
                                     ^
   <scratch space>:127:1: note: expanded from here
   arch___test_and_clear_bit
   ^
   arch/hexagon/include/asm/bitops.h:150:1: note: '__test_and_clear_bit' declared here
   __test_and_clear_bit(unsigned long nr, volatile unsigned long *addr)
   ^
   In file included from kernel/bounds.c:13:
   In file included from include/linux/log2.h:12:
>> include/linux/bitops.h:47:1: error: use of undeclared identifier 'arch___test_and_change_bit'; did you mean '__test_and_change_bit'?
   __check_bitop_pr(__test_and_change_bit);
   ^
   include/linux/bitops.h:39:28: note: expanded from macro '__check_bitop_pr'
           static_assert(__same_type(arch_##name, generic_##name) &&       \
                                     ^
   <scratch space>:131:1: note: expanded from here
   arch___test_and_change_bit
   ^
   arch/hexagon/include/asm/bitops.h:162:1: note: '__test_and_change_bit' declared here
   __test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
   ^
   In file included from kernel/bounds.c:13:
   In file included from include/linux/log2.h:12:
>> include/linux/bitops.h:48:1: error: use of undeclared identifier 'arch_test_bit'
   __check_bitop_pr(test_bit);
   ^
   include/linux/bitops.h:39:28: note: expanded from macro '__check_bitop_pr'
           static_assert(__same_type(arch_##name, generic_##name) &&       \
                                     ^
   <scratch space>:135:1: note: expanded from here
   arch_test_bit
   ^
   7 errors generated.
   make[2]: *** [scripts/Makefile.build:117: kernel/bounds.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1200: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/arch___set_bit +42 include/linux/bitops.h

    36	
    37	/* Check that the bitops prototypes are sane */
    38	#define __check_bitop_pr(name)						\
    39		static_assert(__same_type(arch_##name, generic_##name) &&	\
    40			      __same_type(name, generic_##name))
    41	
  > 42	__check_bitop_pr(__set_bit);
  > 43	__check_bitop_pr(__clear_bit);
  > 44	__check_bitop_pr(__change_bit);
  > 45	__check_bitop_pr(__test_and_set_bit);
  > 46	__check_bitop_pr(__test_and_clear_bit);
  > 47	__check_bitop_pr(__test_and_change_bit);
  > 48	__check_bitop_pr(test_bit);
    49	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
