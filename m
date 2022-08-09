Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED4158D428
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 09:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236322AbiHIHEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 03:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235972AbiHIHEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 03:04:49 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0891CB09
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 00:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660028688; x=1691564688;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=tbci+4/V+Z6565cmiIO9rrQx0jiTn36t7acZovPHmfA=;
  b=W2NCwosXPqtOsfElJnrVMHiy+G1CQKd/l8MnFVKDr4M3A15FDV4TZDxo
   muW3A5Rt385hzBWbU/ApcOxIk6SYjsOfGAwwtcbf0d9hYTX12eWRhzmRO
   HY2wmtD/Q0Y/h0J5n/8s4TfDLTWX2rOBw9wjwEH7JC2w2ngSjED0ka+5J
   YqdfLAk4qYeshJgGGzFx8I3FB5LK6KjscpdNfqAaFecpUG3aXRmzth/Aa
   cMeCwWCDHxo8aY0Csr6odaVpdPGTdJLByD2D7vOjw2256yshl28lP17Oi
   WSP0Biclbz4x0ZBs5vTXDIg+oanAZeHf5Pj9lW+v4b9OFuFGzlB8TjRt4
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="277705260"
X-IronPort-AV: E=Sophos;i="5.93,223,1654585200"; 
   d="scan'208";a="277705260"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 00:04:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,223,1654585200"; 
   d="scan'208";a="672782537"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 09 Aug 2022 00:04:43 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLJIA-000Mow-31;
        Tue, 09 Aug 2022 07:04:42 +0000
Date:   Tue, 9 Aug 2022 15:04:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [bvanassche:scsi-const-host-template 10/11]
 drivers/ata/pata_amd.c:575:50: warning: passing argument 3 of
 'ata_pci_bmdma_init_one' discards 'const' qualifier from pointer target type
Message-ID: <202208091539.kxKLGtDn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/bvanassche/linux scsi-const-host-template
head:   86b323713ebb1d9a9b2f35df76be3954ba7f1759
commit: 579544e409bc1067fb7a362db251e6061b2ca2b2 [10/11] scsi: Declare most SCSI host templates const
config: i386-defconfig (https://download.01.org/0day-ci/archive/20220809/202208091539.kxKLGtDn-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/bvanassche/linux/commit/579544e409bc1067fb7a362db251e6061b2ca2b2
        git remote add bvanassche https://github.com/bvanassche/linux
        git fetch --no-tags bvanassche scsi-const-host-template
        git checkout 579544e409bc1067fb7a362db251e6061b2ca2b2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/ata/pata_amd.c: In function 'amd_init_one':
>> drivers/ata/pata_amd.c:575:50: warning: passing argument 3 of 'ata_pci_bmdma_init_one' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     575 |         return ata_pci_bmdma_init_one(pdev, ppi, &amd_sht, hpriv, 0);
         |                                                  ^~~~~~~~
   In file included from drivers/ata/pata_amd.c:24:
   include/linux/libata.h:2001:62: note: expected 'struct scsi_host_template *' but argument is of type 'const struct scsi_host_template *'
    2001 |                                   struct scsi_host_template *sht,
         |                                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
--
   drivers/ata/pata_oldpiix.c: In function 'oldpiix_init_one':
>> drivers/ata/pata_oldpiix.c:248:50: warning: passing argument 3 of 'ata_pci_bmdma_init_one' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     248 |         return ata_pci_bmdma_init_one(pdev, ppi, &oldpiix_sht, NULL, 0);
         |                                                  ^~~~~~~~~~~~
   In file included from drivers/ata/pata_oldpiix.c:24:
   include/linux/libata.h:2001:62: note: expected 'struct scsi_host_template *' but argument is of type 'const struct scsi_host_template *'
    2001 |                                   struct scsi_host_template *sht,
         |                                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
--
   drivers/ata/pata_sch.c: In function 'sch_init_one':
>> drivers/ata/pata_sch.c:164:50: warning: passing argument 3 of 'ata_pci_bmdma_init_one' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     164 |         return ata_pci_bmdma_init_one(pdev, ppi, &sch_sht, NULL, 0);
         |                                                  ^~~~~~~~
   In file included from drivers/ata/pata_sch.c:21:
   include/linux/libata.h:2001:62: note: expected 'struct scsi_host_template *' but argument is of type 'const struct scsi_host_template *'
    2001 |                                   struct scsi_host_template *sht,
         |                                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
--
   drivers/ata/ata_generic.c: In function 'ata_generic_init_one':
>> drivers/ata/ata_generic.c:209:49: warning: passing argument 3 of 'ata_pci_bmdma_init_one' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     209 |         return ata_pci_bmdma_init_one(dev, ppi, &generic_sht, (void *)id, 0);
         |                                                 ^~~~~~~~~~~~
   In file included from drivers/ata/ata_generic.c:25:
   include/linux/libata.h:2001:62: note: expected 'struct scsi_host_template *' but argument is of type 'const struct scsi_host_template *'
    2001 |                                   struct scsi_host_template *sht,
         |                                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~


vim +575 drivers/ata/pata_amd.c

c48052cc36e02f Alan Cox        2009-02-11  457  
669a5db411d85a Jeff Garzik     2006-08-29  458  static int amd_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
669a5db411d85a Jeff Garzik     2006-08-29  459  {
1626aeb881236c Tejun Heo       2007-05-04  460  	static const struct ata_port_info info[10] = {
14bdef982caeda Erik Inge Bolsø 2009-03-14  461  		{	/* 0: AMD 7401 - no swdma */
1d2808fd3d2d5d Jeff Garzik     2007-05-28  462  			.flags = ATA_FLAG_SLAVE_POSS,
14bdef982caeda Erik Inge Bolsø 2009-03-14  463  			.pio_mask = ATA_PIO4,
14bdef982caeda Erik Inge Bolsø 2009-03-14  464  			.mwdma_mask = ATA_MWDMA2,
14bdef982caeda Erik Inge Bolsø 2009-03-14  465  			.udma_mask = ATA_UDMA2,
669a5db411d85a Jeff Garzik     2006-08-29  466  			.port_ops = &amd33_port_ops
669a5db411d85a Jeff Garzik     2006-08-29  467  		},
669a5db411d85a Jeff Garzik     2006-08-29  468  		{	/* 1: Early AMD7409 - no swdma */
1d2808fd3d2d5d Jeff Garzik     2007-05-28  469  			.flags = ATA_FLAG_SLAVE_POSS,
14bdef982caeda Erik Inge Bolsø 2009-03-14  470  			.pio_mask = ATA_PIO4,
14bdef982caeda Erik Inge Bolsø 2009-03-14  471  			.mwdma_mask = ATA_MWDMA2,
14bdef982caeda Erik Inge Bolsø 2009-03-14  472  			.udma_mask = ATA_UDMA4,
669a5db411d85a Jeff Garzik     2006-08-29  473  			.port_ops = &amd66_port_ops
669a5db411d85a Jeff Garzik     2006-08-29  474  		},
14bdef982caeda Erik Inge Bolsø 2009-03-14  475  		{	/* 2: AMD 7409 */
1d2808fd3d2d5d Jeff Garzik     2007-05-28  476  			.flags = ATA_FLAG_SLAVE_POSS,
14bdef982caeda Erik Inge Bolsø 2009-03-14  477  			.pio_mask = ATA_PIO4,
14bdef982caeda Erik Inge Bolsø 2009-03-14  478  			.mwdma_mask = ATA_MWDMA2,
14bdef982caeda Erik Inge Bolsø 2009-03-14  479  			.udma_mask = ATA_UDMA4,
669a5db411d85a Jeff Garzik     2006-08-29  480  			.port_ops = &amd66_port_ops
669a5db411d85a Jeff Garzik     2006-08-29  481  		},
669a5db411d85a Jeff Garzik     2006-08-29  482  		{	/* 3: AMD 7411 */
1d2808fd3d2d5d Jeff Garzik     2007-05-28  483  			.flags = ATA_FLAG_SLAVE_POSS,
14bdef982caeda Erik Inge Bolsø 2009-03-14  484  			.pio_mask = ATA_PIO4,
14bdef982caeda Erik Inge Bolsø 2009-03-14  485  			.mwdma_mask = ATA_MWDMA2,
14bdef982caeda Erik Inge Bolsø 2009-03-14  486  			.udma_mask = ATA_UDMA5,
669a5db411d85a Jeff Garzik     2006-08-29  487  			.port_ops = &amd100_port_ops
669a5db411d85a Jeff Garzik     2006-08-29  488  		},
669a5db411d85a Jeff Garzik     2006-08-29  489  		{	/* 4: AMD 7441 */
1d2808fd3d2d5d Jeff Garzik     2007-05-28  490  			.flags = ATA_FLAG_SLAVE_POSS,
14bdef982caeda Erik Inge Bolsø 2009-03-14  491  			.pio_mask = ATA_PIO4,
14bdef982caeda Erik Inge Bolsø 2009-03-14  492  			.mwdma_mask = ATA_MWDMA2,
14bdef982caeda Erik Inge Bolsø 2009-03-14  493  			.udma_mask = ATA_UDMA5,
669a5db411d85a Jeff Garzik     2006-08-29  494  			.port_ops = &amd100_port_ops
669a5db411d85a Jeff Garzik     2006-08-29  495  		},
14bdef982caeda Erik Inge Bolsø 2009-03-14  496  		{	/* 5: AMD 8111 - no swdma */
1d2808fd3d2d5d Jeff Garzik     2007-05-28  497  			.flags = ATA_FLAG_SLAVE_POSS,
14bdef982caeda Erik Inge Bolsø 2009-03-14  498  			.pio_mask = ATA_PIO4,
14bdef982caeda Erik Inge Bolsø 2009-03-14  499  			.mwdma_mask = ATA_MWDMA2,
14bdef982caeda Erik Inge Bolsø 2009-03-14  500  			.udma_mask = ATA_UDMA6,
669a5db411d85a Jeff Garzik     2006-08-29  501  			.port_ops = &amd133_port_ops
669a5db411d85a Jeff Garzik     2006-08-29  502  		},
14bdef982caeda Erik Inge Bolsø 2009-03-14  503  		{	/* 6: AMD 8111 UDMA 100 (Serenade) - no swdma */
1d2808fd3d2d5d Jeff Garzik     2007-05-28  504  			.flags = ATA_FLAG_SLAVE_POSS,
14bdef982caeda Erik Inge Bolsø 2009-03-14  505  			.pio_mask = ATA_PIO4,
14bdef982caeda Erik Inge Bolsø 2009-03-14  506  			.mwdma_mask = ATA_MWDMA2,
14bdef982caeda Erik Inge Bolsø 2009-03-14  507  			.udma_mask = ATA_UDMA5,
669a5db411d85a Jeff Garzik     2006-08-29  508  			.port_ops = &amd133_port_ops
669a5db411d85a Jeff Garzik     2006-08-29  509  		},
669a5db411d85a Jeff Garzik     2006-08-29  510  		{	/* 7: Nvidia Nforce */
1d2808fd3d2d5d Jeff Garzik     2007-05-28  511  			.flags = ATA_FLAG_SLAVE_POSS,
14bdef982caeda Erik Inge Bolsø 2009-03-14  512  			.pio_mask = ATA_PIO4,
14bdef982caeda Erik Inge Bolsø 2009-03-14  513  			.mwdma_mask = ATA_MWDMA2,
14bdef982caeda Erik Inge Bolsø 2009-03-14  514  			.udma_mask = ATA_UDMA5,
669a5db411d85a Jeff Garzik     2006-08-29  515  			.port_ops = &nv100_port_ops
669a5db411d85a Jeff Garzik     2006-08-29  516  		},
14bdef982caeda Erik Inge Bolsø 2009-03-14  517  		{	/* 8: Nvidia Nforce2 and later - no swdma */
1d2808fd3d2d5d Jeff Garzik     2007-05-28  518  			.flags = ATA_FLAG_SLAVE_POSS,
14bdef982caeda Erik Inge Bolsø 2009-03-14  519  			.pio_mask = ATA_PIO4,
14bdef982caeda Erik Inge Bolsø 2009-03-14  520  			.mwdma_mask = ATA_MWDMA2,
14bdef982caeda Erik Inge Bolsø 2009-03-14  521  			.udma_mask = ATA_UDMA6,
669a5db411d85a Jeff Garzik     2006-08-29  522  			.port_ops = &nv133_port_ops
669a5db411d85a Jeff Garzik     2006-08-29  523  		},
669a5db411d85a Jeff Garzik     2006-08-29  524  		{	/* 9: AMD CS5536 (Geode companion) */
1d2808fd3d2d5d Jeff Garzik     2007-05-28  525  			.flags = ATA_FLAG_SLAVE_POSS,
14bdef982caeda Erik Inge Bolsø 2009-03-14  526  			.pio_mask = ATA_PIO4,
14bdef982caeda Erik Inge Bolsø 2009-03-14  527  			.mwdma_mask = ATA_MWDMA2,
14bdef982caeda Erik Inge Bolsø 2009-03-14  528  			.udma_mask = ATA_UDMA5,
669a5db411d85a Jeff Garzik     2006-08-29  529  			.port_ops = &amd100_port_ops
669a5db411d85a Jeff Garzik     2006-08-29  530  		}
669a5db411d85a Jeff Garzik     2006-08-29  531  	};
887125e3740283 Tejun Heo       2008-03-25  532  	const struct ata_port_info *ppi[] = { NULL, NULL };
669a5db411d85a Jeff Garzik     2006-08-29  533  	int type = id->driver_data;
887125e3740283 Tejun Heo       2008-03-25  534  	void *hpriv = NULL;
669a5db411d85a Jeff Garzik     2006-08-29  535  	u8 fifo;
f08048e94564d0 Tejun Heo       2008-03-25  536  	int rc;
669a5db411d85a Jeff Garzik     2006-08-29  537  
06296a1e684bcd Joe Perches     2011-04-15  538  	ata_print_version_once(&pdev->dev, DRV_VERSION);
669a5db411d85a Jeff Garzik     2006-08-29  539  
f08048e94564d0 Tejun Heo       2008-03-25  540  	rc = pcim_enable_device(pdev);
f08048e94564d0 Tejun Heo       2008-03-25  541  	if (rc)
f08048e94564d0 Tejun Heo       2008-03-25  542  		return rc;
f08048e94564d0 Tejun Heo       2008-03-25  543  
669a5db411d85a Jeff Garzik     2006-08-29  544  	pci_read_config_byte(pdev, 0x41, &fifo);
669a5db411d85a Jeff Garzik     2006-08-29  545  
669a5db411d85a Jeff Garzik     2006-08-29  546  	/* Check for AMD7409 without swdma errata and if found adjust type */
44c10138fd4bbc Auke Kok        2007-06-08  547  	if (type == 1 && pdev->revision > 0x7)
669a5db411d85a Jeff Garzik     2006-08-29  548  		type = 2;
669a5db411d85a Jeff Garzik     2006-08-29  549  
ce54d161630211 Tejun Heo       2007-12-18  550  	/* Serenade ? */
ce54d161630211 Tejun Heo       2007-12-18  551  	if (type == 5 && pdev->subsystem_vendor == PCI_VENDOR_ID_AMD &&
ce54d161630211 Tejun Heo       2007-12-18  552  			 pdev->subsystem_device == PCI_DEVICE_ID_AMD_SERENADE)
ce54d161630211 Tejun Heo       2007-12-18  553  		type = 6;	/* UDMA 100 only */
ce54d161630211 Tejun Heo       2007-12-18  554  
ce54d161630211 Tejun Heo       2007-12-18  555  	/*
ce54d161630211 Tejun Heo       2007-12-18  556  	 * Okay, type is determined now.  Apply type-specific workarounds.
ce54d161630211 Tejun Heo       2007-12-18  557  	 */
887125e3740283 Tejun Heo       2008-03-25  558  	ppi[0] = &info[type];
ce54d161630211 Tejun Heo       2007-12-18  559  
ce54d161630211 Tejun Heo       2007-12-18  560  	if (type < 3)
9363c3825ea9ad Tejun Heo       2008-04-07  561  		ata_pci_bmdma_clear_simplex(pdev);
c48052cc36e02f Alan Cox        2009-02-11  562  	if (pdev->vendor == PCI_VENDOR_ID_AMD)
c48052cc36e02f Alan Cox        2009-02-11  563  		amd_clear_fifo(pdev);
ce54d161630211 Tejun Heo       2007-12-18  564  	/* Cable detection on Nvidia chips doesn't work too well,
ce54d161630211 Tejun Heo       2007-12-18  565  	 * cache BIOS programmed UDMA mode.
ce54d161630211 Tejun Heo       2007-12-18  566  	 */
ce54d161630211 Tejun Heo       2007-12-18  567  	if (type == 7 || type == 8) {
ce54d161630211 Tejun Heo       2007-12-18  568  		u32 udma;
669a5db411d85a Jeff Garzik     2006-08-29  569  
ce54d161630211 Tejun Heo       2007-12-18  570  		pci_read_config_dword(pdev, 0x60, &udma);
887125e3740283 Tejun Heo       2008-03-25  571  		hpriv = (void *)(unsigned long)udma;
ce54d161630211 Tejun Heo       2007-12-18  572  	}
669a5db411d85a Jeff Garzik     2006-08-29  573  
669a5db411d85a Jeff Garzik     2006-08-29  574  	/* And fire it up */
1c5afdf7a629d2 Tejun Heo       2010-05-19 @575  	return ata_pci_bmdma_init_one(pdev, ppi, &amd_sht, hpriv, 0);
669a5db411d85a Jeff Garzik     2006-08-29  576  }
669a5db411d85a Jeff Garzik     2006-08-29  577  

:::::: The code at line 575 was first introduced by commit
:::::: 1c5afdf7a629d2e77de8dd043b97a33dcd7e6dfa libata-sff: separate out BMDMA init

:::::: TO: Tejun Heo <tj@kernel.org>
:::::: CC: Jeff Garzik <jgarzik@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
