Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC6B526535
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 16:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381362AbiEMOsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 10:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351689AbiEMOrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 10:47:52 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E77C2ED6E
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 07:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652453271; x=1683989271;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HbRDZLon2bEfMnJ+egiJaqJDquML3EXNdRnTwZASpHY=;
  b=Z/cuW2Xiz5QhIAXQNHzPPG5cHCza+oTwdRU9Hw8qMz3TtgeTWvueuJMt
   zZqvIlK/HL3IDglzu8hCW7CzWj/ScKVDmXfg2D9cjSiim+SIv3g2+YLNH
   EEMmDRHH+GeAAPUeUo6CZZv+ORjyEFL/pKdi/nM6H0X+b0JTklJpvEK+O
   c3cfH8T8Ba832a506qTSE+tFMgpuBD1+pz4xAQBCjHZ4XB1CZvKd9alxj
   EQh1+pf20qS7ccnKKwO1jmVGTDNLIr0+fMioPro/hp0iEuLMxqPYJKeAB
   AWZfx8GfLeqPvDYBxrRxFdAEApLYLscvpp16mm4ZjLpnp5uyFMQD+kkVa
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="356748015"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="356748015"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 07:47:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="896251999"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 13 May 2022 07:47:48 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npWa4-000LqE-80;
        Fri, 13 May 2022 14:47:48 +0000
Date:   Fri, 13 May 2022 22:47:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Walle <michael@walle.cc>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH 5/6] mtd: spi-nor: add generic flash driver
Message-ID: <202205132220.uRTFaqNA-lkp@intel.com>
References: <20220513133520.3945820-6-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513133520.3945820-6-michael@walle.cc>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

I love your patch! Perhaps something to improve:

[auto build test WARNING on mtd/spi-nor/next]
[also build test WARNING on next-20220513]
[cannot apply to linux/master linus/master v5.18-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Michael-Walle/mtd-spi-nor-generic-flash-driver/20220513-214238
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-nor/next
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220513/202205132220.uRTFaqNA-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d38c0ac1528d85bea65fc5a9e7f61a10dbc051fb
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Michael-Walle/mtd-spi-nor-generic-flash-driver/20220513-214238
        git checkout d38c0ac1528d85bea65fc5a9e7f61a10dbc051fb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/mtd/spi-nor/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/mtd/spi-nor/sfdp.c:1260: warning: expecting prototype for spi_nor_check_sfdp_header(). Prototype was for spi_nor_check_sfdp_signature() instead


vim +1260 drivers/mtd/spi-nor/sfdp.c

  1249	
  1250	/**
  1251	 * spi_nor_check_sfdp_header() - check for a valid SFDP header
  1252	 * @nor:		pointer to a 'struct spi_nor'
  1253	 *
  1254	 * Used to detect if the flash supports the RDSFDP command as well as the
  1255	 * presence of a valid SFDP table.
  1256	 *
  1257	 * Return: 0 on success, -errno otherwise.
  1258	 */
  1259	int spi_nor_check_sfdp_signature(struct spi_nor *nor)
> 1260	{
  1261		u32 signature;
  1262		int err;
  1263	
  1264		/* Get the SFDP header. */
  1265		err = spi_nor_read_sfdp_dma_unsafe(nor, 0, sizeof(signature),
  1266						   &signature);
  1267		if (err < 0)
  1268			return err;
  1269	
  1270		/* Check the SFDP signature. */
  1271		if (le32_to_cpu(signature) != SFDP_SIGNATURE)
  1272			return -EINVAL;
  1273	
  1274		return 0;
  1275	}
  1276	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
