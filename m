Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0463B56433F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 01:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiGBWuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 18:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGBWuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 18:50:20 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD34B7D4
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 15:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656802219; x=1688338219;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LvmqgPY4S/j3qKRYtf62NYcvpVr2W/vbljZntZZGsv8=;
  b=LHGgx7hpGvw54lea71V8O5sRo9QiwSaxGbgaHVlpQtJsQDZJzjMt+vzM
   1tcXnvT4ZjbyIsIKioqnf2YgssnrnCJgZIIeD6HPIaY7pc2p/E/zUxk8b
   EdaMS2kcAYd3eEHX4ZY7aqXBez585Sb61b7j8lpvwlnW9HdpvK6a2Cnw8
   rbyDbapkfwClYLM+Vj9Mhx0iyjpDUP5uXaK4A8Hu4DbfuogRMMp94zmp4
   YvpVhuFYRcEl8NFInlEzjuL5xpnFQjqR/ax2qTrt9/7z4IjZwrWRm11lG
   uimOH7OQ5+RjRFOYbl2W9QvcVG5Gb0UARMKydF4M8XbMzwFYi+NQ0Umy1
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10396"; a="282907666"
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="282907666"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 15:50:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="734428388"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 02 Jul 2022 15:50:17 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o7lwO-000FmN-PQ;
        Sat, 02 Jul 2022 22:50:16 +0000
Date:   Sun, 3 Jul 2022 06:49:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vladis Dronov <vdronov@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Harald Freudenberger <freude@linux.ibm.com>
Subject: include/crypto/chacha.h:100: undefined reference to
 `chacha_crypt_arch'
Message-ID: <202207030630.6SZVkrWf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   69cb6c6556ad89620547318439d6be8bb1629a5a
commit: 349d03ffd5f62c298fd667ffa397c3fdc5c6194b crypto: s390 - add crypto library interface for ChaCha20
date:   7 weeks ago
config: s390-buildonly-randconfig-r005-20220703 (https://download.01.org/0day-ci/archive/20220703/202207030630.6SZVkrWf-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=349d03ffd5f62c298fd667ffa397c3fdc5c6194b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 349d03ffd5f62c298fd667ffa397c3fdc5c6194b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: lib/crypto/chacha20poly1305.o: in function `chacha_crypt':
>> include/crypto/chacha.h:100: undefined reference to `chacha_crypt_arch'
>> s390-linux-ld: include/crypto/chacha.h:100: undefined reference to `chacha_crypt_arch'
   s390-linux-ld: lib/crypto/chacha20poly1305.o: in function `chacha_init':
>> include/crypto/chacha.h:86: undefined reference to `chacha_init_arch'
>> s390-linux-ld: include/crypto/chacha.h:86: undefined reference to `chacha_init_arch'
   s390-linux-ld: lib/crypto/chacha20poly1305.o: in function `hchacha_block':
>> include/crypto/chacha.h:45: undefined reference to `hchacha_block_arch'
   s390-linux-ld: lib/crypto/chacha20poly1305.o: in function `chacha_init':
>> include/crypto/chacha.h:86: undefined reference to `chacha_init_arch'
   s390-linux-ld: lib/crypto/chacha20poly1305.o: in function `chacha_crypt':
>> include/crypto/chacha.h:100: undefined reference to `chacha_crypt_arch'
>> s390-linux-ld: include/crypto/chacha.h:100: undefined reference to `chacha_crypt_arch'
   s390-linux-ld: lib/crypto/chacha20poly1305.o: in function `chacha_init':
>> include/crypto/chacha.h:86: undefined reference to `chacha_init_arch'
>> s390-linux-ld: include/crypto/chacha.h:86: undefined reference to `chacha_init_arch'
   s390-linux-ld: lib/crypto/chacha20poly1305.o: in function `chacha_crypt':
>> include/crypto/chacha.h:100: undefined reference to `chacha_crypt_arch'
>> s390-linux-ld: include/crypto/chacha.h:100: undefined reference to `chacha_crypt_arch'
>> s390-linux-ld: include/crypto/chacha.h:100: undefined reference to `chacha_crypt_arch'
   s390-linux-ld: lib/crypto/chacha20poly1305-selftest.o: in function `chacha_init':
>> include/crypto/chacha.h:86: undefined reference to `chacha_init_arch'
   s390-linux-ld: lib/crypto/chacha20poly1305-selftest.o: in function `chacha_crypt':
>> include/crypto/chacha.h:100: undefined reference to `chacha_crypt_arch'
>> s390-linux-ld: include/crypto/chacha.h:100: undefined reference to `chacha_crypt_arch'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for CRYPTO_LIB_CHACHA20POLY1305
   Depends on (CRYPTO_ARCH_HAVE_LIB_CHACHA || !CRYPTO_ARCH_HAVE_LIB_CHACHA && (CRYPTO_ARCH_HAVE_LIB_POLY1305 || !CRYPTO_ARCH_HAVE_LIB_POLY1305 && CRYPTO
   Selected by
   - WIREGUARD && NETDEVICES && NET_CORE && NET && INET && (IPV6 || !IPV6


vim +100 include/crypto/chacha.h

5fb8ef25803ef3 Ard Biesheuvel    2019-11-08   41  
5fb8ef25803ef3 Ard Biesheuvel    2019-11-08   42  static inline void hchacha_block(const u32 *state, u32 *out, int nrounds)
5fb8ef25803ef3 Ard Biesheuvel    2019-11-08   43  {
5fb8ef25803ef3 Ard Biesheuvel    2019-11-08   44  	if (IS_ENABLED(CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA))
5fb8ef25803ef3 Ard Biesheuvel    2019-11-08  @45  		hchacha_block_arch(state, out, nrounds);
5fb8ef25803ef3 Ard Biesheuvel    2019-11-08   46  	else
5fb8ef25803ef3 Ard Biesheuvel    2019-11-08   47  		hchacha_block_generic(state, out, nrounds);
5fb8ef25803ef3 Ard Biesheuvel    2019-11-08   48  }
1ca1b917940c24 Eric Biggers      2018-11-16   49  
96562f286884e2 Dominik Brodowski 2021-12-31   50  enum chacha_constants { /* expand 32-byte k */
96562f286884e2 Dominik Brodowski 2021-12-31   51  	CHACHA_CONSTANT_EXPA = 0x61707865U,
96562f286884e2 Dominik Brodowski 2021-12-31   52  	CHACHA_CONSTANT_ND_3 = 0x3320646eU,
96562f286884e2 Dominik Brodowski 2021-12-31   53  	CHACHA_CONSTANT_2_BY = 0x79622d32U,
96562f286884e2 Dominik Brodowski 2021-12-31   54  	CHACHA_CONSTANT_TE_K = 0x6b206574U
96562f286884e2 Dominik Brodowski 2021-12-31   55  };
96562f286884e2 Dominik Brodowski 2021-12-31   56  
a181e0fdb21642 Eric Biggers      2021-03-21   57  static inline void chacha_init_consts(u32 *state)
5fb8ef25803ef3 Ard Biesheuvel    2019-11-08   58  {
96562f286884e2 Dominik Brodowski 2021-12-31   59  	state[0]  = CHACHA_CONSTANT_EXPA;
96562f286884e2 Dominik Brodowski 2021-12-31   60  	state[1]  = CHACHA_CONSTANT_ND_3;
96562f286884e2 Dominik Brodowski 2021-12-31   61  	state[2]  = CHACHA_CONSTANT_2_BY;
96562f286884e2 Dominik Brodowski 2021-12-31   62  	state[3]  = CHACHA_CONSTANT_TE_K;
a181e0fdb21642 Eric Biggers      2021-03-21   63  }
a181e0fdb21642 Eric Biggers      2021-03-21   64  
a181e0fdb21642 Eric Biggers      2021-03-21   65  void chacha_init_arch(u32 *state, const u32 *key, const u8 *iv);
a181e0fdb21642 Eric Biggers      2021-03-21   66  static inline void chacha_init_generic(u32 *state, const u32 *key, const u8 *iv)
a181e0fdb21642 Eric Biggers      2021-03-21   67  {
a181e0fdb21642 Eric Biggers      2021-03-21   68  	chacha_init_consts(state);
5fb8ef25803ef3 Ard Biesheuvel    2019-11-08   69  	state[4]  = key[0];
5fb8ef25803ef3 Ard Biesheuvel    2019-11-08   70  	state[5]  = key[1];
5fb8ef25803ef3 Ard Biesheuvel    2019-11-08   71  	state[6]  = key[2];
5fb8ef25803ef3 Ard Biesheuvel    2019-11-08   72  	state[7]  = key[3];
5fb8ef25803ef3 Ard Biesheuvel    2019-11-08   73  	state[8]  = key[4];
5fb8ef25803ef3 Ard Biesheuvel    2019-11-08   74  	state[9]  = key[5];
5fb8ef25803ef3 Ard Biesheuvel    2019-11-08   75  	state[10] = key[6];
5fb8ef25803ef3 Ard Biesheuvel    2019-11-08   76  	state[11] = key[7];
5fb8ef25803ef3 Ard Biesheuvel    2019-11-08   77  	state[12] = get_unaligned_le32(iv +  0);
5fb8ef25803ef3 Ard Biesheuvel    2019-11-08   78  	state[13] = get_unaligned_le32(iv +  4);
5fb8ef25803ef3 Ard Biesheuvel    2019-11-08   79  	state[14] = get_unaligned_le32(iv +  8);
5fb8ef25803ef3 Ard Biesheuvel    2019-11-08   80  	state[15] = get_unaligned_le32(iv + 12);
5fb8ef25803ef3 Ard Biesheuvel    2019-11-08   81  }
1ca1b917940c24 Eric Biggers      2018-11-16   82  
5fb8ef25803ef3 Ard Biesheuvel    2019-11-08   83  static inline void chacha_init(u32 *state, const u32 *key, const u8 *iv)
5fb8ef25803ef3 Ard Biesheuvel    2019-11-08   84  {
5fb8ef25803ef3 Ard Biesheuvel    2019-11-08   85  	if (IS_ENABLED(CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA))
5fb8ef25803ef3 Ard Biesheuvel    2019-11-08  @86  		chacha_init_arch(state, key, iv);
5fb8ef25803ef3 Ard Biesheuvel    2019-11-08   87  	else
5fb8ef25803ef3 Ard Biesheuvel    2019-11-08   88  		chacha_init_generic(state, key, iv);
5fb8ef25803ef3 Ard Biesheuvel    2019-11-08   89  }
5fb8ef25803ef3 Ard Biesheuvel    2019-11-08   90  
5fb8ef25803ef3 Ard Biesheuvel    2019-11-08   91  void chacha_crypt_arch(u32 *state, u8 *dst, const u8 *src,
5fb8ef25803ef3 Ard Biesheuvel    2019-11-08   92  		       unsigned int bytes, int nrounds);
5fb8ef25803ef3 Ard Biesheuvel    2019-11-08   93  void chacha_crypt_generic(u32 *state, u8 *dst, const u8 *src,
5fb8ef25803ef3 Ard Biesheuvel    2019-11-08   94  			  unsigned int bytes, int nrounds);
5fb8ef25803ef3 Ard Biesheuvel    2019-11-08   95  
5fb8ef25803ef3 Ard Biesheuvel    2019-11-08   96  static inline void chacha_crypt(u32 *state, u8 *dst, const u8 *src,
5fb8ef25803ef3 Ard Biesheuvel    2019-11-08   97  				unsigned int bytes, int nrounds)
5fb8ef25803ef3 Ard Biesheuvel    2019-11-08   98  {
5fb8ef25803ef3 Ard Biesheuvel    2019-11-08   99  	if (IS_ENABLED(CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA))
5fb8ef25803ef3 Ard Biesheuvel    2019-11-08 @100  		chacha_crypt_arch(state, dst, src, bytes, nrounds);
5fb8ef25803ef3 Ard Biesheuvel    2019-11-08  101  	else
5fb8ef25803ef3 Ard Biesheuvel    2019-11-08  102  		chacha_crypt_generic(state, dst, src, bytes, nrounds);
5fb8ef25803ef3 Ard Biesheuvel    2019-11-08  103  }
5fb8ef25803ef3 Ard Biesheuvel    2019-11-08  104  

:::::: The code at line 100 was first introduced by commit
:::::: 5fb8ef25803ef33e2eb60b626435828b937bed75 crypto: chacha - move existing library code into lib/crypto

:::::: TO: Ard Biesheuvel <ardb@kernel.org>
:::::: CC: Herbert Xu <herbert@gondor.apana.org.au>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
