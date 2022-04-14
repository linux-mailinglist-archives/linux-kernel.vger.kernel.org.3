Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394B2500E18
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 14:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242028AbiDNMyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 08:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbiDNMyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 08:54:05 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9111192320
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 05:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649940700; x=1681476700;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GuytOmDmf5He2/73QTY/X/awL112DhtK4ZT4nU9opVE=;
  b=Ale6oaVXV0UldZSGV7J5nOUy6918pM5LFMlyUQkksTq33DiFDXjwUJvb
   Qf+l8SZB6UpJD2hlkaTelJfH42sychYYDQUPv3gRFRorutxH6WN+zSvfB
   ghdk8nI1ut5JqKVokpj6SEnNr2L04JdOQrL1q8Vi8aTsbEfd9073Adjbm
   hkS5Wh5yVk7xQPfNyv9N+qD3SbP1BxwmWfuqTIN1gggT2lVyGIC4AvU9Y
   dv7uXsuvrwpDtEF5c3gjnUO/+oOBeoF8BAletfcKxq9OKCvUAc7Mkihy9
   H7ozgaH7FjomzEe4hqCrCnjo1cRNI778+3+3InWwEh58toqLdlqpnLZPQ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="250216917"
X-IronPort-AV: E=Sophos;i="5.90,259,1643702400"; 
   d="scan'208";a="250216917"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 05:51:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,259,1643702400"; 
   d="scan'208";a="591181006"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 14 Apr 2022 05:51:38 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1neywj-0000xn-Pm;
        Thu, 14 Apr 2022 12:51:37 +0000
Date:   Thu, 14 Apr 2022 20:51:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/mtd/nand/raw/hisi504_nand.c:465:17: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <202204142012.odIft7m9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a19944809fe9942e6a96292490717904d0690c21
commit: 28e77cc1c0686621a4d416f599cee5ab369daa0a fortify: Detect struct member overflows in memset() at compile-time
date:   9 weeks ago
config: arm-randconfig-s031-20220414 (https://download.01.org/0day-ci/archive/20220414/202204142012.odIft7m9-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=28e77cc1c0686621a4d416f599cee5ab369daa0a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 28e77cc1c0686621a4d416f599cee5ab369daa0a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash drivers/mtd/nand/raw/ drivers/video/fbdev/ fs/

If you fix the issue, kindly add following tag as appropriate
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
--
   drivers/video/fbdev/s3c2410fb.c:643:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __iomem *screen_base @@     got void * @@
   drivers/video/fbdev/s3c2410fb.c:643:27: sparse:     expected char [noderef] __iomem *screen_base
   drivers/video/fbdev/s3c2410fb.c:643:27: sparse:     got void *
>> drivers/video/fbdev/s3c2410fb.c:650:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/s3c2410fb.c:650:17: sparse:     expected void const *
   drivers/video/fbdev/s3c2410fb.c:650:17: sparse:     got char [noderef] __iomem *screen_base
>> drivers/video/fbdev/s3c2410fb.c:650:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/s3c2410fb.c:650:17: sparse:     expected void const *
   drivers/video/fbdev/s3c2410fb.c:650:17: sparse:     got char [noderef] __iomem *screen_base
>> drivers/video/fbdev/s3c2410fb.c:650:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/s3c2410fb.c:650:17: sparse:     expected void *
   drivers/video/fbdev/s3c2410fb.c:650:17: sparse:     got char [noderef] __iomem *screen_base
   drivers/video/fbdev/s3c2410fb.c:666:25: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void *cpu_addr @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/s3c2410fb.c:666:25: sparse:     expected void *cpu_addr
   drivers/video/fbdev/s3c2410fb.c:666:25: sparse:     got char [noderef] __iomem *screen_base
   drivers/video/fbdev/s3c2410fb.c:666:25: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void *cpu_addr @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/s3c2410fb.c:666:25: sparse:     expected void *cpu_addr
   drivers/video/fbdev/s3c2410fb.c:666:25: sparse:     got char [noderef] __iomem *screen_base

vim +465 drivers/mtd/nand/raw/hisi504_nand.c

54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  356  
7e534323c41621 drivers/mtd/nand/raw/hisi504_nand.c Boris Brezillon 2018-09-06  357  static uint8_t hisi_nfc_read_byte(struct nand_chip *chip)
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  358  {
d699ed250c0738 drivers/mtd/nand/hisi504_nand.c     Boris Brezillon 2015-12-10  359  	struct hinfc_host *host = nand_get_controller_data(chip);
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  360  
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  361  	if (host->command == NAND_CMD_STATUS)
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25 @362  		return *(uint8_t *)(host->mmio);
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  363  
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  364  	host->offset++;
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  365  
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  366  	if (host->command == NAND_CMD_READID)
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  367  		return *(uint8_t *)(host->mmio + host->offset - 1);
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  368  
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  369  	return *(uint8_t *)(host->buffer + host->offset - 1);
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  370  }
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  371  
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  372  static void
c0739d85723a38 drivers/mtd/nand/raw/hisi504_nand.c Boris Brezillon 2018-09-06  373  hisi_nfc_write_buf(struct nand_chip *chip, const uint8_t *buf, int len)
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  374  {
d699ed250c0738 drivers/mtd/nand/hisi504_nand.c     Boris Brezillon 2015-12-10  375  	struct hinfc_host *host = nand_get_controller_data(chip);
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  376  
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  377  	memcpy(host->buffer + host->offset, buf, len);
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  378  	host->offset += len;
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  379  }
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  380  
7e534323c41621 drivers/mtd/nand/raw/hisi504_nand.c Boris Brezillon 2018-09-06  381  static void hisi_nfc_read_buf(struct nand_chip *chip, uint8_t *buf, int len)
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  382  {
d699ed250c0738 drivers/mtd/nand/hisi504_nand.c     Boris Brezillon 2015-12-10  383  	struct hinfc_host *host = nand_get_controller_data(chip);
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  384  
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  385  	memcpy(buf, host->buffer + host->offset, len);
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  386  	host->offset += len;
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  387  }
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  388  
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  389  static void set_addr(struct mtd_info *mtd, int column, int page_addr)
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  390  {
4bd4ebcc540c35 drivers/mtd/nand/hisi504_nand.c     Boris Brezillon 2015-12-01  391  	struct nand_chip *chip = mtd_to_nand(mtd);
d699ed250c0738 drivers/mtd/nand/hisi504_nand.c     Boris Brezillon 2015-12-10  392  	struct hinfc_host *host = nand_get_controller_data(chip);
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  393  	unsigned int command = host->command;
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  394  
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  395  	host->addr_cycle    = 0;
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  396  	host->addr_value[0] = 0;
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  397  	host->addr_value[1] = 0;
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  398  
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  399  	/* Serially input address */
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  400  	if (column != -1) {
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  401  		/* Adjust columns for 16 bit buswidth */
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  402  		if (chip->options & NAND_BUSWIDTH_16 &&
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  403  				!nand_opcode_8bits(command))
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  404  			column >>= 1;
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  405  
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  406  		host->addr_value[0] = column & 0xffff;
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  407  		host->addr_cycle    = 2;
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  408  	}
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  409  	if (page_addr != -1) {
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  410  		host->addr_value[0] |= (page_addr & 0xffff)
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  411  			<< (host->addr_cycle * 8);
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  412  		host->addr_cycle    += 2;
14157f861437eb drivers/mtd/nand/hisi504_nand.c     Masahiro Yamada 2017-09-13  413  		if (chip->options & NAND_ROW_ADDR_3) {
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  414  			host->addr_cycle += 1;
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  415  			if (host->command == NAND_CMD_ERASE1)
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  416  				host->addr_value[0] |= ((page_addr >> 16) & 0xff) << 16;
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  417  			else
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  418  				host->addr_value[1] |= ((page_addr >> 16) & 0xff);
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  419  		}
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  420  	}
54f531f6e33287 drivers/mtd/nand/hisi504_nand.c     Zhou Wang       2015-01-25  421  }
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
