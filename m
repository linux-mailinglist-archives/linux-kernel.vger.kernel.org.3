Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87655A9695
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 14:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbiIAMTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 08:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbiIAMTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 08:19:32 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C9C1195F4
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 05:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662034770; x=1693570770;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+NXV3xbzor+SWZoPDSbw3NS0yopPe9tTU0sfkL7B1iY=;
  b=jOR6CoSJklLo274SSjSY2CW7AsORF8pt1JFD2ZLUeuEAYJ6IX5HBmqiJ
   5+qnHrpNvuAJK65kUDC+YBvd9YqFD6rZBAblGlcxFW8mZJkdQeKWUtiA7
   BFjx/Zb6JXuGoS2S+eZNU7O0yopnSTlzGZrNByyQYgLGDYDGHyH50ytDt
   ko2CvgsIiiMbNMAZBh5ZKxh+oGk8lXdDu0Lja/QGwpypBHFMxNuOSJ41L
   gXhsRcdBRn228bwxh9kLE4wEFhes2z1KY9+o4P5tbXFnvcb5KRfqsDxjO
   FahHKdZ3S19dXQ74MzgH4moL7yWFXVcrawKO0iU1C7ld2Q0fZ2FKhd+AK
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="381995123"
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="381995123"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 05:19:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="680833017"
Received: from lkp-server02.sh.intel.com (HELO b138c9e8658c) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 01 Sep 2022 05:19:28 -0700
Received: from kbuild by b138c9e8658c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTjAN-0000HC-17;
        Thu, 01 Sep 2022 12:19:27 +0000
Date:   Thu, 1 Sep 2022 20:18:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: drivers/memstick/host/r592.c:83:22: sparse: sparse: incorrect type
 in argument 1 (different base types)
Message-ID: <202209012019.HHr1fSMX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c5e4d5e99162ba8025d58a3af7ad103f155d2df7
commit: 2255411d1d0f0661d1e5acd5f6edf4e6652a345a powerpc/44x: Fix build failure with GCC 12 (unrecognized opcode: `wrteei')
date:   5 weeks ago
config: powerpc-randconfig-s053-20220901 (https://download.01.org/0day-ci/archive/20220901/202209012019.HHr1fSMX-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2255411d1d0f0661d1e5acd5f6edf4e6652a345a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 2255411d1d0f0661d1e5acd5f6edf4e6652a345a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/dma/ppc4xx/ drivers/memstick/host/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/memstick/host/r592.c:83:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int v @@     got restricted __be32 [usertype] @@
   drivers/memstick/host/r592.c:83:22: sparse:     expected unsigned int v
   drivers/memstick/host/r592.c:83:22: sparse:     got restricted __be32 [usertype]
>> drivers/memstick/host/r592.c:83:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int v @@     got restricted __be32 [usertype] @@
   drivers/memstick/host/r592.c:83:22: sparse:     expected unsigned int v
   drivers/memstick/host/r592.c:83:22: sparse:     got restricted __be32 [usertype]
>> drivers/memstick/host/r592.c:83:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int v @@     got restricted __be32 [usertype] @@
   drivers/memstick/host/r592.c:83:22: sparse:     expected unsigned int v
   drivers/memstick/host/r592.c:83:22: sparse:     got restricted __be32 [usertype]
   drivers/memstick/host/r592.c:75:16: sparse: sparse: cast to restricted __be32
   drivers/memstick/host/r592.c:75:16: sparse: sparse: cast to restricted __be32
--
>> drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
>> drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
>> drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
>> drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
>> drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
>> drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
>> drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
>> drivers/dma/ppc4xx/adma.c:543:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sg1l @@     got restricted __le32 [usertype] @@
   drivers/dma/ppc4xx/adma.c:543:35: sparse:     expected unsigned int [usertype] sg1l
   drivers/dma/ppc4xx/adma.c:543:35: sparse:     got restricted __le32 [usertype]
>> drivers/dma/ppc4xx/adma.c:544:35: sparse: sparse: invalid assignment: |=
>> drivers/dma/ppc4xx/adma.c:544:35: sparse:    left side has type unsigned int
>> drivers/dma/ppc4xx/adma.c:544:35: sparse:    right side has type restricted __le32
   drivers/dma/ppc4xx/adma.c:589:23: sparse: sparse: invalid assignment: |=
   drivers/dma/ppc4xx/adma.c:589:23: sparse:    left side has type unsigned int
   drivers/dma/ppc4xx/adma.c:589:23: sparse:    right side has type restricted __le32
>> drivers/dma/ppc4xx/adma.c:627:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/dma/ppc4xx/adma.c:627:23: sparse:     expected unsigned int [usertype]
   drivers/dma/ppc4xx/adma.c:627:23: sparse:     got restricted __le32 [usertype]
   drivers/dma/ppc4xx/adma.c:628:23: sparse: sparse: invalid assignment: |=
   drivers/dma/ppc4xx/adma.c:628:23: sparse:    left side has type unsigned int
   drivers/dma/ppc4xx/adma.c:628:23: sparse:    right side has type restricted __le32
>> drivers/dma/ppc4xx/adma.c:653:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] cnt @@     got restricted __le32 [usertype] @@
   drivers/dma/ppc4xx/adma.c:653:34: sparse:     expected unsigned int [usertype] cnt
   drivers/dma/ppc4xx/adma.c:653:34: sparse:     got restricted __le32 [usertype]
>> drivers/dma/ppc4xx/adma.c:686:38: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:686:38: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:686:38: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:687:38: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:687:38: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:687:38: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:688:38: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:688:38: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:688:38: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:689:39: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:689:39: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:689:39: sparse:     got unsigned int *
>> drivers/dma/ppc4xx/adma.c:734:17: sparse: sparse: Using plain integer as NULL pointer
>> drivers/dma/ppc4xx/adma.c:1185:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct dma_regs *dma_reg @@     got struct dma_regs [noderef] __iomem *dma_reg @@
   drivers/dma/ppc4xx/adma.c:1185:25: sparse:     expected struct dma_regs *dma_reg
   drivers/dma/ppc4xx/adma.c:1185:25: sparse:     got struct dma_regs [noderef] __iomem *dma_reg
>> drivers/dma/ppc4xx/adma.c:1186:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1186:34: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1186:34: sparse:     got unsigned int *
>> drivers/dma/ppc4xx/adma.c:1188:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
   drivers/dma/ppc4xx/adma.c:1188:25: sparse:     expected struct xor_regs *xor_reg
   drivers/dma/ppc4xx/adma.c:1188:25: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
>> drivers/dma/ppc4xx/adma.c:1189:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1189:36: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1189:36: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1136:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
   drivers/dma/ppc4xx/adma.c:1136:25: sparse:     expected struct xor_regs *xor_reg
   drivers/dma/ppc4xx/adma.c:1136:25: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
   drivers/dma/ppc4xx/adma.c:1145:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1145:35: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1145:35: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1155:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1155:49: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1155:49: sparse:     got unsigned int *
>> drivers/dma/ppc4xx/adma.c:1157:38: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1157:38: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1157:38: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:909:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct dma_regs *dma_reg @@     got struct dma_regs [noderef] __iomem *dma_reg @@
   drivers/dma/ppc4xx/adma.c:909:25: sparse:     expected struct dma_regs *dma_reg
   drivers/dma/ppc4xx/adma.c:909:25: sparse:     got struct dma_regs [noderef] __iomem *dma_reg
   drivers/dma/ppc4xx/adma.c:910:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:910:40: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:910:40: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:927:37: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:972:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:972:32: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:972:32: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:977:40: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:977:40: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:977:40: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:982:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
   drivers/dma/ppc4xx/adma.c:982:25: sparse:     expected struct xor_regs *xor_reg
   drivers/dma/ppc4xx/adma.c:982:25: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
   drivers/dma/ppc4xx/adma.c:983:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:983:34: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:983:34: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:984:34: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:984:34: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:984:34: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:991:55: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:991:55: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:991:55: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:993:51: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:993:51: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:993:51: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:995:51: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:995:51: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:995:51: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:997:46: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:997:46: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:997:46: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1006:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1006:35: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1006:35: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1025:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct dma_regs *dma_reg @@     got struct dma_regs [noderef] __iomem *dma_reg @@
   drivers/dma/ppc4xx/adma.c:1025:25: sparse:     expected struct dma_regs *dma_reg
   drivers/dma/ppc4xx/adma.c:1025:25: sparse:     got struct dma_regs [noderef] __iomem *dma_reg
>> drivers/dma/ppc4xx/adma.c:1029:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned short * @@
   drivers/dma/ppc4xx/adma.c:1029:31: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1029:31: sparse:     got unsigned short *
   drivers/dma/ppc4xx/adma.c:1029:60: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned short * @@
   drivers/dma/ppc4xx/adma.c:1029:60: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1029:60: sparse:     got unsigned short *
   drivers/dma/ppc4xx/adma.c:1030:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned short * @@
   drivers/dma/ppc4xx/adma.c:1030:31: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1030:31: sparse:     got unsigned short *
   drivers/dma/ppc4xx/adma.c:1030:60: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned short * @@
   drivers/dma/ppc4xx/adma.c:1030:60: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1030:60: sparse:     got unsigned short *
   drivers/dma/ppc4xx/adma.c:1036:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
   drivers/dma/ppc4xx/adma.c:1036:25: sparse:     expected struct xor_regs *xor_reg
   drivers/dma/ppc4xx/adma.c:1036:25: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
   drivers/dma/ppc4xx/adma.c:1037:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1037:37: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1037:37: sparse:     got unsigned int *
>> drivers/dma/ppc4xx/adma.c:1051:48: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
   drivers/dma/ppc4xx/adma.c:1051:48: sparse:     expected struct xor_regs *xor_reg
   drivers/dma/ppc4xx/adma.c:1051:48: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
   drivers/dma/ppc4xx/adma.c:1053:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1053:25: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1053:25: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1060:41: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1060:41: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1060:41: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1062:39: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1062:39: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1062:39: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1063:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1063:25: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1063:25: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1064:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1064:33: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1064:33: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1065:22: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1065:22: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1065:22: sparse:     got unsigned int *
>> drivers/dma/ppc4xx/adma.c:1078:48: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct dma_regs *dma_reg @@     got struct dma_regs [noderef] __iomem *dma_reg @@
   drivers/dma/ppc4xx/adma.c:1078:48: sparse:     expected struct dma_regs *dma_reg
   drivers/dma/ppc4xx/adma.c:1078:48: sparse:     got struct dma_regs [noderef] __iomem *dma_reg
   drivers/dma/ppc4xx/adma.c:1088:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1088:26: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1088:26: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1208:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
   drivers/dma/ppc4xx/adma.c:1208:25: sparse:     expected struct xor_regs *xor_reg
   drivers/dma/ppc4xx/adma.c:1208:25: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
   drivers/dma/ppc4xx/adma.c:1212:30: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1212:30: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1212:30: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:2775:62: sparse: sparse: Using plain integer as NULL pointer
>> drivers/dma/ppc4xx/adma.c:4091:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *regs @@     got void [noderef] __iomem * @@
   drivers/dma/ppc4xx/adma.c:4091:14: sparse:     expected void *regs
   drivers/dma/ppc4xx/adma.c:4091:14: sparse:     got void [noderef] __iomem *
>> drivers/dma/ppc4xx/adma.c:4099:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xor_regs [noderef] __iomem *xor_reg @@     got void *regs @@
   drivers/dma/ppc4xx/adma.c:4099:31: sparse:     expected struct xor_regs [noderef] __iomem *xor_reg
   drivers/dma/ppc4xx/adma.c:4099:31: sparse:     got void *regs
>> drivers/dma/ppc4xx/adma.c:4106:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct dma_regs [noderef] __iomem *dma_reg @@     got void *regs @@
   drivers/dma/ppc4xx/adma.c:4106:31: sparse:     expected struct dma_regs [noderef] __iomem *dma_reg
   drivers/dma/ppc4xx/adma.c:4106:31: sparse:     got void *regs

vim +83 drivers/memstick/host/r592.c

9263412501022f Maxim Levitsky 2011-03-25  77  
9263412501022f Maxim Levitsky 2011-03-25  78  /* Writes a big endian DWORD register */
9263412501022f Maxim Levitsky 2011-03-25  79  static inline void r592_write_reg_raw_be(struct r592_device *dev,
9263412501022f Maxim Levitsky 2011-03-25  80  							int address, u32 value)
9263412501022f Maxim Levitsky 2011-03-25  81  {
9263412501022f Maxim Levitsky 2011-03-25  82  	dbg_reg("reg #%02d <- 0x%08x", address, value);
9263412501022f Maxim Levitsky 2011-03-25 @83  	__raw_writel(cpu_to_be32(value), dev->mmio + address);
9263412501022f Maxim Levitsky 2011-03-25  84  }
9263412501022f Maxim Levitsky 2011-03-25  85  

:::::: The code at line 83 was first introduced by commit
:::::: 9263412501022fecef844907129ee2513b5a89de memstick: add driver for Ricoh R5C592 card reader

:::::: TO: Maxim Levitsky <maximlevitsky@gmail.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
