Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFD754B1A2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 14:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbiFNMmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 08:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356292AbiFNMln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 08:41:43 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D524BBAF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 05:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655210312; x=1686746312;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=62k3oO9Ayu0GdsYXnmBXqyuX0LcQaZ87CTBiQ1Uev78=;
  b=jvX+X1TvJb5ir8EFOYt1q7lB7CCsHDL5jzbIgChblAvESELpqfxmxHZO
   yXGJNxNIwTv41PsFV6BBJb3NWZ4KNFC5A6Ic8wJ1exBPkp6GmHlKNHE4l
   7huvfNmiDfwgHCcd4Oas2Lqzx3IqDNHdGgJW4KmG9f5MsrnlHPgCqAOeZ
   8A/eOsdDgIr09JmnE0NHqkd/Ap7F0s3YcJP2mFfYTG3YDTWbf3ncqPt7F
   i4JWC+OYWfsU/ySknBFpGVbO0Dey+HVaQJ/PRtOJJyFvT0VFwKThyG9sW
   5GKq1bLYl5CxkB59MfQms3h3+SziVaXy116EiqNTKFTlM3Sy8k5yXMjKc
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="279320481"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="279320481"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 05:38:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="612214983"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 14 Jun 2022 05:38:30 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o15oT-000LsY-Do;
        Tue, 14 Jun 2022 12:38:29 +0000
Date:   Tue, 14 Jun 2022 20:37:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [ardb:for-kernelci 23/35] ld.lld: error: undefined symbol:
 memstart_offset_seed
Message-ID: <202206142017.FKV7LEZN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git for-kernelci
head:   471ce969846a9d03244edcd56df409ed17a3801a
commit: eb14d7faadf728d1cdb6efc53fe143898fc0a363 [23/35] arm64: head: relocate kernel only a single time if KASLR is enabled
config: arm64-buildonly-randconfig-r003-20220613 (https://download.01.org/0day-ci/archive/20220614/202206142017.FKV7LEZN-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c97436f8b6e2718286e8496faf53a2c800e281cf)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?id=eb14d7faadf728d1cdb6efc53fe143898fc0a363
        git remote add ardb git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
        git fetch --no-tags ardb for-kernelci
        git checkout eb14d7faadf728d1cdb6efc53fe143898fc0a363
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: memstart_offset_seed
   >>> referenced by arch/arm64/kernel/head.o:(__primary_switched)
   >>> referenced by arch/arm64/kernel/head.o:(__primary_switched)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
