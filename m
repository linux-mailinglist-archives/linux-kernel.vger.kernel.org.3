Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74A0A48FD4D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 14:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235349AbiAPN5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 08:57:03 -0500
Received: from mga06.intel.com ([134.134.136.31]:34220 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229785AbiAPN5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 08:57:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642341422; x=1673877422;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kFaqcb+FjiNKs4/Y/N17OI7EJSO4oxpial3CgQSEPFU=;
  b=n6qbx9ce8nzxSp+3nMqORZn1CnMc509hD9ft6p20V9ZiX4t+dKfrb0iD
   m4RRNNdYejyFRwZ2sg+hACUL91wjfX//CE1zK94ChzWehoqBAchoGrGY+
   hFcNDF4G5Y2vDmDInnwx+BzuIkAECi5ywwBsnR8PD5W7ZsDK9fmZyXG75
   i2AePaU+vdo1pzM6L+KQpniWa5Qakh8VZyn1hw/AQUE9lOqOWjrO63cQy
   4o6ofKY31iA9mRK16hMaRT6YU/JLG6Jo4oQxxRQ/0V9krhEVHSGrW9vdB
   DgGlCzsY8nkic5BvgClkx/D93ekSSTavbpdH11UnXSatAPkqYXIAKKIh+
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10228"; a="305223830"
X-IronPort-AV: E=Sophos;i="5.88,293,1635231600"; 
   d="scan'208";a="305223830"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2022 05:57:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,293,1635231600"; 
   d="scan'208";a="624924168"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 16 Jan 2022 05:57:00 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n961j-000Aka-Ab; Sun, 16 Jan 2022 13:56:59 +0000
Date:   Sun, 16 Jan 2022 21:56:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Satya Tangirala <satyat@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android11-kiwi-5.4
 2937/9999] drivers/mmc/core/crypto.c:14:6: warning: no previous prototype
 for function 'mmc_crypto_setup_queue'
Message-ID: <202201162151.jM4CfcNA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Satya,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android11-kiwi-5.4
head:   7d1d5848183bd1d9086d0572f9af431d3ded407f
commit: 555cf12eb672727979bc7b7840c7503f3de27220 [2937/9999] ANDROID: mmc: MMC crypto API
config: x86_64-randconfig-a003 (https://download.01.org/0day-ci/archive/20220116/202201162151.jM4CfcNA-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project c63a3175c2947e8c1a2d3bbe16a8586600705c54)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/555cf12eb672727979bc7b7840c7503f3de27220
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android11-kiwi-5.4
        git checkout 555cf12eb672727979bc7b7840c7503f3de27220
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/mmc/core/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/mmc/core/crypto.c:14:6: warning: no previous prototype for function 'mmc_crypto_setup_queue' [-Wmissing-prototypes]
   void mmc_crypto_setup_queue(struct mmc_host *host, struct request_queue *q)
        ^
   drivers/mmc/core/crypto.c:14:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void mmc_crypto_setup_queue(struct mmc_host *host, struct request_queue *q)
   ^
   static 
>> drivers/mmc/core/crypto.c:21:6: warning: no previous prototype for function 'mmc_crypto_free_host' [-Wmissing-prototypes]
   void mmc_crypto_free_host(struct mmc_host *host)
        ^
   drivers/mmc/core/crypto.c:21:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void mmc_crypto_free_host(struct mmc_host *host)
   ^
   static 
>> drivers/mmc/core/crypto.c:26:6: warning: no previous prototype for function 'mmc_crypto_prepare_req' [-Wmissing-prototypes]
   void mmc_crypto_prepare_req(struct mmc_queue_req *mqrq)
        ^
   drivers/mmc/core/crypto.c:26:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void mmc_crypto_prepare_req(struct mmc_queue_req *mqrq)
   ^
   static 
   3 warnings generated.


vim +/mmc_crypto_setup_queue +14 drivers/mmc/core/crypto.c

    13	
  > 14	void mmc_crypto_setup_queue(struct mmc_host *host, struct request_queue *q)
    15	{
    16		if (host->caps2 & MMC_CAP2_CRYPTO)
    17			q->ksm = host->ksm;
    18	}
    19	EXPORT_SYMBOL_GPL(mmc_crypto_setup_queue);
    20	
  > 21	void mmc_crypto_free_host(struct mmc_host *host)
    22	{
    23		keyslot_manager_destroy(host->ksm);
    24	}
    25	
  > 26	void mmc_crypto_prepare_req(struct mmc_queue_req *mqrq)

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
