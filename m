Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB0853E656
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238323AbiFFNHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 09:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238091AbiFFNH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 09:07:29 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55EE27F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 06:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654520837; x=1686056837;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gWQOGEVT8bc6y41SAm5x+F23gPtawj0XVjIaqBkFXNE=;
  b=RCS7/rVjdNDqH+y5UPmNR/4CY4mVTcAr449jVO4HVj7XxhBQz+m1yIpf
   dmX/WjknOvjub6Aw8RvoYDJWbbRMlQTeQvcPjapBLQGVKDd7gx+cq4EDe
   I9jKXSHJ+9YiJBKk4FUheBFv7w0LBJYwCl0bbxT4EGdeqfY7Lrv0jf2ZI
   kdSlXzIVbdDUDGduoZATrzymPncolBQHNdmskWDmdQRPfdDuXlr8oaEld
   v1fMEeMxgTlTUukILUmBsyfk/jZGfNtWhF6ccR+Mh0gGMWacXlO4MLFYv
   t3BKWMwQfMCIiCGsQz1C3mCObP5Svc9FfFtZPndDYVFWe+24MisSLb7kx
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="275431562"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="275431562"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 06:07:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="682238817"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 06 Jun 2022 06:07:15 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nyCRv-000CjZ-17;
        Mon, 06 Jun 2022 13:07:15 +0000
Date:   Mon, 6 Jun 2022 21:06:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Robert Richter <rric@kernel.org>
Subject: drivers/pci/controller/pci-xgene.c:626:34: warning:
 'xgene_pcie_match_table' defined but not used
Message-ID: <202206062135.8mSfWOtw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f2906aa863381afb0015a9eb7fefad885d4e5a56
commit: 6e5a1fff9096ecd259dedcbbdc812aa90986a40e PCI: Avoid building empty drivers
date:   1 year, 3 months ago
config: x86_64-buildonly-randconfig-r011-20220606 (https://download.01.org/0day-ci/archive/20220606/202206062135.8mSfWOtw-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6e5a1fff9096ecd259dedcbbdc812aa90986a40e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 6e5a1fff9096ecd259dedcbbdc812aa90986a40e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/pci/controller/ drivers/soc/ixp4xx/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/pci/controller/pci-xgene.c:626:34: warning: 'xgene_pcie_match_table' defined but not used [-Wunused-const-variable=]
     626 | static const struct of_device_id xgene_pcie_match_table[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~~~~


vim +/xgene_pcie_match_table +626 drivers/pci/controller/pci-xgene.c

5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c Tanmay Inamdar 2014-10-01  625  
5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c Tanmay Inamdar 2014-10-01 @626  static const struct of_device_id xgene_pcie_match_table[] = {
5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c Tanmay Inamdar 2014-10-01  627  	{.compatible = "apm,xgene-pcie",},
5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c Tanmay Inamdar 2014-10-01  628  	{},
5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c Tanmay Inamdar 2014-10-01  629  };
5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c Tanmay Inamdar 2014-10-01  630  

:::::: The code at line 626 was first introduced by commit
:::::: 5f6b6ccdbe1cdfa5aa4347ec5412509b8995db27 PCI: xgene: Add APM X-Gene PCIe driver

:::::: TO: Tanmay Inamdar <tinamdar@apm.com>
:::::: CC: Bjorn Helgaas <bhelgaas@google.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
