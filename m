Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C94A4BD0DA
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 20:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244603AbiBTTIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 14:08:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237468AbiBTTIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 14:08:13 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C7740E62
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 11:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645384071; x=1676920071;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=auI5Fq22qc3D50WuT2ArLDDWErR8+vHT2yG2YDFqlE4=;
  b=FGFM7gpmoTObKRHfQTOpCDgDIzPAl8c607jGvIlV0wXw3vCq29Is4fjJ
   508Yl8vDe+NEmHqSewgcZtBXFexUR/yEldoBjVY+gJGHBK2FDGxcLlMjW
   LL6SSsRXWRIOU9ak7c5BLhxM9xEx80Jnd000KnmLhrdE5DBGF6gRODca2
   NY7ex7W6SrGPbvhdhT3XBDwN58P1ntW9+W/MFLFGB416tmKZnIafNxHvU
   c99GenwC98WWwjExTL84M8lPLfUWCLNgW6OiXgTR/Qu6FLo/XnV5/X/df
   OHoSxtAu7l/c6dBHAJXvKB/ZT9FZ1NnOgvruzcqbrP18+siBuV5ec/Q33
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="238808520"
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="238808520"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 11:07:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="606181950"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 20 Feb 2022 11:07:47 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLrYh-0000cR-3x; Sun, 20 Feb 2022 19:07:47 +0000
Date:   Mon, 21 Feb 2022 03:07:42 +0800
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
Subject: Re: [PATCH v2 14/32] mtd: spi-nor: winbond: unify function names
Message-ID: <202202210301.BeYSA7Ny-lkp@intel.com>
References: <20220218113607.1360020-15-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218113607.1360020-15-michael@walle.cc>
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

Hi Michael,

I love your patch! Perhaps something to improve:

[auto build test WARNING on mtd/spi-nor/next]
[also build test WARNING on tip/master linux/master linus/master v5.17-rc4 next-20220217]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Michael-Walle/mtd-spi-nor-move-vendor-specific-code-into-vendor-modules/20220220-192832
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-nor/next
config: alpha-randconfig-r034-20220220 (https://download.01.org/0day-ci/archive/20220221/202202210301.BeYSA7Ny-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/c09cbfe090ed6015773211aad1bd2387dd958b7a
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Michael-Walle/mtd-spi-nor-move-vendor-specific-code-into-vendor-modules/20220220-192832
        git checkout c09cbfe090ed6015773211aad1bd2387dd958b7a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash drivers/mtd/spi-nor/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/mtd/spi-nor/winbond.c:141: warning: expecting prototype for winbond_set_4byte_addr_mode(). Prototype was for winbond_nor_set_4byte_addr_mode() instead


vim +141 drivers/mtd/spi-nor/winbond.c

7b8b22010af95f Boris Brezillon 2020-03-13  131  
7b8b22010af95f Boris Brezillon 2020-03-13  132  /**
7b8b22010af95f Boris Brezillon 2020-03-13  133   * winbond_set_4byte_addr_mode() - Set 4-byte address mode for Winbond flashes.
7b8b22010af95f Boris Brezillon 2020-03-13  134   * @nor:	pointer to 'struct spi_nor'.
7b8b22010af95f Boris Brezillon 2020-03-13  135   * @enable:	true to enter the 4-byte address mode, false to exit the 4-byte
7b8b22010af95f Boris Brezillon 2020-03-13  136   *		address mode.
7b8b22010af95f Boris Brezillon 2020-03-13  137   *
7b8b22010af95f Boris Brezillon 2020-03-13  138   * Return: 0 on success, -errno otherwise.
7b8b22010af95f Boris Brezillon 2020-03-13  139   */
c09cbfe090ed60 Michael Walle   2022-02-18  140  static int winbond_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
7b8b22010af95f Boris Brezillon 2020-03-13 @141  {
7b8b22010af95f Boris Brezillon 2020-03-13  142  	int ret;
7b8b22010af95f Boris Brezillon 2020-03-13  143  
7b8b22010af95f Boris Brezillon 2020-03-13  144  	ret = spi_nor_set_4byte_addr_mode(nor, enable);
7b8b22010af95f Boris Brezillon 2020-03-13  145  	if (ret || enable)
7b8b22010af95f Boris Brezillon 2020-03-13  146  		return ret;
7b8b22010af95f Boris Brezillon 2020-03-13  147  
7b8b22010af95f Boris Brezillon 2020-03-13  148  	/*
7b8b22010af95f Boris Brezillon 2020-03-13  149  	 * On Winbond W25Q256FV, leaving 4byte mode causes the Extended Address
7b8b22010af95f Boris Brezillon 2020-03-13  150  	 * Register to be set to 1, so all 3-byte-address reads come from the
7b8b22010af95f Boris Brezillon 2020-03-13  151  	 * second 16M. We must clear the register to enable normal behavior.
7b8b22010af95f Boris Brezillon 2020-03-13  152  	 */
7b8b22010af95f Boris Brezillon 2020-03-13  153  	ret = spi_nor_write_enable(nor);
7b8b22010af95f Boris Brezillon 2020-03-13  154  	if (ret)
7b8b22010af95f Boris Brezillon 2020-03-13  155  		return ret;
7b8b22010af95f Boris Brezillon 2020-03-13  156  
7b8b22010af95f Boris Brezillon 2020-03-13  157  	ret = spi_nor_write_ear(nor, 0);
7b8b22010af95f Boris Brezillon 2020-03-13  158  	if (ret)
7b8b22010af95f Boris Brezillon 2020-03-13  159  		return ret;
7b8b22010af95f Boris Brezillon 2020-03-13  160  
7b8b22010af95f Boris Brezillon 2020-03-13  161  	return spi_nor_write_disable(nor);
7b8b22010af95f Boris Brezillon 2020-03-13  162  }
7b8b22010af95f Boris Brezillon 2020-03-13  163  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
