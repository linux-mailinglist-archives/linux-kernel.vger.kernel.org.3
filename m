Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DA858B33B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 03:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241525AbiHFBio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 21:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbiHFBil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 21:38:41 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F7C165A0
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 18:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659749920; x=1691285920;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2JE82YWhTETfeHvicg+XTHdJlZYo4b/MLUAXfW/W12I=;
  b=NS5yb5b5kmVytckyK3j8AlCP376Bg9RrAA8H10k9ZNQIWR8rFcAzhs6n
   HtDn4kBSgR8EtgNvbxMmzCJhFEe7sT4xRW2Wpf6nucUXb+ngEXXxudyxg
   ICkLMvEYOTYsCsnACvQyBDUmJY48m6T+SVSlOhU6Fk6QJKjMYIFfn+1fz
   vpCOqE9trqzxzcfY7J48CbCjSAJ4HxhyTC9OGgkqjL34p1oU4upkznhwG
   5YZXDyGaBKUqje4Au2X1uK8ebOHf27LBt9OFG12dPt9An7PVD2FKilxDj
   BAuufZBFErVzFL1P4S2oyDal5/5MyJz9eQc15C+hk2s6++vynnb/Ykl4F
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="316222783"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="316222783"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 18:38:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="931426844"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 05 Aug 2022 18:38:38 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oK8ly-000JuB-1A;
        Sat, 06 Aug 2022 01:38:38 +0000
Date:   Sat, 6 Aug 2022 09:38:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [intel-tdx:guest-filter 5/28] arch/x86/coco/tdx/filter.c:25:22:
 sparse: sparse: symbol 'pci_allow_ids' was not declared. Should it be
 static?
Message-ID: <202208060939.EJYpA76v-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest-filter
head:   375752c8e70e119e0d481b9e1d835f70087c846c
commit: dc7d40b6d7c8fa942bdc8d7da9203f68a3288ee2 [5/28] x86/tdx: Add device filter support for x86 TDX guest platform
config: x86_64-randconfig-s022 (https://download.01.org/0day-ci/archive/20220806/202208060939.EJYpA76v-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel/tdx/commit/dc7d40b6d7c8fa942bdc8d7da9203f68a3288ee2
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-filter
        git checkout dc7d40b6d7c8fa942bdc8d7da9203f68a3288ee2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/coco/tdx/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> arch/x86/coco/tdx/filter.c:25:22: sparse: sparse: symbol 'pci_allow_ids' was not declared. Should it be static?

vim +/pci_allow_ids +25 arch/x86/coco/tdx/filter.c

    16	
    17	/*
    18	 * Allow list for PCI bus
    19	 *
    20	 * NOTE: Device ID is duplicated here. But for small list
    21	 * of devices, it is easier to maintain the duplicated list
    22	 * here verses exporting the device ID table from the driver
    23	 * and use it.
    24	 */
  > 25	struct pci_device_id pci_allow_ids[] = {
    26		{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT_QUMRANET, VIRTIO_TRANS_ID_NET) },
    27		{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT_QUMRANET, VIRTIO_TRANS_ID_BLOCK) },
    28		{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT_QUMRANET, VIRTIO_TRANS_ID_CONSOLE) },
    29		{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT_QUMRANET, VIRTIO_TRANS_ID_9P) },
    30		{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT_QUMRANET, VIRTIO1_ID_NET) },
    31		{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT_QUMRANET, VIRTIO1_ID_BLOCK) },
    32		{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT_QUMRANET, VIRTIO1_ID_CONSOLE) },
    33		{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT_QUMRANET, VIRTIO1_ID_9P) },
    34		{ 0, },
    35	};
    36	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
