Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB7F59AD3E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 12:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345052AbiHTK2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 06:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbiHTK2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 06:28:35 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4621B33E33
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 03:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660991312; x=1692527312;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7X0MsbAZ7WZatX6iWC3r8BErgKmsmjeytsGFjw5sf34=;
  b=bsQgRYIPnpeD9vjsYrPcZRp8dr09JBbdzB+67rLGhS/T2pfn9G8SXF8M
   Bnumh9C3EqBm6fEDNh0Cap3BBUCFmMQch3C9wD8TjfkP/s/K5ivzUxAbr
   juzMv12mBecOvByA9m7BSF5cowCjUY4o5rcjYf18R5ldAV9o5lOaNiBmj
   dXEA35US2cnHtOAmXeftyyyDFskZksQo5y6zR9qcM/7so7L3dP3ex/x5A
   +UpKWyeaOWV1BlZaYrHAGB5RlrdjVh6EDy7/Xfa9s3czlDh8n9YwbkwI1
   qNQsqmVWDAJCSqTYfcYGAUcmvF7w4elckzDGGa0+CCORGGARqCm1qb8p0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10444"; a="280131619"
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="280131619"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2022 03:28:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="641518655"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 20 Aug 2022 03:28:27 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPLiM-0002UJ-35;
        Sat, 20 Aug 2022 10:28:26 +0000
Date:   Sat, 20 Aug 2022 18:28:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Huang Ying <ying.huang@intel.com>
Subject: [ammarfaizi2-block:akpm/mm/mm-unstable 101/170] mm/memory.c:68:10:
 fatal error: linux/memory-tiers.h: No such file or directory
Message-ID: <202208201850.nGhRnTHY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block akpm/mm/mm-unstable
head:   1b745fa43c32e6a6ffb4d922114d75019830a9e2
commit: 71c09d5dbc03732b9f98485edc03c272e7e8a79c [101/170] memory-tiering-hot-page-selection-with-hint-page-fault-latency-fix.txt
config: arm-defconfig (https://download.01.org/0day-ci/archive/20220820/202208201850.nGhRnTHY-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/71c09d5dbc03732b9f98485edc03c272e7e8a79c
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block akpm/mm/mm-unstable
        git checkout 71c09d5dbc03732b9f98485edc03c272e7e8a79c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

Note: the ammarfaizi2-block/akpm/mm/mm-unstable HEAD 1b745fa43c32e6a6ffb4d922114d75019830a9e2 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

>> mm/memory.c:68:10: fatal error: linux/memory-tiers.h: No such file or directory
      68 | #include <linux/memory-tiers.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +68 mm/memory.c

  > 68	#include <linux/memory-tiers.h>
    69	#include <linux/string.h>
    70	#include <linux/debugfs.h>
    71	#include <linux/userfaultfd_k.h>
    72	#include <linux/dax.h>
    73	#include <linux/oom.h>
    74	#include <linux/numa.h>
    75	#include <linux/perf_event.h>
    76	#include <linux/ptrace.h>
    77	#include <linux/vmalloc.h>
    78	#include <linux/sched/sysctl.h>
    79	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
