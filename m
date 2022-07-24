Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B94B57F235
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 02:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236472AbiGXAoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 20:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiGXAoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 20:44:21 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD71317064;
        Sat, 23 Jul 2022 17:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658623460; x=1690159460;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=p8OqWEFGhu6pLUfSsWTBU7kSxbLrZ2r0vLX0FImwX1o=;
  b=WIEN0zIoav+0nfx5IK14xbkAw7mvdabPFY+3vDNj9IOgQv63fTZLrm6m
   D1wb3Zfg5deaAK+maTO+QwxrKVSkZc0EKlPzHqT27wUlXPq2TdaLhB5hm
   /cvzfS6dlQVK7wJMeee3f48PD7ZTnSBgvP0/zRmCqbcPsy4oL97vQ4hVU
   jqj6Naa2P3yGGyxSSIr8AAXPfXBJVItwBCHuO3cqSmMZ6f+d7eaO6Vkzr
   j0mTCinsVvfePow4AEynHIIjkFjNTCGKHBEl4uzMPbxXhFb9Kq7LPLk0a
   X4+BINzi387h95pF7hCX6mlkgp6H7WS+wmDKtrsAnEr8P4P51BcVxkLJN
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="267895880"
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="267895880"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2022 17:44:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="845131504"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 23 Jul 2022 17:44:15 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFPjC-0003Iz-1A;
        Sun, 24 Jul 2022 00:44:14 +0000
Date:   Sun, 24 Jul 2022 08:43:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?utf-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>, tudor.ambarus@microchip.com,
        p.yadav@ti.com, michael@walle.cc, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     kbuild-all@lists.01.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        aidanmacdonald.0x0@gmail.com, tmn505@gmail.com,
        paul@crapouillou.net, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        jinghui.liu@ingenic.com, sernia.zhou@foxmail.com,
        reimu@sudomaker.com
Subject: Re: [PATCH 3/3] SPI: Ingenic: Add SFC support for Ingenic SoCs.
Message-ID: <202207240839.YeZ8uQ0T-lkp@intel.com>
References: <1658508510-15400-4-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1658508510-15400-4-git-send-email-zhouyanjie@wanyeetech.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "周琰杰,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on broonie-spi/for-next]
[also build test WARNING on mtd/spi-nor/next linus/master v5.19-rc7 next-20220722]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhou-Yanjie/Add-SFC-support-for-Ingenic-SoCs/20220723-005011
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220724/202207240839.YeZ8uQ0T-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/0d9d0e60238025a04d428e64e18211c037229284
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Zhou-Yanjie/Add-SFC-support-for-Ingenic-SoCs/20220723-005011
        git checkout 0d9d0e60238025a04d428e64e18211c037229284
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash drivers/spi/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/spi/spi-ingenic-sfc.c: In function 'ingenic_sfc_exec_op_pio':
>> drivers/spi/spi-ingenic-sfc.c:299:16: warning: conversion from 'long unsigned int' to 'u32' {aka 'unsigned int'} changes value from '18446744073709551595' to '4294967275' [-Woverflow]
     299 |         writel(~(INTC_MASK_END | INTC_MASK_RREQ), sfc->base + SFC_REG_INTC);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/spi/spi-ingenic-sfc.c: In function 'ingenic_sfc_exec_op_dma':
   drivers/spi/spi-ingenic-sfc.c:356:16: warning: conversion from 'long unsigned int' to 'u32' {aka 'unsigned int'} changes value from '18446744073709551599' to '4294967279' [-Woverflow]
     356 |         writel(~INTC_MASK_END, sfc->base + SFC_REG_INTC);
   drivers/spi/spi-ingenic-sfc.c: In function 'ingenic_sfc_poll_status':
   drivers/spi/spi-ingenic-sfc.c:469:16: warning: conversion from 'long unsigned int' to 'u32' {aka 'unsigned int'} changes value from '18446744073709551599' to '4294967279' [-Woverflow]
     469 |         writel(~INTC_MASK_END, sfc->base + SFC_REG_INTC);


vim +299 drivers/spi/spi-ingenic-sfc.c

   267	
   268	static int ingenic_sfc_exec_op_pio(struct ingenic_sfc *sfc, const struct spi_mem_op *op)
   269	{
   270		int ret, val;
   271	
   272		val = readl(sfc->base + SFC_REG_GLB);
   273		u32p_replace_bits(&val, GLB_TRAN_DIR_READ, GLB_TRAN_DIR_MASK);
   274		u32p_replace_bits(&val, GLB_OP_MODE_SLAVE, GLB_OP_MODE_MASK);
   275		writel(val, sfc->base + SFC_REG_GLB);
   276	
   277		val = TRAN_CONF_CMD_EN | op->cmd.opcode;
   278	
   279		if (op->addr.nbytes > 0) {
   280			val |= FIELD_PREP(TRAN_CONF_ADDR_WIDTH_MASK, op->addr.nbytes);
   281	
   282			writel(op->addr.val & 0xffffffff, sfc->base + SFC_REG_DEV_ADDR(0));
   283			writel(op->addr.val >> 32, sfc->base + SFC_REG_DEV_ADDR_PLUS(0));
   284		}
   285	
   286		if (op->dummy.nbytes > 0)
   287			val |= FIELD_PREP(TRAN_CONF_DMY_BITS_MASK,
   288					op->dummy.nbytes * 8 / op->dummy.buswidth);
   289	
   290		if (op->data.nbytes > 0)
   291			val |= TRAN_CONF_DATA_EN;
   292	
   293		writel(val, sfc->base + SFC_REG_TRAN_CONF(0));
   294		writel(op->data.nbytes, sfc->base + SFC_REG_TRAN_LEN);
   295	
   296		ingenic_sfc_set_transfer_mode(sfc, op);
   297	
   298		writel(0x1f, sfc->base + SFC_REG_SCR);
 > 299		writel(~(INTC_MASK_END | INTC_MASK_RREQ), sfc->base + SFC_REG_INTC);
   300	
   301		writel(0, sfc->base + SFC_REG_MEM_ADDR);
   302	
   303		writel(TRIG_FLUSH, sfc->base + SFC_REG_TRIG);
   304		writel(TRIG_START, sfc->base + SFC_REG_TRIG);
   305	
   306		ret = wait_for_completion_timeout(&sfc->completion,
   307				msecs_to_jiffies(INGENIC_SFC_TRANSFER_TIMEOUT));
   308		if (!ret) {
   309			writel(0x1f, sfc->base + SFC_REG_INTC);
   310			writel(0x1f, sfc->base + SFC_REG_SCR);
   311			dev_err(sfc->dev, "line:%d Timeout for ACK from SFC device\n", __LINE__);
   312			return -ETIMEDOUT;
   313		}
   314	
   315		ingenic_sfc_read_rxfifo(sfc, op->data.buf.in, op->data.nbytes);
   316		readl_poll_timeout(sfc->base + SFC_REG_SR, val, val & SR_END, 10, 0);
   317	
   318		writel(INTC_MASK_END | INTC_MASK_RREQ, sfc->base + SFC_REG_SCR);
   319		writel(TRIG_STOP, sfc->base + SFC_REG_TRIG);
   320	
   321		return 0;
   322	}
   323	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
