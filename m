Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC8F048F1A7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 21:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244286AbiANUs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 15:48:28 -0500
Received: from mga06.intel.com ([134.134.136.31]:4744 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236975AbiANUs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 15:48:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642193307; x=1673729307;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WJnOki/acRxkRycDA1MP3ik1IpUr2u6KCu76PpNEKOM=;
  b=Ztq+yWyX+BcIZhzSPZlkDeqIaVWT+YYEPrCGd/Bx1YjKbxW6oOP52YPb
   tVOSQTZJJ4MTFSCMM4Lr8zWf/TL16KOwFJHNh9MCPCxblpUMxEpBUJSO0
   N9BzkzGLxdPfucd7c/9gl6rP97hP+wis1pNlEM3S5tEeVu0RV1iApJWNZ
   3gsK0MjhD51IRJefrrfWN8G585cvRMgcGPYJ79Uy7X7vt9M6MJ60JtYmN
   MNTt/PdAUxio/Wky0s7M7vF6LNfYUKsLh5qAuqxjYXnIZiNsfS+VLk6KE
   jgorWqPS+gG7/BvAd0nQts6A7Hj7x7sbLbMka5tucgV5phoRwwR1Gb23/
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="305059325"
X-IronPort-AV: E=Sophos;i="5.88,289,1635231600"; 
   d="scan'208";a="305059325"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 12:48:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,289,1635231600"; 
   d="scan'208";a="692346324"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 14 Jan 2022 12:48:26 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8TUn-0008yv-PN; Fri, 14 Jan 2022 20:48:25 +0000
Date:   Sat, 15 Jan 2022 04:47:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1595/2383]
 ./usr/include/linux/if_link.h:5:10: fatal error: uapi/linux/netlink.h: No
 such file or directory
Message-ID: <202201150439.Rc5HIAEq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   d772004cd069a1947a890ccc8346e922f866ba1e
commit: 60d16930c980493906092825024aebd0235c0f37 [1595/2383] headers/deps: net: Optimize <uapi/linux/if_link.h>
config: x86_64-randconfig-a015 (https://download.01.org/0day-ci/archive/20220115/202201150439.Rc5HIAEq-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=60d16930c980493906092825024aebd0235c0f37
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 60d16930c980493906092825024aebd0235c0f37
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:32:
>> ./usr/include/linux/if_link.h:5:10: fatal error: uapi/linux/netlink.h: No such file or directory
       5 | #include <uapi/linux/netlink.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
