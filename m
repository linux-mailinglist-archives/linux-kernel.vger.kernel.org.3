Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6884BFB25
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 15:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbiBVOvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 09:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbiBVOvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 09:51:10 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7566FD95F1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 06:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645541445; x=1677077445;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=r+FEjdh/8iJE9St3C4f8IXq1Wl6HllBikaMYvkKr+kg=;
  b=E9JfcuhIOEkhO7ezjwAxhwbI+i5gk3EjRA+rZo1/JiszPlaMclfrFMs9
   qPj0eCdOK6TRV2HWpaxobEiO8GXJVEQyBQo02p6dH/UeVle/3oH/Yf49W
   beO/Br9JzofXQW4QdO2SDSJ83vf04aaaiuzcMNbzermZIUDM3tvAInvh8
   tB+ipDFni2TTqVR+Gp6bwQnPFD5ccPHRI6g7RY3CZpPC/+NStdf3S0/gB
   I/mSocWio//sDHwuQy960UdEaJ79PMMf+NTCov/F/OgV5AACssbFE7hKd
   bLHu1m/McoqXFTmxNzKTM5bdw5L/AUqnzkbpPV8lL7xrNpWd1COK1gjq3
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="249299430"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="249299430"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 06:50:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="490817402"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 22 Feb 2022 06:50:43 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMWV0-0000K9-O3; Tue, 22 Feb 2022 14:50:42 +0000
Date:   Tue, 22 Feb 2022 22:50:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     John Stultz <john.stultz@linaro.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:google/android/kernel/common/android12-5.4
 4036/9999] drivers/dma-buf/heaps/deferred-free-helper.c:23:19: sparse:
 sparse: symbol 'freelist_waitqueue' was not declared. Should it be static?
Message-ID: <202202222242.FAlsGVrw-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-5.4
head:   c79b9571f583dcad873b5296417a6a8ddbbfe0dd
commit: e3919bfeb0066ab9b5f9765e5610b95672990e64 [4036/9999] ANDROID: dma-buf: system_heap: Add deferred freeing to the system heap
config: x86_64-randconfig-s022-20220221 (https://download.01.org/0day-ci/archive/20220222/202202222242.FAlsGVrw-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/e3919bfeb0066ab9b5f9765e5610b95672990e64
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android12-5.4
        git checkout e3919bfeb0066ab9b5f9765e5610b95672990e64
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/dma-buf/heaps/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/dma-buf/heaps/deferred-free-helper.c:23:19: sparse: sparse: symbol 'freelist_waitqueue' was not declared. Should it be static?
>> drivers/dma-buf/heaps/deferred-free-helper.c:24:20: sparse: sparse: symbol 'freelist_task' was not declared. Should it be static?

vim +/freelist_waitqueue +23 drivers/dma-buf/heaps/deferred-free-helper.c

bd1639945c30298 John Stultz 2020-12-09  20  
bd1639945c30298 John Stultz 2020-12-09  21  static LIST_HEAD(free_list);
bd1639945c30298 John Stultz 2020-12-09  22  static size_t list_nr_pages;
bd1639945c30298 John Stultz 2020-12-09 @23  wait_queue_head_t freelist_waitqueue;
bd1639945c30298 John Stultz 2020-12-09 @24  struct task_struct *freelist_task;
bd1639945c30298 John Stultz 2020-12-09  25  static DEFINE_SPINLOCK(free_list_lock);
bd1639945c30298 John Stultz 2020-12-09  26  

:::::: The code at line 23 was first introduced by commit
:::::: bd1639945c30298e4bea2b611d6b0cd08d3cdd98 ANDROID: dma-buf: heaps: Add deferred-free-helper library code

:::::: TO: John Stultz <john.stultz@linaro.org>
:::::: CC: John Stultz <john.stultz@linaro.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
