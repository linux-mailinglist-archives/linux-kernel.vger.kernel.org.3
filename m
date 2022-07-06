Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A605C568A42
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 15:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbiGFN5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 09:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbiGFN5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:57:11 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A100817060
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 06:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657115830; x=1688651830;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EsAozKFfM17B/GM7rOoB+i6Xn5Syt7w76ELKh+mPtaA=;
  b=ScU0+aHhpX6RTotNrHH4CJEfHSOj0Sf7PtLUSrBZEjr9QwVaJ493aYGv
   dHkfGllXzh2PKdFuuOrxZAdi8II1mK/kxawBAo+CJIcVKaCwvtzK7LLhX
   BvXttFYKxbelZCTzhjdu4jGTN9qBdv4+6L/a2k1sVRMvq6X7vM2dNq9ao
   l/F8VlWerG7rYOlc8B3NlSSpvhEASc7N5TT5u8HzyXkl2U+TsmGr3Av9S
   MtYM/Ff0EE/L4gajAyc6R3bdCOSVs4rM6V49VSeBOdaVkaEWy81kIf3az
   eoN2vlFajxKSySNxWqir8FHTP3U4+Q1D8PFVrdY0L7VXqZDfpm6BukIey
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="284873005"
X-IronPort-AV: E=Sophos;i="5.92,250,1650956400"; 
   d="scan'208";a="284873005"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 06:57:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,250,1650956400"; 
   d="scan'208";a="620320445"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 06 Jul 2022 06:57:06 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o95Wb-000Kdb-LN;
        Wed, 06 Jul 2022 13:57:05 +0000
Date:   Wed, 6 Jul 2022 21:56:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Janne Grunau <j@jannau.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [asahilinux:bits/090-spi-hid 11/11]
 drivers/hid/spi-hid/spi-hid-apple-core.c:709:17: sparse: sparse: cast from
 restricted __le16
Message-ID: <202207062145.V55bHrHO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/090-spi-hid
head:   42af7072aa3351c9a5716b754babb8ded16874ab
commit: 42af7072aa3351c9a5716b754babb8ded16874ab [11/11] WIP: HID: transport: spi: add Apple SPI transport
config: powerpc-randconfig-s031-20220706 (https://download.01.org/0day-ci/archive/20220706/202207062145.V55bHrHO-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/AsahiLinux/linux/commit/42af7072aa3351c9a5716b754babb8ded16874ab
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/090-spi-hid
        git checkout 42af7072aa3351c9a5716b754babb8ded16874ab
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/hid/spi-hid/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/hid/spi-hid/spi-hid-apple-core.c:233:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] length @@     got unsigned int @@
   drivers/hid/spi-hid/spi-hid-apple-core.c:233:21: sparse:     expected restricted __le16 [usertype] length
   drivers/hid/spi-hid/spi-hid-apple-core.c:233:21: sparse:     got unsigned int
   drivers/hid/spi-hid/spi-hid-apple-core.c:248:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] crc16 @@     got unsigned short @@
   drivers/hid/spi-hid/spi-hid-apple-core.c:248:20: sparse:     expected restricted __le16 [usertype] crc16
   drivers/hid/spi-hid/spi-hid-apple-core.c:248:20: sparse:     got unsigned short
   drivers/hid/spi-hid/spi-hid-apple-core.c:259:21: sparse: sparse: symbol 'spihid_get_data' was not declared. Should it be static?
   drivers/hid/spi-hid/spi-hid-apple-core.c:639:67: sparse: sparse: incorrect type in argument 5 (different base types) @@     expected unsigned int [usertype] len @@     got restricted __le16 [usertype] length @@
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
>> drivers/hid/spi-hid/spi-hid-apple-core.c:709:17: sparse: sparse: cast from restricted __le16
   drivers/hid/spi-hid/spi-hid-apple-core.c:709:17: sparse: sparse: restricted __le16 degrades to integer
   drivers/hid/spi-hid/spi-hid-apple-core.c:709:17: sparse: sparse: restricted __le16 degrades to integer
   drivers/hid/spi-hid/spi-hid-apple-core.c:709:17: sparse: sparse: restricted __le16 degrades to integer
   drivers/hid/spi-hid/spi-hid-apple-core.c:710:29: sparse: sparse: invalid assignment: +=
   drivers/hid/spi-hid/spi-hid-apple-core.c:710:29: sparse:    left side has type unsigned int
   drivers/hid/spi-hid/spi-hid-apple-core.c:710:29: sparse:    right side has type restricted __le16
   drivers/hid/spi-hid/spi-hid-apple-core.c:735:23: sparse: sparse: restricted __le16 degrades to integer

vim +709 drivers/hid/spi-hid/spi-hid-apple-core.c

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
