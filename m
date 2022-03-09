Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F45B4D38E6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 19:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbiCISfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 13:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbiCISf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 13:35:29 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13781125518
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 10:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646850870; x=1678386870;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GIWK4kzGBVCR6XE/sdxgzDKmNpJgEWFwIqcJpN/JMRw=;
  b=HjMNLRUim/TXYW+8x8+ePbBJVITtAAL3Iv60htFoO3jjDdmCbtO6fULI
   jh1tzxdf9Cne5z45mVixmBOpFYvWsr5HAyvvbMFW+wtXJclL/hqAgPJLl
   sh8ek8l2tI7YMeTzzH7xPHWwd3AgcNKDYz+WEMG/gT+fNclYxE3HGP0ak
   5U20cudqQ+lisC+rIrHxzYMYP/6lZFed8gU6rJMXTrh52Eg3BvE0wDYjH
   e3HDAk9TUeA2IyI5pZLQ4JYt19fYB+MOPzCnwV6hxbzHRu1NzeD2xZXsl
   SDzT2Mngk0lhwWv7T32/+vpX+HojuQ0HsLJgANLP65bkf3H+vN3Nku4CJ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="252630266"
X-IronPort-AV: E=Sophos;i="5.90,168,1643702400"; 
   d="scan'208";a="252630266"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 10:34:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,168,1643702400"; 
   d="scan'208";a="547733826"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 09 Mar 2022 10:34:25 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nS18h-0003hU-IH; Wed, 09 Mar 2022 18:34:23 +0000
Date:   Thu, 10 Mar 2022 02:33:41 +0800
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
 558/9999] io-pgtable.c:undefined reference to `iommu_debugfs_top'
Message-ID: <202203100235.mOo7SPyo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android-4.19-stable
head:   3fba6c6e70994eff4dcc5be475c9d2bd3848b83d
commit: e24979f0e7bff01a70f00a01fccc5d62f6f980aa [558/9999] ANDROID: GKI: iommu: Snapshot of vendor changes
config: arc-randconfig-r036-20220309 (https://download.01.org/0day-ci/archive/20220310/202203100235.mOo7SPyo-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/e24979f0e7bff01a70f00a01fccc5d62f6f980aa
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android-4.19-stable
        git checkout e24979f0e7bff01a70f00a01fccc5d62f6f980aa
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arceb-elf-ld: drivers/iommu/io-pgtable.o: in function `io_pgtable_init':
>> io-pgtable.c:(.init.text+0xc): undefined reference to `iommu_debugfs_top'
>> arceb-elf-ld: io-pgtable.c:(.init.text+0xc): undefined reference to `iommu_debugfs_top'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
