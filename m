Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEC84C593C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 05:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiB0EPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 23:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiB0EPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 23:15:53 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF48F4F443
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 20:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645935317; x=1677471317;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XWQFXk8SCvsg5p/cSLNISv7pJ23spXt0Q83FmTLk0Tw=;
  b=HGNlLA7AeDyCb8QcM4NRs7dkEnY/2fVkJ9gFAz7PqTxk2nDvHf4JaDm/
   jdRIr7vguoSV+hZV66IRlbovg+pPP5mM38VJ1UKjVoUxVyBt3vsH5TRqo
   lUbigzp3WKITa3tspFtmheYB0SLibscKQ6k6RIjq532xA9ykAy7eVZA6g
   k08D0/xL0bhvfwgif+IBFmQtPNcHNDXz7xOBVYYI9WBLG4gwPkYpg+f/v
   0Fl3T8o+OEVSbXBWVNGHZb02LTvjs6hR3kLrLf1PGJT6pDpUn5etzPiDp
   ZF9L3M+6l4k6lrBEOXzuQpa8t/FJxwwp+//Ps15yUruixW1xqhhO3e3T7
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10270"; a="236208688"
X-IronPort-AV: E=Sophos;i="5.90,140,1643702400"; 
   d="scan'208";a="236208688"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2022 20:15:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,140,1643702400"; 
   d="scan'208";a="534039115"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 26 Feb 2022 20:15:16 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOAxn-0006CR-Jv; Sun, 27 Feb 2022 04:15:15 +0000
Date:   Sun, 27 Feb 2022 12:14:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/wireless/ath/ath6kl/htc_mbox.c:368:9: sparse: sparse:
 incorrect type in assignment (different base types)
Message-ID: <202202271242.Cm0RmDFO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_FMBLA_NEWDOM,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2293be58d6a18cab800e25e42081bacb75c05752
commit: 803f4e1eab7a8938ba3a3c30dd4eb5e9eeef5e63 asm-generic: simplify asm/unaligned.h
date:   10 months ago
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20220227/202202271242.Cm0RmDFO-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=803f4e1eab7a8938ba3a3c30dd4eb5e9eeef5e63
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 803f4e1eab7a8938ba3a3c30dd4eb5e9eeef5e63
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/net/wireless/ath/ath6kl/ drivers/net/wireless/mediatek/mt76/mt7915/ drivers/scsi/qedi/ drivers/staging/ sound/soc/intel/skylake/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/net/wireless/ath/ath6kl/htc_mbox.c:368:9: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 x @@     got unsigned short [usertype] @@
   drivers/net/wireless/ath/ath6kl/htc_mbox.c:368:9: sparse:     expected restricted __le16 x
   drivers/net/wireless/ath/ath6kl/htc_mbox.c:368:9: sparse:     got unsigned short [usertype]
--
>> drivers/net/wireless/ath/ath6kl/htc_pipe.c:241:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 x @@     got unsigned short [usertype] @@
   drivers/net/wireless/ath/ath6kl/htc_pipe.c:241:17: sparse:     expected restricted __le16 x
   drivers/net/wireless/ath/ath6kl/htc_pipe.c:241:17: sparse:     got unsigned short [usertype]

vim +368 drivers/net/wireless/ath/ath6kl/htc_mbox.c

94e532d1a053b1 drivers/net/wireless/ath/ath6kl/htc.c Vasanthakumar Thiagarajan 2011-08-22  358  
dfa0104c2a2699 drivers/net/wireless/ath/ath6kl/htc.c Kalle Valo                2011-09-06  359  static void ath6kl_htc_tx_prep_pkt(struct htc_packet *packet, u8 flags,
dfa0104c2a2699 drivers/net/wireless/ath/ath6kl/htc.c Kalle Valo                2011-09-06  360  				   int ctrl0, int ctrl1)
bdcd81707973cf drivers/net/wireless/ath/ath6kl/htc.c Kalle Valo                2011-07-18  361  {
bdcd81707973cf drivers/net/wireless/ath/ath6kl/htc.c Kalle Valo                2011-07-18  362  	struct htc_frame_hdr *hdr;
bdcd81707973cf drivers/net/wireless/ath/ath6kl/htc.c Kalle Valo                2011-07-18  363  
bdcd81707973cf drivers/net/wireless/ath/ath6kl/htc.c Kalle Valo                2011-07-18  364  	packet->buf -= HTC_HDR_LENGTH;
bdcd81707973cf drivers/net/wireless/ath/ath6kl/htc.c Kalle Valo                2011-07-18  365  	hdr =  (struct htc_frame_hdr *)packet->buf;
bdcd81707973cf drivers/net/wireless/ath/ath6kl/htc.c Kalle Valo                2011-07-18  366  
bdcd81707973cf drivers/net/wireless/ath/ath6kl/htc.c Kalle Valo                2011-07-18  367  	/* Endianess? */
bdcd81707973cf drivers/net/wireless/ath/ath6kl/htc.c Kalle Valo                2011-07-18 @368  	put_unaligned((u16)packet->act_len, &hdr->payld_len);
bdcd81707973cf drivers/net/wireless/ath/ath6kl/htc.c Kalle Valo                2011-07-18  369  	hdr->flags = flags;
bdcd81707973cf drivers/net/wireless/ath/ath6kl/htc.c Kalle Valo                2011-07-18  370  	hdr->eid = packet->endpoint;
bdcd81707973cf drivers/net/wireless/ath/ath6kl/htc.c Kalle Valo                2011-07-18  371  	hdr->ctrl[0] = ctrl0;
bdcd81707973cf drivers/net/wireless/ath/ath6kl/htc.c Kalle Valo                2011-07-18  372  	hdr->ctrl[1] = ctrl1;
bdcd81707973cf drivers/net/wireless/ath/ath6kl/htc.c Kalle Valo                2011-07-18  373  }
bdcd81707973cf drivers/net/wireless/ath/ath6kl/htc.c Kalle Valo                2011-07-18  374  

:::::: The code at line 368 was first introduced by commit
:::::: bdcd81707973cf8aa9305337166f8ee842a050d4 Add ath6kl cleaned up driver

:::::: TO: Kalle Valo <kvalo@qca.qualcomm.com>
:::::: CC: Kalle Valo <kvalo@qca.qualcomm.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
