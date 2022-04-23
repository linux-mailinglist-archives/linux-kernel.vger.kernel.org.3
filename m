Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5DD950CB21
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 16:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236018AbiDWOUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 10:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbiDWOT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 10:19:57 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BF01D40EF
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 07:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650723421; x=1682259421;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8LZaZOWGKPvcXQU+HeCkcvoNHpFKfU3iv0mmOJNgyQs=;
  b=JQDIN3Mf54atOOhOnk27wqgeFwgBpD+B3x3r56hEr6jr3s7yjeEkKWbw
   FfH9jQBU8k/eCBakxNpR3w+EZl1h1MyCxjDYDnZKZQfpUIrzFLBueTsGO
   HPTZqP/5Sp2NLcckiePJ7X9uz1SyHuy9CjqIBmqeoFqPlUG8yHfT0UeM0
   maC7a3vzuUof+aR6knxV+79FfP4KZbCUNQgIxIICzctNLW2fKkZuf4r7f
   u5qJuFjU0Xqz+63BR1S/8k1eSeldZCBLjvWsBDh70QS6GB0IAZ0NUKafq
   oCV9zDM2xQpJghPqtj8WLOjX9ve3es1xhjork79/ICpYJCSEXc5IbMkIH
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="263747950"
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="263747950"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 07:17:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="649034964"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Apr 2022 07:17:00 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1niGZH-00006S-Cj;
        Sat, 23 Apr 2022 14:16:59 +0000
Date:   Sat, 23 Apr 2022 22:16:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2036/2579]
 ./usr/include/linux/if_addr.h:5:10: fatal error: uapi/linux/types.h: No such
 file or directory
Message-ID: <202204232244.WffuuBH7-lkp@intel.com>
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
commit: b237979a3f807c8ad2b6a305c5f860edf2ee9fc2 [2036/2579] headers/deps: net: Optimize <uapi/linux/if_addr.h> dependencies
config: x86_64-randconfig-a015 (https://download.01.org/0day-ci/archive/20220423/202204232244.WffuuBH7-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=b237979a3f807c8ad2b6a305c5f860edf2ee9fc2
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout b237979a3f807c8ad2b6a305c5f860edf2ee9fc2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:
>> ./usr/include/linux/if_addr.h:5:10: fatal error: uapi/linux/types.h: No such file or directory
       5 | #include <uapi/linux/types.h>
         |          ^~~~~~~~~~~~~~~~~~~~
   compilation terminated.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
