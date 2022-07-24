Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E666257F6BF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 21:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiGXTzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 15:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGXTzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 15:55:23 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C54645B
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 12:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658692522; x=1690228522;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yrxPz4DhxJLOrncZSUwVp7mct2pqGzN+SdqBum4/69g=;
  b=F8WigzRPSLeWoIg5Q/8eku2lUk2jflkbdQVubNq+GHzQYt+Z0lYiZEQ2
   PWMazDt2NAcNvJG0cOQoA1xiklalam3S04qOm8ni7uT9+O11lWev1FJPG
   cX1QAbsbKjGJ5W7ugByPsbIrnCDY+Nst1whQLCq+y4zbfk5Mq14bBk0lF
   qmDbVH9g0pSIT4GzGyOqQ9ERaBJLnNO27bbAO5qRuSpAFIGSaKH+isERG
   HNe+ezFxpovvbRadLBWC1hmDVzeG0DIt1jG53NRb1IChyOAePaIfp18SG
   RmbkBHcUjO4U+fupHejmGp8nBHv9S6Y1oQqBsyfiTTnEoYU3fr9JaAd+P
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="288326244"
X-IronPort-AV: E=Sophos;i="5.93,191,1654585200"; 
   d="scan'208";a="288326244"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 12:55:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,191,1654585200"; 
   d="scan'208";a="741612455"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 24 Jul 2022 12:55:21 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFhhA-0004DJ-26;
        Sun, 24 Jul 2022 19:55:20 +0000
Date:   Mon, 25 Jul 2022 03:54:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jcmvbkbc-xtensa:xtensa-5.19-rochester 12/13]
 arch/xtensa/mm/tlb.c:218:6: warning: no previous prototype for
 'dump_tlb_entry'
Message-ID: <202207250312.HBDnpUhY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jcmvbkbc/linux-xtensa xtensa-5.19-rochester
head:   a9635269505502dd939295e872fd5e6933ee9876
commit: 50e205d64d5f6b858c9b1447e258af4ad0d80b42 [12/13] WIP: xtensa: add dump_tlb
config: xtensa-buildonly-randconfig-r004-20220718 (https://download.01.org/0day-ci/archive/20220725/202207250312.HBDnpUhY-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jcmvbkbc/linux-xtensa/commit/50e205d64d5f6b858c9b1447e258af4ad0d80b42
        git remote add jcmvbkbc-xtensa https://github.com/jcmvbkbc/linux-xtensa
        git fetch --no-tags jcmvbkbc-xtensa xtensa-5.19-rochester
        git checkout 50e205d64d5f6b858c9b1447e258af4ad0d80b42
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash arch/xtensa/mm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/xtensa/mm/tlb.c:218:6: warning: no previous prototype for 'dump_tlb_entry' [-Wmissing-prototypes]
     218 | void dump_tlb_entry(unsigned w, unsigned e, bool dtlb)
         |      ^~~~~~~~~~~~~~
>> arch/xtensa/mm/tlb.c:231:6: warning: no previous prototype for 'dump_tlb' [-Wmissing-prototypes]
     231 | void dump_tlb(void)
         |      ^~~~~~~~
   arch/xtensa/mm/tlb.c:292:6: warning: no previous prototype for 'check_tlb_sanity' [-Wmissing-prototypes]
     292 | void check_tlb_sanity(void)
         |      ^~~~~~~~~~~~~~~~


vim +/dump_tlb_entry +218 arch/xtensa/mm/tlb.c

   217	
 > 218	void dump_tlb_entry(unsigned w, unsigned e, bool dtlb)
   219	{
   220		unsigned tlbidx = w | (e << PAGE_SHIFT);
   221		unsigned r0 = dtlb ?
   222			read_dtlb_virtual(tlbidx) : read_itlb_virtual(tlbidx);
   223		unsigned r1 = dtlb ?
   224			read_dtlb_translation(tlbidx) : read_itlb_translation(tlbidx);
   225		unsigned vpn = (r0 & PAGE_MASK) | (e << PAGE_SHIFT);
   226	
   227		pr_info("%cTLB[%d][%d]: v=%08x, p=%08x, vaddr=%08x\n",
   228			dtlb ? 'D' : 'I', w, e, r0, r1, vpn);
   229	}
   230	
 > 231	void dump_tlb(void)
   232	{
   233		unsigned w, e;
   234	
   235		for (w = 7; w < 9; ++w)
   236			for (e = 0; e < 4; ++e)
   237				dump_tlb_entry(w, e, 1);
   238	}
   239	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
