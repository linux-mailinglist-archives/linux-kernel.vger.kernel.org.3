Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4524B517BD0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 04:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiECCIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 22:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiECCIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 22:08:40 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAEF3AA7A
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 19:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651543510; x=1683079510;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/hXC35HPvlxH3T+ghZTTmqCyfsWHn/R3ik2lq6LAws8=;
  b=Hi/HCQTHDIjiLZtjBlngcaMhj05TmZrfG2dSznkNDGSpgJ2Wyi7Uvt5d
   N+iptLmbkFaIpGQPNB6h7yWakmvXoxl/IiaS6+I9kgA6AVy/AX0qWVGos
   tUw2obx2w09apWPuWnTPQOpaRAflwHaidvLYAmVaauhg0x1vNwZ2yYuGC
   WVIBgx/yYd76WjiuHOt/4BMvuUID6OwJMf7INXrhia6nxxf9sloS6NHzK
   DSQBRfcvjwO4SgIpmVdQ4FffwIXXh0hiE5FVsgsqbWHh/ibHMmsYMlNdE
   CAeGBC2Tgmr8aWa7BFVM4C1mSFqdoDoD+unIvc9LU3/WhTzXD12BSYE90
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="353812747"
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="353812747"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 18:26:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="620150460"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 02 May 2022 18:26:12 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlhIq-000A2p-1K;
        Tue, 03 May 2022 01:26:12 +0000
Date:   Tue, 3 May 2022 09:25:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: drivers/gpu/drm/i915/i915_sw_fence.c:90:20: error: unused function
 'debug_fence_init_onstack'
Message-ID: <202205030929.Dk88nH74-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9050ba3a61a4b5bd84c2cde092a100404f814f31
commit: 9f4069b055d1508c833115df7493b6e0001e5c9b drm/i915: re-disable -Wframe-address
date:   2 years ago
config: x86_64-randconfig-r023-20220502 (https://download.01.org/0day-ci/archive/20220503/202205030929.Dk88nH74-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 09325d36061e42b495d1f4c7e933e260eac260ed)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9f4069b055d1508c833115df7493b6e0001e5c9b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 9f4069b055d1508c833115df7493b6e0001e5c9b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpu/drm/i915/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/i915/i915_sw_fence.c:90:20: error: unused function 'debug_fence_init_onstack' [-Werror,-Wunused-function]
   static inline void debug_fence_init_onstack(struct i915_sw_fence *fence)
                      ^
>> drivers/gpu/drm/i915/i915_sw_fence.c:111:20: error: unused function 'debug_fence_free' [-Werror,-Wunused-function]
   static inline void debug_fence_free(struct i915_sw_fence *fence)
                      ^
   2 errors generated.


vim +/debug_fence_init_onstack +90 drivers/gpu/drm/i915/i915_sw_fence.c

fc1584059d6c43 Chris Wilson 2016-11-25   89  
214707fc2ce08d Chris Wilson 2017-10-12  @90  static inline void debug_fence_init_onstack(struct i915_sw_fence *fence)
214707fc2ce08d Chris Wilson 2017-10-12   91  {
214707fc2ce08d Chris Wilson 2017-10-12   92  }
214707fc2ce08d Chris Wilson 2017-10-12   93  
fc1584059d6c43 Chris Wilson 2016-11-25   94  static inline void debug_fence_activate(struct i915_sw_fence *fence)
fc1584059d6c43 Chris Wilson 2016-11-25   95  {
fc1584059d6c43 Chris Wilson 2016-11-25   96  }
fc1584059d6c43 Chris Wilson 2016-11-25   97  
fc1584059d6c43 Chris Wilson 2016-11-25   98  static inline void debug_fence_set_state(struct i915_sw_fence *fence,
fc1584059d6c43 Chris Wilson 2016-11-25   99  					 int old, int new)
fc1584059d6c43 Chris Wilson 2016-11-25  100  {
fc1584059d6c43 Chris Wilson 2016-11-25  101  }
fc1584059d6c43 Chris Wilson 2016-11-25  102  
fc1584059d6c43 Chris Wilson 2016-11-25  103  static inline void debug_fence_deactivate(struct i915_sw_fence *fence)
fc1584059d6c43 Chris Wilson 2016-11-25  104  {
fc1584059d6c43 Chris Wilson 2016-11-25  105  }
fc1584059d6c43 Chris Wilson 2016-11-25  106  
fc1584059d6c43 Chris Wilson 2016-11-25  107  static inline void debug_fence_destroy(struct i915_sw_fence *fence)
fc1584059d6c43 Chris Wilson 2016-11-25  108  {
fc1584059d6c43 Chris Wilson 2016-11-25  109  }
fc1584059d6c43 Chris Wilson 2016-11-25  110  
fc1584059d6c43 Chris Wilson 2016-11-25 @111  static inline void debug_fence_free(struct i915_sw_fence *fence)
fc1584059d6c43 Chris Wilson 2016-11-25  112  {
fc1584059d6c43 Chris Wilson 2016-11-25  113  }
fc1584059d6c43 Chris Wilson 2016-11-25  114  

:::::: The code at line 90 was first introduced by commit
:::::: 214707fc2ce08d09982bc4fe4b7a1c1f010e82be drm/i915/selftests: Wrap a timer into a i915_sw_fence

:::::: TO: Chris Wilson <chris@chris-wilson.co.uk>
:::::: CC: Chris Wilson <chris@chris-wilson.co.uk>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
