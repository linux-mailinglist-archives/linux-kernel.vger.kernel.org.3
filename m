Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF5DD483B70
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 06:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiADFI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 00:08:27 -0500
Received: from mga17.intel.com ([192.55.52.151]:15035 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229463AbiADFI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 00:08:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641272906; x=1672808906;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Q+kCvHS6KtD47YREWb4CcTTnq2JF7XNJS+88ETlwsiY=;
  b=YJoBLE9vyiLt/e90tJArQP1s9RnfY1PmSS6EtoXrF9Jaa2QcpdDnjsHV
   AUenDk0xNCdchyEF8GSt2T42hfqNkiO36NPwp35WFDvFVE62G6sJR0qnb
   +vJG5etfTMkm9unQZpx9otQqsPKt21i5EKytIyOQF+htBUzXzcpd07Xpm
   3vc3OBXdu6dzpyplO7D1WPlWdEYCgwKBve5hNVcDk2+RAe7Iy7jiZQCQF
   c/c4YeeicGJAQMTWPVBRpD6hFjl5p7W/JDn/x+OSEG1x7PHutqEIAjg/A
   Ru3HM4z43if2IK4K0g2UB44UQtqVi3tzzcX0RXMWb8RkBQMhxTUWpArZn
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="222830420"
X-IronPort-AV: E=Sophos;i="5.88,260,1635231600"; 
   d="scan'208";a="222830420"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 21:08:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,260,1635231600"; 
   d="scan'208";a="556054078"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 03 Jan 2022 21:08:23 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n4c3b-000EiL-8y; Tue, 04 Jan 2022 05:08:23 +0000
Date:   Tue, 4 Jan 2022 13:07:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: drivers/pci/controller/pcie-mt7621.c:224:6: error: implicit
 declaration of function 'mips_cps_numiocu'
Message-ID: <202201041305.X3oSuWBy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergio,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c9e6606c7fe92b50a02ce51dda82586ebdf99b48
commit: 2bdd5238e756aac3ecbffc7c22b884485e84062e PCI: mt7621: Add MediaTek MT7621 PCIe host controller driver
date:   3 months ago
config: mips-randconfig-r024-20220102 (https://download.01.org/0day-ci/archive/20220104/202201041305.X3oSuWBy-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 104a827ea6de0cbe0f5faef4407552ede31d165c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2bdd5238e756aac3ecbffc7c22b884485e84062e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 2bdd5238e756aac3ecbffc7c22b884485e84062e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/pci/controller/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/pci/controller/pcie-mt7621.c:224:6: error: implicit declaration of function 'mips_cps_numiocu' [-Werror,-Wimplicit-function-declaration]
           if (mips_cps_numiocu(0)) {
               ^
>> drivers/pci/controller/pcie-mt7621.c:232:3: error: implicit declaration of function 'write_gcr_reg1_base' [-Werror,-Wimplicit-function-declaration]
                   write_gcr_reg1_base(entry->res->start);
                   ^
>> drivers/pci/controller/pcie-mt7621.c:233:3: error: implicit declaration of function 'write_gcr_reg1_mask' [-Werror,-Wimplicit-function-declaration]
                   write_gcr_reg1_mask(mask | CM_GCR_REGn_MASK_CMTGT_IOCU0);
                   ^
   drivers/pci/controller/pcie-mt7621.c:233:3: note: did you mean 'write_gcr_reg1_base'?
   drivers/pci/controller/pcie-mt7621.c:232:3: note: 'write_gcr_reg1_base' declared here
                   write_gcr_reg1_base(entry->res->start);
                   ^
>> drivers/pci/controller/pcie-mt7621.c:233:30: error: use of undeclared identifier 'CM_GCR_REGn_MASK_CMTGT_IOCU0'
                   write_gcr_reg1_mask(mask | CM_GCR_REGn_MASK_CMTGT_IOCU0);
                                              ^
>> drivers/pci/controller/pcie-mt7621.c:235:25: error: implicit declaration of function 'read_gcr_reg1_base' [-Werror,-Wimplicit-function-declaration]
                            (unsigned long long)read_gcr_reg1_base(),
                                                ^
   drivers/pci/controller/pcie-mt7621.c:235:25: note: did you mean 'write_gcr_reg1_base'?
   drivers/pci/controller/pcie-mt7621.c:232:3: note: 'write_gcr_reg1_base' declared here
                   write_gcr_reg1_base(entry->res->start);
                   ^
>> drivers/pci/controller/pcie-mt7621.c:236:25: error: implicit declaration of function 'read_gcr_reg1_mask' [-Werror,-Wimplicit-function-declaration]
                            (unsigned long long)read_gcr_reg1_mask());
                                                ^
   drivers/pci/controller/pcie-mt7621.c:236:25: note: did you mean 'read_gcr_reg1_base'?
   drivers/pci/controller/pcie-mt7621.c:235:25: note: 'read_gcr_reg1_base' declared here
                            (unsigned long long)read_gcr_reg1_base(),
                                                ^
   include/linux/dev_printk.h:150:67: note: expanded from macro 'dev_info'
           dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                                            ^
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
                   _p_func(dev, fmt, ##__VA_ARGS__);                       \
                                       ^
   6 errors generated.


vim +/mips_cps_numiocu +224 drivers/pci/controller/pcie-mt7621.c

e51844bf825169 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2018-11-24  210  
b15606e63ea90c drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2021-06-14  211  static int setup_cm_memory_region(struct pci_host_bridge *host)
03f152e31f4ae8 drivers/staging/mt7621-pci/pci-mt7621.c John Crispin       2018-03-15  212  {
b15606e63ea90c drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2021-06-14  213  	struct mt7621_pcie *pcie = pci_host_bridge_priv(host);
d936550784a23b drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2018-11-04  214  	struct device *dev = pcie->dev;
b15606e63ea90c drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2021-06-14  215  	struct resource_entry *entry;
03f152e31f4ae8 drivers/staging/mt7621-pci/pci-mt7621.c John Crispin       2018-03-15  216  	resource_size_t mask;
8571c62d45cb7e drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2018-08-03  217  
b15606e63ea90c drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2021-06-14  218  	entry = resource_list_first_type(&host->windows, IORESOURCE_MEM);
b15606e63ea90c drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2021-06-14  219  	if (!entry) {
2bdd5238e756aa drivers/pci/controller/pcie-mt7621.c    Sergio Paracuellos 2021-09-22  220  		dev_err(dev, "cannot get memory resource\n");
b15606e63ea90c drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2021-06-14  221  		return -EINVAL;
b15606e63ea90c drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2021-06-14  222  	}
b15606e63ea90c drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2021-06-14  223  
03f152e31f4ae8 drivers/staging/mt7621-pci/pci-mt7621.c John Crispin       2018-03-15 @224  	if (mips_cps_numiocu(0)) {
d2bac2fd6daa91 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2018-11-04  225  		/*
d2bac2fd6daa91 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2018-11-04  226  		 * FIXME: hardware doesn't accept mask values with 1s after
d4e3a1f6cea79e drivers/staging/mt7621-pci/pci-mt7621.c NeilBrown          2018-05-04  227  		 * 0s (e.g. 0xffef), so it would be great to warn if that's
d2bac2fd6daa91 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2018-11-04  228  		 * about to happen
d2bac2fd6daa91 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2018-11-04  229  		 */
b15606e63ea90c drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2021-06-14  230  		mask = ~(entry->res->end - entry->res->start);
03f152e31f4ae8 drivers/staging/mt7621-pci/pci-mt7621.c John Crispin       2018-03-15  231  
b15606e63ea90c drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2021-06-14 @232  		write_gcr_reg1_base(entry->res->start);
03f152e31f4ae8 drivers/staging/mt7621-pci/pci-mt7621.c John Crispin       2018-03-15 @233  		write_gcr_reg1_mask(mask | CM_GCR_REGn_MASK_CMTGT_IOCU0);
d936550784a23b drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2018-11-04  234  		dev_info(dev, "PCI coherence region base: 0x%08llx, mask/settings: 0x%08llx\n",
03f152e31f4ae8 drivers/staging/mt7621-pci/pci-mt7621.c John Crispin       2018-03-15 @235  			 (unsigned long long)read_gcr_reg1_base(),
03f152e31f4ae8 drivers/staging/mt7621-pci/pci-mt7621.c John Crispin       2018-03-15 @236  			 (unsigned long long)read_gcr_reg1_mask());
03f152e31f4ae8 drivers/staging/mt7621-pci/pci-mt7621.c John Crispin       2018-03-15  237  	}
09dd629eeabb8a drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2020-03-18  238  
8571c62d45cb7e drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2018-08-03  239  	return 0;
8571c62d45cb7e drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2018-08-03  240  }
8571c62d45cb7e drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2018-08-03  241  

:::::: The code at line 224 was first introduced by commit
:::::: 03f152e31f4ae89c37ab240f45dd77c8a916dd26 staging: mt7621-pci: MIPS/ralink: add MT7621 pcie driver

:::::: TO: John Crispin <blogic@openwrt.org>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
