Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD61D58707E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 20:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbiHASsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 14:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbiHASsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 14:48:45 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F45222BC5
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 11:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659379724; x=1690915724;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5AiKL+DvuSxKnf3kFLABHhMOxVxvLs3s3mUnLtOtRwE=;
  b=gRhHsaR2Uow1NQkwMNzDonaciv07zZBARqsMickG1JdfNCn745N+NoSV
   C80lJ3uVbj8e6vClQ4VsZ7zPoz9z1ylEpC+igmxVgJlIzIgiViVDIb1b+
   EDLBY4A/jaqD+MQhFn99z+dj/+gwUVV4yKMk5tSWctH6tnpOZ60h1IISJ
   hqWl0L6rhIoqJM0OhVJ92pDpMY8QgRCaXrMBia3HHJNMXrNzlwtLQ/llZ
   lF9m/aRy56+244i9CDn7XCOCpDyn/DcfT5gCeO8EP4bVClkbEblyg3QFy
   qBKB8N7mgjrLHNB31rOxdHuCldIDRys98f1eCtyowdndTpQy0q+glvged
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="375522738"
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="375522738"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 11:48:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="670144043"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 01 Aug 2022 11:48:42 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oIaT4-000FE1-0S;
        Mon, 01 Aug 2022 18:48:42 +0000
Date:   Tue, 2 Aug 2022 02:48:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:crng/random/jd/vdso 9/9]
 include/vdso/processor.h:10:10: fatal error: 'asm/vdso/processor.h' file not
 found
Message-ID: <202208020231.SlFNUKqj-lkp@intel.com>
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
head:   352e85344386bb54dc19717319667b114cff5082
commit: 352e85344386bb54dc19717319667b114cff5082 [9/9] random: implement getrandom() in vDSO
config: hexagon-randconfig-r041-20220801 (https://download.01.org/0day-ci/archive/20220802/202208020231.SlFNUKqj-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 52cd00cabf479aa7eb6dbb063b7ba41ea57bce9e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/352e85344386bb54dc19717319667b114cff5082
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block crng/random/jd/vdso
        git checkout 352e85344386bb54dc19717319667b114cff5082
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/char/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/char/random.c:62:
   In file included from include/vdso/datapage.h:17:
>> include/vdso/processor.h:10:10: fatal error: 'asm/vdso/processor.h' file not found
   #include <asm/vdso/processor.h>
            ^~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +10 include/vdso/processor.h

d8bb6993d871f5 Vincenzo Frascino 2020-03-20   9  
d8bb6993d871f5 Vincenzo Frascino 2020-03-20 @10  #include <asm/vdso/processor.h>
d8bb6993d871f5 Vincenzo Frascino 2020-03-20  11  

:::::: The code at line 10 was first introduced by commit
:::::: d8bb6993d871f5d3cd6d65d3772e4b1f4ef17380 common: Introduce processor.h

:::::: TO: Vincenzo Frascino <vincenzo.frascino@arm.com>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
