Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D34A59C47B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 18:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235786AbiHVQ67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 12:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234891AbiHVQ65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 12:58:57 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747D713F4A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 09:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661187536; x=1692723536;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lw0sAPkCENe0vTSIoAyxyGpPW+YUlIRxQmC+3cqpAgY=;
  b=QfcE5RLw9EzV8tYQ4VZkaZ/wX8Vpx2gFPUVL2RQcYgxIO52NI0NHIpZG
   BYBWrmxwzXtBoGnn4Dyhkcflpu8mazCxOXNGcaD07eObHN9iZ1eTmCbLE
   zbVHpVnk4xPI5rc6IqpY6UBOiiUHF8m/Om44xDBnUaQVqYKhN2XdDskSf
   1IheV3gDu6GNtRrQSZBipyyYRLed/cbEXMF9wQtHBJqtVEfl7mHns51CK
   SyaEVbw8xKyezVlzSYiL9w4WlkMU2yHgzeSd6JFggsJj+3yvm3YemL21A
   +6DFjmNhRHQQDy4O6XgQh1FQv3zbYKerzvdu/f4j3GHqZTHGQ4MNMg+hY
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="294257288"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="294257288"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 09:58:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="937114179"
Received: from lkp-server01.sh.intel.com (HELO dd9b29378baa) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 22 Aug 2022 09:58:54 -0700
Received: from kbuild by dd9b29378baa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQAlJ-0000UF-20;
        Mon, 22 Aug 2022 16:58:53 +0000
Date:   Tue, 23 Aug 2022 00:58:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: drivers/gpu/drm/i915/i915_sw_fence.c:90:20: error: unused function
 'debug_fence_init_onstack'
Message-ID: <202208230005.ZOG0eeUT-lkp@intel.com>
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

Hi Nick,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1c23f9e627a7b412978b4e852793c5e3c3efc555
commit: 9f4069b055d1508c833115df7493b6e0001e5c9b drm/i915: re-disable -Wframe-address
date:   2 years, 4 months ago
config: x86_64-randconfig-a005-20220822 (https://download.01.org/0day-ci/archive/20220823/202208230005.ZOG0eeUT-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9f4069b055d1508c833115df7493b6e0001e5c9b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 9f4069b055d1508c833115df7493b6e0001e5c9b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
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
