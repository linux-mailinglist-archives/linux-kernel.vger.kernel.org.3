Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59454517003
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 15:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385103AbiEBNMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 09:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbiEBNMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 09:12:10 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC8D19290
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 06:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651496921; x=1683032921;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TRBohxboTMUTpfDTiSX38welX9/T8q5AoQ7VTXHhiO4=;
  b=HafUaXLstyHWXnFBIKfOE9RdNqj5A91W0Hki1TmQOduhA0Ce/HjO+RMG
   JYSe3Dyl24RHiS4u34UJzPLsChOvqDTepnK4gqevdmSTNs1xHlNTMVOcv
   I+3XpB/JkXNKUB2UI2VUP2/0+xs9cMeZsEmnx0grA4qudhd9rf+t69Qj2
   sz0KMQQJrf9QpkuIGAkqdbsPOQmh7Q7uuHQeByQ6wH+/UGXegbq/7DbpA
   QY+185WZKve/oOgtSz3P7WShGTtvyoDqjycNRMB3tl+0xT4sGhaUkiv+n
   zy5vjSaQww1F44f4QZKpslUXZ/w/hl/RhFsyKPAElSABBJYDWfM06fFCM
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10334"; a="264797207"
X-IronPort-AV: E=Sophos;i="5.91,192,1647327600"; 
   d="scan'208";a="264797207"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 06:08:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,192,1647327600"; 
   d="scan'208";a="690279646"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 02 May 2022 06:08:18 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlVmj-0009Yx-IB;
        Mon, 02 May 2022 13:08:17 +0000
Date:   Mon, 2 May 2022 21:08:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>
Subject: drivers/pci/controller/dwc/pcie-qcom-ep.c:694:9: error: implicit
 declaration of function 'qcom_pcie_disable_resources'; did you mean
 'qcom_pcie_ep_get_resources'?
Message-ID: <202205022102.2MzCb1qA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel-lab-lkp/linux/commits/UPDATE-20220502-184544/Manivannan-Sadhasivam/PCI-qcom-ep-Move-enable-disable-resources-code-to-common-functions/20220502-124818
head:   9cb459b5dc9b6a7c837726501f453ad78a829d3a
commit: 9cb459b5dc9b6a7c837726501f453ad78a829d3a PCI: qcom-ep: use qcom_pcie_disable_resources() in qcom_pcie_ep_remove()
date:   2 hours ago
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20220502/202205022102.2MzCb1qA-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/9cb459b5dc9b6a7c837726501f453ad78a829d3a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review UPDATE-20220502-184544/Manivannan-Sadhasivam/PCI-qcom-ep-Move-enable-disable-resources-code-to-common-functions/20220502-124818
        git checkout 9cb459b5dc9b6a7c837726501f453ad78a829d3a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/pci/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/pci/controller/dwc/pcie-qcom-ep.c: In function 'qcom_pcie_ep_remove':
>> drivers/pci/controller/dwc/pcie-qcom-ep.c:694:9: error: implicit declaration of function 'qcom_pcie_disable_resources'; did you mean 'qcom_pcie_ep_get_resources'? [-Werror=implicit-function-declaration]
     694 |         qcom_pcie_disable_resources(pcie_ep);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         |         qcom_pcie_ep_get_resources
   cc1: some warnings being treated as errors


vim +694 drivers/pci/controller/dwc/pcie-qcom-ep.c

   686	
   687	static int qcom_pcie_ep_remove(struct platform_device *pdev)
   688	{
   689		struct qcom_pcie_ep *pcie_ep = platform_get_drvdata(pdev);
   690	
   691		if (pcie_ep->link_status == QCOM_PCIE_EP_LINK_DISABLED)
   692			return 0;
   693	
 > 694		qcom_pcie_disable_resources(pcie_ep);
   695	
   696		return 0;
   697	}
   698	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
