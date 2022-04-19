Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6DC507949
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 20:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354083AbiDSSkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 14:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357425AbiDSSkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:40:07 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126983D1EB
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650393440; x=1681929440;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7EnDri+rzzXdbwBNvqibLC0OTDCudKYbxio2FvHLIN8=;
  b=Nhj+xTsA1igDFXeoK1lNJr5KjBvpS+aSpGVOQhkQlM4wDtbdy9FPiUiB
   oD+Vk1SEbfxg+hZ6quXiR6X1D4JwnpARRrGEqv/reJziL6LZ0NH0LbZ+Z
   dtCl9k7TA4DFh2FnXN8QM8H+U6SNM8USQiimjV+qZGsEOsqevltBJk7Lw
   EjhDwBkmbJgyM9Ar5EOKJJMzf0FZaeNPGtsKkkuDLdGl2qv6Hi/OhQTKv
   uG5J9K+mUkN/0D8nPB/q5JP9P784QmVhGmzOk+aa+K2Cd5mez/zSE1uPm
   in3zL8pJ/bKzwYe9FGQfK6nkvoOsxbkIOl845fHFY0NjuZm5fb6/ciMCI
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="261445155"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="261445155"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 11:37:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="727176861"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 19 Apr 2022 11:37:18 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngsiz-00065I-Eo;
        Tue, 19 Apr 2022 18:37:17 +0000
Date:   Wed, 20 Apr 2022 02:36:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [broonie-ci:file4opaUI 20/24] drivers/spi/spi-intel.c:808:38: error:
 passing argument 2 of 'iop->exec_op' from incompatible pointer type
Message-ID: <202204200200.q7QlOOQc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git file4opaUI
head:   64ef86292800d770fcd8916cf07b1bea58559680
commit: 246bb4cbc6a55a247e5e0afd57c91e0dec0c77c3 [20/24] spi: intel: Implement dirmap hooks
config: powerpc-randconfig-r022-20220419 (https://download.01.org/0day-ci/archive/20220420/202204200200.q7QlOOQc-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git/commit/?id=246bb4cbc6a55a247e5e0afd57c91e0dec0c77c3
        git remote add broonie-ci https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git
        git fetch --no-tags broonie-ci file4opaUI
        git checkout 246bb4cbc6a55a247e5e0afd57c91e0dec0c77c3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/spi/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/mtd/spi-nor.h:10,
                    from drivers/spi/spi-intel.c:13:
   include/linux/mtd/cfi.h:62:2: warning: #warning No CONFIG_MTD_CFI_Ix selected. No NOR chip support can work. [-Wcpp]
      62 | #warning No CONFIG_MTD_CFI_Ix selected. No NOR chip support can work.
         |  ^~~~~~~
   drivers/spi/spi-intel.c: In function 'intel_spi_dirmap_read':
>> drivers/spi/spi-intel.c:808:38: error: passing argument 2 of 'iop->exec_op' from incompatible pointer type [-Werror=incompatible-pointer-types]
     808 |         ret = iop->exec_op(ispi, desc->mem, iop, &op);
         |                                  ~~~~^~~~~
         |                                      |
         |                                      struct spi_mem *
   drivers/spi/spi-intel.c:808:38: note: expected 'const struct intel_spi_mem_op *' but argument is of type 'struct spi_mem *'
   drivers/spi/spi-intel.c:808:45: error: passing argument 3 of 'iop->exec_op' from incompatible pointer type [-Werror=incompatible-pointer-types]
     808 |         ret = iop->exec_op(ispi, desc->mem, iop, &op);
         |                                             ^~~
         |                                             |
         |                                             const struct intel_spi_mem_op *
   drivers/spi/spi-intel.c:808:45: note: expected 'const struct spi_mem_op *' but argument is of type 'const struct intel_spi_mem_op *'
>> drivers/spi/spi-intel.c:808:15: error: too many arguments to function 'iop->exec_op'
     808 |         ret = iop->exec_op(ispi, desc->mem, iop, &op);
         |               ^~~
   drivers/spi/spi-intel.c: In function 'intel_spi_dirmap_write':
   drivers/spi/spi-intel.c:824:38: error: passing argument 2 of 'iop->exec_op' from incompatible pointer type [-Werror=incompatible-pointer-types]
     824 |         ret = iop->exec_op(ispi, desc->mem, iop, &op);
         |                                  ~~~~^~~~~
         |                                      |
         |                                      struct spi_mem *
   drivers/spi/spi-intel.c:824:38: note: expected 'const struct intel_spi_mem_op *' but argument is of type 'struct spi_mem *'
   drivers/spi/spi-intel.c:824:45: error: passing argument 3 of 'iop->exec_op' from incompatible pointer type [-Werror=incompatible-pointer-types]
     824 |         ret = iop->exec_op(ispi, desc->mem, iop, &op);
         |                                             ^~~
         |                                             |
         |                                             const struct intel_spi_mem_op *
   drivers/spi/spi-intel.c:824:45: note: expected 'const struct spi_mem_op *' but argument is of type 'const struct intel_spi_mem_op *'
   drivers/spi/spi-intel.c:824:15: error: too many arguments to function 'iop->exec_op'
     824 |         ret = iop->exec_op(ispi, desc->mem, iop, &op);
         |               ^~~
   cc1: some warnings being treated as errors


vim +808 drivers/spi/spi-intel.c

   794	
   795	static ssize_t intel_spi_dirmap_read(struct spi_mem_dirmap_desc *desc, u64 offs,
   796					     size_t len, void *buf)
   797	{
   798		struct intel_spi *ispi = spi_master_get_devdata(desc->mem->spi->master);
   799		const struct intel_spi_mem_op *iop = desc->priv;
   800		struct spi_mem_op op = desc->info.op_tmpl;
   801		int ret;
   802	
   803		/* Fill in the gaps */
   804		op.addr.val = offs;
   805		op.data.nbytes = len;
   806		op.data.buf.in = buf;
   807	
 > 808		ret = iop->exec_op(ispi, desc->mem, iop, &op);
   809		return ret ? ret : len;
   810	}
   811	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
