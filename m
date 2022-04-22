Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D2F50AEF3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 06:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443953AbiDVEUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 00:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443963AbiDVEUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 00:20:38 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFBB4EF72
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 21:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650601061; x=1682137061;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jGLJ2CtZlVXvaRIPxPwrE1Ya3XHvA51uPt0/y7JUAlQ=;
  b=WBN9kO89a4eu01xY8O3S0BxP8C4+yoCbs65U9MRHMY2Mu8WKxwi23EGg
   FQLSnah5gXxwN1LWSPoOiym7dO6CmGZ9/IaDUUZDgzc9R0FLdC3SmyvAc
   ahtSSR5B3AooDpAp2WdIvawEZ2dCT5m75P7n7VfYTKx/yIo+WnkLGQalW
   pM73gXe/jPCDjenoCOy1qYJt4Kp7HbUdX8SrYZEi/f6kCOJ7ljQRIFefA
   PmlKi5waXI/ZznOHTes/dP/G5Ldqc4Vlwxae44YZw5hL0LRggu6Bki6oU
   2zkoFiIgsnhfg0jBvOjeQB5bwSzddM4xvlhiyD8JgueGj9fJiLNzJQgRB
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264733600"
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="264733600"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 21:17:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="593977100"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 21 Apr 2022 21:17:39 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhkji-0009Cc-K8;
        Fri, 22 Apr 2022 04:17:38 +0000
Date:   Fri, 22 Apr 2022 12:16:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jonas =?iso-8859-1?Q?Dre=DFler?= <verdre@v0yd.nl>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [linux-stable-rc:linux-5.15.y 133/5978]
 drivers/net/wireless/marvell/mwifiex/pcie.c:659:13: warning: variable
 'retval' set but not used
Message-ID: <202204221209.wnYEN9S3-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
head:   81d8d30c35edf29c5c70186ccb14dac4a5ca38a8
commit: 023d9d9e74d66182733d9e5bc8bf2e4671890110 [133/5978] mwifiex: Try waking the firmware until we get an interrupt
config: ia64-allmodconfig (https://download.01.org/0day-ci/archive/20220422/202204221209.wnYEN9S3-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=023d9d9e74d66182733d9e5bc8bf2e4671890110
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.15.y
        git checkout 023d9d9e74d66182733d9e5bc8bf2e4671890110
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/net/wireless/marvell/mwifiex/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/net/wireless/marvell/mwifiex/pcie.c: In function 'mwifiex_pm_wakeup_card':
>> drivers/net/wireless/marvell/mwifiex/pcie.c:659:13: warning: variable 'retval' set but not used [-Wunused-but-set-variable]
     659 |         int retval;
         |             ^~~~~~


vim +/retval +659 drivers/net/wireless/marvell/mwifiex/pcie.c

   653	
   654	/* This function wakes up the card by reading fw_status register. */
   655	static int mwifiex_pm_wakeup_card(struct mwifiex_adapter *adapter)
   656	{
   657		struct pcie_service_card *card = adapter->card;
   658		const struct mwifiex_pcie_card_reg *reg = card->pcie.reg;
 > 659		int retval;
   660	
   661		mwifiex_dbg(adapter, EVENT,
   662			    "event: Wakeup device...\n");
   663	
   664		if (reg->sleep_cookie)
   665			mwifiex_pcie_dev_wakeup_delay(adapter);
   666	
   667		/* The 88W8897 PCIe+USB firmware (latest version 15.68.19.p21) sometimes
   668		 * appears to ignore or miss our wakeup request, so we continue trying
   669		 * until we receive an interrupt from the card.
   670		 */
   671		if (read_poll_timeout(mwifiex_write_reg, retval,
   672				      READ_ONCE(adapter->int_status) != 0,
   673				      500, 500 * N_WAKEUP_TRIES_SHORT_INTERVAL,
   674				      false,
   675				      adapter, reg->fw_status, FIRMWARE_READY_PCIE)) {
   676			if (read_poll_timeout(mwifiex_write_reg, retval,
   677					      READ_ONCE(adapter->int_status) != 0,
   678					      10000, 10000 * N_WAKEUP_TRIES_LONG_INTERVAL,
   679					      false,
   680					      adapter, reg->fw_status, FIRMWARE_READY_PCIE)) {
   681				mwifiex_dbg(adapter, ERROR,
   682					    "Firmware didn't wake up\n");
   683				return -EIO;
   684			}
   685		}
   686	
   687		if (reg->sleep_cookie) {
   688			mwifiex_pcie_dev_wakeup_delay(adapter);
   689			mwifiex_dbg(adapter, INFO,
   690				    "PCIE wakeup: Setting PS_STATE_AWAKE\n");
   691			adapter->ps_state = PS_STATE_AWAKE;
   692		}
   693	
   694		return 0;
   695	}
   696	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
