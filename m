Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561145097E7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 08:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385110AbiDUGpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385055AbiDUGop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:44:45 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686A513F9C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650523312; x=1682059312;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wPEL/kw/JWNf7uKtzOagGZmEcIiBH/2teWadWxvGW8Q=;
  b=jCsvQxHDc9xXnaJmEllbXR5x/6OI/odgYBj1SmT7+h0ppJX8+UtWJ+sk
   R1cGmgfIcnUjKTi06/62qyR8J7iBvMsIs25yNtvDsNGvJTxNwbpR+3hnL
   px8RHLzRA3PLfU7ZpTFUbBWWMdsR6ThOr1lQ4JB5KeG7lGWbMNR9FzH28
   1AQyoOcOKU+dkNSioToLM1G8F/H24PJTiCo0Pn+nvE5RLNfhgzqsyoxOr
   eAvuZKmvcCL7IinqFLBlMTtK4aXCbNts6xJUye9p1fmpt5ddx/FVP7RrC
   D5RKOebifmcN8F20lk+8VAyAV943M9itzDDY58fp6ToLylhuts4GIwyUz
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="251569920"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="251569920"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:41:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="614756916"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 20 Apr 2022 23:41:50 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhQVh-0007yT-QS;
        Thu, 21 Apr 2022 06:41:49 +0000
Date:   Thu, 21 Apr 2022 14:40:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1453/2579] arch/mips/vdso/genvdso.c:21:10:
 fatal error: 'linux/mm_api.h' file not found
Message-ID: <202204202323.l1gSemNN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   49e1ec6c70a6eb4b7de9250a455b8b63eb42afbe
commit: 4eb7f06cbb9a0539016473ab509c83b5c9c50127 [1453/2579] headers/deps: Add header dependencies to .c files: <linux/mm_api.h>
config: mips-randconfig-r026-20220419 (https://download.01.org/0day-ci/archive/20220420/202204202323.l1gSemNN-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c1c49a356162b22554088d269f7689bdb044a9f1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=4eb7f06cbb9a0539016473ab509c83b5c9c50127
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 4eb7f06cbb9a0539016473ab509c83b5c9c50127
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/kernel/ arch/mips/vdso/ drivers/media/tuners/ drivers/rtc/ kernel/ lib/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/mips/vdso/genvdso.c:21:10: fatal error: 'linux/mm_api.h' file not found
   #include <linux/mm_api.h>
            ^~~~~~~~~~~~~~~~
   1 error generated.


vim +21 arch/mips/vdso/genvdso.c

  > 21	#include <linux/mm_api.h>
    22	#include <sys/mman.h>
    23	#include <sys/stat.h>
    24	#include <sys/types.h>
    25	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
