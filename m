Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429A15766C9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 20:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiGOScr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 14:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiGOScp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 14:32:45 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE2E747BE
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 11:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657909963; x=1689445963;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CQ7UmEGuDaQHrnVHebaIcYHqVFDdWO47r6fGCP9l/0M=;
  b=VxLqXp+hQMflKkbsqUkDRxpvcqrPUkY+OO0J+Gkl3BZTXXSUiyEinL5s
   ojgUQdFvUzENLZgJTFCBEHHIDmHQPwrLPr8CHZsVzn74NfwqrgzXB/cpg
   RRIEib/NTZayCZD/Y8O+0bnmQW1TTUoyGKytutJGYganM4qup5X3WEFiX
   5CyoPrMNgTcr4AQmgvhjxCnaLXboPswmIITp7hBCgCInFL3JY5ZQ13Ci8
   mGlG+OJ2B14MYZQCwg7iW/Mw0sbzGtAdQDLjrOBUXpF1pTMISILJFzVlf
   fGhYrWvzRgPY/Pjm2Fmb8vKIx4etjVKNsImKrSn8y72ztfqvuaE34xCg0
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="283431934"
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="283431934"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 11:32:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="773071558"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 15 Jul 2022 11:32:42 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCQ7F-0000e6-DY;
        Fri, 15 Jul 2022 18:32:41 +0000
Date:   Sat, 16 Jul 2022 02:31:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Janne Grunau <j@jannau.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [asahilinux:bits/090-spi-hid 11/18]
 drivers/hid/spi-hid/spi-hid-apple-core.c:709:17: sparse: sparse: incorrect
 type in argument 3 (different base types)
Message-ID: <202207160237.e6yo0GPd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/090-spi-hid
head:   2902ed1bd2d6ac439a835c53841122c7f3455a6c
commit: caee9bbb3f5dd71fbcc4690a7c2e97ff6964ab92 [11/18] WIP: HID: transport: spi: add Apple SPI transport
config: sparc-randconfig-s041-20220715 (https://download.01.org/0day-ci/archive/20220716/202207160237.e6yo0GPd-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sparc SHELL=/bin/bash drivers/hid/spi-hid/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/hid/spi-hid/spi-hid-apple-core.c:233:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] length @@     got unsigned long @@
   drivers/hid/spi-hid/spi-hid-apple-core.c:233:21: sparse:     expected restricted __le16 [usertype] length
   drivers/hid/spi-hid/spi-hid-apple-core.c:233:21: sparse:     got unsigned long
   drivers/hid/spi-hid/spi-hid-apple-core.c:248:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] crc16 @@     got unsigned short @@
   drivers/hid/spi-hid/spi-hid-apple-core.c:248:20: sparse:     expected restricted __le16 [usertype] crc16
   drivers/hid/spi-hid/spi-hid-apple-core.c:248:20: sparse:     got unsigned short
   drivers/hid/spi-hid/spi-hid-apple-core.c:259:21: sparse: sparse: symbol 'spihid_get_data' was not declared. Should it be static?
   drivers/hid/spi-hid/spi-hid-apple-core.c:639:67: sparse: sparse: incorrect type in argument 5 (different base types) @@     expected unsigned long [usertype] len @@     got restricted __le16 [usertype] length @@
   drivers/hid/spi-hid/spi-hid-apple-core.c:639:67: sparse:     expected unsigned long [usertype] len
   drivers/hid/spi-hid/spi-hid-apple-core.c:639:67: sparse:     got restricted __le16 [usertype] length
   drivers/hid/spi-hid/spi-hid-apple-core.c:643:54: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected unsigned long [usertype] len @@     got restricted __le16 [usertype] length @@
   drivers/hid/spi-hid/spi-hid-apple-core.c:643:54: sparse:     expected unsigned long [usertype] len
   drivers/hid/spi-hid/spi-hid-apple-core.c:643:54: sparse:     got restricted __le16 [usertype] length
   drivers/hid/spi-hid/spi-hid-apple-core.c:665:50: sparse: sparse: incorrect type in argument 6 (different base types) @@     expected unsigned long [usertype] len @@     got restricted __le16 [usertype] length @@
   drivers/hid/spi-hid/spi-hid-apple-core.c:665:50: sparse:     expected unsigned long [usertype] len
   drivers/hid/spi-hid/spi-hid-apple-core.c:665:50: sparse:     got restricted __le16 [usertype] length
   drivers/hid/spi-hid/spi-hid-apple-core.c:686:16: sparse: sparse: restricted __le16 degrades to integer
   drivers/hid/spi-hid/spi-hid-apple-core.c:700:43: sparse: sparse: restricted __le16 degrades to integer
   drivers/hid/spi-hid/spi-hid-apple-core.c:703:23: sparse: sparse: restricted __le16 degrades to integer
   drivers/hid/spi-hid/spi-hid-apple-core.c:704:24: sparse: sparse: restricted __le16 degrades to integer
   drivers/hid/spi-hid/spi-hid-apple-core.c:704:47: sparse: sparse: restricted __le16 degrades to integer
   drivers/hid/spi-hid/spi-hid-apple-core.c:709:17: sparse: sparse: restricted __le16 degrades to integer
>> drivers/hid/spi-hid/spi-hid-apple-core.c:709:17: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned long @@     got restricted __le16 [usertype] length @@
   drivers/hid/spi-hid/spi-hid-apple-core.c:709:17: sparse:     expected unsigned long
   drivers/hid/spi-hid/spi-hid-apple-core.c:709:17: sparse:     got restricted __le16 [usertype] length
   drivers/hid/spi-hid/spi-hid-apple-core.c:710:29: sparse: sparse: invalid assignment: +=
   drivers/hid/spi-hid/spi-hid-apple-core.c:710:29: sparse:    left side has type unsigned int
   drivers/hid/spi-hid/spi-hid-apple-core.c:710:29: sparse:    right side has type restricted __le16
   drivers/hid/spi-hid/spi-hid-apple-core.c:735:23: sparse: sparse: restricted __le16 degrades to integer

vim +709 drivers/hid/spi-hid/spi-hid-apple-core.c

   617	
   618	static void spihid_process_message(struct spihid_apple *spihid, u8 *data,
   619					   size_t length, u8 device, u8 flags)
   620	{
   621		struct device *dev = &spihid->spidev->dev;
   622		struct spihid_msg_hdr *hdr;
   623		bool handled = false;
   624		u8 *payload;
   625	
   626		if (!spihid_verify_msg(spihid, data, length))
   627			return;
   628	
   629		hdr = (struct spihid_msg_hdr *)data;
   630	
   631		if (hdr->length == 0)
   632			return;
   633	
   634		payload = data + sizeof(struct spihid_msg_hdr);
   635	
   636		switch (flags) {
   637		case SPIHID_READ_PACKET:
   638			handled = spihid_process_input_report(spihid, device, hdr,
   639							      payload, hdr->length);
   640			break;
   641		case SPIHID_WRITE_PACKET:
   642			handled = spihid_process_response(spihid, hdr, payload,
   643							  hdr->length);
   644			break;
   645		default:
   646			break;
   647		}
   648	
   649	#if defined(DEBUG) && DEBUG > 1
   650		{
   651			dev_dbg(dev,
   652				"R msg: req:%02hhx rep:%02hhx dev:%02hhx id:%hu len:%hu\n",
   653				hdr->unknown0, hdr->unknown1, hdr->unknown2, hdr->id,
   654				hdr->length);
   655			print_hex_dump_debug("spihid msg: ", DUMP_PREFIX_OFFSET, 16, 1,
   656					     payload, hdr->length, true);
   657		}
   658	#else
   659		if (!handled) {
   660			dev_dbg(dev,
   661				"R unhandled msg: req:%02hhx rep:%02hhx dev:%02hhx id:%hu len:%hu\n",
   662				hdr->unknown0, hdr->unknown1, hdr->unknown2, hdr->id,
   663				hdr->length);
   664			print_hex_dump_debug("spihid msg: ", DUMP_PREFIX_OFFSET, 16, 1,
 > 665					     payload, hdr->length, true);
   666		}
   667	#endif
   668	}
   669	
   670	static void spihid_assemble_meesage(struct spihid_apple *spihid,
   671					    struct spihid_transfer_packet *pkt)
   672	{
   673		size_t length, offset, remain;
   674		struct device *dev = &spihid->spidev->dev;
   675		struct spihid_input_report *rep = &spihid->report;
   676	
   677		length = le16_to_cpu(pkt->length);
   678		remain = le16_to_cpu(pkt->remain);
   679		offset = le16_to_cpu(pkt->offset);
   680	
   681		if (offset + length + remain > U16_MAX) {
   682			return;
   683		}
   684	
   685		if (pkt->device != rep->device || pkt->flags != rep->flags ||
   686		    pkt->offset != rep->offset) {
   687			rep->device = 0;
   688			rep->flags = 0;
   689			rep->offset = 0;
   690			rep->length = 0;
   691		}
   692	
   693		if (pkt->offset == 0) {
   694			if (rep->offset != 0) {
   695				dev_warn(dev, "incomplete report off:%u len:%u",
   696					 rep->offset, rep->length);
   697			}
   698			memcpy(rep->buf, pkt->data, length);
   699			rep->offset = length;
   700			rep->length = length + pkt->remain;
   701			rep->device = pkt->device;
   702			rep->flags = pkt->flags;
   703		} else if (pkt->offset == rep->offset) {
   704			if (pkt->offset + length + pkt->remain != rep->length) {
   705				dev_warn(dev, "incomplete report off:%u len:%u",
   706					 rep->offset, rep->length);
   707				return;
   708			}
 > 709			memcpy(rep->buf + pkt->offset, pkt->data, pkt->length);
   710			rep->offset += pkt->length;
   711	
   712			if (rep->offset == rep->length) {
   713				spihid_process_message(spihid, rep->buf, rep->length,
   714						       rep->device, rep->flags);
   715				rep->device = 0;
   716				rep->flags = 0;
   717				rep->offset = 0;
   718				rep->length = 0;
   719			}
   720		}
   721	}
   722	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
