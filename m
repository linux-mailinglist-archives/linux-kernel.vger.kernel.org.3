Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A2858B82A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 22:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbiHFUUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 16:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiHFUUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 16:20:10 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D16BCA
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 13:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659817209; x=1691353209;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=seyUIzZ0dBgGXBWMh5GKi2sELzQMRs3ejW7dC2J2Ptk=;
  b=PKZya7I1jdPywEaT9XdgqCemljqgBNeDkjdR37CBrSyn4eqiXvZp3Gp9
   DThyQ0ggtDMpUqPC2RiANd8YRCngIwUTUSTa3vXHaGDPqxbxDUMiu4OxH
   5OVm4w/jt6/KoAO1zFWToiA598gFssR/Gqoj8Rb6E+FHhcqQp6UH0qC61
   mvSSekrGonQHCbkNMXlK/qFhZG6q9yNRlonPHNaf4qf832awU0I2TO0k7
   hvy+XjG6Bghv/bfuPdkIOua1WUZTUOSzLsUg7R/rzBkWu5I7pEYbeXqjO
   xZI+MrJVe8wsP9bUEWpEL6EGO2CgIYA9puZTGq5vJsxpVBdpYt9rGjrj5
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10431"; a="352114210"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="352114210"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 13:20:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="632395025"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 06 Aug 2022 13:20:07 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKQHH-000Keb-0K;
        Sat, 06 Aug 2022 20:20:07 +0000
Date:   Sun, 7 Aug 2022 04:19:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Baisong Zhong <zhongbaisong@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: kernel/sched/rt.c:9:18: warning: 'max_rt_runtime' defined but not
 used
Message-ID: <202208070450.S8sp9M2v-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baisong,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   20cf903a0c407cef19300e5c85a03c82593bde36
commit: 28f152cd0926596e69d412467b11b6fe6fe4e864 sched/rt: fix build error when CONFIG_SYSCTL is disable
date:   4 months ago
config: i386-tinyconfig (https://download.01.org/0day-ci/archive/20220807/202208070450.S8sp9M2v-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=28f152cd0926596e69d412467b11b6fe6fe4e864
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 28f152cd0926596e69d412467b11b6fe6fe4e864
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from kernel/sched/build_policy.c:43:
>> kernel/sched/rt.c:9:18: warning: 'max_rt_runtime' defined but not used [-Wunused-const-variable=]
       9 | static const u64 max_rt_runtime = MAX_BW;
         |                  ^~~~~~~~~~~~~~


vim +/max_rt_runtime +9 kernel/sched/rt.c

d505b8af58912a Huaixin Chang  2020-04-25  @9  static const u64 max_rt_runtime = MAX_BW;
ce0dbbbb30aee6 Clark Williams 2013-02-07  10  

:::::: The code at line 9 was first introduced by commit
:::::: d505b8af58912ae1e1a211fabc9995b19bd40828 sched: Defend cfs and rt bandwidth quota against overflow

:::::: TO: Huaixin Chang <changhuaixin@linux.alibaba.com>
:::::: CC: Peter Zijlstra <peterz@infradead.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
