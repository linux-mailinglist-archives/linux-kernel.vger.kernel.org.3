Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8014E8D74
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 07:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238112AbiC1FJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 01:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238098AbiC1FJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 01:09:01 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162BB46147
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 22:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648444042; x=1679980042;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lZJOERFH7oTW/lODh/xoheOIGWVEYGe5+Emr2y+S6CU=;
  b=PJRgWbm0lblDqvTKcQnO1O8iLxVGMyq137wq2EXZ38gza9IJ3tdfqEL8
   80T/gLvZc5cjtwxrynZmgqpRNkHPfhzADEcrypZIRKDxE1enQmNdwiyGr
   g2QkcJ5iIKBtd5IMPzna6LBVdLKwZAXyqilZm5wvqaFfaAmQZBOX9ga9+
   ztopn2sbiWbbGpt1a+cWf9nj2s+yoHHPM0CWj1iYuhNRzrsj2t7YC7Gc7
   Q/ZwfMeF+8q1R833ieGP9xxRZBewJFxwRt5qunlCYr15F47EPTsMLRGTc
   ozKrllP5Z4FNeZ6q49HzkculKWKgGGJ++hDEU6PC5MxmR31ufbRdfvFAk
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10299"; a="257741628"
X-IronPort-AV: E=Sophos;i="5.90,216,1643702400"; 
   d="scan'208";a="257741628"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2022 22:07:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,216,1643702400"; 
   d="scan'208";a="563254936"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 27 Mar 2022 22:07:20 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nYhb6-0001jn-0n; Mon, 28 Mar 2022 05:07:20 +0000
Date:   Mon, 28 Mar 2022 13:06:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: vmlinux.o: warning: objtool: fixup_exception()+0x38d: unreachable
 instruction
Message-ID: <202203281242.rB7iBQGD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ae085d7f9365de7da27ab5c0d16b12d51ea7fca9
commit: ed53a0d971926e484d86cce617ec02a7ee85c3fe x86/alternative: Use .ibt_endbr_seal to seal indirect calls
date:   13 days ago
config: x86_64-randconfig-r036-20220328 (https://download.01.org/0day-ci/archive/20220328/202203281242.rB7iBQGD-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ed53a0d971926e484d86cce617ec02a7ee85c3fe
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ed53a0d971926e484d86cce617ec02a7ee85c3fe
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> vmlinux.o: warning: objtool: fixup_exception()+0x38d: unreachable instruction

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
