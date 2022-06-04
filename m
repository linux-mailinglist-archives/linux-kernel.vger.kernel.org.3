Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9809353D68E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 13:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235424AbiFDLbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 07:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbiFDLbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 07:31:35 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6055631DE3
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 04:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654342294; x=1685878294;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=h/O0teAdGLAz29qj5hE0JHD7nci/qAf1cuFUYOXiy6Q=;
  b=mn8iGa+Gqejs6cJh1oEu/kG4eH53omGpOotN7WZC63nt3cGfXozNE6tR
   8ByoxxG/7GKnRRwJP65jzaSLn4vksLtRfpOlROTK+8HzlfDAOnZ5BnI5d
   CuMckZU8jm6N553iQaxClXHWu58xxy8TUGD/9mpW96A6aB6tbveWbniPP
   z4B3TRcch9ynfoZ9pKTm4cZzmw2Ms245cmZaSl1jWE+Hrtnvc6+f3T8hx
   APPoBaMhoeZyCarSolceOGlNi6muRkfAwhscxasGZG1jVZxGZfOgsvaE4
   h6oQTybzFSgOnHiMUxDKv6+JcGcYQ54AWRcNmNeUazzI2dkKLCYjsTkGM
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10367"; a="256899499"
X-IronPort-AV: E=Sophos;i="5.91,277,1647327600"; 
   d="scan'208";a="256899499"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 04:31:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,277,1647327600"; 
   d="scan'208";a="582933094"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 04 Jun 2022 04:31:33 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxS0C-000AkZ-Hf;
        Sat, 04 Jun 2022 11:31:32 +0000
Date:   Sat, 4 Jun 2022 19:30:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Julien Massot <julien.massot@iot.bzh>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: drivers/remoteproc/rcar_rproc.c:45:20: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202206041947.AZnEnWE1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   032dcf09e2bf7c822be25b4abef7a6c913870d98
commit: 285892a74f1370a12249f765c6a4e3b16194852e remoteproc: Add Renesas rcar driver
date:   6 months ago
config: arc-allmodconfig (https://download.01.org/0day-ci/archive/20220604/202206041947.AZnEnWE1-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-18-g56afb504-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=285892a74f1370a12249f765c6a4e3b16194852e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 285892a74f1370a12249f765c6a4e3b16194852e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arc SHELL=/bin/bash drivers/remoteproc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/remoteproc/rcar_rproc.c:28:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *va @@     got void [noderef] __iomem * @@
   drivers/remoteproc/rcar_rproc.c:28:12: sparse:     expected void *va
   drivers/remoteproc/rcar_rproc.c:28:12: sparse:     got void [noderef] __iomem *
>> drivers/remoteproc/rcar_rproc.c:45:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *va @@
   drivers/remoteproc/rcar_rproc.c:45:20: sparse:     expected void const [noderef] __iomem *addr
   drivers/remoteproc/rcar_rproc.c:45:20: sparse:     got void *va

vim +45 drivers/remoteproc/rcar_rproc.c

    40	
    41	static int rcar_rproc_mem_release(struct rproc *rproc,
    42					   struct rproc_mem_entry *mem)
    43	{
    44		dev_dbg(&rproc->dev, "unmap memory: %pa\n", &mem->dma);
  > 45		iounmap(mem->va);
    46	
    47		return 0;
    48	}
    49	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
