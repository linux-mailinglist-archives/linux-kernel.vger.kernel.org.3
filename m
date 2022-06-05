Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D7753D994
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 06:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238580AbiFEEFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 00:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiFEEF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 00:05:29 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9646436
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 21:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654401928; x=1685937928;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1w7zCCCzOZU/CEG9MKA/Ybdz2DQe6r4XVdp4ZbIfoB8=;
  b=SJNqgndgNA07UupbrMGv+WNv4PtrT/6XJ1w5k421qmcex5biNXmRgiAM
   Goog0lsbFhkOppXp9C2JEErIm/4uf4hQnBGLKxL9Q4FHN4ZJ5cE/7k6j7
   1e7WdYZ82KoEnxIpopfkevgEC5Rug9ZBakzBlk5KMpoI01nuVX8QQbZpH
   acO1/zaMGuHZqp2Rd7XGOoxeG1rmqEZA2aNGotDqSUzAi+v+QEKXKZ37c
   ZM3SGo6BvbXJ4OOaF8uG5zE3W9dCb3SEMbFLoTg6Rd/vY3H2Z1Q1XmDKZ
   KdOOS63hLwKSE4lYQ0azjVgElI/s8djeA1Uizq6jNt7y2n/TtRJCpEMcE
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10368"; a="264193921"
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="264193921"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 21:05:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="553894639"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 04 Jun 2022 21:05:27 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxhW2-000BSn-ER;
        Sun, 05 Jun 2022 04:05:26 +0000
Date:   Sun, 5 Jun 2022 12:05:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/wwan/iosm/iosm_ipc_mux_codec.c:833:21: sparse: sparse:
 Using plain integer as NULL pointer
Message-ID: <202206051123.UxnYthu7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Loic,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d0e60d46bc03252b8d4ffaaaa0b371970ac16cda
commit: 89212e160b81e778f829b89743570665810e3b13 net: wwan: Fix WWAN config symbols
date:   12 months ago
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20220605/202206051123.UxnYthu7-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-18-g56afb504-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=89212e160b81e778f829b89743570665810e3b13
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 89212e160b81e778f829b89743570665810e3b13
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/ samples//

If you fix the issue, kindly add following tag where applicable
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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
