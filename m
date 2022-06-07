Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F77753F6B8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 09:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237362AbiFGG7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 02:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiFGG7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 02:59:48 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52448DFD13
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 23:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654585187; x=1686121187;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ugz5Yr2O87wU2aHl3D58metSBL+6GZHntS4uQF/xDd0=;
  b=VvpqBeZea5OmEP8pAfTPtgkvLKk3ZnlGrn9B4chcDCSZNEXcKeYKTEnG
   SBypGu9Srydq8piJ/bzodDMQGC5KDIX6Ind7lDvWsMQonVGvpxgOENL/5
   KYWHBukNdL52HQtByVdLAcqQJZ+uovhWU9oNPehKOLgY1ZVRNQrsLeQ8W
   wUM5OEtiOyyJQ+jSOXH6DTtie8uRq1Nb3C1Yn50+g97DMD0/BvSyxbhLj
   2/bh0/nb9zTpO3PIEqEbIJgrNhhQesql2VFPZ/pxO3BwlBCnVAl630SNM
   BW9Lc+qQKbdK2ISlqVOQ4Uoph8V0n8LhHRrFAnrzDXmJDgvvo23gWMyOs
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="277354775"
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="277354775"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 23:59:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="584065425"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 06 Jun 2022 23:59:45 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nyTBp-000DRh-3V;
        Tue, 07 Jun 2022 06:59:45 +0000
Date:   Tue, 7 Jun 2022 14:58:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [tglx-spdx:2022-batch1 11/25]
 arch/x86/crypto/crc32-pclmul_asm.S:2:2: error: unexpected token at start of
 statement
Message-ID: <202206071406.DZ8LbAVZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tglx/linux-spdx.git 2022-batch1
head:   91ba6750a1ba591f72b2f68e0a209c9cc7c0ace4
commit: 5de8e209fec395c4e3a43a9554ef3459547f0364 [11/25] treewide: Replace GPLv2 boilerplate/reference with SPDX - gpl-2.0_179.RULE
config: x86_64-randconfig-a009 (https://download.01.org/0day-ci/archive/20220607/202206071406.DZ8LbAVZ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b92436efcb7813fc481b30f2593a4907568d917a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/tglx/linux-spdx.git/commit/?id=5de8e209fec395c4e3a43a9554ef3459547f0364
        git remote add tglx-spdx https://git.kernel.org/pub/scm/linux/kernel/git/tglx/linux-spdx.git
        git fetch --no-tags tglx-spdx 2022-batch1
        git checkout 5de8e209fec395c4e3a43a9554ef3459547f0364
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/x86/crypto/crc32-pclmul_asm.S:2:2: error: unexpected token at start of statement
    */
    ^


vim +2 arch/x86/crypto/crc32-pclmul_asm.S

78c37d191dd6899 Alexander Boyko 2013-01-10 @2   */
78c37d191dd6899 Alexander Boyko 2013-01-10  3  

:::::: The code at line 2 was first introduced by commit
:::::: 78c37d191dd6899d8c219fee597a17d6e3c5d288 crypto: crc32 - add crc32 pclmulqdq implementation and wrappers for table implementation

:::::: TO: Alexander Boyko <alexander_boyko@xyratex.com>
:::::: CC: Herbert Xu <herbert@gondor.apana.org.au>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
