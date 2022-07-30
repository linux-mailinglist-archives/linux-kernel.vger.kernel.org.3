Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC4B585855
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 05:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237144AbiG3Dok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 23:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiG3Doi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 23:44:38 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5546D2D1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 20:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659152677; x=1690688677;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OKSusFbrm5sUaWyzaFMDDNHXw+ww7jPgpopObZCSoLk=;
  b=bdK1RYDKCySou+M6g6MWTF0/YRozqp8VvVC2O3xBBHs/ToE8w0vuK6AG
   Gj6b8qWG5ddlgfFum/u06r10gaQZhn2NeygGPvcS4KY56gkERpceNvHfr
   FPlus5HVPPg6He3Yc13JFIEnZ7XkzNCTg1rdQF78HfGW4nhoJPAs1RfEF
   HF97/0b3hFmYYLpQQKuwZj66RVT4xU6pB3DZWsq5vDdz96sA0HxBQcEYe
   7HZTeikRhVn1A67JH1NVxWcrd0t+7RdPajogL5qGNYKdpBYLlszaZDJ4X
   mFqiFVNV/EtOcQIf7CKiXddblxNm/dXsm8stQXwbc+D4PhUu0GXgRonoz
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="375191624"
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="375191624"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 20:44:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="669464243"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 29 Jul 2022 20:44:36 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHdP1-000CLS-1Z;
        Sat, 30 Jul 2022 03:44:35 +0000
Date:   Sat, 30 Jul 2022 11:44:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:crng/random/jd/vdso 8/8]
 drivers/char/random.c:88:42: error: expected declaration specifiers or '...'
 before '_vdso_rng_data'
Message-ID: <202207301142.4Kf53jZQ-lkp@intel.com>
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
head:   65b88fc7d65669b6a7f4225aa00acf18b82a7682
commit: 65b88fc7d65669b6a7f4225aa00acf18b82a7682 [8/8] random: implement getrandom() in vDSO
config: csky-randconfig-r012-20220729 (https://download.01.org/0day-ci/archive/20220730/202207301142.4Kf53jZQ-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/65b88fc7d65669b6a7f4225aa00acf18b82a7682
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block crng/random/jd/vdso
        git checkout 65b88fc7d65669b6a7f4225aa00acf18b82a7682
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=csky SHELL=/bin/bash drivers/char/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/char/random.c:88:42: error: expected declaration specifiers or '...' before '_vdso_rng_data'
      88 | DEFINE_VVAR_SINGLE(struct vdso_rng_data, _vdso_rng_data);
         |                                          ^~~~~~~~~~~~~~


vim +88 drivers/char/random.c

    63	
    64	/*********************************************************************
    65	 *
    66	 * Initialization and readiness waiting.
    67	 *
    68	 * Much of the RNG infrastructure is devoted to various dependencies
    69	 * being able to wait until the RNG has collected enough entropy and
    70	 * is ready for safe consumption.
    71	 *
    72	 *********************************************************************/
    73	
    74	/*
    75	 * crng_init is protected by base_crng->lock, and only increases
    76	 * its value (from empty->early->ready).
    77	 */
    78	static enum {
    79		CRNG_EMPTY = 0, /* Little to no entropy collected */
    80		CRNG_EARLY = 1, /* At least POOL_EARLY_BITS collected */
    81		CRNG_READY = 2  /* Fully initialized with POOL_READY_BITS collected */
    82	} crng_init __read_mostly = CRNG_EMPTY;
    83	static DEFINE_STATIC_KEY_FALSE(crng_is_ready);
    84	#define crng_ready() (static_branch_likely(&crng_is_ready) || crng_init >= CRNG_READY)
    85	/* Various types of waiters for crng_init->CRNG_READY transition. */
    86	static DECLARE_WAIT_QUEUE_HEAD(crng_init_wait);
    87	static struct fasync_struct *fasync;
  > 88	DEFINE_VVAR_SINGLE(struct vdso_rng_data, _vdso_rng_data);
    89	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
