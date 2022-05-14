Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E179352704B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 11:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbiENJbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 05:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiENJbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 05:31:35 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A4FE006
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 02:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652520694; x=1684056694;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dFGar8ng++sNwcK1YrUGfJrMFTXpQxROjMhA13xwAaQ=;
  b=lJoUXDAG6GyRK+fWDL5LxdgwUGFonNUE26YMnOYUGrBTuqrtmirDbF1p
   VStlkHYlsUlkyiSn3mERtUVInhlrKVqVvqhbzME4ZwTPq82i3vqVnIeW6
   R2APzfFROQY+EKh7pu8HExVmgTOsW6YoHpVkUXBk79PuEKA7IZjzTeaMw
   PC27vuUQ4lSlZR8Iybf/fRd8PBfufYkuegTblIfHCGysj1OAF6HMC2qg2
   bJp2soQtCuugRkl06Si3k7EAsFOFrH6YbEeqm9bNTTSPnwiZTUivc1CzX
   yD8cWGAAUDFOCxTSVMCssiVPW+GVRgWZlE+QLjMB0z/7fIy9cxTQ9O7xQ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="270168237"
X-IronPort-AV: E=Sophos;i="5.91,225,1647327600"; 
   d="scan'208";a="270168237"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2022 02:31:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,225,1647327600"; 
   d="scan'208";a="896551702"
Received: from lkp-server01.sh.intel.com (HELO d1462bc4b09b) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 14 May 2022 02:31:31 -0700
Received: from kbuild by d1462bc4b09b with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npo7W-0000Qw-LY;
        Sat, 14 May 2022 09:31:30 +0000
Date:   Sat, 14 May 2022 17:30:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>
Subject: drivers/bluetooth/hci_qca.c:1860:37: warning: 'qca_soc_data_wcn6750'
 defined but not used
Message-ID: <202205141707.C0PnkKx4-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ec7f49619d8ee13e108740c82f942cd401b989e9
commit: d8f97da1b92d2fe89d51c673ecf80c4016119e5c Bluetooth: hci_qca: Add support for QTI Bluetooth chip wcn6750
date:   11 months ago
config: i386-randconfig-a014-20211210 (https://download.01.org/0day-ci/archive/20220514/202205141707.C0PnkKx4-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d8f97da1b92d2fe89d51c673ecf80c4016119e5c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d8f97da1b92d2fe89d51c673ecf80c4016119e5c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/bluetooth/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/bluetooth/hci_qca.c:1860:37: warning: 'qca_soc_data_wcn6750' defined but not used [-Wunused-const-variable=]
    1860 | static const struct qca_device_data qca_soc_data_wcn6750 = {
         |                                     ^~~~~~~~~~~~~~~~~~~~
   drivers/bluetooth/hci_qca.c:1844:37: warning: 'qca_soc_data_wcn3998' defined but not used [-Wunused-const-variable=]
    1844 | static const struct qca_device_data qca_soc_data_wcn3998 = {
         |                                     ^~~~~~~~~~~~~~~~~~~~
   drivers/bluetooth/hci_qca.c:1832:37: warning: 'qca_soc_data_wcn3991' defined but not used [-Wunused-const-variable=]
    1832 | static const struct qca_device_data qca_soc_data_wcn3991 = {
         |                                     ^~~~~~~~~~~~~~~~~~~~
   drivers/bluetooth/hci_qca.c:1821:37: warning: 'qca_soc_data_wcn3990' defined but not used [-Wunused-const-variable=]
    1821 | static const struct qca_device_data qca_soc_data_wcn3990 = {
         |                                     ^~~~~~~~~~~~~~~~~~~~


vim +/qca_soc_data_wcn6750 +1860 drivers/bluetooth/hci_qca.c

  1859	
> 1860	static const struct qca_device_data qca_soc_data_wcn6750 = {
  1861		.soc_type = QCA_WCN6750,
  1862		.vregs = (struct qca_vreg []) {
  1863			{ "vddio", 5000 },
  1864			{ "vddaon", 26000 },
  1865			{ "vddbtcxmx", 126000 },
  1866			{ "vddrfacmn", 12500 },
  1867			{ "vddrfa0p8", 102000 },
  1868			{ "vddrfa1p7", 302000 },
  1869			{ "vddrfa1p2", 257000 },
  1870			{ "vddrfa2p2", 1700000 },
  1871			{ "vddasd", 200 },
  1872		},
  1873		.num_vregs = 9,
  1874		.capabilities = QCA_CAP_WIDEBAND_SPEECH | QCA_CAP_VALID_LE_STATES,
  1875	};
  1876	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
