Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4309359B259
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 08:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiHUGwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 02:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiHUGwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 02:52:40 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B72822521
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 23:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661064759; x=1692600759;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=b67IsNnJhJZXwjsvQnCc2klpUpKpU5ujWx41lFQeQT0=;
  b=HRMy+rZYvRS2O2lDskPpGyAK92QDHWeDN/kzWCdzkCuxteMFQjn7jZFV
   Wve6i7C0ndEgHXoXzMsLiZnEcEy4C4mS6zpgtbOswJ2wtgJdfluDXVVBz
   GOCngtgA466rWwFX5x4llhahGB0p/LKcsaIEEppZj/alferLs+a7N9bUe
   A/C3F/wV1fjFY/WVnLbDNCIvc5qa3Cqr4fewitl5v6f9wGDKCA5FgJoHw
   m5cJkYxmZONKHVx8gcuLMlZQM8frOsrOn8XEZodFw1Od/B3UNc4RBfbCG
   UqYU7tgvgY1/ciNVjy5vsYfauoR9K7zHVxWGp9ZmydWPVmRuhw9LWV2mK
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10445"; a="280194956"
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="280194956"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2022 23:52:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="697948166"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Aug 2022 23:52:37 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPep2-0003mP-2d;
        Sun, 21 Aug 2022 06:52:36 +0000
Date:   Sun, 21 Aug 2022 14:52:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [hverkuil-media-tree:extron 94/94]
 arch/x86/include/asm/thread_info.h:175:13: error: calling
 '__builtin_frame_address' with a nonzero argument is unsafe
Message-ID: <202208211427.2SoCEKiR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://linuxtv.org/hverkuil/media_tree.git extron
head:   1540c2ffcd7f0fb1320c24f214d02a5c08f9fb2c
commit: 1540c2ffcd7f0fb1320c24f214d02a5c08f9fb2c [94/94] cec/extron-da-hd-4k-plus: add the Extron DA HD 4K Plus CEC driver
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220821/202208211427.2SoCEKiR-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 0ac597f3cacf60479ffd36b03766fa7462dabd78)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add hverkuil-media-tree git://linuxtv.org/hverkuil/media_tree.git
        git fetch --no-tags hverkuil-media-tree extron
        git checkout 1540c2ffcd7f0fb1320c24f214d02a5c08f9fb2c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/media/cec/usb/extron-da-hd-4k-plus/extron-da-hd-4k-plus.c:31:
   In file included from include/linux/completion.h:12:
   In file included from include/linux/swait.h:7:
   In file included from include/linux/spinlock.h:55:
   In file included from include/linux/preempt.h:78:
   In file included from arch/x86/include/asm/preempt.h:7:
   In file included from include/linux/thread_info.h:60:
>> arch/x86/include/asm/thread_info.h:175:13: error: calling '__builtin_frame_address' with a nonzero argument is unsafe [-Werror,-Wframe-address]
           oldframe = __builtin_frame_address(1);
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/thread_info.h:177:11: error: calling '__builtin_frame_address' with a nonzero argument is unsafe [-Werror,-Wframe-address]
                   frame = __builtin_frame_address(2);
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~
   2 errors generated.


vim +/__builtin_frame_address +175 arch/x86/include/asm/thread_info.h

2052e8d40ad58b include/asm-x86/thread_info.h      Christoph Lameter 2008-05-12  157  
0f60a8efe4005a arch/x86/include/asm/thread_info.h Kees Cook         2016-07-12  158  /*
0f60a8efe4005a arch/x86/include/asm/thread_info.h Kees Cook         2016-07-12  159   * Walks up the stack frames to make sure that the specified object is
0f60a8efe4005a arch/x86/include/asm/thread_info.h Kees Cook         2016-07-12  160   * entirely contained by a single stack frame.
0f60a8efe4005a arch/x86/include/asm/thread_info.h Kees Cook         2016-07-12  161   *
0f60a8efe4005a arch/x86/include/asm/thread_info.h Kees Cook         2016-07-12  162   * Returns:
96dc4f9fb64690 arch/x86/include/asm/thread_info.h Sahara            2017-02-16  163   *	GOOD_FRAME	if within a frame
96dc4f9fb64690 arch/x86/include/asm/thread_info.h Sahara            2017-02-16  164   *	BAD_STACK	if placed across a frame boundary (or outside stack)
96dc4f9fb64690 arch/x86/include/asm/thread_info.h Sahara            2017-02-16  165   *	NOT_STACK	unable to determine (no frame pointers, etc)
0f60a8efe4005a arch/x86/include/asm/thread_info.h Kees Cook         2016-07-12  166   */
0f60a8efe4005a arch/x86/include/asm/thread_info.h Kees Cook         2016-07-12  167  static inline int arch_within_stack_frames(const void * const stack,
0f60a8efe4005a arch/x86/include/asm/thread_info.h Kees Cook         2016-07-12  168  					   const void * const stackend,
0f60a8efe4005a arch/x86/include/asm/thread_info.h Kees Cook         2016-07-12  169  					   const void *obj, unsigned long len)
0f60a8efe4005a arch/x86/include/asm/thread_info.h Kees Cook         2016-07-12  170  {
0f60a8efe4005a arch/x86/include/asm/thread_info.h Kees Cook         2016-07-12  171  #if defined(CONFIG_FRAME_POINTER)
0f60a8efe4005a arch/x86/include/asm/thread_info.h Kees Cook         2016-07-12  172  	const void *frame = NULL;
0f60a8efe4005a arch/x86/include/asm/thread_info.h Kees Cook         2016-07-12  173  	const void *oldframe;
0f60a8efe4005a arch/x86/include/asm/thread_info.h Kees Cook         2016-07-12  174  
0f60a8efe4005a arch/x86/include/asm/thread_info.h Kees Cook         2016-07-12 @175  	oldframe = __builtin_frame_address(1);
0f60a8efe4005a arch/x86/include/asm/thread_info.h Kees Cook         2016-07-12  176  	if (oldframe)
0f60a8efe4005a arch/x86/include/asm/thread_info.h Kees Cook         2016-07-12  177  		frame = __builtin_frame_address(2);
0f60a8efe4005a arch/x86/include/asm/thread_info.h Kees Cook         2016-07-12  178  	/*
0f60a8efe4005a arch/x86/include/asm/thread_info.h Kees Cook         2016-07-12  179  	 * low ----------------------------------------------> high
0f60a8efe4005a arch/x86/include/asm/thread_info.h Kees Cook         2016-07-12  180  	 * [saved bp][saved ip][args][local vars][saved bp][saved ip]
0f60a8efe4005a arch/x86/include/asm/thread_info.h Kees Cook         2016-07-12  181  	 *                     ^----------------^
0f60a8efe4005a arch/x86/include/asm/thread_info.h Kees Cook         2016-07-12  182  	 *               allow copies only within here
0f60a8efe4005a arch/x86/include/asm/thread_info.h Kees Cook         2016-07-12  183  	 */
0f60a8efe4005a arch/x86/include/asm/thread_info.h Kees Cook         2016-07-12  184  	while (stack <= frame && frame < stackend) {
0f60a8efe4005a arch/x86/include/asm/thread_info.h Kees Cook         2016-07-12  185  		/*
0f60a8efe4005a arch/x86/include/asm/thread_info.h Kees Cook         2016-07-12  186  		 * If obj + len extends past the last frame, this
0f60a8efe4005a arch/x86/include/asm/thread_info.h Kees Cook         2016-07-12  187  		 * check won't pass and the next frame will be 0,
0f60a8efe4005a arch/x86/include/asm/thread_info.h Kees Cook         2016-07-12  188  		 * causing us to bail out and correctly report
0f60a8efe4005a arch/x86/include/asm/thread_info.h Kees Cook         2016-07-12  189  		 * the copy as invalid.
0f60a8efe4005a arch/x86/include/asm/thread_info.h Kees Cook         2016-07-12  190  		 */
0f60a8efe4005a arch/x86/include/asm/thread_info.h Kees Cook         2016-07-12  191  		if (obj + len <= frame)
96dc4f9fb64690 arch/x86/include/asm/thread_info.h Sahara            2017-02-16  192  			return obj >= oldframe + 2 * sizeof(void *) ?
96dc4f9fb64690 arch/x86/include/asm/thread_info.h Sahara            2017-02-16  193  				GOOD_FRAME : BAD_STACK;
0f60a8efe4005a arch/x86/include/asm/thread_info.h Kees Cook         2016-07-12  194  		oldframe = frame;
0f60a8efe4005a arch/x86/include/asm/thread_info.h Kees Cook         2016-07-12  195  		frame = *(const void * const *)frame;
0f60a8efe4005a arch/x86/include/asm/thread_info.h Kees Cook         2016-07-12  196  	}
96dc4f9fb64690 arch/x86/include/asm/thread_info.h Sahara            2017-02-16  197  	return BAD_STACK;
0f60a8efe4005a arch/x86/include/asm/thread_info.h Kees Cook         2016-07-12  198  #else
96dc4f9fb64690 arch/x86/include/asm/thread_info.h Sahara            2017-02-16  199  	return NOT_STACK;
0f60a8efe4005a arch/x86/include/asm/thread_info.h Kees Cook         2016-07-12  200  #endif
0f60a8efe4005a arch/x86/include/asm/thread_info.h Kees Cook         2016-07-12  201  }
0f60a8efe4005a arch/x86/include/asm/thread_info.h Kees Cook         2016-07-12  202  

:::::: The code at line 175 was first introduced by commit
:::::: 0f60a8efe4005ab5e65ce000724b04d4ca04a199 mm: Implement stack frame object validation

:::::: TO: Kees Cook <keescook@chromium.org>
:::::: CC: Kees Cook <keescook@chromium.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
