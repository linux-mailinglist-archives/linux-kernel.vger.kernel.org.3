Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161944D2DA6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 12:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbiCILKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 06:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbiCILKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 06:10:04 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98424125C9F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 03:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646824146; x=1678360146;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Eo9nlWOx53qpkkW31pjZzB7mIGz1Skew6VqvHY4/bCE=;
  b=Q15VrMHhoZn41t5jQRh4Bnygod4eSnwFM02VwhOGpMqY0wsSxatorIiv
   9sJ0pPTrCsTBas/X4bS2cHQMBnWue+cg4AbvF1VnRfKGffzzFFlVy1IFU
   GBT9fzpqI9R3BC4MoqbXHing51o9aQFifNrK6ShGMjpsouNDAQAu15tHy
   Zc9Qs0REp1+6dEvJRo5oKGV9GGhKtEeF4hCh6P6YJaK7Rx9BaSJq/GOtL
   ledOuK2f+40vxWeaYIY067PUdm5D4IsrdPFILxpd4NlMXFFGPcGHd0UJp
   CehI2uXKmF2CvKfxymlqwLSgTdR/oEOZL9osnzHRcpSnBd3WCh7srGHhV
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="341379429"
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="341379429"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 03:09:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="547590288"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 09 Mar 2022 03:09:05 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRuBk-000391-LY; Wed, 09 Mar 2022 11:09:04 +0000
Date:   Wed, 9 Mar 2022 19:08:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Liu Yi L <yi.l.liu@intel.com>
Subject: [luxis1999-iommufd:iommufd-v5.17-rc6 37/40] undefined reference to
 `iommufd_vfio_check_extension'
Message-ID: <202203091936.QAP99zL8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/luxis1999/iommufd iommufd-v5.17-rc6
head:   cde3fc107eb3877b1055b6c5cd048c18d6f5b8d5
commit: a3f133279ae994c62f5a14dbcd334564651484c8 [37/40] vfio: Add iommufd VFIO compat support to group_fd
config: microblaze-randconfig-m031-20220308 (https://download.01.org/0day-ci/archive/20220309/202203091936.QAP99zL8-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/luxis1999/iommufd/commit/a3f133279ae994c62f5a14dbcd334564651484c8
        git remote add luxis1999-iommufd https://github.com/luxis1999/iommufd
        git fetch --no-tags luxis1999-iommufd iommufd-v5.17-rc6
        git checkout a3f133279ae994c62f5a14dbcd334564651484c8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=microblaze SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   microblaze-linux-ld: drivers/vfio/vfio.o: in function `vfio_external_check_extension':
>> (.text+0x14dc): undefined reference to `iommufd_vfio_check_extension'
   microblaze-linux-ld: drivers/vfio/vfio.o: in function `__vfio_group_unset_container':
>> (.text+0x1554): undefined reference to `vfio_group_unset_iommufd'
   microblaze-linux-ld: drivers/vfio/vfio.o: in function `vfio_group_set_container':
>> (.text+0x1d50): undefined reference to `vfio_group_set_iommufd'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
