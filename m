Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243BE576FFC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 17:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbiGPPvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 11:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiGPPvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 11:51:23 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB56118B0C
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 08:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657986682; x=1689522682;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LaO484dNnKjtU1b9v96aU9pgzCv4lbAKkmwsfMZ3azw=;
  b=Qdi5JtWTa8RwoixBmpDJef8cVa1s6Pc973SGssdUz4iaKCRbHt5tE5Yo
   UQVI0lLKkvx3uyQrtcDTGM0DkjFa38J05ZAnbIjhp89XFUxIQZjR9md8y
   e4iv+NoqQshTmuOWANlfXxGibBb9ONxl71vGrbYckNcu8U+myolXPXdjS
   rfFPMQdiMkZu+KGaRGF/GwMs8re+vOa8FDPagBSHeAfifv/lcsHoPrMhM
   xahtHux7Is/5WEva8Coe2YP6fj3vRWFyYu6+z2GjZdoh65DcfHt7GfcHI
   BbAkoGz2lH4Keb6lXXY8dOGhgWmSK0/yfLW+YgTWZ1Mjg3qKLCQhK8u23
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10410"; a="266394148"
X-IronPort-AV: E=Sophos;i="5.92,277,1650956400"; 
   d="scan'208";a="266394148"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2022 08:51:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,277,1650956400"; 
   d="scan'208";a="629438321"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 16 Jul 2022 08:51:20 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCk4d-0001lK-Vh;
        Sat, 16 Jul 2022 15:51:19 +0000
Date:   Sat, 16 Jul 2022 23:50:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: arch/mips/boot/compressed/../../../../lib/ashldi3.c:9:19: warning:
 no previous prototype for '__ashldi3'
Message-ID: <202207162318.iryfcTQP-lkp@intel.com>
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

Hi Masahiro,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9b59ec8d50a1f28747ceff9a4f39af5deba9540e
commit: f78b25ee922ef6faf59a258af1b9388ca894cfd9 mips: decompressor: do not copy source files while building
date:   8 months ago
config: mips-randconfig-r012-20220715 (https://download.01.org/0day-ci/archive/20220716/202207162318.iryfcTQP-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f78b25ee922ef6faf59a258af1b9388ca894cfd9
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f78b25ee922ef6faf59a258af1b9388ca894cfd9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

Note: functions only called from assembly code should be annotated with the asmlinkage attribute
All warnings (new ones prefixed by >>):

   In file included from arch/mips/boot/compressed/ashldi3.c:2:
>> arch/mips/boot/compressed/../../../../lib/ashldi3.c:9:19: warning: no previous prototype for '__ashldi3' [-Wmissing-prototypes]
       9 | long long notrace __ashldi3(long long u, word_type b)
         |                   ^~~~~~~~~


vim +/__ashldi3 +9 arch/mips/boot/compressed/../../../../lib/ashldi3.c

b35cd9884fa5d8 Palmer Dabbelt 2017-05-23  8  
b35cd9884fa5d8 Palmer Dabbelt 2017-05-23 @9  long long notrace __ashldi3(long long u, word_type b)

:::::: The code at line 9 was first introduced by commit
:::::: b35cd9884fa5d81c9d5e7f57c9d03264ae2bd835 lib: Add shared copies of some GCC library routines

:::::: TO: Palmer Dabbelt <palmer@dabbelt.com>
:::::: CC: Palmer Dabbelt <palmer@dabbelt.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
