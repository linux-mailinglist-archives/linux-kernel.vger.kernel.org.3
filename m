Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAFF4C5845
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 22:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiBZV2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 16:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiBZV2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 16:28:49 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42BD237D2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 13:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645910891; x=1677446891;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=N9nA17ijHRj3hlT/p8PL1tadHcjP62H9Omt0xTpKmPs=;
  b=CqUmD+UrgufI4ixmGflyYLvBhgmiGutULDzoRHXfUQwQOqJrQekTr4Ch
   S8LJhxgOQjtqYj4tXP/xTw42B9h1GUT6rogqeFKBlowxD9C1KrAyXYwrq
   nbbTqRt55LhKo6VXnt7yWggnxYR1d/7OYzn8FVGrPjIZnSzoeKTtL6FuT
   6vqj69GObrRn5ZlqhDPB6Wy6nNIU4tMm/fTHfcRNGDWkkAYF83j57D1yK
   Mdby15TsGOLUY+CsRhrhxH3Tflpy3VBlS/7tLC6aGGade932zpmTVBzfJ
   VRdWulVEj0hhtDk0+46V3eorXUGVSkWorCG6TkcRBvK04aXew03d++bgr
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10270"; a="232656257"
X-IronPort-AV: E=Sophos;i="5.90,140,1643702400"; 
   d="scan'208";a="232656257"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2022 13:28:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,140,1643702400"; 
   d="scan'208";a="640484770"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 26 Feb 2022 13:28:09 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nO4bo-0005yP-Bn; Sat, 26 Feb 2022 21:28:08 +0000
Date:   Sun, 27 Feb 2022 05:27:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: security/smack/smack_lsm.c:2525:27: sparse: sparse: incorrect type
 in assignment (different base types)
Message-ID: <202202270517.RBXhVEJE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9137eda53752ef73148e42b0d7640a00f1bc96b1
commit: d991bb1c8da842a2a0b9dc83b1005e655783f861 include/linux/compiler-gcc.h: sparse can do constant folding of __builtin_bswap*()
date:   10 months ago
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20220227/202202270517.RBXhVEJE-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d991bb1c8da842a2a0b9dc83b1005e655783f861
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d991bb1c8da842a2a0b9dc83b1005e655783f861
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/block/drbd/ drivers/net/ethernet/packetengines/ drivers/net/wireless/ath/ath6kl/ drivers/net/wireless/mediatek/mt76/mt7915/ drivers/net/wwan/ drivers/scsi/bnx2fc/ drivers/scsi/qedi/ drivers/staging/ security/smack/ sound/soc/intel/skylake/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   security/smack/smack_lsm.c:1778:61: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct cred const *cred @@     got struct cred const [noderef] __rcu *cred @@
   security/smack/smack_lsm.c:1778:61: sparse:     expected struct cred const *cred
   security/smack/smack_lsm.c:1778:61: sparse:     got struct cred const [noderef] __rcu *cred
>> security/smack/smack_lsm.c:2525:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [usertype] dport @@     got unsigned short [usertype] @@
   security/smack/smack_lsm.c:2525:27: sparse:     expected restricted __be16 [usertype] dport
   security/smack/smack_lsm.c:2525:27: sparse:     got unsigned short [usertype]
   security/smack/smack_lsm.c:4901:30: sparse: sparse: cast removes address space '__rcu' of expression
--
   drivers/block/drbd/drbd_receiver.c:1169:28: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:1173:27: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:1174:28: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:1179:27: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:1180:28: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:822:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:822:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:822:14: sparse:    struct net_conf *
   drivers/block/drbd/drbd_receiver.c:877:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:877:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:877:14: sparse:    struct net_conf *
   drivers/block/drbd/drbd_receiver.c:1042:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:1042:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:1042:14: sparse:    struct net_conf *
   drivers/block/drbd/drbd_receiver.c:1434:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:1434:14: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:1434:14: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_receiver.c:1588:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:1588:14: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:1588:14: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_receiver.c:1893:22: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:1897:22: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:1909:22: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:2157:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:2191:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:2405:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:2405:22: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:2405:22: sparse:    struct net_conf *
   drivers/block/drbd/drbd_receiver.c:2415:27: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:2415:27: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:2415:27: sparse:    struct net_conf *
   drivers/block/drbd/drbd_receiver.c:2594:24: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:2622:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:2633:20: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:2666:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:2666:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:2666:14: sparse:    struct net_conf *
   drivers/block/drbd/drbd_receiver.c:2798:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:2798:22: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:2798:22: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_receiver.c:2854:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:2855:18: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:3066:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:3066:23: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:3066:23: sparse:    struct net_conf *
   drivers/block/drbd/drbd_receiver.c:3142:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:3142:23: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:3142:23: sparse:    struct net_conf *
   drivers/block/drbd/drbd_receiver.c:3199:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:3199:23: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:3199:23: sparse:    struct net_conf *
   drivers/block/drbd/drbd_receiver.c:3545:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:3545:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:3545:14: sparse:    struct net_conf *
   drivers/block/drbd/drbd_receiver.c:3677:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:3678:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:3679:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:3680:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:3681:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:3682:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:3703:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:3703:22: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:3703:22: sparse:    struct net_conf *
   drivers/block/drbd/drbd_receiver.c:3789:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:3789:9: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:3789:9: sparse:    struct net_conf *
   drivers/block/drbd/drbd_receiver.c:3946:46: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:4005:55: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:4006:57: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:4007:56: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:4008:53: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:4044:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:4044:25: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:4044:25: sparse:    struct net_conf *
   drivers/block/drbd/drbd_receiver.c:4049:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:4049:17: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:4049:17: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_receiver.c:4055:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:4055:17: sparse:    struct fifo_buffer [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:4055:17: sparse:    struct fifo_buffer *
   drivers/block/drbd/drbd_receiver.c:4122:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:4123:19: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:4124:19: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:4132:28: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:4132:28: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:4132:28: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_receiver.c:4174:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:4174:25: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:4174:25: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_receiver.c:4297:29: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:4397:18: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:4398:17: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:4423:18: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:4424:17: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:4456:24: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:4660:52: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:4987:9: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:4987:9: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5005:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5006:16: sparse: sparse: cast to restricted __be32
>> drivers/block/drbd/drbd_receiver.c:5315:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] protocol_min @@     got restricted __be32 [usertype] @@
>> drivers/block/drbd/drbd_receiver.c:5316:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] protocol_max @@     got restricted __be32 [usertype] @@
>> drivers/block/drbd/drbd_receiver.c:5317:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] feature_flags @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_receiver.c:5626:23: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5645:23: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5690:27: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5691:23: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5700:38: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5742:27: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5743:23: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5751:38: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5788:27: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5789:20: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5797:38: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5824:27: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5831:38: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5833:9: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5833:9: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5833:9: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5833:9: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5854:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5855:16: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5857:38: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5884:44: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5916:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5917:16: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5919:38: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5921:13: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5970:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:5970:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:5970:14: sparse:    struct net_conf *
   drivers/block/drbd/drbd_receiver.c:6060:37: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:6060:37: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:6060:37: sparse:    struct net_conf *
   drivers/block/drbd/drbd_receiver.c:6157:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:6157:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:6157:14: sparse:    struct net_conf *
--
   drivers/block/drbd/drbd_main.c:1393:31: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:1406:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sector @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1406:19: sparse:     expected unsigned long long [usertype] sector
   drivers/block/drbd/drbd_main.c:1406:19: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:1407:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] blksize @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1407:20: sparse:     expected unsigned int [usertype] blksize
   drivers/block/drbd/drbd_main.c:1407:20: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:1422:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sector @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1422:19: sparse:     expected unsigned long long [usertype] sector
   drivers/block/drbd/drbd_main.c:1422:19: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:1424:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] blksize @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1424:20: sparse:     expected unsigned int [usertype] blksize
   drivers/block/drbd/drbd_main.c:1424:20: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:1440:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sector @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1440:19: sparse:     expected unsigned long long [usertype] sector
   drivers/block/drbd/drbd_main.c:1440:19: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:1442:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] blksize @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1442:20: sparse:     expected unsigned int [usertype] blksize
   drivers/block/drbd/drbd_main.c:1442:20: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:1455:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sector @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1455:19: sparse:     expected unsigned long long [usertype] sector
   drivers/block/drbd/drbd_main.c:1455:19: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:1457:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] blksize @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1457:20: sparse:     expected unsigned int [usertype] blksize
   drivers/block/drbd/drbd_main.c:1457:20: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:1680:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sector @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1680:19: sparse:     expected unsigned long long [usertype] sector
   drivers/block/drbd/drbd_main.c:1680:19: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:1682:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] seq_num @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1682:20: sparse:     expected unsigned int [usertype] seq_num
   drivers/block/drbd/drbd_main.c:1682:20: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:1696:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] dp_flags @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1696:21: sparse:     expected unsigned int [usertype] dp_flags
   drivers/block/drbd/drbd_main.c:1696:21: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:1701:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] size @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1701:25: sparse:     expected unsigned int [usertype] size
   drivers/block/drbd/drbd_main.c:1701:25: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:1711:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] size @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1711:29: sparse:     expected unsigned int [usertype] size
   drivers/block/drbd/drbd_main.c:1711:29: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:1787:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sector @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1787:19: sparse:     expected unsigned long long [usertype] sector
   drivers/block/drbd/drbd_main.c:1787:19: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:1810:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sector @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1810:19: sparse:     expected unsigned long long [usertype] sector
   drivers/block/drbd/drbd_main.c:1810:19: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:1811:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] blksize @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1811:20: sparse:     expected unsigned int [usertype] blksize
   drivers/block/drbd/drbd_main.c:1811:20: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:1847:40: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_main.c:1847:40: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_main.c:1847:40: sparse:    struct net_conf *
   drivers/block/drbd/drbd_main.c:3020:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] la_size_sect @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:3020:30: sparse:     expected unsigned long long [usertype] la_size_sect
   drivers/block/drbd/drbd_main.c:3020:30: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:3022:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:3022:33: sparse:     expected unsigned long long
   drivers/block/drbd/drbd_main.c:3022:33: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:3023:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] flags @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:3023:23: sparse:     expected unsigned int [usertype] flags
   drivers/block/drbd/drbd_main.c:3023:23: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:3024:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] magic @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:3024:23: sparse:     expected unsigned int [usertype] magic
   drivers/block/drbd/drbd_main.c:3024:23: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:3026:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] md_size_sect @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:3026:31: sparse:     expected unsigned int [usertype] md_size_sect
   drivers/block/drbd/drbd_main.c:3026:31: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:3027:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] al_offset @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:3027:31: sparse:     expected unsigned int [usertype] al_offset
   drivers/block/drbd/drbd_main.c:3027:31: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:3028:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] al_nr_extents @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:3028:31: sparse:     expected unsigned int [usertype] al_nr_extents
   drivers/block/drbd/drbd_main.c:3028:31: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:3029:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] bm_bytes_per_bit @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:3029:34: sparse:     expected unsigned int [usertype] bm_bytes_per_bit
   drivers/block/drbd/drbd_main.c:3029:34: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:3030:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] device_uuid @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:3030:29: sparse:     expected unsigned long long [usertype] device_uuid
   drivers/block/drbd/drbd_main.c:3030:29: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:3032:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] bm_offset @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:3032:27: sparse:     expected unsigned int [usertype] bm_offset
   drivers/block/drbd/drbd_main.c:3032:27: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:3033:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] la_peer_max_bio_size @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:3033:38: sparse:     expected unsigned int [usertype] la_peer_max_bio_size
   drivers/block/drbd/drbd_main.c:3033:38: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:3035:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] al_stripes @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:3035:28: sparse:     expected unsigned int [usertype] al_stripes
   drivers/block/drbd/drbd_main.c:3035:28: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:3036:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] al_stripe_size_4k @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:3036:35: sparse:     expected unsigned int [usertype] al_stripe_size_4k
   drivers/block/drbd/drbd_main.c:3036:35: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:3089:26: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3090:33: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3252:17: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3253:17: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3271:13: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3272:17: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3272:17: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3272:17: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3272:17: sparse: sparse: cast to restricted __be32
>> drivers/block/drbd/drbd_main.c:3279:33: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_main.c:3281:36: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_main.c:3282:26: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3283:32: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_main.c:3285:33: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3286:30: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3287:30: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3294:13: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3295:17: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3295:17: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3295:17: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3295:17: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3299:13: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3300:17: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3300:17: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3300:17: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3300:17: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3310:24: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3693:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_main.c:3693:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_main.c:3693:14: sparse:    struct net_conf *
   drivers/block/drbd/drbd_main.c:860:9: sparse: sparse: context imbalance in 'drbd_print_uuids' - different lock contexts for basic block
   drivers/block/drbd/drbd_main.c: note: in included file:
   drivers/block/drbd/drbd_int.h:2141:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_int.h:2141:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_int.h:2141:14: sparse:    struct net_conf *
   drivers/block/drbd/drbd_int.h:2141:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_int.h:2141:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_int.h:2141:14: sparse:    struct net_conf *
   drivers/block/drbd/drbd_int.h:2141:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_int.h:2141:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_int.h:2141:14: sparse:    struct net_conf *
   drivers/block/drbd/drbd_int.h:1722:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_int.h:1722:14: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_int.h:1722:14: sparse:    struct disk_conf *
--
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:504:32: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] context_id
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:504:32: sparse:     got unsigned int [usertype] context_id
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:505:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] conn_id @@     got unsigned int [usertype] fcoe_conn_id @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:505:29: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] conn_id
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:505:29: sparse:     got unsigned int [usertype] fcoe_conn_id
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:613:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] fr_crc @@     got restricted __le32 [usertype] @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:613:28: sparse:     expected unsigned int [usertype] fr_crc
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:613:28: sparse:     got restricted __le32 [usertype]
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:695:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] xid @@     got restricted __le16 [usertype] ox_id @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:695:21: sparse:     expected unsigned short [usertype] xid
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:695:21: sparse:     got restricted __le16 [usertype] ox_id
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:727:27: sparse: sparse: cast from restricted __le32
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:728:26: sparse: sparse: cast from restricted __le32
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:807:23: sparse: sparse: cast from restricted __le16
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:807:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] xid @@     got restricted __be16 [usertype] @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:807:21: sparse:     expected unsigned short [usertype] xid
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:807:21: sparse:     got restricted __be16 [usertype]
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:821:27: sparse: sparse: cast from restricted __le32
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:822:26: sparse: sparse: cast from restricted __le32
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:886:45: sparse: sparse: restricted __le16 degrades to integer
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:963:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] doorbell_cq_cons @@     got int @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:963:33: sparse:     expected restricted __le16 [usertype] doorbell_cq_cons
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:963:33: sparse:     got int
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:966:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int val @@     got restricted __le32 [usertype] @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:966:16: sparse:     expected unsigned int val
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:966:16: sparse:     got restricted __le32 [usertype]
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1019:43: sparse: sparse: restricted __le16 degrades to integer
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1089:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] wqe @@     got restricted __le16 [usertype] wqe @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1089:22: sparse:     expected unsigned short [usertype] wqe
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1089:22: sparse:     got restricted __le16 [usertype] wqe
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1253:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] conn_id @@     got restricted __le32 [usertype] fcoe_conn_id @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1253:17: sparse:     expected unsigned int [usertype] conn_id
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1253:17: sparse:     got restricted __le32 [usertype] fcoe_conn_id
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1369:53: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int [usertype] err_code @@     got restricted __le32 [usertype] completion_status @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1369:53: sparse:     expected unsigned int [usertype] err_code
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1369:53: sparse:     got restricted __le32 [usertype] completion_status
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1420:18: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] wqe @@     got int @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1420:18: sparse:     expected restricted __le16 [usertype] wqe
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1420:18: sparse:     got int
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1421:18: sparse: sparse: invalid assignment: |=
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1421:18: sparse:    left side has type restricted __le16
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1421:18: sparse:    right side has type int
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1439:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int val @@     got restricted __le32 [usertype] @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1439:16: sparse:     expected unsigned int val
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1439:16: sparse:     got restricted __le32 [usertype]
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1522:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] init_flags @@     got unsigned int @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1522:46: sparse:     expected restricted __le32 [usertype] init_flags
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1522:46: sparse:     got unsigned int
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1524:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] init_flags @@     got unsigned int @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1524:46: sparse:     expected restricted __le32 [usertype] init_flags
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1524:46: sparse:     got unsigned int
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1527:63: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] cleaned_task_id @@     got unsigned short [usertype] orig_xid @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1527:63: sparse:     expected restricted __le16 [usertype] cleaned_task_id
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1527:63: sparse:     got unsigned short [usertype] orig_xid
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1530:69: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] rolled_tx_data_offset @@     got unsigned int [usertype] offset @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1530:69: sparse:     expected restricted __le32 [usertype] rolled_tx_data_offset
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1530:69: sparse:     got unsigned int [usertype] offset
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1536:35: sparse: sparse: restricted __le16 degrades to integer
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1538:24: sparse: sparse: invalid assignment: -=
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1538:24: sparse:    left side has type unsigned int
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1538:24: sparse:    right side has type restricted __le16
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1543:69: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] lo @@     got unsigned int [usertype] @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1543:69: sparse:     expected restricted __le32 [usertype] lo
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1543:69: sparse:     got unsigned int [usertype]
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1545:69: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] hi @@     got unsigned int [usertype] @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1545:69: sparse:     expected restricted __le32 [usertype] hi
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1545:69: sparse:     got unsigned int [usertype]
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1549:65: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] cur_sge_off @@     got unsigned int [usertype] offset @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1549:65: sparse:     expected restricted __le16 [usertype] cur_sge_off
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1549:65: sparse:     got unsigned int [usertype] offset
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1556:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] lo @@     got unsigned int [usertype] @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1556:46: sparse:     expected restricted __le32 [usertype] lo
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1556:46: sparse:     got unsigned int [usertype]
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1557:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] hi @@     got unsigned int [usertype] @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1557:46: sparse:     expected restricted __le32 [usertype] hi
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1557:46: sparse:     got unsigned int [usertype]
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1559:42: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] cur_sge_off @@     got unsigned int [usertype] offset @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1559:42: sparse:     expected restricted __le16 [usertype] cur_sge_off
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1559:42: sparse:     got unsigned int [usertype] offset
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1564:55: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] low_exp_ro @@     got unsigned int [usertype] orig_offset @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1564:55: sparse:     expected restricted __le32 [usertype] low_exp_ro
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1564:55: sparse:     got unsigned int [usertype] orig_offset
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1565:56: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] high_exp_ro @@     got unsigned int [usertype] orig_offset @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1565:56: sparse:     expected restricted __le32 [usertype] high_exp_ro
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1565:56: sparse:     got unsigned int [usertype] orig_offset
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1592:63: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] cleaned_task_id @@     got unsigned short [usertype] orig_xid @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1592:63: sparse:     expected restricted __le16 [usertype] cleaned_task_id
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1592:63: sparse:     got unsigned short [usertype] orig_xid
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1600:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] init_flags @@     got unsigned int @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1600:46: sparse:     expected restricted __le32 [usertype] init_flags
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1600:46: sparse:     got unsigned int
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1602:42: sparse: sparse: invalid assignment: |=
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1602:42: sparse:    left side has type restricted __le16
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1602:42: sparse:    right side has type int
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1638:69: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] lo @@     got unsigned int [usertype] @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1638:69: sparse:     expected restricted __le32 [usertype] lo
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1638:69: sparse:     got unsigned int [usertype]
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1640:69: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] hi @@     got unsigned int [usertype] @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1640:69: sparse:     expected restricted __le32 [usertype] hi
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1640:69: sparse:     got unsigned int [usertype]
>> drivers/scsi/bnx2fc/bnx2fc_hwi.c:1665:47: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] data_2_trns @@     got unsigned int [usertype] data_xfer_len @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1665:47: sparse:     expected restricted __le32 [usertype] data_2_trns
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1665:47: sparse:     got unsigned int [usertype] data_xfer_len
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1668:42: sparse: sparse: invalid assignment: |=
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1668:42: sparse:    left side has type restricted __le16
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1668:42: sparse:    right side has type int
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1672:46: sparse: sparse: too many warnings
--
   drivers/scsi/qedi/qedi_fw.c:1514:30: sparse: sparse: cast to restricted itt_t
   drivers/scsi/qedi/qedi_fw.c:1514:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [usertype] itt @@     got unsigned int [usertype] @@
   drivers/scsi/qedi/qedi_fw.c:1514:28: sparse:     expected restricted __le32 [addressable] [usertype] itt
   drivers/scsi/qedi/qedi_fw.c:1514:28: sparse:     got unsigned int [usertype]
>> drivers/scsi/qedi/qedi_fw.c:1515:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [usertype] cmd_sn @@     got unsigned int [usertype] @@
   drivers/scsi/qedi/qedi_fw.c:1515:31: sparse:     expected restricted __le32 [addressable] [usertype] cmd_sn
   drivers/scsi/qedi/qedi_fw.c:1515:31: sparse:     got unsigned int [usertype]
   drivers/scsi/qedi/qedi_fw.c:1518:33: sparse: sparse: cast to restricted __be32
>> drivers/scsi/qedi/qedi_fw.c:1518:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [usertype] lo @@     got unsigned int [usertype] @@
   drivers/scsi/qedi/qedi_fw.c:1518:31: sparse:     expected restricted __le32 [addressable] [usertype] lo
   drivers/scsi/qedi/qedi_fw.c:1518:31: sparse:     got unsigned int [usertype]
   drivers/scsi/qedi/qedi_fw.c:1519:33: sparse: sparse: cast to restricted __be32
>> drivers/scsi/qedi/qedi_fw.c:1519:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [usertype] hi @@     got unsigned int [usertype] @@
   drivers/scsi/qedi/qedi_fw.c:1519:31: sparse:     expected restricted __le32 [addressable] [usertype] hi
   drivers/scsi/qedi/qedi_fw.c:1519:31: sparse:     got unsigned int [usertype]
   drivers/scsi/qedi/qedi_fw.c:1530:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [usertype] rtt @@     got unsigned int [usertype] @@
   drivers/scsi/qedi/qedi_fw.c:1530:36: sparse:     expected restricted __le32 [addressable] [usertype] rtt
   drivers/scsi/qedi/qedi_fw.c:1530:36: sparse:     got unsigned int [usertype]
   drivers/scsi/qedi/qedi_fw.c:1534:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [usertype] rtt @@     got unsigned int @@
   drivers/scsi/qedi/qedi_fw.c:1534:36: sparse:     expected restricted __le32 [addressable] [usertype] rtt
   drivers/scsi/qedi/qedi_fw.c:1534:36: sparse:     got unsigned int
   drivers/scsi/qedi/qedi_fw.c:1539:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] hdr_second_dword @@     got int @@
   drivers/scsi/qedi/qedi_fw.c:1539:41: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] hdr_second_dword
   drivers/scsi/qedi/qedi_fw.c:1539:41: sparse:     got int
>> drivers/scsi/qedi/qedi_fw.c:1540:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] ref_cmd_sn @@     got unsigned int [usertype] @@
   drivers/scsi/qedi/qedi_fw.c:1540:35: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] ref_cmd_sn
   drivers/scsi/qedi/qedi_fw.c:1540:35: sparse:     got unsigned int [usertype]
   drivers/scsi/qedi/qedi_fw.c:50:25: sparse: sparse: restricted __le16 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:51:28: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:52:31: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:53:31: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:55:28: sparse: sparse: cast from restricted __le16
   drivers/scsi/qedi/qedi_fw.c:55:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [usertype] t2wait @@     got restricted __be32 [usertype] @@
   drivers/scsi/qedi/qedi_fw.c:55:26: sparse:     expected restricted __be16 [usertype] t2wait
   drivers/scsi/qedi/qedi_fw.c:55:26: sparse:     got restricted __be32 [usertype]
   drivers/scsi/qedi/qedi_fw.c:56:30: sparse: sparse: cast from restricted __le16
   drivers/scsi/qedi/qedi_fw.c:56:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [usertype] t2retain @@     got restricted __be32 [usertype] @@
   drivers/scsi/qedi/qedi_fw.c:56:28: sparse:     expected restricted __be16 [usertype] t2retain
   drivers/scsi/qedi/qedi_fw.c:56:28: sparse:     got restricted __be32 [usertype]
   drivers/scsi/qedi/qedi_fw.c:106:9: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:106:9: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:106:9: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:110:29: sparse: sparse: restricted __le16 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:112:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [usertype] ttt @@     got restricted __le32 [usertype] ttt @@
   drivers/scsi/qedi/qedi_fw.c:112:27: sparse:     expected restricted __be32 [usertype] ttt
   drivers/scsi/qedi/qedi_fw.c:112:27: sparse:     got restricted __le32 [usertype] ttt
   drivers/scsi/qedi/qedi_fw.c:113:32: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:114:35: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:115:35: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:117:36: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:218:9: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:218:9: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:218:9: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:221:29: sparse: sparse: restricted __le16 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:223:32: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:224:36: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:225:35: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:282:9: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:282:9: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:282:9: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:285:29: sparse: sparse: restricted __le16 degrades to integer
>> drivers/scsi/qedi/qedi_fw.c:287:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [usertype] tsih @@     got restricted __le16 [usertype] tsih @@
   drivers/scsi/qedi/qedi_fw.c:287:28: sparse:     expected restricted __be16 [usertype] tsih
   drivers/scsi/qedi/qedi_fw.c:287:28: sparse:     got restricted __le16 [usertype] tsih
   drivers/scsi/qedi/qedi_fw.c:288:32: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:289:35: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:290:35: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:293:37: sparse: sparse: restricted __le32 degrades to integer
>> drivers/scsi/qedi/qedi_fw.c:332:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] idx @@     got restricted __le16 [usertype] rqe_opaque @@
   drivers/scsi/qedi/qedi_fw.c:332:13: sparse:     expected unsigned short [usertype] idx
   drivers/scsi/qedi/qedi_fw.c:332:13: sparse:     got restricted __le16 [usertype] rqe_opaque
   drivers/scsi/qedi/qedi_fw.c:367:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] idx @@     got restricted __le16 [usertype] rqe_opaque @@
   drivers/scsi/qedi/qedi_fw.c:367:13: sparse:     expected unsigned short [usertype] idx
   drivers/scsi/qedi/qedi_fw.c:367:13: sparse:     got restricted __le16 [usertype] rqe_opaque
>> drivers/scsi/qedi/qedi_fw.c:385:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] opaque @@     got restricted __le32 [usertype] @@
   drivers/scsi/qedi/qedi_fw.c:385:41: sparse:     expected restricted __le16 [usertype] opaque
   drivers/scsi/qedi/qedi_fw.c:385:41: sparse:     got restricted __le32 [usertype]
   drivers/scsi/qedi/qedi_fw.c:428:29: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:435:26: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:436:26: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:437:23: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:438:20: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:454:28: sparse: sparse: restricted __le16 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:499:32: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:515:18: sparse: sparse: cast from restricted __le32
>> drivers/scsi/qedi/qedi_fw.c:515:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int @@     got restricted __be32 [usertype] @@
   drivers/scsi/qedi/qedi_fw.c:515:16: sparse:     expected unsigned int
   drivers/scsi/qedi/qedi_fw.c:515:16: sparse:     got restricted __be32 [usertype]
   drivers/scsi/qedi/qedi_fw.c:516:18: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:516:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int @@     got restricted __be32 [usertype] @@
   drivers/scsi/qedi/qedi_fw.c:516:16: sparse:     expected unsigned int
   drivers/scsi/qedi/qedi_fw.c:516:16: sparse:     got restricted __be32 [usertype]
   drivers/scsi/qedi/qedi_fw.c:518:31: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:519:31: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:520:28: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:525:28: sparse: sparse: cast from restricted __le16
   drivers/scsi/qedi/qedi_fw.c:526:28: sparse: sparse: cast from restricted __le16
   drivers/scsi/qedi/qedi_fw.c:527:28: sparse: sparse: cast from restricted __le16
   drivers/scsi/qedi/qedi_fw.c:550:29: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:565:9: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:565:9: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:565:9: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:567:26: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:568:26: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:569:23: sparse: sparse: cast from restricted __le32
>> drivers/scsi/qedi/qedi_fw.c:592:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] iscsi_cid @@     got restricted __le16 [usertype] conn_id @@
   drivers/scsi/qedi/qedi_fw.c:592:20: sparse:     expected unsigned int [usertype] iscsi_cid
   drivers/scsi/qedi/qedi_fw.c:592:20: sparse:     got restricted __le16 [usertype] conn_id
   drivers/scsi/qedi/qedi_fw.c:632:26: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:633:26: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:634:20: sparse: sparse: restricted __le16 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:638:31: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:641:38: sparse: sparse: restricted __le32 degrades to integer
>> drivers/scsi/qedi/qedi_fw.c:746:28: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] proto_itt @@     got restricted __le16 [usertype] itid @@
   drivers/scsi/qedi/qedi_fw.c:746:28: sparse:     expected unsigned int [usertype] proto_itt
   drivers/scsi/qedi/qedi_fw.c:746:28: sparse:     got restricted __le16 [usertype] itid
   drivers/scsi/qedi/qedi_fw.c:758:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] iscsi_cid @@     got restricted __le16 [usertype] conn_id @@
   drivers/scsi/qedi/qedi_fw.c:758:19: sparse:     expected unsigned int [usertype] iscsi_cid
   drivers/scsi/qedi/qedi_fw.c:758:19: sparse:     got restricted __le16 [usertype] conn_id
   drivers/scsi/qedi/qedi_fw.c:816:25: sparse: sparse: cast to restricted itt_t
   drivers/scsi/qedi/qedi_fw.c:838:45: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int [usertype] tid @@     got restricted __le16 [usertype] itid @@
   drivers/scsi/qedi/qedi_fw.c:838:45: sparse:     expected unsigned int [usertype] tid
   drivers/scsi/qedi/qedi_fw.c:838:45: sparse:     got restricted __le16 [usertype] itid
   drivers/scsi/qedi/qedi_fw.c:859:57: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int idx @@     got restricted __le16 [usertype] itid @@
   drivers/scsi/qedi/qedi_fw.c:859:57: sparse:     expected int idx
   drivers/scsi/qedi/qedi_fw.c:859:57: sparse:     got restricted __le16 [usertype] itid
   drivers/scsi/qedi/qedi_fw.c:862:45: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int [usertype] tid @@     got restricted __le16 [usertype] itid @@
   drivers/scsi/qedi/qedi_fw.c:862:45: sparse:     expected unsigned int [usertype] tid
   drivers/scsi/qedi/qedi_fw.c:862:45: sparse:     got restricted __le16 [usertype] itid
   drivers/scsi/qedi/qedi_fw.c:900:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] iscsi_cid @@     got restricted __le16 [usertype] conn_id @@
   drivers/scsi/qedi/qedi_fw.c:900:20: sparse:     expected unsigned int [usertype] iscsi_cid
   drivers/scsi/qedi/qedi_fw.c:900:20: sparse:     got restricted __le16 [usertype] conn_id
>> drivers/scsi/qedi/qedi_fw.c:931:50: sparse: sparse: cast from restricted itt_t
   drivers/scsi/qedi/qedi_fw.c:931:40: sparse: sparse: restricted __le16 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:936:48: sparse: sparse: restricted __le32 degrades to integer
>> drivers/scsi/qedi/qedi_fw.c:935:49: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] itid @@     got unsigned int @@
   drivers/scsi/qedi/qedi_fw.c:935:49: sparse:     expected restricted __le16 [usertype] itid
   drivers/scsi/qedi/qedi_fw.c:935:49: sparse:     got unsigned int
   drivers/scsi/qedi/qedi_fw.c:985:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [assigned] [usertype] sq_prod @@     got unsigned short [usertype] fw_sq_prod_idx @@
   drivers/scsi/qedi/qedi_fw.c:985:23: sparse:     expected restricted __le16 [assigned] [usertype] sq_prod
   drivers/scsi/qedi/qedi_fw.c:985:23: sparse:     got unsigned short [usertype] fw_sq_prod_idx
>> drivers/scsi/qedi/qedi_fw.c:1058:40: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] isid_tabc @@     got unsigned int @@
   drivers/scsi/qedi/qedi_fw.c:1058:40: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] isid_tabc
   drivers/scsi/qedi/qedi_fw.c:1058:40: sparse:     got unsigned int
>> drivers/scsi/qedi/qedi_fw.c:1059:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [addressable] [assigned] [usertype] isid_d @@     got unsigned short @@
   drivers/scsi/qedi/qedi_fw.c:1059:37: sparse:     expected restricted __le16 [addressable] [assigned] [usertype] isid_d
   drivers/scsi/qedi/qedi_fw.c:1059:37: sparse:     got unsigned short
>> drivers/scsi/qedi/qedi_fw.c:1061:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [addressable] [assigned] [usertype] tsih @@     got restricted __be16 [usertype] tsih @@
   drivers/scsi/qedi/qedi_fw.c:1061:35: sparse:     expected restricted __le16 [addressable] [assigned] [usertype] tsih
   drivers/scsi/qedi/qedi_fw.c:1061:35: sparse:     got restricted __be16 [usertype] tsih
   drivers/scsi/qedi/qedi_fw.c:1062:47: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] hdr_second_dword @@     got int @@
   drivers/scsi/qedi/qedi_fw.c:1062:47: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] hdr_second_dword
   drivers/scsi/qedi/qedi_fw.c:1062:47: sparse:     got int
   drivers/scsi/qedi/qedi_fw.c:1065:36: sparse: sparse: cast to restricted itt_t
>> drivers/scsi/qedi/qedi_fw.c:1065:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] itt @@     got unsigned int [usertype] @@
   drivers/scsi/qedi/qedi_fw.c:1065:34: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] itt
   drivers/scsi/qedi/qedi_fw.c:1065:34: sparse:     got unsigned int [usertype]
>> drivers/scsi/qedi/qedi_fw.c:1066:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [addressable] [assigned] [usertype] cid @@     got unsigned int [usertype] iscsi_conn_id @@
   drivers/scsi/qedi/qedi_fw.c:1066:34: sparse:     expected restricted __le16 [addressable] [assigned] [usertype] cid
   drivers/scsi/qedi/qedi_fw.c:1066:34: sparse:     got unsigned int [usertype] iscsi_conn_id
>> drivers/scsi/qedi/qedi_fw.c:1067:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] cmd_sn @@     got unsigned int [usertype] @@
   drivers/scsi/qedi/qedi_fw.c:1067:37: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] cmd_sn
   drivers/scsi/qedi/qedi_fw.c:1067:37: sparse:     got unsigned int [usertype]
>> drivers/scsi/qedi/qedi_fw.c:1068:42: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] exp_stat_sn @@     got unsigned int [usertype] @@
   drivers/scsi/qedi/qedi_fw.c:1068:42: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] exp_stat_sn
   drivers/scsi/qedi/qedi_fw.c:1068:42: sparse:     got unsigned int [usertype]
>> drivers/scsi/qedi/qedi_fw.c:1074:45: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] lo @@     got unsigned int [usertype] @@
   drivers/scsi/qedi/qedi_fw.c:1074:45: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] lo
   drivers/scsi/qedi/qedi_fw.c:1074:45: sparse:     got unsigned int [usertype]
   drivers/scsi/qedi/qedi_fw.c:1076:45: sparse: sparse: too many warnings
--
   drivers/net/ethernet/packetengines/hamachi.c:1564:61: sparse: sparse: cast to restricted __be16
>> drivers/net/ethernet/packetengines/hamachi.c:1564:59: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __wsum [usertype] csum @@     got unsigned short [usertype] @@
   drivers/net/ethernet/packetengines/hamachi.c:1564:59: sparse:     expected restricted __wsum [usertype] csum
   drivers/net/ethernet/packetengines/hamachi.c:1564:59: sparse:     got unsigned short [usertype]
   drivers/net/ethernet/packetengines/hamachi.c:1565:56: sparse: sparse: restricted __wsum degrades to integer
   drivers/net/ethernet/packetengines/hamachi.c:1566:67: sparse: sparse: bad assignment (-=) to restricted __wsum
   drivers/net/ethernet/packetengines/hamachi.c:1568:67: sparse: sparse: bad assignment (+=) to restricted __wsum

vim +2525 security/smack/smack_lsm.c

e114e473771c84 Casey Schaufler 2008-02-04  2502  
21abb1ec414c75 Casey Schaufler 2015-07-22  2503  /**
21abb1ec414c75 Casey Schaufler 2015-07-22  2504   * smk_ipv6_check - check Smack access
21abb1ec414c75 Casey Schaufler 2015-07-22  2505   * @subject: subject Smack label
21abb1ec414c75 Casey Schaufler 2015-07-22  2506   * @object: object Smack label
21abb1ec414c75 Casey Schaufler 2015-07-22  2507   * @address: address
21abb1ec414c75 Casey Schaufler 2015-07-22  2508   * @act: the action being taken
21abb1ec414c75 Casey Schaufler 2015-07-22  2509   *
21abb1ec414c75 Casey Schaufler 2015-07-22  2510   * Check an IPv6 access
21abb1ec414c75 Casey Schaufler 2015-07-22  2511   */
21abb1ec414c75 Casey Schaufler 2015-07-22  2512  static int smk_ipv6_check(struct smack_known *subject,
21abb1ec414c75 Casey Schaufler 2015-07-22  2513  				struct smack_known *object,
21abb1ec414c75 Casey Schaufler 2015-07-22  2514  				struct sockaddr_in6 *address, int act)
21abb1ec414c75 Casey Schaufler 2015-07-22  2515  {
21abb1ec414c75 Casey Schaufler 2015-07-22  2516  #ifdef CONFIG_AUDIT
21abb1ec414c75 Casey Schaufler 2015-07-22  2517  	struct lsm_network_audit net;
21abb1ec414c75 Casey Schaufler 2015-07-22  2518  #endif
21abb1ec414c75 Casey Schaufler 2015-07-22  2519  	struct smk_audit_info ad;
21abb1ec414c75 Casey Schaufler 2015-07-22  2520  	int rc;
21abb1ec414c75 Casey Schaufler 2015-07-22  2521  
21abb1ec414c75 Casey Schaufler 2015-07-22  2522  #ifdef CONFIG_AUDIT
21abb1ec414c75 Casey Schaufler 2015-07-22  2523  	smk_ad_init_net(&ad, __func__, LSM_AUDIT_DATA_NET, &net);
21abb1ec414c75 Casey Schaufler 2015-07-22  2524  	ad.a.u.net->family = PF_INET6;
21abb1ec414c75 Casey Schaufler 2015-07-22 @2525  	ad.a.u.net->dport = ntohs(address->sin6_port);
21abb1ec414c75 Casey Schaufler 2015-07-22  2526  	if (act == SMK_RECEIVING)
21abb1ec414c75 Casey Schaufler 2015-07-22  2527  		ad.a.u.net->v6info.saddr = address->sin6_addr;
21abb1ec414c75 Casey Schaufler 2015-07-22  2528  	else
21abb1ec414c75 Casey Schaufler 2015-07-22  2529  		ad.a.u.net->v6info.daddr = address->sin6_addr;
21abb1ec414c75 Casey Schaufler 2015-07-22  2530  #endif
21abb1ec414c75 Casey Schaufler 2015-07-22  2531  	rc = smk_access(subject, object, MAY_WRITE, &ad);
21abb1ec414c75 Casey Schaufler 2015-07-22  2532  	rc = smk_bu_note("IPv6 check", subject, object, MAY_WRITE, rc);
21abb1ec414c75 Casey Schaufler 2015-07-22  2533  	return rc;
21abb1ec414c75 Casey Schaufler 2015-07-22  2534  }
21abb1ec414c75 Casey Schaufler 2015-07-22  2535  

:::::: The code at line 2525 was first introduced by commit
:::::: 21abb1ec414c75abe32c3854848ff30e2b4a6113 Smack: IPv6 host labeling

:::::: TO: Casey Schaufler <casey@schaufler-ca.com>
:::::: CC: Casey Schaufler <casey@schaufler-ca.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
