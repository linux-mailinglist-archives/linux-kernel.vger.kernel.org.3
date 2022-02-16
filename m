Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51FA04B8A61
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 14:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbiBPNh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 08:37:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbiBPNhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 08:37:52 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554A02A39D3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 05:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645018660; x=1676554660;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eMKwLxYUL/GXMxK+okjyuwQUCIzuRwZI2UA1n8U3xT8=;
  b=FDHgDtj35rgvzbLQbW7aaYBJO0/b6xvHhx7/A77oPUK7DEPv/tWlDVlY
   1A76MKWA8sm/EKQkZOKFoDBuM0+oTCqMYyj2zLqFyv0tJa1TBRQfD1exa
   FDaBoPK9yA48SFPDIYWV7Tc1DslFNnpvAa50+JmdzCmMC7Po9prdWv3py
   mCv+fTZoQU3EXzhjxdQYTjBJ1ZVqLQUMz+OjI0yyh9YnEtsDQJy4zoEHn
   70WAN2ItvvbaTBvEB7Fs9VHv82OfwKQVQllMoW2CMyxvuOwTy8BjpYBa8
   nktYJ0lxN89t13osp8TaEmPX0QAMQhGvm6sb6LSi2TIZ3sHRksyWNwn0/
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="313875028"
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="313875028"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 05:37:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="774043839"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 16 Feb 2022 05:37:38 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKKV0-000Ape-3e; Wed, 16 Feb 2022 13:37:38 +0000
Date:   Wed, 16 Feb 2022 21:37:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zhu Lingshan <lingshan.zhu@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ls-zhu:shared_irq_v4 3/3] drivers/vdpa/ifcvf/ifcvf_main.c:94:13:
 warning: variable 'max_intr' set but not used
Message-ID: <202202162105.kmic72fi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ls-zhu/linux shared_irq_v4
head:   25e932e005734a4b8924e41bbedafa9dd394aead
commit: 25e932e005734a4b8924e41bbedafa9dd394aead [3/3] vDPA/ifcvf: implement device MSIX vector allocator
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220216/202202162105.kmic72fi-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ls-zhu/linux/commit/25e932e005734a4b8924e41bbedafa9dd394aead
        git remote add ls-zhu https://github.com/ls-zhu/linux
        git fetch --no-tags ls-zhu shared_irq_v4
        git checkout 25e932e005734a4b8924e41bbedafa9dd394aead
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/vdpa/ifcvf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/vdpa/ifcvf/ifcvf_main.c: In function 'ifcvf_request_irq':
>> drivers/vdpa/ifcvf/ifcvf_main.c:94:13: warning: variable 'max_intr' set but not used [-Wunused-but-set-variable]
      94 |         u16 max_intr;
         |             ^~~~~~~~


vim +/max_intr +94 drivers/vdpa/ifcvf/ifcvf_main.c

    88	
    89	static int ifcvf_request_irq(struct ifcvf_adapter *adapter)
    90	{
    91		struct pci_dev *pdev = adapter->pdev;
    92		struct ifcvf_hw *vf = &adapter->vf;
    93		int vector, nvectors, i, ret, irq;
  > 94		u16 max_intr;
    95	
    96		nvectors = ifcvf_alloc_vectors(adapter);
    97		if (nvectors <=0)
    98			return nvectors;
    99	
   100		max_intr = vf->nr_vring + 1;
   101		snprintf(vf->config_msix_name, 256, "ifcvf[%s]-config\n",
   102			 pci_name(pdev));
   103		vector = 0;
   104		vf->config_irq = pci_irq_vector(pdev, vector);
   105		ret = devm_request_irq(&pdev->dev, vf->config_irq,
   106				       ifcvf_config_changed, 0,
   107				       vf->config_msix_name, vf);
   108		if (ret) {
   109			IFCVF_ERR(pdev, "Failed to request config irq\n");
   110			return ret;
   111		}
   112	
   113		for (i = 0; i < vf->nr_vring; i++) {
   114			snprintf(vf->vring[i].msix_name, 256, "ifcvf[%s]-%d\n",
   115				 pci_name(pdev), i);
   116			vector = i + IFCVF_MSI_QUEUE_OFF;
   117			irq = pci_irq_vector(pdev, vector);
   118			ret = devm_request_irq(&pdev->dev, irq,
   119					       ifcvf_intr_handler, 0,
   120					       vf->vring[i].msix_name,
   121					       &vf->vring[i]);
   122			if (ret) {
   123				IFCVF_ERR(pdev,
   124					  "Failed to request irq for vq %d\n", i);
   125				ifcvf_free_irq(adapter, i);
   126	
   127				return ret;
   128			}
   129	
   130			vf->vring[i].irq = irq;
   131		}
   132	
   133		return 0;
   134	}
   135	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
