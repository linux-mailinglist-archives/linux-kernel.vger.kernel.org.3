Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F50F4FA18D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 04:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240555AbiDICLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 22:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiDICK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 22:10:59 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4402DA88
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 19:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649470134; x=1681006134;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=j2HUrVzzHCI51aWpm7y8S2TT7YyUAIa0ZHDObI+VlMk=;
  b=m2Ukdh5wIDzfnpCfcYZW6YncSD61K8/p5wR9rejJ2Axt1voCdiEcQaEF
   0TNwPDhhqwxYHvyNJRjHddbBmr77E/YG+wbUhi+AfY3hfbYI+Qh3wQzKP
   heVcKNfGy3c1uqvZEqXFJLfdwAlGr6wkEi9QEgw3R5S8sg0xgutk2sNYg
   JRY7JeFY7Dhsd3dr8ESnbXb4whaD18FJcV+GIrupWCME7fWjNdJp0cs1p
   lbsl8GxyBc4h1FlA6xyZaASAeJUUF32AfbOXxumi4xL3/ctGdHJArWzkN
   zNLxAb1KWASc5241r9N1HlkAXjms/VKQ37gBglEldKjD9NzJagOyTrfO2
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="259341726"
X-IronPort-AV: E=Sophos;i="5.90,246,1643702400"; 
   d="scan'208";a="259341726"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 19:08:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,246,1643702400"; 
   d="scan'208";a="558035283"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 08 Apr 2022 19:08:53 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nd0Wy-0000o1-QV;
        Sat, 09 Apr 2022 02:08:52 +0000
Date:   Sat, 9 Apr 2022 10:07:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:x86/urgent 3/4] arch/x86/kernel/smpboot.o: warning:
 objtool: start_secondary() falls through to next function
 arch_scale_freq_tick()
Message-ID: <202204091020.5tTNxHao-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/urgent
head:   e3842332d80517488a5253940d10ae4bef4811b7
commit: 19aa14169fc9f44c709615a1e340393d5122419f [3/4] x86,objtool: Mark cpu_startup_entry() __noreturn
config: x86_64-randconfig-a004 (https://download.01.org/0day-ci/archive/20220409/202204091020.5tTNxHao-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=19aa14169fc9f44c709615a1e340393d5122419f
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue x86/urgent
        git checkout 19aa14169fc9f44c709615a1e340393d5122419f
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/smpboot.o: warning: objtool: start_secondary() falls through to next function arch_scale_freq_tick()

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
