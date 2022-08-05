Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027AF58B049
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 21:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241037AbiHETVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 15:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbiHETVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 15:21:33 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02156557D
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 12:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659727292; x=1691263292;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UE5wa8PamgbMDvZ2VLj/oxmN/DGbwNUA50B0fjdU0JQ=;
  b=ZCwrwFPCIgejYQf+47LsKI9bKOd97n2QjM6TaCNUzJc/4UmiQplhCJTJ
   89heugrYDylbTGQUFuc3RXeOEjiAUuB3+1Xhp9I8VSx2zO9Lc2WwMoVzE
   cAz0Ef8NgN0u6Q1Brs/t9NUY/OCaQi8A6JqX4iNxEWzLlm8YdNK+9yliB
   vVKiZkwkNj0qcKboexF4NcJjknnimxK235u1Sd66YEH6dkAWt5pzae+0S
   THGuZ+vB4l/DZpdkOwmjNwb+kEzwXEzWpX7t07GDdpDgom3IPCDbaLyE9
   /aAaHrd5acAvG8y1LVMmlCWzhAMhMdn7dADFylxYP6UZQ5RBcdh6Z9Q63
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="270043643"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="270043643"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 12:21:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="745957713"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 05 Aug 2022 12:21:30 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oK2sz-000JfH-2o;
        Fri, 05 Aug 2022 19:21:29 +0000
Date:   Sat, 6 Aug 2022 03:20:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Arnd Bergmann <arnd@arndb.de>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: drivers/remoteproc/rcar_rproc.c:45:20: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202208060349.qkwQPlqG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9e2f40233670c70c25e0681cb66d50d1e2742829
commit: d803336abdbc1bfacdb32b2cf9f4fdbee072b8ee ARM: mm: kill unused runtime hook arch_iounmap()
date:   6 weeks ago
config: arm-randconfig-s041-20220805 (https://download.01.org/0day-ci/archive/20220806/202208060349.qkwQPlqG-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d803336abdbc1bfacdb32b2cf9f4fdbee072b8ee
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d803336abdbc1bfacdb32b2cf9f4fdbee072b8ee
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash drivers/remoteproc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   drivers/remoteproc/rcar_rproc.c:28:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *va @@     got void [noderef] __iomem * @@
   drivers/remoteproc/rcar_rproc.c:28:12: sparse:     expected void *va
   drivers/remoteproc/rcar_rproc.c:28:12: sparse:     got void [noderef] __iomem *
>> drivers/remoteproc/rcar_rproc.c:45:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *io_addr @@     got void *va @@
   drivers/remoteproc/rcar_rproc.c:45:20: sparse:     expected void volatile [noderef] __iomem *io_addr
   drivers/remoteproc/rcar_rproc.c:45:20: sparse:     got void *va

vim +45 drivers/remoteproc/rcar_rproc.c

285892a74f1370 Julien Massot 2021-12-07  40  
285892a74f1370 Julien Massot 2021-12-07  41  static int rcar_rproc_mem_release(struct rproc *rproc,
285892a74f1370 Julien Massot 2021-12-07  42  				   struct rproc_mem_entry *mem)
285892a74f1370 Julien Massot 2021-12-07  43  {
285892a74f1370 Julien Massot 2021-12-07  44  	dev_dbg(&rproc->dev, "unmap memory: %pa\n", &mem->dma);
285892a74f1370 Julien Massot 2021-12-07 @45  	iounmap(mem->va);
285892a74f1370 Julien Massot 2021-12-07  46  
285892a74f1370 Julien Massot 2021-12-07  47  	return 0;
285892a74f1370 Julien Massot 2021-12-07  48  }
285892a74f1370 Julien Massot 2021-12-07  49  

:::::: The code at line 45 was first introduced by commit
:::::: 285892a74f1370a12249f765c6a4e3b16194852e remoteproc: Add Renesas rcar driver

:::::: TO: Julien Massot <julien.massot@iot.bzh>
:::::: CC: Mathieu Poirier <mathieu.poirier@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
