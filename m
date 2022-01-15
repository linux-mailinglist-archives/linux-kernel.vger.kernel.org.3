Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECBD848F654
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 11:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbiAOKPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 05:15:53 -0500
Received: from mga02.intel.com ([134.134.136.20]:25107 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232805AbiAOKPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 05:15:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642241752; x=1673777752;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1EwwpogSbFY0eQPXy39AQ3Gl9MtBBpEpT5T2I2larKk=;
  b=N2uvkSjtvsZ83oet4kBesoXAvcp+SQ+GN8g9QGbtFIXq5hy8tM//7SEH
   OIe9WMpm9zYERQLa1EkpwTdkjtVkSqlauJvUQ9uLLbTavTJ3ceoeXotXB
   MguRyQMbK/K5M0y2dPMup0NPByNQ4aWyNEu9xdwDLOpOjh6+57b4lV5Rt
   OWaofXwzb84PJgk2WfGOOCjrlOB7sougg2hLvfxUoAPf4ls7E2/c2uN5f
   HLw7r6YEFDnY+IlFqS9sYGJBehb+oVzBY/h+jN/Dbqb/rNgpqPhmv6MZn
   6HfoN5Fz3d/RFAMWNuIsFLaxw2RQ4XmFzsrmvRjZ11NE42bwD3w5WgtJ3
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="231752156"
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="231752156"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2022 02:15:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="476067999"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 15 Jan 2022 02:15:51 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8g6A-0009dk-Ek; Sat, 15 Jan 2022 10:15:50 +0000
Date:   Sat, 15 Jan 2022 18:15:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1943/2384]
 ./usr/include/linux/rtnetlink.h:5:10: fatal error: uapi/linux/types.h: No
 such file or directory
Message-ID: <202201151815.UIlNSRyJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   4c707c1c0de83967079b4e385012fa5b00e2cd11
commit: c23f2d841e378347986864822f333c0b10346a94 [1943/2384] headers/deps: net: Optimize <uapi/linux/rtnetlink.h> dependencies
config: x86_64-randconfig-a015 (https://download.01.org/0day-ci/archive/20220115/202201151815.UIlNSRyJ-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=c23f2d841e378347986864822f333c0b10346a94
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout c23f2d841e378347986864822f333c0b10346a94
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from ./usr/include/linux/fib_rules.h:6,
                    from <command-line>:32:
>> ./usr/include/linux/rtnetlink.h:5:10: fatal error: uapi/linux/types.h: No such file or directory
       5 | #include <uapi/linux/types.h>
         |          ^~~~~~~~~~~~~~~~~~~~
   compilation terminated.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
