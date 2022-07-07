Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AD156AC8D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 22:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236058AbiGGUJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 16:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235942AbiGGUJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 16:09:05 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A9922BD4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 13:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657224544; x=1688760544;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=feBtOv+Wkde6tc78sObtHiwH7bssGhZQUVGVAsYRa7g=;
  b=eXoS61TMlAAgt7uPetZek9b1onyIOsMNaP/pcgJVKMn8gEwkz4rzfS/o
   QJBkNGOOd5xGs5Cueo7MgbHYaproOWcZFBYKHtDh79su0PQhr5zJLf6Wr
   wZVUb2gAtDyj2/yHiD02bP1d+e/wJrGPrWGMFCYHtbX2CSGXuWB6lcPg8
   1fARcSUrCmza2Uy9/GsmYdUfQFds9+NiUtZsOhuDb8k2wuSbBak5fk4YP
   cC0yYXfcyRmt8pLKXqdV5pKq/jclK7V67WDMlvI6h0hGHfn9P9y0uyyPz
   sBSZeRk7T/8Vp4lay1AYOjA3Oaga9lbnxTiyeYI8TbHeVo8ZT5j11wXcE
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="348097141"
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="348097141"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 13:09:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="661518737"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 07 Jul 2022 13:09:02 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9Xo5-000MQC-JS;
        Thu, 07 Jul 2022 20:09:01 +0000
Date:   Fri, 8 Jul 2022 04:08:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:bluetooth-wip 8/8]
 drivers/bluetooth/hci_bcm43xx.c:1062:30: warning: unused variable 'bcm43xx'
Message-ID: <202207080351.QotD6R07-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bluetooth-wip
head:   a1e15829f0faa83ea0884f38fa4cae8990f76801
commit: a1e15829f0faa83ea0884f38fa4cae8990f76801 [8/8] Bluetooth: hci_bcm43xx: Add new driver for BCM43XX PCI boards
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220708/202207080351.QotD6R07-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/AsahiLinux/linux/commit/a1e15829f0faa83ea0884f38fa4cae8990f76801
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bluetooth-wip
        git checkout a1e15829f0faa83ea0884f38fa4cae8990f76801
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/bluetooth/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/bluetooth/hci_bcm43xx.c: In function 'bcm43xx_hci_close':
>> drivers/bluetooth/hci_bcm43xx.c:1062:30: warning: unused variable 'bcm43xx' [-Wunused-variable]
    1062 |         struct bcm43xx_data *bcm43xx = hci_get_drvdata(hdev);
         |                              ^~~~~~~
   drivers/bluetooth/hci_bcm43xx.c: In function 'bcm43xx_init_context':
   drivers/bluetooth/hci_bcm43xx.c:1243:29: error: passing argument 3 of 'dmam_alloc_coherent' from incompatible pointer type [-Werror=incompatible-pointer-types]
    1243 |                             &bcm43xx->ctx->per_info_addr, GFP_KERNEL);
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                             |
         |                             __le64 * {aka long long unsigned int *}
   In file included from drivers/bluetooth/hci_bcm43xx.c:34:
   include/linux/dma-mapping.h:550:29: note: expected 'dma_addr_t *' {aka 'unsigned int *'} but argument is of type '__le64 *' {aka 'long long unsigned int *'}
     550 |                 dma_addr_t *dma_handle, gfp_t gfp)
         |                 ~~~~~~~~~~~~^~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/bcm43xx +1062 drivers/bluetooth/hci_bcm43xx.c

  1059	
  1060	static int bcm43xx_hci_close(struct hci_dev *hdev)
  1061	{
> 1062		struct bcm43xx_data *bcm43xx = hci_get_drvdata(hdev);
  1063	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
