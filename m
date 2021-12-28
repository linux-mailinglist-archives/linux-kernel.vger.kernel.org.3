Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C911480AB6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 16:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234956AbhL1PLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 10:11:11 -0500
Received: from mga03.intel.com ([134.134.136.65]:34951 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233240AbhL1PLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 10:11:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640704270; x=1672240270;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=kJLmrfBtllj1iXpfMziscYsmcUQmauHSa9TjTuMCSs0=;
  b=l2ORn8gE5J7rF6HIWNTvZmWM0cpMRko2US5tVZnxenKvdnoE51tGDxGZ
   Ndj5mHgQH/ulXVm1ch+kpjZ2YCAcHEOhxsLorZnXs4cIpJBDEavxPbRhX
   k0is/rTrRiwwX25MAGQRmrBtszniKFLNk/KXSN97qgqx/1CfEAoEcTfCm
   XW787kpmcJrcGuj5DXzaut2M7AtC31hDGz2/JXM13uqWlCGqQTdjWNdFm
   kq1ACblEJvCeVZW6ExTmxKM48Hzl8K6NUOwpsUI6ssKKHEOfcvQ6lsu2q
   qoxyJ5mwYUobDEnfXOQUKu8xNGVl9o0r1urhDSUKKlgQI45Vi2ukPT87I
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10210"; a="241330602"
X-IronPort-AV: E=Sophos;i="5.88,242,1635231600"; 
   d="scan'208";a="241330602"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2021 07:11:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,242,1635231600"; 
   d="scan'208";a="686607693"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 28 Dec 2021 07:11:07 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2E82-0007fi-Th; Tue, 28 Dec 2021 15:11:06 +0000
Date:   Tue, 28 Dec 2021 23:10:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: drivers/char/tpm/tpm_ibmvtpm.c:366:30: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202112282355.7mLEOz0w-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a8ad9a2434dc7967ab285437f443cae633b6fc1c
commit: 72d67229f522e3331d1eabd9f58d36ae080eb228 slab: clean up function prototypes
date:   7 weeks ago
config: powerpc64-randconfig-s032-20211228 (https://download.01.org/0day-ci/archive/20211228/202112282355.7mLEOz0w-lkp@intel.com/config)
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

132f7629474424 Ashley Lai             2012-08-22  336  
132f7629474424 Ashley Lai             2012-08-22  337  /**
132f7629474424 Ashley Lai             2012-08-22  338   * tpm_ibmvtpm_remove - ibm vtpm remove entry point
132f7629474424 Ashley Lai             2012-08-22  339   * @vdev:	vio device struct
132f7629474424 Ashley Lai             2012-08-22  340   *
93c12f293f8798 Winkler, Tomas         2016-11-23  341   * Return: Always 0.
132f7629474424 Ashley Lai             2012-08-22  342   */
386a966f5ce71a Uwe Kleine-König       2021-02-25  343  static void tpm_ibmvtpm_remove(struct vio_dev *vdev)
132f7629474424 Ashley Lai             2012-08-22  344  {
9e0d39d8a6a0a8 Christophe Ricard      2016-03-31  345  	struct tpm_chip *chip = dev_get_drvdata(&vdev->dev);
9e0d39d8a6a0a8 Christophe Ricard      2016-03-31  346  	struct ibmvtpm_dev *ibmvtpm = dev_get_drvdata(&chip->dev);
132f7629474424 Ashley Lai             2012-08-22  347  	int rc = 0;
132f7629474424 Ashley Lai             2012-08-22  348  
afb5abc262e962 Jarkko Sakkinen        2014-12-12  349  	tpm_chip_unregister(chip);
afb5abc262e962 Jarkko Sakkinen        2014-12-12  350  
132f7629474424 Ashley Lai             2012-08-22  351  	free_irq(vdev->irq, ibmvtpm);
132f7629474424 Ashley Lai             2012-08-22  352  
132f7629474424 Ashley Lai             2012-08-22  353  	do {
132f7629474424 Ashley Lai             2012-08-22  354  		if (rc)
132f7629474424 Ashley Lai             2012-08-22  355  			msleep(100);
132f7629474424 Ashley Lai             2012-08-22  356  		rc = plpar_hcall_norets(H_FREE_CRQ, vdev->unit_address);
132f7629474424 Ashley Lai             2012-08-22  357  	} while (rc == H_BUSY || H_IS_LONG_BUSY(rc));
132f7629474424 Ashley Lai             2012-08-22  358  
132f7629474424 Ashley Lai             2012-08-22  359  	dma_unmap_single(ibmvtpm->dev, ibmvtpm->crq_dma_handle,
132f7629474424 Ashley Lai             2012-08-22  360  			 CRQ_RES_BUF_SIZE, DMA_BIDIRECTIONAL);
132f7629474424 Ashley Lai             2012-08-22  361  	free_page((unsigned long)ibmvtpm->crq_queue.crq_addr);
132f7629474424 Ashley Lai             2012-08-22  362  
132f7629474424 Ashley Lai             2012-08-22  363  	if (ibmvtpm->rtce_buf) {
132f7629474424 Ashley Lai             2012-08-22  364  		dma_unmap_single(ibmvtpm->dev, ibmvtpm->rtce_dma_handle,
132f7629474424 Ashley Lai             2012-08-22  365  				 ibmvtpm->rtce_size, DMA_BIDIRECTIONAL);
132f7629474424 Ashley Lai             2012-08-22 @366  		kfree(ibmvtpm->rtce_buf);
132f7629474424 Ashley Lai             2012-08-22  367  	}
132f7629474424 Ashley Lai             2012-08-22  368  
132f7629474424 Ashley Lai             2012-08-22  369  	kfree(ibmvtpm);
31574d321c70f6 Hon Ching \(Vicky\  Lo 2017-03-15  370) 	/* For tpm_ibmvtpm_get_desired_dma */
31574d321c70f6 Hon Ching \(Vicky\  Lo 2017-03-15  371) 	dev_set_drvdata(&vdev->dev, NULL);
132f7629474424 Ashley Lai             2012-08-22  372  }
132f7629474424 Ashley Lai             2012-08-22  373  

:::::: The code at line 366 was first introduced by commit
:::::: 132f7629474424418a5cdd666796ad3cfa4dc0c5 drivers/char/tpm: Add new device driver to support IBM vTPM

:::::: TO: Ashley Lai <adlai@linux.vnet.ibm.com>
:::::: CC: Kent Yoder <key@linux.vnet.ibm.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
