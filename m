Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6154B7FB6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 05:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344489AbiBPEvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 23:51:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344437AbiBPEvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 23:51:37 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BF53A5C3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 20:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644987086; x=1676523086;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ia+lAJFTNQLqFxL3FDU81fywrPyVaCCMbA8Z4rqRw4M=;
  b=WZO148ZPVCoy5NBZCs3se3r79i0yYGUorl+yMvwomb6zozaikqhCUbOs
   2CId7C32iyEbNWYF5C58kUYhzrQDr0tnVqXmHAzZ5DmLqRzK7/+m5GZhC
   6nZunVt1Egt8Sefvwel9cB0BlF/dTIBCh0zvbz6d19deTcNB6W6ES/fvZ
   91mWraAeIW+cKO6UGoN/YJF9ZsJnGB8S0LAwpbhaTF8qmvFrFTZgNqROK
   GwWexdWaFDNZRqnDFJc8pIFJV7Vmmxk7aM1XOGv+UOauilW+2JtnXO0ti
   eZsh0V4F/nzEH3Vw9ZpQ8FEryRFb/MHi+UZ5UDTy+TUhH+xmmHuD/nF/l
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="313797358"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="313797358"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 20:51:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="502849857"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 15 Feb 2022 20:51:24 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKCHj-000AQ2-Nr; Wed, 16 Feb 2022 04:51:23 +0000
Date:   Wed, 16 Feb 2022 12:50:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:axboe/linux-block/m1-test 340/382]
 include/linux/soc/apple/rtkit.h:223:5: warning: no previous prototype for
 'apple_rtkit_poll'
Message-ID: <202202161217.nOIv70qW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block axboe/linux-block/m1-test
head:   5adfbb595194191bad98c47447ddbee7d3b60b8f
commit: 11c140423f34e589a6390d378267811426f82984 [340/382] soc: apple: rtkit: Add recv_message_early callback and apple_rtkit_poll
config: openrisc-randconfig-r022-20220216 (https://download.01.org/0day-ci/archive/20220216/202202161217.nOIv70qW-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/11c140423f34e589a6390d378267811426f82984
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block axboe/linux-block/m1-test
        git checkout 11c140423f34e589a6390d378267811426f82984
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=openrisc SHELL=/bin/bash drivers/nvme/host/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/nvme/host/apple.c:32:
>> include/linux/soc/apple/rtkit.h:223:5: warning: no previous prototype for 'apple_rtkit_poll' [-Wmissing-prototypes]
     223 | int apple_rtkit_poll(struct apple_rtkit *rtk)
         |     ^~~~~~~~~~~~~~~~


vim +/apple_rtkit_poll +223 include/linux/soc/apple/rtkit.h

   222	
 > 223	int apple_rtkit_poll(struct apple_rtkit *rtk)
   224	{
   225		return -ENODEV;
   226	}
   227	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
