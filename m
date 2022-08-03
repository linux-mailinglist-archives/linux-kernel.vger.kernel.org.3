Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA885886B3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 07:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbiHCFN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 01:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiHCFNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 01:13:53 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA2F1CB3B
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 22:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659503632; x=1691039632;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=O5EojvPN6N/DT/cah6pxOiMEeRKVEqcOgsYwVZ+IxAQ=;
  b=Zz/3g7S/ARuf7xOH3tVzB04o5hDQ2nCo52G/lSHaBSzVNMtYADp5QBaW
   Dx0G4VHH6ij/G3hr4aX/CZ58g8jk/Io+wPnV/VOr5knWVp9Oj2BwE9GxV
   WMPsyzOXDk7H5vqFKoSUshBTkeV9JT1Xaw+DaOoDTqUij93DN+bUhDFFZ
   w48DdxIrcCEMsvsBi4wo2hrf70iLUzLuIw3S6BhIhYWBTBj/npxcggV5k
   drMrLJv++SVPUyYO0BQT1ox3O+4w4AZgVmppSKzjH8J0b0b8I0WcamT2p
   QYS6C2GKBdwccYr5IMT2MZX0GH3KOyK1DiB9Mv248GSjowRHQ2KoMlbLM
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="351297535"
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="351297535"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 22:13:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="635547240"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 02 Aug 2022 22:13:50 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJ6hZ-000Grb-1X;
        Wed, 03 Aug 2022 05:13:49 +0000
Date:   Wed, 3 Aug 2022 13:13:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:crng/random/jd/vdso 9/9] lib/crypto/chacha.c:28
 chacha_permute() warn: inconsistent indenting
Message-ID: <202208031320.4h7OAbtq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block crng/random/jd/vdso
head:   29d7baa1e13b4304df93126e0c8baf56584b720a
commit: 29d7baa1e13b4304df93126e0c8baf56584b720a [9/9] random: implement getrandom() in vDSO
config: x86_64-randconfig-m001-20220801 (https://download.01.org/0day-ci/archive/20220803/202208031320.4h7OAbtq-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
lib/crypto/chacha.c:28 chacha_permute() warn: inconsistent indenting

vim +28 lib/crypto/chacha.c

1ca1b917940c24c lib/chacha.c   Eric Biggers  2018-11-16  24  
1ca1b917940c24c lib/chacha.c   Eric Biggers  2018-11-16  25  	for (i = 0; i < nrounds; i += 2) {
7660b1fb367eb37 lib/chacha20.c Eric Biggers  2017-12-31  26  		x[0]  += x[4];    x[12] = rol32(x[12] ^ x[0],  16);
7660b1fb367eb37 lib/chacha20.c Eric Biggers  2017-12-31  27  		x[1]  += x[5];    x[13] = rol32(x[13] ^ x[1],  16);
7660b1fb367eb37 lib/chacha20.c Eric Biggers  2017-12-31 @28  		x[2]  += x[6];    x[14] = rol32(x[14] ^ x[2],  16);
7660b1fb367eb37 lib/chacha20.c Eric Biggers  2017-12-31  29  		x[3]  += x[7];    x[15] = rol32(x[15] ^ x[3],  16);
e192be9d9a30555 lib/chacha20.c Theodore Ts'o 2016-06-12  30  
7660b1fb367eb37 lib/chacha20.c Eric Biggers  2017-12-31  31  		x[8]  += x[12];   x[4]  = rol32(x[4]  ^ x[8],  12);
7660b1fb367eb37 lib/chacha20.c Eric Biggers  2017-12-31  32  		x[9]  += x[13];   x[5]  = rol32(x[5]  ^ x[9],  12);
7660b1fb367eb37 lib/chacha20.c Eric Biggers  2017-12-31  33  		x[10] += x[14];   x[6]  = rol32(x[6]  ^ x[10], 12);
7660b1fb367eb37 lib/chacha20.c Eric Biggers  2017-12-31  34  		x[11] += x[15];   x[7]  = rol32(x[7]  ^ x[11], 12);
e192be9d9a30555 lib/chacha20.c Theodore Ts'o 2016-06-12  35  
7660b1fb367eb37 lib/chacha20.c Eric Biggers  2017-12-31  36  		x[0]  += x[4];    x[12] = rol32(x[12] ^ x[0],   8);
7660b1fb367eb37 lib/chacha20.c Eric Biggers  2017-12-31  37  		x[1]  += x[5];    x[13] = rol32(x[13] ^ x[1],   8);
7660b1fb367eb37 lib/chacha20.c Eric Biggers  2017-12-31  38  		x[2]  += x[6];    x[14] = rol32(x[14] ^ x[2],   8);
7660b1fb367eb37 lib/chacha20.c Eric Biggers  2017-12-31  39  		x[3]  += x[7];    x[15] = rol32(x[15] ^ x[3],   8);
e192be9d9a30555 lib/chacha20.c Theodore Ts'o 2016-06-12  40  
7660b1fb367eb37 lib/chacha20.c Eric Biggers  2017-12-31  41  		x[8]  += x[12];   x[4]  = rol32(x[4]  ^ x[8],   7);
7660b1fb367eb37 lib/chacha20.c Eric Biggers  2017-12-31  42  		x[9]  += x[13];   x[5]  = rol32(x[5]  ^ x[9],   7);
7660b1fb367eb37 lib/chacha20.c Eric Biggers  2017-12-31  43  		x[10] += x[14];   x[6]  = rol32(x[6]  ^ x[10],  7);
7660b1fb367eb37 lib/chacha20.c Eric Biggers  2017-12-31  44  		x[11] += x[15];   x[7]  = rol32(x[7]  ^ x[11],  7);
e192be9d9a30555 lib/chacha20.c Theodore Ts'o 2016-06-12  45  
7660b1fb367eb37 lib/chacha20.c Eric Biggers  2017-12-31  46  		x[0]  += x[5];    x[15] = rol32(x[15] ^ x[0],  16);
7660b1fb367eb37 lib/chacha20.c Eric Biggers  2017-12-31  47  		x[1]  += x[6];    x[12] = rol32(x[12] ^ x[1],  16);
7660b1fb367eb37 lib/chacha20.c Eric Biggers  2017-12-31  48  		x[2]  += x[7];    x[13] = rol32(x[13] ^ x[2],  16);
7660b1fb367eb37 lib/chacha20.c Eric Biggers  2017-12-31  49  		x[3]  += x[4];    x[14] = rol32(x[14] ^ x[3],  16);
e192be9d9a30555 lib/chacha20.c Theodore Ts'o 2016-06-12  50  
7660b1fb367eb37 lib/chacha20.c Eric Biggers  2017-12-31  51  		x[10] += x[15];   x[5]  = rol32(x[5]  ^ x[10], 12);
7660b1fb367eb37 lib/chacha20.c Eric Biggers  2017-12-31  52  		x[11] += x[12];   x[6]  = rol32(x[6]  ^ x[11], 12);
7660b1fb367eb37 lib/chacha20.c Eric Biggers  2017-12-31  53  		x[8]  += x[13];   x[7]  = rol32(x[7]  ^ x[8],  12);
7660b1fb367eb37 lib/chacha20.c Eric Biggers  2017-12-31  54  		x[9]  += x[14];   x[4]  = rol32(x[4]  ^ x[9],  12);
e192be9d9a30555 lib/chacha20.c Theodore Ts'o 2016-06-12  55  
7660b1fb367eb37 lib/chacha20.c Eric Biggers  2017-12-31  56  		x[0]  += x[5];    x[15] = rol32(x[15] ^ x[0],   8);
7660b1fb367eb37 lib/chacha20.c Eric Biggers  2017-12-31  57  		x[1]  += x[6];    x[12] = rol32(x[12] ^ x[1],   8);
7660b1fb367eb37 lib/chacha20.c Eric Biggers  2017-12-31  58  		x[2]  += x[7];    x[13] = rol32(x[13] ^ x[2],   8);
7660b1fb367eb37 lib/chacha20.c Eric Biggers  2017-12-31  59  		x[3]  += x[4];    x[14] = rol32(x[14] ^ x[3],   8);
e192be9d9a30555 lib/chacha20.c Theodore Ts'o 2016-06-12  60  
7660b1fb367eb37 lib/chacha20.c Eric Biggers  2017-12-31  61  		x[10] += x[15];   x[5]  = rol32(x[5]  ^ x[10],  7);
7660b1fb367eb37 lib/chacha20.c Eric Biggers  2017-12-31  62  		x[11] += x[12];   x[6]  = rol32(x[6]  ^ x[11],  7);
7660b1fb367eb37 lib/chacha20.c Eric Biggers  2017-12-31  63  		x[8]  += x[13];   x[7]  = rol32(x[7]  ^ x[8],   7);
7660b1fb367eb37 lib/chacha20.c Eric Biggers  2017-12-31  64  		x[9]  += x[14];   x[4]  = rol32(x[4]  ^ x[9],   7);
e192be9d9a30555 lib/chacha20.c Theodore Ts'o 2016-06-12  65  	}
dd333449d0fb667 lib/chacha20.c Eric Biggers  2018-11-16  66  }
dd333449d0fb667 lib/chacha20.c Eric Biggers  2018-11-16  67  

:::::: The code at line 28 was first introduced by commit
:::::: 7660b1fb367eb3723b48d3980451fc4f25a05021 crypto: chacha20 - use rol32() macro from bitops.h

:::::: TO: Eric Biggers <ebiggers@google.com>
:::::: CC: Herbert Xu <herbert@gondor.apana.org.au>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
