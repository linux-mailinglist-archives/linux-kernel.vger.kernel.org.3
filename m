Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F94554A9E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 15:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353137AbiFVNLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 09:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352594AbiFVNLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 09:11:11 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC601146A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 06:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655903468; x=1687439468;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1kvT5kphf2ppWOofxuRUBPhw/d3m0dVFYfPTF8riA24=;
  b=i2UDkqoou91joADALIdGbUwnAR1fhJEsrBlruxZeyszWGURCx8wFRESy
   7/DDfDdmOTX0WvYy8mVJhWuxjjXzovs4EarfGq7yQ9V5swR28jECcWAO2
   iRFw62GTTlcUWnidudo4Icp9znShDWeFLqbv4vHbXFNHFARoN9cA/7W1y
   jX3/2zN8NBob1NePesRjN9GWwgDpz9+jgp3ZoXyic3FKifI6fkIORICe4
   au/uC+Dz2yrBV4+5JPEmHttv++jLab3HZ5e+qCkeOZMT0ufqkCbUqI4r8
   jiHl8QAN53/ATERa+mgVRo5Z7q20e/NGA3966aeqFzqcuxeS+IOxl38xl
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="260231785"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="260231785"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 06:10:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="538463843"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 22 Jun 2022 06:10:47 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o4086-0001IL-Vj;
        Wed, 22 Jun 2022 13:10:46 +0000
Date:   Wed, 22 Jun 2022 21:10:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Kalle Valo <quic_kvalo@quicinc.com>
Subject: [ammarfaizi2-block:kvalo/ath/pending 3/10]
 drivers/net/wireless/ath/ath9k/hif_usb.c:251:57: warning: suggest braces
 around empty body in an 'else' statement
Message-ID: <202206222110.WLZh7cQf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block kvalo/ath/pending
head:   ff1c40050ac3ca6a55ccc7970e37503e75465977
commit: d7fc76039b74ad37b7056d5607b05d7cb31a5404 [3/10] ath9k: htc: clean up statistics macros
config: xtensa-randconfig-r033-20220622 (https://download.01.org/0day-ci/archive/20220622/202206222110.WLZh7cQf-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/d7fc76039b74ad37b7056d5607b05d7cb31a5404
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block kvalo/ath/pending
        git checkout d7fc76039b74ad37b7056d5607b05d7cb31a5404
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash drivers/net/wireless/ath/ath9k/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/net/wireless/ath/ath9k/hif_usb.c: In function 'ath9k_skb_queue_complete':
>> drivers/net/wireless/ath/ath9k/hif_usb.c:251:57: warning: suggest braces around empty body in an 'else' statement [-Wempty-body]
     251 |                         TX_STAT_INC(hif_dev, skb_failed);
         |                                                         ^


vim +/else +251 drivers/net/wireless/ath/ath9k/hif_usb.c

   233	
   234	static inline void ath9k_skb_queue_complete(struct hif_device_usb *hif_dev,
   235						    struct sk_buff_head *queue,
   236						    bool txok)
   237	{
   238		struct sk_buff *skb;
   239	
   240		while ((skb = __skb_dequeue(queue)) != NULL) {
   241	#ifdef CONFIG_ATH9K_HTC_DEBUGFS
   242			int ln = skb->len;
   243	#endif
   244			ath9k_htc_txcompletion_cb(hif_dev->htc_handle,
   245						  skb, txok);
   246			if (txok) {
   247				TX_STAT_INC(hif_dev, skb_success);
   248				TX_STAT_ADD(hif_dev, skb_success_bytes, ln);
   249			}
   250			else
 > 251				TX_STAT_INC(hif_dev, skb_failed);
   252		}
   253	}
   254	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
