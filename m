Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0779E4C8232
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 05:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbiCAEUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 23:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbiCAEU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 23:20:29 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC0B2C11E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 20:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646108388; x=1677644388;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Wazi11WfZT2uqM2yxa+sX0dRMhOL20+FTicJ5DynnMg=;
  b=MzggzL0OVROx4MRIEMPkfYt9dXuYiDqNsbt7tnKSl4OVKCnNbrvThidA
   x3If39OGZtGUel1jfUi0p4C9j3bi91W3Y2P8ubPDPY6ekAkR/x1OPhuf2
   +J2A4ctw9wfilFXwDVhx9o4KnKfUJ4T2dJmFaXfxZeopH90TRqDHIvaj2
   a8/G0YzV4+i6wG2UF7Q8QY6W1FN81uKEEj0Er9l5Dmx2DINvPCmNLhWa5
   fVX3N/+1bJbCTGsw+f6D7h3z+2TivZ2Hj0JTuemjLbr6M4iykwhO8PRzl
   umj33O1KzwdwPulpWbn/rtP29roqDOi7r7eltZp15PiZSaZrCU+izbgk6
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="251883870"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="251883870"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 20:19:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="639231798"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 28 Feb 2022 20:19:47 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOtzG-00086d-Md; Tue, 01 Mar 2022 04:19:46 +0000
Date:   Tue, 1 Mar 2022 12:19:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [amir73il:sb_iostats 3/8] fs/nfsd/export.c:337:9: error: implicit
 declaration of function 'percpu_counters_init'
Message-ID: <202203011147.TpujEh2h-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/amir73il/linux sb_iostats
head:   ecfdb413f2105083296e9cb45290eb1f01b0ef5c
commit: ec86002f8d5abb285345a931587f2f554d995825 [3/8] lib/percpu_counter: add helpers for arrays of counters
config: arm-versatile_defconfig (https://download.01.org/0day-ci/archive/20220301/202203011147.TpujEh2h-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/amir73il/linux/commit/ec86002f8d5abb285345a931587f2f554d995825
        git remote add amir73il https://github.com/amir73il/linux
        git fetch --no-tags amir73il sb_iostats
        git checkout ec86002f8d5abb285345a931587f2f554d995825
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> fs/nfsd/export.c:337:9: error: implicit declaration of function 'percpu_counters_init' [-Werror,-Wimplicit-function-declaration]
           return percpu_counters_init(stats->counter, EXP_STATS_COUNTERS_NUM, 0,
                  ^
   fs/nfsd/export.c:337:9: note: did you mean 'percpu_counter_init'?
   include/linux/percpu_counter.h:106:19: note: 'percpu_counter_init' declared here
   static inline int percpu_counter_init(struct percpu_counter *fbc, s64 amount,
                     ^
>> fs/nfsd/export.c:343:2: error: implicit declaration of function 'percpu_counters_set' [-Werror,-Wimplicit-function-declaration]
           percpu_counters_set(stats->counter, EXP_STATS_COUNTERS_NUM, 0);
           ^
   fs/nfsd/export.c:343:2: note: did you mean 'percpu_counter_set'?
   include/linux/percpu_counter.h:117:20: note: 'percpu_counter_set' declared here
   static inline void percpu_counter_set(struct percpu_counter *fbc, s64 amount)
                      ^
>> fs/nfsd/export.c:348:2: error: implicit declaration of function 'percpu_counters_destroy' [-Werror,-Wimplicit-function-declaration]
           percpu_counters_destroy(stats->counter, EXP_STATS_COUNTERS_NUM);
           ^
   fs/nfsd/export.c:348:2: note: did you mean 'percpu_counter_destroy'?
   include/linux/percpu_counter.h:113:20: note: 'percpu_counter_destroy' declared here
   static inline void percpu_counter_destroy(struct percpu_counter *fbc)
                      ^
   fs/nfsd/export.c:980:17: warning: variable 'inode' set but not used [-Wunused-but-set-variable]
           struct inode            *inode;
                                    ^
   1 warning and 3 errors generated.
--
>> fs/nfsd/nfscache.c:159:9: error: implicit declaration of function 'nfsd_percpu_counters_init' [-Werror,-Wimplicit-function-declaration]
           return nfsd_percpu_counters_init(nn->counter, NFSD_NET_COUNTERS_NUM);
                  ^
   fs/nfsd/nfscache.c:159:9: note: did you mean 'percpu_counter_init'?
   include/linux/percpu_counter.h:106:19: note: 'percpu_counter_init' declared here
   static inline int percpu_counter_init(struct percpu_counter *fbc, s64 amount,
                     ^
>> fs/nfsd/nfscache.c:164:2: error: implicit declaration of function 'nfsd_percpu_counters_destroy' [-Werror,-Wimplicit-function-declaration]
           nfsd_percpu_counters_destroy(nn->counter, NFSD_NET_COUNTERS_NUM);
           ^
   fs/nfsd/nfscache.c:164:2: note: did you mean 'percpu_counter_destroy'?
   include/linux/percpu_counter.h:113:20: note: 'percpu_counter_destroy' declared here
   static inline void percpu_counter_destroy(struct percpu_counter *fbc)
                      ^
   2 errors generated.
--
>> fs/nfsd/stats.c:89:9: error: implicit declaration of function 'percpu_counters_init' [-Werror,-Wimplicit-function-declaration]
           return percpu_counters_init(nfsdstats.counter, NFSD_STATS_COUNTERS_NUM,
                  ^
   fs/nfsd/stats.c:89:9: note: did you mean 'percpu_counter_init'?
   include/linux/percpu_counter.h:106:19: note: 'percpu_counter_init' declared here
   static inline int percpu_counter_init(struct percpu_counter *fbc, s64 amount,
                     ^
>> fs/nfsd/stats.c:95:2: error: implicit declaration of function 'percpu_counters_destroy' [-Werror,-Wimplicit-function-declaration]
           percpu_counters_destroy(nfsdstats.counter, NFSD_STATS_COUNTERS_NUM);
           ^
   fs/nfsd/stats.c:95:2: note: did you mean 'percpu_counter_destroy'?
   include/linux/percpu_counter.h:113:20: note: 'percpu_counter_destroy' declared here
   static inline void percpu_counter_destroy(struct percpu_counter *fbc)
                      ^
   2 errors generated.


vim +/percpu_counters_init +337 fs/nfsd/export.c

   333	
   334	static int export_stats_init(struct export_stats *stats)
   335	{
   336		stats->start_time = ktime_get_seconds();
 > 337		return percpu_counters_init(stats->counter, EXP_STATS_COUNTERS_NUM, 0,
   338					    GFP_KERNEL);
   339	}
   340	
   341	static void export_stats_reset(struct export_stats *stats)
   342	{
 > 343		percpu_counters_set(stats->counter, EXP_STATS_COUNTERS_NUM, 0);
   344	}
   345	
   346	static void export_stats_destroy(struct export_stats *stats)
   347	{
 > 348		percpu_counters_destroy(stats->counter, EXP_STATS_COUNTERS_NUM);
   349	}
   350	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
