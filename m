Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D8B4C58E0
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 02:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiB0BMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 20:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiB0BMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 20:12:51 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6DC2294A2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 17:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645924335; x=1677460335;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mm5Qq9zamCvFhlWle7oJy1zxnmYnJMIemHTTbkERl10=;
  b=MgfiWnFQ279bUsyibKzkLj3+97/tCRUjKDhgx9rK5/PDbkCyLmpoa5Ir
   R1Qof+J1KqzjVFohNvnErDJjSquG2N7vLkGYUQG7M+7aKH5Te0IkNnHAB
   TifCaUFd2dZ++pU4WbabkSr2bFBhUfKGi/MWt1jzDbg/khL3uH2rwgyUz
   xy1wJ0/4hNzbYPO866w+5TSk+wPj+k6TsKKrYQSAimoE0IWucYNljuVXo
   IDOBXVdZLCNURngpQPBN9fcrvkC6CIN3WsNVswkyZKNSbdeQudWCFVD5S
   D+VQaQ3LGXOD8OSRVjcpoQ56c353lQ9r8j7F5zoVigR0Y8U/+USLSnBDW
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10270"; a="251527584"
X-IronPort-AV: E=Sophos;i="5.90,140,1643702400"; 
   d="scan'208";a="251527584"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2022 17:12:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,140,1643702400"; 
   d="scan'208";a="534014218"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 26 Feb 2022 17:12:13 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nO86f-000671-3T; Sun, 27 Feb 2022 01:12:13 +0000
Date:   Sun, 27 Feb 2022 09:12:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/wwan/iosm/iosm_ipc_mux_codec.c:833:21: sparse: sparse:
 Using plain integer as NULL pointer
Message-ID: <202202270909.D6JXGlhK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_FMBLA_NEWDOM,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Loic,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2293be58d6a18cab800e25e42081bacb75c05752
commit: 89212e160b81e778f829b89743570665810e3b13 net: wwan: Fix WWAN config symbols
date:   9 months ago
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20220227/202202270909.D6JXGlhK-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=89212e160b81e778f829b89743570665810e3b13
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 89212e160b81e778f829b89743570665810e3b13
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/net/wireless/ath/ath6kl/ drivers/net/wireless/mediatek/mt76/mt7915/ drivers/net/wwan/iosm/ drivers/scsi/qedi/ drivers/staging/ sound/soc/intel/skylake/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/net/wwan/iosm/iosm_ipc_mux_codec.c:833:21: sparse: sparse: Using plain integer as NULL pointer

vim +833 drivers/net/wwan/iosm/iosm_ipc_mux_codec.c

9413491e20e1ab M Chetan Kumar 2021-06-13  814  
9413491e20e1ab M Chetan Kumar 2021-06-13  815  void ipc_mux_ul_encoded_process(struct iosm_mux *ipc_mux, struct sk_buff *skb)
9413491e20e1ab M Chetan Kumar 2021-06-13  816  {
9413491e20e1ab M Chetan Kumar 2021-06-13  817  	struct mux_adgh *adgh;
9413491e20e1ab M Chetan Kumar 2021-06-13  818  	u16 adgh_len;
9413491e20e1ab M Chetan Kumar 2021-06-13  819  
9413491e20e1ab M Chetan Kumar 2021-06-13  820  	adgh = (struct mux_adgh *)skb->data;
9413491e20e1ab M Chetan Kumar 2021-06-13  821  	adgh_len = le16_to_cpu(adgh->length);
9413491e20e1ab M Chetan Kumar 2021-06-13  822  
9413491e20e1ab M Chetan Kumar 2021-06-13  823  	if (adgh->signature == cpu_to_le32(MUX_SIG_ADGH) &&
9413491e20e1ab M Chetan Kumar 2021-06-13  824  	    ipc_mux->ul_flow == MUX_UL)
9413491e20e1ab M Chetan Kumar 2021-06-13  825  		ipc_mux->ul_data_pend_bytes = ipc_mux->ul_data_pend_bytes -
9413491e20e1ab M Chetan Kumar 2021-06-13  826  					      adgh_len;
9413491e20e1ab M Chetan Kumar 2021-06-13  827  
9413491e20e1ab M Chetan Kumar 2021-06-13  828  	if (ipc_mux->ul_flow == MUX_UL)
9413491e20e1ab M Chetan Kumar 2021-06-13  829  		dev_dbg(ipc_mux->dev, "ul_data_pend_bytes: %lld",
9413491e20e1ab M Chetan Kumar 2021-06-13  830  			ipc_mux->ul_data_pend_bytes);
9413491e20e1ab M Chetan Kumar 2021-06-13  831  
9413491e20e1ab M Chetan Kumar 2021-06-13  832  	/* Reset the skb settings. */
9413491e20e1ab M Chetan Kumar 2021-06-13 @833  	skb->tail = 0;
9413491e20e1ab M Chetan Kumar 2021-06-13  834  	skb->len = 0;
9413491e20e1ab M Chetan Kumar 2021-06-13  835  
9413491e20e1ab M Chetan Kumar 2021-06-13  836  	/* Add the consumed ADB to the free list. */
9413491e20e1ab M Chetan Kumar 2021-06-13  837  	skb_queue_tail((&ipc_mux->ul_adb.free_list), skb);
9413491e20e1ab M Chetan Kumar 2021-06-13  838  }
9413491e20e1ab M Chetan Kumar 2021-06-13  839  

:::::: The code at line 833 was first introduced by commit
:::::: 9413491e20e1aba6e471d90c19cc43e523216a4d net: iosm: encode or decode datagram

:::::: TO: M Chetan Kumar <m.chetan.kumar@intel.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
