Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1111D4E808B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 12:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbiCZLQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 07:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbiCZLQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 07:16:51 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945801D0ED
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 04:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648293315; x=1679829315;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RLwYChefsEKaSgld+bj3zvjcdCYFmUYhUBPQGdv1b/o=;
  b=cZqrLzt1UVpfPKTD/Z7Bez9lrguBt7rSPEhIHXzO5avTjQoX1TxlsceW
   IJTgaFLL4HQQp1Gu9jbaJI2rxVQj6rmoxGgyezF5AKOAbbvHMiWgGFHok
   56lXCFFeVujdT3kV5ObqQT3Bly2+lZUttr3K+YW/jNOBmNLVCoxGZaK84
   hNAfSUgCN9dO7ZyZssYRS09h/ITu6D+XhPgINVY8SSdmApzgZXZqnc60r
   mmShYEKYRqdsPqrIu0vP9l3Z1uDb5ft2Jvj4/xOpmpWL/47z4Jfu6vIya
   LoznQeGuRCmXA+gw7YeS6Hh2UFwYgkuEEImh+cg3MREtX49ogEB01xGFX
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="257605412"
X-IronPort-AV: E=Sophos;i="5.90,213,1643702400"; 
   d="scan'208";a="257605412"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2022 04:15:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,213,1643702400"; 
   d="scan'208";a="520477514"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 26 Mar 2022 04:15:13 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nY4O0-000NJT-Vr; Sat, 26 Mar 2022 11:15:13 +0000
Date:   Sat, 26 Mar 2022 19:14:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [norov:bitmap 5/49]
 drivers/net/ethernet/qlogic/qed/qed_rdma.c:338:11: warning: comparison of
 distinct pointer types ('typeof (bmap->max_count - bit) *' (aka 'unsigned
 int *') and 'typeof (512UL) *' (aka 'unsigned long *'))
Message-ID: <202203261918.97wQ7aCy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/norov/linux bitmap
head:   0bce39e45f86107fcce7f816fe51d73e6f78a3df
commit: 5c602c9efc42ae865431c9d685858e0b8d1665d0 [5/49] qed: rework qed_rdma_bmap_free()
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220326/202203261918.97wQ7aCy-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/norov/linux/commit/5c602c9efc42ae865431c9d685858e0b8d1665d0
        git remote add norov https://github.com/norov/linux
        git fetch --no-tags norov bitmap
        git checkout 5c602c9efc42ae865431c9d685858e0b8d1665d0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/ drivers/net/ethernet/qlogic/qed/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/qlogic/qed/qed_rdma.c:338:11: warning: comparison of distinct pointer types ('typeof (bmap->max_count - bit) *' (aka 'unsigned int *') and 'typeof (512UL) *' (aka 'unsigned long *')) [-Wcompare-distinct-pointer-types]
                   nbits = min(bmap->max_count - bit, 512UL);
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
 > 338			nbits = min(bmap->max_count - bit, 512UL);
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
