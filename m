Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF5B4B7FB7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 05:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344516AbiBPEvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 23:51:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344431AbiBPEvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 23:51:37 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0281B7B5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 20:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644987085; x=1676523085;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sh8iut/RjeH+KtXj0mEpLJXoMlqNnx0uLaF4osrGmbk=;
  b=LB0DKV6prZYYFzZMpdaJOBKKwvmun2Qj0PYANPfH5QiS4jgSmOr0zh3H
   ksiL4TO9/XAXjF3rNNrpSGEe/rNmXTHEPHDjnVwd2DwmSm1ankAkUBdyY
   5q/J2s+WK7+tnxkSz0uZ0ipDwE5yd60JtFuVoynlA2ll7wZAF+spOG5Gz
   qKBWGka5oZel2LUYNXk9gDbZpwRHRep/O768pw/MqvI89yemEzJJp9nKj
   tZbiaEZCFdunWrSrbgoLWvLGs2bsh6kJyOEGzqLBT4XWL0meSJIVew7mY
   sNAFdvSPdx8kvJQQNZTxGso0TiCQCuZMaR0rCNPREu4Gn9fAYbVp3Jk1m
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="250724169"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="250724169"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 20:51:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="681343272"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 15 Feb 2022 20:51:24 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKCHj-000AQ4-P7; Wed, 16 Feb 2022 04:51:23 +0000
Date:   Wed, 16 Feb 2022 12:50:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:axboe/linux-block/m1-test 340/382]
 include/linux/soc/apple/rtkit.h:223:5: warning: no previous prototype for
 function 'apple_rtkit_poll'
Message-ID: <202202161241.peuSiTA3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
config: arm64-randconfig-r003-20220216 (https://download.01.org/0day-ci/archive/20220216/202202161241.peuSiTA3-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0e628a783b935c70c80815db6c061ec84f884af5)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/11c140423f34e589a6390d378267811426f82984
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block axboe/linux-block/m1-test
        git checkout 11c140423f34e589a6390d378267811426f82984
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/nvme/host/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/nvme/host/apple.c:32:
>> include/linux/soc/apple/rtkit.h:223:5: warning: no previous prototype for function 'apple_rtkit_poll' [-Wmissing-prototypes]
   int apple_rtkit_poll(struct apple_rtkit *rtk)
       ^
   include/linux/soc/apple/rtkit.h:223:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int apple_rtkit_poll(struct apple_rtkit *rtk)
   ^
   static 
   1 warning generated.


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
