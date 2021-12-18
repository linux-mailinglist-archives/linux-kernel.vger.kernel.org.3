Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A77D479E32
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 00:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbhLRXxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 18:53:08 -0500
Received: from mga17.intel.com ([192.55.52.151]:3488 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232124AbhLRXxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 18:53:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639871587; x=1671407587;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0uuPtTuVbPzgiQyF7t8zGYE2IrWuinjW1888yEEAKLI=;
  b=Z5Xm1lu+HX0YgzsDVNwCYe7K44KiNRRGEYYIdcCiRm5FQbXurQDvtg4T
   9atflyuYp9jIXN2RCURrbZUv+GvpwG4xSCF6c+obb9D6QjrHnVW4rmGZA
   YKbm8fuY5umSbM1S/agsPYr1NgUhSQG++S7Qoat6llU9KQNX/9rlZxq1F
   7ixqF3Q8wr2YIhQxRYR3yfAEa1mkSNJBU6bLtTytIk33M8lNglvvFOIPe
   aUVWxaZMizCi9FREKETFXNUQf4QG3SfmXGELfuXUKGrDRgpvYXvQOdBiN
   Lwf2E5jagO6zu8d5K84SS+9gRNrdFVJrsqWdqG7JtVjFG1ot6OxanzWis
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10202"; a="220639367"
X-IronPort-AV: E=Sophos;i="5.88,217,1635231600"; 
   d="scan'208";a="220639367"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2021 15:53:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,217,1635231600"; 
   d="scan'208";a="483617899"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 18 Dec 2021 15:53:05 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1myjVg-0006WK-RY; Sat, 18 Dec 2021 23:53:04 +0000
Date:   Sun, 19 Dec 2021 07:52:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Keerthy <j-keerthy@ti.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tero Kristo <t-kristo@ti.com>
Subject: drivers/crypto/sa2ul.c:432:1: warning: the frame size of 1088 bytes
 is larger than 1024 bytes
Message-ID: <202112190729.P81P29Nc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keerthy,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9eaa88c7036eda3f6c215f87ca693594cf90559b
commit: d2c8ac187fc922e73930a1b2f6a211e27f595d01 crypto: sa2ul - Add AEAD algorithm support
date:   1 year, 5 months ago
config: mips-randconfig-p002-20211218 (https://download.01.org/0day-ci/archive/20211219/202112190729.P81P29Nc-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d2c8ac187fc922e73930a1b2f6a211e27f595d01
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d2c8ac187fc922e73930a1b2f6a211e27f595d01
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash drivers/crypto/ drivers/opp/ drivers/pinctrl/ drivers/usb/chipidea/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/dmaengine.h:8,
                    from drivers/crypto/sa2ul.c:12:
   drivers/crypto/sa2ul.c: In function 'sa_sha_init':
   drivers/crypto/sa2ul.c:1486:47: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    1486 |                 crypto_ahash_digestsize(tfm), (u64)rctx);
         |                                               ^
   include/linux/dev_printk.h:123:61: note: in definition of macro 'dev_dbg'
     123 |                 dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
         |                                                             ^~~~~~~~~~~
   drivers/crypto/sa2ul.c: In function 'sa_prepare_iopads':
>> drivers/crypto/sa2ul.c:432:1: warning: the frame size of 1088 bytes is larger than 1024 bytes [-Wframe-larger-than=]
     432 | }
         | ^


cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

>> drivers/usb/chipidea/core.c:596:15: warning: Local variable ci_role shadows outer function [shadowFunction]
    enum ci_role ci_role = usb_role_to_ci_role(role);
                 ^
   drivers/usb/chipidea/ci.h:262:38: note: Shadowed declaration
   static inline struct ci_role_driver *ci_role(struct ci_hdrc *ci)
                                        ^
   drivers/usb/chipidea/core.c:596:15: note: Shadow variable
    enum ci_role ci_role = usb_role_to_ci_role(role);
                 ^
>> drivers/opp/core.c:1395:4: warning: Address of local auto-variable assigned to a function parameter. [autoVariables]
      *head = &opp->node;
      ^

vim +432 drivers/crypto/sa2ul.c

   407	
   408	static void sa_prepare_iopads(struct algo_data *data, const u8 *key,
   409				      u16 key_sz, __be32 *ipad, __be32 *opad)
   410	{
   411		SHASH_DESC_ON_STACK(shash, data->ctx->shash);
   412		int block_size = crypto_shash_blocksize(data->ctx->shash);
   413		int digest_size = crypto_shash_digestsize(data->ctx->shash);
   414		u8 k_ipad[SHA1_BLOCK_SIZE];
   415		u8 k_opad[SHA1_BLOCK_SIZE];
   416	
   417		shash->tfm = data->ctx->shash;
   418	
   419		prepare_kiopad(k_ipad, k_opad, key, key_sz);
   420	
   421		memzero_explicit(ipad, block_size);
   422		memzero_explicit(opad, block_size);
   423	
   424		crypto_shash_init(shash);
   425		crypto_shash_update(shash, k_ipad, block_size);
   426		sa_export_shash(shash, block_size, digest_size, ipad);
   427	
   428		crypto_shash_init(shash);
   429		crypto_shash_update(shash, k_opad, block_size);
   430	
   431		sa_export_shash(shash, block_size, digest_size, opad);
 > 432	}
   433	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
