Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770F348F880
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 18:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiAOReb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 12:34:31 -0500
Received: from mga06.intel.com ([134.134.136.31]:13633 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230189AbiAORea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 12:34:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642268070; x=1673804070;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MEEHnOBYspsqd3iaGNTwi7jGqelHVRK4zyFKxECcOo4=;
  b=N7MLCh028Snh/c3mKhp9N7KRvWmKwe3BNbnd7hrV77ylrKVw0/t64dbQ
   BfL/cZmu9gpz41nFKmRpmi7YrG3D9j+cIX+KjHmiO+nGBn3q9XHUAmv0L
   RD0im52eEXfRW5IyQjHRd0A4syMSpVlBmroY+jofXXNTzTYxBRH+sOgUY
   betyJcg/UUFlhDvfaVhI1gP/80r2sFtJ55VnKL5dmqKTjgml7QvzWNwyM
   waNN7Mho8DkLoy4KJlNc2koGhvCuisSepDHr9tJ025YFnHV02Vms34HER
   ooCbH4t4OSCMa4c7HNXegsvLe8ARu7BH99fUjasM3BcGJBcogJarY9CYc
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10228"; a="305160536"
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="305160536"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2022 09:34:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="692601970"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 15 Jan 2022 09:34:28 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8mwe-000A9i-73; Sat, 15 Jan 2022 17:34:28 +0000
Date:   Sun, 16 Jan 2022 01:34:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Justin M. Forbes" <jforbes@fedoraproject.org>
Cc:     kbuild-all@lists.01.org, GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        "Jason A. Donenfeld" <zx2c4@kernel.org>
Subject: [ammarfaizi2-block:crng/random/master 1/2] aarch64-linux-ld:
 Unexpected GOT/PLT entries detected!
Message-ID: <202201160152.1zZeXMni-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block crng/random/master
head:   55a3130a6888d74fb1b6d26793dbe2c994ff4b7f
commit: 7c82c3237147bd1447bb760009b17c9bee4c91e9 [1/2] lib/crypto: add prompts back to crypto libraries
config: arm64-randconfig-r016-20220115 (https://download.01.org/0day-ci/archive/20220116/202201160152.1zZeXMni-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/7c82c3237147bd1447bb760009b17c9bee4c91e9
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block crng/random/master
        git checkout 7c82c3237147bd1447bb760009b17c9bee4c91e9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> aarch64-linux-ld: Unexpected GOT/PLT entries detected!
>> aarch64-linux-ld: Unexpected run-time procedure linkages detected!
   aarch64-linux-ld: lib/crypto/libchacha.o: in function `crypto_xor_cpy':
>> libchacha.c:(.text+0x8): undefined reference to `__crypto_xor'
   aarch64-linux-ld: lib/crypto/chacha20poly1305.o: in function `crypto_xor':
>> chacha20poly1305.c:(.text+0x580): undefined reference to `__crypto_xor'
   aarch64-linux-ld: lib/crypto/chacha20poly1305.o: in function `crypto_memneq.constprop.0':
>> chacha20poly1305.c:(.text+0x5b0): undefined reference to `__crypto_memneq'
   aarch64-linux-ld: lib/crypto/chacha20poly1305.o: in function `chacha20poly1305_crypt_sg_inplace':
>> chacha20poly1305.c:(.text+0x7e4): undefined reference to `scatterwalk_map_and_copy'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for CRYPTO_ALGAPI
   Depends on CRYPTO
   Selected by
   - CRYPTO_LIB_CHACHA_GENERIC
   Selected by
   - CRYPTO_AEAD && CRYPTO
   - CRYPTO_SKCIPHER && CRYPTO
   - CRYPTO_HASH && CRYPTO
   - CRYPTO_RNG && CRYPTO
   - CRYPTO_AKCIPHER && CRYPTO
   - CRYPTO_KPP && CRYPTO
   - CRYPTO_AES && CRYPTO
   - CRYPTO_CAMELLIA && CRYPTO
   - CRYPTO_DES && CRYPTO
   - CRYPTO_FCRYPT && CRYPTO
   - CRYPTO_SERPENT && CRYPTO
   - CRYPTO_SM4 && CRYPTO
   - CRYPTO_DEFLATE && CRYPTO
   - CRYPTO_LZO && CRYPTO
   - CRYPTO_842 && CRYPTO
   - CRYPTO_LZ4 && CRYPTO
   - CRYPTO_LZ4HC && CRYPTO
   - CRYPTO_DEV_HISI_SEC && CRYPTO && CRYPTO_HW && (ARM64 || COMPILE_TEST && HAS_IOMEM

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
