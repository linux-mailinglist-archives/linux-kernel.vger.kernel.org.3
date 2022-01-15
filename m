Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA95448F487
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 04:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbiAODHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 22:07:39 -0500
Received: from mga12.intel.com ([192.55.52.136]:49661 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230100AbiAODHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 22:07:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642216059; x=1673752059;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QnZJaX87Bpnvrx8ldFNTtIPzhwTxF6gVGwgi7+551HQ=;
  b=mp+aX0begMsRjuDddPc299rZwkR7oeziW2k2K2NcY+1c4wNTEP3bCKIw
   TdyqQ7iFcbPJ8bdZlTI+fKASLvVwH3rd8/hfs7RaSHssX0Wf6birM/LPm
   ttcuOvJ7r/9uUxY3lHwYm7cITNurrGQ3UsvJRC9o/HTsNxcU2oOPoSZGU
   iSTIeKlijKMWjK00lrScgAeTB5oiVQk1uQhDJjmOSt4z7gBuS5SIP4PoJ
   ZYJCwTlIOeVNXB0snUjdNgzqNQ9AKDFDsue5qiDuSmLDceXaIfWW8u1f/
   JJKhLQSVenA6ZeHKwuozIvHHkUj0OCVuW9AFhWMIP+yrV4Fuy+llYB2bM
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="224355698"
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="224355698"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 19:07:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="559690049"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 14 Jan 2022 19:07:37 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8ZPk-0009II-Vy; Sat, 15 Jan 2022 03:07:36 +0000
Date:   Sat, 15 Jan 2022 11:06:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1597/2384]
 ./usr/include/linux/netlink.h:5:10: fatal error: uapi/linux/types.h: No such
 file or directory
Message-ID: <202201151131.XuZRGtcN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   4c707c1c0de83967079b4e385012fa5b00e2cd11
commit: 394a7895e7b5aeef5c98d7fbe21f09107b515d19 [1597/2384] headers/deps: net: Optimize <uapi/linux/netlink.h>
config: x86_64-randconfig-a015 (https://download.01.org/0day-ci/archive/20220115/202201151131.XuZRGtcN-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=394a7895e7b5aeef5c98d7fbe21f09107b515d19
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 394a7895e7b5aeef5c98d7fbe21f09107b515d19
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:32:
>> ./usr/include/linux/netlink.h:5:10: fatal error: uapi/linux/types.h: No such file or directory
       5 | #include <uapi/linux/types.h>
         |          ^~~~~~~~~~~~~~~~~~~~
   compilation terminated.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
