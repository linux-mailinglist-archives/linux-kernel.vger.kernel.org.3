Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1465357CF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 04:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235995AbiE0Ch5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 22:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiE0Chz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 22:37:55 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD66213F0B
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 19:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653619073; x=1685155073;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AqgDnnRFdPBZJABPx68XXA+tPN5LvAJagEhad89DANE=;
  b=fMX5pgeH0DIY7Cs5vsg3pmAwxuQo/XnpuYsQc0Wg8LLXu+wURN+1QuOU
   kiuOICEttfndOxe1AqGf0406HkGsHJqI+/4dPXtHLV/OqPpSMJ9473KHc
   FeZEWMFjVhS8qrcs50y9v/K4mJ/eutDHsX3VR7sA6O1tkQGcG3LMUkYsZ
   YvjDNls0NLGJUbv+oWJ/+UKzPLU1l9+q6EaSks8AITqUXyVDiKbzdcdO8
   VQzSFoGKOol3ffXM9FSZNHVkOxEHNN2oMbZLH09KyAkigdaoB0UQbgOGD
   8bN8DOV/nk9Rfzl4H+A1Pr7iK3oK5z7rJXjWR3uvoAyaZ2xV7vUDvaqHb
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="271930437"
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="271930437"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 19:37:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="527749090"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 26 May 2022 19:37:51 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuPrK-0004Ks-DK;
        Fri, 27 May 2022 02:37:50 +0000
Date:   Fri, 27 May 2022 10:37:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, 0day robot <lkp@intel.com>
Subject: include/linux/netdevice.h:2339:11: error: no member named 'use_ipv'
 in 'struct sk_buff'
Message-ID: <202205271055.wLZFsaxk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel-lab-lkp/linux/commits/UPDATE-20220526-173254/Vladimir-Oltean/selftests-forwarding-add-Per-Stream-Filtering-and-Policing-test-for-Ocelot/20220501-193132
head:   32b52188919f424bfabe1d3c0921ff854fb7f4ee
commit: 32b52188919f424bfabe1d3c0921ff854fb7f4ee selftests: forwarding: add Per-Stream Filtering and Policing test for Ocelot
date:   17 hours ago
config: i386-randconfig-a015 (https://download.01.org/0day-ci/archive/20220527/202205271055.wLZFsaxk-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6f4644d194da594562027a5d458d9fb7a20ebc39)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/32b52188919f424bfabe1d3c0921ff854fb7f4ee
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review UPDATE-20220526-173254/Vladimir-Oltean/selftests-forwarding-add-Per-Stream-Filtering-and-Policing-test-for-Ocelot/20220501-193132
        git checkout 32b52188919f424bfabe1d3c0921ff854fb7f4ee
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/net/ethernet/broadcom/bnx2x/ drivers/net/ethernet/mellanox/mlx4/ drivers/net/ethernet/sfc/ net/sched/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from net/sched/act_gact.c:13:
   In file included from include/linux/rtnetlink.h:7:
>> include/linux/netdevice.h:2339:11: error: no member named 'use_ipv' in 'struct sk_buff'
           if (skb->use_ipv)
               ~~~  ^
>> include/linux/netdevice.h:2340:15: error: no member named 'ipv' in 'struct sk_buff'
                   prio = skb->ipv;
                          ~~~  ^
   2 errors generated.
--
   In file included from net/sched/act_gate.c:10:
   In file included from include/linux/rtnetlink.h:7:
>> include/linux/netdevice.h:2339:11: error: no member named 'use_ipv' in 'struct sk_buff'
           if (skb->use_ipv)
               ~~~  ^
>> include/linux/netdevice.h:2340:15: error: no member named 'ipv' in 'struct sk_buff'
                   prio = skb->ipv;
                          ~~~  ^
>> net/sched/act_gate.c:145:8: error: no member named 'use_ipv' in 'struct sk_buff'
                   skb->use_ipv = true;
                   ~~~  ^
>> net/sched/act_gate.c:146:8: error: no member named 'ipv' in 'struct sk_buff'
                   skb->ipv = gact->current_ipv;
                   ~~~  ^
   4 errors generated.
--
   In file included from net/sched/cls_flow.c:17:
   In file included from include/linux/ipv6.h:93:
   In file included from include/linux/tcp.h:19:
   In file included from include/net/sock.h:46:
>> include/linux/netdevice.h:2339:11: error: no member named 'use_ipv' in 'struct sk_buff'
           if (skb->use_ipv)
               ~~~  ^
>> include/linux/netdevice.h:2340:15: error: no member named 'ipv' in 'struct sk_buff'
                   prio = skb->ipv;
                          ~~~  ^
>> net/sched/cls_flow.c:63:52: warning: shift count >= width of type [-Wshift-count-overflow]
           return (a & 0xFFFFFFFF) ^ (BITS_PER_LONG > 32 ? a >> 32 : 0);
                                                             ^  ~~
   1 warning and 2 errors generated.
--
   In file included from drivers/net/ethernet/sfc/farch.c:15:
   In file included from drivers/net/ethernet/sfc/net_driver.h:13:
>> include/linux/netdevice.h:2339:11: error: no member named 'use_ipv' in 'struct sk_buff'
           if (skb->use_ipv)
               ~~~  ^
>> include/linux/netdevice.h:2340:15: error: no member named 'ipv' in 'struct sk_buff'
                   prio = skb->ipv;
                          ~~~  ^
   drivers/net/ethernet/sfc/farch.c:188:3: warning: shift count is negative [-Wshift-count-negative]
                   EFX_POPULATE_QWORD_3(buf_desc,
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:434:2: note: expanded from macro 'EFX_POPULATE_QWORD_3'
           EFX_POPULATE_QWORD_4(qword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:432:2: note: expanded from macro 'EFX_POPULATE_QWORD_4'
           EFX_POPULATE_QWORD_5(qword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:430:2: note: expanded from macro 'EFX_POPULATE_QWORD_5'
           EFX_POPULATE_QWORD_6(qword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 19 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   drivers/net/ethernet/sfc/bitfield.h:256:3: note: expanded from macro 'EFX_INSERT_NATIVE'
            EFX_INSERT_NATIVE64(min, max, low, high, value) :      \
            ^
   drivers/net/ethernet/sfc/bitfield.h:246:21: note: expanded from macro 'EFX_INSERT_NATIVE64'
             (((u64) (value)) >> (min - low))))
                              ^
   include/uapi/linux/byteorder/little_endian.h:34:51: note: expanded from macro '__cpu_to_le32'
   #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
                                                     ^
   drivers/net/ethernet/sfc/farch.c:188:3: warning: shift count >= width of type [-Wshift-count-overflow]
                   EFX_POPULATE_QWORD_3(buf_desc,
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:434:2: note: expanded from macro 'EFX_POPULATE_QWORD_3'
           EFX_POPULATE_QWORD_4(qword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:432:2: note: expanded from macro 'EFX_POPULATE_QWORD_4'
           EFX_POPULATE_QWORD_5(qword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:430:2: note: expanded from macro 'EFX_POPULATE_QWORD_5'
           EFX_POPULATE_QWORD_6(qword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 19 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   drivers/net/ethernet/sfc/bitfield.h:257:3: note: expanded from macro 'EFX_INSERT_NATIVE'
            EFX_INSERT_NATIVE32(min, max, low, high, value))
            ^
   drivers/net/ethernet/sfc/bitfield.h:251:21: note: expanded from macro 'EFX_INSERT_NATIVE32'
             (((u32) (value)) << (low - min)) :            \
                              ^
   include/uapi/linux/byteorder/little_endian.h:34:51: note: expanded from macro '__cpu_to_le32'
   #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
                                                     ^
   drivers/net/ethernet/sfc/farch.c:188:3: warning: shift count is negative [-Wshift-count-negative]
                   EFX_POPULATE_QWORD_3(buf_desc,
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:434:2: note: expanded from macro 'EFX_POPULATE_QWORD_3'
           EFX_POPULATE_QWORD_4(qword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:432:2: note: expanded from macro 'EFX_POPULATE_QWORD_4'
           EFX_POPULATE_QWORD_5(qword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:430:2: note: expanded from macro 'EFX_POPULATE_QWORD_5'
           EFX_POPULATE_QWORD_6(qword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 19 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   drivers/net/ethernet/sfc/bitfield.h:257:3: note: expanded from macro 'EFX_INSERT_NATIVE'
            EFX_INSERT_NATIVE32(min, max, low, high, value))
            ^
   drivers/net/ethernet/sfc/bitfield.h:252:21: note: expanded from macro 'EFX_INSERT_NATIVE32'
             (((u32) (value)) >> (min - low))))
                              ^
   include/uapi/linux/byteorder/little_endian.h:34:51: note: expanded from macro '__cpu_to_le32'
   #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
                                                     ^
   drivers/net/ethernet/sfc/farch.c:188:3: warning: shift count is negative [-Wshift-count-negative]
                   EFX_POPULATE_QWORD_3(buf_desc,
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:434:2: note: expanded from macro 'EFX_POPULATE_QWORD_3'
           EFX_POPULATE_QWORD_4(qword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:432:2: note: expanded from macro 'EFX_POPULATE_QWORD_4'
           EFX_POPULATE_QWORD_5(qword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:430:2: note: expanded from macro 'EFX_POPULATE_QWORD_5'
           EFX_POPULATE_QWORD_6(qword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 19 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   drivers/net/ethernet/sfc/bitfield.h:256:3: note: expanded from macro 'EFX_INSERT_NATIVE'
            EFX_INSERT_NATIVE64(min, max, low, high, value) :      \
            ^
   drivers/net/ethernet/sfc/bitfield.h:246:21: note: expanded from macro 'EFX_INSERT_NATIVE64'
             (((u64) (value)) >> (min - low))))
                              ^
   include/uapi/linux/byteorder/little_endian.h:34:51: note: expanded from macro '__cpu_to_le32'
   #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
                                                     ^
   drivers/net/ethernet/sfc/farch.c:188:3: warning: shift count is negative [-Wshift-count-negative]
                   EFX_POPULATE_QWORD_3(buf_desc,
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:434:2: note: expanded from macro 'EFX_POPULATE_QWORD_3'
           EFX_POPULATE_QWORD_4(qword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:432:2: note: expanded from macro 'EFX_POPULATE_QWORD_4'
           EFX_POPULATE_QWORD_5(qword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:430:2: note: expanded from macro 'EFX_POPULATE_QWORD_5'
--
   In file included from drivers/net/ethernet/sfc/siena.c:14:
   In file included from drivers/net/ethernet/sfc/net_driver.h:13:
>> include/linux/netdevice.h:2339:11: error: no member named 'use_ipv' in 'struct sk_buff'
           if (skb->use_ipv)
               ~~~  ^
>> include/linux/netdevice.h:2340:15: error: no member named 'ipv' in 'struct sk_buff'
                   prio = skb->ipv;
                          ~~~  ^
   drivers/net/ethernet/sfc/siena.c:44:3: warning: shift count is negative [-Wshift-count-negative]
                   EFX_POPULATE_DWORD_2(timer_cmd,
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:481:2: note: expanded from macro 'EFX_POPULATE_DWORD_2'
           EFX_POPULATE_DWORD_3(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:479:2: note: expanded from macro 'EFX_POPULATE_DWORD_3'
           EFX_POPULATE_DWORD_4(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:477:2: note: expanded from macro 'EFX_POPULATE_DWORD_4'
           EFX_POPULATE_DWORD_5(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 19 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   drivers/net/ethernet/sfc/bitfield.h:256:3: note: expanded from macro 'EFX_INSERT_NATIVE'
            EFX_INSERT_NATIVE64(min, max, low, high, value) :      \
            ^
   drivers/net/ethernet/sfc/bitfield.h:246:21: note: expanded from macro 'EFX_INSERT_NATIVE64'
             (((u64) (value)) >> (min - low))))
                              ^
   include/uapi/linux/byteorder/little_endian.h:34:51: note: expanded from macro '__cpu_to_le32'
   #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
                                                     ^
   drivers/net/ethernet/sfc/siena.c:44:3: warning: shift count is negative [-Wshift-count-negative]
                   EFX_POPULATE_DWORD_2(timer_cmd,
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:481:2: note: expanded from macro 'EFX_POPULATE_DWORD_2'
           EFX_POPULATE_DWORD_3(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:479:2: note: expanded from macro 'EFX_POPULATE_DWORD_3'
           EFX_POPULATE_DWORD_4(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:477:2: note: expanded from macro 'EFX_POPULATE_DWORD_4'
           EFX_POPULATE_DWORD_5(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 19 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   drivers/net/ethernet/sfc/bitfield.h:257:3: note: expanded from macro 'EFX_INSERT_NATIVE'
            EFX_INSERT_NATIVE32(min, max, low, high, value))
            ^
   drivers/net/ethernet/sfc/bitfield.h:252:21: note: expanded from macro 'EFX_INSERT_NATIVE32'
             (((u32) (value)) >> (min - low))))
                              ^
   include/uapi/linux/byteorder/little_endian.h:34:51: note: expanded from macro '__cpu_to_le32'
   #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
                                                     ^
   drivers/net/ethernet/sfc/siena.c:50:3: warning: shift count is negative [-Wshift-count-negative]
                   EFX_POPULATE_DWORD_2(timer_cmd,
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:481:2: note: expanded from macro 'EFX_POPULATE_DWORD_2'
           EFX_POPULATE_DWORD_3(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:479:2: note: expanded from macro 'EFX_POPULATE_DWORD_3'
           EFX_POPULATE_DWORD_4(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:477:2: note: expanded from macro 'EFX_POPULATE_DWORD_4'
           EFX_POPULATE_DWORD_5(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 19 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   drivers/net/ethernet/sfc/bitfield.h:256:3: note: expanded from macro 'EFX_INSERT_NATIVE'
            EFX_INSERT_NATIVE64(min, max, low, high, value) :      \
            ^
   drivers/net/ethernet/sfc/bitfield.h:246:21: note: expanded from macro 'EFX_INSERT_NATIVE64'
             (((u64) (value)) >> (min - low))))
                              ^
   include/uapi/linux/byteorder/little_endian.h:34:51: note: expanded from macro '__cpu_to_le32'
   #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
                                                     ^
   drivers/net/ethernet/sfc/siena.c:50:3: warning: shift count is negative [-Wshift-count-negative]
                   EFX_POPULATE_DWORD_2(timer_cmd,
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:481:2: note: expanded from macro 'EFX_POPULATE_DWORD_2'
           EFX_POPULATE_DWORD_3(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:479:2: note: expanded from macro 'EFX_POPULATE_DWORD_3'
           EFX_POPULATE_DWORD_4(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:477:2: note: expanded from macro 'EFX_POPULATE_DWORD_4'
           EFX_POPULATE_DWORD_5(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 19 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   drivers/net/ethernet/sfc/bitfield.h:257:3: note: expanded from macro 'EFX_INSERT_NATIVE'
            EFX_INSERT_NATIVE32(min, max, low, high, value))
            ^
   drivers/net/ethernet/sfc/bitfield.h:252:21: note: expanded from macro 'EFX_INSERT_NATIVE32'
             (((u32) (value)) >> (min - low))))
                              ^
   include/uapi/linux/byteorder/little_endian.h:34:51: note: expanded from macro '__cpu_to_le32'
   #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
                                                     ^
   drivers/net/ethernet/sfc/siena.c:286:18: warning: shift count >= width of type [-Wshift-count-overflow]
           efx->port_num = EFX_OWORD_FIELD(reg, FRF_CZ_CS_PORT_NUM) - 1;
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:228:26: note: expanded from macro 'EFX_OWORD_FIELD'
   #define EFX_OWORD_FIELD         EFX_OWORD_FIELD32
                                   ^
   drivers/net/ethernet/sfc/bitfield.h:177:2: note: expanded from macro 'EFX_OWORD_FIELD32'
           EFX_EXTRACT_OWORD32(oword, EFX_LOW_BIT(field),          \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:153:4: note: expanded from macro 'EFX_EXTRACT_OWORD32'
--
   In file included from drivers/net/ethernet/sfc/ef10.c:7:
   In file included from drivers/net/ethernet/sfc/net_driver.h:13:
>> include/linux/netdevice.h:2339:11: error: no member named 'use_ipv' in 'struct sk_buff'
           if (skb->use_ipv)
               ~~~  ^
>> include/linux/netdevice.h:2340:15: error: no member named 'ipv' in 'struct sk_buff'
                   prio = skb->ipv;
                          ~~~  ^
>> drivers/net/ethernet/sfc/ef10.c:50:9: warning: shift count is negative [-Wshift-count-negative]
           return EFX_DWORD_FIELD(reg, EFX_WORD_1) == 0xb007 ?
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:185:2: note: expanded from macro 'EFX_DWORD_FIELD'
           EFX_EXTRACT_DWORD(dword, EFX_LOW_BIT(field),            \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:165:3: note: expanded from macro 'EFX_EXTRACT_DWORD'
           (EFX_EXTRACT32((dword).u32[0], 0, 31, low, high) &      \
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:141:2: note: expanded from macro 'EFX_EXTRACT32'
           EFX_EXTRACT_NATIVE(le32_to_cpu(element), min, max, low, high)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:127:20: note: expanded from macro 'EFX_EXTRACT_NATIVE'
            (native_element) << ((min) - (low)))
                             ^  ~~~~~~~~~~~~~~~
>> drivers/net/ethernet/sfc/ef10.c:127:3: warning: shift count >= width of type [-Wshift-count-overflow]
                   MCDI_DWORD(outbuf, GET_CAPABILITIES_OUT_FLAGS1);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/mcdi.h:218:2: note: expanded from macro 'MCDI_DWORD'
           EFX_DWORD_FIELD(*_MCDI_DWORD(_buf, _field), EFX_DWORD_0)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:185:2: note: expanded from macro 'EFX_DWORD_FIELD'
           EFX_EXTRACT_DWORD(dword, EFX_LOW_BIT(field),            \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:166:3: note: expanded from macro 'EFX_EXTRACT_DWORD'
            EFX_MASK32((high) + 1 - (low)))
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:71:16: note: expanded from macro 'EFX_MASK32'
            (((((u32) 1) << (width))) - 1))
                         ^  ~~~~~~~
   drivers/net/ethernet/sfc/ef10.c:130:30: warning: shift count >= width of type [-Wshift-count-overflow]
                   nic_data->datapath_caps2 = MCDI_DWORD(outbuf,
                                              ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/mcdi.h:218:2: note: expanded from macro 'MCDI_DWORD'
           EFX_DWORD_FIELD(*_MCDI_DWORD(_buf, _field), EFX_DWORD_0)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:185:2: note: expanded from macro 'EFX_DWORD_FIELD'
           EFX_EXTRACT_DWORD(dword, EFX_LOW_BIT(field),            \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:166:3: note: expanded from macro 'EFX_EXTRACT_DWORD'
            EFX_MASK32((high) + 1 - (low)))
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:71:16: note: expanded from macro 'EFX_MASK32'
            (((((u32) 1) << (width))) - 1))
                         ^  ~~~~~~~
   drivers/net/ethernet/sfc/ef10.c:198:32: warning: shift count >= width of type [-Wshift-count-overflow]
           nic_data->licensed_features = MCDI_QWORD(outbuf,
                                         ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/mcdi.h:281:3: note: expanded from macro 'MCDI_QWORD'
           (EFX_DWORD_FIELD(_MCDI_DWORD(_buf, _field)[0], EFX_DWORD_0) |   \
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:185:2: note: expanded from macro 'EFX_DWORD_FIELD'
           EFX_EXTRACT_DWORD(dword, EFX_LOW_BIT(field),            \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:166:3: note: expanded from macro 'EFX_EXTRACT_DWORD'
            EFX_MASK32((high) + 1 - (low)))
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:71:16: note: expanded from macro 'EFX_MASK32'
            (((((u32) 1) << (width))) - 1))
                         ^  ~~~~~~~
   drivers/net/ethernet/sfc/ef10.c:198:32: warning: shift count >= width of type [-Wshift-count-overflow]
           nic_data->licensed_features = MCDI_QWORD(outbuf,
                                         ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/mcdi.h:282:7: note: expanded from macro 'MCDI_QWORD'
           (u64)EFX_DWORD_FIELD(_MCDI_DWORD(_buf, _field)[1], EFX_DWORD_0) << 32)
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:185:2: note: expanded from macro 'EFX_DWORD_FIELD'
           EFX_EXTRACT_DWORD(dword, EFX_LOW_BIT(field),            \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:166:3: note: expanded from macro 'EFX_EXTRACT_DWORD'
            EFX_MASK32((high) + 1 - (low)))
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:71:16: note: expanded from macro 'EFX_MASK32'
            (((((u32) 1) << (width))) - 1))
                         ^  ~~~~~~~
   drivers/net/ethernet/sfc/ef10.c:211:7: warning: shift count >= width of type [-Wshift-count-overflow]
           rc = MCDI_DWORD(outbuf, GET_CLOCK_OUT_SYS_FREQ);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/mcdi.h:218:2: note: expanded from macro 'MCDI_DWORD'
           EFX_DWORD_FIELD(*_MCDI_DWORD(_buf, _field), EFX_DWORD_0)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:185:2: note: expanded from macro 'EFX_DWORD_FIELD'
           EFX_EXTRACT_DWORD(dword, EFX_LOW_BIT(field),            \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:166:3: note: expanded from macro 'EFX_EXTRACT_DWORD'
            EFX_MASK32((high) + 1 - (low)))
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:71:16: note: expanded from macro 'EFX_MASK32'
            (((((u32) 1) << (width))) - 1))
                         ^  ~~~~~~~
   drivers/net/ethernet/sfc/ef10.c:267:27: warning: shift count >= width of type [-Wshift-count-overflow]
                   efx->timer_quantum_ns = MCDI_DWORD(data,
                                           ^~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/mcdi.h:218:2: note: expanded from macro 'MCDI_DWORD'
           EFX_DWORD_FIELD(*_MCDI_DWORD(_buf, _field), EFX_DWORD_0)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:185:2: note: expanded from macro 'EFX_DWORD_FIELD'
           EFX_EXTRACT_DWORD(dword, EFX_LOW_BIT(field),            \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:166:3: note: expanded from macro 'EFX_EXTRACT_DWORD'
            EFX_MASK32((high) + 1 - (low)))
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:71:16: note: expanded from macro 'EFX_MASK32'
            (((((u32) 1) << (width))) - 1))
                         ^  ~~~~~~~
   drivers/net/ethernet/sfc/ef10.c:269:23: warning: shift count >= width of type [-Wshift-count-overflow]
                   efx->timer_max_ns = MCDI_DWORD(data,
                                       ^~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/mcdi.h:218:2: note: expanded from macro 'MCDI_DWORD'
           EFX_DWORD_FIELD(*_MCDI_DWORD(_buf, _field), EFX_DWORD_0)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:185:2: note: expanded from macro 'EFX_DWORD_FIELD'
           EFX_EXTRACT_DWORD(dword, EFX_LOW_BIT(field),            \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:166:3: note: expanded from macro 'EFX_EXTRACT_DWORD'
            EFX_MASK32((high) + 1 - (low)))
..


vim +2339 include/linux/netdevice.h

  2332	
  2333	static inline int skb_get_prio_tc_map(const struct sk_buff *skb,
  2334					      const struct net_device *dev)
  2335	{
  2336		__u32 prio = skb->priority;
  2337	
  2338	#if IS_ENABLED(CONFIG_NET_ACT_GATE)
> 2339		if (skb->use_ipv)
> 2340			prio = skb->ipv;
  2341	#endif
  2342	
  2343		return netdev_get_prio_tc_map(dev, prio);
  2344	}
  2345	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
