Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADEA483952
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 00:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbiACXyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 18:54:21 -0500
Received: from mga14.intel.com ([192.55.52.115]:10581 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229487AbiACXyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 18:54:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641254060; x=1672790060;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0tTNwPj9eh86ZKv6XZ+eWl8bR/RHsuhQnDF4yLvJLd4=;
  b=BDzDZn1BjIjffRuZPn/mfTY7SAMIxWzg51ehgTh+SdYizyEEjfji/pOP
   ZsNDdiDLYUwgpN0gE/zB0TRd9ipf9LzBgT9WH2iJPAWVf/I0SHFi9w3Y8
   Y7E/43v5AMAV969gJKdpxQfmxsfVWMWwhSfaBqYVeJR9vPnqf1zWZBgcY
   ATX2G5T2F079uQDTwWKR+hXMf6k9ZOSkVUo+9rPvTIaGJ9yoAqUWyi+tJ
   oq9oKAff0VwPCJoY3Iynqb2LfQBLB2NolwF+lMWPPr373xzXdKT2clLyJ
   yOZWMhBL/gCqBLcTksBSfMncyGTHTK4NfXB5IiCtQT0UK2bGa3+/oRNqt
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="242337426"
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="242337426"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 15:54:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="620456626"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 03 Jan 2022 15:54:18 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n4X9d-000EVZ-Nj; Mon, 03 Jan 2022 23:54:17 +0000
Date:   Tue, 4 Jan 2022 07:53:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [narmstrong-oxnas:oxnas/v5.10/sata 3/3]
 drivers/ata/sata_ox810se.c:68:34: warning: cast from pointer to integer of
 different size
Message-ID: <202201040748.nmgUInv1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/narmstrong/linux-oxnas.git oxnas/v5.10/sata
head:   acba9b2498a048f1a89fdac6f661ec263e369e76
commit: acba9b2498a048f1a89fdac6f661ec263e369e76 [3/3] fixup! ata: Add Oxford Semiconductor OX810SE SATA Controller Support
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20220104/202201040748.nmgUInv1-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/narmstrong/linux-oxnas.git/commit/?id=acba9b2498a048f1a89fdac6f661ec263e369e76
        git remote add narmstrong-oxnas https://git.kernel.org/pub/scm/linux/kernel/git/narmstrong/linux-oxnas.git
        git fetch --no-tags narmstrong-oxnas oxnas/v5.10/sata
        git checkout acba9b2498a048f1a89fdac6f661ec263e369e76
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash drivers/ata/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/ata/sata_ox810se.c:408:27: warning: initialized field overwritten [-Woverride-init]
     408 |     .can_queue          = SATA_OXNAS_QUEUE_DEPTH,
         |                           ^~~~~~~~~~~~~~~~~~~~~~
   drivers/ata/sata_ox810se.c:408:27: note: (near initialization for 'ox810sata_sht.can_queue')
   drivers/ata/sata_ox810se.c: In function 'ox810sata_port_no':
>> drivers/ata/sata_ox810se.c:68:34: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      68 | #define NULLPTR(x)              ((u32)x < PAGE_SIZE)
         |                                  ^
   drivers/ata/sata_ox810se.c:518:9: note: in expansion of macro 'NULLPTR'
     518 |     if (NULLPTR(ap))
         |         ^~~~~~~
   drivers/ata/sata_ox810se.c: In function 'ox810sata_other_port_no':
>> drivers/ata/sata_ox810se.c:68:34: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      68 | #define NULLPTR(x)              ((u32)x < PAGE_SIZE)
         |                                  ^
   drivers/ata/sata_ox810se.c:525:9: note: in expansion of macro 'NULLPTR'
     525 |     if (NULLPTR(ap))
         |         ^~~~~~~
   drivers/ata/sata_ox810se.c: In function 'ox810sata_other_ap':
>> drivers/ata/sata_ox810se.c:68:34: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      68 | #define NULLPTR(x)              ((u32)x < PAGE_SIZE)
         |                                  ^
   drivers/ata/sata_ox810se.c:536:10: note: in expansion of macro 'NULLPTR'
     536 |     if (!NULLPTR(ap)) {
         |          ^~~~~~~
   drivers/ata/sata_ox810se.c: In function 'ox810sata_dma_abort':
>> drivers/ata/sata_ox810se.c:68:34: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      68 | #define NULLPTR(x)              ((u32)x < PAGE_SIZE)
         |                                  ^
   drivers/ata/sata_ox810se.c:631:10: note: in expansion of macro 'NULLPTR'
     631 |     if (!NULLPTR(ox810sata_hd.chan)) {
         |          ^~~~~~~
>> drivers/ata/sata_ox810se.c:68:34: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      68 | #define NULLPTR(x)              ((u32)x < PAGE_SIZE)
         |                                  ^
   drivers/ata/sata_ox810se.c:633:14: note: in expansion of macro 'NULLPTR'
     633 |         if (!NULLPTR(ox810sata_hd.desc)) {
         |              ^~~~~~~
   drivers/ata/sata_ox810se.c: In function 'ox810sata_qc_from_tag':
>> drivers/ata/sata_ox810se.c:68:34: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      68 | #define NULLPTR(x)              ((u32)x < PAGE_SIZE)
         |                                  ^
   drivers/ata/sata_ox810se.c:651:10: note: in expansion of macro 'NULLPTR'
     651 |     if (!NULLPTR(ap)) {
         |          ^~~~~~~
>> drivers/ata/sata_ox810se.c:68:34: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      68 | #define NULLPTR(x)              ((u32)x < PAGE_SIZE)
         |                                  ^
   drivers/ata/sata_ox810se.c:654:18: note: in expansion of macro 'NULLPTR'
     654 |             if (!NULLPTR(qc) && qc->tag != ap->link.active_tag)
         |                  ^~~~~~~
   drivers/ata/sata_ox810se.c: In function 'ox810sata_active_qc':
>> drivers/ata/sata_ox810se.c:68:34: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      68 | #define NULLPTR(x)              ((u32)x < PAGE_SIZE)
         |                                  ^
   drivers/ata/sata_ox810se.c:664:33: note: in expansion of macro 'NULLPTR'
     664 |     ox810sata_port_priv_t *pd = NULLPTR(ap) ? NULL : ap->private_data;
         |                                 ^~~~~~~
>> drivers/ata/sata_ox810se.c:68:34: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      68 | #define NULLPTR(x)              ((u32)x < PAGE_SIZE)
         |                                  ^
   drivers/ata/sata_ox810se.c:665:34: note: in expansion of macro 'NULLPTR'
     665 |     struct ata_queued_cmd *qc0 = NULLPTR(ap)
         |                                  ^~~~~~~
>> drivers/ata/sata_ox810se.c:68:34: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      68 | #define NULLPTR(x)              ((u32)x < PAGE_SIZE)
         |                                  ^
   drivers/ata/sata_ox810se.c:667:33: note: in expansion of macro 'NULLPTR'
     667 |     struct ata_queued_cmd *qc = NULLPTR(pd)
         |                                 ^~~~~~~
>> drivers/ata/sata_ox810se.c:68:34: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      68 | #define NULLPTR(x)              ((u32)x < PAGE_SIZE)
         |                                  ^
   drivers/ata/sata_ox810se.c:670:10: note: in expansion of macro 'NULLPTR'
     670 |     if (!NULLPTR(qc)) {
         |          ^~~~~~~
>> drivers/ata/sata_ox810se.c:68:34: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      68 | #define NULLPTR(x)              ((u32)x < PAGE_SIZE)
         |                                  ^
   drivers/ata/sata_ox810se.c:680:10: note: in expansion of macro 'NULLPTR'
     680 |     if (!NULLPTR(qc) && !NULLPTR(qc0) && qc != qc0) {
         |          ^~~~~~~
>> drivers/ata/sata_ox810se.c:68:34: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      68 | #define NULLPTR(x)              ((u32)x < PAGE_SIZE)
         |                                  ^
   drivers/ata/sata_ox810se.c:680:26: note: in expansion of macro 'NULLPTR'
     680 |     if (!NULLPTR(qc) && !NULLPTR(qc0) && qc != qc0) {
         |                          ^~~~~~~
   drivers/ata/sata_ox810se.c: In function 'ox810sata_cs_error_clear':
>> drivers/ata/sata_ox810se.c:68:34: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      68 | #define NULLPTR(x)              ((u32)x < PAGE_SIZE)
         |                                  ^
   drivers/ata/sata_ox810se.c:695:10: note: in expansion of macro 'NULLPTR'
     695 |     if (!NULLPTR(ap))
         |          ^~~~~~~
   drivers/ata/sata_ox810se.c: In function 'ox810sata_sctl_error_clear':
>> drivers/ata/sata_ox810se.c:68:34: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      68 | #define NULLPTR(x)              ((u32)x < PAGE_SIZE)
         |                                  ^
   drivers/ata/sata_ox810se.c:703:10: note: in expansion of macro 'NULLPTR'
     703 |     if (!NULLPTR(ap))
         |          ^~~~~~~
   drivers/ata/sata_ox810se.c: In function 'ox810sata_reg_access_error_clear':
>> drivers/ata/sata_ox810se.c:68:34: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      68 | #define NULLPTR(x)              ((u32)x < PAGE_SIZE)
         |                                  ^
   drivers/ata/sata_ox810se.c:713:10: note: in expansion of macro 'NULLPTR'
     713 |     if (!NULLPTR(ap))
         |          ^~~~~~~
   drivers/ata/sata_ox810se.c: In function 'ox810sata_qc_data_protocol':
>> drivers/ata/sata_ox810se.c:68:34: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      68 | #define NULLPTR(x)              ((u32)x < PAGE_SIZE)
         |                                  ^
   drivers/ata/sata_ox810se.c:777:12: note: in expansion of macro 'NULLPTR'
     777 |     return NULLPTR(qc)
         |            ^~~~~~~
   drivers/ata/sata_ox810se.c: In function 'ox810sata_qc_complete':
>> drivers/ata/sata_ox810se.c:68:34: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      68 | #define NULLPTR(x)              ((u32)x < PAGE_SIZE)
         |                                  ^
   drivers/ata/sata_ox810se.c:784:33: note: in expansion of macro 'NULLPTR'
     784 |     ox810sata_port_priv_t *pd = NULLPTR(ap) ? NULL : ap->private_data;
         |                                 ^~~~~~~
>> drivers/ata/sata_ox810se.c:68:34: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      68 | #define NULLPTR(x)              ((u32)x < PAGE_SIZE)
         |                                  ^
   drivers/ata/sata_ox810se.c:788:10: note: in expansion of macro 'NULLPTR'
     788 |     qc = NULLPTR(ap) ? NULL : ox810sata_active_qc(ap);
         |          ^~~~~~~
>> drivers/ata/sata_ox810se.c:68:34: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      68 | #define NULLPTR(x)              ((u32)x < PAGE_SIZE)
         |                                  ^
   drivers/ata/sata_ox810se.c:789:10: note: in expansion of macro 'NULLPTR'
     789 |     if (!NULLPTR(qc)) {
         |          ^~~~~~~
   drivers/ata/sata_ox810se.c:68:34: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      68 | #define NULLPTR(x)              ((u32)x < PAGE_SIZE)
         |                                  ^
   drivers/ata/sata_ox810se.c:790:14: note: in expansion of macro 'NULLPTR'
     790 |         if (!NULLPTR(pd))
         |              ^~~~~~~
   drivers/ata/sata_ox810se.c: In function 'ox810sata_dma_alloc':
   drivers/ata/sata_ox810se.c:68:34: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      68 | #define NULLPTR(x)              ((u32)x < PAGE_SIZE)
         |                                  ^
   drivers/ata/sata_ox810se.c:810:9: note: in expansion of macro 'NULLPTR'
     810 |     if (NULLPTR(ox810sata_hd.chan) || IS_ERR(ox810sata_hd.chan))
         |         ^~~~~~~
   drivers/ata/sata_ox810se.c:68:34: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      68 | #define NULLPTR(x)              ((u32)x < PAGE_SIZE)
         |                                  ^
   drivers/ata/sata_ox810se.c:816:9: note: in expansion of macro 'NULLPTR'
     816 |     if (NULLPTR(ox810sata_hd.chan)) {
         |         ^~~~~~~
   drivers/ata/sata_ox810se.c: In function 'ox810sata_dma_free':
   drivers/ata/sata_ox810se.c:68:34: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      68 | #define NULLPTR(x)              ((u32)x < PAGE_SIZE)
         |                                  ^
   drivers/ata/sata_ox810se.c:836:10: note: in expansion of macro 'NULLPTR'
     836 |     if (!NULLPTR(ox810sata_hd.chan)) {
         |          ^~~~~~~
   drivers/ata/sata_ox810se.c: In function 'ox810sata_dma_busy_check':
   drivers/ata/sata_ox810se.c:68:34: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      68 | #define NULLPTR(x)              ((u32)x < PAGE_SIZE)
         |                                  ^
   drivers/ata/sata_ox810se.c:849:33: note: in expansion of macro 'NULLPTR'
     849 |     struct ata_queued_cmd *qc = NULLPTR(ap) ? NULL : ox810sata_active_qc(ap);
         |                                 ^~~~~~~
   drivers/ata/sata_ox810se.c:68:34: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      68 | #define NULLPTR(x)              ((u32)x < PAGE_SIZE)
         |                                  ^
   drivers/ata/sata_ox810se.c:850:20: note: in expansion of macro 'NULLPTR'
     850 |     bool use_dma = NULLPTR(qc) ? true : ox810sata_qc_data_protocol(qc);
         |                    ^~~~~~~
   drivers/ata/sata_ox810se.c:68:34: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      68 | #define NULLPTR(x)              ((u32)x < PAGE_SIZE)
         |                                  ^
   drivers/ata/sata_ox810se.c:852:9: note: in expansion of macro 'NULLPTR'
     852 |     if (NULLPTR(ox810sata_hd.chan) || !use_dma)
         |         ^~~~~~~
   drivers/ata/sata_ox810se.c:68:34: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      68 | #define NULLPTR(x)              ((u32)x < PAGE_SIZE)
         |                                  ^
   drivers/ata/sata_ox810se.c:857:9: note: in expansion of macro 'NULLPTR'
     857 |         NULLPTR(ox810sata_hd.desc) ? false
         |         ^~~~~~~
   drivers/ata/sata_ox810se.c: In function 'ox810sata_srst_send':
   drivers/ata/sata_ox810se.c:68:34: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      68 | #define NULLPTR(x)              ((u32)x < PAGE_SIZE)
         |                                  ^
   drivers/ata/sata_ox810se.c:934:9: note: in expansion of macro 'NULLPTR'
     934 |     if (NULLPTR(ap))
         |         ^~~~~~~
   drivers/ata/sata_ox810se.c: In function 'ox810sata_link_read':
   drivers/ata/sata_ox810se.c:68:34: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      68 | #define NULLPTR(x)              ((u32)x < PAGE_SIZE)
         |                                  ^
   drivers/ata/sata_ox810se.c:982:10: note: in expansion of macro 'NULLPTR'
     982 |     if (!NULLPTR(lock) && !in_irq())
         |          ^~~~~~~
   drivers/ata/sata_ox810se.c:68:34: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      68 | #define NULLPTR(x)              ((u32)x < PAGE_SIZE)
         |                                  ^
   drivers/ata/sata_ox810se.c:997:10: note: in expansion of macro 'NULLPTR'
     997 |     if (!NULLPTR(lock) && !in_irq())
         |          ^~~~~~~
   drivers/ata/sata_ox810se.c: In function 'ox810sata_scr_read_port':
   drivers/ata/sata_ox810se.c:68:34: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      68 | #define NULLPTR(x)              ((u32)x < PAGE_SIZE)
         |                                  ^
   drivers/ata/sata_ox810se.c:1015:33: note: in expansion of macro 'NULLPTR'
    1015 |     ox810sata_port_priv_t *pd = NULLPTR(ap) ? NULL : ap->private_data;
         |                                 ^~~~~~~
   drivers/ata/sata_ox810se.c:68:34: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      68 | #define NULLPTR(x)              ((u32)x < PAGE_SIZE)
         |                                  ^
   drivers/ata/sata_ox810se.c:1016:24: note: in expansion of macro 'NULLPTR'
    1016 |     spinlock_t *lock = NULLPTR(pd) ? NULL : &pd->scrlock;
         |                        ^~~~~~~
   drivers/ata/sata_ox810se.c: In function 'ox810sata_link_write':
   drivers/ata/sata_ox810se.c:68:34: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      68 | #define NULLPTR(x)              ((u32)x < PAGE_SIZE)
         |                                  ^
   drivers/ata/sata_ox810se.c:1035:10: note: in expansion of macro 'NULLPTR'
    1035 |     if (!NULLPTR(lock) && !in_irq())
         |          ^~~~~~~
   drivers/ata/sata_ox810se.c:68:34: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      68 | #define NULLPTR(x)              ((u32)x < PAGE_SIZE)
         |                                  ^
   drivers/ata/sata_ox810se.c:1050:10: note: in expansion of macro 'NULLPTR'


vim +68 drivers/ata/sata_ox810se.c

    66	
    67	#define SCR2LINK(x)             (0x20 + (x * 4))
  > 68	#define NULLPTR(x)              ((u32)x < PAGE_SIZE)
    69	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
