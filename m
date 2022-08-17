Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092C9597837
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 22:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242120AbiHQUpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 16:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242117AbiHQUop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:44:45 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92499AB07E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660769078; x=1692305078;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ay1aY0/ZxGxI3okWaaKfeX76PeMG9qEyESpYnSNtmgI=;
  b=D9PSZ73UyTt+5EQoRnZdtD5fibeCkt5Mr4Q56n7/bgXftYvHNdkkfenJ
   iUB+9ry0NSCrbmuwE32bLrfKjNArhT7DKg089FJC2hY/p0hdsW7PMSM8T
   N3mpytfN9Y788Vs/JaS/AMhCUAXA4yywJYGqmuY5FzbH/gctyiVHMyvEj
   Pwd8NofY+/ZyJiKCloVUJy/S/cTd0B7Nae2IRl3tAnF6cWakS1MhIdyj+
   sfFZTwuCOCzmenPM/vOnQVkuq1QSUg8qd8gLSvHF2Yf3/eSgHSVUSQRiF
   Ip1EJWhNK+U2srPzirN48cwgI7Mla7RImGfVnhzWWdaVvNzeAOJ+hqFx+
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="292597368"
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="292597368"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 13:44:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="640606846"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 17 Aug 2022 13:44:35 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oOPty-0001KS-2i;
        Wed, 17 Aug 2022 20:44:34 +0000
Date:   Thu, 18 Aug 2022 04:44:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Janne Grunau <j@jannau.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [asahilinux:bits/090-spi-hid 11/22]
 drivers/hid/spi-hid/spi-hid-apple-core.c:233:21: sparse: sparse: incorrect
 type in assignment (different base types)
Message-ID: <202208180422.pfweR0Ro-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/090-spi-hid
head:   480924e97dddd088c4ed360eb12ecf92a30f19b1
commit: ab84f7572c5928c7412539ab0e51a581ecafe4f1 [11/22] WIP: HID: transport: spi: add Apple SPI transport
config: openrisc-randconfig-s041-20220818 (https://download.01.org/0day-ci/archive/20220818/202208180422.pfweR0Ro-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/AsahiLinux/linux/commit/ab84f7572c5928c7412539ab0e51a581ecafe4f1
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/090-spi-hid
        git checkout ab84f7572c5928c7412539ab0e51a581ecafe4f1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=openrisc SHELL=/bin/bash drivers/hid/spi-hid/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/hid/spi-hid/spi-hid-apple-core.c:233:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] length @@     got unsigned int @@
   drivers/hid/spi-hid/spi-hid-apple-core.c:233:21: sparse:     expected restricted __le16 [usertype] length
   drivers/hid/spi-hid/spi-hid-apple-core.c:233:21: sparse:     got unsigned int
   drivers/hid/spi-hid/spi-hid-apple-core.c:248:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] crc16 @@     got unsigned short @@
   drivers/hid/spi-hid/spi-hid-apple-core.c:248:20: sparse:     expected restricted __le16 [usertype] crc16
   drivers/hid/spi-hid/spi-hid-apple-core.c:248:20: sparse:     got unsigned short
   drivers/hid/spi-hid/spi-hid-apple-core.c:259:21: sparse: sparse: symbol 'spihid_get_data' was not declared. Should it be static?
>> drivers/hid/spi-hid/spi-hid-apple-core.c:639:67: sparse: sparse: incorrect type in argument 5 (different base types) @@     expected unsigned int [usertype] len @@     got restricted __le16 [usertype] length @@
   drivers/hid/spi-hid/spi-hid-apple-core.c:639:67: sparse:     expected unsigned int [usertype] len
   drivers/hid/spi-hid/spi-hid-apple-core.c:639:67: sparse:     got restricted __le16 [usertype] length
   drivers/hid/spi-hid/spi-hid-apple-core.c:643:54: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected unsigned int [usertype] len @@     got restricted __le16 [usertype] length @@
   drivers/hid/spi-hid/spi-hid-apple-core.c:643:54: sparse:     expected unsigned int [usertype] len
   drivers/hid/spi-hid/spi-hid-apple-core.c:643:54: sparse:     got restricted __le16 [usertype] length
   drivers/hid/spi-hid/spi-hid-apple-core.c:665:50: sparse: sparse: incorrect type in argument 6 (different base types) @@     expected unsigned int [usertype] len @@     got restricted __le16 [usertype] length @@
   drivers/hid/spi-hid/spi-hid-apple-core.c:665:50: sparse:     expected unsigned int [usertype] len
   drivers/hid/spi-hid/spi-hid-apple-core.c:665:50: sparse:     got restricted __le16 [usertype] length
   drivers/hid/spi-hid/spi-hid-apple-core.c:686:16: sparse: sparse: restricted __le16 degrades to integer
   drivers/hid/spi-hid/spi-hid-apple-core.c:700:43: sparse: sparse: restricted __le16 degrades to integer
   drivers/hid/spi-hid/spi-hid-apple-core.c:703:23: sparse: sparse: restricted __le16 degrades to integer
   drivers/hid/spi-hid/spi-hid-apple-core.c:704:24: sparse: sparse: restricted __le16 degrades to integer
   drivers/hid/spi-hid/spi-hid-apple-core.c:704:47: sparse: sparse: restricted __le16 degrades to integer
   drivers/hid/spi-hid/spi-hid-apple-core.c:709:38: sparse: sparse: restricted __le16 degrades to integer
>> drivers/hid/spi-hid/spi-hid-apple-core.c:709:62: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int [usertype] n @@     got restricted __le16 [usertype] length @@
   drivers/hid/spi-hid/spi-hid-apple-core.c:709:62: sparse:     expected unsigned int [usertype] n
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
