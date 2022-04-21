Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F7B5097F1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 08:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385119AbiDUGps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385077AbiDUGop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:44:45 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BA613F89
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650523311; x=1682059311;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6trtt3MfIlUxiA71QF37NgYtdZFf4AqAN87K22KWaJw=;
  b=dd+MNbg31UvVeQcsH542zcNCbvcJk0VjGwmHoGqxNQJqXhIWBByWxH0e
   V/EtwvWLP2SRfwXYH1yZ+uocjZMC68toHUK3rlhoqVxKMPNY/dk9SWPtx
   O8qVZUjPoJj0A+jHErxI9g/fcA9CP0c+sZ1RTTL/JcbBxbLF673xEuhw7
   Dy27Rt7Sg/k/fy256n2ItNo5ovaEQxqaEqIeuzujlZzyal2EkZlUyYKOc
   VBVI0MemBSXui6fgBOsL0R29MTGot4T0y/3KLO7kdaMo9jI6Zv0BqpqYw
   BV7KDGdKZ6k6cdK/K6jkF2kZqPn1zjnfbmL97ztw3W09O5P5faGaFU/Nz
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="244838285"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="244838285"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:41:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="727846588"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 20 Apr 2022 23:41:50 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhQVh-0007yd-To;
        Thu, 21 Apr 2022 06:41:49 +0000
Date:   Thu, 21 Apr 2022 14:41:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 102/2579]
 ./usr/include/asm-generic/shmbuf.h:9:10: fatal error:
 uapi/asm-generic/ipcbuf.h: No such file or directory
Message-ID: <202204210116.WDrjDPoj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   49e1ec6c70a6eb4b7de9250a455b8b63eb42afbe
commit: 303c55f2ed6ecc81b7b19a796a9d3562e99b350c [102/2579] headers/deps: Remove <linux/sem.h> from <linux/sched.h>
config: x86_64-randconfig-a015 (https://download.01.org/0day-ci/archive/20220421/202204210116.WDrjDPoj-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=303c55f2ed6ecc81b7b19a796a9d3562e99b350c
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 303c55f2ed6ecc81b7b19a796a9d3562e99b350c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from ./usr/include/asm/shmbuf.h:6,
                    from ./usr/include/linux/shm.h:26,
                    from <command-line>:
>> ./usr/include/asm-generic/shmbuf.h:9:10: fatal error: uapi/asm-generic/ipcbuf.h: No such file or directory
       9 | #include <uapi/asm-generic/ipcbuf.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
