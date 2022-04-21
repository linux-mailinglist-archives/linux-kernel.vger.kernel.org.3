Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB1750A048
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 15:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbiDUNGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 09:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiDUNGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 09:06:15 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143F8338B5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650546206; x=1682082206;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=motXs5KVTHeBonIQQERqYU8O1E/gky/yojvQugo6wqo=;
  b=JJogByNPaDabDOgZI31y52dlfhR2sS23xWUfc8RfbL4Bv1Y4pM/FL8Fv
   8CTVxOfCT9Q8jbKQnqDCW2ZA8wbFswyzxHbQ53A8D/PexwlcouvnvDHVj
   +1ByCqY9L8gd0on676S4Gq7AksYt+f0JtgDMEGJ6WLCQxSKph2xBQY5Jp
   tl9uH+q+CPFJLg4poyG7/FjodC7y5fHmgfM7BzX1WI2PXyDYLlRrIgJAZ
   5T9a9C7Ct4wb82hiR40XvPpir0I6a98uiR0Ee6tSjUBKTHzW8nxqcb3zT
   4L6N3XgwMdFhCInaexkzs4Pk/LDAZyzG3jcAyBjvMhW+eOokUVgmKw4fv
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="327245882"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="327245882"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 06:02:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="648122772"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Apr 2022 06:02:15 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhWRq-0008Q1-O0;
        Thu, 21 Apr 2022 13:02:14 +0000
Date:   Thu, 21 Apr 2022 21:01:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1933/2579] lib/memcat_p.c:10:8: warning: no
 previous prototype for function '__memcat_p'
Message-ID: <202204212135.0nRWoKwW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   49e1ec6c70a6eb4b7de9250a455b8b63eb42afbe
commit: b17c57b9f326f544a10178f2be4c886c4b02b4f3 [1933/2579] headers/deps: smp: Optimize <linux/smp.h> dependencies, remove <linux/smp_api.h> inclusion
config: mips-randconfig-r026-20220419 (https://download.01.org/0day-ci/archive/20220421/202204212135.0nRWoKwW-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c1c49a356162b22554088d269f7689bdb044a9f1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=b17c57b9f326f544a10178f2be4c886c4b02b4f3
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout b17c57b9f326f544a10178f2be4c886c4b02b4f3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> lib/memcat_p.c:10:8: warning: no previous prototype for function '__memcat_p' [-Wmissing-prototypes]
   void **__memcat_p(void **a, void **b)
          ^
   lib/memcat_p.c:10:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void **__memcat_p(void **a, void **b)
   ^
   static 
   1 warning generated.


vim +/__memcat_p +10 lib/memcat_p.c

93048c0944150b Alexander Shishkin 2018-10-16   4  
93048c0944150b Alexander Shishkin 2018-10-16   5  /*
93048c0944150b Alexander Shishkin 2018-10-16   6   * Merge two NULL-terminated pointer arrays into a newly allocated
93048c0944150b Alexander Shishkin 2018-10-16   7   * array, which is also NULL-terminated. Nomenclature is inspired by
93048c0944150b Alexander Shishkin 2018-10-16   8   * memset_p() and memcat() found elsewhere in the kernel source tree.
93048c0944150b Alexander Shishkin 2018-10-16   9   */
93048c0944150b Alexander Shishkin 2018-10-16 @10  void **__memcat_p(void **a, void **b)

:::::: The code at line 10 was first introduced by commit
:::::: 93048c0944150b316a15f92c41a4d626c8df37fd lib: Fix ia64 bootloader linkage

:::::: TO: Alexander Shishkin <alexander.shishkin@linux.intel.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
