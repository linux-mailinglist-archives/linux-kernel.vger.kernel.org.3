Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C07E488593
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 20:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbiAHT0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 14:26:09 -0500
Received: from mga02.intel.com ([134.134.136.20]:31504 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230345AbiAHT0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 14:26:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641669968; x=1673205968;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5i+7qkjJpoaToMa9cZ/n40+B4SZcLAw3oycfrjVI180=;
  b=VMWY++35T9PyNGdT1gJZ2bL9EosRRT0ihI6+cQLkiS5grMz/lIDtAlyH
   v0tV26ZAPEJ9xHUqAadRlXgJl7fhAuMLR2vV4Qa8uwOVMCh6j/fPX/ba/
   B+d7WmA9amQDFei0abuRTLPKyfKAbe290xbEoD90cAp5o9prMrt91t9Sg
   wFi+ka+Sy+EfYD8zOglHwFPpc5DKCY8isbOtD79Jo6z7Xe1lROxMcGlV4
   EzwfJ4432JhTBqVz90C7Vijmz/jE19dLVJwod8IkhvV91yNSQaR6M3CHc
   t/H5pgvGqbXTEvu3zK+W6SFhsW3BF0cOBr2juDMCT+ES/OcWSSMprSJiu
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10221"; a="230375544"
X-IronPort-AV: E=Sophos;i="5.88,273,1635231600"; 
   d="scan'208";a="230375544"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2022 11:26:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,273,1635231600"; 
   d="scan'208";a="557591045"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 08 Jan 2022 11:26:07 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6HLq-0000y9-Sa; Sat, 08 Jan 2022 19:26:06 +0000
Date:   Sun, 9 Jan 2022 03:25:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 2300/2300] usr/include/linux/neighbour.h:9: found
 __[us]{8,16,32,64} type without #include <linux/types.h>
Message-ID: <202201090323.0gexKYhO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   4e348e961395297bb17f101cc63bc133d8a348e9
commit: 4e348e961395297bb17f101cc63bc133d8a348e9 [2300/2300] FIX: f989e243f1f4 headers/deps: uapi/headers: Create usr/include/uapi symbolic link
config: x86_64-randconfig-a014-20220108 (https://download.01.org/0day-ci/archive/20220109/202201090323.0gexKYhO-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=4e348e961395297bb17f101cc63bc133d8a348e9
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout 4e348e961395297bb17f101cc63bc133d8a348e9
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> usr/include/linux/neighbour.h:9: found __[us]{8,16,32,64} type without #include <linux/types.h>
--
>> usr/include/linux/if_addr.h:9: found __[us]{8,16,32,64} type without #include <linux/types.h>
--
>> usr/include/linux/netlink.h:40: found __[us]{8,16,32,64} type without #include <linux/types.h>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
