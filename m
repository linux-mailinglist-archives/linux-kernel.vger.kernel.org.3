Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC6747D30B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 14:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241228AbhLVNcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 08:32:07 -0500
Received: from mga03.intel.com ([134.134.136.65]:6584 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240256AbhLVNcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 08:32:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640179926; x=1671715926;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HgoHbSGfRtVfVRTG1MYphNWo0vtqovBzp6z/tt3OdpA=;
  b=cg/mKWMgxmiZNNl4GP1AlPvZvCPnem/ts/2Gt5MnpK2GZ1b9nEqtVtHL
   UvtmKK1lMtQMwHrDIQ5tbxxsmvPMFuPmEGWshbh2TW1Z7psrKxq4xhu2O
   DMa15B+YxsP07JtspMBtl8VuHNGJtpdOutKIJ0r/5IpIkpWMnjIGXWtKb
   m++5L9cIEn9AIT4IWdXcT2NOi56Zocs7VM1j/JjSyIzbdvAI0Idz5q28v
   /DJWqfsrx1JziK43JfZFieokDAVfLuhOdbb/+vqAz/tTpGvIAPLS474Wp
   8/xRp517kWkwpwoIobF2nZtjoU4fexDUIwLYc6HAmBW1JSbm3gkW38ENc
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="240569293"
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="240569293"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 05:31:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="617134199"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 22 Dec 2021 05:31:43 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n01iY-0000Tn-Jx; Wed, 22 Dec 2021 13:31:42 +0000
Date:   Wed, 22 Dec 2021 21:30:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jonas =?iso-8859-1?Q?Dre=DFler?= <verdre@v0yd.nl>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Kalle Valo <kvalo@codeaurora.org>
Subject: drivers/net/wireless/marvell/mwifiex/pcie.c:659:13: warning:
 variable 'retval' set but not used
Message-ID: <202112222102.0Qk7vOl2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonas,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2f47a9a4dfa3674fad19a49b40c5103a9a8e1589
commit: 8e3e59c31fea5de95ffc52c46f0c562c39f20c59 mwifiex: Try waking the firmware until we get an interrupt
date:   9 weeks ago
config: powerpc64-buildonly-randconfig-r005-20211222 (https://download.01.org/0day-ci/archive/20211222/202112222102.0Qk7vOl2-lkp@intel.com/config)
compiler: powerpc64le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8e3e59c31fea5de95ffc52c46f0c562c39f20c59
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 8e3e59c31fea5de95ffc52c46f0c562c39f20c59
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/net/wireless/marvell/mwifiex/

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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
