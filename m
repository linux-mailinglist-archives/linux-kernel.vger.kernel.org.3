Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE98A4A76C0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 18:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346212AbiBBRXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 12:23:33 -0500
Received: from mga09.intel.com ([134.134.136.24]:46902 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237041AbiBBRXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 12:23:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643822611; x=1675358611;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FfQwTJzWKATT32F4p5gOzN+KE1zPEG9JU+pMAd3OQ4A=;
  b=OC0X8g4Ja08YzvUc1tCLjxnDiSjmY6XGN9gFY1EpZ3aMinrZw8bu4kp/
   UtVGDpNkeur1bRYRHlcUHtGosL9abPSutCTreZhVhBpj9zzEqiCMUoNmZ
   CNhG+Nhq2Ou0sRKg8yg0s7woA28nvJh7K3tYv8Ir4f6rq0tUchOMBVGO/
   WKB3CFMWrdW1Ir1jVTxXlvWOaoR46vkUagF7ihC2a71uDBcSwcvszn2Gx
   sjWsBZRszES54XXaFDf3eo2RKTvyhmGn3JlXNgfueHHrs2avRdCnswVvZ
   UT5olUVuMD/cQxOdh62SXvGSmcDotGEIGFezNidCowwYnWvMtyj5SYJMd
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="247744500"
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="247744500"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 09:14:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="698967422"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 02 Feb 2022 09:14:10 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFJCr-000UsG-Ma; Wed, 02 Feb 2022 17:14:09 +0000
Date:   Thu, 3 Feb 2022 01:14:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Walle <michael@walle.cc>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v1 05/14] mtd: spi-nor: xilinx: rename vendor specific
 functions and defines
Message-ID: <202202030130.meVKrEGw-lkp@intel.com>
References: <20220202145853.4187726-6-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202145853.4187726-6-michael@walle.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

I love your patch! Perhaps something to improve:

[auto build test WARNING on mtd/spi-nor/next]
[also build test WARNING on linux/master linus/master v5.17-rc2 next-20220202]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Michael-Walle/mtd-spi-nor-move-vendor-specific-code-into-vendor-modules/20220202-230139
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-nor/next
config: alpha-allmodconfig (https://download.01.org/0day-ci/archive/20220203/202202030130.meVKrEGw-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/6527d5f32d65d5695ddcc0bcf3ac31928e64a935
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Michael-Walle/mtd-spi-nor-move-vendor-specific-code-into-vendor-modules/20220202-230139
        git checkout 6527d5f32d65d5695ddcc0bcf3ac31928e64a935
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash drivers/mtd/spi-nor/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/mtd/spi-nor/xilinx.c:103: warning: expecting prototype for spi_nor_xsr_ready(). Prototype was for xilinx_sr_ready() instead


vim +103 drivers/mtd/spi-nor/xilinx.c

37ccf5a41e1528 Michael Walle 2022-02-02   94  
37ccf5a41e1528 Michael Walle 2022-02-02   95  /**
37ccf5a41e1528 Michael Walle 2022-02-02   96   * spi_nor_xsr_ready() - Query the Status Register of the S3AN flash to see if
37ccf5a41e1528 Michael Walle 2022-02-02   97   * the flash is ready for new commands.
37ccf5a41e1528 Michael Walle 2022-02-02   98   * @nor:	pointer to 'struct spi_nor'.
37ccf5a41e1528 Michael Walle 2022-02-02   99   *
37ccf5a41e1528 Michael Walle 2022-02-02  100   * Return: 1 if ready, 0 if not ready, -errno on errors.
37ccf5a41e1528 Michael Walle 2022-02-02  101   */
6527d5f32d65d5 Michael Walle 2022-02-02  102  static int xilinx_sr_ready(struct spi_nor *nor)
37ccf5a41e1528 Michael Walle 2022-02-02 @103  {
37ccf5a41e1528 Michael Walle 2022-02-02  104  	int ret;
37ccf5a41e1528 Michael Walle 2022-02-02  105  
6527d5f32d65d5 Michael Walle 2022-02-02  106  	ret = xilinx_read_sr(nor, nor->bouncebuf);
37ccf5a41e1528 Michael Walle 2022-02-02  107  	if (ret)
37ccf5a41e1528 Michael Walle 2022-02-02  108  		return ret;
37ccf5a41e1528 Michael Walle 2022-02-02  109  
37ccf5a41e1528 Michael Walle 2022-02-02  110  	return !!(nor->bouncebuf[0] & XSR_RDY);
37ccf5a41e1528 Michael Walle 2022-02-02  111  }
37ccf5a41e1528 Michael Walle 2022-02-02  112  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
