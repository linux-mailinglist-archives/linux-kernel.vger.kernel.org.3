Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2A74AF544
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 16:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235824AbiBIPa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 10:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235551AbiBIPau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 10:30:50 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182ADC061355
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 07:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644420654; x=1675956654;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zauU5vkXPysXVgTYyd3mR2l2ZQGaxYzjdyZI9mEhceI=;
  b=hBIKhoPu8m/pJ9+Id/XUk15aTimE6/QZm3QNHaqbOhGJ9b3tnMT/1zI0
   l2XwNw3aAnSARij/VWY1vIwsTNQz0F1/d9hZUhLd2LQkV9cHjetWpJp97
   We6DLbdX23Jar2mxt8NqfAAS8+l1nh+cfDq7c+YaDloR1TwYd2yr0qQ6C
   VsKDYpaqbVuYakJnptSXOBwYpEbpArolbiZ7mrqLvRTaokfy0iQJ8c1EW
   uSU8VeWoyFS4HpDthbJv7Q+HOdDFT0L0x80pnZprzyhGdJbO5r09IPkFK
   aOXuRFChFb3Z9+81XDz812yUw84hgYZmLz7j+ca6QElUuen55Rv3RBBu6
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="232793078"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="232793078"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 07:30:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="485277870"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 09 Feb 2022 07:30:52 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nHovj-0001yX-AT; Wed, 09 Feb 2022 15:30:51 +0000
Date:   Wed, 9 Feb 2022 23:29:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [norov:bitmap-20220204 10/48]
 drivers/net/ethernet/qlogic/qed/qed_rdma.c:332:7: error: use of undeclared
 identifier 'idx'
Message-ID: <202202092311.nsDv5MPD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/norov/linux bitmap-20220204
head:   6be3158022466595db078b4091472d0541e04bdc
commit: 8bca8c2ba1a83d9ebf601431dab6c4ab05d9ca27 [10/48] qed: rework qed_rdma_bmap_free()
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20220209/202202092311.nsDv5MPD-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project e8bff9ae54a55b4dbfeb6ba55f723abbd81bf494)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/norov/linux/commit/8bca8c2ba1a83d9ebf601431dab6c4ab05d9ca27
        git remote add norov https://github.com/norov/linux
        git fetch --no-tags norov bitmap-20220204
        git checkout 8bca8c2ba1a83d9ebf601431dab6c4ab05d9ca27
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/net/ethernet/qlogic/qed/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/qlogic/qed/qed_rdma.c:332:7: error: use of undeclared identifier 'idx'
           for (idx = 0; idx < bmap->max_count; idx += 512) {
                ^
   drivers/net/ethernet/qlogic/qed/qed_rdma.c:332:16: error: use of undeclared identifier 'idx'
           for (idx = 0; idx < bmap->max_count; idx += 512) {
                         ^
   drivers/net/ethernet/qlogic/qed/qed_rdma.c:332:39: error: use of undeclared identifier 'idx'
           for (idx = 0; idx < bmap->max_count; idx += 512) {
                                                ^
   drivers/net/ethernet/qlogic/qed/qed_rdma.c:333:37: error: use of undeclared identifier 'idx'
                   b =  bmap->bitmap + BITS_TO_LONGS(idx);
                                                     ^
   drivers/net/ethernet/qlogic/qed/qed_rdma.c:334:33: error: use of undeclared identifier 'idx'
                   nbits = min(bmap->max_count - idx, 512);
                                                 ^
   drivers/net/ethernet/qlogic/qed/qed_rdma.c:334:33: error: use of undeclared identifier 'idx'
   drivers/net/ethernet/qlogic/qed/qed_rdma.c:338:30: error: use of undeclared identifier 'idx'
                                     "line 0x%04x: %*pb\n", idx / 512, nbits, b);
                                                            ^
   7 errors generated.


vim +/idx +332 drivers/net/ethernet/qlogic/qed/qed_rdma.c

   318	
   319	void qed_rdma_bmap_free(struct qed_hwfn *p_hwfn,
   320				struct qed_bmap *bmap, bool check)
   321	{
   322		unsigned int pos, weight, nbits;
   323		unsigned long *b;
   324	
   325		if (!check || !(weight = bitmap_weight(bmap->bitmap, bmap->max_count)))
   326			goto end;
   327	
   328		DP_NOTICE(p_hwfn,
   329			  "%s bitmap not free - size=%d, weight=%d, 512 bits per line\n",
   330			  bmap->name, bmap->max_count, weight);
   331	
 > 332		for (idx = 0; idx < bmap->max_count; idx += 512) {
   333			b =  bmap->bitmap + BITS_TO_LONGS(idx);
   334			nbits = min(bmap->max_count - idx, 512);
   335	
   336			if (!bitmap_empty(b, nbits))
   337				DP_NOTICE(p_hwfn,
   338					  "line 0x%04x: %*pb\n", idx / 512, nbits, b);
   339		}
   340	
   341	end:
   342		kfree(bmap->bitmap);
   343		bmap->bitmap = NULL;
   344	}
   345	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
