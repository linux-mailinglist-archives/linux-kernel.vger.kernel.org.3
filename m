Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9134DB718
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 18:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355042AbiCPR1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 13:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbiCPR1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 13:27:10 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDCA9FE5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 10:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647451556; x=1678987556;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BoNwyuLssHiOeLFKAfxDzOADRAao0Zu6ebHZfUKkGAk=;
  b=TM10bGA4qWPzAwyFm4UG0/EO9cg1gdzn2Xx2m11kbXxQ6NTR2hqXtpsL
   rxsBy7/4kA9eujSuQ+vT2fyQCXBVWTA2ynWnW7q0kHzHTG7o41tqS9my1
   iNrFE/oXe3W+fpGMZPRNXGlVlbamAnRbvRYgGdVhXpfqJ9TigzBNZgxJ9
   azJIzxLN5IM9ISAk017bcDyZADdzxi/PowvPsFcDuRE2uVRFQmc5M5RYd
   tZGa8J4oIr5QyZPhO4BSObo+fuDvY/NySyETIzLQvVnINHeNaZTTlvx5g
   ofng9swseUmDJ+NyQjlszoJmRlNICJ3bV+mSxYalRCFsF4zKd4wMqgibO
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="317390662"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="317390662"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 10:25:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="541023740"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 16 Mar 2022 10:25:37 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUXOy-000CgN-Pq; Wed, 16 Mar 2022 17:25:36 +0000
Date:   Thu, 17 Mar 2022 01:25:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 1527/2335] ./usr/include/linux/socket.h:5:10:
 fatal error: uapi/linux/socket_types.h: No such file or directory
Message-ID: <202203170120.b2FHH2Pm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   85293bf3fca6d85608cff1447ce3097583f15fab
commit: d66072bb2f7b14c08b75d3d344151386141b27a1 [1527/2335] headers/deps: net: Split <linux/socket_types.h> out of <linux/socket.h>
config: i386-randconfig-a006-20220314 (https://download.01.org/0day-ci/archive/20220317/202203170120.b2FHH2Pm-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=d66072bb2f7b14c08b75d3d344151386141b27a1
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout d66072bb2f7b14c08b75d3d344151386141b27a1
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from ./usr/include/linux/netlink.h:6,
                    from ./usr/include/linux/netconf.h:6,
                    from <command-line>:32:
>> ./usr/include/linux/socket.h:5:10: fatal error: uapi/linux/socket_types.h: No such file or directory
       5 | #include <uapi/linux/socket_types.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
