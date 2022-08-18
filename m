Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25ECB597B48
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 04:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242588AbiHRCBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 22:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234661AbiHRCA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 22:00:56 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C771AA1D76
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 19:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660788055; x=1692324055;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1rrpwpTOC70pQwvy4VNsNvX0EZXbs9BRtZEbnWgw8Z8=;
  b=lqnxZXEdvT7t0GPhxTziqqoltKza51ulX3PCYRi8EI6XjKCYkQ+gUs4Q
   SXhTyq9mZuFph2lIG2O4apXYQZbCzXBzAdZmsMrFlok2+32+f6Vhc6GKZ
   GniCBlYrUp92vHtC+HqEYfqys9KM00XT/6vn9g1AZchhXqITGUVE8J1yC
   YoiQMPg9jhzZdkeEb/xwGNU6hu8n66C8mkXfvggB6P6dkZX8Kb6dnOv0K
   wxvtupIKLEFvtuQ3/iiChn6QefBCWa9Hlv4Qo8NcViLfcUWwLXpQGHE3c
   8yPv1tgH9WQZ71X4o5Jumrnxiv4odf67sSatBEqFXZZjcK2vpwwK4eS7z
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="318661092"
X-IronPort-AV: E=Sophos;i="5.93,245,1654585200"; 
   d="scan'208";a="318661092"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 19:00:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,245,1654585200"; 
   d="scan'208";a="558349288"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 17 Aug 2022 19:00:53 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oOUq5-0001bU-09;
        Thu, 18 Aug 2022 02:00:53 +0000
Date:   Thu, 18 Aug 2022 09:59:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [intel-tdx:guest-filter 5/28] arch/x86/coco/tdx/filter.c:25:22:
 sparse: sparse: symbol 'pci_allow_ids' was not declared. Should it be
 static?
Message-ID: <202208180949.U99TQppy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest-filter
head:   b5812625f245fbcee0c97d9a431d0f7f2f0aea6d
commit: 7f8f03269925a391cebded5a705121352e5b0e1d [5/28] x86/tdx: Add device filter support for x86 TDX guest platform
config: x86_64-randconfig-s022 (https://download.01.org/0day-ci/archive/20220818/202208180949.U99TQppy-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel/tdx/commit/7f8f03269925a391cebded5a705121352e5b0e1d
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-filter
        git checkout 7f8f03269925a391cebded5a705121352e5b0e1d
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
