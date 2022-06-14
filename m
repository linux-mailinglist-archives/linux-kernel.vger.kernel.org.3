Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6AB54A3A2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 03:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244903AbiFNB1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 21:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbiFNB1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 21:27:13 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076F130F5E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 18:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655170031; x=1686706031;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5MJSC94FXE9Q5aSPrzggmB8RiOE58H5/LO4V1zUaLYw=;
  b=OmjFjpqLpGulxSCZ+XSIGI2zwtu3WlQqHBthnE6QqWGBeKCLr+jf1RR+
   0arbF1eh6YZMdSSaNWbHdjyiadLVLB/fpQtnL1xgnmj7nmY2XfRxbiULb
   3vZJEUyEc1fvfHI9y2FI+ZeOPpcBoOkcULCWyCtXXJsvWbvED0s67XIvZ
   GkwimIllzQqQJZCIl9jLh5LnNmVM1nMNHku5/vkUcxUfitbWLYew6NCUM
   1Hv7LK8UwyNxhkFxZtulkxABrsxf3VDmw+Jc63Umf70Ve4Q9CuX2mHj9u
   8Uz76B0cBo7olfKFT39u+ba3caQvXH/C6BwDi8T6wLjlg8tbc3wH8Qj08
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="364794721"
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="364794721"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 18:27:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="582471651"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 13 Jun 2022 18:27:07 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0vKl-000LJu-48;
        Tue, 14 Jun 2022 01:27:07 +0000
Date:   Tue, 14 Jun 2022 09:26:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     jingyuwang <jingyuwang_vip@163.com>, akpm@linux-foundation.org,
        rostedt@goodmis.org, mhiramat@kernel.org, vbabka@suse.cz,
        ahalaney@redhat.com, Jason@zx2c4.com, mark-pk.tsai@mediatek.com
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        jingyuwang <jingyuwang_vip@163.com>
Subject: Re: [PATCH] Fix the following checkpatch error:
Message-ID: <202206140910.24mkxBXB-lkp@intel.com>
References: <20220613202210.31759-1-jingyuwang_vip@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613202210.31759-1-jingyuwang_vip@163.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi jingyuwang,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v5.19-rc2 next-20220610]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/jingyuwang/Fix-the-following-checkpatch-error/20220614-050258
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220614/202206140910.24mkxBXB-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/35742a839670fa8937c7040160e16b7009b2a9ae
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review jingyuwang/Fix-the-following-checkpatch-error/20220614-050258
        git checkout 35742a839670fa8937c7040160e16b7009b2a9ae
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   init/main.c:773:20: warning: no previous prototype for 'arch_post_acpi_subsys_init' [-Wmissing-prototypes]
     773 | void __init __weak arch_post_acpi_subsys_init(void) { }
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   init/main.c:785:20: warning: no previous prototype for 'mem_encrypt_init' [-Wmissing-prototypes]
     785 | void __init __weak mem_encrypt_init(void) { }
         |                    ^~~~~~~~~~~~~~~~
   init/main.c:787:20: warning: no previous prototype for 'poking_init' [-Wmissing-prototypes]
     787 | void __init __weak poking_init(void) { }
         |                    ^~~~~~~~~~~
   In file included from include/linux/printk.h:6,
                    from include/linux/kernel.h:29,
                    from include/linux/cpumask.h:10,
                    from include/linux/mm_types_task.h:14,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from init/main.c:17:
>> include/linux/init.h:316:27: error: '__setup_str_initcall_blacklist' causes a section type conflict with 'initcall_level_names'
     316 |         static const char __setup_str_##unique_id[] __initconst         \
         |                           ^~~~~~~~~~~~
   include/linux/init.h:329:9: note: in expansion of macro '__setup_param'
     329 |         __setup_param(str, fn, fn, 0)
         |         ^~~~~~~~~~~~~
   init/main.c:1239:1: note: in expansion of macro '__setup'
    1239 | __setup("initcall_blacklist=", initcall_blacklist);
         | ^~~~~~~
   init/main.c:1344:20: note: 'initcall_level_names' was declared here
    1344 | static const char *initcall_level_names[] __initconst = {
         |                    ^~~~~~~~~~~~~~~~~~~~


vim +316 include/linux/init.h

^1da177e4c3f41 Linus Torvalds 2005-04-16  308  
^1da177e4c3f41 Linus Torvalds 2005-04-16  309  /*
^1da177e4c3f41 Linus Torvalds 2005-04-16  310   * Only for really core code.  See moduleparam.h for the normal way.
^1da177e4c3f41 Linus Torvalds 2005-04-16  311   *
^1da177e4c3f41 Linus Torvalds 2005-04-16  312   * Force the alignment so the compiler doesn't space elements of the
^1da177e4c3f41 Linus Torvalds 2005-04-16  313   * obs_kernel_param "array" too far apart in .init.setup.
^1da177e4c3f41 Linus Torvalds 2005-04-16  314   */
^1da177e4c3f41 Linus Torvalds 2005-04-16  315  #define __setup_param(str, unique_id, fn, early)			\
fd6c3a8dc44329 Jan Beulich    2009-03-12 @316  	static const char __setup_str_##unique_id[] __initconst		\
fd6c3a8dc44329 Jan Beulich    2009-03-12  317  		__aligned(1) = str; 					\
^1da177e4c3f41 Linus Torvalds 2005-04-16  318  	static struct obs_kernel_param __setup_##unique_id		\
33def8498fdde1 Joe Perches    2020-10-21  319  		__used __section(".init.setup")				\
147ad605dc12c5 Johan Hovold   2020-11-23  320  		__aligned(__alignof__(struct obs_kernel_param))		\
^1da177e4c3f41 Linus Torvalds 2005-04-16  321  		= { __setup_str_##unique_id, fn, early }
^1da177e4c3f41 Linus Torvalds 2005-04-16  322  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
