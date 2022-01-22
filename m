Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12981496969
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 03:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiAVCZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 21:25:17 -0500
Received: from mga17.intel.com ([192.55.52.151]:29814 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229505AbiAVCZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 21:25:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642818316; x=1674354316;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ifd/q530DUzw9JrlA4BF+8VoxcOijWnt+dyb2nWjLvE=;
  b=CvAxyBFVgJTYxMsuSJcIPjcDK1PJApyUHfDLgdWNsdHjJjP0TGfq0eD8
   jkGo6POOKD6AXvI/sFKNHnw4FWoPOyCbwv6JtJ2sAyJytKb1/KaNNwr8A
   vfRtW+kJcGiIS0j3Aw80lI7W4ZK5l7qGY1tttDeOyNGYOKSUP1/N+DqXh
   cD/8yfIcRa1vCCOXEOV42apUJtwLYcMv5WUFX5rAv2iSMdw6j7yo1teTL
   qm49N2nie5+XyVZxobCyRFoZK9am8E5i5kj3P2E5y6l6smqUujj3TfTaG
   p1SmI+wyl/NnV2qfO6U2pR/iRL+D7d/vtrP9r4a/cC1RRXFY7nwpWzFaI
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10234"; a="226457332"
X-IronPort-AV: E=Sophos;i="5.88,307,1635231600"; 
   d="scan'208";a="226457332"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 18:25:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,307,1635231600"; 
   d="scan'208";a="562080991"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 21 Jan 2022 18:25:13 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nB65Y-000Fui-RB; Sat, 22 Jan 2022 02:25:12 +0000
Date:   Sat, 22 Jan 2022 10:24:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     kbuild-all@lists.01.org, GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Will McVicker <willmcvicker@google.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [ammarfaizi2-block:google/android/kernel/common/android-4.19-stable
 346/9999] drivers/nvmem/core.c:347:5: warning: no previous prototype for
 'nvmem_add_cells'
Message-ID: <202201221032.qQ2lBxEQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android-4.19-stable
head:   90a691fca4c2525068d9908ac203e9f09e4e33c0
commit: e96a10625581a499e8a4218ef504f3f53918408b [346/9999] UPSTREAM: nvmem: add support for cell info
config: x86_64-randconfig-a011 (https://download.01.org/0day-ci/archive/20220122/202201221032.qQ2lBxEQ-lkp@intel.com/config)
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

eace75cfdcf7d99 Srinivas Kandagatla 2015-07-27  337  
b3db17e4b864e46 Andrew Lunn         2018-05-11  338  /**
b3db17e4b864e46 Andrew Lunn         2018-05-11  339   * nvmem_add_cells() - Add cell information to an nvmem device
b3db17e4b864e46 Andrew Lunn         2018-05-11  340   *
b3db17e4b864e46 Andrew Lunn         2018-05-11  341   * @nvmem: nvmem device to add cells to.
b3db17e4b864e46 Andrew Lunn         2018-05-11  342   * @info: nvmem cell info to add to the device
b3db17e4b864e46 Andrew Lunn         2018-05-11  343   * @ncells: number of cells in info
b3db17e4b864e46 Andrew Lunn         2018-05-11  344   *
b3db17e4b864e46 Andrew Lunn         2018-05-11  345   * Return: 0 or negative error code on failure.
b3db17e4b864e46 Andrew Lunn         2018-05-11  346   */
b3db17e4b864e46 Andrew Lunn         2018-05-11 @347  int nvmem_add_cells(struct nvmem_device *nvmem,
b3db17e4b864e46 Andrew Lunn         2018-05-11  348  		    const struct nvmem_cell_info *info,
b3db17e4b864e46 Andrew Lunn         2018-05-11  349  		    int ncells)
eace75cfdcf7d99 Srinivas Kandagatla 2015-07-27  350  {
eace75cfdcf7d99 Srinivas Kandagatla 2015-07-27  351  	struct nvmem_cell **cells;
eace75cfdcf7d99 Srinivas Kandagatla 2015-07-27  352  	int i, rval;
eace75cfdcf7d99 Srinivas Kandagatla 2015-07-27  353  
b3db17e4b864e46 Andrew Lunn         2018-05-11  354  	cells = kcalloc(ncells, sizeof(*cells), GFP_KERNEL);
eace75cfdcf7d99 Srinivas Kandagatla 2015-07-27  355  	if (!cells)
eace75cfdcf7d99 Srinivas Kandagatla 2015-07-27  356  		return -ENOMEM;
eace75cfdcf7d99 Srinivas Kandagatla 2015-07-27  357  
b3db17e4b864e46 Andrew Lunn         2018-05-11  358  	for (i = 0; i < ncells; i++) {
eace75cfdcf7d99 Srinivas Kandagatla 2015-07-27  359  		cells[i] = kzalloc(sizeof(**cells), GFP_KERNEL);
eace75cfdcf7d99 Srinivas Kandagatla 2015-07-27  360  		if (!cells[i]) {
eace75cfdcf7d99 Srinivas Kandagatla 2015-07-27  361  			rval = -ENOMEM;
eace75cfdcf7d99 Srinivas Kandagatla 2015-07-27  362  			goto err;
eace75cfdcf7d99 Srinivas Kandagatla 2015-07-27  363  		}
eace75cfdcf7d99 Srinivas Kandagatla 2015-07-27  364  
eace75cfdcf7d99 Srinivas Kandagatla 2015-07-27  365  		rval = nvmem_cell_info_to_nvmem_cell(nvmem, &info[i], cells[i]);
287980e49ffc0f6 Arnd Bergmann       2016-05-27  366  		if (rval) {
eace75cfdcf7d99 Srinivas Kandagatla 2015-07-27  367  			kfree(cells[i]);
eace75cfdcf7d99 Srinivas Kandagatla 2015-07-27  368  			goto err;
eace75cfdcf7d99 Srinivas Kandagatla 2015-07-27  369  		}
eace75cfdcf7d99 Srinivas Kandagatla 2015-07-27  370  
eace75cfdcf7d99 Srinivas Kandagatla 2015-07-27  371  		nvmem_cell_add(cells[i]);
eace75cfdcf7d99 Srinivas Kandagatla 2015-07-27  372  	}
eace75cfdcf7d99 Srinivas Kandagatla 2015-07-27  373  
eace75cfdcf7d99 Srinivas Kandagatla 2015-07-27  374  	/* remove tmp array */
eace75cfdcf7d99 Srinivas Kandagatla 2015-07-27  375  	kfree(cells);
eace75cfdcf7d99 Srinivas Kandagatla 2015-07-27  376  
eace75cfdcf7d99 Srinivas Kandagatla 2015-07-27  377  	return 0;
eace75cfdcf7d99 Srinivas Kandagatla 2015-07-27  378  err:
dfdf141429f0895 Rasmus Villemoes    2016-02-08  379  	while (i--)
eace75cfdcf7d99 Srinivas Kandagatla 2015-07-27  380  		nvmem_cell_drop(cells[i]);
eace75cfdcf7d99 Srinivas Kandagatla 2015-07-27  381  
dfdf141429f0895 Rasmus Villemoes    2016-02-08  382  	kfree(cells);
dfdf141429f0895 Rasmus Villemoes    2016-02-08  383  
eace75cfdcf7d99 Srinivas Kandagatla 2015-07-27  384  	return rval;
eace75cfdcf7d99 Srinivas Kandagatla 2015-07-27  385  }
b3db17e4b864e46 Andrew Lunn         2018-05-11  386  EXPORT_SYMBOL_GPL(nvmem_add_cells);
eace75cfdcf7d99 Srinivas Kandagatla 2015-07-27  387  

:::::: The code at line 347 was first introduced by commit
:::::: b3db17e4b864e46ad150ebef69c0e0130a1c5fca drivers: nvmem: Export nvmem_add_cells()

:::::: TO: Andrew Lunn <andrew@lunn.ch>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
