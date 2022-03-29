Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0044EAEFD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 16:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237714AbiC2OF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 10:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235896AbiC2OFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 10:05:24 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84699C2E
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 07:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648562621; x=1680098621;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=N7ljZpLuhVxvG1lByeWMuXSfovsfSjMocKlsX1aE0+o=;
  b=Ld2nj0SjsvUbgrVQkhSZYurdRUUf+ISVVP3lN1GW0CaxOT9PW4C5WENO
   qd8YDRyIDYq+uktPpMrgUG6VAvN7F631/1puYIX3RMj6vFck0fVC03F95
   gMEHsf36jS++u7sBUPlS1eQngNfO7wVtmm1T01/MzxjVoav1qolZK/bTs
   7mvn0UMa9+fPbvX5dnNNcXEegiYpszzao/gPAmajtT8RNEbodEeR3qjj0
   jKD2YBBlCEcLDOANsWMaWl5/aaCHD0OleTX7rnr/wmPzA7XIZnvuQPfSP
   jTAvnvJXh77piTMaEPjMkDp5HvJof9gu7tFvCUB4OECWhMylHGgCtuOGn
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="259443498"
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="259443498"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 07:03:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="585586371"
Received: from lkp-server01.sh.intel.com (HELO 3965e2759b93) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 29 Mar 2022 07:03:12 -0700
Received: from kbuild by 3965e2759b93 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nZCRD-0000I4-R1; Tue, 29 Mar 2022 14:03:11 +0000
Date:   Tue, 29 Mar 2022 22:02:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@elte.hu>, Adrian Bunk <bunk@stusta.de>,
        Randy Dunlap <rdunlap@xenotime.net>,
        Michel Lespinasse <walken@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [hnaz-mm:master 478/481] kernel/synchro-test.c:393:49: warning:
 variable 'zeros' set but not used
Message-ID: <202203292115.plWUiMYU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/hnaz/linux-mm master
head:   673977c1d5c4c5bc15abf8f01ebaddc66116a9cd
commit: 52880bd2b8272052d5ccf95f94704a959796c9f6 [478/481] mutex subsystem, synchro-test module
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20220329/202203292115.plWUiMYU-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/hnaz/linux-mm/commit/52880bd2b8272052d5ccf95f94704a959796c9f6
        git remote add hnaz-mm https://github.com/hnaz/linux-mm
        git fetch --no-tags hnaz-mm master
        git checkout 52880bd2b8272052d5ccf95f94704a959796c9f6
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/synchro-test.c:267:2: error: implicit declaration of function 'complete_and_exit' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           complete_and_exit(&sp_comp[N], 0);
           ^
   kernel/synchro-test.c:268:1: error: non-void function does not return a value [-Werror,-Wreturn-type]
   }
   ^
   kernel/synchro-test.c:288:2: error: implicit declaration of function 'complete_and_exit' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           complete_and_exit(&mx_comp[N], 0);
           ^
   kernel/synchro-test.c:289:1: error: non-void function does not return a value [-Werror,-Wreturn-type]
   }
   ^
   kernel/synchro-test.c:309:2: error: implicit declaration of function 'complete_and_exit' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           complete_and_exit(&sm_comp[N], 0);
           ^
   kernel/synchro-test.c:310:1: error: non-void function does not return a value [-Werror,-Wreturn-type]
   }
   ^
   kernel/synchro-test.c:332:2: error: implicit declaration of function 'complete_and_exit' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           complete_and_exit(&rd_comp[N], 0);
           ^
   kernel/synchro-test.c:333:1: error: non-void function does not return a value [-Werror,-Wreturn-type]
   }
   ^
   kernel/synchro-test.c:355:2: error: implicit declaration of function 'complete_and_exit' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           complete_and_exit(&wr_comp[N], 0);
           ^
   kernel/synchro-test.c:356:1: error: non-void function does not return a value [-Werror,-Wreturn-type]
   }
   ^
   kernel/synchro-test.c:383:2: error: implicit declaration of function 'complete_and_exit' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           complete_and_exit(&dg_comp[N], 0);
           ^
   kernel/synchro-test.c:384:1: error: non-void function does not return a value [-Werror,-Wreturn-type]
   }
   ^
>> kernel/synchro-test.c:393:49: warning: variable 'zeros' set but not used [-Wunused-but-set-variable]
           unsigned int tot = 0, max = 0, min = UINT_MAX, zeros = 0, cnt;
                                                          ^
   1 warning and 12 errors generated.


vim +/zeros +393 kernel/synchro-test.c

   390	
   391	static unsigned int total(const char *what, unsigned int counts[], int num)
   392	{
 > 393		unsigned int tot = 0, max = 0, min = UINT_MAX, zeros = 0, cnt;
   394		int loop;
   395	
   396		for (loop = 0; loop < num; loop++) {
   397			cnt = counts[loop];
   398	
   399			if (cnt == 0) {
   400				zeros++;
   401				min = 0;
   402				continue;
   403			}
   404	
   405			tot += cnt;
   406			if (tot > max)
   407				max = tot;
   408			if (tot < min)
   409				min = tot;
   410		}
   411	
   412		if (verbose && tot > 0) {
   413			printk("%s:", what);
   414	
   415			for (loop = 0; loop < num; loop++) {
   416				cnt = counts[loop];
   417	
   418				if (cnt == 0)
   419					printk(" zzz");
   420				else
   421					printk(" %d%%", cnt * 100 / tot);
   422			}
   423	
   424			printk("\n");
   425		}
   426	
   427		return tot;
   428	}
   429	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
