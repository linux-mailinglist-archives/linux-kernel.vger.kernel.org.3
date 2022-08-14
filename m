Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A194591EC8
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 08:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240373AbiHNGqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 02:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240361AbiHNGp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 02:45:26 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0684F6CD18
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 23:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660459489; x=1691995489;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=owEgZxnm0169Ns5wQ68R67g0lZf1ifsfr0boCRr2+VI=;
  b=INGU1mjNDELHVBDlFk/CfFSqXqVrk2YM/SF2QXnTSsEGVYtMz9+NFSMt
   pff4DGx1oUjA5X0PSEpFLC2WUYxRuktEIg2kTuL4vNrXB1er+GxQJxKtr
   ZLN+9fX9REz5Nr2Ke+VU5BxD0RDIl8vg18GSZsdv/qqZZF8lAivF8qbm3
   lmvMY1jhatFirkU7VLAbXH2nQA4n3FxtAmn6vQsW8n8AtDve/YjKKDPAS
   TY6gvnZfnkWjERYMJIFs8h25p9798RJFUiYJ31hbyMchUnG8BdljeOEps
   i+1ghyC91o6WHTF9ETJtNg2plOu6pd454QMlyU3oIctb7wJnqbfCrg8Ik
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="272195472"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="272195472"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 23:44:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="556953076"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 13 Aug 2022 23:44:45 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oN7Mb-0002aj-07;
        Sun, 14 Aug 2022 06:44:45 +0000
Date:   Sun, 14 Aug 2022 14:44:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: drivers/net/ethernet/freescale/ucc_geth.c:1838:50: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <202208141414.oQzAXKP0-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   aea23e7c464bfdec04b52cf61edb62030e9e0d0a
commit: 72d67229f522e3331d1eabd9f58d36ae080eb228 slab: clean up function prototypes
date:   9 months ago
config: powerpc-randconfig-s051-20220729 (https://download.01.org/0day-ci/archive/20220814/202208141414.oQzAXKP0-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=72d67229f522e3331d1eabd9f58d36ae080eb228
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 72d67229f522e3331d1eabd9f58d36ae080eb228
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/net/ethernet/freescale/

If you fix the issue, kindly add following tag where applicable
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
>> drivers/net/ethernet/freescale/ucc_geth.c:1838:50: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *objp @@     got unsigned char [noderef] [usertype] __iomem * @@
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
   drivers/net/ethernet/freescale/ucc_geth.c:2167:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got unsigned char [noderef] [usertype] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:2167:47: sparse:     expected void *
   drivers/net/ethernet/freescale/ucc_geth.c:2167:47: sparse:     got unsigned char [noderef] [usertype] __iomem *
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
   drivers/net/ethernet/freescale/ucc_geth.c:2982:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] [usertype] __iomem *p_utodr @@
   drivers/net/ethernet/freescale/ucc_geth.c:2982:22: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:2982:22: sparse:     got restricted __be16 [noderef] [usertype] __iomem *p_utodr
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

vim +1838 drivers/net/ethernet/freescale/ucc_geth.c

ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang          2006-08-14  1805  
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  1806  static void ucc_geth_free_rx(struct ucc_geth_private *ugeth)
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  1807  {
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  1808  	struct ucc_geth_info *ug_info;
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  1809  	struct ucc_fast_info *uf_info;
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  1810  	u16 i, j;
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  1811  	u8 __iomem *bd;
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  1812  
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  1813  
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  1814  	ug_info = ugeth->ug_info;
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  1815  	uf_info = &ug_info->uf_info;
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  1816  
53f49d86ea2108 drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes 2021-01-19  1817  	for (i = 0; i < ucc_geth_rx_queues(ugeth->ug_info); i++) {
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  1818  		if (ugeth->p_rx_bd_ring[i]) {
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  1819  			/* Return existing data buffers in ring */
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  1820  			bd = ugeth->p_rx_bd_ring[i];
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  1821  			for (j = 0; j < ugeth->ug_info->bdRingLenRx[i]; j++) {
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  1822  				if (ugeth->rx_skbuff[i][j]) {
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  1823  					dma_unmap_single(ugeth->dev,
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  1824  						in_be32(&((struct qe_bd __iomem *)bd)->buf),
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  1825  						ugeth->ug_info->
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  1826  						uf_info.max_rx_buf_length +
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  1827  						UCC_GETH_RX_DATA_BUF_ALIGNMENT,
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  1828  						DMA_FROM_DEVICE);
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  1829  					dev_kfree_skb_any(
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  1830  						ugeth->rx_skbuff[i][j]);
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  1831  					ugeth->rx_skbuff[i][j] = NULL;
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  1832  				}
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  1833  				bd += sizeof(struct qe_bd);
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  1834  			}
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  1835  
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  1836  			kfree(ugeth->rx_skbuff[i]);
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  1837  
9b0dfef4755301 drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes 2021-01-19 @1838  			kfree(ugeth->p_rx_bd_ring[i]);
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  1839  			ugeth->p_rx_bd_ring[i] = NULL;
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  1840  		}
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  1841  	}
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  1842  

:::::: The code at line 1838 was first introduced by commit
:::::: 9b0dfef4755301d9f7fcef63e2f64d23649bebb4 ethernet: ucc_geth: simplify rx/tx allocations

:::::: TO: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
:::::: CC: Jakub Kicinski <kuba@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
