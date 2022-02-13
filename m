Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0834B3B25
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 12:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbiBMLbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 06:31:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235491AbiBMLa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 06:30:57 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43D95B3FD
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 03:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644751852; x=1676287852;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RnzVlUtfTW9FBqEvEPVHHM+2qy8cCICbEO1yHb+x50s=;
  b=HVyQ4cjDi7RfdEUUCVr9udAbaVsTmv92TtZvD3nSYwyUGOJKHdqhpMb1
   dBf7/YF5kva8EgoJCnvLhRzQbtUDpPpaH0lWPMWxBL2pLHr0U2d+at/W1
   Mg03/OMNv4i396t8UDvm46a3yHfeNkq8netZmdVhJcCV9XyZMFMmVfj0S
   nU0hxuEIJqTdle+h7bKzVhZve4bw4pEf5M6CuVInCN8AfjGQnXmOujf80
   QGptNjaW7sNnxmFMW05LIF6oSJH6KVh22wiqbNNJcivZTg8J/lr0xF940
   T9rN99yc6U+3L4skOIj9mqoslqZsVZ/cIgFma6t6KAhc3Dj9NroyYmHEJ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10256"; a="248772840"
X-IronPort-AV: E=Sophos;i="5.88,365,1635231600"; 
   d="scan'208";a="248772840"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 03:30:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,365,1635231600"; 
   d="scan'208";a="623637840"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Feb 2022 03:30:50 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJD5e-0007QW-Aq; Sun, 13 Feb 2022 11:30:50 +0000
Date:   Sun, 13 Feb 2022 19:30:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     zhanglianjie <zhanglianjie@uniontech.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [hnaz-mm:master 92/304] mm/page-writeback.c:93:28: error:
 'dirty_bytes_min' defined but not used
Message-ID: <202202131948.o0qQogUI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/hnaz/linux-mm master
head:   31e523f69aa14a1f4ba298c63034d8dc62c4aae7
commit: d2d94dec619e0ab7f6805f3bc6e7932d71bfe765 [92/304] mm: move page-writeback sysctls to their own file
config: powerpc64-randconfig-s032-20220213 (https://download.01.org/0day-ci/archive/20220213/202202131948.o0qQogUI-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/hnaz/linux-mm/commit/d2d94dec619e0ab7f6805f3bc6e7932d71bfe765
        git remote add hnaz-mm https://github.com/hnaz/linux-mm
        git fetch --no-tags hnaz-mm master
        git checkout d2d94dec619e0ab7f6805f3bc6e7932d71bfe765
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mm/page-writeback.c:2002:12: error: 'dirty_writeback_centisecs_handler' defined but not used [-Werror=unused-function]
    2002 | static int dirty_writeback_centisecs_handler(struct ctl_table *table, int write,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   mm/page-writeback.c:545:12: error: 'dirty_bytes_handler' defined but not used [-Werror=unused-function]
     545 | static int dirty_bytes_handler(struct ctl_table *table, int write,
         |            ^~~~~~~~~~~~~~~~~~~
   mm/page-writeback.c:531:12: error: 'dirty_ratio_handler' defined but not used [-Werror=unused-function]
     531 | static int dirty_ratio_handler(struct ctl_table *table, int write, void *buffer,
         |            ^~~~~~~~~~~~~~~~~~~
   mm/page-writeback.c:520:12: error: 'dirty_background_bytes_handler' defined but not used [-Werror=unused-function]
     520 | static int dirty_background_bytes_handler(struct ctl_table *table, int write,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   mm/page-writeback.c:509:12: error: 'dirty_background_ratio_handler' defined but not used [-Werror=unused-function]
     509 | static int dirty_background_ratio_handler(struct ctl_table *table, int write,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> mm/page-writeback.c:93:28: error: 'dirty_bytes_min' defined but not used [-Werror=unused-const-variable=]
      93 | static const unsigned long dirty_bytes_min = 2 * PAGE_SIZE;
         |                            ^~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/dirty_bytes_min +93 mm/page-writeback.c

    91	
    92	/* this is needed for the proc_doulongvec_minmax of vm_dirty_bytes */
  > 93	static const unsigned long dirty_bytes_min = 2 * PAGE_SIZE;
    94	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
