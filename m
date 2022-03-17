Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34C44DD0C9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 23:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiCQWdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 18:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiCQWcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 18:32:43 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B06B1890D2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 15:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647556280; x=1679092280;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=e66LrJ7VCKe/RK9M3q2i3ehYIXdL9g4PT+CYLZsjBcM=;
  b=gmif4DSopqo7ZyrYn1jUiaFEd627f1vVhrGhEl3+dafLFWcLZglRmIhC
   lfSXOLDYJRpko7DM5Gr1kt35UGKHfD0gmCj5BcWe649bStZzHre+K78ey
   ChFeP46eNI/wMCBfbp9rLIQU46ke4BjRtndslmzlonYjhC5Rto6cNpDoi
   JEuGAbHbHumNVerXU6sFV4vgIhXwXOKHS5EgXLL442krSBmnSwv2iezig
   Y/aFRl+n9Qn4SuTXVukX3nTomdEMGCvN469jOsq8QkAN4Tc+rjKU4uxbL
   gVYpFY4Y+wykn8CkHZq81PyHnn3G2EX51IX/E+wU5R3UO/7nTgRartLGp
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="256945243"
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="256945243"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 15:31:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="599264648"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 17 Mar 2022 15:31:17 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUyeL-000EAM-6P; Thu, 17 Mar 2022 22:31:17 +0000
Date:   Fri, 18 Mar 2022 06:30:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: drivers/char/tpm/tpm_ibmvtpm.c:366:30: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202203180615.oEOOfSfq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   56e337f2cf1326323844927a04e9dbce9a244835
commit: 72d67229f522e3331d1eabd9f58d36ae080eb228 slab: clean up function prototypes
date:   4 months ago
config: powerpc64-randconfig-s032-20220317 (https://download.01.org/0day-ci/archive/20220318/202203180615.oEOOfSfq-lkp@intel.com/config)
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
   drivers/char/tpm/tpm_ibmvtpm.c:126:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *p @@     got void [noderef] __iomem *rtce_buf @@
   drivers/char/tpm/tpm_ibmvtpm.c:126:23: sparse:     expected void *p
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
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
