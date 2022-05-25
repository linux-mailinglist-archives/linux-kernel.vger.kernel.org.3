Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01709534479
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 21:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbiEYTpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 15:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346309AbiEYTpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 15:45:11 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9857236E3D
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 12:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653507909; x=1685043909;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UeFYYZYoLiE7jCNi16qt8Zlhpepa1Hw60nMZduO5Oq0=;
  b=KQUmEUho89VTYMjOvKIjSHSABfVbxV9LrjPQGKN5Mb11ksTc9stTsT8o
   rD+OwuUQfUlyhg+sxFeAt47LRl/+LjRJk+CMY45lpQOm/HKAV29CAr7Q8
   5AhbOp817cc1XrRn6p5PIC92ToS0eC1eKd9fTumX9/35FFRH8AcBlHTfb
   sQzLjNs0FnmOSVLaleT4i9blDyzD6Odr1//qb4RO5M/UMjPvPUEHDm7T8
   Hqg9J3jBBlVIFKHRMrwq6najlMHdQqDzwNIPuQtJrzl8DjhImfF3kK5FR
   NnUa4jIMBEq8mouY0+HLvq1HEroZPIGbDJ4NmZv13g0YrUyIjLzZGdu50
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="253791127"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="253791127"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 12:45:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="527011559"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 25 May 2022 12:45:07 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntwwM-0003Gm-Mf;
        Wed, 25 May 2022 19:45:06 +0000
Date:   Thu, 26 May 2022 03:45:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:paulmck/linux-rcu/for-peterz.2022.05.25a 54/62]
 ERROR: modpost: "rcu_trc_cmpxchg_need_qs" [kernel/torture.ko] undefined!
Message-ID: <202205260344.sqrr1y1S-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/for-peterz.2022.05.25a
head:   4b2a6af8fe31e85fb2754b8da5072041a4dea471
commit: 0f7cb0c989a98c0d1e758e265021514bc6b595c0 [54/62] rcu-tasks: Atomically update .b.need_qs to obviate count
config: x86_64-randconfig-a011 (https://download.01.org/0day-ci/archive/20220526/202205260344.sqrr1y1S-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/0f7cb0c989a98c0d1e758e265021514bc6b595c0
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/for-peterz.2022.05.25a
        git checkout 0f7cb0c989a98c0d1e758e265021514bc6b595c0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>, old ones prefixed by <<):

In file included from kernel/rcu/update.c:606:
kernel/rcu/tasks.h: In function 'rcu_trc_cmpxchg_need_qs':
>> kernel/rcu/tasks.h:1233:27: warning: variable 'trs_new' set but not used [-Wunused-but-set-variable]
1233 |         union rcu_special trs_new = trs_old;
|                           ^~~~~~~
--
>> ERROR: modpost: "rcu_trc_cmpxchg_need_qs" [kernel/torture.ko] undefined!
>> ERROR: modpost: "rcu_trc_cmpxchg_need_qs" [kernel/rcu/rcuscale.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
