Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10618577888
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 00:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbiGQWBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 18:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiGQWBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 18:01:44 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD11A101DD
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 15:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658095303; x=1689631303;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=umrEMe4/Eh9b/p66Di4u3ZYbBAkgYFr5XnpNB3kROiU=;
  b=gl7VpAFNIuXaqxgRR0VzzjZqFUQdr0tQyTHeVQmycQDi+M4V1eLUPrsX
   DxkXlRvLMxI01tK/PrjtComckVBBoHV9HuHljsPmPbCFQ7gnORtGhvBe9
   nHPGetssm4QHH6zXNNVAc1gzvyzcBWwpGmtwfiMUPIxA81aPdRa67Z6Yp
   n+Az5RhtMmSceA4Z3e4WobcGXy50jLkcoSE8JpsnfVGsFP39XBytRfVri
   ghCgIKiNJtusHHsR1m33CpR7guSliVNln2AxaXISovTJ+VKZLqJH6RiEJ
   VDr13wdoW38c9sulRI5avEAkrVYBE3ZiCalmJSJN0xaKzLRrMZ1SAtq3B
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="372404371"
X-IronPort-AV: E=Sophos;i="5.92,279,1650956400"; 
   d="scan'208";a="372404371"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 15:01:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,279,1650956400"; 
   d="scan'208";a="924115200"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 17 Jul 2022 15:01:42 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oDCKb-0003jW-Or;
        Sun, 17 Jul 2022 22:01:41 +0000
Date:   Mon, 18 Jul 2022 06:00:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:bluetooth-wip 9/9]
 drivers/bluetooth/hci_bcm4377.c:886:68: sparse: sparse: incorrect type in
 assignment (different base types)
Message-ID: <202207180545.Tw2sWN1w-lkp@intel.com>
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

tree:   https://github.com/AsahiLinux/linux bluetooth-wip
head:   0148a507e34696326e2b63e626cf0dd46c047cfd
commit: 0148a507e34696326e2b63e626cf0dd46c047cfd [9/9] Bluetooth: hci_bcm4377: Add new driver for BCM4377 PCI boards
config: parisc-randconfig-s041-20220715 (https://download.01.org/0day-ci/archive/20220718/202207180545.Tw2sWN1w-lkp@intel.com/config)
compiler: hppa64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/AsahiLinux/linux/commit/0148a507e34696326e2b63e626cf0dd46c047cfd
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bluetooth-wip
        git checkout 0148a507e34696326e2b63e626cf0dd46c047cfd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=parisc64 SHELL=/bin/bash drivers/bluetooth/ drivers/media/i2c/ drivers/pci/ kernel/trace/ sound/soc/codecs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/bluetooth/hci_bcm4377.c:886:68: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 @@     got int @@
   drivers/bluetooth/hci_bcm4377.c:886:68: sparse:     expected restricted __le16
   drivers/bluetooth/hci_bcm4377.c:886:68: sparse:     got int
>> drivers/bluetooth/hci_bcm4377.c:1352:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] enabled_caps @@     got restricted __le16 [usertype] @@
   drivers/bluetooth/hci_bcm4377.c:1352:36: sparse:     expected restricted __le32 [usertype] enabled_caps
   drivers/bluetooth/hci_bcm4377.c:1352:36: sparse:     got restricted __le16 [usertype]

vim +886 drivers/bluetooth/hci_bcm4377.c

   830	
   831	static int bcm4377_create_transfer_ring(struct bcm4377_data *bcm4377,
   832						struct bcm4377_transfer_ring *ring)
   833	{
   834		struct bcm4377_create_transfer_ring_msg msg;
   835		u16 flags = 0;
   836		int ret, i;
   837		unsigned long spinlock_flags;
   838	
   839		if (ring->virtual)
   840			flags |= BCM4377_XFER_RING_FLAG_VIRTUAL;
   841		if (ring->sync)
   842			flags |= BCM4377_XFER_RING_FLAG_SYNC;
   843	
   844		spin_lock_irqsave(&ring->lock, spinlock_flags);
   845		memset(&msg, 0, sizeof(msg));
   846		msg.msg_type = BCM4377_CONTROL_MSG_CREATE_XFER_RING;
   847		msg.ring_id = cpu_to_le16(ring->ring_id);
   848		msg.ring_id_again = cpu_to_le16(ring->ring_id);
   849		msg.ring_iova = cpu_to_le64(ring->ring_dma);
   850		msg.n_elements = cpu_to_le16(ring->n_entries);
   851		msg.completion_ring_id = cpu_to_le16(ring->completion_ring);
   852		msg.doorbell = cpu_to_le16(ring->doorbell);
   853		msg.flags = cpu_to_le16(flags);
   854		msg.footer_size = ring->payload_size / 4;
   855	
   856		bcm4377->ring_state->xfer_ring_head[ring->ring_id] = 0;
   857		bcm4377->ring_state->xfer_ring_tail[ring->ring_id] = 0;
   858		ring->generation++;
   859		spin_unlock_irqrestore(&ring->lock, spinlock_flags);
   860	
   861		ret = bcm4377_enqueue(bcm4377, &bcm4377->control_h2d_ring, &msg,
   862				      sizeof(msg), true);
   863	
   864		spin_lock_irqsave(&ring->lock, spinlock_flags);
   865	
   866		if (ring->d2h_buffers_only) {
   867			for (i = 0; i < ring->n_entries; ++i) {
   868				struct bcm4377_xfer_ring_entry *entry =
   869					ring->ring + i * sizeof(*entry);
   870				u16 raw_msgid = FIELD_PREP(BCM4377_MSGID_GENERATION,
   871							   ring->generation);
   872				raw_msgid |= FIELD_PREP(BCM4377_MSGID_ID, i);
   873	
   874				memset(entry, 0, sizeof(*entry));
   875				entry->id = cpu_to_le16(raw_msgid);
   876				entry->len = cpu_to_le16(ring->mapped_payload_size);
   877				entry->flags = BCM4377_XFER_RING_FLAG_PAYLOAD_MAPPED;
   878				entry->payload =
   879					cpu_to_le64(ring->payloads_dma +
   880						    i * ring->mapped_payload_size);
   881			}
   882		}
   883	
   884		/* this primes the device->host side */
   885		if (ring->virtual || ring->d2h_buffers_only) {
 > 886			bcm4377->ring_state->xfer_ring_head[ring->ring_id] = 0xf;
   887			bcm4377_ring_doorbell(bcm4377, ring->doorbell, 0xf);
   888		}
   889	
   890		ring->enabled = true;
   891		spin_unlock_irqrestore(&ring->lock, spinlock_flags);
   892	
   893		return ret;
   894	}
   895	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
