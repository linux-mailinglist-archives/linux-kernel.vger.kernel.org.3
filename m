Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC75048F546
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 06:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbiAOFus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 00:50:48 -0500
Received: from mga11.intel.com ([192.55.52.93]:19475 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231184AbiAOFur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 00:50:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642225847; x=1673761847;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=St1y+OFaiZQzSvE2Hbc8pIM5mvsG167VjJtpyhV/1kM=;
  b=Rt8y6lquv6yQLJIA5FttQg3KGa9to99EUwzancHWcvcZHJs7/bcU/dLP
   3+8oxpo10tRVNCuNHi6cpjyuRAs1eDOwCKRs99JfiJjiUzjHPLKF7hgb3
   MdCSLZzaatqPMFyxPyopuyEpKI1WVsyNxSfHBnD1I79ztuoExhzC3mZVl
   ZrAerJnvaGwTpSsH96dlx7zRi1hupJnMXLKsyuYPaH81M7XArBeaLkQvr
   w7fKcgcFGwQ5uOAZr/IY4XTLTjCaCqF5Z0hN8pVvZaBWOsSkiaGVOFsW0
   55vxoeqePCBPYt7O+LfqcJPxfEH0QR5mxxvM5FDH2vIos0iEJBVnsWPz0
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="241943997"
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="241943997"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 21:50:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="473882162"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 14 Jan 2022 21:50:45 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8bxc-0009Qt-VJ; Sat, 15 Jan 2022 05:50:44 +0000
Date:   Sat, 15 Jan 2022 13:49:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1941/2384]
 ./usr/include/linux/if_addr.h:5:10: fatal error: uapi/linux/types.h: No such
 file or directory
Message-ID: <202201151333.cGY0nwmS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   4c707c1c0de83967079b4e385012fa5b00e2cd11
commit: 97d04c6183db4658f05ac14df308c4efd3871346 [1941/2384] headers/deps: net: Optimize <uapi/linux/if_addr.h> dependencies
config: x86_64-randconfig-a015 (https://download.01.org/0day-ci/archive/20220115/202201151333.cGY0nwmS-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=97d04c6183db4658f05ac14df308c4efd3871346
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 97d04c6183db4658f05ac14df308c4efd3871346
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:32:
>> ./usr/include/linux/if_addr.h:5:10: fatal error: uapi/linux/types.h: No such file or directory
       5 | #include <uapi/linux/types.h>
         |          ^~~~~~~~~~~~~~~~~~~~
   compilation terminated.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
