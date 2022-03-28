Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A944E931B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 13:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240552AbiC1LRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 07:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240539AbiC1LRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 07:17:40 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E1755492
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 04:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648466158; x=1680002158;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3S/We15dSI1J4JxVTCMhSops0VFGNLbqcTwVqBe+seg=;
  b=JPzlni01RhjXtfiyGUaO9ijstcqQzXAxbZA+lWxXtkweqc344PtjlFSR
   3NqVPqlWr87GPBpqY3Y/9BKmObMsPVgiUIcryBPn+r2AXdBQHtuLx7KLY
   W4NFhyC5K+WUKD34nCjdm0Aa07NgzyC/OshEAi5dC77CBwJoXawLnMtQO
   JuB/+/Kxht4rYKNdsaia0gq6B91kTVm4e2FinQaIh8CoCqnk6lthSze0x
   olE36yH6BlGs67ZFis9D1C139pvbVchZBpZ/wnXBYePtCPk+Oms03HG0k
   XlikLb7Qmv4MAF/4ON8YjQ1vS6QpTBReI3waJ1rXOCzNezmtBVjNxfW2O
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10299"; a="256548590"
X-IronPort-AV: E=Sophos;i="5.90,217,1643702400"; 
   d="scan'208";a="256548590"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 04:15:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,217,1643702400"; 
   d="scan'208";a="585157047"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 28 Mar 2022 04:15:55 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nYnLm-0001zX-Ny; Mon, 28 Mar 2022 11:15:54 +0000
Date:   Mon, 28 Mar 2022 19:14:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: drivers/dma/ppc4xx/adma.c:4100:31: sparse: sparse: incorrect type in
 assignment (different address spaces)
Message-ID: <202203281957.p6BfxYul-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ae085d7f9365de7da27ab5c0d16b12d51ea7fca9
commit: d991bb1c8da842a2a0b9dc83b1005e655783f861 include/linux/compiler-gcc.h: sparse can do constant folding of __builtin_bswap*()
date:   11 months ago
config: powerpc-randconfig-s032-20220327 (https://download.01.org/0day-ci/archive/20220328/202203281957.p6BfxYul-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d991bb1c8da842a2a0b9dc83b1005e655783f861
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d991bb1c8da842a2a0b9dc83b1005e655783f861
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/dma/ppc4xx/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/dma/ppc4xx/adma.c:1155:49: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1155:49: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1157:38: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1157:38: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1157:38: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:909:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct dma_regs *dma_reg @@     got struct dma_regs [noderef] __iomem *dma_reg @@
   drivers/dma/ppc4xx/adma.c:909:25: sparse:     expected struct dma_regs *dma_reg
   drivers/dma/ppc4xx/adma.c:909:25: sparse:     got struct dma_regs [noderef] __iomem *dma_reg
   drivers/dma/ppc4xx/adma.c:910:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:910:40: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:910:40: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:927:37: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:972:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:972:32: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:972:32: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:977:40: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:977:40: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:977:40: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:982:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
   drivers/dma/ppc4xx/adma.c:982:25: sparse:     expected struct xor_regs *xor_reg
   drivers/dma/ppc4xx/adma.c:982:25: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
   drivers/dma/ppc4xx/adma.c:983:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:983:34: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:983:34: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:984:34: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:984:34: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:984:34: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:991:55: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:991:55: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:991:55: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:993:51: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:993:51: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:993:51: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:995:51: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:995:51: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:995:51: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:997:46: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:997:46: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:997:46: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1006:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1006:35: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1006:35: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1025:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct dma_regs *dma_reg @@     got struct dma_regs [noderef] __iomem *dma_reg @@
   drivers/dma/ppc4xx/adma.c:1025:25: sparse:     expected struct dma_regs *dma_reg
   drivers/dma/ppc4xx/adma.c:1025:25: sparse:     got struct dma_regs [noderef] __iomem *dma_reg
   drivers/dma/ppc4xx/adma.c:1029:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned short * @@
   drivers/dma/ppc4xx/adma.c:1029:31: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1029:31: sparse:     got unsigned short *
   drivers/dma/ppc4xx/adma.c:1029:60: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned short * @@
   drivers/dma/ppc4xx/adma.c:1029:60: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1029:60: sparse:     got unsigned short *
   drivers/dma/ppc4xx/adma.c:1030:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned short * @@
   drivers/dma/ppc4xx/adma.c:1030:31: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1030:31: sparse:     got unsigned short *
   drivers/dma/ppc4xx/adma.c:1030:60: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned short * @@
   drivers/dma/ppc4xx/adma.c:1030:60: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1030:60: sparse:     got unsigned short *
   drivers/dma/ppc4xx/adma.c:1036:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
   drivers/dma/ppc4xx/adma.c:1036:25: sparse:     expected struct xor_regs *xor_reg
   drivers/dma/ppc4xx/adma.c:1036:25: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
   drivers/dma/ppc4xx/adma.c:1037:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1037:37: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1037:37: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1051:48: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
   drivers/dma/ppc4xx/adma.c:1051:48: sparse:     expected struct xor_regs *xor_reg
   drivers/dma/ppc4xx/adma.c:1051:48: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
   drivers/dma/ppc4xx/adma.c:1053:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1053:25: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1053:25: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1060:41: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1060:41: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1060:41: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1062:39: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1062:39: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1062:39: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1063:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1063:25: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1063:25: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1064:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1064:33: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1064:33: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1065:22: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1065:22: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1065:22: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1078:48: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct dma_regs *dma_reg @@     got struct dma_regs [noderef] __iomem *dma_reg @@
   drivers/dma/ppc4xx/adma.c:1078:48: sparse:     expected struct dma_regs *dma_reg
   drivers/dma/ppc4xx/adma.c:1078:48: sparse:     got struct dma_regs [noderef] __iomem *dma_reg
   drivers/dma/ppc4xx/adma.c:1088:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1088:26: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1088:26: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1208:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
   drivers/dma/ppc4xx/adma.c:1208:25: sparse:     expected struct xor_regs *xor_reg
   drivers/dma/ppc4xx/adma.c:1208:25: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
   drivers/dma/ppc4xx/adma.c:1212:30: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1212:30: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1212:30: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:2775:62: sparse: sparse: Using plain integer as NULL pointer
   drivers/dma/ppc4xx/adma.c:4092:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *regs @@     got void [noderef] __iomem * @@
   drivers/dma/ppc4xx/adma.c:4092:14: sparse:     expected void *regs
   drivers/dma/ppc4xx/adma.c:4092:14: sparse:     got void [noderef] __iomem *
>> drivers/dma/ppc4xx/adma.c:4100:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xor_regs [noderef] __iomem *xor_reg @@     got void *regs @@
   drivers/dma/ppc4xx/adma.c:4100:31: sparse:     expected struct xor_regs [noderef] __iomem *xor_reg
   drivers/dma/ppc4xx/adma.c:4100:31: sparse:     got void *regs
>> drivers/dma/ppc4xx/adma.c:4107:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct dma_regs [noderef] __iomem *dma_reg @@     got void *regs @@
   drivers/dma/ppc4xx/adma.c:4107:31: sparse:     expected struct dma_regs [noderef] __iomem *dma_reg
   drivers/dma/ppc4xx/adma.c:4107:31: sparse:     got void *regs

vim +4100 drivers/dma/ppc4xx/adma.c

12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4001  
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4002  /**
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4003   * ppc440spe_adma_probe - probe the asynch device
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4004   */
463a1f8b3ceebe9 Bill Pemberton           2012-11-19  4005  static int ppc440spe_adma_probe(struct platform_device *ofdev)
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4006  {
05c02542c20aa00 Anatolij Gustschin       2010-06-03  4007  	struct device_node *np = ofdev->dev.of_node;
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4008  	struct resource res;
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4009  	struct ppc440spe_adma_device *adev;
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4010  	struct ppc440spe_adma_chan *chan;
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4011  	struct ppc_dma_chan_ref *ref, *_ref;
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4012  	int ret = 0, initcode = PPC_ADMA_INIT_OK;
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4013  	const u32 *idx;
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4014  	int len;
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4015  	void *regs;
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4016  	u32 id, pool_size;
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4017  
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4018  	if (of_device_is_compatible(np, "amcc,xor-accelerator")) {
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4019  		id = PPC440SPE_XOR_ID;
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4020  		/* As far as the XOR engine is concerned, it does not
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4021  		 * use FIFOs but uses linked list. So there is no dependency
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4022  		 * between pool size to allocate and the engine configuration.
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4023  		 */
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4024  		pool_size = PAGE_SIZE << 1;
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4025  	} else {
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4026  		/* it is DMA0 or DMA1 */
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4027  		idx = of_get_property(np, "cell-index", &len);
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4028  		if (!idx || (len != sizeof(u32))) {
c6c93048baff25f Rob Herring              2017-07-18  4029  			dev_err(&ofdev->dev, "Device node %pOF has missing "
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4030  				"or invalid cell-index property\n",
c6c93048baff25f Rob Herring              2017-07-18  4031  				np);
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4032  			return -EINVAL;
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4033  		}
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4034  		id = *idx;
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4035  		/* DMA0,1 engines use FIFO to maintain CDBs, so we
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4036  		 * should allocate the pool accordingly to size of this
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4037  		 * FIFO. Thus, the pool size depends on the FIFO depth:
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4038  		 * how much CDBs pointers the FIFO may contain then so
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4039  		 * much CDBs we should provide in the pool.
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4040  		 * That is
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4041  		 *   CDB size = 32B;
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4042  		 *   CDBs number = (DMA0_FIFO_SIZE >> 3);
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4043  		 *   Pool size = CDBs number * CDB size =
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4044  		 *      = (DMA0_FIFO_SIZE >> 3) << 5 = DMA0_FIFO_SIZE << 2.
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4045  		 */
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4046  		pool_size = (id == PPC440SPE_DMA0_ID) ?
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4047  			    DMA0_FIFO_SIZE : DMA1_FIFO_SIZE;
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4048  		pool_size <<= 2;
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4049  	}
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4050  
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4051  	if (of_address_to_resource(np, 0, &res)) {
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4052  		dev_err(&ofdev->dev, "failed to get memory resource\n");
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4053  		initcode = PPC_ADMA_INIT_MEMRES;
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4054  		ret = -ENODEV;
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4055  		goto out;
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4056  	}
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4057  
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4058  	if (!request_mem_region(res.start, resource_size(&res),
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4059  				dev_driver_string(&ofdev->dev))) {
a584bff5efae8c1 Joe Perches              2010-11-12  4060  		dev_err(&ofdev->dev, "failed to request memory region %pR\n",
a584bff5efae8c1 Joe Perches              2010-11-12  4061  			&res);
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4062  		initcode = PPC_ADMA_INIT_MEMREG;
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4063  		ret = -EBUSY;
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4064  		goto out;
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4065  	}
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4066  
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4067  	/* create a device */
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4068  	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4069  	if (!adev) {
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4070  		initcode = PPC_ADMA_INIT_ALLOC;
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4071  		ret = -ENOMEM;
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4072  		goto err_adev_alloc;
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4073  	}
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4074  
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4075  	adev->id = id;
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4076  	adev->pool_size = pool_size;
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4077  	/* allocate coherent memory for hardware descriptors */
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4078  	adev->dma_desc_pool_virt = dma_alloc_coherent(&ofdev->dev,
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4079  					adev->pool_size, &adev->dma_desc_pool,
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4080  					GFP_KERNEL);
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4081  	if (adev->dma_desc_pool_virt == NULL) {
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4082  		dev_err(&ofdev->dev, "failed to allocate %d bytes of coherent "
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4083  			"memory for hardware descriptors\n",
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4084  			adev->pool_size);
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4085  		initcode = PPC_ADMA_INIT_COHERENT;
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4086  		ret = -ENOMEM;
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4087  		goto err_dma_alloc;
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4088  	}
d73111c6d43f08d Masanari Iida            2012-08-04  4089  	dev_dbg(&ofdev->dev, "allocated descriptor pool virt 0x%p phys 0x%llx\n",
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4090  		adev->dma_desc_pool_virt, (u64)adev->dma_desc_pool);
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4091  
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4092  	regs = ioremap(res.start, resource_size(&res));
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4093  	if (!regs) {
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4094  		dev_err(&ofdev->dev, "failed to ioremap regs!\n");
f3b77727e82722f Julia Lawall             2013-12-29  4095  		ret = -ENOMEM;
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4096  		goto err_regs_alloc;
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4097  	}
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4098  
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4099  	if (adev->id == PPC440SPE_XOR_ID) {
12458ea06efd7b4 Anatolij Gustschin       2009-12-11 @4100  		adev->xor_reg = regs;
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4101  		/* Reset XOR */
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4102  		iowrite32be(XOR_CRSR_XASR_BIT, &adev->xor_reg->crsr);
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4103  		iowrite32be(XOR_CRSR_64BA_BIT, &adev->xor_reg->crrr);
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4104  	} else {
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4105  		size_t fifo_size = (adev->id == PPC440SPE_DMA0_ID) ?
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4106  				   DMA0_FIFO_SIZE : DMA1_FIFO_SIZE;
12458ea06efd7b4 Anatolij Gustschin       2009-12-11 @4107  		adev->dma_reg = regs;
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4108  		/* DMAx_FIFO_SIZE is defined in bytes,
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4109  		 * <fsiz> - is defined in number of CDB pointers (8byte).
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4110  		 * DMA FIFO Length = CSlength + CPlength, where
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4111  		 * CSlength = CPlength = (fsiz + 1) * 8.
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4112  		 */
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4113  		iowrite32(DMA_FIFO_ENABLE | ((fifo_size >> 3) - 2),
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4114  			  &adev->dma_reg->fsiz);
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4115  		/* Configure DMA engine */
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4116  		iowrite32(DMA_CFG_DXEPR_HP | DMA_CFG_DFMPP_HP | DMA_CFG_FALGN,
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4117  			  &adev->dma_reg->cfg);
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4118  		/* Clear Status */
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4119  		iowrite32(~0, &adev->dma_reg->dsts);
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4120  	}
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4121  
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4122  	adev->dev = &ofdev->dev;
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4123  	adev->common.dev = &ofdev->dev;
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4124  	INIT_LIST_HEAD(&adev->common.channels);
dd3daca162f7411 Jingoo Han               2013-05-24  4125  	platform_set_drvdata(ofdev, adev);
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4126  
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4127  	/* create a channel */
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4128  	chan = kzalloc(sizeof(*chan), GFP_KERNEL);
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4129  	if (!chan) {
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4130  		initcode = PPC_ADMA_INIT_CHANNEL;
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4131  		ret = -ENOMEM;
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4132  		goto err_chan_alloc;
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4133  	}
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4134  
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4135  	spin_lock_init(&chan->lock);
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4136  	INIT_LIST_HEAD(&chan->chain);
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4137  	INIT_LIST_HEAD(&chan->all_slots);
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4138  	chan->device = adev;
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4139  	chan->common.device = &adev->common;
8ac695463f37af9 Russell King - ARM Linux 2012-03-06  4140  	dma_cookie_init(&chan->common);
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4141  	list_add_tail(&chan->common.device_node, &adev->common.channels);
7f8281765f9949a Allen Pais               2020-08-31  4142  	tasklet_setup(&chan->irq_tasklet, ppc440spe_adma_tasklet);
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4143  
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4144  	/* allocate and map helper pages for async validation or
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4145  	 * async_mult/async_sum_product operations on DMA0/1.
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4146  	 */
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4147  	if (adev->id != PPC440SPE_XOR_ID) {
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4148  		chan->pdest_page = alloc_page(GFP_KERNEL);
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4149  		chan->qdest_page = alloc_page(GFP_KERNEL);
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4150  		if (!chan->pdest_page ||
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4151  		    !chan->qdest_page) {
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4152  			if (chan->pdest_page)
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4153  				__free_page(chan->pdest_page);
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4154  			if (chan->qdest_page)
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4155  				__free_page(chan->qdest_page);
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4156  			ret = -ENOMEM;
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4157  			goto err_page_alloc;
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4158  		}
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4159  		chan->pdest = dma_map_page(&ofdev->dev, chan->pdest_page, 0,
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4160  					   PAGE_SIZE, DMA_BIDIRECTIONAL);
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4161  		chan->qdest = dma_map_page(&ofdev->dev, chan->qdest_page, 0,
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4162  					   PAGE_SIZE, DMA_BIDIRECTIONAL);
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4163  	}
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4164  
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4165  	ref = kmalloc(sizeof(*ref), GFP_KERNEL);
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4166  	if (ref) {
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4167  		ref->chan = &chan->common;
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4168  		INIT_LIST_HEAD(&ref->node);
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4169  		list_add_tail(&ref->node, &ppc440spe_adma_chan_list);
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4170  	} else {
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4171  		dev_err(&ofdev->dev, "failed to allocate channel reference!\n");
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4172  		ret = -ENOMEM;
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4173  		goto err_ref_alloc;
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4174  	}
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4175  
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4176  	ret = ppc440spe_adma_setup_irqs(adev, chan, &initcode);
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4177  	if (ret)
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4178  		goto err_irq;
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4179  
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4180  	ppc440spe_adma_init_capabilities(adev);
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4181  
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4182  	ret = dma_async_device_register(&adev->common);
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4183  	if (ret) {
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4184  		initcode = PPC_ADMA_INIT_REGISTER;
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4185  		dev_err(&ofdev->dev, "failed to register dma device\n");
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4186  		goto err_dev_reg;
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4187  	}
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4188  
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4189  	goto out;
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4190  
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4191  err_dev_reg:
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4192  	ppc440spe_adma_release_irqs(adev, chan);
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4193  err_irq:
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4194  	list_for_each_entry_safe(ref, _ref, &ppc440spe_adma_chan_list, node) {
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4195  		if (chan == to_ppc440spe_adma_chan(ref->chan)) {
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4196  			list_del(&ref->node);
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4197  			kfree(ref);
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4198  		}
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4199  	}
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4200  err_ref_alloc:
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4201  	if (adev->id != PPC440SPE_XOR_ID) {
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4202  		dma_unmap_page(&ofdev->dev, chan->pdest,
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4203  			       PAGE_SIZE, DMA_BIDIRECTIONAL);
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4204  		dma_unmap_page(&ofdev->dev, chan->qdest,
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4205  			       PAGE_SIZE, DMA_BIDIRECTIONAL);
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4206  		__free_page(chan->pdest_page);
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4207  		__free_page(chan->qdest_page);
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4208  	}
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4209  err_page_alloc:
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4210  	kfree(chan);
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4211  err_chan_alloc:
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4212  	if (adev->id == PPC440SPE_XOR_ID)
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4213  		iounmap(adev->xor_reg);
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4214  	else
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4215  		iounmap(adev->dma_reg);
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4216  err_regs_alloc:
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4217  	dma_free_coherent(adev->dev, adev->pool_size,
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4218  			  adev->dma_desc_pool_virt,
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4219  			  adev->dma_desc_pool);
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4220  err_dma_alloc:
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4221  	kfree(adev);
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4222  err_adev_alloc:
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4223  	release_mem_region(res.start, resource_size(&res));
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4224  out:
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4225  	if (id < PPC440SPE_ADMA_ENGINES_NUM)
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4226  		ppc440spe_adma_devices[id] = initcode;
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4227  
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4228  	return ret;
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4229  }
12458ea06efd7b4 Anatolij Gustschin       2009-12-11  4230  

:::::: The code at line 4100 was first introduced by commit
:::::: 12458ea06efd7b44281e68fe59c950ec7d59c649 ppc440spe-adma: adds updated ppc440spe adma driver

:::::: TO: Anatolij Gustschin <agust@denx.de>
:::::: CC: Dan Williams <dan.j.williams@intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
