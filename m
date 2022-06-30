Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFCE562402
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 22:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237197AbiF3UQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 16:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236609AbiF3UQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 16:16:12 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299B24475A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 13:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656620171; x=1688156171;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=USQWbAorFYjcY7tNlPI3byjv9rIn9AUbLU1IZM4fmGg=;
  b=fsN5ZsG+HS+WQUvcKdSf9fjyDf8OTbVbVn5pIROHjfWyzMRX2KTvsOjy
   EPxX8/1p/sOPbMwmY1rfRyOkbNXQFkhQgagnOd6wPYD6BM20kBnIpm0d4
   CjMt3nouNrUrtiIrjlYQUdAbi3fKdxnbFtjccWhKNt3bB2r4lf0eaQD7e
   WfWYep0Z1NzEXjdOsjAQNj7domiD5qZoM02dl6UyT7ZO+4IaiiKQAieXN
   7z12lDFZcUQg9Qo2vfS0L+JM1mr6RYoshWWCZsoi5NylhGk0MZvKRCYpE
   KEKylm9j5OsjCzEFtqg/vxNFL+1mVxe2CkbsqekPjBAfBXeqblCRFMpo/
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="271227739"
X-IronPort-AV: E=Sophos;i="5.92,235,1650956400"; 
   d="scan'208";a="271227739"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 13:16:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,235,1650956400"; 
   d="scan'208";a="918191920"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 30 Jun 2022 13:16:09 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o70a8-000D9q-KH;
        Thu, 30 Jun 2022 20:16:08 +0000
Date:   Fri, 1 Jul 2022 04:15:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [ammarfaizi2-block:paulmck/linux-rcu/pmladek.2022.06.15a 123/140]
 xtensa-linux-ld: arch/xtensa/kernel/entry.o:undefined reference to
 `context_tracking_user_exit'
Message-ID: <202207010405.MVCHQe6d-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/pmladek.2022.06.15a
head:   0ba7324b44282870af740a5a121add62c7f5f730
commit: 9d16390cc0d00ae1100bca4f4adb0ae2906631ec [123/140] context_tracking: Take idle eqs entrypoints over RCU
config: xtensa-randconfig-r004-20220629 (https://download.01.org/0day-ci/archive/20220701/202207010405.MVCHQe6d-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/9d16390cc0d00ae1100bca4f4adb0ae2906631ec
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/pmladek.2022.06.15a
        git checkout 9d16390cc0d00ae1100bca4f4adb0ae2906631ec
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> xtensa-linux-ld: arch/xtensa/kernel/entry.o:(.text+0x0): undefined reference to `context_tracking_user_exit'
>> xtensa-linux-ld: arch/xtensa/kernel/entry.o:(.text+0xc): undefined reference to `context_tracking_user_enter'
   xtensa-linux-ld: arch/xtensa/kernel/entry.o: in function `common_exception':
   arch/xtensa/kernel/entry.S:459: undefined reference to `context_tracking_user_exit'
   xtensa-linux-ld: arch/xtensa/kernel/entry.o: in function `common_exception_return':
   arch/xtensa/kernel/entry.S:542: undefined reference to `context_tracking_user_enter'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
