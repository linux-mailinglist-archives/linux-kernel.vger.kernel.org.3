Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D584A9937
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 13:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358759AbiBDMYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 07:24:24 -0500
Received: from mga14.intel.com ([192.55.52.115]:63290 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1358735AbiBDMYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 07:24:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643977462; x=1675513462;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xDWPgvPIZxAfOnRp39d2iWRpOEozvCXQ75/8Sv3lweQ=;
  b=ay8snxC+oWSZv7cRF5SU/C7cRy0BgjKh06XAC2ExWMUnlAKVKNoGZJ51
   uNTMR/5juX0BrbflXdHvR2K8ybcSiKyqHTuCzDimQPWXNbJKnnX6t0t5s
   y1rWMf5Mjd0amZ1SLqxZPrTUknKwI4APg2V0W5wbC60FN1S6we8icmiAF
   Tg5qBFuJBiq/KLNqdEsiHBl3OWKPyaHzpjLktqhHqjsPOUO+9la1O+I9q
   tRXXPOM1fhG7kCiHjJHsNH3Bxh6cuP0f93rNVdqcVYDY0yxENza6glWqK
   +EYTmjjYyXsnn+aeWa8QlKtH9U3F4RmSxhlluRg9BlttLGXHLbpIwdyeF
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="248572198"
X-IronPort-AV: E=Sophos;i="5.88,342,1635231600"; 
   d="scan'208";a="248572198"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 04:24:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,342,1635231600"; 
   d="scan'208";a="627764472"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 04 Feb 2022 04:24:21 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFxdU-000XbJ-EY; Fri, 04 Feb 2022 12:24:20 +0000
Date:   Fri, 4 Feb 2022 20:23:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jonghyeon Kim <tome01@ajou.ac.kr>
Cc:     kbuild-all@lists.01.org, Jonghyeon Kim <tome01@ajou.ac.kr>,
        SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: Rebase DAMON_RECALIM watermarks for NUMA nodes
Message-ID: <202202042046.8vkLpAyg-lkp@intel.com>
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
config: arm-randconfig-c002-20220130 (https://download.01.org/0day-ci/archive/20220204/202202042046.8vkLpAyg-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/68abc90556004f51e2f388a1d87d0d2690340b8d
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jonghyeon-Kim/mm-damon-Rebase-DAMON_RECALIM-watermarks-for-NUMA-nodes/20220204-144249
        git checkout 68abc90556004f51e2f388a1d87d0d2690340b8d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: arch/arm/mach-dove/pcie.o: in function `dove_pcie_setup':
   pcie.c:(.init.text+0x144): undefined reference to `pci_remap_iospace'
   arm-linux-gnueabi-ld: mm/damon/core.o: in function `kdamond_fn':
>> core.c:(.text+0x10a4): undefined reference to `si_meminfo_node'
   arm-linux-gnueabi-ld: drivers/pci/pci.o: in function `devm_pci_remap_iospace':
   pci.c:(.text+0x513c): undefined reference to `pci_remap_iospace'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
