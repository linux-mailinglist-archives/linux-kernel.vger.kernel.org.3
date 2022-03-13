Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A84A4D7569
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 14:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbiCMNEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 09:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233916AbiCMNEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 09:04:07 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47392A243
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 06:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647176579; x=1678712579;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rTk31ewTbSxDovSgwL5zIli0bBMVQZ05Yf2qsXQgCH0=;
  b=cnWTxiWcwbbo5uCmtzTMGMQlTnnIc9BQ5CSQ0g3TdpuFZUzJnSJP2XUc
   u7JVZKwQYHUItJSr81hh/pgYybycN3wYJKg07qzGUj12JKQNzaZNL3d9F
   Uc2vYgy4J+20Em2WuMjZ6QzreVETRG84bRwH6nTnfe4s8fV53LIRGITeb
   GiDiwkZFClM0LJfJhz5FYVfG+ezHKTqKMFZCqjCzGdZK81iN0O0YJmWn1
   72QGcFfU1BPpecwk2w4yTwfJ2l2fz/Btsa5s0S5qYaVVnnO8RKCwz5mj0
   pSGdDPe1mpHO9EqftuWo0CRKMDFumVyuTDzfbA6OKGvxAFcjPOUy+5OMF
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10284"; a="316590550"
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="316590550"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 06:02:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="579833169"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 13 Mar 2022 06:02:57 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTNs9-0008yB-5G; Sun, 13 Mar 2022 13:02:57 +0000
Date:   Sun, 13 Mar 2022 21:02:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [hare-scsi-devel:tls-upcall.v4 118/156] crypto/hkdf.c:26:5: warning:
 no previous prototype for 'hkdf_extract'
Message-ID: <202203132024.aYz79iM0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git tls-upcall.v4
head:   d2416ecdb6b03fc2e4aa40b20cdf919322713224
commit: ea4c6fc32e5e02a1e4c841f462c3a931b8838f33 [118/156] crypto,fs: Separate out hkdf_extract() and hkdf_expand()
config: i386-randconfig-a003 (https://download.01.org/0day-ci/archive/20220313/202203132024.aYz79iM0-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git/commit/?id=ea4c6fc32e5e02a1e4c841f462c3a931b8838f33
        git remote add hare-scsi-devel https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git
        git fetch --no-tags hare-scsi-devel tls-upcall.v4
        git checkout ea4c6fc32e5e02a1e4c841f462c3a931b8838f33
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> crypto/hkdf.c:26:5: warning: no previous prototype for 'hkdf_extract' [-Wmissing-prototypes]
      26 | int hkdf_extract(struct crypto_shash *hmac_tfm, const u8 *ikm,
         |     ^~~~~~~~~~~~
>> crypto/hkdf.c:52:5: warning: no previous prototype for 'hkdf_expand' [-Wmissing-prototypes]
      52 | int hkdf_expand(struct crypto_shash *hmac_tfm,
         |     ^~~~~~~~~~~


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
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
