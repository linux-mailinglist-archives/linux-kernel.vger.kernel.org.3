Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07DB54AF58D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 16:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236136AbiBIPlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 10:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236177AbiBIPk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 10:40:58 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2144AC0613CA;
        Wed,  9 Feb 2022 07:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644421259; x=1675957259;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ybIpsMmv2oQsujciJTHbw6FLtIsdAI/tnWcB5Lvr0nM=;
  b=Bio9/O6aEtJH15JzT6gNHEb+eI0GM8j4b1gPHk2gBAzSvAp4k8OVRniS
   OnY9O+UV9+A5kXCj6RCUKx39J8uH3+JRMAerq+sVT83Mcc0obtXweEqBw
   scCb0TmnP8EJN1lE073hvI4yCafe7c3+GbNO5S1pkyaf9h8LJRbJGMENk
   fLhkDrdI3OF8VG/MgJJwy2CCi4/5dhWFxo+e2GO4mA71KpRmlzkYQ3MEa
   GGEtgNBaJeVLGQnL+iGx1oKzKcUQlLNiARSYE2vS/KGUG6Wc/iitk6J3a
   cHrfZb961p452lrubEeuMhMtfnaAfnuXK8yxApT+4lOL1pZMzLg8YU+RM
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="248988099"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="248988099"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 07:40:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="500003852"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 09 Feb 2022 07:40:53 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nHp5Q-0001ym-K7; Wed, 09 Feb 2022 15:40:52 +0000
Date:   Wed, 9 Feb 2022 23:40:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [ambarus:spi-nor/next 9/9] drivers/mtd/spi-nor/macronix.c:20:
 warning: This comment starts with '/**', but isn't a kernel-doc comment.
 Refer Documentation/doc-guide/kernel-doc.rst
Message-ID: <202202092342.YwAYnHF4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ambarus/linux-0day spi-nor/next
head:   89a4d99e9d41b68d34943980943207b58c433256
commit: 89a4d99e9d41b68d34943980943207b58c433256 [9/9] mtd: spi-nor: macronix: Add support for mx66lm1g45g
config: i386-randconfig-a003 (https://download.01.org/0day-ci/archive/20220209/202202092342.YwAYnHF4-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/ambarus/linux-0day/commit/89a4d99e9d41b68d34943980943207b58c433256
        git remote add ambarus https://github.com/ambarus/linux-0day
        git fetch --no-tags ambarus spi-nor/next
        git checkout 89a4d99e9d41b68d34943980943207b58c433256
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/mtd/spi-nor/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/mtd/spi-nor/macronix.c:20: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Macronix SPI NOR flash operations.


vim +20 drivers/mtd/spi-nor/macronix.c

    18	
    19	/**
  > 20	 * Macronix SPI NOR flash operations.
    21	 */
    22	#define SPI_NOR_MX_READ_CR2_OP(ndummy, buf, ndata)			\
    23		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_READ_CR2, 0),		\
    24			   SPI_MEM_OP_ADDR(4, SPINOR_REG_CR2_MODE_ADDR, 0),	\
    25			   SPI_MEM_OP_DUMMY(ndummy, 0),				\
    26			   SPI_MEM_OP_DATA_IN(ndata, buf, 0))
    27	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
