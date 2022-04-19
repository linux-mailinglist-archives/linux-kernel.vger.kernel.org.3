Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9905062D9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 05:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348128AbiDSDkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 23:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345766AbiDSDkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 23:40:04 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED3864C0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 20:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650339443; x=1681875443;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=J/G2QZDGh8sjb3ZQF69dyulE/K9NIO0fCCRcHcgaSBc=;
  b=W//hwL3l4IAOJ9GV+di8bwCKtcp7E8YYhautSGTR0DqFtB3OdWp26Rla
   As8H9WnCYqLmRT9iiIbQb7oCXn6wajpJKPKD+BUnvsCC+HRA1p9pG8Wfg
   Vvntsu6iMDDtVh39QAOooCqrgP6q1f4Utrx4Wkxi1B0ZiYtI53DTBj0d5
   uJETp6Yz2AYrkLUSSAJDyOWe10S6LddathQ1FTvq8df87oYsvVnYWi7+4
   U8BrDkiO0oitkFg27aBHvqlAZI10GWxexOg3ShHOdbw55dlGzXTbuf0yn
   OGbdELuMzs7s4zUJiovI7TsdOawgD6ymLPZ89EL3FAWoiHesRuU/E8sHn
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="262525578"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="262525578"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 20:37:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="860438115"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 18 Apr 2022 20:37:21 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngeg4-0005Id-P4;
        Tue, 19 Apr 2022 03:37:20 +0000
Date:   Tue, 19 Apr 2022 11:36:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1729/2356] mm/damon/ops-common.c:24:15:
 warning: incompatible integer to pointer conversion initializing 'struct
 page *' with an expression of type 'int'
Message-ID: <202204191122.Mc8zEXBp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   af93551cf39027d176f30b9beafc60a4c130998a
commit: 7eedc6a3354abcdcb3fbec4de62d4df0fa11c55d [1729/2356] headers/deps: mm/mmzone: Optimize <linux/mmzone.h> dependencies, remove <linux/memory_hotplug.h> inclusion
config: i386-randconfig-a015-20220418 (https://download.01.org/0day-ci/archive/20220419/202204191122.Mc8zEXBp-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 429cbac0390654f90bba18a41799464adf31a5ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=7eedc6a3354abcdcb3fbec4de62d4df0fa11c55d
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 7eedc6a3354abcdcb3fbec4de62d4df0fa11c55d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/block/ drivers/clk/ drivers/iio/accel/ drivers/infiniband/core/ drivers/infiniband/ulp/ipoib/ drivers/input/touchscreen/ drivers/mmc/host/ drivers/net/dsa/ drivers/nvdimm/ drivers/powercap/ drivers/usb/typec/ mm/damon/ net/dsa/ net/smc/ sound/soc/codecs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   mm/damon/ops-common.c:24:22: error: implicit declaration of function 'pfn_to_online_page' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           struct page *page = pfn_to_online_page(pfn);
                               ^
>> mm/damon/ops-common.c:24:15: warning: incompatible integer to pointer conversion initializing 'struct page *' with an expression of type 'int' [-Wint-conversion]
           struct page *page = pfn_to_online_page(pfn);
                        ^      ~~~~~~~~~~~~~~~~~~~~~~~
   1 warning and 1 error generated.


vim +24 mm/damon/ops-common.c

46c3a0accdc48c mm/damon/prmtv-common.c SeongJae Park 2021-11-05  14  
46c3a0accdc48c mm/damon/prmtv-common.c SeongJae Park 2021-11-05  15  /*
46c3a0accdc48c mm/damon/prmtv-common.c SeongJae Park 2021-11-05  16   * Get an online page for a pfn if it's in the LRU list.  Otherwise, returns
46c3a0accdc48c mm/damon/prmtv-common.c SeongJae Park 2021-11-05  17   * NULL.
46c3a0accdc48c mm/damon/prmtv-common.c SeongJae Park 2021-11-05  18   *
46c3a0accdc48c mm/damon/prmtv-common.c SeongJae Park 2021-11-05  19   * The body of this function is stolen from the 'page_idle_get_page()'.  We
46c3a0accdc48c mm/damon/prmtv-common.c SeongJae Park 2021-11-05  20   * steal rather than reuse it because the code is quite simple.
46c3a0accdc48c mm/damon/prmtv-common.c SeongJae Park 2021-11-05  21   */
46c3a0accdc48c mm/damon/prmtv-common.c SeongJae Park 2021-11-05  22  struct page *damon_get_page(unsigned long pfn)
46c3a0accdc48c mm/damon/prmtv-common.c SeongJae Park 2021-11-05  23  {
46c3a0accdc48c mm/damon/prmtv-common.c SeongJae Park 2021-11-05 @24  	struct page *page = pfn_to_online_page(pfn);
46c3a0accdc48c mm/damon/prmtv-common.c SeongJae Park 2021-11-05  25  
46c3a0accdc48c mm/damon/prmtv-common.c SeongJae Park 2021-11-05  26  	if (!page || !PageLRU(page) || !get_page_unless_zero(page))
46c3a0accdc48c mm/damon/prmtv-common.c SeongJae Park 2021-11-05  27  		return NULL;
46c3a0accdc48c mm/damon/prmtv-common.c SeongJae Park 2021-11-05  28  
46c3a0accdc48c mm/damon/prmtv-common.c SeongJae Park 2021-11-05  29  	if (unlikely(!PageLRU(page))) {
46c3a0accdc48c mm/damon/prmtv-common.c SeongJae Park 2021-11-05  30  		put_page(page);
46c3a0accdc48c mm/damon/prmtv-common.c SeongJae Park 2021-11-05  31  		page = NULL;
46c3a0accdc48c mm/damon/prmtv-common.c SeongJae Park 2021-11-05  32  	}
46c3a0accdc48c mm/damon/prmtv-common.c SeongJae Park 2021-11-05  33  	return page;
46c3a0accdc48c mm/damon/prmtv-common.c SeongJae Park 2021-11-05  34  }
46c3a0accdc48c mm/damon/prmtv-common.c SeongJae Park 2021-11-05  35  

:::::: The code at line 24 was first introduced by commit
:::::: 46c3a0accdc48c86928157fd073e66807f338485 mm/damon/vaddr: separate commonly usable functions

:::::: TO: SeongJae Park <sj@kernel.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
