Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A50C4A6021
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 16:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240317AbiBAP3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 10:29:05 -0500
Received: from mga07.intel.com ([134.134.136.100]:35658 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240294AbiBAP3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 10:29:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643729344; x=1675265344;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=O9qf2U0x7o4A/jcao6X2JJyNTrNpGEOOemrb2qph0vo=;
  b=EAEad/C1F1Swty4pCWlEhLVN1zswxDh7jb/vzbp5yPYH0gSG0p2NqcRu
   8u9yZscwimOdHeiZ41EB+fn2o7k5Coz8+5jbJbrWBP1hxZs4GJKfvGNEC
   mh86TNQZO0sSkrhcFuufnfdnyR9X9tCU16+YcyYAWtPtlWo1HiOqrg7Pb
   Nvu8Aw0KAv2oDhZBecuWcZzR4yXmmfyy7uj4WUeKqddVkhDZv5PXIdJVd
   P14SIJi57LR/8iynm2Bc6YGRnJhdFsF4PwQ/YfCVCPIsrKc+6R6suBRkt
   1SkKi19LTygCl4a5HGsbYbp8ylcr0F4G7YJLv7PGf6AjDCuVYe56AM+oK
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="311022304"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="311022304"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 07:28:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="698437069"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 01 Feb 2022 07:28:50 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEv5O-000TPg-6S; Tue, 01 Feb 2022 15:28:50 +0000
Date:   Tue, 1 Feb 2022 23:28:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Will McVicker <willmcvicker@google.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [ammarfaizi2-block:google/android/kernel/common/android-4.19-stable
 343/9999] drivers/nvmem/core.c:347:5: warning: no previous prototype for
 function 'nvmem_add_cells'
Message-ID: <202202012338.LedWi6I7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android-4.19-stable
head:   b45c5eeda8dea785e3d411380b486a209768f6b2
commit: e96a10625581a499e8a4218ef504f3f53918408b [343/9999] UPSTREAM: nvmem: add support for cell info
config: x86_64-randconfig-r026-20220131 (https://download.01.org/0day-ci/archive/20220201/202202012338.LedWi6I7-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 6b1e844b69f15bb7dffaf9365cd2b355d2eb7579)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/e96a10625581a499e8a4218ef504f3f53918408b
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android-4.19-stable
        git checkout e96a10625581a499e8a4218ef504f3f53918408b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/nvmem/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/nvmem/core.c:347:5: warning: no previous prototype for function 'nvmem_add_cells' [-Wmissing-prototypes]
   int nvmem_add_cells(struct nvmem_device *nvmem,
       ^
   drivers/nvmem/core.c:347:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int nvmem_add_cells(struct nvmem_device *nvmem,
   ^
   static 
   1 warning generated.


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
