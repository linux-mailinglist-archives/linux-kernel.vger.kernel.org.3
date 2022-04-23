Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDED50C836
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 10:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbiDWIWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 04:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiDWIWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 04:22:08 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08288192BA
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 01:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650701953; x=1682237953;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AmmEzeN8jAjgUeN1IyCKipY18PlOL0df9x3DLkBbp18=;
  b=FnL/H8nKOk3t7Ep5fDKrD3EuaLGMaR6YQs5zLbLbpkxRMZfbPbWuBgvv
   RAY3QCniPT50EXJqtt+hhTdenUWY8Rccips2B92/DjHmD+GHodfr/0Ajf
   y34qB0oKd312bAwrX35FqpuEtRdTKE1daw9eNqpW/cCPTguEvFYDVab2H
   VZixuX3WmJdTq9gcDb5srXyMzEB8N0x+dluvW1NaBSWUvMptr1e6RjEUS
   8as8Uyr8pPGICisF5xRtpuq2cbOOwHOiy2aWyqziWcfvYsPqSg3fGUFY9
   lgvWCFI9kFmGg9/uN84WuoZzbIWe6XIgWPLhLoy40UWf2qbiDn9GAJN5O
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="263716496"
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="263716496"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 01:19:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="531222828"
Received: from lkp-server01.sh.intel.com (HELO dd58949a6e39) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 23 Apr 2022 01:19:11 -0700
Received: from kbuild by dd58949a6e39 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1niAz0-00004B-AX;
        Sat, 23 Apr 2022 08:19:10 +0000
Date:   Sat, 23 Apr 2022 16:18:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1710/2579]
 ./usr/include/linux/netdevice.h:29:10: fatal error: uapi/linux/if.h: No such
 file or directory
Message-ID: <202204231644.5nTrhYXS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   49e1ec6c70a6eb4b7de9250a455b8b63eb42afbe
commit: b58a26ed571b6e16d664ba93c54c098e2f7af65a [1710/2579] headers/deps: net: Optimize <uapi/linux/netdevice.h>
config: x86_64-randconfig-a015 (https://download.01.org/0day-ci/archive/20220423/202204231644.5nTrhYXS-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=b58a26ed571b6e16d664ba93c54c098e2f7af65a
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout b58a26ed571b6e16d664ba93c54c098e2f7af65a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:
>> ./usr/include/linux/netdevice.h:29:10: fatal error: uapi/linux/if.h: No such file or directory
      29 | #include <uapi/linux/if.h>
         |          ^~~~~~~~~~~~~~~~~
   compilation terminated.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
