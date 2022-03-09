Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37A24D28B9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 07:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiCIGLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 01:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiCIGK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 01:10:57 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A09102422;
        Tue,  8 Mar 2022 22:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646806199; x=1678342199;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j4Paq6rqkqKvyEXcOnBuT00IqpCvptBYn4u9HKCe0z8=;
  b=dG6SD8tbvX9S9gWwDuYccsgOoreTBTFz5wUGHHwXtHR01L1qiLEZyr6v
   1OWMVT1MRWdNqoEBoCBIBvt3UPr09jgWanjzmr32vnNEYh94GO+1VSuBB
   qCYocfhejhyUNsaBHnQ8mFvdTGlczFMX6Qy3RVMyiO1V4qL0wuMBQGKZA
   0ovqHlmiOM7vLMDpovgrutl06Mz8/iSzjZ9xfWkDHa4W0Bsma8LhBuILl
   WZYu2nVGny3crRQOv0K1KgNdMME1qikCRd6X4UMlqBFfKRZCOyIkWRfxK
   RHsPOkwM5Vh9YHNvRc8WyiVmEU7XSotBQvA8wNoZsLOZTjv7tgbMmasoh
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="234849388"
X-IronPort-AV: E=Sophos;i="5.90,166,1643702400"; 
   d="scan'208";a="234849388"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 22:09:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,166,1643702400"; 
   d="scan'208";a="611260786"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 08 Mar 2022 22:09:55 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRpWE-0002iD-Bu; Wed, 09 Mar 2022 06:09:54 +0000
Date:   Wed, 9 Mar 2022 14:09:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rafael@kernel.org, linux@armlinux.org.uk
Cc:     kbuild-all@lists.01.org, lenb@kernel.org, robert.moore@intel.com,
        james.morse@arm.com, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@amperecomputing.com, scott@os.amperecomputing.com,
        darren@os.amperecomputing.com
Subject: Re: [PATCH v5 RESEND 2/2] ACPI: AGDI: Add support for Arm Generic
 Diagnostic Dump and Reset device
Message-ID: <202203091424.soyv4Ea1-lkp@intel.com>
References: <20220304052241.151946-3-ilkka@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304052241.151946-3-ilkka@os.amperecomputing.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ilkka,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on next-20220308]
[cannot apply to v5.17-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Ilkka-Koskinen/ACPI-tables-Add-AGDI-to-the-list-of-known-table-signatures/20220304-142317
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220309/202203091424.soyv4Ea1-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/004555056c85ab479f5f0ec4ffb80ab8c0619881
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Ilkka-Koskinen/ACPI-tables-Add-AGDI-to-the-list-of-known-table-signatures/20220304-142317
        git checkout 004555056c85ab479f5f0ec4ffb80ab8c0619881
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/acpi/arm64/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/acpi/arm64/agdi.c:22:13: warning: no previous prototype for 'acpi_agdi_init' [-Wmissing-prototypes]
      22 | void __init acpi_agdi_init(void)
         |             ^~~~~~~~~~~~~~


vim +/acpi_agdi_init +22 drivers/acpi/arm64/agdi.c

    21	
  > 22	void __init acpi_agdi_init(void)

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
