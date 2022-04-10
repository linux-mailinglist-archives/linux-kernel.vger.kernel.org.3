Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62DC04FAEFB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 18:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243640AbiDJQiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 12:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235793AbiDJQiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 12:38:24 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F7F3E0FD
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 09:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649608573; x=1681144573;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OId2k+rI0cp2U8A4cCUrH4qT5EA5H+KoBhzW3FvihMY=;
  b=VR7XySNqe11t5nce8voAjRLbdNr0K7qua+o9s9vnxtTNN5Yb1sGo8uoG
   7D0V0FiXfZYF+vgq2soQVeIkNWkX4EjBIyW6Ca8HfK3ehhVO+MfvW5AwB
   bjJ2TGI8rCHQFKVa0sDnZ988EHIRdOBc+ZjKb8D7w+w8URFv76CmDGre2
   Cc4akwPZpame97bY7QttOUf7NLmu/l4XvKoiY0cT+meyK46sMxnGapteQ
   UBPzpWDG50R5q68YX4NyPsswo9LRBD0e3h01RwUOxQ8393/bGhJoWHC21
   P5wBHriKlwWhxf6qcbWbaSdtSIlxoFQzSBU5jVOkY8i7S+A81svgxgFK5
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="241916948"
X-IronPort-AV: E=Sophos;i="5.90,249,1643702400"; 
   d="scan'208";a="241916948"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2022 09:36:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,249,1643702400"; 
   d="scan'208";a="589492090"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 10 Apr 2022 09:36:11 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndaXr-0000xV-11;
        Sun, 10 Apr 2022 16:36:11 +0000
Date:   Mon, 11 Apr 2022 00:35:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     kbuild-all@lists.01.org, zx2c4@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [crng-random:jd/not-zero-entropy 8/12]
 arch/nios2/include/asm/timex.h:12:63: error: implicit declaration of
 function 'sched_clock'; did you mean 'sched_fork'?
Message-ID: <202204110002.cY2Rt9Sq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git jd/not-zero-entropy
head:   efec3e2057963ad20223fa50a657b3ca9314ed45
commit: 375f51ba327a3403d8ea14f4292a8ac14c57428e [8/12] nios2: use sched_clock() for random_get_entropy() instead of zero
config: nios2-randconfig-r033-20220410 (https://download.01.org/0day-ci/archive/20220411/202204110002.cY2Rt9Sq-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git/commit/?id=375f51ba327a3403d8ea14f4292a8ac14c57428e
        git remote add crng-random git://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git
        git fetch --no-tags crng-random jd/not-zero-entropy
        git checkout 375f51ba327a3403d8ea14f4292a8ac14c57428e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash drivers/char/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/timex.h:65,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/ktime.h:24,
                    from include/linux/timer.h:6,
                    from include/linux/workqueue.h:9,
                    from include/linux/rhashtable-types.h:15,
                    from include/linux/ipc.h:7,
                    from include/uapi/linux/sem.h:5,
                    from include/linux/sem.h:5,
                    from include/linux/sched.h:15,
                    from include/linux/utsname.h:6,
                    from drivers/char/random.c:30:
   drivers/char/random.c: In function 'extract_entropy':
>> arch/nios2/include/asm/timex.h:12:63: error: implicit declaration of function 'sched_clock'; did you mean 'sched_fork'? [-Werror=implicit-function-declaration]
      12 | #define random_get_entropy() ((unsigned long)(get_cycles() ?: sched_clock()))
         |                                                               ^~~~~~~~~~~
   drivers/char/random.c:847:43: note: in expansion of macro 'random_get_entropy'
     847 |                         block.rdseed[i] = random_get_entropy();
         |                                           ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +12 arch/nios2/include/asm/timex.h

    11	
  > 12	#define random_get_entropy() ((unsigned long)(get_cycles() ?: sched_clock()))
    13	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
