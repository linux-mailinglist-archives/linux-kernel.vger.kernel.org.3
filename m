Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1E758BA7E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 11:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbiHGJwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 05:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbiHGJwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 05:52:31 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDC9DEA1
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 02:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659865950; x=1691401950;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZyNnmghNOpKjUsOnNKhgVp74mOBmLxv3F+uaarEaaOM=;
  b=gwwS7imSZVoBaqBLf4iGECI8LJpe+Z4HnRSWDfttdtulXsebDPRlBpWZ
   mZLohL0P/7X54rj4njNhuJfLLq6V3dpArucXYiAaK31nJPWYOpCT9jbJD
   5ch8XpsaBb19wfgU3kn/Uhf8j/cNLjUbK1yT+ZE8rDs2nIbFFipfdKciD
   +BGmhS2KudkQbTLE97xHp/jB0+NrpYpb7duL8uvRUO4+ydnNlJlYHYJ4T
   qZbG1vnH4XhtgDaET1kdRqQt6lDUJH43s30ybBqIRuh1U05WblpzHIClj
   of6JEHy1ZLty3IeODFs3ovuDRh4cNqIbCgv+pi4GQaRNMmviRDcXe7Tz3
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10431"; a="270200880"
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="270200880"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 02:52:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="632520275"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 07 Aug 2022 02:52:29 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKcxQ-000LCr-2F;
        Sun, 07 Aug 2022 09:52:28 +0000
Date:   Sun, 7 Aug 2022 17:51:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:sched/idle 27/37] ld: warning: orphan section
 `.noinstr.text' from `arch/x86/boot/compressed/tdcall.o' being placed in
 section `.noinstr.text'
Message-ID: <202208071702.pBUh72AK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/idle
head:   769b3ef979a1016d45e34b71df278f51ae32271d
commit: 0b1047bab43c93290e31a02365f807247b4e6e11 [27/37] cpuidle,tdx: Make tdx noinstr clean
config: x86_64-randconfig-c001 (https://download.01.org/0day-ci/archive/20220807/202208071702.pBUh72AK-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=0b1047bab43c93290e31a02365f807247b4e6e11
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue sched/idle
        git checkout 0b1047bab43c93290e31a02365f807247b4e6e11
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> ld: warning: orphan section `.noinstr.text' from `arch/x86/boot/compressed/tdcall.o' being placed in section `.noinstr.text'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
