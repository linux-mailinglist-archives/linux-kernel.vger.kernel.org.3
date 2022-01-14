Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A1648EEF2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 18:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243695AbiANRDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 12:03:18 -0500
Received: from mga14.intel.com ([192.55.52.115]:62738 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236077AbiANRDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 12:03:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642179797; x=1673715797;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Bv+v544jxOPRG12AeiNErwVYo2ovoSUeee46VfmNq4A=;
  b=WEpf3fpu28/+KiMlj61b3hMPjPkjfVSBcLlwmeTue67Ntr85QL7AjfJ1
   /9Qlz5dVQxff78OavmI9hbZBPNouHjj4lbmxm7gnv2cjBmI/qTyNEpZhl
   W+3GFbvsvvn0xWx+5vJuPCJ7wq922IGfmCmX7b6mdxcJUPMo+hH3SQepz
   xP0chuxGF9XPh0mwho4W+6D6BTSzHjUAq82qXNpoWD7oIS5bwOUnNZ5Yx
   +7a/hStEN84a1aKOiU8dA6RLxhZHO7goiE4OT7NoV+jGH55lKY0qyNCID
   bY3kpuI5uMrYVKy41QEakFje22M4PgnZAejwfZ7E9YAn/DoLFpRTvnb2q
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="244485582"
X-IronPort-AV: E=Sophos;i="5.88,289,1635231600"; 
   d="scan'208";a="244485582"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 09:02:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,289,1635231600"; 
   d="scan'208";a="614394801"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Jan 2022 09:02:14 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8Pxu-0008o4-2Q; Fri, 14 Jan 2022 17:02:14 +0000
Date:   Sat, 15 Jan 2022 01:01:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1593/2383]
 ./usr/include/linux/if_bonding.h:47:10: fatal error: uapi/linux/sockios.h:
 No such file or directory
Message-ID: <202201150043.5fTxWerJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   d772004cd069a1947a890ccc8346e922f866ba1e
commit: eb4b43a3bb224895dcd3976b63def55ee42203f5 [1593/2383] headers/deps: net: Optimize the header dependencies of <uapi/linux/if_bonding.h>
config: x86_64-randconfig-a015 (https://download.01.org/0day-ci/archive/20220115/202201150043.5fTxWerJ-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=eb4b43a3bb224895dcd3976b63def55ee42203f5
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout eb4b43a3bb224895dcd3976b63def55ee42203f5
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:32:
>> ./usr/include/linux/if_bonding.h:47:10: fatal error: uapi/linux/sockios.h: No such file or directory
      47 | #include <uapi/linux/sockios.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
