Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D1948F5F9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 09:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbiAOISQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 03:18:16 -0500
Received: from mga02.intel.com ([134.134.136.20]:59692 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230260AbiAOISP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 03:18:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642234695; x=1673770695;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SNTRIYChHQSOOu4tf+hpnaFmmdl3S9/Vpad1JVTcN2Y=;
  b=hXpyclu2m0gKuD8Yq3n9GUPYZwzxd0k0DyLukfWa7sfEcfK676BK17u7
   S1I9wqaPhVa5GGxirVMPJtFvdeUfxJhApqyyQvBQMfrOJng0I0o5osnCz
   aFLB/DYP/baKcKTv8QJMjJO6iZgschebFj9a+Zdm7jwTp8t30Th/M0h45
   SpYE3YVO1E8Q4d2LTULXDOldz7ybEqjbq7ogLZGYbIltB9RLK1dQSRVbP
   2126WtxCazjH7gHfJlLFW4pxWjtYBEI8l1mn5oQHfzzIz3WLAZDyL8nWn
   nz1rUGB+pWt6lbkmWRsvXxd2l3QSmMWq0WU/EdxAn+zqZ5EVnbonwT056
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="231743005"
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="231743005"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2022 00:12:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="577539050"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 15 Jan 2022 00:12:48 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8eB5-0009Xa-MT; Sat, 15 Jan 2022 08:12:47 +0000
Date:   Sat, 15 Jan 2022 16:11:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1942/2384]
 ./usr/include/linux/neighbour.h:5:10: fatal error: uapi/linux/types.h: No
 such file or directory
Message-ID: <202201151636.bpzlVrMY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   4c707c1c0de83967079b4e385012fa5b00e2cd11
commit: 57aa2dcd6f974cdffe2dcc9e9dd7b9c6379d1183 [1942/2384] headers/deps: net: Optimize <uapi/linux/neighbour.h> dependencies
config: x86_64-randconfig-a015 (https://download.01.org/0day-ci/archive/20220115/202201151636.bpzlVrMY-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=57aa2dcd6f974cdffe2dcc9e9dd7b9c6379d1183
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 57aa2dcd6f974cdffe2dcc9e9dd7b9c6379d1183
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:32:
>> ./usr/include/linux/neighbour.h:5:10: fatal error: uapi/linux/types.h: No such file or directory
       5 | #include <uapi/linux/types.h>
         |          ^~~~~~~~~~~~~~~~~~~~
   compilation terminated.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
