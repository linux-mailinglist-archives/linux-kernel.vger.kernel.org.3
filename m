Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA38485F2E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 04:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiAFDYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 22:24:06 -0500
Received: from mga09.intel.com ([134.134.136.24]:9768 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229694AbiAFDYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 22:24:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641439446; x=1672975446;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=P3sSACmSpQXLtf2LZOVO9lkkPSb6OkBFtsV4kzyxeYM=;
  b=nt1cCDVWlXRsnpjMaoB7as/kgJ/pun9HCOw+Q63F5MV+4HduGw2reHJc
   4x7EeMdyMhOKpN6FQWfbsTnQyk0gH8+UBXQbNSa3HahTbYMzviTkyU/3R
   wN/y8bUIdFfLd+0adVOzErTU6OD6Bvd3oxHH+xbqgX9UYQClOVvfIz1mX
   Bw6l8K1YOOa82S1jHmpeI+mik75bubAN/haUmNGMdacYN+u7jlC/VMze1
   7gEe+kyWuCZSwS6RdElcol2/xbwAc0efW+wGNiX9xm4JpJ+NMAWLJHh3F
   H9voCtBzTvZxdFC2om1BR7FjE9V7/mzMMt+GRXj/1egCk04pBnPLZeupn
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="242378039"
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; 
   d="scan'208";a="242378039"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 19:24:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; 
   d="scan'208";a="689245195"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 05 Jan 2022 19:24:04 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5JNj-000HI1-Je; Thu, 06 Jan 2022 03:24:03 +0000
Date:   Thu, 6 Jan 2022 11:23:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jonas =?iso-8859-1?Q?Dre=DFler?= <verdre@v0yd.nl>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Kalle Valo <kvalo@codeaurora.org>
Subject: drivers/net/wireless/marvell/mwifiex/pcie.c:659:13: warning:
 variable 'retval' set but not used
Message-ID: <202201061102.dFgIQVH0-lkp@intel.com>
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
head:   75acfdb6fd922598a408a0d864486aeb167c1a97
commit: 8e3e59c31fea5de95ffc52c46f0c562c39f20c59 mwifiex: Try waking the firmware until we get an interrupt
date:   3 months ago
config: ia64-randconfig-r001-20220106 (https://download.01.org/0day-ci/archive/20220106/202201061102.dFgIQVH0-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8e3e59c31fea5de95ffc52c46f0c562c39f20c59
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 8e3e59c31fea5de95ffc52c46f0c562c39f20c59
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/net/wireless/marvell/mwifiex/

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
