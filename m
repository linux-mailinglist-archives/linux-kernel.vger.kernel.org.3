Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90F547DAE0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 00:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244106AbhLVX0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 18:26:08 -0500
Received: from mga05.intel.com ([192.55.52.43]:16418 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230210AbhLVX0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 18:26:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640215567; x=1671751567;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=J7vnVG5q1My3KWcdQmTiXRPCNvGbUpytvZ6Hrp86Z8I=;
  b=hszrZlvlZhlqz0McK+ucVadwLF/nvh9XHgawpBxJGqZp7AjasHVB2GlQ
   B+IK57IHwvLeQZw3uCizM5Mirorpl+aZyXrJPQESzTZCiKAaaTpo7gjSr
   bwpPM6Z+TwwFNlE19W24HjvTYypACvbp92SdxtRt60sd4JMzjUhALI4QG
   TMJs5i4r0DxqKLkC6Dv/LcuFvF7otGVPKXzZPCqFVjtw0Yqguo3OiWBEX
   BZ/KAP3tIMs39LvF0x9snpCjLWIGFXalYFC5zuHI/4zV9DqgAEjD4WKPp
   01leUiHCvNxyOBJy3COxhQa4xPgHXeYqv8kjdJwZlDZGuEmD4BnZmLsL7
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="327030750"
X-IronPort-AV: E=Sophos;i="5.88,227,1635231600"; 
   d="scan'208";a="327030750"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 15:26:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,227,1635231600"; 
   d="scan'208";a="508652227"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 22 Dec 2021 15:26:04 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n0Azk-00013G-15; Wed, 22 Dec 2021 23:26:04 +0000
Date:   Thu, 23 Dec 2021 07:25:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bo Jiao <Bo.Jiao@mediatek.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [nbd168-wireless:mt76 5/28]
 drivers/net/wireless/mediatek/mt76/mt7915/dma.c:97:6: warning: variable
 'base' is used uninitialized whenever 'if' condition is false
Message-ID: <202112230704.dKCp3lmX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/nbd168/wireless mt76
head:   05f0500c7b0147353e97de7369d504c5fbd3951e
commit: 22c2fb9495d35e0c442c23bcd3b8a4a18a28c62d [5/28] mt76: mt7915: rework dma.c to adapt mt7916 changes
config: mips-randconfig-r033-20211222 (https://download.01.org/0day-ci/archive/20211223/202112230704.dKCp3lmX-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project de4e0195ae1c39f1c3b07834b8e32c113f4f20eb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://github.com/nbd168/wireless/commit/22c2fb9495d35e0c442c23bcd3b8a4a18a28c62d
        git remote add nbd168-wireless https://github.com/nbd168/wireless
        git fetch --no-tags nbd168-wireless mt76
        git checkout 22c2fb9495d35e0c442c23bcd3b8a4a18a28c62d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/net/wireless/mediatek/mt76/mt7915/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/mediatek/mt76/mt7915/dma.c:97:6: warning: variable 'base' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           if (!is_mt7915(&dev->mt76)) {
               ^~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/mediatek/mt76/mt7915/dma.c:101:70: note: uninitialized use occurs here
           mt76_wr(dev, MT_RXQ_EXT_CTRL(MT_RXQ_EXT_WA) + ofs, PREFETCH(0x1c0 + base, 0x4));
                                                                               ^~~~
   drivers/net/wireless/mediatek/mt76/mt7915/dma.c:85:35: note: expanded from macro 'PREFETCH'
   #define PREFETCH(_base, _depth) ((_base) << 16 | (_depth))
                                     ^~~~~
   drivers/net/wireless/mediatek/mt76/mt7915/../mt76.h:829:63: note: expanded from macro 'mt76_wr'
   #define mt76_wr(dev, ...)       (dev)->mt76.bus->wr(&((dev)->mt76), __VA_ARGS__)
                                                                       ^~~~~~~~~~~
   drivers/net/wireless/mediatek/mt76/mt7915/dma.c:97:2: note: remove the 'if' if its condition is always true
           if (!is_mt7915(&dev->mt76)) {
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/mediatek/mt76/mt7915/dma.c:86:10: note: initialize the variable 'base' to silence this warning
           u32 base;
                   ^
                    = 0
   1 warning generated.


vim +97 drivers/net/wireless/mediatek/mt76/mt7915/dma.c

    82	
    83	static void __mt7915_dma_prefetch(struct mt7915_dev *dev, u32 ofs)
    84	{
    85	#define PREFETCH(_base, _depth)	((_base) << 16 | (_depth))
    86		u32 base;
    87	
    88		/* prefetch SRAM wrapping boundary for tx/rx ring. */
    89		mt76_wr(dev, MT_MCUQ_EXT_CTRL(MT_MCUQ_FWDL) + ofs, PREFETCH(0x0, 0x4));
    90		mt76_wr(dev, MT_MCUQ_EXT_CTRL(MT_MCUQ_WM) + ofs, PREFETCH(0x40, 0x4));
    91		mt76_wr(dev, MT_TXQ_EXT_CTRL(0) + ofs, PREFETCH(0x80, 0x4));
    92		mt76_wr(dev, MT_TXQ_EXT_CTRL(1) + ofs, PREFETCH(0xc0, 0x4));
    93		mt76_wr(dev, MT_MCUQ_EXT_CTRL(MT_MCUQ_WA) + ofs, PREFETCH(0x100, 0x4));
    94	
    95		mt76_wr(dev, MT_RXQ_EXT_CTRL(MT_RXQ_MCU) + ofs, PREFETCH(0x140, 0x4));
    96		mt76_wr(dev, MT_RXQ_EXT_CTRL(MT_RXQ_MCU_WA) + ofs, PREFETCH(0x180, 0x4));
  > 97		if (!is_mt7915(&dev->mt76)) {
    98			mt76_wr(dev, MT_RXQ_EXT_CTRL(MT_RXQ_MAIN_WA) + ofs, PREFETCH(0x1c0, 0x4));
    99			base = 0x40;
   100		}
   101		mt76_wr(dev, MT_RXQ_EXT_CTRL(MT_RXQ_EXT_WA) + ofs, PREFETCH(0x1c0 + base, 0x4));
   102		mt76_wr(dev, MT_RXQ_EXT_CTRL(MT_RXQ_MAIN) + ofs, PREFETCH(0x200 + base, 0x4));
   103		mt76_wr(dev, MT_RXQ_EXT_CTRL(MT_RXQ_EXT) + ofs, PREFETCH(0x240 + base, 0x4));
   104	
   105		/* for mt7915, the ring which is next the last
   106		 * used ring must be initialized.
   107		 */
   108		if (is_mt7915(&dev->mt76)) {
   109			ofs += 0x4;
   110			mt76_wr(dev, MT_MCUQ_EXT_CTRL(MT_MCUQ_WA) + ofs, PREFETCH(0x140, 0x0));
   111			mt76_wr(dev, MT_RXQ_EXT_CTRL(MT_RXQ_EXT_WA) + ofs, PREFETCH(0x200 + base, 0x0));
   112			mt76_wr(dev, MT_RXQ_EXT_CTRL(MT_RXQ_EXT) + ofs, PREFETCH(0x280 + base, 0x0));
   113		}
   114	}
   115	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
