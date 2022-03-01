Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542AF4C7F8A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 01:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbiCAAqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 19:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbiCAAqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 19:46:22 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8922DE3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 16:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646095542; x=1677631542;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=A1M2o61/sQ2bPl3vTO7eHWNh6H9JFtsdHmHIpBkcMBk=;
  b=PxP/4ECqV4amcKiGiLAglqRd6lcWain3d0jbDKeKhWPG6PYUw/W9l9td
   AStkFFiIWAGx6jpbxs+CmRZaUyW7H510i3gkBoYQUD6g5srHXxgCoCLj6
   hJDcsAwCFNdu2IWT9rOKXWEflm+QnX2tphW4lK3ftTx2Nq7cVdE0HoPQd
   RL2Lf6nZDSCAsiIHYo+xmla5AhaS9C5M0E26jSngvSXU+IMEtSw4SFfup
   xmUGjh3yt4xvbkdlgiOxMhGCV7vY5Wag1bU2R8Eq50xVkj70TQYLA0lwo
   ZUUtU7WmGZMMlhXUDcmkha6rhYVYzPGx5s5PlFfp+HplrryibNKVIJuto
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="277686284"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="277686284"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 16:45:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="629832301"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Feb 2022 16:45:38 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOqe1-0007wg-Vr; Tue, 01 Mar 2022 00:45:37 +0000
Date:   Tue, 1 Mar 2022 08:45:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [amir73il:sb_iostats 3/8] fs/nfsd/export.c:337:16: error: implicit
 declaration of function 'percpu_counters_init'; did you mean
 'percpu_counter_init'?
Message-ID: <202203010840.WX3EvHHw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/amir73il/linux sb_iostats
head:   ecfdb413f2105083296e9cb45290eb1f01b0ef5c
commit: ec86002f8d5abb285345a931587f2f554d995825 [3/8] lib/percpu_counter: add helpers for arrays of counters
config: alpha-defconfig (https://download.01.org/0day-ci/archive/20220301/202203010840.WX3EvHHw-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/amir73il/linux/commit/ec86002f8d5abb285345a931587f2f554d995825
        git remote add amir73il https://github.com/amir73il/linux
        git fetch --no-tags amir73il sb_iostats
        git checkout ec86002f8d5abb285345a931587f2f554d995825
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash fs/nfsd/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/nfsd/export.c: In function 'export_stats_init':
>> fs/nfsd/export.c:337:16: error: implicit declaration of function 'percpu_counters_init'; did you mean 'percpu_counter_init'? [-Werror=implicit-function-declaration]
     337 |         return percpu_counters_init(stats->counter, EXP_STATS_COUNTERS_NUM, 0,
         |                ^~~~~~~~~~~~~~~~~~~~
         |                percpu_counter_init
   fs/nfsd/export.c: In function 'export_stats_reset':
>> fs/nfsd/export.c:343:9: error: implicit declaration of function 'percpu_counters_set'; did you mean 'percpu_counter_set'? [-Werror=implicit-function-declaration]
     343 |         percpu_counters_set(stats->counter, EXP_STATS_COUNTERS_NUM, 0);
         |         ^~~~~~~~~~~~~~~~~~~
         |         percpu_counter_set
   fs/nfsd/export.c: In function 'export_stats_destroy':
>> fs/nfsd/export.c:348:9: error: implicit declaration of function 'percpu_counters_destroy'; did you mean 'percpu_counter_destroy'? [-Werror=implicit-function-declaration]
     348 |         percpu_counters_destroy(stats->counter, EXP_STATS_COUNTERS_NUM);
         |         ^~~~~~~~~~~~~~~~~~~~~~~
         |         percpu_counter_destroy
   fs/nfsd/export.c: In function 'exp_rootfh':
   fs/nfsd/export.c:980:34: warning: variable 'inode' set but not used [-Wunused-but-set-variable]
     980 |         struct inode            *inode;
         |                                  ^~~~~
   cc1: some warnings being treated as errors
--
   fs/nfsd/nfscache.c: In function 'nfsd_reply_cache_stats_init':
>> fs/nfsd/nfscache.c:159:16: error: implicit declaration of function 'nfsd_percpu_counters_init'; did you mean 'percpu_counter_init'? [-Werror=implicit-function-declaration]
     159 |         return nfsd_percpu_counters_init(nn->counter, NFSD_NET_COUNTERS_NUM);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~
         |                percpu_counter_init
   fs/nfsd/nfscache.c: In function 'nfsd_reply_cache_stats_destroy':
>> fs/nfsd/nfscache.c:164:9: error: implicit declaration of function 'nfsd_percpu_counters_destroy'; did you mean 'percpu_counter_destroy'? [-Werror=implicit-function-declaration]
     164 |         nfsd_percpu_counters_destroy(nn->counter, NFSD_NET_COUNTERS_NUM);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |         percpu_counter_destroy
   cc1: some warnings being treated as errors
--
   fs/nfsd/stats.c: In function 'nfsd_stat_counters_init':
>> fs/nfsd/stats.c:89:16: error: implicit declaration of function 'percpu_counters_init'; did you mean 'percpu_counter_init'? [-Werror=implicit-function-declaration]
      89 |         return percpu_counters_init(nfsdstats.counter, NFSD_STATS_COUNTERS_NUM,
         |                ^~~~~~~~~~~~~~~~~~~~
         |                percpu_counter_init
   fs/nfsd/stats.c: In function 'nfsd_stat_counters_destroy':
>> fs/nfsd/stats.c:95:9: error: implicit declaration of function 'percpu_counters_destroy'; did you mean 'percpu_counter_destroy'? [-Werror=implicit-function-declaration]
      95 |         percpu_counters_destroy(nfsdstats.counter, NFSD_STATS_COUNTERS_NUM);
         |         ^~~~~~~~~~~~~~~~~~~~~~~
         |         percpu_counter_destroy
   cc1: some warnings being treated as errors


vim +337 fs/nfsd/export.c

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
