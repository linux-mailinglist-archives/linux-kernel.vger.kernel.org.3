Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03FC4E5F8C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239839AbiCXHgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239572AbiCXHgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:36:38 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B96BB7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 00:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648107305; x=1679643305;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=W0JdFkTSRuOApKRgaNYpzLcmuy+UK2g+tWhFQJ7MWKw=;
  b=I0Vj9tEc80KgmewIl+OAHAy3HzT5aAdDCz4jWs0IET6ZBPR2xXJUOmEF
   KM+b+x6PPIiX6WiUAd4twqw0RcQHLazdctBAoe+o5y7NLCXQuA5ITjZcD
   4doeROB9jLMnuKSowuuWMRiP2J1t3Lw3KgG9ZUjihWm4jne5Qsg4ZEG/Q
   J3fkgu37XLVY4dRFlmdBDoIzn1lWERwDKZtl37npAqde0NC0yrHlNyUfs
   MVF3WvBEMx+X2vDCRZRdNsb7h954dixquuUKFPVq5Q+OjeWn4iTDUWcyA
   M1ynfTa9S/Xjjda3UoBDVsjCtvaCrevC6y2YXF5RqybSts5Gp4nvsgbhO
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="240467006"
X-IronPort-AV: E=Sophos;i="5.90,206,1643702400"; 
   d="scan'208";a="240467006"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 00:35:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,206,1643702400"; 
   d="scan'208";a="544532929"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 24 Mar 2022 00:35:02 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nXHzq-000Kou-0o; Thu, 24 Mar 2022 07:35:02 +0000
Date:   Thu, 24 Mar 2022 15:34:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [norov:bitmap 5/49]
 drivers/net/ethernet/qlogic/qed/qed_rdma.c:338:11: warning: comparison of
 distinct pointer types ('typeof (bmap->max_count - bit) *' (aka 'unsigned
 int *') and 'typeof (512) *' (aka 'int *'))
Message-ID: <202203241543.fPNu5JUu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/norov/linux bitmap
head:   d56897e7da0ce165cd3f983526a76013dd4c1bc1
commit: 4a18f9ef6b1ed1e87ca56f01d1f1a402809982e7 [5/49] qed: rework qed_rdma_bmap_free()
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220324/202203241543.fPNu5JUu-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 902f4708fe1d03b0de7e5315ef875006a6adc319)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/norov/linux/commit/4a18f9ef6b1ed1e87ca56f01d1f1a402809982e7
        git remote add norov https://github.com/norov/linux
        git fetch --no-tags norov bitmap
        git checkout 4a18f9ef6b1ed1e87ca56f01d1f1a402809982e7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/i2c/busses/ drivers/net/ethernet/qlogic/qed/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/qlogic/qed/qed_rdma.c:338:11: warning: comparison of distinct pointer types ('typeof (bmap->max_count - bit) *' (aka 'unsigned int *') and 'typeof (512) *' (aka 'int *')) [-Wcompare-distinct-pointer-types]
                   nbits = min(bmap->max_count - bit, 512);
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:45:19: note: expanded from macro 'min'
   #define min(x, y)       __careful_cmp(x, y, <)
                           ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: expanded from macro '__careful_cmp'
           __builtin_choose_expr(__safe_cmp(x, y), \
                                 ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:26:4: note: expanded from macro '__safe_cmp'
                   (__typecheck(x, y) && __no_side_effects(x, y))
                    ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:20:28: note: expanded from macro '__typecheck'
           (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                      ~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~
   1 warning generated.


vim +338 drivers/net/ethernet/qlogic/qed/qed_rdma.c

   318	
   319	void qed_rdma_bmap_free(struct qed_hwfn *p_hwfn,
   320				struct qed_bmap *bmap, bool check)
   321	{
   322		unsigned int bit, weight, nbits;
   323		unsigned long *b;
   324	
   325		if (!check)
   326			goto end;
   327	
   328		weight = bitmap_weight(bmap->bitmap, bmap->max_count);
   329		if (!weight)
   330			goto end;
   331	
   332		DP_NOTICE(p_hwfn,
   333			  "%s bitmap not free - size=%d, weight=%d, 512 bits per line\n",
   334			  bmap->name, bmap->max_count, weight);
   335	
   336		for (bit = 0; bit < bmap->max_count; bit += 512) {
   337			b =  bmap->bitmap + BITS_TO_LONGS(bit);
 > 338			nbits = min(bmap->max_count - bit, 512);
   339	
   340			if (!bitmap_empty(b, nbits))
   341				DP_NOTICE(p_hwfn,
   342					  "line 0x%04x: %*pb\n", bit / 512, nbits, b);
   343		}
   344	
   345	end:
   346		kfree(bmap->bitmap);
   347		bmap->bitmap = NULL;
   348	}
   349	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
