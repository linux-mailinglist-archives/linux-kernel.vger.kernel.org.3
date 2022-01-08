Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 878D04884C3
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 18:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234783AbiAHRCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 12:02:04 -0500
Received: from mga02.intel.com ([134.134.136.20]:57388 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231398AbiAHRCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 12:02:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641661323; x=1673197323;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PPp4shNkrkr5sM/CPXa3UKR2QAr+sPRGe4T07ev9Mqc=;
  b=gIuKsMpDf+FOS0pjAzxXVnwPuDXIAmhsUslhmX5hjmdjYEPP+D2ZBbfV
   eje4hMHw+RbS/CdNRXovdwin7w9us/7I/jDddhzkpJAzrCzjCCuoqBmd8
   irj9W/0syzeeYlDK0YKYxv8sk/ThG5fu618WDdQFgOiY5oi0O3hoWhXjD
   1fnwell4sNMqnH5vn6RMYCskYLilhNeY1ufbe+gn2EqjyqVLPES5zru2T
   VtNo5U7zDh1SMIu3E9Z1j3zdb9PvLY6o0tZrccmu3MziNEwaHFjApfjVJ
   LC7+ea2LBDFdB0EK4hiIp/HY9W3fVWUGgk2SRgglI2YYrxmM1irReSjYW
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="230367954"
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="230367954"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2022 09:02:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="557573728"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 08 Jan 2022 09:02:01 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6F6P-0000qB-4j; Sat, 08 Jan 2022 17:02:01 +0000
Date:   Sun, 9 Jan 2022 01:01:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 2130/2300] drivers/net/fddi/defza.c:104:16:
 warning: returning 'int' from a function with return type 'struct sk_buff *'
 makes pointer from integer without a cast
Message-ID: <202201090043.nAZcpAke-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   4e348e961395297bb17f101cc63bc133d8a348e9
commit: 849a5d0b76b20f2ffe001b8c745fe15441b98bc7 [2130/2300] headers/deps: net: Optimize <linux/netdevice_api.h> dependencies, remove various headers
config: mips-decstation_defconfig (https://download.01.org/0day-ci/archive/20220109/202201090043.nAZcpAke-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=849a5d0b76b20f2ffe001b8c745fe15441b98bc7
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout 849a5d0b76b20f2ffe001b8c745fe15441b98bc7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/dec/ drivers/net/fddi/ drivers/video/fbdev/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/net/fddi/defza.c: In function 'fza_alloc_skb_irq':
   drivers/net/fddi/defza.c:104:16: error: implicit declaration of function '__netdev_alloc_skb' [-Werror=implicit-function-declaration]
     104 |         return __netdev_alloc_skb(dev, length, GFP_ATOMIC);
         |                ^~~~~~~~~~~~~~~~~~
>> drivers/net/fddi/defza.c:104:16: warning: returning 'int' from a function with return type 'struct sk_buff *' makes pointer from integer without a cast [-Wint-conversion]
     104 |         return __netdev_alloc_skb(dev, length, GFP_ATOMIC);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/fddi/defza.c: In function 'fza_alloc_skb':
   drivers/net/fddi/defza.c:110:16: warning: returning 'int' from a function with return type 'struct sk_buff *' makes pointer from integer without a cast [-Wint-conversion]
     110 |         return __netdev_alloc_skb(dev, length, GFP_KERNEL);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/fddi/defza.c: In function 'fza_skb_align':
   drivers/net/fddi/defza.c:120:9: error: implicit declaration of function 'skb_reserve' [-Werror=implicit-function-declaration]
     120 |         skb_reserve(skb, y - x);
         |         ^~~~~~~~~~~
   drivers/net/fddi/defza.c: In function 'fza_rx':
   drivers/net/fddi/defza.c:757:25: error: implicit declaration of function 'skb_put' [-Werror=implicit-function-declaration]
     757 |                         skb_put(skb, pkt_len);  /* And cut off FCS. */
         |                         ^~~~~~~
   drivers/net/fddi/defza.c: In function 'fza_tx_smt':
   drivers/net/fddi/defza.c:827:33: error: implicit declaration of function 'skb_reset_network_header'; did you mean 'skb_inner_network_header'? [-Werror=implicit-function-declaration]
     827 |                                 skb_reset_network_header(skb);
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~
         |                                 skb_inner_network_header
   drivers/net/fddi/defza.c: In function 'fza_start_xmit':
   drivers/net/fddi/defza.c:1091:9: error: implicit declaration of function 'skb_push' [-Werror=implicit-function-declaration]
    1091 |         skb_push(skb, 3);                       /* Make room for PRH. */
         |         ^~~~~~~~
   drivers/net/fddi/defza.c:1148:9: error: implicit declaration of function 'dev_kfree_skb'; did you mean 'dev_kfree_skb_any'? [-Werror=implicit-function-declaration]
    1148 |         dev_kfree_skb(skb);
         |         ^~~~~~~~~~~~~
         |         dev_kfree_skb_any
   cc1: some warnings being treated as errors


vim +104 drivers/net/fddi/defza.c

61414f5ec9834d Maciej W. Rozycki 2018-10-09  100  
61414f5ec9834d Maciej W. Rozycki 2018-10-09  101  static inline struct sk_buff *fza_alloc_skb_irq(struct net_device *dev,
61414f5ec9834d Maciej W. Rozycki 2018-10-09  102  						unsigned int length)
61414f5ec9834d Maciej W. Rozycki 2018-10-09  103  {
61414f5ec9834d Maciej W. Rozycki 2018-10-09 @104  	return __netdev_alloc_skb(dev, length, GFP_ATOMIC);
61414f5ec9834d Maciej W. Rozycki 2018-10-09  105  }
61414f5ec9834d Maciej W. Rozycki 2018-10-09  106  

:::::: The code at line 104 was first introduced by commit
:::::: 61414f5ec9834df8aa4f55c90de16b71a3d6ca8d FDDI: defza: Add support for DEC FDDIcontroller 700 TURBOchannel adapter

:::::: TO: Maciej W. Rozycki <macro@linux-mips.org>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
