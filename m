Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E155D54F16C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 09:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380426AbiFQHIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 03:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380402AbiFQHIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 03:08:38 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EE436E25
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 00:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655449713; x=1686985713;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sjc582oVQk/M+343pAi/1IUYppiGE2CvRRFk83lulMY=;
  b=mwP/npDMmINvwCexyeUwro8NoFTHFipJLReCd/Yd6/ch9qBrjvCwhZES
   5QLyCsKjUymgIBCRwFiaFSbRfk3T4PWUYfcwTiCzB3OV/eB4aIdKd2FbP
   BWiOP74ksncCIfVnlq6/VdxUOlDdOZfsEXkVbrm4yyUVHMDr1rd8N3jyh
   7kbsERaT9lSTp/mr/HpHGqYHpQdaF6OS1jmV8Yxa/5toU3SBCFB/bL7Im
   WKlDUrYUvk5R3om0TBoLRX5lAxiF8mdaS7/lVZf5PS0JLv5qljzUz0Awi
   55W1gJ5nAliw+qE6iGS0IiKag/U2OCr2AiRZv6ufjfp01VY5yFEPFTAS7
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="343398991"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="343398991"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 00:08:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="619174482"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 17 Jun 2022 00:08:31 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o265n-000PBq-53;
        Fri, 17 Jun 2022 07:08:31 +0000
Date:   Fri, 17 Jun 2022 15:08:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [bvanassche:block-bitwise-opf 15/15]
 include/linux/compiler_types.h:352:45: error: call to
 '__compiletime_assert_300' declared with attribute error: BUILD_BUG_ON
 failed: !__same_type(op, blk_mq_opf_t) && !__same_type(op, enum req_op)
Message-ID: <202206171554.MBCHaiNR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/bvanassche/linux block-bitwise-opf
head:   031ccdd616b11c4e774e56aa7eae906188ab24cc
commit: 031ccdd616b11c4e774e56aa7eae906188ab24cc [15/15] block: Introduce the type blk_mq_opf_t
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20220617/202206171554.MBCHaiNR-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/bvanassche/linux/commit/031ccdd616b11c4e774e56aa7eae906188ab24cc
        git remote add bvanassche https://github.com/bvanassche/linux
        git fetch --no-tags bvanassche block-bitwise-opf
        git checkout 031ccdd616b11c4e774e56aa7eae906188ab24cc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   drivers/block/paride/pd.c: In function 'do_pd_io_start':
>> drivers/block/paride/pd.c:487:9: warning: enumeration value 'REQ_OP_FLUSH' not handled in switch [-Wswitch]
     487 |         switch (req_op(pd_req)) {
         |         ^~~~~~
>> drivers/block/paride/pd.c:487:9: warning: enumeration value 'REQ_OP_DISCARD' not handled in switch [-Wswitch]
>> drivers/block/paride/pd.c:487:9: warning: enumeration value 'REQ_OP_SECURE_ERASE' not handled in switch [-Wswitch]
>> drivers/block/paride/pd.c:487:9: warning: enumeration value 'REQ_OP_WRITE_ZEROES' not handled in switch [-Wswitch]
>> drivers/block/paride/pd.c:487:9: warning: enumeration value 'REQ_OP_ZONE_OPEN' not handled in switch [-Wswitch]
>> drivers/block/paride/pd.c:487:9: warning: enumeration value 'REQ_OP_ZONE_CLOSE' not handled in switch [-Wswitch]
>> drivers/block/paride/pd.c:487:9: warning: enumeration value 'REQ_OP_ZONE_FINISH' not handled in switch [-Wswitch]
>> drivers/block/paride/pd.c:487:9: warning: enumeration value 'REQ_OP_ZONE_APPEND' not handled in switch [-Wswitch]
>> drivers/block/paride/pd.c:487:9: warning: enumeration value 'REQ_OP_ZONE_RESET' not handled in switch [-Wswitch]
>> drivers/block/paride/pd.c:487:9: warning: enumeration value 'REQ_OP_ZONE_RESET_ALL' not handled in switch [-Wswitch]
>> drivers/block/paride/pd.c:487:9: warning: enumeration value 'REQ_OP_DRV_OUT' not handled in switch [-Wswitch]
>> drivers/block/paride/pd.c:487:9: warning: enumeration value 'REQ_OP_LAST' not handled in switch [-Wswitch]
--
   In file included from <command-line>:
   block/blk-wbt.c: In function 'wbt_data_dir':
>> include/linux/compiler_types.h:352:45: error: call to '__compiletime_assert_300' declared with attribute error: BUILD_BUG_ON failed: !__same_type(op, blk_mq_opf_t) && !__same_type(op, enum req_op)
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
   include/linux/blk_types.h:487:17: note: in expansion of macro 'BUILD_BUG_ON'
     487 |                 BUILD_BUG_ON(!__same_type(op, blk_mq_opf_t) &&  \
         |                 ^~~~~~~~~~~~
   block/blk-wbt.c:677:18: note: in expansion of macro 'op_is_write'
     677 |         else if (op_is_write(op))
         |                  ^~~~~~~~~~~


vim +/__compiletime_assert_300 +352 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  338  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  339  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  340  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  341  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  342  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  343   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  344   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  345   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  346   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  347   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  348   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  349   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  350   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  351  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @352  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  353  

:::::: The code at line 352 was first introduced by commit
:::::: eb5c2d4b45e3d2d5d052ea6b8f1463976b1020d5 compiler.h: Move compiletime_assert() macros into compiler_types.h

:::::: TO: Will Deacon <will@kernel.org>
:::::: CC: Will Deacon <will@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
