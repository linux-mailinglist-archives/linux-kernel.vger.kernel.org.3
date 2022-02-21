Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE314BDFB1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357899AbiBUMTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 07:19:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357853AbiBUMT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 07:19:29 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5268CCEF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 04:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645445779; x=1676981779;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8hVLrnAnBGBdpP5SQ/9ADmMHt7FI1CBjOU1y3Dq+Z6k=;
  b=BzPUURULbtYdVVQ7cMCT32dETHossNtQKF3X+M8Bf8vDjwSrtsdJIiv+
   ZBfHF96zHxYOfkwRGrW6IUjZczv8PWXFDwQwQYoshuKqBiJ7GXBLn6NKS
   utAV9dzCrFSNnQw/81JltNnVJ6iwiqA76A3ODHPbZDx7zm83oAxi1blTx
   Wxd9uq1KuWDEBvg8MgF8PJR8kWUQnuOarzjaNSFQllNwzqBVGxQRjg1UW
   tqQagz2GHMPCxsx7AKI+jwT2aDCV0uYFXR8oioIcgLYUgQnCcQ+X+6w7v
   R9TgGbiQkzqMqiJMvaxRLQibr+2S1dxlnSe0gCMRAv7eklj+iWbZlGLm5
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="235038646"
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="235038646"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 04:16:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="775981651"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 21 Feb 2022 04:16:15 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nM7by-0001Zy-3Q; Mon, 21 Feb 2022 12:16:14 +0000
Date:   Mon, 21 Feb 2022 20:15:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Walle <michael@walle.cc>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        yaliang.wang@windriver.com, Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v3 12/32] mtd: spi-nor: spansion: unify function names
Message-ID: <202202212013.sOSFyoNv-lkp@intel.com>
References: <20220221085236.1452024-13-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221085236.1452024-13-michael@walle.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

I love your patch! Yet something to improve:

[auto build test ERROR on mtd/spi-nor/next]
[also build test ERROR on tip/master linux/master linus/master v5.17-rc5 next-20220217]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Michael-Walle/mtd-spi-nor-move-vendor-specific-code-into-vendor-modules/20220221-165728
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-nor/next
config: x86_64-randconfig-a003-20220221 (https://download.01.org/0day-ci/archive/20220221/202202212013.sOSFyoNv-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/f8aeae6008aa9a304aacb1914911dcb3a895da53
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Michael-Walle/mtd-spi-nor-move-vendor-specific-code-into-vendor-modules/20220221-165728
        git checkout f8aeae6008aa9a304aacb1914911dcb3a895da53
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/mtd/spi-nor/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/mtd/spi-nor/spansion.c:232:14: error: 's25fs_s_fixups' undeclared here (not in a function); did you mean 's25fs_s_nor_fixups'?
     232 |   .fixups = &s25fs_s_fixups, },
         |              ^~~~~~~~~~~~~~
         |              s25fs_s_nor_fixups
   drivers/mtd/spi-nor/spansion.c:201:36: warning: 's25fs_s_nor_fixups' defined but not used [-Wunused-const-variable=]
     201 | static const struct spi_nor_fixups s25fs_s_nor_fixups = {
         |                                    ^~~~~~~~~~~~~~~~~~


vim +232 drivers/mtd/spi-nor/spansion.c

5587fa489747a8 Sergei Shtylyov 2020-04-20  204  
f8aeae6008aa9a Michael Walle   2022-02-21  205  static const struct flash_info spansion_nor_parts[] = {
0173c32a0ebd42 Boris Brezillon 2020-03-13  206  	/* Spansion/Cypress -- single (large) sector size only, at least
0173c32a0ebd42 Boris Brezillon 2020-03-13  207  	 * for the chips listed here (without boot sectors).
0173c32a0ebd42 Boris Brezillon 2020-03-13  208  	 */
ec1c0e996035c8 Tudor Ambarus   2021-12-07  209  	{ "s25sl032p",  INFO(0x010215, 0x4d00,  64 * 1024,  64)
ec1c0e996035c8 Tudor Ambarus   2021-12-07  210  		NO_SFDP_FLAGS(SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
ec1c0e996035c8 Tudor Ambarus   2021-12-07  211  	{ "s25sl064p",  INFO(0x010216, 0x4d00,  64 * 1024, 128)
ec1c0e996035c8 Tudor Ambarus   2021-12-07  212  		NO_SFDP_FLAGS(SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
ec1c0e996035c8 Tudor Ambarus   2021-12-07  213  	{ "s25fl128s0", INFO6(0x012018, 0x4d0080, 256 * 1024, 64)
ec1c0e996035c8 Tudor Ambarus   2021-12-07  214  		FLAGS(USE_CLSR)
ec1c0e996035c8 Tudor Ambarus   2021-12-07  215  		NO_SFDP_FLAGS(SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
ec1c0e996035c8 Tudor Ambarus   2021-12-07  216  	{ "s25fl128s1", INFO6(0x012018, 0x4d0180, 64 * 1024, 256)
ec1c0e996035c8 Tudor Ambarus   2021-12-07  217  		FLAGS(USE_CLSR)
ec1c0e996035c8 Tudor Ambarus   2021-12-07  218  		NO_SFDP_FLAGS(SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
ec1c0e996035c8 Tudor Ambarus   2021-12-07  219  	{ "s25fl256s0", INFO6(0x010219, 0x4d0080, 256 * 1024, 128)
ec1c0e996035c8 Tudor Ambarus   2021-12-07  220  		FLAGS(USE_CLSR)
5eefc2dc03192c Tudor Ambarus   2021-12-07  221  		NO_SFDP_FLAGS(SPI_NOR_SKIP_SFDP | SPI_NOR_DUAL_READ |
5eefc2dc03192c Tudor Ambarus   2021-12-07  222  			      SPI_NOR_QUAD_READ) },
ec1c0e996035c8 Tudor Ambarus   2021-12-07  223  	{ "s25fl256s1", INFO6(0x010219, 0x4d0180, 64 * 1024, 512)
ec1c0e996035c8 Tudor Ambarus   2021-12-07  224  		FLAGS(USE_CLSR)
ec1c0e996035c8 Tudor Ambarus   2021-12-07  225  		NO_SFDP_FLAGS(SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
ec1c0e996035c8 Tudor Ambarus   2021-12-07  226  	{ "s25fl512s",  INFO6(0x010220, 0x4d0080, 256 * 1024, 256)
ec1c0e996035c8 Tudor Ambarus   2021-12-07  227  		FLAGS(SPI_NOR_HAS_LOCK | USE_CLSR)
ec1c0e996035c8 Tudor Ambarus   2021-12-07  228  		NO_SFDP_FLAGS(SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
ec1c0e996035c8 Tudor Ambarus   2021-12-07  229  	{ "s25fs128s1", INFO6(0x012018, 0x4d0181, 64 * 1024, 256)
ec1c0e996035c8 Tudor Ambarus   2021-12-07  230  		FLAGS(USE_CLSR)
ec1c0e996035c8 Tudor Ambarus   2021-12-07  231  		NO_SFDP_FLAGS(SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
c26d0d87f175b8 Yicong Yang     2020-04-22 @232  		.fixups = &s25fs_s_fixups, },
ec1c0e996035c8 Tudor Ambarus   2021-12-07  233  	{ "s25fs256s0", INFO6(0x010219, 0x4d0081, 256 * 1024, 128)
ec1c0e996035c8 Tudor Ambarus   2021-12-07  234  		FLAGS(USE_CLSR)
ec1c0e996035c8 Tudor Ambarus   2021-12-07  235  		NO_SFDP_FLAGS(SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
ec1c0e996035c8 Tudor Ambarus   2021-12-07  236  	{ "s25fs256s1", INFO6(0x010219, 0x4d0181, 64 * 1024, 512)
ec1c0e996035c8 Tudor Ambarus   2021-12-07  237  		FLAGS(USE_CLSR)
ec1c0e996035c8 Tudor Ambarus   2021-12-07  238  		NO_SFDP_FLAGS(SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
ec1c0e996035c8 Tudor Ambarus   2021-12-07  239  	{ "s25fs512s",  INFO6(0x010220, 0x4d0081, 256 * 1024, 256)
ec1c0e996035c8 Tudor Ambarus   2021-12-07  240  		FLAGS(USE_CLSR)
ec1c0e996035c8 Tudor Ambarus   2021-12-07  241  		NO_SFDP_FLAGS(SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
5587fa489747a8 Sergei Shtylyov 2020-04-20  242  		.fixups = &s25fs_s_fixups, },
ec1c0e996035c8 Tudor Ambarus   2021-12-07  243  	{ "s25sl12800", INFO(0x012018, 0x0300, 256 * 1024,  64) },
ec1c0e996035c8 Tudor Ambarus   2021-12-07  244  	{ "s25sl12801", INFO(0x012018, 0x0301,  64 * 1024, 256) },
ec1c0e996035c8 Tudor Ambarus   2021-12-07  245  	{ "s25fl129p0", INFO(0x012018, 0x4d00, 256 * 1024,  64)
ec1c0e996035c8 Tudor Ambarus   2021-12-07  246  		FLAGS(USE_CLSR)
ec1c0e996035c8 Tudor Ambarus   2021-12-07  247  		NO_SFDP_FLAGS(SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
ec1c0e996035c8 Tudor Ambarus   2021-12-07  248  	{ "s25fl129p1", INFO(0x012018, 0x4d01,  64 * 1024, 256)
ec1c0e996035c8 Tudor Ambarus   2021-12-07  249  		FLAGS(USE_CLSR)
ec1c0e996035c8 Tudor Ambarus   2021-12-07  250  		NO_SFDP_FLAGS(SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
ec1c0e996035c8 Tudor Ambarus   2021-12-07  251  	{ "s25sl004a",  INFO(0x010212,      0,  64 * 1024,   8) },
ec1c0e996035c8 Tudor Ambarus   2021-12-07  252  	{ "s25sl008a",  INFO(0x010213,      0,  64 * 1024,  16) },
ec1c0e996035c8 Tudor Ambarus   2021-12-07  253  	{ "s25sl016a",  INFO(0x010214,      0,  64 * 1024,  32) },
ec1c0e996035c8 Tudor Ambarus   2021-12-07  254  	{ "s25sl032a",  INFO(0x010215,      0,  64 * 1024,  64) },
ec1c0e996035c8 Tudor Ambarus   2021-12-07  255  	{ "s25sl064a",  INFO(0x010216,      0,  64 * 1024, 128) },
ec1c0e996035c8 Tudor Ambarus   2021-12-07  256  	{ "s25fl004k",  INFO(0xef4013,      0,  64 * 1024,   8)
ec1c0e996035c8 Tudor Ambarus   2021-12-07  257  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
ec1c0e996035c8 Tudor Ambarus   2021-12-07  258  			      SPI_NOR_QUAD_READ) },
ec1c0e996035c8 Tudor Ambarus   2021-12-07  259  	{ "s25fl008k",  INFO(0xef4014,      0,  64 * 1024,  16)
ec1c0e996035c8 Tudor Ambarus   2021-12-07  260  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
ec1c0e996035c8 Tudor Ambarus   2021-12-07  261  			      SPI_NOR_QUAD_READ) },
ec1c0e996035c8 Tudor Ambarus   2021-12-07  262  	{ "s25fl016k",  INFO(0xef4015,      0,  64 * 1024,  32)
ec1c0e996035c8 Tudor Ambarus   2021-12-07  263  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
ec1c0e996035c8 Tudor Ambarus   2021-12-07  264  			      SPI_NOR_QUAD_READ) },
ec1c0e996035c8 Tudor Ambarus   2021-12-07  265  	{ "s25fl064k",  INFO(0xef4017,      0,  64 * 1024, 128)
ec1c0e996035c8 Tudor Ambarus   2021-12-07  266  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
ec1c0e996035c8 Tudor Ambarus   2021-12-07  267  			      SPI_NOR_QUAD_READ) },
ec1c0e996035c8 Tudor Ambarus   2021-12-07  268  	{ "s25fl116k",  INFO(0x014015,      0,  64 * 1024,  32)
ec1c0e996035c8 Tudor Ambarus   2021-12-07  269  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
ec1c0e996035c8 Tudor Ambarus   2021-12-07  270  			      SPI_NOR_QUAD_READ) },
ec1c0e996035c8 Tudor Ambarus   2021-12-07  271  	{ "s25fl132k",  INFO(0x014016,      0,  64 * 1024,  64)
ec1c0e996035c8 Tudor Ambarus   2021-12-07  272  		NO_SFDP_FLAGS(SECT_4K) },
ec1c0e996035c8 Tudor Ambarus   2021-12-07  273  	{ "s25fl164k",  INFO(0x014017,      0,  64 * 1024, 128)
ec1c0e996035c8 Tudor Ambarus   2021-12-07  274  		NO_SFDP_FLAGS(SECT_4K) },
ec1c0e996035c8 Tudor Ambarus   2021-12-07  275  	{ "s25fl204k",  INFO(0x014013,      0,  64 * 1024,   8)
ec1c0e996035c8 Tudor Ambarus   2021-12-07  276  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ) },
ec1c0e996035c8 Tudor Ambarus   2021-12-07  277  	{ "s25fl208k",  INFO(0x014014,      0,  64 * 1024,  16)
ec1c0e996035c8 Tudor Ambarus   2021-12-07  278  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ) },
ec1c0e996035c8 Tudor Ambarus   2021-12-07  279  	{ "s25fl064l",  INFO(0x016017,      0,  64 * 1024, 128)
ec1c0e996035c8 Tudor Ambarus   2021-12-07  280  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
ec1c0e996035c8 Tudor Ambarus   2021-12-07  281  		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
ec1c0e996035c8 Tudor Ambarus   2021-12-07  282  	{ "s25fl128l",  INFO(0x016018,      0,  64 * 1024, 256)
ec1c0e996035c8 Tudor Ambarus   2021-12-07  283  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
ec1c0e996035c8 Tudor Ambarus   2021-12-07  284  		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
ec1c0e996035c8 Tudor Ambarus   2021-12-07  285  	{ "s25fl256l",  INFO(0x016019,      0,  64 * 1024, 512)
ec1c0e996035c8 Tudor Ambarus   2021-12-07  286  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
ec1c0e996035c8 Tudor Ambarus   2021-12-07  287  		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
ec1c0e996035c8 Tudor Ambarus   2021-12-07  288  	{ "cy15x104q",  INFO6(0x042cc2, 0x7f7f7f, 512 * 1024, 1)
ec1c0e996035c8 Tudor Ambarus   2021-12-07  289  		FLAGS(SPI_NOR_NO_ERASE) },
ec1c0e996035c8 Tudor Ambarus   2021-12-07  290  	{ "s28hs512t",   INFO(0x345b1a,      0, 256 * 1024, 256)
ec1c0e996035c8 Tudor Ambarus   2021-12-07  291  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_OCTAL_DTR_READ |
c3266af101f28e Pratyush Yadav  2020-10-05  292  			      SPI_NOR_OCTAL_DTR_PP)
c3266af101f28e Pratyush Yadav  2020-10-05  293  		.fixups = &s28hs512t_fixups,
c3266af101f28e Pratyush Yadav  2020-10-05  294  	},
0173c32a0ebd42 Boris Brezillon 2020-03-13  295  };
0173c32a0ebd42 Boris Brezillon 2020-03-13  296  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
