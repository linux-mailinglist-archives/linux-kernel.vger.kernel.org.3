Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30E04C2094
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 01:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245249AbiBXA01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 19:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235755AbiBXA0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 19:26:25 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000F760CE5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 16:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645662355; x=1677198355;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ItM0Ed5jGXsDogudqlqJ3bPLvolWhLw5yq5+/f2NQuA=;
  b=e9D6c1c7amiQKB4f+/a8gkrCfIgEhSNmqoGk+YKGFKJtGpOq4uDCxf0X
   Lzj4hW7ilIznw7u9NTzxax73O0WPVgwdGpevVmKxQ6Ae+RrP0ems8mMXA
   l1S4vgSJqMfQIUJYa4m4x68hEHISS0FgWSSlYnfeWsPI7171dyFcgdgHU
   piXrl9Vb+S9k6cB5fhZoKMZ0NtQquY9nwN8GrAHI2NrXsrE/8f1PWUlQ3
   m2VqrlQNppLdLMajG112GwM54nqg+1QxHbLOVYgmsRxYL/ns/4naNLEPe
   5SQlw9yAOsRI9u1MBt5H+FOe/st2X/2VDep94RNEsvHhS7qX9QBWKobDf
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="338553053"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="338553053"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 16:25:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="684094941"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 23 Feb 2022 16:25:53 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nN1xB-00021P-BT; Thu, 24 Feb 2022 00:25:53 +0000
Date:   Thu, 24 Feb 2022 08:24:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [hare-scsi-devel:tls-upcall.v2 34/67] crypto/hkdf.c:26:5: warning:
 no previous prototype for function 'hkdf_extract'
Message-ID: <202202240845.4HsZOLts-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git tls-upcall.v2
head:   ac729ea3c52bda460616c71d5f5fc47b2e64da6d
commit: 04ae9ad78a4ea9280f04e5e001fd8a179665d1c1 [34/67] crypto,fs: Separate out hkdf_extract() and hkdf_expand()
config: riscv-buildonly-randconfig-r002-20220223 (https://download.01.org/0day-ci/archive/20220224/202202240845.4HsZOLts-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git/commit/?id=04ae9ad78a4ea9280f04e5e001fd8a179665d1c1
        git remote add hare-scsi-devel https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git
        git fetch --no-tags hare-scsi-devel tls-upcall.v2
        git checkout 04ae9ad78a4ea9280f04e5e001fd8a179665d1c1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> crypto/hkdf.c:26:5: warning: no previous prototype for function 'hkdf_extract' [-Wmissing-prototypes]
   int hkdf_extract(struct crypto_shash *hmac_tfm, const u8 *ikm,
       ^
   crypto/hkdf.c:26:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int hkdf_extract(struct crypto_shash *hmac_tfm, const u8 *ikm,
   ^
   static 
   crypto/hkdf.c:57:5: warning: unused variable 'prefix' [-Wunused-variable]
           u8 prefix[9];
              ^
>> crypto/hkdf.c:52:5: warning: no previous prototype for function 'hkdf_expand' [-Wmissing-prototypes]
   int hkdf_expand(struct crypto_shash *hmac_tfm,
       ^
   crypto/hkdf.c:52:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int hkdf_expand(struct crypto_shash *hmac_tfm,
   ^
   static 
   3 warnings generated.


vim +/hkdf_extract +26 crypto/hkdf.c

    14	
    15	/*
    16	 * HKDF consists of two steps:
    17	 *
    18	 * 1. HKDF-Extract: extract a pseudorandom key of length HKDF_HASHLEN bytes from
    19	 *    the input keying material and optional salt.
    20	 * 2. HKDF-Expand: expand the pseudorandom key into output keying material of
    21	 *    any length, parameterized by an application-specific info string.
    22	 *
    23	 */
    24	
    25	/* HKDF-Extract (RFC 5869 section 2.2), unsalted */
  > 26	int hkdf_extract(struct crypto_shash *hmac_tfm, const u8 *ikm,
    27			 unsigned int ikmlen, u8 *prk)
    28	{
    29		unsigned int prklen = crypto_shash_digestsize(hmac_tfm);
    30		u8 *default_salt;
    31		int err;
    32	
    33		default_salt = kzalloc(prklen, GFP_KERNEL);
    34		if (!default_salt)
    35			return -ENOMEM;
    36		err = crypto_shash_setkey(hmac_tfm, default_salt, prklen);
    37		if (!err)
    38			err = crypto_shash_tfm_digest(hmac_tfm, ikm, ikmlen, prk);
    39	
    40		kfree(default_salt);
    41		return err;
    42	}
    43	EXPORT_SYMBOL_GPL(hkdf_extract);
    44	
    45	/*
    46	 * HKDF-Expand (RFC 5869 section 2.3).
    47	 * This expands the pseudorandom key, which was already keyed into @hmac_tfm,
    48	 * into @okmlen bytes of output keying material parameterized by the
    49	 * application-specific @info of length @infolen bytes.
    50	 * This is thread-safe and may be called by multiple threads in parallel.
    51	 */
  > 52	int hkdf_expand(struct crypto_shash *hmac_tfm,

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
