Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABE0591D92
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 04:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiHNCOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 22:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiHNCOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 22:14:41 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BBC6E2CC
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 19:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660443280; x=1691979280;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mL6DQCPNrGBktb6a8EQDWXZrefD9kYqagtdkBoIfQz0=;
  b=VWxbFYpar9YVfC5i1lxbkxxZy1ZAxphueSmRMtgnrezzn7lCPMBmUofR
   Cdw0swJciwa9/GiPIz59uvsmYWCaceB6sMCHK9sKreVASPYf++k7FFz9w
   raY4buHNQMOFhLlC++b2mnOxOUmOHLbkX6arP3MdnuOhWwrQAtaCsw2iJ
   UJHYRfi+EkNLlP0sK0+qR/VVmgYP43bkIVSI5MXOg11ycVJJa4+QQvdSa
   J15iURxxZSsdKQu9LdqYwUzA7E0QWWiaaRfzDlHP5mpqssALYN+hev+zG
   hJpAJIlG7WT9epxBZTkBSsXWe3J8uZCEjHdmuGExpgVrVa5Vw2LnaA9pA
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="292586294"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="292586294"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 19:14:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="674473096"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 13 Aug 2022 19:14:38 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oN39B-0002Ln-2o;
        Sun, 14 Aug 2022 02:14:37 +0000
Date:   Sun, 14 Aug 2022 10:14:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
        Jon Mason <jdmason@kudzu.us>
Subject: [jonmason-ntb:ntb-next-hacking 18/18]
 drivers/pci/endpoint/functions/pci-epf-vntb.c:560:56: warning: variable
 'align' is uninitialized when used here
Message-ID: <202208141017.cwJ0JXde-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jonmason/ntb ntb-next-hacking
head:   d90921d21692b59734d2452efea346217a526f44
commit: d90921d21692b59734d2452efea346217a526f44 [18/18] pcie: endpoint: pci-epf-vntb: add endpoint msi support
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220814/202208141017.cwJ0JXde-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 5f1c7e2cc5a3c07cbc2412e851a7283c1841f520)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/jonmason/ntb/commit/d90921d21692b59734d2452efea346217a526f44
        git remote add jonmason-ntb https://github.com/jonmason/ntb
        git fetch --no-tags jonmason-ntb ntb-next-hacking
        git checkout d90921d21692b59734d2452efea346217a526f44
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/pci/endpoint/functions/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/pci/endpoint/functions/pci-epf-vntb.c:541:33: warning: variable 'epc_features' set but not used [-Wunused-but-set-variable]
           const struct pci_epc_features *epc_features;
                                          ^
>> drivers/pci/endpoint/functions/pci-epf-vntb.c:560:56: warning: variable 'align' is uninitialized when used here [-Wuninitialized]
                   mw_addr = pci_epf_alloc_space(ntb->epf, size, barno, align, 0);
                                                                        ^~~~~
   drivers/pci/endpoint/functions/pci-epf-vntb.c:542:11: note: initialize the variable 'align' to silence this warning
           u32 align;
                    ^
                     = 0
   2 warnings generated.


vim +/align +560 drivers/pci/endpoint/functions/pci-epf-vntb.c

d90921d21692b59 Frank Li 2022-07-07  534  
53efbaa43643f36 Frank Li 2022-02-22  535  /**
53efbaa43643f36 Frank Li 2022-02-22  536   * epf_ntb_db_bar_init() - Configure Doorbell window BARs
53efbaa43643f36 Frank Li 2022-02-22  537   * @ntb: NTB device that facilitates communication between HOST and vHOST
53efbaa43643f36 Frank Li 2022-02-22  538   */
53efbaa43643f36 Frank Li 2022-02-22  539  static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
53efbaa43643f36 Frank Li 2022-02-22  540  {
53efbaa43643f36 Frank Li 2022-02-22  541  	const struct pci_epc_features *epc_features;
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
53efbaa43643f36 Frank Li 2022-02-22 @560  		mw_addr = pci_epf_alloc_space(ntb->epf, size, barno, align, 0);
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

:::::: The code at line 560 was first introduced by commit
:::::: 53efbaa43643f36d203700e7f436eaac11695274 PCI: endpoint: Support NTB transfer between RC and EP

:::::: TO: Frank Li <Frank.Li@nxp.com>
:::::: CC: Jon Mason <jdmason@kudzu.us>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
