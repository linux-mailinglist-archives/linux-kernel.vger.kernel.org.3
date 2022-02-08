Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5474AE4E1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354656AbiBHWpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387741AbiBHWoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 17:44:44 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC5BC08C5F5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 14:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644359421; x=1675895421;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IVSlc+hTFVxw4ygzmnnDYqbkOr2sqg2hetKidNXSDBM=;
  b=abV+CCXq6Awghk+x+Y1mqetBcwBkmob9GaJvPXdVyzK+webRUaJz2if8
   uvQTxeS8IQTmVGusX1modjUUeGTya8JJV4HEY65mWA9a/G0TS+OEPnLNU
   t4u0fLSLSdi2S1aVNXF5fb+io4kWmCS1VxjoaC7t5m5J7BJy3lUT7tjW1
   3BidEaEHIEghg92/CIVfeQe/OfPiea2MjKTM73CgG/yYqIL16Cj/FVYMe
   COO3NllOjrj9L+T1GAo0q/y6J+hXuww9FJ4SSlZyltFUv3BjJtvjBoJ9A
   edLozcIQEbowgdvDd/Hrm+En8pEmjB4kjUYLvMyHPFLud/sdYXZCHzmf/
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="273600197"
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="273600197"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 14:30:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="701013215"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 08 Feb 2022 14:30:12 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nHZ00-0000py-41; Tue, 08 Feb 2022 22:30:12 +0000
Date:   Wed, 9 Feb 2022 06:29:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [ardb:hctr2 3/8] crypto/hctr2.c:115:38: sparse: sparse: incorrect
 type in assignment (different base types)
Message-ID: <202202090607.wkQ2yto6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git hctr2
head:   5bb01649223080b7cde5740f441eb5e758ec357f
commit: 09533ad0ea8fa56420aa6e866b11c0685e862bd1 [3/8] crypto: hctr2 - Add HCTR2 support
config: sparc64-randconfig-s032-20220208 (https://download.01.org/0day-ci/archive/20220209/202202090607.wkQ2yto6-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?id=09533ad0ea8fa56420aa6e866b11c0685e862bd1
        git remote add ardb git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
        git fetch --no-tags ardb hctr2
        git checkout 09533ad0ea8fa56420aa6e866b11c0685e862bd1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sparc64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> crypto/hctr2.c:115:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long @@     got restricted __le64 [usertype] @@
   crypto/hctr2.c:115:38: sparse:     expected unsigned long long
   crypto/hctr2.c:115:38: sparse:     got restricted __le64 [usertype]
   crypto/hctr2.c:117:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long @@     got restricted __le64 [usertype] @@
   crypto/hctr2.c:117:38: sparse:     expected unsigned long long
   crypto/hctr2.c:117:38: sparse:     got restricted __le64 [usertype]

vim +115 crypto/hctr2.c

   103	
   104	static int hctr2_hash_tweak(struct skcipher_request *req, u8 *iv)
   105	{
   106		u64 tweak_length_part[2];
   107		struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
   108		const struct hctr2_tfm_ctx *tctx = crypto_skcipher_ctx(tfm);
   109		struct hctr2_request_ctx *rctx = skcipher_request_ctx(req);
   110		struct shash_desc *hash_desc = &rctx->u.hash_desc;
   111		int err;
   112	
   113		memset(tweak_length_part, 0, sizeof(tweak_length_part));
   114		if (req->cryptlen % POLYVAL_BLOCK_SIZE == 0)
 > 115			tweak_length_part[0] = cpu_to_le64(TWEAK_SIZE * 8 * 2 + 2);
   116		else
   117			tweak_length_part[0] = cpu_to_le64(TWEAK_SIZE * 8 * 2 + 3);
   118	
   119		hash_desc->tfm = tctx->hash;
   120		err = crypto_shash_init(hash_desc);
   121		if (err)
   122			return err;
   123	
   124		err = crypto_shash_update(hash_desc, (u8 *)tweak_length_part, sizeof(tweak_length_part));
   125		if (err)
   126			return err;
   127		err = crypto_shash_update(hash_desc, iv, TWEAK_SIZE);
   128		return err;
   129	}
   130	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
