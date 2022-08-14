Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88459591F2E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 11:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbiHNIuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 04:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiHNIuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 04:50:50 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A853D13D7A
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 01:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660467049; x=1692003049;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EATcR5VGFUaRuQIi9otJAW1IFr6PQVLIwWz+IQpd4uE=;
  b=kjYu8eZAiopBHpDbA1rSGq1HjCMbt2oQYwJxChu5rzAghEuvfXBu7v2L
   62iUeme4ifCd51S/5ZTmg7gyVDBjBa7pbGdxAOrQf/Cr5vjcgTaBRi1Tw
   ixPv+NLad7oSw0rJt+HgJ0qpuVKhhDl8e/QpPllIGRTEVF88TF0OKi21/
   BdRcNdjzqoxHQ8bl6zpPY5c4ibzT7QHB8+tlFEKJmv4CVLl54tQ7ru3T1
   27fKVr49q8vqoitBoH4mlfNu1i6jHM9XdIlbxcpXUIdntFRRO7RUk79Ce
   4QKRS9CPiy6cJTq5A31xT6NJ7zCdh4bfFlHyWEPaJ3gVZC7ti9m4ZP2tQ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="292605257"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="292605257"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 01:50:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="748620757"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 14 Aug 2022 01:50:47 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oN9KZ-0002fn-0k;
        Sun, 14 Aug 2022 08:50:47 +0000
Date:   Sun, 14 Aug 2022 16:50:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: lib/crypto/blake2s-selftest.c:632:1: warning: the frame size of 1120
 bytes is larger than 1024 bytes
Message-ID: <202208141644.7UxLWkan-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   aea23e7c464bfdec04b52cf61edb62030e9e0d0a
commit: 2d16803c562ecc644803d42ba98a8e0aef9c014e crypto: blake2s - remove shash module
date:   9 weeks ago
config: i386-buildonly-randconfig-r002-20220808 (https://download.01.org/0day-ci/archive/20220814/202208141644.7UxLWkan-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2d16803c562ecc644803d42ba98a8e0aef9c014e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 2d16803c562ecc644803d42ba98a8e0aef9c014e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash lib/crypto/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   lib/crypto/blake2s-selftest.c: In function 'blake2s_selftest':
>> lib/crypto/blake2s-selftest.c:632:1: warning: the frame size of 1120 bytes is larger than 1024 bytes [-Wframe-larger-than=]
     632 | }
         | ^


vim +632 lib/crypto/blake2s-selftest.c

2d16803c562ecc Jason A. Donenfeld 2022-05-28  614  
2d16803c562ecc Jason A. Donenfeld 2022-05-28  615  		memcpy(&state1, &state, sizeof(state1));
2d16803c562ecc Jason A. Donenfeld 2022-05-28  616  		blake2s_compress(&state1, blocks, 1, BLAKE2S_BLOCK_SIZE);
2d16803c562ecc Jason A. Donenfeld 2022-05-28  617  		for (l = 1; l < TEST_ALIGNMENT; ++l) {
2d16803c562ecc Jason A. Donenfeld 2022-05-28  618  			memcpy(unaligned_block + l, blocks,
2d16803c562ecc Jason A. Donenfeld 2022-05-28  619  			       BLAKE2S_BLOCK_SIZE);
2d16803c562ecc Jason A. Donenfeld 2022-05-28  620  			memcpy(&state2, &state, sizeof(state2));
2d16803c562ecc Jason A. Donenfeld 2022-05-28  621  			blake2s_compress(&state2, unaligned_block + l, 1,
2d16803c562ecc Jason A. Donenfeld 2022-05-28  622  					 BLAKE2S_BLOCK_SIZE);
2d16803c562ecc Jason A. Donenfeld 2022-05-28  623  			if (memcmp(&state1, &state2, sizeof(state1))) {
2d16803c562ecc Jason A. Donenfeld 2022-05-28  624  				pr_err("blake2s random compress align %d self-test %d: FAIL\n",
2d16803c562ecc Jason A. Donenfeld 2022-05-28  625  				       l, i + 1);
2d16803c562ecc Jason A. Donenfeld 2022-05-28  626  				success = false;
2d16803c562ecc Jason A. Donenfeld 2022-05-28  627  			}
2d16803c562ecc Jason A. Donenfeld 2022-05-28  628  		}
2d16803c562ecc Jason A. Donenfeld 2022-05-28  629  	}
2d16803c562ecc Jason A. Donenfeld 2022-05-28  630  
66d7fb94e4ffe5 Jason A. Donenfeld 2019-11-08  631  	return success;
66d7fb94e4ffe5 Jason A. Donenfeld 2019-11-08 @632  }

:::::: The code at line 632 was first introduced by commit
:::::: 66d7fb94e4ffe5acc589e0b2b4710aecc1f07a28 crypto: blake2s - generic C library implementation and selftest

:::::: TO: Jason A. Donenfeld <Jason@zx2c4.com>
:::::: CC: Herbert Xu <herbert@gondor.apana.org.au>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
