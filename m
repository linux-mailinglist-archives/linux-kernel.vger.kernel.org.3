Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7B4591DAA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 05:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiHNDFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 23:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiHNDFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 23:05:45 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9061B13F03
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 20:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660446343; x=1691982343;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nNoiqNJZNdLT/U6b7ZbDHyvXfHsiz0TYG40CuGouwcU=;
  b=Ibzg2aFVz4k6tdPuT3+qohOpvQgBFtg9HG7ET1dTcZhDZ0FHad1m2aa9
   MAuQ1qO3ITPoFmzzWivh/Ihqx88krYmZAECJm1W/aNWYlB11R/8KHriW6
   xZxOJpNyab1BZyn7jDqrZhktjigcBiG7pYJGBmsechDH4N5/j3R3vJR5c
   ZyoRWOMwNwYzfU77eyswj4LkZ/+nDuonPXMIEcfhZ1QZY5b3o6iQV2dOi
   LfXy+lRCaOpE+0pkckgk12dUGFs+gSZ/qO1ET9FbyvHSvZJyM87koS6Da
   yOst/JcCV9bvi58U1UKzRiSPSxGbx9XDEa3iA6613OFSQguQE6r0/v1tf
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="272186551"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="272186551"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 20:05:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="732599022"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 13 Aug 2022 20:05:40 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oN3wZ-0002QB-2o;
        Sun, 14 Aug 2022 03:05:39 +0000
Date:   Sun, 14 Aug 2022 11:05:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     kbuild-all@lists.01.org, linux-ntb@googlegroups.com,
        linux-kernel@vger.kernel.org, Jon Mason <jdmason@kudzu.us>
Subject: [jonmason-ntb:ntb-next-hacking 18/18]
 drivers/pci/endpoint/functions/pci-epf-vntb.c:541:40: warning: variable
 'epc_features' set but not used
Message-ID: <202208141103.CnuY3Xvp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jonmason/ntb ntb-next-hacking
head:   d90921d21692b59734d2452efea346217a526f44
commit: d90921d21692b59734d2452efea346217a526f44 [18/18] pcie: endpoint: pci-epf-vntb: add endpoint msi support
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220814/202208141103.CnuY3Xvp-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/jonmason/ntb/commit/d90921d21692b59734d2452efea346217a526f44
        git remote add jonmason-ntb https://github.com/jonmason/ntb
        git fetch --no-tags jonmason-ntb ntb-next-hacking
        git checkout d90921d21692b59734d2452efea346217a526f44
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/pci/endpoint/functions/ fs/notify/fanotify/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/pci/endpoint/functions/pci-epf-vntb.c: In function 'epf_ntb_db_bar_init':
>> drivers/pci/endpoint/functions/pci-epf-vntb.c:541:40: warning: variable 'epc_features' set but not used [-Wunused-but-set-variable]
     541 |         const struct pci_epc_features *epc_features;
         |                                        ^~~~~~~~~~~~


vim +/epc_features +541 drivers/pci/endpoint/functions/pci-epf-vntb.c

d90921d21692b59 Frank Li 2022-07-07  534  
53efbaa43643f36 Frank Li 2022-02-22  535  /**
53efbaa43643f36 Frank Li 2022-02-22  536   * epf_ntb_db_bar_init() - Configure Doorbell window BARs
53efbaa43643f36 Frank Li 2022-02-22  537   * @ntb: NTB device that facilitates communication between HOST and vHOST
53efbaa43643f36 Frank Li 2022-02-22  538   */
53efbaa43643f36 Frank Li 2022-02-22  539  static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
53efbaa43643f36 Frank Li 2022-02-22  540  {
53efbaa43643f36 Frank Li 2022-02-22 @541  	const struct pci_epc_features *epc_features;
53efbaa43643f36 Frank Li 2022-02-22  542  	u32 align;
53efbaa43643f36 Frank Li 2022-02-22  543  	struct device *dev = &ntb->epf->dev;
53efbaa43643f36 Frank Li 2022-02-22  544  	int ret;
53efbaa43643f36 Frank Li 2022-02-22  545  	struct pci_epf_bar *epf_bar;
d90921d21692b59 Frank Li 2022-07-07  546  	void __iomem *mw_addr = NULL;
53efbaa43643f36 Frank Li 2022-02-22  547  	enum pci_barno barno;
d90921d21692b59 Frank Li 2022-07-07  548  	size_t size;
53efbaa43643f36 Frank Li 2022-02-22  549  
53efbaa43643f36 Frank Li 2022-02-22  550  	epc_features = pci_epc_get_features(ntb->epf->epc,
53efbaa43643f36 Frank Li 2022-02-22  551  					    ntb->epf->func_no,
53efbaa43643f36 Frank Li 2022-02-22  552  					    ntb->epf->vfunc_no);
53efbaa43643f36 Frank Li 2022-02-22  553  
d90921d21692b59 Frank Li 2022-07-07  554  	size = epf_ntb_db_size(ntb);
53efbaa43643f36 Frank Li 2022-02-22  555  
53efbaa43643f36 Frank Li 2022-02-22  556  	barno = ntb->epf_ntb_bar[BAR_DB];
d90921d21692b59 Frank Li 2022-07-07  557  	epf_bar = &ntb->epf->bar[barno];
53efbaa43643f36 Frank Li 2022-02-22  558  
d90921d21692b59 Frank Li 2022-07-07  559  	if (!ntb->epf_db_phy) {
53efbaa43643f36 Frank Li 2022-02-22  560  		mw_addr = pci_epf_alloc_space(ntb->epf, size, barno, align, 0);
53efbaa43643f36 Frank Li 2022-02-22  561  		if (!mw_addr) {
53efbaa43643f36 Frank Li 2022-02-22  562  			dev_err(dev, "Failed to allocate OB address\n");
53efbaa43643f36 Frank Li 2022-02-22  563  			return -ENOMEM;
53efbaa43643f36 Frank Li 2022-02-22  564  		}
d90921d21692b59 Frank Li 2022-07-07  565  	} else {
d90921d21692b59 Frank Li 2022-07-07  566  		epf_bar->phys_addr = ntb->epf_db_phy;
d90921d21692b59 Frank Li 2022-07-07  567  		epf_bar->barno = barno;
d90921d21692b59 Frank Li 2022-07-07  568  		epf_bar->size = size;
d90921d21692b59 Frank Li 2022-07-07  569  	}
53efbaa43643f36 Frank Li 2022-02-22  570  
53efbaa43643f36 Frank Li 2022-02-22  571  	ntb->epf_db = mw_addr;
53efbaa43643f36 Frank Li 2022-02-22  572  
53efbaa43643f36 Frank Li 2022-02-22  573  	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no, epf_bar);
53efbaa43643f36 Frank Li 2022-02-22  574  	if (ret) {
53efbaa43643f36 Frank Li 2022-02-22  575  		dev_err(dev, "Doorbell BAR set failed\n");
53efbaa43643f36 Frank Li 2022-02-22  576  			goto err_alloc_peer_mem;
53efbaa43643f36 Frank Li 2022-02-22  577  	}
53efbaa43643f36 Frank Li 2022-02-22  578  	return ret;
53efbaa43643f36 Frank Li 2022-02-22  579  
53efbaa43643f36 Frank Li 2022-02-22  580  err_alloc_peer_mem:
53efbaa43643f36 Frank Li 2022-02-22  581  	pci_epc_mem_free_addr(ntb->epf->epc, epf_bar->phys_addr, mw_addr, epf_bar->size);
53efbaa43643f36 Frank Li 2022-02-22  582  	return -1;
53efbaa43643f36 Frank Li 2022-02-22  583  }
53efbaa43643f36 Frank Li 2022-02-22  584  

:::::: The code at line 541 was first introduced by commit
:::::: 53efbaa43643f36d203700e7f436eaac11695274 PCI: endpoint: Support NTB transfer between RC and EP

:::::: TO: Frank Li <Frank.Li@nxp.com>
:::::: CC: Jon Mason <jdmason@kudzu.us>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
