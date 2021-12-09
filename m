Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B009D46E0E1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 03:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbhLICep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 21:34:45 -0500
Received: from mga06.intel.com ([134.134.136.31]:11391 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229909AbhLICeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 21:34:44 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="298791643"
X-IronPort-AV: E=Sophos;i="5.88,191,1635231600"; 
   d="scan'208";a="298791643"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 18:31:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,191,1635231600"; 
   d="scan'208";a="480167333"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 08 Dec 2021 18:31:03 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mv9D4-0001Le-RN; Thu, 09 Dec 2021 02:31:02 +0000
Date:   Thu, 9 Dec 2021 10:31:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [hare-scsi-devel:ata-trace.v3 13/73]
 drivers/ata/sata_dwc_460ex.c:744:26: error: implicit declaration of function
 'get_dma_dir_descript'; did you mean 'get_prot_descript'?
Message-ID: <202112091014.OAV9O2tr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git ata-trace.v3
head:   d973dee7af0328b9176e4a1710fb73093c334698
commit: a8252508eadb132c62be4596a50701e1f261e92d [13/73] sata_dwc_460ex: use generic tracepoints
config: arm-buildonly-randconfig-r005-20211207 (https://download.01.org/0day-ci/archive/20211209/202112091014.OAV9O2tr-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git/commit/?id=a8252508eadb132c62be4596a50701e1f261e92d
        git remote add hare-scsi-devel https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git
        git fetch --no-tags hare-scsi-devel ata-trace.v3
        git checkout a8252508eadb132c62be4596a50701e1f261e92d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash drivers/ata/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from drivers/ata/sata_dwc_460ex.c:28:
   drivers/ata/sata_dwc_460ex.c: In function 'sata_dwc_dma_xfer_complete':
>> drivers/ata/sata_dwc_460ex.c:744:26: error: implicit declaration of function 'get_dma_dir_descript'; did you mean 'get_prot_descript'? [-Werror=implicit-function-declaration]
     744 |                          get_dma_dir_descript(qc->dma_dir),
         |                          ^~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:37: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                                     ^~~~~~~~~~~
   drivers/ata/sata_dwc_460ex.c:741:17: note: in expansion of macro 'dev_info'
     741 |                 dev_info(ap->dev,
         |                 ^~~~~~~~
>> drivers/ata/sata_dwc_460ex.c:742:26: warning: format '%s' expects argument of type 'char *', but argument 6 has type 'int' [-Wformat=]
     742 |                          "%s tag=%u cmd=0x%02x dma dir=%s proto=%s dmacr=0x%08x\n",
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:150:58: note: in expansion of macro 'dev_fmt'
     150 |         dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                          ^~~~~~~
   drivers/ata/sata_dwc_460ex.c:741:17: note: in expansion of macro 'dev_info'
     741 |                 dev_info(ap->dev,
         |                 ^~~~~~~~
   drivers/ata/sata_dwc_460ex.c:742:57: note: format string is defined here
     742 |                          "%s tag=%u cmd=0x%02x dma dir=%s proto=%s dmacr=0x%08x\n",
         |                                                        ~^
         |                                                         |
         |                                                         char *
         |                                                        %d
   cc1: some warnings being treated as errors


vim +744 drivers/ata/sata_dwc_460ex.c

62936009f35a665 Rupjyoti Sarmah 2010-07-06  724  
62936009f35a665 Rupjyoti Sarmah 2010-07-06  725  static void sata_dwc_dma_xfer_complete(struct ata_port *ap, u32 check_status)
62936009f35a665 Rupjyoti Sarmah 2010-07-06  726  {
62936009f35a665 Rupjyoti Sarmah 2010-07-06  727  	struct ata_queued_cmd *qc;
62936009f35a665 Rupjyoti Sarmah 2010-07-06  728  	struct sata_dwc_device_port *hsdevp = HSDEVP_FROM_AP(ap);
62936009f35a665 Rupjyoti Sarmah 2010-07-06  729  	struct sata_dwc_device *hsdev = HSDEV_FROM_AP(ap);
62936009f35a665 Rupjyoti Sarmah 2010-07-06  730  	u8 tag = 0;
62936009f35a665 Rupjyoti Sarmah 2010-07-06  731  
62936009f35a665 Rupjyoti Sarmah 2010-07-06  732  	tag = ap->link.active_tag;
62936009f35a665 Rupjyoti Sarmah 2010-07-06  733  	qc = ata_qc_from_tag(ap, tag);
62936009f35a665 Rupjyoti Sarmah 2010-07-06  734  	if (!qc) {
62936009f35a665 Rupjyoti Sarmah 2010-07-06  735  		dev_err(ap->dev, "failed to get qc");
62936009f35a665 Rupjyoti Sarmah 2010-07-06  736  		return;
62936009f35a665 Rupjyoti Sarmah 2010-07-06  737  	}
62936009f35a665 Rupjyoti Sarmah 2010-07-06  738  
62936009f35a665 Rupjyoti Sarmah 2010-07-06  739  #ifdef DEBUG_NCQ
62936009f35a665 Rupjyoti Sarmah 2010-07-06  740  	if (tag > 0) {
d578514b271e7c8 Andy Shevchenko 2015-03-03  741  		dev_info(ap->dev,
d578514b271e7c8 Andy Shevchenko 2015-03-03 @742  			 "%s tag=%u cmd=0x%02x dma dir=%s proto=%s dmacr=0x%08x\n",
4e5b6260cc9ba84 Jens Axboe      2018-05-11  743  			 __func__, qc->hw_tag, qc->tf.command,
84b47e3b16f8a5b Sergei Shtylyov 2011-01-28 @744  			 get_dma_dir_descript(qc->dma_dir),
84b47e3b16f8a5b Sergei Shtylyov 2011-01-28  745  			 get_prot_descript(qc->tf.protocol),
ee81d6cc8e8aa66 Mans Rullgard   2016-04-26  746  			 sata_dwc_readl(&hsdev->sata_dwc_regs->dmacr));
62936009f35a665 Rupjyoti Sarmah 2010-07-06  747  	}
62936009f35a665 Rupjyoti Sarmah 2010-07-06  748  #endif
62936009f35a665 Rupjyoti Sarmah 2010-07-06  749  
62936009f35a665 Rupjyoti Sarmah 2010-07-06  750  	if (ata_is_dma(qc->tf.protocol)) {
62936009f35a665 Rupjyoti Sarmah 2010-07-06  751  		if (hsdevp->dma_pending[tag] == SATA_DWC_DMA_PENDING_NONE) {
d578514b271e7c8 Andy Shevchenko 2015-03-03  752  			dev_err(ap->dev,
d578514b271e7c8 Andy Shevchenko 2015-03-03  753  				"%s DMA protocol RX and TX DMA not pending dmacr: 0x%08x\n",
d578514b271e7c8 Andy Shevchenko 2015-03-03  754  				__func__,
ee81d6cc8e8aa66 Mans Rullgard   2016-04-26  755  				sata_dwc_readl(&hsdev->sata_dwc_regs->dmacr));
62936009f35a665 Rupjyoti Sarmah 2010-07-06  756  		}
62936009f35a665 Rupjyoti Sarmah 2010-07-06  757  
62936009f35a665 Rupjyoti Sarmah 2010-07-06  758  		hsdevp->dma_pending[tag] = SATA_DWC_DMA_PENDING_NONE;
62936009f35a665 Rupjyoti Sarmah 2010-07-06  759  		sata_dwc_qc_complete(ap, qc, check_status);
62936009f35a665 Rupjyoti Sarmah 2010-07-06  760  		ap->link.active_tag = ATA_TAG_POISON;
62936009f35a665 Rupjyoti Sarmah 2010-07-06  761  	} else {
62936009f35a665 Rupjyoti Sarmah 2010-07-06  762  		sata_dwc_qc_complete(ap, qc, check_status);
62936009f35a665 Rupjyoti Sarmah 2010-07-06  763  	}
62936009f35a665 Rupjyoti Sarmah 2010-07-06  764  }
62936009f35a665 Rupjyoti Sarmah 2010-07-06  765  

:::::: The code at line 744 was first introduced by commit
:::::: 84b47e3b16f8a5bb416cd55774d679ebbdb19072 sata_dwc_460ex: fix misuse of ata_get_cmd_descript()

:::::: TO: Sergei Shtylyov <sshtylyov@ru.mvista.com>
:::::: CC: Jeff Garzik <jgarzik@redhat.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
