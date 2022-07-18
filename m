Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071E0578E31
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 01:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbiGRXRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 19:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbiGRXRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 19:17:05 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE5433404
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 16:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658186224; x=1689722224;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+IxFfiondMcYgpEccKsKG84qfbAwNXjUIPRDCC3r4sQ=;
  b=Dro28gj6I1hYi0e0Hhe8oEvJqeqlS+dby+bgMHq+0d47EDhSn0j5+22H
   fqmY+BlFWgy8eC1+jvi3trhwsp9cbgYZS4e4XsUhlSpcDTKU/+Fqyxq4c
   H7wQqg1IFfPL9zoEiLMpTlxCYjn75B6pUFnTUDD8frjjFohOZGzGI/HU5
   4qVS+C+Dij5QHzOf4htcrUy7OxfBnIR73qm8TLEzIjRpYYvJr2b+t2Qqm
   ppzHIWHLmZZ4NFiVcw9Fff4tZoA0JSwCLb2J3ihwuGFCngwEkPUxxNwWl
   SzxIoeIKhGAFPFQBNDPsrD5544l8jXlXLfI4hu/P0J4BtbZ0E1IGzckCi
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="283906559"
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="283906559"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 16:17:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="547684792"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 18 Jul 2022 16:17:02 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oDZz3-0004qp-Mt;
        Mon, 18 Jul 2022 23:17:01 +0000
Date:   Tue, 19 Jul 2022 07:16:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Helge Deller <deller@gmx.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        John David Anglin <dave.anglin@bell.net>
Subject: arch/parisc/kernel/cache.c:50:1: sparse: sparse: symbol
 'pa_swapper_pg_lock' was not declared. Should it be static?
Message-ID: <202207190738.uOrugo2G-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   80e19f34c2887a8881084b7bb7480e9544d56b91
commit: b7795074a04669d0a023babf786d29bf67c68783 parisc: Optimize per-pagetable spinlocks
date:   1 year, 5 months ago
config: parisc-randconfig-s032-20220718 (https://download.01.org/0day-ci/archive/20220719/202207190738.uOrugo2G-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b7795074a04669d0a023babf786d29bf67c68783
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout b7795074a04669d0a023babf786d29bf67c68783
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/parisc/kernel/cache.c:50:1: sparse: sparse: symbol 'pa_swapper_pg_lock' was not declared. Should it be static?

vim +/pa_swapper_pg_lock +50 arch/parisc/kernel/cache.c

b37d1c1898b288 Mikulas Patocka 2019-04-28  45   * this.
^1da177e4c3f41 Linus Torvalds  2005-04-16  46   */
b37d1c1898b288 Mikulas Patocka 2019-04-28  47  DEFINE_SPINLOCK(pa_tlb_flush_lock);
b37d1c1898b288 Mikulas Patocka 2019-04-28  48  
b37d1c1898b288 Mikulas Patocka 2019-04-28  49  /* Swapper page setup lock. */
b37d1c1898b288 Mikulas Patocka 2019-04-28 @50  DEFINE_SPINLOCK(pa_swapper_pg_lock);
b37d1c1898b288 Mikulas Patocka 2019-04-28  51  
b37d1c1898b288 Mikulas Patocka 2019-04-28  52  #if defined(CONFIG_64BIT) && defined(CONFIG_SMP)

:::::: The code at line 50 was first introduced by commit
:::::: b37d1c1898b288c69f3dc9267bc2c41af06f4a4b parisc: Use per-pagetable spinlock

:::::: TO: Mikulas Patocka <mpatocka@redhat.com>
:::::: CC: Helge Deller <deller@gmx.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
