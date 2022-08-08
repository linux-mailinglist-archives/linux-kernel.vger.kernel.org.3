Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFBEA58D0EF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 01:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244620AbiHHX6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 19:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244664AbiHHX6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 19:58:31 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4474A112D
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 16:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660003067; x=1691539067;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ecb0gY4vX9N5iJyAQ4enIDSBKMM7NnOIzQUhbpmgwM8=;
  b=Mg1Gwt+U0UPnX62hAgAdhru52CcZLtpja+4WhuG8MQMrT934mJL3tzwJ
   3bOkrul/h5vwRXmZDmfhv3rnMM4MG8+MJNv4ZckFCD7USoEwJB6j6ncPZ
   pJlCCSPW/JPY+6k9hpbOn2Ecs0uW8J1a3CtOb4+M11m5+Ii9Fzz4H9Uz3
   yTHj2fDQZ0KAMqzLY8mQaN0FWYw/okXmJqWcI6vxFoT9gxHlRnqiC0ohE
   0JElmxSGijhLpAxnBnDGAy9HvpVFg6glOQyzzU5QqSE2UE5UJGNJBDbY1
   dQBDq/bK7OGqsxnj1G0KvcQ/4zp5exJZf/HfsrM1euIzuwzt4lEiEqYb0
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="289473835"
X-IronPort-AV: E=Sophos;i="5.93,223,1654585200"; 
   d="scan'208";a="289473835"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 16:57:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,223,1654585200"; 
   d="scan'208";a="555124486"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 08 Aug 2022 16:57:36 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLCcp-000Maz-0y;
        Mon, 08 Aug 2022 23:57:35 +0000
Date:   Tue, 9 Aug 2022 07:57:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>
Subject: drivers/bluetooth/hci_qca.c:1860:37: warning: 'qca_soc_data_wcn6750'
 defined but not used
Message-ID: <202208090758.H0TcTuyd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
head:   c8a684e2e110376c58f0bfa30fb3855d1e319670
commit: d8f97da1b92d2fe89d51c673ecf80c4016119e5c Bluetooth: hci_qca: Add support for QTI Bluetooth chip wcn6750
date:   1 year, 1 month ago
config: x86_64-randconfig-c032-20220808 (https://download.01.org/0day-ci/archive/20220809/202208090758.H0TcTuyd-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d8f97da1b92d2fe89d51c673ecf80c4016119e5c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d8f97da1b92d2fe89d51c673ecf80c4016119e5c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/bluetooth/

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
