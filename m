Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9676C4FAF4D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 19:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239573AbiDJR31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 13:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbiDJR3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 13:29:25 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C2160D8E
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 10:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649611634; x=1681147634;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fnCbI3Yw/UZXqTdUeK5i0P7bVmCOkgh+X3ejU+zJCfw=;
  b=ZTTb8EBVwMXZzlYoxUVccEyBqUWUvQXw6MRxlnzmN8Y3YWCnlSmrYzKl
   gunrxbdMNtWOFynbVxNOlAEQdsbVGGKdssVuiwlF18IeoXP7Pc73rMBny
   BOlmg6TxhIVIus1+vXwSSOeZW7zlTnqHT5VlK31hLq8yecZzwEJuSgX6s
   2myRnhl/LsTdtyA9O5F/8hM7JzGgiPXtPPP9wZevcU+JQ/SauLB+r4oM7
   EQMIUfBlCXGrZ8SmOuQlh4xvEEaXpxRzFrMzwpMUQynlVnkINuJ9h9/Zq
   RFICpkQU7Ipxfkd9nHuNFmrtaHXk+Idpj44HRhiZKiQNtRpvZSRnJxuso
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="261729564"
X-IronPort-AV: E=Sophos;i="5.90,250,1643702400"; 
   d="scan'208";a="261729564"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2022 10:27:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,250,1643702400"; 
   d="scan'208";a="622564061"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 10 Apr 2022 10:27:12 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndbLE-0000zP-2p;
        Sun, 10 Apr 2022 17:27:12 +0000
Date:   Mon, 11 Apr 2022 01:26:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     kbuild-all@lists.01.org, zx2c4@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [crng-random:jd/not-zero-entropy 3/12] include/linux/timex.h:83:49:
 error: implicit declaration of function 'sched_clock'
Message-ID: <202204110149.L9WMl0vi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git jd/not-zero-entropy
head:   efec3e2057963ad20223fa50a657b3ca9314ed45
commit: d921ec2a978ab8566577c18abfe20960dd0c6477 [3/12] random: use sched_clock() for random_get_entropy() if no get_cycles()
config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20220411/202204110149.L9WMl0vi-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git/commit/?id=d921ec2a978ab8566577c18abfe20960dd0c6477
        git remote add crng-random git://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git
        git fetch --no-tags crng-random jd/not-zero-entropy
        git checkout d921ec2a978ab8566577c18abfe20960dd0c6477
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/jiffies.h:10,
                    from lib/random32.c:38:
   lib/random32.c: In function 'prandom_init_early':
>> include/linux/timex.h:83:49: error: implicit declaration of function 'sched_clock' [-Werror=implicit-function-declaration]
      83 | #define random_get_entropy()    ((unsigned long)sched_clock())
         |                                                 ^~~~~~~~~~~
   lib/random32.c:469:22: note: in expansion of macro 'random_get_entropy'
     469 |                 v1 = random_get_entropy();
         |                      ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/sched_clock +83 include/linux/timex.h

    66	
    67	#ifndef random_get_entropy
    68	/*
    69	 * The random_get_entropy() function is used by the /dev/random driver
    70	 * in order to extract entropy via the relative unpredictability of
    71	 * when an interrupt takes places versus a high speed, fine-grained
    72	 * timing source or cycle counter.  Since it will be occurred on every
    73	 * single interrupt, it must have a very low cost/overhead.
    74	 *
    75	 * By default we use get_cycles() for this purpose, but individual
    76	 * architectures may override this in their asm/timex.h header file.
    77	 * If a given arch does not have get_cycles(), then we fallback to
    78	 * using sched_clock().
    79	 */
    80	#ifdef get_cycles
    81	#define random_get_entropy()	((unsigned long)get_cycles())
    82	#else
  > 83	#define random_get_entropy()	((unsigned long)sched_clock())
    84	#endif
    85	#endif
    86	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
