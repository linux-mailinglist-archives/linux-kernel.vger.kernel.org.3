Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E679577212
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 00:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbiGPWvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 18:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGPWvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 18:51:00 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A91918341
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 15:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658011859; x=1689547859;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IzorPhwJ89/U7tpVrw1rKrYgZ6dL6q1fMlWVlbJmymc=;
  b=iWHkHiZXQRwKM2H+W273UpjmcczLKxorNYM784795425neWOnUZ14kj2
   D5Wpzg8sHyXF+jbAyZeCUkgKDRX96cRPgjThcetfVHS9Rld3V84Mbnmn4
   OEuacrGJxHYBSR2ODOqJLN1B8oC5aK6KVT/wf7oNZMcaYNCrT9GWBxb+U
   4K0ggRJJHZm9pigD5n/sQJjNqNL3hHdNQRmGMyib6jnTrrR0N+xUlNyFE
   GAT1ZxzG2Vzq2LwhoyH1MaPZk4iOiN3EC36NbmB3F9wvkLVMxulzSKLvW
   iOMCMAgZ04N8mODJzv75Ls8lQRYYjlG8kswE+34dG9DOfcFb5iC6KKksK
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10410"; a="283575844"
X-IronPort-AV: E=Sophos;i="5.92,277,1650956400"; 
   d="scan'208";a="283575844"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2022 15:50:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,277,1650956400"; 
   d="scan'208";a="571962627"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 16 Jul 2022 15:50:57 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCqcj-0002GI-9o;
        Sat, 16 Jul 2022 22:50:57 +0000
Date:   Sun, 17 Jul 2022 06:50:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/mtd/nand/raw/hisi504_nand.c:465:17: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <202207170656.8VUpADeW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c5fe7a97f20c7f3070ac870144515c0fabc6b999
commit: 28e77cc1c0686621a4d416f599cee5ab369daa0a fortify: Detect struct member overflows in memset() at compile-time
date:   5 months ago
config: arm64-randconfig-s031-20220717 (https://download.01.org/0day-ci/archive/20220717/202207170656.8VUpADeW-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=28e77cc1c0686621a4d416f599cee5ab369daa0a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 28e77cc1c0686621a4d416f599cee5ab369daa0a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/mtd/nand/raw/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/mtd/nand/raw/hisi504_nand.c:362:26: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/nand/raw/hisi504_nand.c:367:26: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/mtd/nand/raw/hisi504_nand.c:465:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *mmio @@
   drivers/mtd/nand/raw/hisi504_nand.c:465:17: sparse:     expected void const *
   drivers/mtd/nand/raw/hisi504_nand.c:465:17: sparse:     got void [noderef] __iomem *mmio
>> drivers/mtd/nand/raw/hisi504_nand.c:465:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *mmio @@
   drivers/mtd/nand/raw/hisi504_nand.c:465:17: sparse:     expected void const *
   drivers/mtd/nand/raw/hisi504_nand.c:465:17: sparse:     got void [noderef] __iomem *mmio
   drivers/mtd/nand/raw/hisi504_nand.c:465:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *mmio @@
   drivers/mtd/nand/raw/hisi504_nand.c:465:17: sparse:     expected void *
   drivers/mtd/nand/raw/hisi504_nand.c:465:17: sparse:     got void [noderef] __iomem *mmio
   drivers/mtd/nand/raw/hisi504_nand.c:477:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *mmio @@
   drivers/mtd/nand/raw/hisi504_nand.c:477:17: sparse:     expected void const *
   drivers/mtd/nand/raw/hisi504_nand.c:477:17: sparse:     got void [noderef] __iomem *mmio
   drivers/mtd/nand/raw/hisi504_nand.c:477:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *mmio @@
   drivers/mtd/nand/raw/hisi504_nand.c:477:17: sparse:     expected void const *
   drivers/mtd/nand/raw/hisi504_nand.c:477:17: sparse:     got void [noderef] __iomem *mmio
   drivers/mtd/nand/raw/hisi504_nand.c:477:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *mmio @@
   drivers/mtd/nand/raw/hisi504_nand.c:477:17: sparse:     expected void *
   drivers/mtd/nand/raw/hisi504_nand.c:477:17: sparse:     got void [noderef] __iomem *mmio
   drivers/mtd/nand/raw/hisi504_nand.c:603:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *mmio @@
   drivers/mtd/nand/raw/hisi504_nand.c:603:9: sparse:     expected void const *
   drivers/mtd/nand/raw/hisi504_nand.c:603:9: sparse:     got void [noderef] __iomem *mmio
   drivers/mtd/nand/raw/hisi504_nand.c:603:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *mmio @@
   drivers/mtd/nand/raw/hisi504_nand.c:603:9: sparse:     expected void const *
   drivers/mtd/nand/raw/hisi504_nand.c:603:9: sparse:     got void [noderef] __iomem *mmio
   drivers/mtd/nand/raw/hisi504_nand.c:603:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *mmio @@
   drivers/mtd/nand/raw/hisi504_nand.c:603:9: sparse:     expected void *
   drivers/mtd/nand/raw/hisi504_nand.c:603:9: sparse:     got void [noderef] __iomem *mmio

vim +465 drivers/mtd/nand/raw/hisi504_nand.c

54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  422  
5295cf2e047cf6 drivers/mtd/nand/raw/hisi504_nand.c Boris Brezillon 2018-09-06  423  static void hisi_nfc_cmdfunc(struct nand_chip *chip, unsigned command,
5295cf2e047cf6 drivers/mtd/nand/raw/hisi504_nand.c Boris Brezillon 2018-09-06  424  			     int column, int page_addr)
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  425  {
5295cf2e047cf6 drivers/mtd/nand/raw/hisi504_nand.c Boris Brezillon 2018-09-06  426  	struct mtd_info *mtd = nand_to_mtd(chip);
d699ed250c0738 drivers/mtd/nand/hisi504_nand.c     Boris Brezillon 2015-12-10  427  	struct hinfc_host *host = nand_get_controller_data(chip);
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  428  	int is_cache_invalid = 1;
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  429  	unsigned int flag = 0;
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  430  
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  431  	host->command =  command;
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  432  
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  433  	switch (command) {
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  434  	case NAND_CMD_READ0:
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  435  	case NAND_CMD_READOOB:
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  436  		if (command == NAND_CMD_READ0)
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  437  			host->offset = column;
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  438  		else
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  439  			host->offset = column + mtd->writesize;
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  440  
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  441  		is_cache_invalid = 0;
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  442  		set_addr(mtd, column, page_addr);
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  443  		hisi_nfc_send_cmd_readstart(host);
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  444  		break;
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  445  
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  446  	case NAND_CMD_SEQIN:
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  447  		host->offset = column;
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  448  		set_addr(mtd, column, page_addr);
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  449  		break;
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  450  
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  451  	case NAND_CMD_ERASE1:
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  452  		set_addr(mtd, column, page_addr);
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  453  		break;
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  454  
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  455  	case NAND_CMD_PAGEPROG:
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  456  		hisi_nfc_send_cmd_pageprog(host);
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  457  		break;
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  458  
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  459  	case NAND_CMD_ERASE2:
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  460  		hisi_nfc_send_cmd_erase(host);
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  461  		break;
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  462  
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  463  	case NAND_CMD_READID:
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  464  		host->offset = column;
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25 @465  		memset(host->mmio, 0, 0x10);
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  466  		hisi_nfc_send_cmd_readid(host);
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  467  		break;
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  468  
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  469  	case NAND_CMD_STATUS:
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  470  		flag = hinfc_read(host, HINFC504_CON);
bace41f80f65dc drivers/mtd/nand/raw/hisi504_nand.c Miquel Raynal   2020-08-27  471  		if (chip->ecc.engine_type == NAND_ECC_ENGINE_TYPE_ON_HOST)
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  472  			hinfc_write(host,
dd58d38fb30aa9 drivers/mtd/nand/hisi504_nand.c     Dan Carpenter   2015-02-11  473  				    flag & ~(HINFC504_CON_ECCTYPE_MASK <<
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  474  				    HINFC504_CON_ECCTYPE_SHIFT), HINFC504_CON);
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  475  
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  476  		host->offset = 0;
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  477  		memset(host->mmio, 0, 0x10);
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  478  		hisi_nfc_send_cmd_status(host);
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  479  		hinfc_write(host, flag, HINFC504_CON);
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  480  		break;
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  481  
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  482  	case NAND_CMD_RESET:
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  483  		hisi_nfc_send_cmd_reset(host, host->chipselect);
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  484  		break;
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  485  
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  486  	default:
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  487  		dev_err(host->dev, "Error: unsupported cmd(cmd=%x, col=%x, page=%x)\n",
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  488  			command, column, page_addr);
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  489  	}
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  490  
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  491  	if (is_cache_invalid) {
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  492  		host->cache_addr_value[0] = ~0;
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  493  		host->cache_addr_value[1] = ~0;
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  494  	}
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  495  }
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  496  

:::::: The code at line 465 was first introduced by commit
:::::: 54f531f6e332875bd8a604871532f7f1174adc0e mtd: hisilicon: add a new NAND controller driver for hisilicon hip04 Soc

:::::: TO: Zhou Wang <wangzhou1@hisilicon.com>
:::::: CC: Brian Norris <computersforpeace@gmail.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
