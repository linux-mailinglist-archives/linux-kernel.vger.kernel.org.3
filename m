Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5F05829F2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 17:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbiG0Prm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 11:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbiG0Prf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 11:47:35 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873B9491DF
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 08:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658936853; x=1690472853;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TdrfWsxQGirYo+4xG6E2Er31WG2PvMMsRbjlDcmtKfM=;
  b=EZN8UUdqxCXUG1Rh3ytm/uCUNYy4aEr8bRPjJ2d0h+gpkkm/SWftl5Tz
   UFLmkzJPPeKizHQLhiaT8ZvFB0Nwp5CVXkW4sOMkcozznTMCWfTdpAFd8
   +yrjdq+WCc9WxU9RMDEs7WtHb5X1AMHvPpgqvNtgFcBFio2xasExp8/CI
   XvtPzLDFdN8MXNyC+HMM0URiIKC3iI+V3R4V9e7To5afm0WOJXCha29Mx
   +bRMJws3RoxbnMAF7hgu7t3EZMIT4DZnwOnsJK7oy8oIDRgSr84JgijvQ
   w9XI2Sn0DbHMMGWzDdQc54w6V3dJphki5URr6E6mEqEczmR1XkudXmKwL
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10421"; a="268038722"
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="268038722"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 08:47:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="576037329"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 27 Jul 2022 08:47:31 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oGjFz-0008qk-0A;
        Wed, 27 Jul 2022 15:47:31 +0000
Date:   Wed, 27 Jul 2022 23:47:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dani Liberman <dliberman@habana.ai>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Oded Gabbay <ogabbay@kernel.org>
Subject: [ogabbay:habanalabs-next 1/13] goya.c:undefined reference to
 `hl_engine_data_sprintf'
Message-ID: <202207272314.ioAxqwFe-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git habanalabs-next
head:   17bf8b54044fa4053a28e1319f7ff71cb2b89d8b
commit: 7dc0e638a9f6d72d481ebb0ad27a11f43712a130 [1/13] habanalabs: removed seq_file parameter from is_idle asic functions
config: csky-randconfig-r012-20220727 (https://download.01.org/0day-ci/archive/20220727/202207272314.ioAxqwFe-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git/commit/?id=7dc0e638a9f6d72d481ebb0ad27a11f43712a130
        git remote add ogabbay https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git
        git fetch --no-tags ogabbay habanalabs-next
        git checkout 7dc0e638a9f6d72d481ebb0ad27a11f43712a130
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=csky SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   csky-linux-ld: csky-linux-ld: DWARF error: could not find abbrev number 83
   drivers/misc/habanalabs/goya/goya.o: in function `goya_is_device_idle':
>> goya.c:(.text+0x33f2): undefined reference to `hl_engine_data_sprintf'
>> csky-linux-ld: goya.c:(.text+0x3472): undefined reference to `hl_engine_data_sprintf'
   csky-linux-ld: goya.c:(.text+0x34fe): undefined reference to `hl_engine_data_sprintf'
   csky-linux-ld: goya.c:(.text+0x3578): undefined reference to `hl_engine_data_sprintf'
   csky-linux-ld: goya.c:(.text+0x35ae): undefined reference to `hl_engine_data_sprintf'
   csky-linux-ld: drivers/misc/habanalabs/goya/goya.o:goya.c:(.text+0x35e6): more undefined references to `hl_engine_data_sprintf' follow

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
