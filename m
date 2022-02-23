Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602A84C198B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 18:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243281AbiBWRKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 12:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236564AbiBWRJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 12:09:51 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DB76A00B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 09:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645636163; x=1677172163;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vRdsv3Fy6NbuApbaB3ggHyhSGJ4vHsHhQh9jBEiyj/U=;
  b=RqawMp6lmh82jBEB5875lPF/RKF6ZcHN5pxzSpA9PZMWRAyetvF+U0zt
   sWUEM44yQQnM5+IbH/ojMqQgU4KclS41JRTGfl7/5zfKt9a5IX/Te9SOw
   b7do58bLEkyizu1U+dUs2rgWm4G5YZ7tAS0UWKtTJmpCk702i1azeEmcQ
   w/FibHTFsuzMreiMV5AExmc/UQ8q6w+BoVxgdKY+i7z9SgLkFeOllyls3
   NP3GjSUy/dqNFBjd+a1tiZ4sk362KDdmWvqxNZv3qBpwIBTWK3IyHtbkh
   R9jQG3vkAbuAZFXXPu7q9C8ZI3Qgo7eaN5NpGYwRrJ8xBCutdzbMonR4I
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="239418219"
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="239418219"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 09:03:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="548344664"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 23 Feb 2022 09:03:40 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMv3D-0001dl-Go; Wed, 23 Feb 2022 17:03:39 +0000
Date:   Thu, 24 Feb 2022 01:02:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1583/2340]
 drivers/net/ieee802154/ca8210.c:1782:4: error: implicit declaration of
 function 'dev_kfree_skb_any'
Message-ID: <202202240010.CSrNf18k-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   97c5eeb4de3ad324ed2a4656b46465299cfd010a
commit: ea46cc7b8232972f12361f456922beddc7ab3d14 [1583/2340] headers/deps: networking/headers: Remove the <linux/netdevice_api.h> inclusion from <linux/netdevice.h>
config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20220224/202202240010.CSrNf18k-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=ea46cc7b8232972f12361f456922beddc7ab3d14
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout ea46cc7b8232972f12361f456922beddc7ab3d14
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/net/dsa/ drivers/net/ieee802154/ net/dsa/ net/smc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the mingo-tip/sched/headers HEAD 97c5eeb4de3ad324ed2a4656b46465299cfd010a builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

>> drivers/net/ieee802154/ca8210.c:1782:4: error: implicit declaration of function 'dev_kfree_skb_any' [-Werror,-Wimplicit-function-declaration]
                           dev_kfree_skb_any(priv->tx_skb);
                           ^
   1 error generated.


vim +/dev_kfree_skb_any +1782 drivers/net/ieee802154/ca8210.c

ded845a781a578 Harry Morris  2017-03-28  1745  
ded845a781a578 Harry Morris  2017-03-28  1746  /**
ded845a781a578 Harry Morris  2017-03-28  1747   * ca8210_async_xmit_complete() - Called to announce that an asynchronous
ded845a781a578 Harry Morris  2017-03-28  1748   *                                transmission has finished
ded845a781a578 Harry Morris  2017-03-28  1749   * @hw:          ieee802154_hw of ca8210 that has finished exchange
ded845a781a578 Harry Morris  2017-03-28  1750   * @msduhandle:  Identifier of transmission that has completed
ded845a781a578 Harry Morris  2017-03-28  1751   * @status:      Returned 802.15.4 status code of the transmission
ded845a781a578 Harry Morris  2017-03-28  1752   *
ded845a781a578 Harry Morris  2017-03-28  1753   * Return: 0 or linux error code
ded845a781a578 Harry Morris  2017-03-28  1754   */
ded845a781a578 Harry Morris  2017-03-28  1755  static int ca8210_async_xmit_complete(
ded845a781a578 Harry Morris  2017-03-28  1756  	struct ieee802154_hw  *hw,
ded845a781a578 Harry Morris  2017-03-28  1757  	u8                     msduhandle,
ded845a781a578 Harry Morris  2017-03-28  1758  	u8                     status)
ded845a781a578 Harry Morris  2017-03-28  1759  {
ded845a781a578 Harry Morris  2017-03-28  1760  	struct ca8210_priv *priv = hw->priv;
ded845a781a578 Harry Morris  2017-03-28  1761  
ded845a781a578 Harry Morris  2017-03-28  1762  	if (priv->nextmsduhandle != msduhandle) {
ded845a781a578 Harry Morris  2017-03-28  1763  		dev_err(
ded845a781a578 Harry Morris  2017-03-28  1764  			&priv->spi->dev,
ded845a781a578 Harry Morris  2017-03-28  1765  			"Unexpected msdu_handle on data confirm, Expected %d, got %d\n",
ded845a781a578 Harry Morris  2017-03-28  1766  			priv->nextmsduhandle,
ded845a781a578 Harry Morris  2017-03-28  1767  			msduhandle
ded845a781a578 Harry Morris  2017-03-28  1768  		);
ded845a781a578 Harry Morris  2017-03-28  1769  		return -EIO;
ded845a781a578 Harry Morris  2017-03-28  1770  	}
ded845a781a578 Harry Morris  2017-03-28  1771  
ded845a781a578 Harry Morris  2017-03-28  1772  	priv->async_tx_pending = false;
ded845a781a578 Harry Morris  2017-03-28  1773  	priv->nextmsduhandle++;
ded845a781a578 Harry Morris  2017-03-28  1774  
ded845a781a578 Harry Morris  2017-03-28  1775  	if (status) {
ded845a781a578 Harry Morris  2017-03-28  1776  		dev_err(
ded845a781a578 Harry Morris  2017-03-28  1777  			&priv->spi->dev,
ded845a781a578 Harry Morris  2017-03-28  1778  			"Link transmission unsuccessful, status = %d\n",
ded845a781a578 Harry Morris  2017-03-28  1779  			status
ded845a781a578 Harry Morris  2017-03-28  1780  		);
ded845a781a578 Harry Morris  2017-03-28  1781  		if (status != MAC_TRANSACTION_OVERFLOW) {
621b24b09eb61c Miquel Raynal 2022-01-25 @1782  			dev_kfree_skb_any(priv->tx_skb);
ded845a781a578 Harry Morris  2017-03-28  1783  			ieee802154_wake_queue(priv->hw);
ded845a781a578 Harry Morris  2017-03-28  1784  			return 0;
ded845a781a578 Harry Morris  2017-03-28  1785  		}
ded845a781a578 Harry Morris  2017-03-28  1786  	}
ded845a781a578 Harry Morris  2017-03-28  1787  	ieee802154_xmit_complete(priv->hw, priv->tx_skb, true);
ded845a781a578 Harry Morris  2017-03-28  1788  
ded845a781a578 Harry Morris  2017-03-28  1789  	return 0;
ded845a781a578 Harry Morris  2017-03-28  1790  }
ded845a781a578 Harry Morris  2017-03-28  1791  

:::::: The code at line 1782 was first introduced by commit
:::::: 621b24b09eb61c63f262da0c9c5f0e93348897e5 net: ieee802154: ca8210: Stop leaking skb's

:::::: TO: Miquel Raynal <miquel.raynal@bootlin.com>
:::::: CC: Stefan Schmidt <stefan@datenfreihafen.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
