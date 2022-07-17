Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F29577649
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 15:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbiGQNAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 09:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbiGQNAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 09:00:52 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647AB1403A
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 06:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658062851; x=1689598851;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZhChAmGa4PUfwSYgmOTNhRvW8kWSCMA102br5NJoZa0=;
  b=W7gnIeSHkdtPrG2iymncFDkVUyyy7zDZg0RCEkwlogvxMnWIwT2Iwq3R
   x5gAygzGZgLzjBUkOO3L2XBv2VUwOSh+RKVMI6RPnQHxiFL0S25F5vZoN
   WDJWKNwA8B/tkd+f+zpm64e6JmfaisJIzbZcgLYO4dWDK4pFb9sBPON+W
   w6tG0WGk++XNazl57gFC7mC+b8QH8kkcdGAxLwTd+rRT0le3Mi55zMVn/
   Zb+Fl0CIEZEzKBTVCm0xmdMJ9YfT3XZjmMyQvRhrCtQ8KHlzl8Ox0I2Pn
   YCGWc0d+WDpb/6a3O48T01PAWMRUe2Sk92yPeNIz2dlM3BWLgy2wuT/f2
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10410"; a="350022427"
X-IronPort-AV: E=Sophos;i="5.92,279,1650956400"; 
   d="scan'208";a="350022427"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 06:00:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,279,1650956400"; 
   d="scan'208";a="629619132"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 17 Jul 2022 06:00:32 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oD3st-0003GG-Sq;
        Sun, 17 Jul 2022 13:00:31 +0000
Date:   Sun, 17 Jul 2022 20:59:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/wwan/iosm/iosm_ipc_mux_codec.c:833:21: sparse: sparse:
 Using plain integer as NULL pointer
Message-ID: <202207172003.r0081Wo1-lkp@intel.com>
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

Hi Loic,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   972a278fe60c361eb8f37619f562f092e8786d7c
commit: 89212e160b81e778f829b89743570665810e3b13 net: wwan: Fix WWAN config symbols
date:   1 year, 1 month ago
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20220717/202207172003.r0081Wo1-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=89212e160b81e778f829b89743570665810e3b13
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 89212e160b81e778f829b89743570665810e3b13
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/net/wwan/iosm/

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
