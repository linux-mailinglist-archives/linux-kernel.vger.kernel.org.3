Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A31F591B68
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 17:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239771AbiHMPc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 11:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239675AbiHMPcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 11:32:25 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132B81EC45
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 08:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660404744; x=1691940744;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=v8iAzPZKVm8YyLTFPNZdYdxY3uj1CLNh49Qrsm7poEQ=;
  b=kZwImv006lcnEB57FTM74LdQmF12kQCZTyNkQoXhTwncOx6s4DElMlgR
   2Tv33Xj0DCG80EvWU5IWmLw0LXryWU1FvlrZtZPOx6PybDgxeCHUkXaWG
   Z2ZjY7/PNKopDJ2oxfTJ+6DEAuo0mlLDkHTCHznCmG5HMskWBnwwV69B6
   17AEQgbNEf1n5iTjeD6jBnqQV6KA2/EsbRPrZ5XAvOKjKFJ3jaCSGkOpg
   7jedKQrec4RxAg3Dlnrz8EfdQUlwCkXRnz2LRjsc2ertnYxhcpHVYacf3
   /ozvD9S2jP/zutFKsX2LLsV8GPDRtDPSQEri1lHPonoRX1+ulqfLXsasL
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="291759279"
X-IronPort-AV: E=Sophos;i="5.93,235,1654585200"; 
   d="scan'208";a="291759279"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 08:32:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,235,1654585200"; 
   d="scan'208";a="606215747"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 13 Aug 2022 08:32:22 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMt7d-0001oU-1A;
        Sat, 13 Aug 2022 15:32:21 +0000
Date:   Sat, 13 Aug 2022 23:31:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [bvanassche:scsi-const-host-template 11/86]
 drivers/ata/pata_platform.c:97:5: error: conflicting types for
 '__pata_platform_probe'
Message-ID: <202208132333.QdRbhHNh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/bvanassche/linux scsi-const-host-template
head:   6d6e5cf2f6e93f909e73e468fd5888431de61f13
commit: 24ce874bd15b6e1e45942c02db623e7e19b6cc81 [11/86] ata
config: i386-randconfig-a002 (https://download.01.org/0day-ci/archive/20220813/202208132333.QdRbhHNh-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 3329cec2f79185bafd678f310fafadba2a8c76d2)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/bvanassche/linux/commit/24ce874bd15b6e1e45942c02db623e7e19b6cc81
        git remote add bvanassche https://github.com/bvanassche/linux
        git fetch --no-tags bvanassche scsi-const-host-template
        git checkout 24ce874bd15b6e1e45942c02db623e7e19b6cc81
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/ata/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/ata/pata_platform.c:97:5: error: conflicting types for '__pata_platform_probe'
   int __pata_platform_probe(struct device *dev, struct resource *io_res,
       ^
   include/linux/ata_platform.h:16:12: note: previous declaration is here
   extern int __pata_platform_probe(struct device *dev,
              ^
   drivers/ata/pata_platform.c:221:20: error: passing 'const struct scsi_host_template *' to parameter of type 'struct scsi_host_template *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
                                        pio_mask, &pata_platform_sht, false);
                                                  ^~~~~~~~~~~~~~~~~~
   include/linux/ata_platform.h:22:33: note: passing argument to parameter 'sht' here
                                    struct scsi_host_template *sht,
                                                               ^
   2 errors generated.


vim +/__pata_platform_probe +97 drivers/ata/pata_platform.c

a20c9e820864e1 Paul Mundt         2006-10-27   67  
a20c9e820864e1 Paul Mundt         2006-10-27   68  /**
cf03613e9662c2 Anton Vorontsov    2008-01-09   69   *	__pata_platform_probe		-	attach a platform interface
cf03613e9662c2 Anton Vorontsov    2008-01-09   70   *	@dev: device
cf03613e9662c2 Anton Vorontsov    2008-01-09   71   *	@io_res: Resource representing I/O base
cf03613e9662c2 Anton Vorontsov    2008-01-09   72   *	@ctl_res: Resource representing CTL base
cf03613e9662c2 Anton Vorontsov    2008-01-09   73   *	@irq_res: Resource representing IRQ and its flags
cf03613e9662c2 Anton Vorontsov    2008-01-09   74   *	@ioport_shift: I/O port shift
cf03613e9662c2 Anton Vorontsov    2008-01-09   75   *	@__pio_mask: PIO mask
17263905399471 Akinobu Mita       2015-01-29   76   *	@sht: scsi_host_template to use when registering
f3d5e4f18dba18 Alexander Shiyan   2019-01-19   77   *	@use16bit: Flag to indicate 16-bit IO instead of 32-bit
a20c9e820864e1 Paul Mundt         2006-10-27   78   *
a20c9e820864e1 Paul Mundt         2006-10-27   79   *	Register a platform bus IDE interface. Such interfaces are PIO and we
a20c9e820864e1 Paul Mundt         2006-10-27   80   *	assume do not support IRQ sharing.
a20c9e820864e1 Paul Mundt         2006-10-27   81   *
f7fc0ceb4d72ea Paul Mundt         2007-11-08   82   *	Platform devices are expected to contain at least 2 resources per port:
a20c9e820864e1 Paul Mundt         2006-10-27   83   *
a20c9e820864e1 Paul Mundt         2006-10-27   84   *		- I/O Base (IORESOURCE_IO or IORESOURCE_MEM)
a20c9e820864e1 Paul Mundt         2006-10-27   85   *		- CTL Base (IORESOURCE_IO or IORESOURCE_MEM)
f7fc0ceb4d72ea Paul Mundt         2007-11-08   86   *
f7fc0ceb4d72ea Paul Mundt         2007-11-08   87   *	and optionally:
f7fc0ceb4d72ea Paul Mundt         2007-11-08   88   *
a20c9e820864e1 Paul Mundt         2006-10-27   89   *		- IRQ	   (IORESOURCE_IRQ)
a20c9e820864e1 Paul Mundt         2006-10-27   90   *
a20c9e820864e1 Paul Mundt         2006-10-27   91   *	If the base resources are both mem types, the ioremap() is handled
a20c9e820864e1 Paul Mundt         2006-10-27   92   *	here. For IORESOURCE_IO, it's assumed that there's no remapping
a20c9e820864e1 Paul Mundt         2006-10-27   93   *	necessary.
f7fc0ceb4d72ea Paul Mundt         2007-11-08   94   *
f7fc0ceb4d72ea Paul Mundt         2007-11-08   95   *	If no IRQ resource is present, PIO polling mode is used instead.
a20c9e820864e1 Paul Mundt         2006-10-27   96   */
0ec24914675c48 Greg Kroah-Hartman 2012-12-21  @97  int __pata_platform_probe(struct device *dev, struct resource *io_res,
0ec24914675c48 Greg Kroah-Hartman 2012-12-21   98  			  struct resource *ctl_res, struct resource *irq_res,
17263905399471 Akinobu Mita       2015-01-29   99  			  unsigned int ioport_shift, int __pio_mask,
24ce874bd15b6e Bart Van Assche    2022-08-09  100  			  const struct scsi_host_template *sht, bool use16bit)
a20c9e820864e1 Paul Mundt         2006-10-27  101  {
5d728824efeda6 Tejun Heo          2007-04-17  102  	struct ata_host *host;
5d728824efeda6 Tejun Heo          2007-04-17  103  	struct ata_port *ap;
a20c9e820864e1 Paul Mundt         2006-10-27  104  	unsigned int mmio;
cf03613e9662c2 Anton Vorontsov    2008-01-09  105  	int irq = 0;
cf03613e9662c2 Anton Vorontsov    2008-01-09  106  	int irq_flags = 0;
a20c9e820864e1 Paul Mundt         2006-10-27  107  
a20c9e820864e1 Paul Mundt         2006-10-27  108  	/*
a20c9e820864e1 Paul Mundt         2006-10-27  109  	 * Check for MMIO
a20c9e820864e1 Paul Mundt         2006-10-27  110  	 */
a20c9e820864e1 Paul Mundt         2006-10-27  111  	mmio = (( io_res->flags == IORESOURCE_MEM) &&
a20c9e820864e1 Paul Mundt         2006-10-27  112  		(ctl_res->flags == IORESOURCE_MEM));
a20c9e820864e1 Paul Mundt         2006-10-27  113  
f7fc0ceb4d72ea Paul Mundt         2007-11-08  114  	/*
f7fc0ceb4d72ea Paul Mundt         2007-11-08  115  	 * And the IRQ
f7fc0ceb4d72ea Paul Mundt         2007-11-08  116  	 */
cf03613e9662c2 Anton Vorontsov    2008-01-09  117  	if (irq_res && irq_res->start > 0) {
cf03613e9662c2 Anton Vorontsov    2008-01-09  118  		irq = irq_res->start;
baac9ce1f33326 Alexander Shiyan   2019-01-19  119  		irq_flags = (irq_res->flags & IRQF_TRIGGER_MASK) | IRQF_SHARED;
cf03613e9662c2 Anton Vorontsov    2008-01-09  120  	}
f7fc0ceb4d72ea Paul Mundt         2007-11-08  121  
a20c9e820864e1 Paul Mundt         2006-10-27  122  	/*
a20c9e820864e1 Paul Mundt         2006-10-27  123  	 * Now that that's out of the way, wire up the port..
a20c9e820864e1 Paul Mundt         2006-10-27  124  	 */
cf03613e9662c2 Anton Vorontsov    2008-01-09  125  	host = ata_host_alloc(dev, 1);
5d728824efeda6 Tejun Heo          2007-04-17  126  	if (!host)
5d728824efeda6 Tejun Heo          2007-04-17  127  		return -ENOMEM;
5d728824efeda6 Tejun Heo          2007-04-17  128  	ap = host->ports[0];
5d728824efeda6 Tejun Heo          2007-04-17  129  
f3d5e4f18dba18 Alexander Shiyan   2019-01-19  130  	ap->ops = devm_kzalloc(dev, sizeof(*ap->ops), GFP_KERNEL);
9b6d90e2085ca2 Zhou Qingyang      2022-01-25  131  	if (!ap->ops)
9b6d90e2085ca2 Zhou Qingyang      2022-01-25  132  		return -ENOMEM;
f3d5e4f18dba18 Alexander Shiyan   2019-01-19  133  	ap->ops->inherits = &ata_sff_port_ops;
f3d5e4f18dba18 Alexander Shiyan   2019-01-19  134  	ap->ops->cable_detect = ata_cable_unknown;
f3d5e4f18dba18 Alexander Shiyan   2019-01-19  135  	ap->ops->set_mode = pata_platform_set_mode;
f3d5e4f18dba18 Alexander Shiyan   2019-01-19  136  	if (use16bit)
f3d5e4f18dba18 Alexander Shiyan   2019-01-19  137  		ap->ops->sff_data_xfer = ata_sff_data_xfer;
f3d5e4f18dba18 Alexander Shiyan   2019-01-19  138  	else
f3d5e4f18dba18 Alexander Shiyan   2019-01-19  139  		ap->ops->sff_data_xfer = ata_sff_data_xfer32;
f3d5e4f18dba18 Alexander Shiyan   2019-01-19  140  
cf03613e9662c2 Anton Vorontsov    2008-01-09  141  	ap->pio_mask = __pio_mask;
5d728824efeda6 Tejun Heo          2007-04-17  142  	ap->flags |= ATA_FLAG_SLAVE_POSS;
a20c9e820864e1 Paul Mundt         2006-10-27  143  
f7fc0ceb4d72ea Paul Mundt         2007-11-08  144  	/*
f7fc0ceb4d72ea Paul Mundt         2007-11-08  145  	 * Use polling mode if there's no IRQ
f7fc0ceb4d72ea Paul Mundt         2007-11-08  146  	 */
f7fc0ceb4d72ea Paul Mundt         2007-11-08  147  	if (!irq) {
f7fc0ceb4d72ea Paul Mundt         2007-11-08  148  		ap->flags |= ATA_FLAG_PIO_POLLING;
f7fc0ceb4d72ea Paul Mundt         2007-11-08  149  		ata_port_desc(ap, "no IRQ, using PIO polling");
f7fc0ceb4d72ea Paul Mundt         2007-11-08  150  	}
f7fc0ceb4d72ea Paul Mundt         2007-11-08  151  
a20c9e820864e1 Paul Mundt         2006-10-27  152  	/*
a20c9e820864e1 Paul Mundt         2006-10-27  153  	 * Handle the MMIO case
a20c9e820864e1 Paul Mundt         2006-10-27  154  	 */
a20c9e820864e1 Paul Mundt         2006-10-27  155  	if (mmio) {
cf03613e9662c2 Anton Vorontsov    2008-01-09  156  		ap->ioaddr.cmd_addr = devm_ioremap(dev, io_res->start,
041b5eac254107 Julia Lawall       2009-08-06  157  				resource_size(io_res));
cf03613e9662c2 Anton Vorontsov    2008-01-09  158  		ap->ioaddr.ctl_addr = devm_ioremap(dev, ctl_res->start,
041b5eac254107 Julia Lawall       2009-08-06  159  				resource_size(ctl_res));
a20c9e820864e1 Paul Mundt         2006-10-27  160  	} else {
cf03613e9662c2 Anton Vorontsov    2008-01-09  161  		ap->ioaddr.cmd_addr = devm_ioport_map(dev, io_res->start,
041b5eac254107 Julia Lawall       2009-08-06  162  				resource_size(io_res));
cf03613e9662c2 Anton Vorontsov    2008-01-09  163  		ap->ioaddr.ctl_addr = devm_ioport_map(dev, ctl_res->start,
041b5eac254107 Julia Lawall       2009-08-06  164  				resource_size(ctl_res));
0d5ff566779f89 Tejun Heo          2007-02-01  165  	}
5d728824efeda6 Tejun Heo          2007-04-17  166  	if (!ap->ioaddr.cmd_addr || !ap->ioaddr.ctl_addr) {
cf03613e9662c2 Anton Vorontsov    2008-01-09  167  		dev_err(dev, "failed to map IO/CTL base\n");
0d5ff566779f89 Tejun Heo          2007-02-01  168  		return -ENOMEM;
a20c9e820864e1 Paul Mundt         2006-10-27  169  	}
a20c9e820864e1 Paul Mundt         2006-10-27  170  
5d728824efeda6 Tejun Heo          2007-04-17  171  	ap->ioaddr.altstatus_addr = ap->ioaddr.ctl_addr;
a20c9e820864e1 Paul Mundt         2006-10-27  172  
cf03613e9662c2 Anton Vorontsov    2008-01-09  173  	pata_platform_setup_port(&ap->ioaddr, ioport_shift);
a20c9e820864e1 Paul Mundt         2006-10-27  174  
cbcdd87593a1d8 Tejun Heo          2007-08-18  175  	ata_port_desc(ap, "%s cmd 0x%llx ctl 0x%llx", mmio ? "mmio" : "ioport",
cbcdd87593a1d8 Tejun Heo          2007-08-18  176  		      (unsigned long long)io_res->start,
cbcdd87593a1d8 Tejun Heo          2007-08-18  177  		      (unsigned long long)ctl_res->start);
cbcdd87593a1d8 Tejun Heo          2007-08-18  178  
5d728824efeda6 Tejun Heo          2007-04-17  179  	/* activate */
9363c3825ea9ad Tejun Heo          2008-04-07  180  	return ata_host_activate(host, irq, irq ? ata_sff_interrupt : NULL,
17263905399471 Akinobu Mita       2015-01-29  181  				 irq_flags, sht);
a20c9e820864e1 Paul Mundt         2006-10-27  182  }
cf03613e9662c2 Anton Vorontsov    2008-01-09  183  EXPORT_SYMBOL_GPL(__pata_platform_probe);
a20c9e820864e1 Paul Mundt         2006-10-27  184  

:::::: The code at line 97 was first introduced by commit
:::::: 0ec24914675c48213378da550db494bf154f0f6c Drivers: ata: remove __dev* attributes.

:::::: TO: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
