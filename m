Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FAA58D4B2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 09:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236184AbiHIHgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 03:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240125AbiHIHfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 03:35:47 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C60C1EED3
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 00:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660030545; x=1691566545;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=e5N7Hz3u0NXeWzsm4pwDP2Dx1IgSv4OHp/u/qM5EN5g=;
  b=lRulwE8dDqRHEKARh4NTH/D7L+DGbyaeII9/bRfo4609gL9bmZxMEhmy
   bJQW7nGLFipnr5OOlrwuoJFD+QzQ9a5EyftQCVDRmP2jHFySpvYTYSKv3
   JyOgs6OSeALpL8zSROJIzJHt0IDf/klWHl91GEQRADU9f8CO/0uouoErV
   RUia9tJLmzoV2a5XhKZ9KKWIuueto3FkNT4N8iaHqB3cSOXRFuR2qhScq
   iSKVRUyvDXWLZxqIBroJz2UpEiSUYF3CrMTO85Roe5GbV++2z/8wb58PO
   evbFe28tcSeWdgwaAIrFWPg+AYy6v7icxvNDl4XRXon8qPi/6U6Ogx2Xf
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="270551674"
X-IronPort-AV: E=Sophos;i="5.93,223,1654585200"; 
   d="scan'208";a="270551674"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 00:35:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,223,1654585200"; 
   d="scan'208";a="746950407"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 09 Aug 2022 00:35:44 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLJmB-000Mpr-1G;
        Tue, 09 Aug 2022 07:35:43 +0000
Date:   Tue, 9 Aug 2022 15:35:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [bvanassche:scsi-const-host-template 10/11]
 drivers/ata/ahci_platform.c:70:38: warning: passing argument 4 of
 'ahci_platform_init_host' discards 'const' qualifier from pointer target
 type
Message-ID: <202208091542.HqPREzpw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/bvanassche/linux scsi-const-host-template
head:   86b323713ebb1d9a9b2f35df76be3954ba7f1759
commit: 579544e409bc1067fb7a362db251e6061b2ca2b2 [10/11] scsi: Declare most SCSI host templates const
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220809/202208091542.HqPREzpw-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/bvanassche/linux/commit/579544e409bc1067fb7a362db251e6061b2ca2b2
        git remote add bvanassche https://github.com/bvanassche/linux
        git fetch --no-tags bvanassche scsi-const-host-template
        git checkout 579544e409bc1067fb7a362db251e6061b2ca2b2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/ata/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/ata/ahci_platform.c: In function 'ahci_probe':
>> drivers/ata/ahci_platform.c:70:38: warning: passing argument 4 of 'ahci_platform_init_host' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      70 |                                      &ahci_platform_sht);
         |                                      ^~~~~~~~~~~~~~~~~~
   In file included from drivers/ata/ahci_platform.c:18:
   include/linux/ahci_platform.h:35:56: note: expected 'struct scsi_host_template *' but argument is of type 'const struct scsi_host_template *'
      35 |                             struct scsi_host_template *sht);
         |                             ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
--
   drivers/ata/ahci_ceva.c: In function 'ceva_ahci_probe':
>> drivers/ata/ahci_ceva.c:316:41: warning: passing argument 4 of 'ahci_platform_init_host' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     316 |                                         &ahci_platform_sht);
         |                                         ^~~~~~~~~~~~~~~~~~
   In file included from drivers/ata/ahci_ceva.c:9:
   include/linux/ahci_platform.h:35:56: note: expected 'struct scsi_host_template *' but argument is of type 'const struct scsi_host_template *'
      35 |                             struct scsi_host_template *sht);
         |                             ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
--
   drivers/ata/ahci_qoriq.c: In function 'ahci_qoriq_probe':
>> drivers/ata/ahci_qoriq.c:312:38: warning: passing argument 4 of 'ahci_platform_init_host' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     312 |                                      &ahci_qoriq_sht);
         |                                      ^~~~~~~~~~~~~~~
   In file included from drivers/ata/ahci_qoriq.c:13:
   include/linux/ahci_platform.h:35:56: note: expected 'struct scsi_host_template *' but argument is of type 'const struct scsi_host_template *'
      35 |                             struct scsi_host_template *sht);
         |                             ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
--
   drivers/ata/pata_ali.c: In function 'ali_init_one':
>> drivers/ata/pata_ali.c:588:56: warning: passing argument 3 of 'ata_pci_sff_init_one' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     588 |                 return ata_pci_sff_init_one(pdev, ppi, &ali_sht, NULL, 0);
         |                                                        ^~~~~~~~
   In file included from drivers/ata/pata_ali.c:34:
   include/linux/libata.h:1965:44: note: expected 'struct scsi_host_template *' but argument is of type 'const struct scsi_host_template *'
    1965 |                 struct scsi_host_template *sht, void *host_priv, int hflags);
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
>> drivers/ata/pata_ali.c:590:58: warning: passing argument 3 of 'ata_pci_bmdma_init_one' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     590 |                 return ata_pci_bmdma_init_one(pdev, ppi, &ali_sht, NULL, 0);
         |                                                          ^~~~~~~~
   In file included from drivers/ata/pata_ali.c:34:
   include/linux/libata.h:2001:62: note: expected 'struct scsi_host_template *' but argument is of type 'const struct scsi_host_template *'
    2001 |                                   struct scsi_host_template *sht,
         |                                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
--
   drivers/ata/pata_artop.c: In function 'artop_init_one':
>> drivers/ata/pata_artop.c:420:50: warning: passing argument 3 of 'ata_pci_bmdma_init_one' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     420 |         return ata_pci_bmdma_init_one(pdev, ppi, &artop_sht, NULL, 0);
         |                                                  ^~~~~~~~~~
   In file included from drivers/ata/pata_artop.c:27:
   include/linux/libata.h:2001:62: note: expected 'struct scsi_host_template *' but argument is of type 'const struct scsi_host_template *'
    2001 |                                   struct scsi_host_template *sht,
         |                                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
--
   drivers/ata/pata_atiixp.c: In function 'atiixp_init_one':
>> drivers/ata/pata_atiixp.c:288:50: warning: passing argument 3 of 'ata_pci_bmdma_init_one' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     288 |         return ata_pci_bmdma_init_one(pdev, ppi, &atiixp_sht, NULL,
         |                                                  ^~~~~~~~~~~
   In file included from drivers/ata/pata_atiixp.c:22:
   include/linux/libata.h:2001:62: note: expected 'struct scsi_host_template *' but argument is of type 'const struct scsi_host_template *'
    2001 |                                   struct scsi_host_template *sht,
         |                                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
--
   drivers/ata/pata_cmd64x.c: In function 'cmd64x_init_one':
>> drivers/ata/pata_cmd64x.c:488:50: warning: passing argument 3 of 'ata_pci_bmdma_init_one' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     488 |         return ata_pci_bmdma_init_one(pdev, ppi, &cmd64x_sht, NULL, 0);
         |                                                  ^~~~~~~~~~~
   In file included from drivers/ata/pata_cmd64x.c:33:
   include/linux/libata.h:2001:62: note: expected 'struct scsi_host_template *' but argument is of type 'const struct scsi_host_template *'
    2001 |                                   struct scsi_host_template *sht,
         |                                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
--
   drivers/ata/pata_cs5530.c: In function 'cs5530_init_one':
>> drivers/ata/pata_cs5530.c:313:50: warning: passing argument 3 of 'ata_pci_bmdma_init_one' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     313 |         return ata_pci_bmdma_init_one(pdev, ppi, &cs5530_sht, NULL, 0);
         |                                                  ^~~~~~~~~~~
   In file included from drivers/ata/pata_cs5530.c:20:
   include/linux/libata.h:2001:62: note: expected 'struct scsi_host_template *' but argument is of type 'const struct scsi_host_template *'
    2001 |                                   struct scsi_host_template *sht,
         |                                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
--
   drivers/ata/pata_cs5535.c: In function 'cs5535_init_one':
>> drivers/ata/pata_cs5535.c:176:49: warning: passing argument 3 of 'ata_pci_bmdma_init_one' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     176 |         return ata_pci_bmdma_init_one(dev, ppi, &cs5535_sht, NULL, 0);
         |                                                 ^~~~~~~~~~~
   In file included from drivers/ata/pata_cs5535.c:25:
   include/linux/libata.h:2001:62: note: expected 'struct scsi_host_template *' but argument is of type 'const struct scsi_host_template *'
    2001 |                                   struct scsi_host_template *sht,
         |                                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
--
   drivers/ata/pata_cs5536.c: In function 'cs5536_init_one':
>> drivers/ata/pata_cs5536.c:275:49: warning: passing argument 3 of 'ata_pci_bmdma_init_one' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     275 |         return ata_pci_bmdma_init_one(dev, ppi, &cs5536_sht, NULL, 0);
         |                                                 ^~~~~~~~~~~
   In file included from drivers/ata/pata_cs5536.c:26:
   include/linux/libata.h:2001:62: note: expected 'struct scsi_host_template *' but argument is of type 'const struct scsi_host_template *'
    2001 |                                   struct scsi_host_template *sht,
         |                                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
--
   drivers/ata/pata_cypress.c: In function 'cy82c693_init_one':
>> drivers/ata/pata_cypress.c:147:50: warning: passing argument 3 of 'ata_pci_bmdma_init_one' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     147 |         return ata_pci_bmdma_init_one(pdev, ppi, &cy82c693_sht, NULL, 0);
         |                                                  ^~~~~~~~~~~~~
   In file included from drivers/ata/pata_cypress.c:18:
   include/linux/libata.h:2001:62: note: expected 'struct scsi_host_template *' but argument is of type 'const struct scsi_host_template *'
    2001 |                                   struct scsi_host_template *sht,
         |                                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
..


vim +70 drivers/ata/ahci_platform.c

018d5ef2048fca Akinobu Mita              2015-01-29  42  
23b07d4cb3c0c8 Hans de Goede             2014-02-22  43  static int ahci_probe(struct platform_device *pdev)
23b07d4cb3c0c8 Hans de Goede             2014-02-22  44  {
23b07d4cb3c0c8 Hans de Goede             2014-02-22  45  	struct device *dev = &pdev->dev;
23b07d4cb3c0c8 Hans de Goede             2014-02-22  46  	struct ahci_host_priv *hpriv;
20bdc376b427cb Suman Tripathi            2018-09-07  47  	const struct ata_port_info *port;
23b07d4cb3c0c8 Hans de Goede             2014-02-22  48  	int rc;
23b07d4cb3c0c8 Hans de Goede             2014-02-22  49  
2d17f460c5d79f Kunihiko Hayashi          2018-08-22  50  	hpriv = ahci_platform_get_resources(pdev,
2d17f460c5d79f Kunihiko Hayashi          2018-08-22  51  					    AHCI_PLATFORM_GET_RESETS);
23b07d4cb3c0c8 Hans de Goede             2014-02-22  52  	if (IS_ERR(hpriv))
23b07d4cb3c0c8 Hans de Goede             2014-02-22  53  		return PTR_ERR(hpriv);
23b07d4cb3c0c8 Hans de Goede             2014-02-22  54  
23b07d4cb3c0c8 Hans de Goede             2014-02-22  55  	rc = ahci_platform_enable_resources(hpriv);
23b07d4cb3c0c8 Hans de Goede             2014-02-22  56  	if (rc)
23b07d4cb3c0c8 Hans de Goede             2014-02-22  57  		return rc;
23b07d4cb3c0c8 Hans de Goede             2014-02-22  58  
17dcc37e3e847b Srinivas Kandagatla       2016-04-01  59  	of_property_read_u32(dev->of_node,
17dcc37e3e847b Srinivas Kandagatla       2016-04-01  60  			     "ports-implemented", &hpriv->force_port_map);
17dcc37e3e847b Srinivas Kandagatla       2016-04-01  61  
a1a205df6ee224 Kefeng Wang               2014-05-14  62  	if (of_device_is_compatible(dev->of_node, "hisilicon,hisi-ahci"))
725c7b570fda42 Antoine Tenart            2014-07-30  63  		hpriv->flags |= AHCI_HFLAG_NO_FBS | AHCI_HFLAG_NO_NCQ;
a1a205df6ee224 Kefeng Wang               2014-05-14  64  
20bdc376b427cb Suman Tripathi            2018-09-07  65  	port = acpi_device_get_match_data(dev);
20bdc376b427cb Suman Tripathi            2018-09-07  66  	if (!port)
20bdc376b427cb Suman Tripathi            2018-09-07  67  		port = &ahci_port_info;
20bdc376b427cb Suman Tripathi            2018-09-07  68  
20bdc376b427cb Suman Tripathi            2018-09-07  69  	rc = ahci_platform_init_host(pdev, hpriv, port,
018d5ef2048fca Akinobu Mita              2015-01-29 @70  				     &ahci_platform_sht);
1c2a49f61785eb Anton Vorontsov           2010-03-04  71  	if (rc)
515d9b2c03943c Bartlomiej Zolnierkiewicz 2014-08-12  72  		goto disable_resources;
1c2a49f61785eb Anton Vorontsov           2010-03-04  73  
1c2a49f61785eb Anton Vorontsov           2010-03-04  74  	return 0;
96a01ba52c60fd Hans de Goede             2014-02-22  75  disable_resources:
96a01ba52c60fd Hans de Goede             2014-02-22  76  	ahci_platform_disable_resources(hpriv);
1c2a49f61785eb Anton Vorontsov           2010-03-04  77  	return rc;
1c2a49f61785eb Anton Vorontsov           2010-03-04  78  }
1c2a49f61785eb Anton Vorontsov           2010-03-04  79  

:::::: The code at line 70 was first introduced by commit
:::::: 018d5ef2048fcab339467bcbebccf588c9bd2531 ata: ahci_platform: fix owner module reference mismatch for scsi host

:::::: TO: Akinobu Mita <akinobu.mita@gmail.com>
:::::: CC: Tejun Heo <tj@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
