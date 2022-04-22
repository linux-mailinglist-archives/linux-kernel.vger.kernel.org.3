Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEC150B979
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448200AbiDVOIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388281AbiDVOIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:08:15 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86338DEFF
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650636320; x=1682172320;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mVw+CvMCzQNC5VeNoHNWoK0A1Uj2nOHMbvuuCm8DJUw=;
  b=DzN/k6a+vjm8EoLh3y4ntZ7xfH2cJOVVKsPeEA+y93JfIKoBMc4f3WEU
   17c5GTLkXLfSlH0IDscbRnXeK1eP87MxJ3DkyqP+1ezltMj8L4/nmeFl6
   Rrxnz4bRCZUjBcmpLgiu9JSuDtVYjTUh7eW8fpH92t4q54qhss0wNmsmj
   d9h0Lt45PT1r2WkGNTDs1UNKI7LjDAfv+WcsyXlE1U3c22adActfKQ9Gq
   T7ubb2vO3uZN3V4Bg1Yrssmv3lMGRsa9CSOF3VOyLMGq4Ym/DoI0a0o2+
   VgbYCSjXjDqFO4HMkrraIFNr6PI40ryRrIn0idpJJLz8wFy4rZtpiYD8x
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="263531600"
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="263531600"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 07:05:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="594152842"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 22 Apr 2022 07:05:18 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhtuP-000A9m-Hh;
        Fri, 22 Apr 2022 14:05:17 +0000
Date:   Fri, 22 Apr 2022 22:04:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/freescale/ucc_geth.c:2167:17: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <202204222245.zin1HpKO-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d569e86915b7f2f9795588591c8d5ea0b66481cb
commit: 28e77cc1c0686621a4d416f599cee5ab369daa0a fortify: Detect struct member overflows in memset() at compile-time
date:   10 weeks ago
config: powerpc-randconfig-s032-20220422 (https://download.01.org/0day-ci/archive/20220422/202204222245.zin1HpKO-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=28e77cc1c0686621a4d416f599cee5ab369daa0a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 28e77cc1c0686621a4d416f599cee5ab369daa0a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/net/ethernet/freescale/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/net/ethernet/freescale/ucc_geth.c:243:21: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:243:21: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:243:21: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:404:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] [usertype] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:404:22: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:404:22: sparse:     got restricted __be16 [noderef] [usertype] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:405:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] [usertype] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:405:22: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:405:22: sparse:     got restricted __be16 [noderef] [usertype] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:406:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] [usertype] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:406:22: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:406:22: sparse:     got restricted __be16 [noderef] [usertype] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:448:23: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __be16 [noderef] [usertype] __iomem *reg @@     got unsigned short [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:448:23: sparse:     expected restricted __be16 [noderef] [usertype] __iomem *reg
   drivers/net/ethernet/freescale/ucc_geth.c:448:23: sparse:     got unsigned short [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:1316:26: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:1316:26: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:1316:26: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:1343:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:1343:19: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:1343:19: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:1389:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_uccm @@
   drivers/net/ethernet/freescale/ucc_geth.c:1389:9: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:1389:9: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_uccm
   drivers/net/ethernet/freescale/ucc_geth.c:1389:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_uccm @@
   drivers/net/ethernet/freescale/ucc_geth.c:1389:9: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:1389:9: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_uccm
   drivers/net/ethernet/freescale/ucc_geth.c:1390:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_ucce @@
   drivers/net/ethernet/freescale/ucc_geth.c:1390:22: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:1390:22: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_ucce
   drivers/net/ethernet/freescale/ucc_geth.c:1401:36: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_ucce @@
   drivers/net/ethernet/freescale/ucc_geth.c:1401:36: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:1401:36: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_ucce
   drivers/net/ethernet/freescale/ucc_geth.c:1570:38: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:1570:38: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:1570:38: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:1635:35: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:1635:35: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:1635:35: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:1823:41: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:1823:41: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:1823:41: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:1838:50: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *objp @@     got unsigned char [noderef] [usertype] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:1838:50: sparse:     expected void const *objp
   drivers/net/ethernet/freescale/ucc_geth.c:1838:50: sparse:     got unsigned char [noderef] [usertype] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:1863:33: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:1863:33: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:1863:33: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:1875:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *objp @@     got unsigned char [noderef] [usertype] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:1875:42: sparse:     expected void const *objp
   drivers/net/ethernet/freescale/ucc_geth.c:1875:42: sparse:     got unsigned char [noderef] [usertype] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:1964:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:1964:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:1964:17: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:1964:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:1964:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:1964:17: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:1966:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:1966:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:1966:17: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:1966:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:1966:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:1966:17: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:2012:29: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_uccm @@
   drivers/net/ethernet/freescale/ucc_geth.c:2012:29: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:2012:29: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_uccm
   drivers/net/ethernet/freescale/ucc_geth.c:2015:29: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_ucce @@
   drivers/net/ethernet/freescale/ucc_geth.c:2015:29: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:2015:29: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_ucce
   drivers/net/ethernet/freescale/ucc_geth.c:2159:40: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] [usertype] __iomem * @@     got void * @@
   drivers/net/ethernet/freescale/ucc_geth.c:2159:40: sparse:     expected unsigned char [noderef] [usertype] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:2159:40: sparse:     got void *
   drivers/net/ethernet/freescale/ucc_geth.c:2167:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:2167:17: sparse:     expected void const *
   drivers/net/ethernet/freescale/ucc_geth.c:2167:17: sparse:     got unsigned char [noderef] [usertype] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:2167:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:2167:17: sparse:     expected void const *
   drivers/net/ethernet/freescale/ucc_geth.c:2167:17: sparse:     got unsigned char [noderef] [usertype] __iomem *
>> drivers/net/ethernet/freescale/ucc_geth.c:2167:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got unsigned char [noderef] [usertype] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:2167:17: sparse:     expected void *
   drivers/net/ethernet/freescale/ucc_geth.c:2167:17: sparse:     got unsigned char [noderef] [usertype] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:2187:37: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:2187:37: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:2187:37: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:2220:40: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] [usertype] __iomem * @@     got void * @@
   drivers/net/ethernet/freescale/ucc_geth.c:2220:40: sparse:     expected unsigned char [noderef] [usertype] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:2220:40: sparse:     got void *
   drivers/net/ethernet/freescale/ucc_geth.c:2247:37: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:2247:37: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:2247:37: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:2309:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [noderef] [usertype] __iomem *upsmr_register @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:2309:32: sparse:     expected unsigned int [noderef] [usertype] __iomem *upsmr_register
   drivers/net/ethernet/freescale/ucc_geth.c:2309:32: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:2315:57: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected unsigned int [noderef] [usertype] __iomem *upsmr_register @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:2315:57: sparse:     expected unsigned int [noderef] [usertype] __iomem *upsmr_register
   drivers/net/ethernet/freescale/ucc_geth.c:2315:57: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:2327:35: sparse: sparse: incorrect type in argument 6 (different base types) @@     expected unsigned int [noderef] [usertype] __iomem *upsmr_register @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:2327:35: sparse:     expected unsigned int [noderef] [usertype] __iomem *upsmr_register
   drivers/net/ethernet/freescale/ucc_geth.c:2327:35: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:2375:37: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int [noderef] [usertype] __iomem *upsmr_register @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:2375:37: sparse:     expected unsigned int [noderef] [usertype] __iomem *upsmr_register
   drivers/net/ethernet/freescale/ucc_geth.c:2375:37: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:2453:64: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile *address @@     got unsigned char [noderef] [usertype] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:2453:64: sparse:     expected void volatile *address
   drivers/net/ethernet/freescale/ucc_geth.c:2453:64: sparse:     got unsigned char [noderef] [usertype] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:2456:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile *address @@     got unsigned char [noderef] [usertype] __iomem *[assigned] endOfRing @@
   drivers/net/ethernet/freescale/ucc_geth.c:2456:45: sparse:     expected void volatile *address
   drivers/net/ethernet/freescale/ucc_geth.c:2456:45: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] endOfRing
   drivers/net/ethernet/freescale/ucc_geth.c:2676:64: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile *address @@     got unsigned char [noderef] [usertype] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:2676:64: sparse:     expected void volatile *address
   drivers/net/ethernet/freescale/ucc_geth.c:2676:64: sparse:     got unsigned char [noderef] [usertype] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:2943:21: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:2943:21: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:2943:21: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:3009:46: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:3009:46: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:3009:46: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:3137:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_uccm @@
   drivers/net/ethernet/freescale/ucc_geth.c:3137:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:3137:17: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_uccm
   drivers/net/ethernet/freescale/ucc_geth.c:3137:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_uccm @@
   drivers/net/ethernet/freescale/ucc_geth.c:3137:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:3137:17: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_uccm
   drivers/net/ethernet/freescale/ucc_geth.c:3158:34: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_ucce @@
   drivers/net/ethernet/freescale/ucc_geth.c:3158:34: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:3158:34: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_ucce
   drivers/net/ethernet/freescale/ucc_geth.c:3159:34: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_uccm @@
   drivers/net/ethernet/freescale/ucc_geth.c:3159:34: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:3159:34: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_uccm
   drivers/net/ethernet/freescale/ucc_geth.c:3161:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_ucce @@
   drivers/net/ethernet/freescale/ucc_geth.c:3161:22: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:3161:22: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_ucce
   drivers/net/ethernet/freescale/ucc_geth.c:3167:38: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_uccm @@
   drivers/net/ethernet/freescale/ucc_geth.c:3167:38: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:3167:38: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_uccm
   drivers/net/ethernet/freescale/ucc_geth.c:3413:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_uccm @@
   drivers/net/ethernet/freescale/ucc_geth.c:3413:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:3413:17: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_uccm
   drivers/net/ethernet/freescale/ucc_geth.c:3413:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_uccm @@
   drivers/net/ethernet/freescale/ucc_geth.c:3413:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:3413:17: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_uccm
   drivers/net/ethernet/freescale/ucc_geth.c:3436:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_uccm @@
   drivers/net/ethernet/freescale/ucc_geth.c:3436:25: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:3436:25: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_uccm
   drivers/net/ethernet/freescale/ucc_geth.c:3436:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_uccm @@
   drivers/net/ethernet/freescale/ucc_geth.c:3436:25: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:3436:25: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_uccm

vim +2167 drivers/net/ethernet/freescale/ucc_geth.c

728de4c927a354 drivers/net/ucc_geth.c                    Kim Phillips     2007-04-13  2137  
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2138  static int ucc_geth_alloc_tx(struct ucc_geth_private *ugeth)
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2139  {
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2140  	struct ucc_geth_info *ug_info;
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2141  	struct ucc_fast_info *uf_info;
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2142  	int length;
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2143  	u16 i, j;
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2144  	u8 __iomem *bd;
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2145  
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2146  	ug_info = ugeth->ug_info;
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2147  	uf_info = &ug_info->uf_info;
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2148  
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2149  	/* Allocate Tx bds */
53f49d86ea2108 drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes 2021-01-19  2150  	for (j = 0; j < ucc_geth_tx_queues(ug_info); j++) {
9b0dfef4755301 drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes 2021-01-19  2151  		u32 align = max(UCC_GETH_TX_BD_RING_ALIGNMENT,
9b0dfef4755301 drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes 2021-01-19  2152  				UCC_GETH_TX_BD_RING_SIZE_MEMORY_ALIGNMENT);
9b0dfef4755301 drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes 2021-01-19  2153  		u32 alloc;
9b0dfef4755301 drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes 2021-01-19  2154  
9b0dfef4755301 drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes 2021-01-19  2155  		length = ug_info->bdRingLenTx[j] * sizeof(struct qe_bd);
9b0dfef4755301 drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes 2021-01-19  2156  		alloc = round_up(length, align);
9b0dfef4755301 drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes 2021-01-19  2157  		alloc = roundup_pow_of_two(alloc);
9b0dfef4755301 drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes 2021-01-19  2158  
9b0dfef4755301 drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes 2021-01-19  2159  		ugeth->p_tx_bd_ring[j] = kmalloc(alloc, GFP_KERNEL);
64a99fe596f9cb drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes 2021-01-19  2160  
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2161  		if (!ugeth->p_tx_bd_ring[j]) {
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2162  			if (netif_msg_ifup(ugeth))
c84d8055e0c997 drivers/net/ethernet/freescale/ucc_geth.c Joe Perches      2013-04-13  2163  				pr_err("Can not allocate memory for Tx bd rings\n");
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2164  			return -ENOMEM;
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2165  		}
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2166  		/* Zero unused end of bd ring, according to spec */
9b0dfef4755301 drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes 2021-01-19 @2167  		memset(ugeth->p_tx_bd_ring[j] + length, 0, alloc - length);
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2168  	}
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2169  
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2170  	/* Init Tx bds */
53f49d86ea2108 drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes 2021-01-19  2171  	for (j = 0; j < ucc_geth_tx_queues(ug_info); j++) {
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2172  		/* Setup the skbuff rings */
6da2ec56059c3c drivers/net/ethernet/freescale/ucc_geth.c Kees Cook        2018-06-12  2173  		ugeth->tx_skbuff[j] =
33deb13c87e561 drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes 2021-01-19  2174  			kcalloc(ugeth->ug_info->bdRingLenTx[j],
6da2ec56059c3c drivers/net/ethernet/freescale/ucc_geth.c Kees Cook        2018-06-12  2175  				sizeof(struct sk_buff *), GFP_KERNEL);
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2176  
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2177  		if (ugeth->tx_skbuff[j] == NULL) {
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2178  			if (netif_msg_ifup(ugeth))
c84d8055e0c997 drivers/net/ethernet/freescale/ucc_geth.c Joe Perches      2013-04-13  2179  				pr_err("Could not allocate tx_skbuff\n");
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2180  			return -ENOMEM;
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2181  		}
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2182  
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2183  		ugeth->skb_curtx[j] = ugeth->skb_dirtytx[j] = 0;
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2184  		bd = ugeth->confBd[j] = ugeth->txBd[j] = ugeth->p_tx_bd_ring[j];
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2185  		for (i = 0; i < ug_info->bdRingLenTx[j]; i++) {
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2186  			/* clear bd buffer */
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2187  			out_be32(&((struct qe_bd __iomem *)bd)->buf, 0);
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2188  			/* set bd status and length */
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2189  			out_be32((u32 __iomem *)bd, 0);
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2190  			bd += sizeof(struct qe_bd);
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2191  		}
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2192  		bd -= sizeof(struct qe_bd);
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2193  		/* set bd status and length */
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2194  		out_be32((u32 __iomem *)bd, T_W); /* for last BD set Wrap bit */
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2195  	}
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2196  
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2197  	return 0;
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2198  }
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2199  

:::::: The code at line 2167 was first introduced by commit
:::::: 9b0dfef4755301d9f7fcef63e2f64d23649bebb4 ethernet: ucc_geth: simplify rx/tx allocations

:::::: TO: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
:::::: CC: Jakub Kicinski <kuba@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
