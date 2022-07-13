Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12E4573760
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 15:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbiGMN3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 09:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiGMN3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 09:29:03 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63596120B6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 06:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657718942; x=1689254942;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4uGDfWc/PlNv0ZILiK6BkAbZajsOITq318v9NwJ1Nxk=;
  b=SYbrQ30liHvUaUZKoGL+27g9ESqjI5zYypxYOlRQErWTE9ypMmcM1Gz6
   0FJYyuZK8pvkEs82bp0zWqyaJbUUhOCRh8OXtFehH55XHpRhCGUJVewFt
   OLEt/DTS4uKGIhSZYNKXVO/x7N+tuO7q2GPFKoavIESLCCxCeNWoTuuEl
   2gt0kNXvZQO1FuxegvXqUn3mVxoIdLjPBwu9wnYfcwx7KtQ0LIRO66Xt+
   vEyf7ihdH+uvhsZSqfJc81XWGJCHLMogdhSlHiUgWOVC/9W+bwH9PwaN+
   41HyktanlsoZcz5nTNzzQZKwTeI1EaPPLtFhvIJB7x4qSfTM7Fqlor39m
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="285235131"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="285235131"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 06:29:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="545838454"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 13 Jul 2022 06:29:00 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBcQG-0003YV-2f;
        Wed, 13 Jul 2022 13:29:00 +0000
Date:   Wed, 13 Jul 2022 21:28:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: include/linux/compiler_types.h:352:45: error: call to
 '__compiletime_assert_402' declared with attribute error: BUILD_BUG_ON
 failed: sizeof(cmd_a64_entry_t) != 64
Message-ID: <202207132140.qUP8tBhr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b047602d579b4fb028128a525f056bbdc890e7f0
commit: 7036440eab3e2d47a775d4616909f8235488d714 ARM: omap1: enable multiplatform
date:   6 weeks ago
config: arm-randconfig-s031-20220712 (https://download.01.org/0day-ci/archive/20220713/202207132140.qUP8tBhr-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7036440eab3e2d47a775d4616909f8235488d714
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 7036440eab3e2d47a775d4616909f8235488d714
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash drivers/scsi/qla2xxx/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   drivers/scsi/qla2xxx/qla_os.c: In function 'qla2x00_module_init':
>> include/linux/compiler_types.h:352:45: error: call to '__compiletime_assert_402' declared with attribute error: BUILD_BUG_ON failed: sizeof(cmd_a64_entry_t) != 64
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:333:25: note: in definition of macro '__compiletime_assert'
     333 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   drivers/scsi/qla2xxx/qla_os.c:8032:9: note: in expansion of macro 'BUILD_BUG_ON'
    8032 |         BUILD_BUG_ON(sizeof(cmd_a64_entry_t) != 64);
         |         ^~~~~~~~~~~~
--
   In file included from include/linux/string.h:253,
                    from include/linux/bitmap.h:11,
                    from include/linux/cpumask.h:12,
                    from include/linux/mm_types_task.h:14,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from drivers/scsi/qla2xxx/qla_target.c:17:
   In function 'fortify_memcpy_chk',
       inlined from 'qla24xx_post_nack_work' at drivers/scsi/qla2xxx/qla_target.c:555:2:
   include/linux/fortify-string.h:344:25: warning: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
     344 |                         __write_overflow_field(p_size_field, size);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from <command-line>:
   drivers/scsi/qla2xxx/qla_target.c: In function 'qlt_init':
>> include/linux/compiler_types.h:352:45: error: call to '__compiletime_assert_325' declared with attribute error: BUILD_BUG_ON failed: sizeof(struct ctio7_to_24xx) != 64
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:333:25: note: in definition of macro '__compiletime_assert'
     333 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   drivers/scsi/qla2xxx/qla_target.c:7414:9: note: in expansion of macro 'BUILD_BUG_ON'
    7414 |         BUILD_BUG_ON(sizeof(struct ctio7_to_24xx) != 64);
         |         ^~~~~~~~~~~~


vim +/__compiletime_assert_402 +352 include/linux/compiler_types.h

eb5c2d4b45e3d2d Will Deacon 2020-07-21  338  
eb5c2d4b45e3d2d Will Deacon 2020-07-21  339  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2d Will Deacon 2020-07-21  340  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2d Will Deacon 2020-07-21  341  
eb5c2d4b45e3d2d Will Deacon 2020-07-21  342  /**
eb5c2d4b45e3d2d Will Deacon 2020-07-21  343   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2d Will Deacon 2020-07-21  344   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2d Will Deacon 2020-07-21  345   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2d Will Deacon 2020-07-21  346   *
eb5c2d4b45e3d2d Will Deacon 2020-07-21  347   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2d Will Deacon 2020-07-21  348   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2d Will Deacon 2020-07-21  349   * compiler has support to do so.
eb5c2d4b45e3d2d Will Deacon 2020-07-21  350   */
eb5c2d4b45e3d2d Will Deacon 2020-07-21  351  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2d Will Deacon 2020-07-21 @352  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2d Will Deacon 2020-07-21  353  

:::::: The code at line 352 was first introduced by commit
:::::: eb5c2d4b45e3d2d5d052ea6b8f1463976b1020d5 compiler.h: Move compiletime_assert() macros into compiler_types.h

:::::: TO: Will Deacon <will@kernel.org>
:::::: CC: Will Deacon <will@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
