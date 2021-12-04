Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A00B4686B6
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 18:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385269AbhLDRoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 12:44:25 -0500
Received: from mga04.intel.com ([192.55.52.120]:49128 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234651AbhLDRoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 12:44:24 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10188"; a="235870626"
X-IronPort-AV: E=Sophos;i="5.87,287,1631602800"; 
   d="scan'208";a="235870626"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2021 09:40:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,287,1631602800"; 
   d="scan'208";a="541944279"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 04 Dec 2021 09:40:56 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mtZ1r-000JFU-Kb; Sat, 04 Dec 2021 17:40:55 +0000
Date:   Sun, 5 Dec 2021 01:40:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: drivers/scsi/myrs.c:2434:13: sparse: sparse: incorrect type in
 assignment (different base types)
Message-ID: <202112050107.2l2GufNo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   12119cfa1052d512a92524e90ebee85029a918f8
commit: a18b14d8886614b3c7d290c4cfc33389822b0535 riscv: Disable STACKPROTECTOR_PER_TASK if GCC_PLUGIN_RANDSTRUCT is enabled
date:   4 months ago
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20211205/202112050107.2l2GufNo-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a18b14d8886614b3c7d290c4cfc33389822b0535
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a18b14d8886614b3c7d290c4cfc33389822b0535
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/ drivers/scsi/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/scsi/myrs.c:2267:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *base @@     got struct myrs_hba *cs @@
   drivers/scsi/myrs.c:2267:34: sparse:     expected void [noderef] __iomem *base
   drivers/scsi/myrs.c:2267:34: sparse:     got struct myrs_hba *cs
   drivers/scsi/myrs.c:2419:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/myrs.c:2472:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/myrs.c:2412:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/myrs.c:2472:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/myrs.c:2405:9: sparse: sparse: cast from restricted __le32
>> drivers/scsi/myrs.c:2434:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] val @@     got unsigned int [assigned] [usertype] __v @@
   drivers/scsi/myrs.c:2434:13: sparse:     expected restricted __le32 [usertype] val
   drivers/scsi/myrs.c:2434:13: sparse:     got unsigned int [assigned] [usertype] __v
   drivers/scsi/myrs.c:2504:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] val @@     got unsigned int [assigned] [usertype] __v @@
   drivers/scsi/myrs.c:2504:13: sparse:     expected restricted __le32 [usertype] val
   drivers/scsi/myrs.c:2504:13: sparse:     got unsigned int [assigned] [usertype] __v
   drivers/scsi/myrs.c:2507:18: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/myrs.c:2412:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/myrs.c:2465:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/myrs.c:2450:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/myrs.c:2426:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] val @@     got unsigned int [assigned] [usertype] __v @@
   drivers/scsi/myrs.c:2426:13: sparse:     expected restricted __le32 [usertype] val
   drivers/scsi/myrs.c:2426:13: sparse:     got unsigned int [assigned] [usertype] __v
   drivers/scsi/myrs.c:2398:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/myrs.c:2457:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] val @@     got unsigned int [assigned] [usertype] __v @@
   drivers/scsi/myrs.c:2457:13: sparse:     expected restricted __le32 [usertype] val
   drivers/scsi/myrs.c:2457:13: sparse:     got unsigned int [assigned] [usertype] __v
   drivers/scsi/myrs.c:2442:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/myrs.c:2405:9: sparse: sparse: cast from restricted __le32

vim +2434 drivers/scsi/myrs.c

77266186397c6c Hannes Reinecke   2018-10-17  2258  
77266186397c6c Hannes Reinecke   2018-10-17  2259  static void myrs_cleanup(struct myrs_hba *cs)
77266186397c6c Hannes Reinecke   2018-10-17  2260  {
77266186397c6c Hannes Reinecke   2018-10-17  2261  	struct pci_dev *pdev = cs->pdev;
77266186397c6c Hannes Reinecke   2018-10-17  2262  
77266186397c6c Hannes Reinecke   2018-10-17  2263  	/* Free the memory mailbox, status, and related structures */
77266186397c6c Hannes Reinecke   2018-10-17  2264  	myrs_unmap(cs);
77266186397c6c Hannes Reinecke   2018-10-17  2265  
77266186397c6c Hannes Reinecke   2018-10-17  2266  	if (cs->mmio_base) {
77266186397c6c Hannes Reinecke   2018-10-17 @2267  		cs->disable_intr(cs);
77266186397c6c Hannes Reinecke   2018-10-17  2268  		iounmap(cs->mmio_base);
2bb817712e2f77 Lv Yunlong        2021-03-10  2269  		cs->mmio_base = NULL;
77266186397c6c Hannes Reinecke   2018-10-17  2270  	}
77266186397c6c Hannes Reinecke   2018-10-17  2271  	if (cs->irq)
77266186397c6c Hannes Reinecke   2018-10-17  2272  		free_irq(cs->irq, cs);
77266186397c6c Hannes Reinecke   2018-10-17  2273  	if (cs->io_addr)
77266186397c6c Hannes Reinecke   2018-10-17  2274  		release_region(cs->io_addr, 0x80);
77266186397c6c Hannes Reinecke   2018-10-17  2275  	pci_set_drvdata(pdev, NULL);
77266186397c6c Hannes Reinecke   2018-10-17  2276  	pci_disable_device(pdev);
77266186397c6c Hannes Reinecke   2018-10-17  2277  	scsi_host_put(cs->host);
77266186397c6c Hannes Reinecke   2018-10-17  2278  }
77266186397c6c Hannes Reinecke   2018-10-17  2279  
77266186397c6c Hannes Reinecke   2018-10-17  2280  static struct myrs_hba *myrs_detect(struct pci_dev *pdev,
77266186397c6c Hannes Reinecke   2018-10-17  2281  		const struct pci_device_id *entry)
77266186397c6c Hannes Reinecke   2018-10-17  2282  {
77266186397c6c Hannes Reinecke   2018-10-17  2283  	struct myrs_privdata *privdata =
77266186397c6c Hannes Reinecke   2018-10-17  2284  		(struct myrs_privdata *)entry->driver_data;
77266186397c6c Hannes Reinecke   2018-10-17  2285  	irq_handler_t irq_handler = privdata->irq_handler;
77266186397c6c Hannes Reinecke   2018-10-17  2286  	unsigned int mmio_size = privdata->mmio_size;
77266186397c6c Hannes Reinecke   2018-10-17  2287  	struct myrs_hba *cs = NULL;
77266186397c6c Hannes Reinecke   2018-10-17  2288  
77266186397c6c Hannes Reinecke   2018-10-17  2289  	cs = myrs_alloc_host(pdev, entry);
77266186397c6c Hannes Reinecke   2018-10-17  2290  	if (!cs) {
77266186397c6c Hannes Reinecke   2018-10-17  2291  		dev_err(&pdev->dev, "Unable to allocate Controller\n");
77266186397c6c Hannes Reinecke   2018-10-17  2292  		return NULL;
77266186397c6c Hannes Reinecke   2018-10-17  2293  	}
77266186397c6c Hannes Reinecke   2018-10-17  2294  	cs->pdev = pdev;
77266186397c6c Hannes Reinecke   2018-10-17  2295  
77266186397c6c Hannes Reinecke   2018-10-17  2296  	if (pci_enable_device(pdev))
77266186397c6c Hannes Reinecke   2018-10-17  2297  		goto Failure;
77266186397c6c Hannes Reinecke   2018-10-17  2298  
77266186397c6c Hannes Reinecke   2018-10-17  2299  	cs->pci_addr = pci_resource_start(pdev, 0);
77266186397c6c Hannes Reinecke   2018-10-17  2300  
77266186397c6c Hannes Reinecke   2018-10-17  2301  	pci_set_drvdata(pdev, cs);
77266186397c6c Hannes Reinecke   2018-10-17  2302  	spin_lock_init(&cs->queue_lock);
77266186397c6c Hannes Reinecke   2018-10-17  2303  	/* Map the Controller Register Window. */
77266186397c6c Hannes Reinecke   2018-10-17  2304  	if (mmio_size < PAGE_SIZE)
77266186397c6c Hannes Reinecke   2018-10-17  2305  		mmio_size = PAGE_SIZE;
4bdc0d676a6431 Christoph Hellwig 2020-01-06  2306  	cs->mmio_base = ioremap(cs->pci_addr & PAGE_MASK, mmio_size);
77266186397c6c Hannes Reinecke   2018-10-17  2307  	if (cs->mmio_base == NULL) {
77266186397c6c Hannes Reinecke   2018-10-17  2308  		dev_err(&pdev->dev,
77266186397c6c Hannes Reinecke   2018-10-17  2309  			"Unable to map Controller Register Window\n");
77266186397c6c Hannes Reinecke   2018-10-17  2310  		goto Failure;
77266186397c6c Hannes Reinecke   2018-10-17  2311  	}
77266186397c6c Hannes Reinecke   2018-10-17  2312  
77266186397c6c Hannes Reinecke   2018-10-17  2313  	cs->io_base = cs->mmio_base + (cs->pci_addr & ~PAGE_MASK);
77266186397c6c Hannes Reinecke   2018-10-17  2314  	if (privdata->hw_init(pdev, cs, cs->io_base))
77266186397c6c Hannes Reinecke   2018-10-17  2315  		goto Failure;
77266186397c6c Hannes Reinecke   2018-10-17  2316  
77266186397c6c Hannes Reinecke   2018-10-17  2317  	/* Acquire shared access to the IRQ Channel. */
77266186397c6c Hannes Reinecke   2018-10-17  2318  	if (request_irq(pdev->irq, irq_handler, IRQF_SHARED, "myrs", cs) < 0) {
77266186397c6c Hannes Reinecke   2018-10-17  2319  		dev_err(&pdev->dev,
77266186397c6c Hannes Reinecke   2018-10-17  2320  			"Unable to acquire IRQ Channel %d\n", pdev->irq);
77266186397c6c Hannes Reinecke   2018-10-17  2321  		goto Failure;
77266186397c6c Hannes Reinecke   2018-10-17  2322  	}
77266186397c6c Hannes Reinecke   2018-10-17  2323  	cs->irq = pdev->irq;
77266186397c6c Hannes Reinecke   2018-10-17  2324  	return cs;
77266186397c6c Hannes Reinecke   2018-10-17  2325  
77266186397c6c Hannes Reinecke   2018-10-17  2326  Failure:
77266186397c6c Hannes Reinecke   2018-10-17  2327  	dev_err(&pdev->dev,
77266186397c6c Hannes Reinecke   2018-10-17  2328  		"Failed to initialize Controller\n");
77266186397c6c Hannes Reinecke   2018-10-17  2329  	myrs_cleanup(cs);
77266186397c6c Hannes Reinecke   2018-10-17  2330  	return NULL;
77266186397c6c Hannes Reinecke   2018-10-17  2331  }
77266186397c6c Hannes Reinecke   2018-10-17  2332  
8a692fdb1d04f5 Lee Jones         2020-07-13  2333  /*
77266186397c6c Hannes Reinecke   2018-10-17  2334   * myrs_err_status reports Controller BIOS Messages passed through
8a692fdb1d04f5 Lee Jones         2020-07-13  2335   * the Error Status Register when the driver performs the BIOS handshaking.
8a692fdb1d04f5 Lee Jones         2020-07-13  2336   * It returns true for fatal errors and false otherwise.
77266186397c6c Hannes Reinecke   2018-10-17  2337   */
77266186397c6c Hannes Reinecke   2018-10-17  2338  
77266186397c6c Hannes Reinecke   2018-10-17  2339  static bool myrs_err_status(struct myrs_hba *cs, unsigned char status,
77266186397c6c Hannes Reinecke   2018-10-17  2340  		unsigned char parm0, unsigned char parm1)
77266186397c6c Hannes Reinecke   2018-10-17  2341  {
77266186397c6c Hannes Reinecke   2018-10-17  2342  	struct pci_dev *pdev = cs->pdev;
77266186397c6c Hannes Reinecke   2018-10-17  2343  
77266186397c6c Hannes Reinecke   2018-10-17  2344  	switch (status) {
77266186397c6c Hannes Reinecke   2018-10-17  2345  	case 0x00:
77266186397c6c Hannes Reinecke   2018-10-17  2346  		dev_info(&pdev->dev,
77266186397c6c Hannes Reinecke   2018-10-17  2347  			 "Physical Device %d:%d Not Responding\n",
77266186397c6c Hannes Reinecke   2018-10-17  2348  			 parm1, parm0);
77266186397c6c Hannes Reinecke   2018-10-17  2349  		break;
77266186397c6c Hannes Reinecke   2018-10-17  2350  	case 0x08:
77266186397c6c Hannes Reinecke   2018-10-17  2351  		dev_notice(&pdev->dev, "Spinning Up Drives\n");
77266186397c6c Hannes Reinecke   2018-10-17  2352  		break;
77266186397c6c Hannes Reinecke   2018-10-17  2353  	case 0x30:
77266186397c6c Hannes Reinecke   2018-10-17  2354  		dev_notice(&pdev->dev, "Configuration Checksum Error\n");
77266186397c6c Hannes Reinecke   2018-10-17  2355  		break;
77266186397c6c Hannes Reinecke   2018-10-17  2356  	case 0x60:
77266186397c6c Hannes Reinecke   2018-10-17  2357  		dev_notice(&pdev->dev, "Mirror Race Recovery Failed\n");
77266186397c6c Hannes Reinecke   2018-10-17  2358  		break;
77266186397c6c Hannes Reinecke   2018-10-17  2359  	case 0x70:
77266186397c6c Hannes Reinecke   2018-10-17  2360  		dev_notice(&pdev->dev, "Mirror Race Recovery In Progress\n");
77266186397c6c Hannes Reinecke   2018-10-17  2361  		break;
77266186397c6c Hannes Reinecke   2018-10-17  2362  	case 0x90:
77266186397c6c Hannes Reinecke   2018-10-17  2363  		dev_notice(&pdev->dev, "Physical Device %d:%d COD Mismatch\n",
77266186397c6c Hannes Reinecke   2018-10-17  2364  			   parm1, parm0);
77266186397c6c Hannes Reinecke   2018-10-17  2365  		break;
77266186397c6c Hannes Reinecke   2018-10-17  2366  	case 0xA0:
77266186397c6c Hannes Reinecke   2018-10-17  2367  		dev_notice(&pdev->dev, "Logical Drive Installation Aborted\n");
77266186397c6c Hannes Reinecke   2018-10-17  2368  		break;
77266186397c6c Hannes Reinecke   2018-10-17  2369  	case 0xB0:
77266186397c6c Hannes Reinecke   2018-10-17  2370  		dev_notice(&pdev->dev, "Mirror Race On A Critical Logical Drive\n");
77266186397c6c Hannes Reinecke   2018-10-17  2371  		break;
77266186397c6c Hannes Reinecke   2018-10-17  2372  	case 0xD0:
77266186397c6c Hannes Reinecke   2018-10-17  2373  		dev_notice(&pdev->dev, "New Controller Configuration Found\n");
77266186397c6c Hannes Reinecke   2018-10-17  2374  		break;
77266186397c6c Hannes Reinecke   2018-10-17  2375  	case 0xF0:
77266186397c6c Hannes Reinecke   2018-10-17  2376  		dev_err(&pdev->dev, "Fatal Memory Parity Error\n");
77266186397c6c Hannes Reinecke   2018-10-17  2377  		return true;
77266186397c6c Hannes Reinecke   2018-10-17  2378  	default:
77266186397c6c Hannes Reinecke   2018-10-17  2379  		dev_err(&pdev->dev, "Unknown Initialization Error %02X\n",
77266186397c6c Hannes Reinecke   2018-10-17  2380  			status);
77266186397c6c Hannes Reinecke   2018-10-17  2381  		return true;
77266186397c6c Hannes Reinecke   2018-10-17  2382  	}
77266186397c6c Hannes Reinecke   2018-10-17  2383  	return false;
77266186397c6c Hannes Reinecke   2018-10-17  2384  }
77266186397c6c Hannes Reinecke   2018-10-17  2385  
77266186397c6c Hannes Reinecke   2018-10-17  2386  /*
77266186397c6c Hannes Reinecke   2018-10-17  2387   * Hardware-specific functions
77266186397c6c Hannes Reinecke   2018-10-17  2388   */
77266186397c6c Hannes Reinecke   2018-10-17  2389  
77266186397c6c Hannes Reinecke   2018-10-17  2390  /*
77266186397c6c Hannes Reinecke   2018-10-17  2391   * DAC960 GEM Series Controllers.
77266186397c6c Hannes Reinecke   2018-10-17  2392   */
77266186397c6c Hannes Reinecke   2018-10-17  2393  
77266186397c6c Hannes Reinecke   2018-10-17  2394  static inline void DAC960_GEM_hw_mbox_new_cmd(void __iomem *base)
77266186397c6c Hannes Reinecke   2018-10-17  2395  {
77266186397c6c Hannes Reinecke   2018-10-17  2396  	__le32 val = cpu_to_le32(DAC960_GEM_IDB_HWMBOX_NEW_CMD << 24);
77266186397c6c Hannes Reinecke   2018-10-17  2397  
77266186397c6c Hannes Reinecke   2018-10-17  2398  	writel(val, base + DAC960_GEM_IDB_READ_OFFSET);
77266186397c6c Hannes Reinecke   2018-10-17  2399  }
77266186397c6c Hannes Reinecke   2018-10-17  2400  
77266186397c6c Hannes Reinecke   2018-10-17  2401  static inline void DAC960_GEM_ack_hw_mbox_status(void __iomem *base)
77266186397c6c Hannes Reinecke   2018-10-17  2402  {
77266186397c6c Hannes Reinecke   2018-10-17  2403  	__le32 val = cpu_to_le32(DAC960_GEM_IDB_HWMBOX_ACK_STS << 24);
77266186397c6c Hannes Reinecke   2018-10-17  2404  
77266186397c6c Hannes Reinecke   2018-10-17  2405  	writel(val, base + DAC960_GEM_IDB_CLEAR_OFFSET);
77266186397c6c Hannes Reinecke   2018-10-17  2406  }
77266186397c6c Hannes Reinecke   2018-10-17  2407  
77266186397c6c Hannes Reinecke   2018-10-17  2408  static inline void DAC960_GEM_reset_ctrl(void __iomem *base)
77266186397c6c Hannes Reinecke   2018-10-17  2409  {
77266186397c6c Hannes Reinecke   2018-10-17  2410  	__le32 val = cpu_to_le32(DAC960_GEM_IDB_CTRL_RESET << 24);
77266186397c6c Hannes Reinecke   2018-10-17  2411  
77266186397c6c Hannes Reinecke   2018-10-17  2412  	writel(val, base + DAC960_GEM_IDB_READ_OFFSET);
77266186397c6c Hannes Reinecke   2018-10-17  2413  }
77266186397c6c Hannes Reinecke   2018-10-17  2414  
77266186397c6c Hannes Reinecke   2018-10-17  2415  static inline void DAC960_GEM_mem_mbox_new_cmd(void __iomem *base)
77266186397c6c Hannes Reinecke   2018-10-17  2416  {
77266186397c6c Hannes Reinecke   2018-10-17  2417  	__le32 val = cpu_to_le32(DAC960_GEM_IDB_HWMBOX_NEW_CMD << 24);
77266186397c6c Hannes Reinecke   2018-10-17  2418  
77266186397c6c Hannes Reinecke   2018-10-17  2419  	writel(val, base + DAC960_GEM_IDB_READ_OFFSET);
77266186397c6c Hannes Reinecke   2018-10-17  2420  }
77266186397c6c Hannes Reinecke   2018-10-17  2421  
77266186397c6c Hannes Reinecke   2018-10-17  2422  static inline bool DAC960_GEM_hw_mbox_is_full(void __iomem *base)
77266186397c6c Hannes Reinecke   2018-10-17  2423  {
77266186397c6c Hannes Reinecke   2018-10-17  2424  	__le32 val;
77266186397c6c Hannes Reinecke   2018-10-17  2425  
77266186397c6c Hannes Reinecke   2018-10-17  2426  	val = readl(base + DAC960_GEM_IDB_READ_OFFSET);
77266186397c6c Hannes Reinecke   2018-10-17  2427  	return (le32_to_cpu(val) >> 24) & DAC960_GEM_IDB_HWMBOX_FULL;
77266186397c6c Hannes Reinecke   2018-10-17  2428  }
77266186397c6c Hannes Reinecke   2018-10-17  2429  
77266186397c6c Hannes Reinecke   2018-10-17  2430  static inline bool DAC960_GEM_init_in_progress(void __iomem *base)
77266186397c6c Hannes Reinecke   2018-10-17  2431  {
77266186397c6c Hannes Reinecke   2018-10-17  2432  	__le32 val;
77266186397c6c Hannes Reinecke   2018-10-17  2433  
77266186397c6c Hannes Reinecke   2018-10-17 @2434  	val = readl(base + DAC960_GEM_IDB_READ_OFFSET);
77266186397c6c Hannes Reinecke   2018-10-17  2435  	return (le32_to_cpu(val) >> 24) & DAC960_GEM_IDB_INIT_IN_PROGRESS;
77266186397c6c Hannes Reinecke   2018-10-17  2436  }
77266186397c6c Hannes Reinecke   2018-10-17  2437  

:::::: The code at line 2434 was first introduced by commit
:::::: 77266186397c6c782a3f670d32808a9671806ec5 scsi: myrs: Add Mylex RAID controller (SCSI interface)

:::::: TO: Hannes Reinecke <hare@suse.com>
:::::: CC: Martin K. Petersen <martin.petersen@oracle.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
