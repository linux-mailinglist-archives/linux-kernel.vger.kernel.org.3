Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACE7B4AF08D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiBIMAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbiBIL65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 06:58:57 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83181E00F7DF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 03:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644407747; x=1675943747;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yCm83f3tzqfBQcDpiYkQIFoUMaRULXgYatxyjGslVP4=;
  b=DeYdmGysxb1Nw+23g5H8g5ZcU6b/3rUpmEQ2ESC8tdxAFecitgRu9FSj
   eZpL8a+V1qr4JC28JLR04vATttlETyqb29orksThhoQCt8OxwSceVDeBJ
   kTEglsb8ovOcYR7mBBdFa7G26Xr5mA7py/6e3SUUeZf6y1IN50Tyr+8Kn
   gho/7ahq4CqFPN41OhtaNCLdqdLE8VmnA67R7LaN4P/W8qztC0w5JiYWk
   6Y7OTI0Hb1gY3RBVhyKexFGmg8L8VG3I+YpOYz99Up6+U1btNj3BEPTLr
   QG+dN+ARHH5trUbRoDb64QBQ1oCJ2OUhF+6JXtbpvUyneF1Qi4vImoY14
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="312482095"
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="312482095"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 03:55:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="701228478"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 09 Feb 2022 03:55:45 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nHlZY-0001lE-Fu; Wed, 09 Feb 2022 11:55:44 +0000
Date:   Wed, 9 Feb 2022 19:54:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Will McVicker <willmcvicker@google.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [ammarfaizi2-block:google/android/kernel/common/android-4.19-stable
 95/9999] drivers/nvmem/core.c:347:5: warning: no previous prototype for
 'nvmem_add_cells'
Message-ID: <202202091936.rHZ0Thvu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android-4.19-stable
head:   69be2ccce366f9ef3eec5cd1c9b8bfb3e1c2d16d
commit: e96a10625581a499e8a4218ef504f3f53918408b [95/9999] UPSTREAM: nvmem: add support for cell info
config: x86_64-randconfig-a011 (https://download.01.org/0day-ci/archive/20220209/202202091936.rHZ0Thvu-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/e96a10625581a499e8a4218ef504f3f53918408b
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android-4.19-stable
        git checkout e96a10625581a499e8a4218ef504f3f53918408b
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/nvmem/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/nvmem/core.c:347:5: warning: no previous prototype for 'nvmem_add_cells' [-Wmissing-prototypes]
     347 | int nvmem_add_cells(struct nvmem_device *nvmem,
         |     ^~~~~~~~~~~~~~~


vim +/nvmem_add_cells +347 drivers/nvmem/core.c

eace75cfdcf7d9 Srinivas Kandagatla 2015-07-27  337  
b3db17e4b864e4 Andrew Lunn         2018-05-11  338  /**
b3db17e4b864e4 Andrew Lunn         2018-05-11  339   * nvmem_add_cells() - Add cell information to an nvmem device
b3db17e4b864e4 Andrew Lunn         2018-05-11  340   *
b3db17e4b864e4 Andrew Lunn         2018-05-11  341   * @nvmem: nvmem device to add cells to.
b3db17e4b864e4 Andrew Lunn         2018-05-11  342   * @info: nvmem cell info to add to the device
b3db17e4b864e4 Andrew Lunn         2018-05-11  343   * @ncells: number of cells in info
b3db17e4b864e4 Andrew Lunn         2018-05-11  344   *
b3db17e4b864e4 Andrew Lunn         2018-05-11  345   * Return: 0 or negative error code on failure.
b3db17e4b864e4 Andrew Lunn         2018-05-11  346   */
b3db17e4b864e4 Andrew Lunn         2018-05-11 @347  int nvmem_add_cells(struct nvmem_device *nvmem,
b3db17e4b864e4 Andrew Lunn         2018-05-11  348  		    const struct nvmem_cell_info *info,
b3db17e4b864e4 Andrew Lunn         2018-05-11  349  		    int ncells)
eace75cfdcf7d9 Srinivas Kandagatla 2015-07-27  350  {
eace75cfdcf7d9 Srinivas Kandagatla 2015-07-27  351  	struct nvmem_cell **cells;
eace75cfdcf7d9 Srinivas Kandagatla 2015-07-27  352  	int i, rval;
eace75cfdcf7d9 Srinivas Kandagatla 2015-07-27  353  
b3db17e4b864e4 Andrew Lunn         2018-05-11  354  	cells = kcalloc(ncells, sizeof(*cells), GFP_KERNEL);
eace75cfdcf7d9 Srinivas Kandagatla 2015-07-27  355  	if (!cells)
eace75cfdcf7d9 Srinivas Kandagatla 2015-07-27  356  		return -ENOMEM;
eace75cfdcf7d9 Srinivas Kandagatla 2015-07-27  357  
b3db17e4b864e4 Andrew Lunn         2018-05-11  358  	for (i = 0; i < ncells; i++) {
eace75cfdcf7d9 Srinivas Kandagatla 2015-07-27  359  		cells[i] = kzalloc(sizeof(**cells), GFP_KERNEL);
eace75cfdcf7d9 Srinivas Kandagatla 2015-07-27  360  		if (!cells[i]) {
eace75cfdcf7d9 Srinivas Kandagatla 2015-07-27  361  			rval = -ENOMEM;
eace75cfdcf7d9 Srinivas Kandagatla 2015-07-27  362  			goto err;
eace75cfdcf7d9 Srinivas Kandagatla 2015-07-27  363  		}
eace75cfdcf7d9 Srinivas Kandagatla 2015-07-27  364  
eace75cfdcf7d9 Srinivas Kandagatla 2015-07-27  365  		rval = nvmem_cell_info_to_nvmem_cell(nvmem, &info[i], cells[i]);
287980e49ffc0f Arnd Bergmann       2016-05-27  366  		if (rval) {
eace75cfdcf7d9 Srinivas Kandagatla 2015-07-27  367  			kfree(cells[i]);
eace75cfdcf7d9 Srinivas Kandagatla 2015-07-27  368  			goto err;
eace75cfdcf7d9 Srinivas Kandagatla 2015-07-27  369  		}
eace75cfdcf7d9 Srinivas Kandagatla 2015-07-27  370  
eace75cfdcf7d9 Srinivas Kandagatla 2015-07-27  371  		nvmem_cell_add(cells[i]);
eace75cfdcf7d9 Srinivas Kandagatla 2015-07-27  372  	}
eace75cfdcf7d9 Srinivas Kandagatla 2015-07-27  373  
eace75cfdcf7d9 Srinivas Kandagatla 2015-07-27  374  	/* remove tmp array */
eace75cfdcf7d9 Srinivas Kandagatla 2015-07-27  375  	kfree(cells);
eace75cfdcf7d9 Srinivas Kandagatla 2015-07-27  376  
eace75cfdcf7d9 Srinivas Kandagatla 2015-07-27  377  	return 0;
eace75cfdcf7d9 Srinivas Kandagatla 2015-07-27  378  err:
dfdf141429f089 Rasmus Villemoes    2016-02-08  379  	while (i--)
eace75cfdcf7d9 Srinivas Kandagatla 2015-07-27  380  		nvmem_cell_drop(cells[i]);
eace75cfdcf7d9 Srinivas Kandagatla 2015-07-27  381  
dfdf141429f089 Rasmus Villemoes    2016-02-08  382  	kfree(cells);
dfdf141429f089 Rasmus Villemoes    2016-02-08  383  
eace75cfdcf7d9 Srinivas Kandagatla 2015-07-27  384  	return rval;
eace75cfdcf7d9 Srinivas Kandagatla 2015-07-27  385  }
b3db17e4b864e4 Andrew Lunn         2018-05-11  386  EXPORT_SYMBOL_GPL(nvmem_add_cells);
eace75cfdcf7d9 Srinivas Kandagatla 2015-07-27  387  

:::::: The code at line 347 was first introduced by commit
:::::: b3db17e4b864e46ad150ebef69c0e0130a1c5fca drivers: nvmem: Export nvmem_add_cells()

:::::: TO: Andrew Lunn <andrew@lunn.ch>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
