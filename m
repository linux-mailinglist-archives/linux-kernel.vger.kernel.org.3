Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22E24DAE2D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 11:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355113AbiCPKXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 06:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbiCPKXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 06:23:07 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDB75BD1A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 03:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647426113; x=1678962113;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ybQ56GQzwJk+Eo4GKBtQc9IUFQDQ7qGm8gL2AqRzt6Q=;
  b=QVsLFbqsINCEgASKKHW9dY31k5HNQ7Wd9TtG87qnhR1IjpH1LEypW/50
   /oLxjaPBoyPvSw6kyC4qBf9xsqv8HMZqIfsoQEzOaOvIW3C0vvg+/6/IN
   Ze/5EdS1REBrv9AkFIr/gSbF7PAJZrn0bbwVeJ8fNUnyucG/p1ky3diLA
   Raf7OhMfSA1Dxw43x+vMZaoGGfOQsAesL2opaiEVTLYty1Ey3Xf71H83n
   5DGumAW5HHZSWYpy7Fkz0Rv7SIE2r3APBhe4BgkB07iTrlDSIz+I4W7Wk
   qTDhZmpA2gMf35zbCzzWsc1K5hLeCzWSzEjN0uF2iftmfSQXgD0JBwNdk
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="243996339"
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="243996339"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 03:21:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="516270684"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 16 Mar 2022 03:21:49 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUQmq-000CGX-JB; Wed, 16 Mar 2022 10:21:48 +0000
Date:   Wed, 16 Mar 2022 18:21:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Swathi Sridhar <swatsrid@codeaurora.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Saravana Kannan <saravanak@google.com>,
        Charan Teja Reddy <charante@codeaurora.org>,
        Liam Mark <lmark@codeaurora.org>,
        Mark Salyzyn <salyzyn@google.com>,
        Patrick Daly <pdaly@codeaurora.org>,
        Prakash Gupta <guptap@codeaurora.org>,
        Qingqing Zhou <qqzhou@codeaurora.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Shiraz Hashim <shashim@codeaurora.org>,
        Sudarshan Rajagopalan <sudaraja@codeaurora.org>,
        Vijayanand Jitta <vjitta@codeaurora.org>,
        Vinayak Menon <vinmenon@codeaurora.org>
Subject: [ammarfaizi2-block:google/android/kernel/common/android-4.19-stable
 1054/9999] undefined reference to `iommu_debugfs_top'
Message-ID: <202203161802.UKUuyUOa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android-4.19-stable
head:   a54c48f848868b38e9a51c1119aa92dfe443cac4
commit: e24979f0e7bff01a70f00a01fccc5d62f6f980aa [1054/9999] ANDROID: GKI: iommu: Snapshot of vendor changes
config: microblaze-randconfig-m031-20220314 (https://download.01.org/0day-ci/archive/20220316/202203161802.UKUuyUOa-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/e24979f0e7bff01a70f00a01fccc5d62f6f980aa
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android-4.19-stable
        git checkout e24979f0e7bff01a70f00a01fccc5d62f6f980aa
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=microblaze SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   microblaze-linux-ld: drivers/iommu/io-pgtable.o: in function `io_pgtable_init':
>> (.init.text+0x10): undefined reference to `iommu_debugfs_top'

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
