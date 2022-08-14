Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD4A592603
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 20:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiHNSfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 14:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239893AbiHNSfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 14:35:11 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD24186DF
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 11:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660502110; x=1692038110;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/JU3KlUrNNzdqUWS0jZTN1lj0eDQuosG+RH4omwlcXs=;
  b=BHHZmO37gAQW5qNUvZi/0Oznu0WZDCmjWsHqdCuU2MHXi8oPWqLjUW2g
   8Y9fjNuOYGInfXB2Qe7ooSUJdia3giPTsQyeoU/VIzii7Z+HsAiZDusJz
   Acv45hMwZxI583bABym2OKZwEi6aOiC/YfXLJhmnajOGryRCyDp/WdUz+
   MltTZ82XkOmADISquJYFaGdZMLqBQDXTVMOQo7lkaM25qFTJPJYNLRC9w
   rwPZrjl1cZtSgj9u0Q3sKD9EiW12psYbpLjsA90kpqzn7HUd/S/k/Y+x0
   X5gUJzDdbGnXCuBC6t3N908nvM+8YmICYmzFDz5D5D9O6f2NhutugPk3d
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="355851063"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="355851063"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 11:35:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="732725599"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 14 Aug 2022 11:35:08 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNIS3-0000QZ-1r;
        Sun, 14 Aug 2022 18:35:07 +0000
Date:   Mon, 15 Aug 2022 02:34:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: [ammarfaizi2-block:paulmck/linux-rcu/ctxt.2022.06.21a 10/22]
 xtensa-linux-ld: arch/xtensa/kernel/entry.o:undefined reference to
 `context_tracking_user_exit'
Message-ID: <202208150217.XWuyLscZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/ctxt.2022.06.21a
head:   22a297887c103cd0a9a251e546cef7f181bd8ce8
commit: 1cd9c24e543e060b0c5fdd1b91ad1b349fd4a700 [10/22] context_tracking: Take idle eqs entrypoints over RCU
config: xtensa-randconfig-r033-20220718 (https://download.01.org/0day-ci/archive/20220815/202208150217.XWuyLscZ-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/1cd9c24e543e060b0c5fdd1b91ad1b349fd4a700
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/ctxt.2022.06.21a
        git checkout 1cd9c24e543e060b0c5fdd1b91ad1b349fd4a700
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> xtensa-linux-ld: arch/xtensa/kernel/entry.o:(.text+0x0): undefined reference to `context_tracking_user_exit'
>> xtensa-linux-ld: arch/xtensa/kernel/entry.o:(.text+0xc): undefined reference to `context_tracking_user_enter'
   xtensa-linux-ld: arch/xtensa/kernel/entry.o: in function `common_exception':
>> (.text+0x16a): undefined reference to `context_tracking_user_exit'
   xtensa-linux-ld: arch/xtensa/kernel/entry.o: in function `common_exception_return':
>> (.text+0x1dd): undefined reference to `context_tracking_user_enter'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
