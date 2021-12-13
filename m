Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 884FF471F3C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 03:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhLMCDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 21:03:37 -0500
Received: from mga14.intel.com ([192.55.52.115]:63708 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229436AbhLMCDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 21:03:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639361016; x=1670897016;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TVoA1VIScZ/2Idf6o7SLH4w3ccsFnd5hkPg8FCUkcKU=;
  b=Egy4ACjVAi7cyq0hpBMvNnI7jPyGYQGrnrwwTqbaxrj6u6nDLNRULArA
   QPVNvMqXtRQUBhdJHLt2zTNsz14d65L2X4h8GGI2hDAHFeRvCTO5qcuX1
   +6fHMhdhpceVGaMzVoFUhYOxKjtR6DI2YfGmLj5nRhFndBf9df8DDjMFU
   duhIGukT62mox/HtkHlUzo/75JpnFYTLAG7g0eep0D5p9h52CTbHFIcwo
   5aJubN5G+6P4qIGqhaX9PMVHidL1xO1uiJGf9Q7YWFAwi/u36gHX1rRng
   ffNOSL4aoOmuFaI8V/Aiq406nczP7W4zUbeQPHAI46ezaQ+97Ln+nZ0TL
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="238870867"
X-IronPort-AV: E=Sophos;i="5.88,201,1635231600"; 
   d="scan'208";a="238870867"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2021 18:03:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,201,1635231600"; 
   d="scan'208";a="463220430"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 12 Dec 2021 18:03:34 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mwagf-00069z-JU; Mon, 13 Dec 2021 02:03:33 +0000
Date:   Mon, 13 Dec 2021 10:03:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [jpirko-mlxsw:combined_queue 1009/1044]
 drivers/net/ethernet/mscc/ocelot_fdma.c:737:38: error: no member named
 'dma_addr' in 'struct ocelot_fdma_tx_buf'
Message-ID: <202112130911.uKvnwPy0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jpirko/linux_mlxsw combined_queue
head:   69ba5a4da9c5d6bbf903d21503643ca69492e34c
commit: 753a026cfec1429c9e32e004ae4d4c2727cc0111 [1009/1044] net: ocelot: add FDMA support
config: i386-randconfig-r013-20211212 (https://download.01.org/0day-ci/archive/20211213/202112130911.uKvnwPy0-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 097a1cb1d5ebb3a0ec4bcaed8ba3ff6a8e33c00a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jpirko/linux_mlxsw/commit/753a026cfec1429c9e32e004ae4d4c2727cc0111
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw combined_queue
        git checkout 753a026cfec1429c9e32e004ae4d4c2727cc0111
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/amd/display/dc/dce/ drivers/gpu/drm/amd/display/dc/dcn201/ drivers/gpu/drm/amd/display/dc/dcn21/ drivers/gpu/drm/amd/display/dc/dcn30/ drivers/net/ethernet/mscc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/mscc/ocelot_fdma.c:737:38: error: no member named 'dma_addr' in 'struct ocelot_fdma_tx_buf'
                   dma_unmap_single(ocelot->dev, txb->dma_addr, skb->len,
                                                 ~~~  ^
   include/linux/dma-mapping.h:407:64: note: expanded from macro 'dma_unmap_single'
   #define dma_unmap_single(d, a, s, r) dma_unmap_single_attrs(d, a, s, r, 0)
                                                                  ^
   1 error generated.


vim +737 drivers/net/ethernet/mscc/ocelot_fdma.c

   722	
   723	static void ocelot_fdma_free_tx_ring(struct ocelot *ocelot)
   724	{
   725		struct ocelot_fdma *fdma = ocelot->fdma;
   726		struct ocelot_fdma_tx_ring *tx_ring;
   727		struct ocelot_fdma_tx_buf *txb;
   728		struct sk_buff *skb;
   729		u16 idx;
   730	
   731		tx_ring = &fdma->tx_ring;
   732		idx = tx_ring->next_to_clean;
   733	
   734		while (idx != tx_ring->next_to_use) {
   735			txb = &tx_ring->bufs[idx];
   736			skb = txb->skb;
 > 737			dma_unmap_single(ocelot->dev, txb->dma_addr, skb->len,
   738					 DMA_TO_DEVICE);
   739			dev_kfree_skb_any(skb);
   740			idx = ocelot_fdma_idx_next(idx, OCELOT_FDMA_TX_RING_SIZE);
   741		}
   742	}
   743	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
