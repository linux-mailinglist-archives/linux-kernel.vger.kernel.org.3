Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64FB5955AE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 10:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiHPI4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 04:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiHPIz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 04:55:58 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B775E1272E4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 00:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660633430; x=1692169430;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=x3vHKljaHoPorOmYOVh/bLWoEv7HxufbaQXL1gLFzlo=;
  b=QBFO7hivNWaHAcPWhPsc5zGv4ZbqK+Jt3zmAalbHyQ1uF0k/Bz8OPSjv
   WaG3jslhzX9IBn+rpZ3iFqyZO3PwhRUNV5YyP8V1MKAEFwxpfafHThaeI
   Dq59a7St/qNx1M4+2usOCbFykqgcS+814rhzgSypaJyc3BFt/jsTwRE2R
   rERqn9SqMV74frDQ6dS1vyxyW296bsRazbL624gvow0F8cW5eo3L/IBDa
   K6GKQfsZF3aCLVhjXgkpKDbZlt7aPPPpiA0x6d8L/PuJihnbKfB8nPDQY
   qYzWJMmmR7rYNWi6uYZTce57Ow2oMfPZPxZ/Oc0Tw8vm0iKJdsByxiebA
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="290897135"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="290897135"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 00:03:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="675105312"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 16 Aug 2022 00:03:49 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNqc8-0001aX-2C;
        Tue, 16 Aug 2022 07:03:48 +0000
Date:   Tue, 16 Aug 2022 15:03:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>
Subject: drivers/bluetooth/hci_qca.c:1860:37: warning: 'qca_soc_data_wcn6750'
 defined but not used
Message-ID: <202208161416.YMrgM5RB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Venkata,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   568035b01cfb107af8d2e4bd2fb9aea22cf5b868
commit: d8f97da1b92d2fe89d51c673ecf80c4016119e5c Bluetooth: hci_qca: Add support for QTI Bluetooth chip wcn6750
date:   1 year, 2 months ago
config: i386-buildonly-randconfig-r005-20220815 (https://download.01.org/0day-ci/archive/20220816/202208161416.YMrgM5RB-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d8f97da1b92d2fe89d51c673ecf80c4016119e5c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d8f97da1b92d2fe89d51c673ecf80c4016119e5c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
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
