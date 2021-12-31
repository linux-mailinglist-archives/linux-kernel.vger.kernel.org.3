Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED894825C8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 21:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbhLaUmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 15:42:15 -0500
Received: from mga05.intel.com ([192.55.52.43]:45521 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230182AbhLaUmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 15:42:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640983334; x=1672519334;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8elW+lqaNwCgVQR16drVD3/HOGfS55e1vCJPLAvQSxo=;
  b=KFoAyh3OuXqvAri+6sl+CJdHeNISunvjuyJUyzcQrN7c5IKaoIq8R78W
   /w625oBkamVqGIIc8l3ZoeJZoVp1OmCEnCcnRyY55nVFp1oJdMdMtmmpw
   lY4TiQQGuoRZhTTiuf7z3bhiOyCJwyMVM2mkdYMtEINWzxyT6iGZcM9Nr
   ofL5XWGilIcHpKMfAYRYIrTtjr4LrxUaRCnDgd9wiSMfet5gKBWDi1lOI
   02QeCZS+GSNdg5vm5I48l1eYUw9ljxeA4ufOK2WyUq1yk50xPRGLLiNew
   diut0Ehh9nBQpFUzDO6omWNSZ91eZnr0gmRDuhtaKaidKr9vfz3CuOwft
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10213"; a="328178827"
X-IronPort-AV: E=Sophos;i="5.88,252,1635231600"; 
   d="scan'208";a="328178827"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2021 12:42:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,252,1635231600"; 
   d="scan'208";a="471022899"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 31 Dec 2021 12:42:12 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n3Oj5-000BfB-PC; Fri, 31 Dec 2021 20:42:11 +0000
Date:   Sat, 1 Jan 2022 04:42:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: drivers/net/usb/lan78xx.c:2963:27: sparse: sparse: incorrect type in
 assignment (different base types)
Message-ID: <202201010449.pwZ9p571-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4f3d93c6eaff6b84e43b63e0d7a119c5920e1020
commit: d991bb1c8da842a2a0b9dc83b1005e655783f861 include/linux/compiler-gcc.h: sparse can do constant folding of __builtin_bswap*()
date:   8 months ago
config: i386-randconfig-s002-20211123 (https://download.01.org/0day-ci/archive/20220101/202201010449.pwZ9p571-lkp@intel.com/config)
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
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/net/usb/lan78xx.c:2963:29: sparse: sparse: cast to restricted __be16
>> drivers/net/usb/lan78xx.c:2963:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __wsum [usertype] csum @@     got unsigned short [usertype] @@
   drivers/net/usb/lan78xx.c:2963:27: sparse:     expected restricted __wsum [usertype] csum
   drivers/net/usb/lan78xx.c:2963:27: sparse:     got unsigned short [usertype]

vim +2963 drivers/net/usb/lan78xx.c

55d7de9de6c30a Woojung.Huh@microchip.com 2015-07-30  2949  
55d7de9de6c30a Woojung.Huh@microchip.com 2015-07-30  2950  static void lan78xx_rx_csum_offload(struct lan78xx_net *dev,
55d7de9de6c30a Woojung.Huh@microchip.com 2015-07-30  2951  				    struct sk_buff *skb,
55d7de9de6c30a Woojung.Huh@microchip.com 2015-07-30  2952  				    u32 rx_cmd_a, u32 rx_cmd_b)
55d7de9de6c30a Woojung.Huh@microchip.com 2015-07-30  2953  {
9343ac87f2a4e0 Dave Stevenson            2018-06-25  2954  	/* HW Checksum offload appears to be flawed if used when not stripping
9343ac87f2a4e0 Dave Stevenson            2018-06-25  2955  	 * VLAN headers. Drop back to S/W checksums under these conditions.
9343ac87f2a4e0 Dave Stevenson            2018-06-25  2956  	 */
55d7de9de6c30a Woojung.Huh@microchip.com 2015-07-30  2957  	if (!(dev->net->features & NETIF_F_RXCSUM) ||
9343ac87f2a4e0 Dave Stevenson            2018-06-25  2958  	    unlikely(rx_cmd_a & RX_CMD_A_ICSM_) ||
9343ac87f2a4e0 Dave Stevenson            2018-06-25  2959  	    ((rx_cmd_a & RX_CMD_A_FVTG_) &&
9343ac87f2a4e0 Dave Stevenson            2018-06-25  2960  	     !(dev->net->features & NETIF_F_HW_VLAN_CTAG_RX))) {
55d7de9de6c30a Woojung.Huh@microchip.com 2015-07-30  2961  		skb->ip_summed = CHECKSUM_NONE;
55d7de9de6c30a Woojung.Huh@microchip.com 2015-07-30  2962  	} else {
55d7de9de6c30a Woojung.Huh@microchip.com 2015-07-30 @2963  		skb->csum = ntohs((u16)(rx_cmd_b >> RX_CMD_B_CSUM_SHIFT_));
55d7de9de6c30a Woojung.Huh@microchip.com 2015-07-30  2964  		skb->ip_summed = CHECKSUM_COMPLETE;
55d7de9de6c30a Woojung.Huh@microchip.com 2015-07-30  2965  	}
55d7de9de6c30a Woojung.Huh@microchip.com 2015-07-30  2966  }
55d7de9de6c30a Woojung.Huh@microchip.com 2015-07-30  2967  

:::::: The code at line 2963 was first introduced by commit
:::::: 55d7de9de6c30adce8d675c7ce513e283829c2ff Microchip's LAN7800 family USB 2/3 to 10/100/1000 Ethernet device driver

:::::: TO: Woojung.Huh@microchip.com <Woojung.Huh@microchip.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
