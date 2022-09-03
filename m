Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A215ABEC4
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 13:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbiICLdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 07:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiICLd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 07:33:29 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0662A642E5
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 04:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662204807; x=1693740807;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aQhwYvMzbi6oqi9STtVTiFF2eQXyNgF4yVk9k1FKWgw=;
  b=VOetTL6t73u2p6oscpf0WApwXKPUrbtA1tfAluflj8yb9AdHZTA5cuxV
   WSwLrI+BspUXeWYQl9B4S0pS2qNTkyzWzifilZ5pxhEf9rOZOAcuWVsTg
   zEl0x1gOhf1W9qJ3bhjNPRl8ogxCOEieskhVM2M95pbKfidUcOsZ8W5LB
   lpriahAKhmLOtr//2UapfUeg1qcprYPcClp6+ir9C1G6lScjKS0S84FIb
   59oIRwhoCzc8XjOlrbQvz4+3YZCCvApQqvJrSaCMwQrJleP0caNsMF4fW
   u2LfSkcIF61zdo7DEc/tMtZspwlTITLyFJwDe+dAf5KzTHvMAfWGRjcyy
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="275896138"
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="275896138"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 04:33:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="755531004"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 03 Sep 2022 04:33:26 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUROv-0001Zk-2l;
        Sat, 03 Sep 2022 11:33:25 +0000
Date:   Sat, 3 Sep 2022 19:33:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Collingbourne <pcc@google.com>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [ammarfaizi2-block:arm64/linux/devel/mte-pg-flags 3/5]
 mm/memory.c:92:2: warning: #warning Unfortunate NUMA and NUMA Balancing
 config, growing page-frame for last_cpupid.
Message-ID: <202209031914.1xwP1jsq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block arm64/linux/devel/mte-pg-flags
head:   7a937f62486a95ed542d051f05e3d6d67c9d0928
commit: 16cd379cfa9ae2607ceb5f2b66c27a5bedb3e2bf [3/5] mm: Add PG_arch_3 page flag
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20220903/202209031914.1xwP1jsq-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/16cd379cfa9ae2607ceb5f2b66c27a5bedb3e2bf
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block arm64/linux/devel/mte-pg-flags
        git checkout 16cd379cfa9ae2607ceb5f2b66c27a5bedb3e2bf
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> mm/memory.c:92:2: warning: #warning Unfortunate NUMA and NUMA Balancing config, growing page-frame for last_cpupid. [-Wcpp]
      92 | #warning Unfortunate NUMA and NUMA Balancing config, growing page-frame for last_cpupid.
         |  ^~~~~~~


vim +92 mm/memory.c

42b7772812d15b Jan Beulich    2008-07-23  90  
af27d9403f5b80 Arnd Bergmann  2018-02-16  91  #if defined(LAST_CPUPID_NOT_IN_PAGE_FLAGS) && !defined(CONFIG_COMPILE_TEST)
90572890d20252 Peter Zijlstra 2013-10-07 @92  #warning Unfortunate NUMA and NUMA Balancing config, growing page-frame for last_cpupid.
75980e97daccfc Peter Zijlstra 2013-02-22  93  #endif
75980e97daccfc Peter Zijlstra 2013-02-22  94  

:::::: The code at line 92 was first introduced by commit
:::::: 90572890d202527c366aa9489b32404e88a7c020 mm: numa: Change page last {nid,pid} into {cpu,pid}

:::::: TO: Peter Zijlstra <peterz@infradead.org>
:::::: CC: Ingo Molnar <mingo@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
