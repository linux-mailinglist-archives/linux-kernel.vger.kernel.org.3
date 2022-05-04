Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216C951B25D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 00:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378669AbiEDWxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 18:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234521AbiEDWxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:53:08 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DB2527F3
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 15:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651704570; x=1683240570;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5P/PrMYYu3/0Y8TeBq+/Mcp8ybxA6LS0+AwYjUJWd44=;
  b=XxSNKsxhDKExbn7qncrezveQQW3LVBsyHiB2DAfiDmm3CtK5SPsGpBDh
   CKij6apwE3WioG8+S6fMmnZWmYyx3xHktufEk5Gr+BVMXUsTwuMBOCIlb
   kY4xaNXGUn31VOrGhe8BPFWlOhpQHqBP9UxsfVlE6hRm1bfjn4Pnkde4H
   YPGjF9IrlCzlCiFcvEhIj4jEDKB1mfb4B0q/CA1vLe/DzbsJpBoJ93qpO
   8kJRkxT8hBfogISaAxPH4FE1iw1rUVes/pP3Btaf8xxwybwDUFGI9YZtu
   bwtk08l5e0KFBKj41y7SspVFBlKaqBJJL/ldtdnkIwLvo7WRnmWidGIaw
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="268075016"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="268075016"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 15:49:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="734620159"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 04 May 2022 15:49:15 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmNo2-000Brq-TI;
        Wed, 04 May 2022 22:49:14 +0000
Date:   Thu, 5 May 2022 06:48:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        will@kernel.org, axboe@kernel.dk
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, mb@lightnvm.io,
        ckeepax@opensource.cirrus.com, manjunatha.venkatesh@nxp.com,
        mst@redhat.com, javier@javigon.com, mikelley@microsoft.com,
        jasowang@redhat.com, sunilmut@microsoft.com,
        bjorn.andersson@linaro.org, rvmanjumce@gmail.com,
        ashish.deshpande@nxp.com
Subject: Re: [PATCH v3] [PATCH v3] uwb: nxp: sr1xx: UWB driver support for
 sr1xx series chip
Message-ID: <202205050656.HCzWfiw2-lkp@intel.com>
References: <20220504171337.3416983-1-manjunatha.venkatesh@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504171337.3416983-1-manjunatha.venkatesh@nxp.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manjunatha,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on linux/master linus/master v5.18-rc5 next-20220504]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Manjunatha-Venkatesh/uwb-nxp-sr1xx-UWB-driver-support-for-sr1xx-series-chip/20220505-020126
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git 35a7609639c49f76f13f206402cbf692c4ae3e4e
config: x86_64-randconfig-a014-20220502 (https://download.01.org/0day-ci/archive/20220505/202205050656.HCzWfiw2-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 363b3a645a1e30011cc8da624f13dac5fd915628)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/037b22462c3f4715f0a04e1be05cd12986880d21
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Manjunatha-Venkatesh/uwb-nxp-sr1xx-UWB-driver-support-for-sr1xx-series-chip/20220505-020126
        git checkout 037b22462c3f4715f0a04e1be05cd12986880d21
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> error: include/uapi/misc/sr1xx.h: missing "WITH Linux-syscall-note" for SPDX-License-Identifier
   make[2]: *** [scripts/Makefile.headersinst:63: usr/include/misc/sr1xx.h] Error 1
   make[2]: Target '__headers' not remade because of errors.
   make[1]: *** [Makefile:1280: headers] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
