Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9CA24A98D6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 13:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239121AbiBDMDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 07:03:25 -0500
Received: from mga06.intel.com ([134.134.136.31]:9665 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230211AbiBDMDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 07:03:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643976202; x=1675512202;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=abpUaTtKY8xSEdJyP7jpPeDD/RGtb2t5uYh87xuapLg=;
  b=TTrBwStQwBp9CLjeadUDSEcf9iilpexkmeUK6nlwof97SJ4yf8SmFAhy
   351GAiP0tA1/P2QId05N6RzLauUYAgNXbzXKguHeGESrm4WDhSnEw4h/R
   nuBoV6FDyIsrYY9wGr2cknzSO+otDerAZtTqZTx8TRFtH1F9ufD76u9Rr
   0OblILHR+rANrzYlRSUZecASuS1Pd0vT7irdiCgVavDGxC0xq0bwRQdg9
   sEwIlFUblp81zDyaBb7jGkahveOA2Wv0Crq4M7ZcdpoZldtfV2/oufhWs
   1n/hbnFJkVz+1sPQ/kP7fClu9dBoMxrVbyDxtRVOW8HTT5ie5tqNRUBxB
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="309101865"
X-IronPort-AV: E=Sophos;i="5.88,342,1635231600"; 
   d="scan'208";a="309101865"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 04:03:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,342,1635231600"; 
   d="scan'208";a="566724322"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 04 Feb 2022 04:03:20 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFxJ9-000XZV-J6; Fri, 04 Feb 2022 12:03:19 +0000
Date:   Fri, 4 Feb 2022 20:03:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jonghyeon Kim <tome01@ajou.ac.kr>
Cc:     kbuild-all@lists.01.org, Jonghyeon Kim <tome01@ajou.ac.kr>,
        SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: Rebase DAMON_RECALIM watermarks for NUMA nodes
Message-ID: <202202041942.7wbmfmQ3-lkp@intel.com>
References: <20220204064059.6244-1-tome01@ajou.ac.kr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204064059.6244-1-tome01@ajou.ac.kr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonghyeon,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on hnaz-mm/master]

url:    https://github.com/0day-ci/linux/commits/Jonghyeon-Kim/mm-damon-Rebase-DAMON_RECALIM-watermarks-for-NUMA-nodes/20220204-144249
base:   https://github.com/hnaz/linux-mm master
config: nds32-randconfig-r031-20220130 (https://download.01.org/0day-ci/archive/20220204/202202041942.7wbmfmQ3-lkp@intel.com/config)
compiler: nds32le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/68abc90556004f51e2f388a1d87d0d2690340b8d
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jonghyeon-Kim/mm-damon-Rebase-DAMON_RECALIM-watermarks-for-NUMA-nodes/20220204-144249
        git checkout 68abc90556004f51e2f388a1d87d0d2690340b8d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   nds32le-linux-ld: mm/damon/core.o: in function `kdamond_fn':
   core.c:(.text+0xb88): undefined reference to `si_meminfo_node'
>> nds32le-linux-ld: core.c:(.text+0xb8c): undefined reference to `si_meminfo_node'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
