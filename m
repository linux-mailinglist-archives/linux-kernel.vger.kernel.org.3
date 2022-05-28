Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F2A536D15
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 15:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235801AbiE1NUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 09:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235473AbiE1NUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 09:20:41 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3BF1A075
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 06:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653744040; x=1685280040;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=B6GjmZla1IYWF1L39TEwqEHfBiLiRLbmuaimjYhTGPI=;
  b=b6kCPLbbKm14PFSdjWS7FVguq0XkzcCO8nOgtnsFLJqyBsWhucbfONkp
   Yhxr4EWlueLzWWSqaPBMfckBsxl0/oOE6xDwBYYbF2+Wj0eC6343I8Iw8
   QgU86Lw3//vmSlHw+cgA/9hPPhrTtfMCkJnqGXArRt4Pv79P7dsjH8Awl
   1ubRoFELvuZklZbTuUk9C4I01I32/2JSCy7tEwI9sSf1E094yDdB5ety4
   sPqp0FZ3wUH5WxxQd1VATLua+mrYQslLhEm3v6Eah0FSDK1BPSkDgOZdA
   4AV5DD/6EFddpdJXJqVBn0WFG617MV95twXnFiDz60zjhxSIHsfOBS3xX
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10360"; a="335325060"
X-IronPort-AV: E=Sophos;i="5.91,258,1647327600"; 
   d="scan'208";a="335325060"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2022 06:20:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,258,1647327600"; 
   d="scan'208";a="665857340"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 28 May 2022 06:20:38 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuwMv-0000E6-UO;
        Sat, 28 May 2022 13:20:37 +0000
Date:   Sat, 28 May 2022 21:20:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>
Subject: lib/crypto/blake2s-selftest.c:630:1: warning: the frame size of 1032
 bytes is larger than 1024 bytes
Message-ID: <202205282155.LdL0Vb6J-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel-lab-lkp/linux/commits/UPDATE-20220528-180939/Jason-A-Donenfeld/crypto-blake2s-remove-shash-module/20220526-172214
head:   54e31fb223170c2e7f3a6c3b1f3b438e32788f43
commit: 54e31fb223170c2e7f3a6c3b1f3b438e32788f43 crypto: blake2s - remove shash module
date:   3 hours ago
config: h8300-randconfig-r015-20220524 (https://download.01.org/0day-ci/archive/20220528/202205282155.LdL0Vb6J-lkp@intel.com/config)
compiler: h8300-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/54e31fb223170c2e7f3a6c3b1f3b438e32788f43
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review UPDATE-20220528-180939/Jason-A-Donenfeld/crypto-blake2s-remove-shash-module/20220526-172214
        git checkout 54e31fb223170c2e7f3a6c3b1f3b438e32788f43
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=h8300 SHELL=/bin/bash lib/crypto/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   lib/crypto/blake2s-selftest.c: In function 'blake2s_selftest':
>> lib/crypto/blake2s-selftest.c:630:1: warning: the frame size of 1032 bytes is larger than 1024 bytes [-Wframe-larger-than=]
     630 | }
         | ^

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for DRM_GEM_SHMEM_HELPER
   Depends on HAS_IOMEM && DRM && MMU
   Selected by
   - DRM_SSD130X && HAS_IOMEM && DRM


vim +630 lib/crypto/blake2s-selftest.c

54e31fb223170c Jason A. Donenfeld 2022-05-28  612  
54e31fb223170c Jason A. Donenfeld 2022-05-28  613  		memcpy(&state1, &state, sizeof(state1));
54e31fb223170c Jason A. Donenfeld 2022-05-28  614  		blake2s_compress(&state1, blocks, 1, BLAKE2S_BLOCK_SIZE);
54e31fb223170c Jason A. Donenfeld 2022-05-28  615  		for (l = 1; l < sizeof(long); ++l) {
54e31fb223170c Jason A. Donenfeld 2022-05-28  616  			memcpy(unaligned_block + l, blocks,
54e31fb223170c Jason A. Donenfeld 2022-05-28  617  			       BLAKE2S_BLOCK_SIZE);
54e31fb223170c Jason A. Donenfeld 2022-05-28  618  			memcpy(&state2, &state, sizeof(state2));
54e31fb223170c Jason A. Donenfeld 2022-05-28  619  			blake2s_compress(&state2, unaligned_block + l, 1,
54e31fb223170c Jason A. Donenfeld 2022-05-28  620  					 BLAKE2S_BLOCK_SIZE);
54e31fb223170c Jason A. Donenfeld 2022-05-28  621  			if (memcmp(&state1, &state2, sizeof(state1))) {
54e31fb223170c Jason A. Donenfeld 2022-05-28  622  				pr_err("blake2s random compress align %d self-test %d: FAIL\n",
54e31fb223170c Jason A. Donenfeld 2022-05-28  623  				       l, i + 1);
54e31fb223170c Jason A. Donenfeld 2022-05-28  624  				success = false;
54e31fb223170c Jason A. Donenfeld 2022-05-28  625  			}
54e31fb223170c Jason A. Donenfeld 2022-05-28  626  		}
54e31fb223170c Jason A. Donenfeld 2022-05-28  627  	}
54e31fb223170c Jason A. Donenfeld 2022-05-28  628  
66d7fb94e4ffe5 Jason A. Donenfeld 2019-11-08  629  	return success;
66d7fb94e4ffe5 Jason A. Donenfeld 2019-11-08 @630  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
