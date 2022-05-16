Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DED75291F3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 22:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347796AbiEPUsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 16:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244565AbiEPUr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 16:47:57 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF4C53E39
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 13:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652732692; x=1684268692;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3xXC00ccf5Fatxhz0n7yx9QRAp7Ln7haOT15zcfvgVc=;
  b=HJG6OhwRu3D9m1hPQ4LZINKzGKhBn/RLIZKthaT+fbbX4cdIBbzCWxva
   Ag2qzAqxTGJyV4LtaS+pTYcwUtaSa2EylMkltgKhXsZqCYymeTSlrMnaz
   EKYTQhA/30g5xOx+iPerMjiOg6A9Zn8bEzXfN6XQsC0WjyYSQmGAi0I+g
   Ndy1XCgXCmLC4pwsUTJI2Vvbx2333eTF4Zvjjlqr+2cwh43ciVPwxY+ux
   iodqrvggDP0nSqysC1H+E14Z7t9ZQ0tJ88KW+Ui4BDI59afL9S51pnU8J
   qxZD+kxaefqgdovQtoeEHNJUnywRmzgUY9NqaeJjXsgHMik5BBjXN9l1Z
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="270645991"
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="270645991"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 13:24:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="638418038"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 16 May 2022 13:24:50 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nqhGr-0000JU-MW;
        Mon, 16 May 2022 20:24:49 +0000
Date:   Tue, 17 May 2022 04:24:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>
Subject: include/linux/compiler_types.h:352:45: error: call to
 '__compiletime_assert_481' declared with attribute error: Please avoid
 flushing system_unbound_wq.
Message-ID: <202205170301.QHEka2f9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel-lab-lkp/linux/commits/UPDATE-20220516-093322/Tetsuo-Handa/checkpatch-warn-about-flushing-system-wide-workqueues/20220425-073327
head:   cd007363b7985a824de0ec5e05f0cb0705e59c88
commit: cd007363b7985a824de0ec5e05f0cb0705e59c88 workqueue: Wrap flush_workqueue() using a macro
date:   18 hours ago
config: arm-randconfig-r002-20220516 (https://download.01.org/0day-ci/archive/20220517/202205170301.QHEka2f9-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/cd007363b7985a824de0ec5e05f0cb0705e59c88
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review UPDATE-20220516-093322/Tetsuo-Handa/checkpatch-warn-about-flushing-system-wide-workqueues/20220425-073327
        git checkout cd007363b7985a824de0ec5e05f0cb0705e59c88
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/infiniband/core/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   drivers/infiniband/core/device.c: In function 'ib_core_cleanup':
>> include/linux/compiler_types.h:352:45: error: call to '__compiletime_assert_481' declared with attribute error: Please avoid flushing system_unbound_wq.
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
   include/linux/workqueue.h:682:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     682 |         BUILD_BUG_ON_MSG(__builtin_constant_p(&(wq) == &system_unbound_wq) && \
         |         ^~~~~~~~~~~~~~~~
   drivers/infiniband/core/device.c:2857:9: note: in expansion of macro 'flush_workqueue'
    2857 |         flush_workqueue(system_unbound_wq);
         |         ^~~~~~~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for NET_DSA_SMSC_LAN9303
   Depends on NETDEVICES && NET_DSA && (VLAN_8021Q || VLAN_8021Q
   Selected by
   - NET_DSA_SMSC_LAN9303_I2C && NETDEVICES && NET_DSA && I2C
   - NET_DSA_SMSC_LAN9303_MDIO && NETDEVICES && NET_DSA


vim +/__compiletime_assert_481 +352 include/linux/compiler_types.h

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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
