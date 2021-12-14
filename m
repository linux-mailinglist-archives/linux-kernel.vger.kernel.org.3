Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B01B474E6A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 00:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238079AbhLNXEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 18:04:34 -0500
Received: from mga05.intel.com ([192.55.52.43]:21289 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233875AbhLNXEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 18:04:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639523073; x=1671059073;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qt/0bX78cB03INx+HUiS9OiVed6/KeEubFO/mlgVDqs=;
  b=YmJjlTRHSzqLhJFMj+aCjfdWeLB6/0CBu4nThRaXyKibT3+0o3Z9zjsW
   y6hFIPk422pqZQ+9Mcvd8qZhDJ6CZuCcp0KtMQEy/Kcdw6/rA17Sxu9go
   tP8a//CWKsLzy8mrJ5mxtN03gFxlxMNqjOrFjdLMee0TC3yXHdsC8LLQ4
   3HrDMXFMFLvFXRqP8DlXzUAoBZ/Dm4rotgIzTReYKMUj3q5DpY0zYZe3H
   Y4CWi/d9mQXfWP6d64a5zw7QKuQFvseLg+86d1UpKyDmfGYnw8Tuwp9ei
   hfkK64dwAI21NJJxPHZzn+8bl2k6LAr5u6rSw/YpWzoQw0HB3Ve6ro6Az
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="325380902"
X-IronPort-AV: E=Sophos;i="5.88,206,1635231600"; 
   d="scan'208";a="325380902"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 15:04:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,206,1635231600"; 
   d="scan'208";a="465290643"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 14 Dec 2021 15:04:31 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxGqV-0000ts-2I; Tue, 14 Dec 2021 23:04:31 +0000
Date:   Wed, 15 Dec 2021 07:04:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     kbuild-all@lists.01.org, Vinod Koul <vkoul@kernel.org>,
        Kishon <kishon@ti.com>, linux-kernel@vger.kernel.org,
        Tim Harvey <tharvey@gateworks.com>
Subject: [phy:next 37/37] drivers/phy/freescale/phy-fsl-imx8m-pcie.c:41:41:
 error: implicit declaration of function 'FIELD_PREP'
Message-ID: <202112150757.4yrvwmKK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git next
head:   1aa97b002258a190d7790a1a5c0c27829f82e569
commit: 1aa97b002258a190d7790a1a5c0c27829f82e569 [37/37] phy: freescale: pcie: Initialize the imx8 pcie standalone phy driver
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20211215/202112150757.4yrvwmKK-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git/commit/?id=1aa97b002258a190d7790a1a5c0c27829f82e569
        git remote add phy https://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git
        git fetch --no-tags phy next
        git checkout 1aa97b002258a190d7790a1a5c0c27829f82e569
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/phy/freescale/phy-fsl-imx8m-pcie.c: In function 'imx8_pcie_phy_init':
>> drivers/phy/freescale/phy-fsl-imx8m-pcie.c:41:41: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
      41 | #define IMX8MM_GPR_PCIE_REF_CLK_EXT     FIELD_PREP(IMX8MM_GPR_PCIE_REF_CLK_SEL, 0x2)
         |                                         ^~~~~~~~~~
   drivers/phy/freescale/phy-fsl-imx8m-pcie.c:85:28: note: in expansion of macro 'IMX8MM_GPR_PCIE_REF_CLK_EXT'
      85 |                            IMX8MM_GPR_PCIE_REF_CLK_EXT :
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/FIELD_PREP +41 drivers/phy/freescale/phy-fsl-imx8m-pcie.c

    38	
    39	#define IMX8MM_GPR_PCIE_REF_CLK_SEL	GENMASK(25, 24)
    40	#define IMX8MM_GPR_PCIE_REF_CLK_PLL	FIELD_PREP(IMX8MM_GPR_PCIE_REF_CLK_SEL, 0x3)
  > 41	#define IMX8MM_GPR_PCIE_REF_CLK_EXT	FIELD_PREP(IMX8MM_GPR_PCIE_REF_CLK_SEL, 0x2)
    42	#define IMX8MM_GPR_PCIE_AUX_EN		BIT(19)
    43	#define IMX8MM_GPR_PCIE_CMN_RST		BIT(18)
    44	#define IMX8MM_GPR_PCIE_POWER_OFF	BIT(17)
    45	#define IMX8MM_GPR_PCIE_SSC_EN		BIT(16)
    46	#define IMX8MM_GPR_PCIE_AUX_EN_OVERRIDE	BIT(9)
    47	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
