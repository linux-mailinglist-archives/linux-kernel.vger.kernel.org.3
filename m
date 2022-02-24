Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208BD4C23E0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 07:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbiBXGHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 01:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiBXGHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 01:07:35 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412885EBCD
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 22:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645682826; x=1677218826;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gEhGUaD8oPJf4/lhLNSulzbS/gmsCvN7ZBmdIarR2AM=;
  b=c63Ysc2RVf61VdfbC/lRButzZ+bxnrE3bEftL11QKcawT+GtWJV05ZbO
   CibxxIcEGdfcD9mW1Wx/Gses5UC5gPyw/pij5I9R6ChNa7eAeincbr7m4
   CB8xXokUSzhycRRV9wMa1nPXp8M07vtjnN//fWtU8Mr152fuE08Xeii7d
   6WsRJCBFEsvw75G705nW5gZO2hC594tnxzHkjyVUSuU9SXXpq8PwE1q3U
   UoAywQ3YaoNGwoHXG9RdR7/Y/QPEYoNRjUOmq+VoZZML3Fg38fpX7QyA+
   eRE/sSVh42k/u2dQSylv/gqSo7PqyExjaYy2KhE1cJzP+99w+41kHB7H9
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="249739934"
X-IronPort-AV: E=Sophos;i="5.88,393,1635231600"; 
   d="scan'208";a="249739934"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 22:07:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,393,1635231600"; 
   d="scan'208";a="637715291"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 23 Feb 2022 22:07:04 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nN7HM-0002Kf-4O; Thu, 24 Feb 2022 06:07:04 +0000
Date:   Thu, 24 Feb 2022 14:06:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vijayanand Jitta <vjitta@codeaurora.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:google/android/kernel/common/android-gs-raviole-5.10-android12-qpr1-d
 1049/8858] (.rodata+0x0): multiple definition of `__crc_si_swapinfo';
 arch/s390/appldata/appldata_base.o:(.rodata+0x0): first defined here
Message-ID: <202202241314.H48PleNt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vijayanand,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android-gs-raviole-5.10-android12-qpr1-d
head:   9771767708df4fcf51cd1642e041c804a86e740c
commit: 5e07d2eb085f9060663d0f5601dd486bf6fc2010 [1049/8858] ANDROID: mm: Export si_swapinfo
config: s390-debug_defconfig (https://download.01.org/0day-ci/archive/20220224/202202241314.H48PleNt-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/5e07d2eb085f9060663d0f5601dd486bf6fc2010
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android-gs-raviole-5.10-android12-qpr1-d
        git checkout 5e07d2eb085f9060663d0f5601dd486bf6fc2010
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: mm/swapfile.o: in function `__crc_si_swapinfo':
>> (.rodata+0x0): multiple definition of `__crc_si_swapinfo'; arch/s390/appldata/appldata_base.o:(.rodata+0x0): first defined here

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
