Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCF34C51A5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 23:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238615AbiBYWkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 17:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235013AbiBYWkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 17:40:02 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3816203BD7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 14:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645828768; x=1677364768;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=z/sVVnuly1B+AXd2uUmxBvspANUk4dpZ/CzoO3EkKtA=;
  b=ekfj1u6gsn3pqpsYEJUvzg2Qkm1nCi9YSN+eZMuodhe4Knz088P3heH8
   SxGWuSeyQqkZQmz6azSi5TekMQEFsvRxY+6w3q4Vg5Efp+S1nSonx83mz
   EzK0qFNoH0LG6vJhznHZaKF2KCSLmuY0fF1/66aMvvZMcLUpFnogAXaBm
   tOnmYP7H8OG076LchNYjJUSSyL9tv+PkdlY3cwpov6TiobIaGFLav1Wgd
   V+0Sl1EM2YjyMud7KnN//PYmlm6ZJpOLNbzI7lqTCnFrKHaO58lYkMks6
   risVZrIH0K5OcPhgxxtNaeNNRZwTJRWbaRu0LYa+cm9wWVZbXWL3O7slO
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10269"; a="315809360"
X-IronPort-AV: E=Sophos;i="5.90,137,1643702400"; 
   d="scan'208";a="315809360"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 14:39:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,137,1643702400"; 
   d="scan'208";a="506840094"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 25 Feb 2022 14:39:26 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNjFF-0004mo-TY; Fri, 25 Feb 2022 22:39:25 +0000
Date:   Sat, 26 Feb 2022 06:38:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: drivers/char/tpm/tpm_ibmvtpm.c:366:30: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202202260624.Hq5VpVpn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   53ab78cd6d5aba25575a7cfb95729336ba9497d8
commit: 72d67229f522e3331d1eabd9f58d36ae080eb228 slab: clean up function prototypes
date:   4 months ago
config: powerpc64-randconfig-s032-20220226 (https://download.01.org/0day-ci/archive/20220226/202202260624.Hq5VpVpn-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=72d67229f522e3331d1eabd9f58d36ae080eb228
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 72d67229f522e3331d1eabd9f58d36ae080eb228
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/char/tpm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/char/tpm/tpm_ibmvtpm.c:125:30: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/tpm/tpm_ibmvtpm.c:126:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *rtce_buf @@
   drivers/char/tpm/tpm_ibmvtpm.c:126:23: sparse:     expected void *
   drivers/char/tpm/tpm_ibmvtpm.c:126:23: sparse:     got void [noderef] __iomem *rtce_buf
   drivers/char/tpm/tpm_ibmvtpm.c:229:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/char/tpm/tpm_ibmvtpm.c:366:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *objp @@     got void [noderef] __iomem *rtce_buf @@
   drivers/char/tpm/tpm_ibmvtpm.c:366:30: sparse:     expected void const *objp
   drivers/char/tpm/tpm_ibmvtpm.c:366:30: sparse:     got void [noderef] __iomem *rtce_buf
   drivers/char/tpm/tpm_ibmvtpm.c:525:43: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *rtce_buf @@     got void * @@
   drivers/char/tpm/tpm_ibmvtpm.c:525:43: sparse:     expected void [noderef] __iomem *rtce_buf
   drivers/char/tpm/tpm_ibmvtpm.c:525:43: sparse:     got void *
   drivers/char/tpm/tpm_ibmvtpm.c:532:52: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *ptr @@     got void [noderef] __iomem *rtce_buf @@
   drivers/char/tpm/tpm_ibmvtpm.c:532:52: sparse:     expected void *ptr
   drivers/char/tpm/tpm_ibmvtpm.c:532:52: sparse:     got void [noderef] __iomem *rtce_buf
   drivers/char/tpm/tpm_ibmvtpm.c:538:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *objp @@     got void [noderef] __iomem *rtce_buf @@
   drivers/char/tpm/tpm_ibmvtpm.c:538:46: sparse:     expected void const *objp
   drivers/char/tpm/tpm_ibmvtpm.c:538:46: sparse:     got void [noderef] __iomem *rtce_buf

vim +366 drivers/char/tpm/tpm_ibmvtpm.c

132f76294744244 Ashley Lai             2012-08-22  336  
132f76294744244 Ashley Lai             2012-08-22  337  /**
132f76294744244 Ashley Lai             2012-08-22  338   * tpm_ibmvtpm_remove - ibm vtpm remove entry point
132f76294744244 Ashley Lai             2012-08-22  339   * @vdev:	vio device struct
132f76294744244 Ashley Lai             2012-08-22  340   *
93c12f293f87982 Winkler, Tomas         2016-11-23  341   * Return: Always 0.
132f76294744244 Ashley Lai             2012-08-22  342   */
386a966f5ce71a0 Uwe Kleine-König       2021-02-25  343  static void tpm_ibmvtpm_remove(struct vio_dev *vdev)
132f76294744244 Ashley Lai             2012-08-22  344  {
9e0d39d8a6a0a88 Christophe Ricard      2016-03-31  345  	struct tpm_chip *chip = dev_get_drvdata(&vdev->dev);
9e0d39d8a6a0a88 Christophe Ricard      2016-03-31  346  	struct ibmvtpm_dev *ibmvtpm = dev_get_drvdata(&chip->dev);
132f76294744244 Ashley Lai             2012-08-22  347  	int rc = 0;
132f76294744244 Ashley Lai             2012-08-22  348  
afb5abc262e9620 Jarkko Sakkinen        2014-12-12  349  	tpm_chip_unregister(chip);
afb5abc262e9620 Jarkko Sakkinen        2014-12-12  350  
132f76294744244 Ashley Lai             2012-08-22  351  	free_irq(vdev->irq, ibmvtpm);
132f76294744244 Ashley Lai             2012-08-22  352  
132f76294744244 Ashley Lai             2012-08-22  353  	do {
132f76294744244 Ashley Lai             2012-08-22  354  		if (rc)
132f76294744244 Ashley Lai             2012-08-22  355  			msleep(100);
132f76294744244 Ashley Lai             2012-08-22  356  		rc = plpar_hcall_norets(H_FREE_CRQ, vdev->unit_address);
132f76294744244 Ashley Lai             2012-08-22  357  	} while (rc == H_BUSY || H_IS_LONG_BUSY(rc));
132f76294744244 Ashley Lai             2012-08-22  358  
132f76294744244 Ashley Lai             2012-08-22  359  	dma_unmap_single(ibmvtpm->dev, ibmvtpm->crq_dma_handle,
132f76294744244 Ashley Lai             2012-08-22  360  			 CRQ_RES_BUF_SIZE, DMA_BIDIRECTIONAL);
132f76294744244 Ashley Lai             2012-08-22  361  	free_page((unsigned long)ibmvtpm->crq_queue.crq_addr);
132f76294744244 Ashley Lai             2012-08-22  362  
132f76294744244 Ashley Lai             2012-08-22  363  	if (ibmvtpm->rtce_buf) {
132f76294744244 Ashley Lai             2012-08-22  364  		dma_unmap_single(ibmvtpm->dev, ibmvtpm->rtce_dma_handle,
132f76294744244 Ashley Lai             2012-08-22  365  				 ibmvtpm->rtce_size, DMA_BIDIRECTIONAL);
132f76294744244 Ashley Lai             2012-08-22 @366  		kfree(ibmvtpm->rtce_buf);
132f76294744244 Ashley Lai             2012-08-22  367  	}
132f76294744244 Ashley Lai             2012-08-22  368  
132f76294744244 Ashley Lai             2012-08-22  369  	kfree(ibmvtpm);
31574d321c70f6d Hon Ching \(Vicky\  Lo 2017-03-15  370) 	/* For tpm_ibmvtpm_get_desired_dma */
31574d321c70f6d Hon Ching \(Vicky\  Lo 2017-03-15  371) 	dev_set_drvdata(&vdev->dev, NULL);
132f76294744244 Ashley Lai             2012-08-22  372  }
132f76294744244 Ashley Lai             2012-08-22  373  

:::::: The code at line 366 was first introduced by commit
:::::: 132f7629474424418a5cdd666796ad3cfa4dc0c5 drivers/char/tpm: Add new device driver to support IBM vTPM

:::::: TO: Ashley Lai <adlai@linux.vnet.ibm.com>
:::::: CC: Kent Yoder <key@linux.vnet.ibm.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
