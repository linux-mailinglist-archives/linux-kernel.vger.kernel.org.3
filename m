Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076015164C3
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 16:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346165AbiEAOmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 10:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbiEAOmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 10:42:08 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E91149F2A
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 07:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651415921; x=1682951921;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cquL9LpGj1ymKGxbolyrfJ/ZYjYl+h86vKDu4S2wv1k=;
  b=V0cbHspPSAlJiU/r3JRcy/R0OONp2KMEQ4vjN8fVv/j88CkZgIWXgaPc
   P0VZ+vFAvqzl1Km7f0LD/nuq8i8tHd0ztMSGH0fEarmusdV8UFAaI9HFY
   2C7V9GMmf3c4a+IOm/5KdnTOmiAt3+r3O9oOlyxjQLy1QL9sahjlVxcZ1
   H0XNx/8nt/raIZC8rWuGu4JvkrV+M3bq3Io9eerihhHiuzfjUfJc9DBT5
   51QE3VZTuk6p0wyhuLDY+EKm3uni5Yd+LJsLoLx8RXuakcfR8/HA6glIg
   vMXaZQIPp6XTc9OQ8fYiYzSdjQ0BEU3bbGw/GHpt9e9hrEhv26J1t63xR
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10334"; a="248987476"
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="248987476"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2022 07:38:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="545271287"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 01 May 2022 07:38:39 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlAic-0008pH-Ta;
        Sun, 01 May 2022 14:38:38 +0000
Date:   Sun, 1 May 2022 22:38:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:crng/random/jd/premature-next 22/22]
 drivers/char/random.c:966:17: error: too many arguments to function
 'crng_reseed'
Message-ID: <202205012224.yDMg4Wy1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block crng/random/jd/premature-next
head:   0f5d33eaa0e077a5d2dfee756ebf254686f268bd
commit: 0f5d33eaa0e077a5d2dfee756ebf254686f268bd [22/22] random: do not pretend to handle premature-next model
config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20220501/202205012224.yDMg4Wy1-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/0f5d33eaa0e077a5d2dfee756ebf254686f268bd
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block crng/random/jd/premature-next
        git checkout 0f5d33eaa0e077a5d2dfee756ebf254686f268bd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/char/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/char/random.c: In function 'random_pm_notification':
>> drivers/char/random.c:966:17: error: too many arguments to function 'crng_reseed'
     966 |                 crng_reseed(true);
         |                 ^~~~~~~~~~~
   drivers/char/random.c:265:13: note: declared here
     265 | static void crng_reseed(void)
         |             ^~~~~~~~~~~


vim +/crng_reseed +966 drivers/char/random.c

3655adc7089da4 Jason A. Donenfeld 2022-02-11  942  
da1a2e23f28eac Jason A. Donenfeld 2022-05-01  943  static int random_pm_notification(struct notifier_block *nb, unsigned long action, void *data)
da1a2e23f28eac Jason A. Donenfeld 2022-05-01  944  {
da1a2e23f28eac Jason A. Donenfeld 2022-05-01  945  	unsigned long flags, entropy = random_get_entropy();
da1a2e23f28eac Jason A. Donenfeld 2022-05-01  946  
da1a2e23f28eac Jason A. Donenfeld 2022-05-01  947  	/*
da1a2e23f28eac Jason A. Donenfeld 2022-05-01  948  	 * Encode a representation of how long the system has been suspended,
da1a2e23f28eac Jason A. Donenfeld 2022-05-01  949  	 * in a way that is distinct from prior system suspends.
da1a2e23f28eac Jason A. Donenfeld 2022-05-01  950  	 */
da1a2e23f28eac Jason A. Donenfeld 2022-05-01  951  	ktime_t stamps[] = {
da1a2e23f28eac Jason A. Donenfeld 2022-05-01  952  		ktime_get(),
da1a2e23f28eac Jason A. Donenfeld 2022-05-01  953  		ktime_get_boottime(),
da1a2e23f28eac Jason A. Donenfeld 2022-05-01  954  		ktime_get_real()
da1a2e23f28eac Jason A. Donenfeld 2022-05-01  955  	};
da1a2e23f28eac Jason A. Donenfeld 2022-05-01  956  
da1a2e23f28eac Jason A. Donenfeld 2022-05-01  957  	spin_lock_irqsave(&input_pool.lock, flags);
da1a2e23f28eac Jason A. Donenfeld 2022-05-01  958  	_mix_pool_bytes(&action, sizeof(action));
da1a2e23f28eac Jason A. Donenfeld 2022-05-01  959  	_mix_pool_bytes(stamps, sizeof(stamps));
da1a2e23f28eac Jason A. Donenfeld 2022-05-01  960  	_mix_pool_bytes(&entropy, sizeof(entropy));
da1a2e23f28eac Jason A. Donenfeld 2022-05-01  961  	spin_unlock_irqrestore(&input_pool.lock, flags);
da1a2e23f28eac Jason A. Donenfeld 2022-05-01  962  
da1a2e23f28eac Jason A. Donenfeld 2022-05-01  963  	if (crng_ready() && (action == PM_RESTORE_PREPARE ||
da1a2e23f28eac Jason A. Donenfeld 2022-05-01  964  	    (action == PM_POST_SUSPEND &&
da1a2e23f28eac Jason A. Donenfeld 2022-05-01  965  	     !IS_ENABLED(CONFIG_PM_AUTOSLEEP) && !IS_ENABLED(CONFIG_ANDROID)))) {
da1a2e23f28eac Jason A. Donenfeld 2022-05-01 @966  		crng_reseed(true);
da1a2e23f28eac Jason A. Donenfeld 2022-05-01  967  		pr_notice("crng reseeded on system resumption\n");
da1a2e23f28eac Jason A. Donenfeld 2022-05-01  968  	}
da1a2e23f28eac Jason A. Donenfeld 2022-05-01  969  	return 0;
da1a2e23f28eac Jason A. Donenfeld 2022-05-01  970  }
da1a2e23f28eac Jason A. Donenfeld 2022-05-01  971  

:::::: The code at line 966 was first introduced by commit
:::::: da1a2e23f28eac7746add084c7807fffcf255f9d random: mix in timestamps and reseed on system restore

:::::: TO: Jason A. Donenfeld <Jason@zx2c4.com>
:::::: CC: Jason A. Donenfeld <Jason@zx2c4.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
