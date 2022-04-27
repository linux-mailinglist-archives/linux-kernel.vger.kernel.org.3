Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159755113A8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 10:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359494AbiD0Iou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 04:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359487AbiD0Ioq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 04:44:46 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B9E78931
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 01:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651048895; x=1682584895;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2KYyJQnEbagsQnQRMtX0OO46zzH7MwavLjh/O/apyZ4=;
  b=hGJXPL9wwacCwYOkinmCmsCmpcGxnQ7WgP0S1qDhyZjpsHGrQzz0JvF3
   w0YlaLaT3ntwWqoJkT9VfP8CO0+eNr8jX3CF+YmkMT7x6M2UV/qbY2uQU
   VCOM1zhWYjaxIEZYxywnv89TCvC3NmYN5hk13p46HEPqkBXHR6Rtva+aI
   zdMvYZjuD+Mtp+MUpav4LjDolO/1UcGbubC5jmbgyj+1uxBOfXQ36y981
   +UcdpOpKHNltLioNHMt7NbrRVjbva13tLqKtSmHA/eRFXG8y4HwvdGgqT
   H2b4ILf9eE4SJwqYQPHQPFXFfv7JaCQuIMCIuRG+Re+p0+rqAyjz1npfZ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="266025040"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="266025040"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 01:41:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="596181349"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 27 Apr 2022 01:41:33 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njdEr-0004W6-9T;
        Wed, 27 Apr 2022 08:41:33 +0000
Date:   Wed, 27 Apr 2022 16:41:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:x86/cleanups 2/2] vmlinux.o: warning: objtool:
 entry_SYSCALL_compat()+0x0: ANNOTATE_NOENDBR on ENDBR
Message-ID: <202204271620.Bmp7ZcIh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/cleanups
head:   4f9f2ebd17877bac826d864e4a76a22aacf30167
commit: 4f9f2ebd17877bac826d864e4a76a22aacf30167 [2/2] x86,entry: Use PUSH_AND_CLEAR_REGS for compat
config: x86_64-randconfig-r026-20220425 (https://download.01.org/0day-ci/archive/20220427/202204271620.Bmp7ZcIh-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=4f9f2ebd17877bac826d864e4a76a22aacf30167
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue x86/cleanups
        git checkout 4f9f2ebd17877bac826d864e4a76a22aacf30167
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> vmlinux.o: warning: objtool: entry_SYSCALL_compat()+0x0: ANNOTATE_NOENDBR on ENDBR

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
