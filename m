Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41C1504C43
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 07:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234763AbiDRFZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 01:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbiDRFZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 01:25:51 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DB81835F
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 22:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650259393; x=1681795393;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iQcjTCb6Q+ghre79b3gzNiS2TrP3j5XZAtf78c1/8s4=;
  b=ZA4R1rU0M06FvaXF+AZBuPjykZd86HzVJgXNieetn66evJRetJFs+jy6
   v/NR5B1Fd2NaPhh/KTx3mWddSdx3c98RC+INNCFGxT6Q0NmYfB6M5qLuW
   25VzRqjl3ndlkvzw13Lu5CboCJ6kulfDlZukymi4S3JFeo7KbReH4ZKom
   e8QvRrt1BxTxF4ofVhh/bNxQeUgJI4KhlKUpGBEsUoolao1h0rsK013bE
   tPriajBK5q7t67h1MMOfCM2ifTs3d9D/2RcAsKvgkJ9TESuBcU1tVjA8E
   VAegt7Lezt37VNyWga0fdUzfntvbI0ivuqpCCZO2uEGhuN0Dy/zs1r8K0
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="263211429"
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="263211429"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2022 22:23:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="625180658"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 17 Apr 2022 22:23:11 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngJqx-0004Mp-4s;
        Mon, 18 Apr 2022 05:23:11 +0000
Date:   Mon, 18 Apr 2022 13:22:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Fomichev <fomichev.ru@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-ntb@googlegroups.com,
        linux-kernel@vger.kernel.org, Jon Mason <jdmason@kudzu.us>
Subject: [jonmason-ntb:ntb-next 2/2] drivers/ntb/test/ntb_perf.c:1144:
 undefined reference to `__umoddi3'
Message-ID: <202204181358.WWjsittG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jonmason/ntb ntb-next
head:   10003e852471b1214f4383d79592497b3f4c7b39
commit: 10003e852471b1214f4383d79592497b3f4c7b39 [2/2] ntb_perf: extend with burst/poll/doorbell latency measurement
config: i386-randconfig-c021-20220418 (https://download.01.org/0day-ci/archive/20220418/202204181358.WWjsittG-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/jonmason/ntb/commit/10003e852471b1214f4383d79592497b3f4c7b39
        git remote add jonmason-ntb https://github.com/jonmason/ntb
        git fetch --no-tags jonmason-ntb ntb-next
        git checkout 10003e852471b1214f4383d79592497b3f4c7b39
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: drivers/ntb/test/ntb_perf.o: in function `perf_run_latency':
>> drivers/ntb/test/ntb_perf.c:1144: undefined reference to `__umoddi3'


vim +1144 drivers/ntb/test/ntb_perf.c

  1113	
  1114	static int perf_run_latency(struct perf_thread *pthr)
  1115	{
  1116		struct perf_peer *peer = pthr->perf->test_peer;
  1117		struct ntb_dev *ntb = pthr->perf->ntb;
  1118		void *flt_src;
  1119		void __iomem *flt_dst, *bnd_dst;
  1120		int ret;
  1121		u64 stop_at = ktime_get_real_fast_ns() + lat_time_ms * NSEC_PER_MSEC;
  1122	
  1123		pthr->tries = 0;
  1124		pthr->latency = ktime_get();
  1125		flt_src = pthr->src;
  1126		flt_dst = peer->outbuf;
  1127		bnd_dst = peer->outbuf + peer->outbuf_size;
  1128	
  1129		while (ktime_get_real_fast_ns() < stop_at) {
  1130			ret = perf_copy_chunk(pthr, flt_dst, flt_src, 1, false);
  1131			if (ret) {
  1132				dev_err(&ntb->dev, "%d: Latency testing error %d\n",
  1133					pthr->tidx, ret);
  1134				pthr->latency = ktime_set(0, 0);
  1135				return ret;
  1136			}
  1137	
  1138			pthr->tries++;
  1139			flt_dst++;
  1140			flt_src++;
  1141	
  1142			if (flt_dst >= bnd_dst || flt_dst < peer->outbuf) {
  1143				flt_dst = peer->outbuf;
> 1144				flt_src = pthr->src;
  1145			}
  1146	
  1147			/* Avoid processor soft lock-ups */
  1148			if (!(pthr->tries % RESCHEDULE_RATIO))
  1149				schedule();
  1150		}
  1151	
  1152		/* Stop timer */
  1153		pthr->latency = ktime_sub(ktime_get(), pthr->latency);
  1154	
  1155		if (pthr->tries < LAT_MIN_TRIES) {
  1156			dev_err(&ntb->dev, "%d: Too few steps to measure Latency. "
  1157					"Increase test time\n", pthr->tidx);
  1158			pthr->latency = ktime_set(0, 0);
  1159			return -EINVAL;
  1160		}
  1161	
  1162		dev_dbg(&ntb->dev, "%d: made %llu tries, lasted %llu usecs\n",
  1163			pthr->tidx, pthr->tries, ktime_to_us(pthr->latency));
  1164	
  1165		pthr->latency = ns_to_ktime(ktime_divns(pthr->latency, pthr->tries));
  1166	
  1167		dev_dbg(&ntb->dev, "%d: latency %llu us (%llu ns)\n", pthr->tidx,
  1168			ktime_to_us(pthr->latency), ktime_to_ns(pthr->latency));
  1169	
  1170		return 0;
  1171	}
  1172	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
