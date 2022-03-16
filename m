Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41C64DAC3C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 09:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354413AbiCPILd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 04:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346256AbiCPILc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 04:11:32 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC69C5EBC4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 01:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647418218; x=1678954218;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oE3dUSyW9sAQB9KtEIorBKepPZxifgH61/xuFVQ26aI=;
  b=YTjIFQp0lKcn/Q08GsGHQN7D4rA6HRytQNkvIzvsGwR2qH3iDqytESFf
   Q8dTVWaxGGNns3l2rniBptWvvQWu7Vwc6NtZMNX+PPialXfeTspHwaRGa
   lzvz/mJFaa3iE4NE6ZMJ87iZAZYrA2LT3NfLG9EIIp6UrbOpwcBLi3vjT
   XQRX0+7pcZrJrqTYFh7KHEwMlz25NN9Cin7uAmYHuQ/sZZ9B9IlOXeiUJ
   hqk3BdAgOnQU/OaWHev426e/XvDBi5gkMfI6tIsefLqr+8a3uOfYbm8yO
   UQ2o8yfkIDQZxzqus13C5wPvADr8VhglpCWjwaXiGAGvtxGbXH7CnX0Nh
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="243973692"
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="243973692"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 01:09:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="714502451"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 16 Mar 2022 01:09:53 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUOjA-000C9F-HO; Wed, 16 Mar 2022 08:09:52 +0000
Date:   Wed, 16 Mar 2022 16:09:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 915/2335] ./usr/include/linux/rds.h:38:10: fatal
 error: uapi/linux/sockios.h: No such file or directory
Message-ID: <202203161619.Vy1cAw02-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   85293bf3fca6d85608cff1447ce3097583f15fab
commit: b8d36bc5384ae56de169ae667aec58547181384f [915/2335] headers/deps: Add header dependencies to .h files: <uapi/linux/sockios.h>
config: i386-randconfig-a006-20220314 (https://download.01.org/0day-ci/archive/20220316/202203161619.Vy1cAw02-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=b8d36bc5384ae56de169ae667aec58547181384f
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout b8d36bc5384ae56de169ae667aec58547181384f
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:32:
>> ./usr/include/linux/rds.h:38:10: fatal error: uapi/linux/sockios.h: No such file or directory
      38 | #include <uapi/linux/sockios.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.
--
   In file included from <command-line>:32:
>> ./usr/include/linux/x25.h:15:10: fatal error: uapi/linux/sockios.h: No such file or directory
      15 | #include <uapi/linux/sockios.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.
--
   In file included from <command-line>:32:
>> ./usr/include/linux/if_tunnel.h:5:10: fatal error: uapi/linux/sockios.h: No such file or directory
       5 | #include <uapi/linux/sockios.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.
--
   In file included from <command-line>:32:
>> ./usr/include/linux/kcm.h:18:10: fatal error: uapi/linux/sockios.h: No such file or directory
      18 | #include <uapi/linux/sockios.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
