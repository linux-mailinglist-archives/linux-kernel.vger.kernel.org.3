Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0309D5368A8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 23:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238181AbiE0V6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 17:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiE0V6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 17:58:32 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903B163534
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 14:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653688711; x=1685224711;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GpBpIclkHkO+HLOIhC+fZ6RlUfaROULvv/SMKg2mBTc=;
  b=iBaBoifjfu6ye5cf9JZ5xuvKYcdvLtVBiH8VqV6r6qUSf4O0iCbNyegN
   wzBFkfSj6daKAeH7/BtJMYCza1WEkI6hYSJPvmbCEB/pUutRePA7jUkzY
   KrKdWFPs8PhMq+ckS9hmCHzitLrK7hFr/82ES3uWyT/SO3fGD6Cz2Tl+X
   jNid9243ycqKHK7pXfhja9XF0vxY9RuK2l+UAdOrB5Eyklpa75N72wAB1
   nnANI+TpVEyGZw5fIMQ0UnrO9YBHwhuMup/P5aRmVKI95iBYQqesULbMs
   iSwxo1g9iCqGeftfrhQIooSvsbQOZn6zSjllk8ZrGYAxGS73lhKNdj8oj
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10360"; a="274685378"
X-IronPort-AV: E=Sophos;i="5.91,256,1647327600"; 
   d="scan'208";a="274685378"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 14:58:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,256,1647327600"; 
   d="scan'208";a="705323923"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 27 May 2022 14:58:29 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuhyW-0005AF-U9;
        Fri, 27 May 2022 21:58:28 +0000
Date:   Sat, 28 May 2022 05:57:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, 0day robot <lkp@intel.com>
Subject: lib/crypto/blake2s-selftest.c:548:13: warning: stack frame size
 (1176) exceeds limit (1024) in 'blake2s_selftest'
Message-ID: <202205280544.UeG75XaY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel-lab-lkp/linux/commits/UPDATE-20220527-161529/Jason-A-Donenfeld/crypto-blake2s-remove-shash-module/20220526-172214
head:   3f36e6ac3553b6d6872d5e575f30112d333a1934
commit: 3f36e6ac3553b6d6872d5e575f30112d333a1934 crypto: blake2s - remove shash module
date:   14 hours ago
config: hexagon-randconfig-r041-20220526 (https://download.01.org/0day-ci/archive/20220528/202205280544.UeG75XaY-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 134d7f9a4b97e9035150d970bd9e376043c4577e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/3f36e6ac3553b6d6872d5e575f30112d333a1934
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review UPDATE-20220527-161529/Jason-A-Donenfeld/crypto-blake2s-remove-shash-module/20220526-172214
        git checkout 3f36e6ac3553b6d6872d5e575f30112d333a1934
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash lib/crypto/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> lib/crypto/blake2s-selftest.c:548:13: warning: stack frame size (1176) exceeds limit (1024) in 'blake2s_selftest' [-Wframe-larger-than]
   bool __init blake2s_selftest(void)
               ^
   1 warning generated.


vim +/blake2s_selftest +548 lib/crypto/blake2s-selftest.c

66d7fb94e4ffe5 Jason A. Donenfeld 2019-11-08  547  
66d7fb94e4ffe5 Jason A. Donenfeld 2019-11-08 @548  bool __init blake2s_selftest(void)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
