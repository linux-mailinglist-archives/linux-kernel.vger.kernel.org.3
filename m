Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E14578706
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 18:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbiGRQKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 12:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbiGRQKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 12:10:32 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABDCE09E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 09:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658160631; x=1689696631;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qEI+xSN8z8yNfP/xrkdu2rvWsTvYXiEHUWjowQURV1A=;
  b=ngzaMbQ6AtLjsA1zQ7jNHkUxJg7xjs2UuhFoSfnnYUACytXbrVtNM2e2
   8JAu/sQwLA23DANRtR13ZReOsBn6fLa4MMqlmT5m2QvxJResW+IxSxURv
   ruAdfJuq0T2u4SekC1AZGP2bG/HxA3EQnj53v+s1rLZYLLpATXUA3gWNe
   qnes2hBPXw7cd0Z24Unta49cmbTeJHmePp8iL6/smP4sB0lFpd+Yr6QrO
   cJ7r7iW68P6KwGcbPvCkgBocuKE/Tq9Ywqk5gOkmc1wIdUTHQ/xefjlCd
   WPVS/u4AOPnOKPDpceUWOkHTNvN4zlUBzp6THw6ag2VKrsqV3s1FaYsi+
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="287408611"
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="287408611"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 09:10:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="723909221"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 18 Jul 2022 09:10:29 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oDTKH-0004Xq-0b;
        Mon, 18 Jul 2022 16:10:29 +0000
Date:   Tue, 19 Jul 2022 00:09:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Janne Grunau <j@jannau.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [asahilinux:bits/090-spi-hid 11/20]
 drivers/hid/spi-hid/spi-hid-apple-core.c:233:21: sparse: sparse: incorrect
 type in assignment (different base types)
Message-ID: <202207190046.Jq1oHjI1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/090-spi-hid
head:   9ba6190c21ccc52b6edd87f55e8aa65959bc170c
commit: caee9bbb3f5dd71fbcc4690a7c2e97ff6964ab92 [11/20] WIP: HID: transport: spi: add Apple SPI transport
config: parisc-randconfig-s041-20220715 (https://download.01.org/0day-ci/archive/20220719/202207190046.Jq1oHjI1-lkp@intel.com/config)
compiler: hppa64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/AsahiLinux/linux/commit/caee9bbb3f5dd71fbcc4690a7c2e97ff6964ab92
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/090-spi-hid
        git checkout caee9bbb3f5dd71fbcc4690a7c2e97ff6964ab92
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=parisc64 SHELL=/bin/bash drivers/bluetooth/ drivers/hid/spi-hid/ drivers/media/i2c/ drivers/net/wireless/broadcom/brcm80211/brcmfmac/ drivers/pci/ drivers/soc/apple/ kernel/trace/ security/apparmor/ sound/soc/codecs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/hid/spi-hid/spi-hid-apple-core.c:233:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] length @@     got unsigned long @@
   drivers/hid/spi-hid/spi-hid-apple-core.c:233:21: sparse:     expected restricted __le16 [usertype] length
   drivers/hid/spi-hid/spi-hid-apple-core.c:233:21: sparse:     got unsigned long
   drivers/hid/spi-hid/spi-hid-apple-core.c:248:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] crc16 @@     got unsigned short @@
   drivers/hid/spi-hid/spi-hid-apple-core.c:248:20: sparse:     expected restricted __le16 [usertype] crc16
   drivers/hid/spi-hid/spi-hid-apple-core.c:248:20: sparse:     got unsigned short
   drivers/hid/spi-hid/spi-hid-apple-core.c:259:21: sparse: sparse: symbol 'spihid_get_data' was not declared. Should it be static?
>> drivers/hid/spi-hid/spi-hid-apple-core.c:639:67: sparse: sparse: incorrect type in argument 5 (different base types) @@     expected unsigned long [usertype] len @@     got restricted __le16 [usertype] length @@
   drivers/hid/spi-hid/spi-hid-apple-core.c:639:67: sparse:     expected unsigned long [usertype] len
   drivers/hid/spi-hid/spi-hid-apple-core.c:639:67: sparse:     got restricted __le16 [usertype] length
   drivers/hid/spi-hid/spi-hid-apple-core.c:643:54: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected unsigned long [usertype] len @@     got restricted __le16 [usertype] length @@
   drivers/hid/spi-hid/spi-hid-apple-core.c:643:54: sparse:     expected unsigned long [usertype] len
   drivers/hid/spi-hid/spi-hid-apple-core.c:643:54: sparse:     got restricted __le16 [usertype] length
   drivers/hid/spi-hid/spi-hid-apple-core.c:664:17: sparse: sparse: incorrect type in argument 7 (different base types) @@     expected unsigned long [usertype] len @@     got restricted __le16 [usertype] length @@
   drivers/hid/spi-hid/spi-hid-apple-core.c:664:17: sparse:     expected unsigned long [usertype] len
   drivers/hid/spi-hid/spi-hid-apple-core.c:664:17: sparse:     got restricted __le16 [usertype] length
   drivers/hid/spi-hid/spi-hid-apple-core.c:686:16: sparse: sparse: restricted __le16 degrades to integer
   drivers/hid/spi-hid/spi-hid-apple-core.c:700:43: sparse: sparse: restricted __le16 degrades to integer
   drivers/hid/spi-hid/spi-hid-apple-core.c:703:23: sparse: sparse: restricted __le16 degrades to integer
   drivers/hid/spi-hid/spi-hid-apple-core.c:704:24: sparse: sparse: restricted __le16 degrades to integer
   drivers/hid/spi-hid/spi-hid-apple-core.c:704:47: sparse: sparse: restricted __le16 degrades to integer
   drivers/hid/spi-hid/spi-hid-apple-core.c:709:38: sparse: sparse: restricted __le16 degrades to integer
>> drivers/hid/spi-hid/spi-hid-apple-core.c:709:62: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned long [usertype] count @@     got restricted __le16 [usertype] length @@
   drivers/hid/spi-hid/spi-hid-apple-core.c:709:62: sparse:     expected unsigned long [usertype] count
   drivers/hid/spi-hid/spi-hid-apple-core.c:709:62: sparse:     got restricted __le16 [usertype] length
   drivers/hid/spi-hid/spi-hid-apple-core.c:710:29: sparse: sparse: invalid assignment: +=
   drivers/hid/spi-hid/spi-hid-apple-core.c:710:29: sparse:    left side has type unsigned int
   drivers/hid/spi-hid/spi-hid-apple-core.c:710:29: sparse:    right side has type restricted __le16
   drivers/hid/spi-hid/spi-hid-apple-core.c:735:23: sparse: sparse: restricted __le16 degrades to integer

vim +233 drivers/hid/spi-hid/spi-hid-apple-core.c

   187	
   188	/*
   189	 * how HID is mapped onto the protocol is not fully clear. This are the known
   190	 * reports/request:
   191	 *
   192	 *			pkt.flags	pkt.dev?	msg.u0	msg.u1	msg.u2
   193	 * info			0x40		0xd0		0x20	0x01	0xd0
   194	 *
   195	 * info mngt:		0x40		0xd0		0x20	0x10	0x00
   196	 * info kbd:		0x40		0xd0		0x20	0x10	0x01
   197	 * info tp:		0x40		0xd0		0x20	0x10	0x02
   198	 *
   199	 * desc kbd:		0x40		0xd0		0x20	0x10	0x01
   200	 * desc trackpad:	0x40		0xd0		0x20	0x10	0x02
   201	 *
   202	 * mt mode:		0x40		0x02		0x52	0x02	0x00	set protocol?
   203	 * capslock led		0x40		0x01		0x51	0x01	0x00	output report
   204	 *
   205	 * report kbd:		0x20		0x01		0x10	0x01	0x00	input report
   206	 * report tp:		0x20		0x02		0x10	0x02	0x00	input report
   207	 *
   208	 */
   209	
   210	
   211	static int spihid_apple_request(struct spihid_apple *spihid, u8 target, u8 unk0,
   212					u8 unk1, u8 unk2, u16 resp_len, u8 *buf,
   213					    size_t len)
   214	{
   215		struct spihid_transfer_packet *pkt;
   216		struct spihid_msg_hdr *hdr;
   217		u16 crc;
   218		int err;
   219	
   220		/* know reports are small enoug to fit in a single packet */
   221		if (len > sizeof(pkt->data) - sizeof(*hdr) - sizeof(__le16))
   222			return -EINVAL;
   223	
   224		err = mutex_lock_interruptible(&spihid->tx_lock);
   225		if (err < 0)
   226			return err;
   227	
   228		pkt = (struct spihid_transfer_packet *)spihid->tx_buf;
   229	
   230		memset(pkt, 0, sizeof(*pkt));
   231		pkt->flags = SPIHID_WRITE_PACKET;
   232		pkt->device = target;
 > 233		pkt->length = sizeof(*hdr) + len + sizeof(__le16);
   234	
   235		hdr = (struct spihid_msg_hdr *)&pkt->data[0];
   236		hdr->unknown0 = unk0;
   237		hdr->unknown1 = unk1;
   238		hdr->unknown2 = unk2;
   239		hdr->id = spihid->msg_id++;
   240		hdr->rsplen = cpu_to_le16(resp_len);
   241		hdr->length = cpu_to_le16(len);
   242	
   243		if (len)
   244			memcpy(pkt->data + sizeof(*hdr), buf, len);
   245		crc = crc16(0, &pkt->data[0], sizeof(*hdr) + len);
   246		put_unaligned_le16(crc, pkt->data + sizeof(*hdr) + len);
   247	
   248		pkt->crc16 = crc16(0, spihid->tx_buf,
   249				   offsetof(struct spihid_transfer_packet, crc16));
   250	
   251		err = spi_sync(spihid->spidev, &spihid->tx_msg);
   252		mutex_unlock(&spihid->tx_lock);
   253		if (err < 0)
   254			return err;
   255	
   256		return (int)len;
   257	}
   258	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
