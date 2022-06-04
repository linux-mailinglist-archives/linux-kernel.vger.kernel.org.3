Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE6D53D8D4
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 01:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242494AbiFDXa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 19:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242415AbiFDXaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 19:30:20 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C2536161
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 16:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654385419; x=1685921419;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PVIVXpwJ5pScKrSY0+7AHdALLlayGDY1sUzD0uzjLy8=;
  b=gcZMBYgX4dwil2o9gSsPpw1wZTWKunkp2hWz3HWILsTuEY2So7lzOWwh
   IyBQ24DhkJhlucuW+HBMWB1XHmwfYaeJuGPjrUdJ2eEsoUlL/Xtuovjua
   89eOPah4klOcdTNYiiKHIVOdiJ0ath1+mBdPCtqjlMGLtRjHvhh1slxvc
   x2WKUCpGXre9r2ap49g0gv+UsV21atlkrXd56zkG5+NKC9Ltx9y+7Qy1Q
   UDEy5MGZRPTaQx5b5hhkSAfFzbz8Glr2c2Ij5W0Js+dAsCHwLZ3dODtvd
   /HZ1qI6Zrjf60Nc29Gh1rXjCs/U7buF60g1dldEoRt7o+jY5xl8zSytQS
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10368"; a="275290082"
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="275290082"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 16:30:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="681697854"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 04 Jun 2022 16:30:17 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxdDk-000BH6-Gy;
        Sat, 04 Jun 2022 23:30:16 +0000
Date:   Sun, 5 Jun 2022 07:30:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: drivers/scsi/myrs.c:2439:13: sparse: sparse: incorrect type in
 assignment (different base types)
Message-ID: <202206050706.pgoCCPgv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   032dcf09e2bf7c822be25b4abef7a6c913870d98
commit: 769e683715211ad3cbed5908a86b97dd54d60970 io-wq: don't repeat IO_WQ_BIT_EXIT check by worker
date:   12 months ago
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20220605/202206050706.pgoCCPgv-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-18-g56afb504-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=769e683715211ad3cbed5908a86b97dd54d60970
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 769e683715211ad3cbed5908a86b97dd54d60970
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash drivers/ net/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/scsi/myrs.c:2272:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *base @@     got struct myrs_hba *cs @@
   drivers/scsi/myrs.c:2272:34: sparse:     expected void [noderef] __iomem *base
   drivers/scsi/myrs.c:2272:34: sparse:     got struct myrs_hba *cs
   drivers/scsi/myrs.c:2424:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/myrs.c:2477:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/myrs.c:2417:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/myrs.c:2477:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/myrs.c:2410:9: sparse: sparse: cast from restricted __le32
>> drivers/scsi/myrs.c:2439:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] val @@     got unsigned int [assigned] [usertype] __v @@
   drivers/scsi/myrs.c:2439:13: sparse:     expected restricted __le32 [usertype] val
   drivers/scsi/myrs.c:2439:13: sparse:     got unsigned int [assigned] [usertype] __v
   drivers/scsi/myrs.c:2509:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] val @@     got unsigned int [assigned] [usertype] __v @@
   drivers/scsi/myrs.c:2509:13: sparse:     expected restricted __le32 [usertype] val
   drivers/scsi/myrs.c:2509:13: sparse:     got unsigned int [assigned] [usertype] __v
   drivers/scsi/myrs.c:2512:18: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/myrs.c:2417:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/myrs.c:2470:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/myrs.c:2455:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/myrs.c:2431:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] val @@     got unsigned int [assigned] [usertype] __v @@
   drivers/scsi/myrs.c:2431:13: sparse:     expected restricted __le32 [usertype] val
   drivers/scsi/myrs.c:2431:13: sparse:     got unsigned int [assigned] [usertype] __v
   drivers/scsi/myrs.c:2403:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/myrs.c:2462:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] val @@     got unsigned int [assigned] [usertype] __v @@
   drivers/scsi/myrs.c:2462:13: sparse:     expected restricted __le32 [usertype] val
   drivers/scsi/myrs.c:2462:13: sparse:     got unsigned int [assigned] [usertype] __v
   drivers/scsi/myrs.c:2447:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/myrs.c:2410:9: sparse: sparse: cast from restricted __le32
--
>> drivers/mcb/mcb-parse.c:54:14: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] reg1 @@     got unsigned int [assigned] [usertype] __v @@
   drivers/mcb/mcb-parse.c:54:14: sparse:     expected restricted __le32 [usertype] reg1
   drivers/mcb/mcb-parse.c:54:14: sparse:     got unsigned int [assigned] [usertype] __v
>> drivers/mcb/mcb-parse.c:55:14: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] reg2 @@     got unsigned int [assigned] [usertype] __v @@
   drivers/mcb/mcb-parse.c:55:14: sparse:     expected restricted __le32 [usertype] reg2
   drivers/mcb/mcb-parse.c:55:14: sparse:     got unsigned int [assigned] [usertype] __v
   drivers/mcb/mcb-parse.c:59:20: sparse: sparse: restricted __le32 degrades to integer
   drivers/mcb/mcb-parse.c:60:21: sparse: sparse: restricted __le32 degrades to integer
   drivers/mcb/mcb-parse.c:61:21: sparse: sparse: restricted __le32 degrades to integer
   drivers/mcb/mcb-parse.c:62:21: sparse: sparse: restricted __le32 degrades to integer
   drivers/mcb/mcb-parse.c:63:23: sparse: sparse: restricted __le32 degrades to integer
   drivers/mcb/mcb-parse.c:64:22: sparse: sparse: restricted __le32 degrades to integer
   drivers/mcb/mcb-parse.c:93:27: sparse: sparse: restricted __le32 degrades to integer
   drivers/mcb/mcb-parse.c:94:25: sparse: sparse: restricted __le32 degrades to integer
>> drivers/mcb/mcb-parse.c:150:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] reg @@     got unsigned int [assigned] [usertype] __v @@
   drivers/mcb/mcb-parse.c:150:21: sparse:     expected restricted __le32 [usertype] reg
   drivers/mcb/mcb-parse.c:150:21: sparse:     got unsigned int [assigned] [usertype] __v
   drivers/mcb/mcb-parse.c:152:29: sparse: sparse: restricted __le32 degrades to integer
   drivers/mcb/mcb-parse.c:198:25: sparse: sparse: cast to restricted __le16
--
>> drivers/clocksource/timer-clint.c:237:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void * @@     got struct clock_event_device [noderef] __percpu * @@
   drivers/clocksource/timer-clint.c:237:36: sparse:     expected void *
   drivers/clocksource/timer-clint.c:237:36: sparse:     got struct clock_event_device [noderef] __percpu *
--
>> net/mptcp/mib.c:60:13: sparse: sparse: cast removes address space '__percpu' of expression

vim +2439 drivers/scsi/myrs.c

77266186397c6c7 Hannes Reinecke   2018-10-17  2263  
77266186397c6c7 Hannes Reinecke   2018-10-17  2264  static void myrs_cleanup(struct myrs_hba *cs)
77266186397c6c7 Hannes Reinecke   2018-10-17  2265  {
77266186397c6c7 Hannes Reinecke   2018-10-17  2266  	struct pci_dev *pdev = cs->pdev;
77266186397c6c7 Hannes Reinecke   2018-10-17  2267  
77266186397c6c7 Hannes Reinecke   2018-10-17  2268  	/* Free the memory mailbox, status, and related structures */
77266186397c6c7 Hannes Reinecke   2018-10-17  2269  	myrs_unmap(cs);
77266186397c6c7 Hannes Reinecke   2018-10-17  2270  
77266186397c6c7 Hannes Reinecke   2018-10-17  2271  	if (cs->mmio_base) {
77266186397c6c7 Hannes Reinecke   2018-10-17 @2272  		cs->disable_intr(cs);
77266186397c6c7 Hannes Reinecke   2018-10-17  2273  		iounmap(cs->mmio_base);
2bb817712e2f774 Lv Yunlong        2021-03-10  2274  		cs->mmio_base = NULL;
77266186397c6c7 Hannes Reinecke   2018-10-17  2275  	}
77266186397c6c7 Hannes Reinecke   2018-10-17  2276  	if (cs->irq)
77266186397c6c7 Hannes Reinecke   2018-10-17  2277  		free_irq(cs->irq, cs);
77266186397c6c7 Hannes Reinecke   2018-10-17  2278  	if (cs->io_addr)
77266186397c6c7 Hannes Reinecke   2018-10-17  2279  		release_region(cs->io_addr, 0x80);
77266186397c6c7 Hannes Reinecke   2018-10-17  2280  	pci_set_drvdata(pdev, NULL);
77266186397c6c7 Hannes Reinecke   2018-10-17  2281  	pci_disable_device(pdev);
77266186397c6c7 Hannes Reinecke   2018-10-17  2282  	scsi_host_put(cs->host);
77266186397c6c7 Hannes Reinecke   2018-10-17  2283  }
77266186397c6c7 Hannes Reinecke   2018-10-17  2284  
77266186397c6c7 Hannes Reinecke   2018-10-17  2285  static struct myrs_hba *myrs_detect(struct pci_dev *pdev,
77266186397c6c7 Hannes Reinecke   2018-10-17  2286  		const struct pci_device_id *entry)
77266186397c6c7 Hannes Reinecke   2018-10-17  2287  {
77266186397c6c7 Hannes Reinecke   2018-10-17  2288  	struct myrs_privdata *privdata =
77266186397c6c7 Hannes Reinecke   2018-10-17  2289  		(struct myrs_privdata *)entry->driver_data;
77266186397c6c7 Hannes Reinecke   2018-10-17  2290  	irq_handler_t irq_handler = privdata->irq_handler;
77266186397c6c7 Hannes Reinecke   2018-10-17  2291  	unsigned int mmio_size = privdata->mmio_size;
77266186397c6c7 Hannes Reinecke   2018-10-17  2292  	struct myrs_hba *cs = NULL;
77266186397c6c7 Hannes Reinecke   2018-10-17  2293  
77266186397c6c7 Hannes Reinecke   2018-10-17  2294  	cs = myrs_alloc_host(pdev, entry);
77266186397c6c7 Hannes Reinecke   2018-10-17  2295  	if (!cs) {
77266186397c6c7 Hannes Reinecke   2018-10-17  2296  		dev_err(&pdev->dev, "Unable to allocate Controller\n");
77266186397c6c7 Hannes Reinecke   2018-10-17  2297  		return NULL;
77266186397c6c7 Hannes Reinecke   2018-10-17  2298  	}
77266186397c6c7 Hannes Reinecke   2018-10-17  2299  	cs->pdev = pdev;
77266186397c6c7 Hannes Reinecke   2018-10-17  2300  
77266186397c6c7 Hannes Reinecke   2018-10-17  2301  	if (pci_enable_device(pdev))
77266186397c6c7 Hannes Reinecke   2018-10-17  2302  		goto Failure;
77266186397c6c7 Hannes Reinecke   2018-10-17  2303  
77266186397c6c7 Hannes Reinecke   2018-10-17  2304  	cs->pci_addr = pci_resource_start(pdev, 0);
77266186397c6c7 Hannes Reinecke   2018-10-17  2305  
77266186397c6c7 Hannes Reinecke   2018-10-17  2306  	pci_set_drvdata(pdev, cs);
77266186397c6c7 Hannes Reinecke   2018-10-17  2307  	spin_lock_init(&cs->queue_lock);
77266186397c6c7 Hannes Reinecke   2018-10-17  2308  	/* Map the Controller Register Window. */
77266186397c6c7 Hannes Reinecke   2018-10-17  2309  	if (mmio_size < PAGE_SIZE)
77266186397c6c7 Hannes Reinecke   2018-10-17  2310  		mmio_size = PAGE_SIZE;
4bdc0d676a64314 Christoph Hellwig 2020-01-06  2311  	cs->mmio_base = ioremap(cs->pci_addr & PAGE_MASK, mmio_size);
77266186397c6c7 Hannes Reinecke   2018-10-17  2312  	if (cs->mmio_base == NULL) {
77266186397c6c7 Hannes Reinecke   2018-10-17  2313  		dev_err(&pdev->dev,
77266186397c6c7 Hannes Reinecke   2018-10-17  2314  			"Unable to map Controller Register Window\n");
77266186397c6c7 Hannes Reinecke   2018-10-17  2315  		goto Failure;
77266186397c6c7 Hannes Reinecke   2018-10-17  2316  	}
77266186397c6c7 Hannes Reinecke   2018-10-17  2317  
77266186397c6c7 Hannes Reinecke   2018-10-17  2318  	cs->io_base = cs->mmio_base + (cs->pci_addr & ~PAGE_MASK);
77266186397c6c7 Hannes Reinecke   2018-10-17  2319  	if (privdata->hw_init(pdev, cs, cs->io_base))
77266186397c6c7 Hannes Reinecke   2018-10-17  2320  		goto Failure;
77266186397c6c7 Hannes Reinecke   2018-10-17  2321  
77266186397c6c7 Hannes Reinecke   2018-10-17  2322  	/* Acquire shared access to the IRQ Channel. */
77266186397c6c7 Hannes Reinecke   2018-10-17  2323  	if (request_irq(pdev->irq, irq_handler, IRQF_SHARED, "myrs", cs) < 0) {
77266186397c6c7 Hannes Reinecke   2018-10-17  2324  		dev_err(&pdev->dev,
77266186397c6c7 Hannes Reinecke   2018-10-17  2325  			"Unable to acquire IRQ Channel %d\n", pdev->irq);
77266186397c6c7 Hannes Reinecke   2018-10-17  2326  		goto Failure;
77266186397c6c7 Hannes Reinecke   2018-10-17  2327  	}
77266186397c6c7 Hannes Reinecke   2018-10-17  2328  	cs->irq = pdev->irq;
77266186397c6c7 Hannes Reinecke   2018-10-17  2329  	return cs;
77266186397c6c7 Hannes Reinecke   2018-10-17  2330  
77266186397c6c7 Hannes Reinecke   2018-10-17  2331  Failure:
77266186397c6c7 Hannes Reinecke   2018-10-17  2332  	dev_err(&pdev->dev,
77266186397c6c7 Hannes Reinecke   2018-10-17  2333  		"Failed to initialize Controller\n");
77266186397c6c7 Hannes Reinecke   2018-10-17  2334  	myrs_cleanup(cs);
77266186397c6c7 Hannes Reinecke   2018-10-17  2335  	return NULL;
77266186397c6c7 Hannes Reinecke   2018-10-17  2336  }
77266186397c6c7 Hannes Reinecke   2018-10-17  2337  
8a692fdb1d04f56 Lee Jones         2020-07-13  2338  /*
77266186397c6c7 Hannes Reinecke   2018-10-17  2339   * myrs_err_status reports Controller BIOS Messages passed through
8a692fdb1d04f56 Lee Jones         2020-07-13  2340   * the Error Status Register when the driver performs the BIOS handshaking.
8a692fdb1d04f56 Lee Jones         2020-07-13  2341   * It returns true for fatal errors and false otherwise.
77266186397c6c7 Hannes Reinecke   2018-10-17  2342   */
77266186397c6c7 Hannes Reinecke   2018-10-17  2343  
77266186397c6c7 Hannes Reinecke   2018-10-17  2344  static bool myrs_err_status(struct myrs_hba *cs, unsigned char status,
77266186397c6c7 Hannes Reinecke   2018-10-17  2345  		unsigned char parm0, unsigned char parm1)
77266186397c6c7 Hannes Reinecke   2018-10-17  2346  {
77266186397c6c7 Hannes Reinecke   2018-10-17  2347  	struct pci_dev *pdev = cs->pdev;
77266186397c6c7 Hannes Reinecke   2018-10-17  2348  
77266186397c6c7 Hannes Reinecke   2018-10-17  2349  	switch (status) {
77266186397c6c7 Hannes Reinecke   2018-10-17  2350  	case 0x00:
77266186397c6c7 Hannes Reinecke   2018-10-17  2351  		dev_info(&pdev->dev,
77266186397c6c7 Hannes Reinecke   2018-10-17  2352  			 "Physical Device %d:%d Not Responding\n",
77266186397c6c7 Hannes Reinecke   2018-10-17  2353  			 parm1, parm0);
77266186397c6c7 Hannes Reinecke   2018-10-17  2354  		break;
77266186397c6c7 Hannes Reinecke   2018-10-17  2355  	case 0x08:
77266186397c6c7 Hannes Reinecke   2018-10-17  2356  		dev_notice(&pdev->dev, "Spinning Up Drives\n");
77266186397c6c7 Hannes Reinecke   2018-10-17  2357  		break;
77266186397c6c7 Hannes Reinecke   2018-10-17  2358  	case 0x30:
77266186397c6c7 Hannes Reinecke   2018-10-17  2359  		dev_notice(&pdev->dev, "Configuration Checksum Error\n");
77266186397c6c7 Hannes Reinecke   2018-10-17  2360  		break;
77266186397c6c7 Hannes Reinecke   2018-10-17  2361  	case 0x60:
77266186397c6c7 Hannes Reinecke   2018-10-17  2362  		dev_notice(&pdev->dev, "Mirror Race Recovery Failed\n");
77266186397c6c7 Hannes Reinecke   2018-10-17  2363  		break;
77266186397c6c7 Hannes Reinecke   2018-10-17  2364  	case 0x70:
77266186397c6c7 Hannes Reinecke   2018-10-17  2365  		dev_notice(&pdev->dev, "Mirror Race Recovery In Progress\n");
77266186397c6c7 Hannes Reinecke   2018-10-17  2366  		break;
77266186397c6c7 Hannes Reinecke   2018-10-17  2367  	case 0x90:
77266186397c6c7 Hannes Reinecke   2018-10-17  2368  		dev_notice(&pdev->dev, "Physical Device %d:%d COD Mismatch\n",
77266186397c6c7 Hannes Reinecke   2018-10-17  2369  			   parm1, parm0);
77266186397c6c7 Hannes Reinecke   2018-10-17  2370  		break;
77266186397c6c7 Hannes Reinecke   2018-10-17  2371  	case 0xA0:
77266186397c6c7 Hannes Reinecke   2018-10-17  2372  		dev_notice(&pdev->dev, "Logical Drive Installation Aborted\n");
77266186397c6c7 Hannes Reinecke   2018-10-17  2373  		break;
77266186397c6c7 Hannes Reinecke   2018-10-17  2374  	case 0xB0:
77266186397c6c7 Hannes Reinecke   2018-10-17  2375  		dev_notice(&pdev->dev, "Mirror Race On A Critical Logical Drive\n");
77266186397c6c7 Hannes Reinecke   2018-10-17  2376  		break;
77266186397c6c7 Hannes Reinecke   2018-10-17  2377  	case 0xD0:
77266186397c6c7 Hannes Reinecke   2018-10-17  2378  		dev_notice(&pdev->dev, "New Controller Configuration Found\n");
77266186397c6c7 Hannes Reinecke   2018-10-17  2379  		break;
77266186397c6c7 Hannes Reinecke   2018-10-17  2380  	case 0xF0:
77266186397c6c7 Hannes Reinecke   2018-10-17  2381  		dev_err(&pdev->dev, "Fatal Memory Parity Error\n");
77266186397c6c7 Hannes Reinecke   2018-10-17  2382  		return true;
77266186397c6c7 Hannes Reinecke   2018-10-17  2383  	default:
77266186397c6c7 Hannes Reinecke   2018-10-17  2384  		dev_err(&pdev->dev, "Unknown Initialization Error %02X\n",
77266186397c6c7 Hannes Reinecke   2018-10-17  2385  			status);
77266186397c6c7 Hannes Reinecke   2018-10-17  2386  		return true;
77266186397c6c7 Hannes Reinecke   2018-10-17  2387  	}
77266186397c6c7 Hannes Reinecke   2018-10-17  2388  	return false;
77266186397c6c7 Hannes Reinecke   2018-10-17  2389  }
77266186397c6c7 Hannes Reinecke   2018-10-17  2390  
77266186397c6c7 Hannes Reinecke   2018-10-17  2391  /*
77266186397c6c7 Hannes Reinecke   2018-10-17  2392   * Hardware-specific functions
77266186397c6c7 Hannes Reinecke   2018-10-17  2393   */
77266186397c6c7 Hannes Reinecke   2018-10-17  2394  
77266186397c6c7 Hannes Reinecke   2018-10-17  2395  /*
77266186397c6c7 Hannes Reinecke   2018-10-17  2396   * DAC960 GEM Series Controllers.
77266186397c6c7 Hannes Reinecke   2018-10-17  2397   */
77266186397c6c7 Hannes Reinecke   2018-10-17  2398  
77266186397c6c7 Hannes Reinecke   2018-10-17  2399  static inline void DAC960_GEM_hw_mbox_new_cmd(void __iomem *base)
77266186397c6c7 Hannes Reinecke   2018-10-17  2400  {
77266186397c6c7 Hannes Reinecke   2018-10-17  2401  	__le32 val = cpu_to_le32(DAC960_GEM_IDB_HWMBOX_NEW_CMD << 24);
77266186397c6c7 Hannes Reinecke   2018-10-17  2402  
77266186397c6c7 Hannes Reinecke   2018-10-17  2403  	writel(val, base + DAC960_GEM_IDB_READ_OFFSET);
77266186397c6c7 Hannes Reinecke   2018-10-17  2404  }
77266186397c6c7 Hannes Reinecke   2018-10-17  2405  
77266186397c6c7 Hannes Reinecke   2018-10-17  2406  static inline void DAC960_GEM_ack_hw_mbox_status(void __iomem *base)
77266186397c6c7 Hannes Reinecke   2018-10-17  2407  {
77266186397c6c7 Hannes Reinecke   2018-10-17  2408  	__le32 val = cpu_to_le32(DAC960_GEM_IDB_HWMBOX_ACK_STS << 24);
77266186397c6c7 Hannes Reinecke   2018-10-17  2409  
77266186397c6c7 Hannes Reinecke   2018-10-17  2410  	writel(val, base + DAC960_GEM_IDB_CLEAR_OFFSET);
77266186397c6c7 Hannes Reinecke   2018-10-17  2411  }
77266186397c6c7 Hannes Reinecke   2018-10-17  2412  
77266186397c6c7 Hannes Reinecke   2018-10-17  2413  static inline void DAC960_GEM_reset_ctrl(void __iomem *base)
77266186397c6c7 Hannes Reinecke   2018-10-17  2414  {
77266186397c6c7 Hannes Reinecke   2018-10-17  2415  	__le32 val = cpu_to_le32(DAC960_GEM_IDB_CTRL_RESET << 24);
77266186397c6c7 Hannes Reinecke   2018-10-17  2416  
77266186397c6c7 Hannes Reinecke   2018-10-17  2417  	writel(val, base + DAC960_GEM_IDB_READ_OFFSET);
77266186397c6c7 Hannes Reinecke   2018-10-17  2418  }
77266186397c6c7 Hannes Reinecke   2018-10-17  2419  
77266186397c6c7 Hannes Reinecke   2018-10-17  2420  static inline void DAC960_GEM_mem_mbox_new_cmd(void __iomem *base)
77266186397c6c7 Hannes Reinecke   2018-10-17  2421  {
77266186397c6c7 Hannes Reinecke   2018-10-17  2422  	__le32 val = cpu_to_le32(DAC960_GEM_IDB_HWMBOX_NEW_CMD << 24);
77266186397c6c7 Hannes Reinecke   2018-10-17  2423  
77266186397c6c7 Hannes Reinecke   2018-10-17  2424  	writel(val, base + DAC960_GEM_IDB_READ_OFFSET);
77266186397c6c7 Hannes Reinecke   2018-10-17  2425  }
77266186397c6c7 Hannes Reinecke   2018-10-17  2426  
77266186397c6c7 Hannes Reinecke   2018-10-17  2427  static inline bool DAC960_GEM_hw_mbox_is_full(void __iomem *base)
77266186397c6c7 Hannes Reinecke   2018-10-17  2428  {
77266186397c6c7 Hannes Reinecke   2018-10-17  2429  	__le32 val;
77266186397c6c7 Hannes Reinecke   2018-10-17  2430  
77266186397c6c7 Hannes Reinecke   2018-10-17  2431  	val = readl(base + DAC960_GEM_IDB_READ_OFFSET);
77266186397c6c7 Hannes Reinecke   2018-10-17  2432  	return (le32_to_cpu(val) >> 24) & DAC960_GEM_IDB_HWMBOX_FULL;
77266186397c6c7 Hannes Reinecke   2018-10-17  2433  }
77266186397c6c7 Hannes Reinecke   2018-10-17  2434  
77266186397c6c7 Hannes Reinecke   2018-10-17  2435  static inline bool DAC960_GEM_init_in_progress(void __iomem *base)
77266186397c6c7 Hannes Reinecke   2018-10-17  2436  {
77266186397c6c7 Hannes Reinecke   2018-10-17  2437  	__le32 val;
77266186397c6c7 Hannes Reinecke   2018-10-17  2438  
77266186397c6c7 Hannes Reinecke   2018-10-17 @2439  	val = readl(base + DAC960_GEM_IDB_READ_OFFSET);
77266186397c6c7 Hannes Reinecke   2018-10-17  2440  	return (le32_to_cpu(val) >> 24) & DAC960_GEM_IDB_INIT_IN_PROGRESS;
77266186397c6c7 Hannes Reinecke   2018-10-17  2441  }
77266186397c6c7 Hannes Reinecke   2018-10-17  2442  

:::::: The code at line 2439 was first introduced by commit
:::::: 77266186397c6c782a3f670d32808a9671806ec5 scsi: myrs: Add Mylex RAID controller (SCSI interface)

:::::: TO: Hannes Reinecke <hare@suse.com>
:::::: CC: Martin K. Petersen <martin.petersen@oracle.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
