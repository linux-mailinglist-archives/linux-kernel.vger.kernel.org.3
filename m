Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B453496CD3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 16:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbiAVPqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 10:46:46 -0500
Received: from mga01.intel.com ([192.55.52.88]:20369 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229581AbiAVPqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 10:46:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642866405; x=1674402405;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3fQYjG67Q8nFzNITh6l5ntrDGpTwyY1xfN+uUa/j/Ps=;
  b=L8yv3ASjf5tijqeJrkDoFPdAtPW88oGBCBupmLazY1EdoQhZ0bB/6Uwa
   D+c++U2Z0WsUZXLyaHMXNo4mM11/izMy5F+vN3ePrmmKAGby/MFVtB1gi
   k7ahuMkSO5Zlg77Fs66N6LQafv3mPDpKfuG3yrX6GFygh5dFiSeyXSYT9
   tSpN0nl1QCYh5JraBMVaDMQoubu8EZuAb5TgjKMOdW16Vht3cZR/rrOyE
   JGOfoUpMEgUKTGKxgcQB1MrLSUpm0rrz1YxNfHamuTqL4XGNUgl/Q+WXp
   ZMX3gNNRd4vmBVsH0Cg3V8vsoW/ZEDsq3YTQ3oyFDKEKCfYgyAjsuIT00
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10234"; a="270263172"
X-IronPort-AV: E=Sophos;i="5.88,308,1635231600"; 
   d="scan'208";a="270263172"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2022 07:46:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,308,1635231600"; 
   d="scan'208";a="476265484"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 22 Jan 2022 07:46:42 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nBIbB-000GYF-PT; Sat, 22 Jan 2022 15:46:41 +0000
Date:   Sat, 22 Jan 2022 23:46:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [cxl:preview 34/53] drivers/cxl/core/pci.c:48:31: error: use of
 undeclared identifier 'CXL_REGLOC_RBI_COMPONENT'
Message-ID: <202201222342.XT0vW1nO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git preview
head:   e675fabdbbcdb6e32dba688a20fb0bd42e0e2d5d
commit: 2b7a34a480122fb652df99554f6d59c5d9f3ef24 [34/53] cxl/core: Generalize dport enumeration in the core
config: mips-randconfig-c004-20220120 (https://download.01.org/0day-ci/archive/20220122/202201222342.XT0vW1nO-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 7b3d30728816403d1fd73cc5082e9fb761262bce)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?id=2b7a34a480122fb652df99554f6d59c5d9f3ef24
        git remote add cxl https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git
        git fetch --no-tags cxl preview
        git checkout 2b7a34a480122fb652df99554f6d59c5d9f3ef24
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/cxl/core/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> drivers/cxl/core/pci.c:48:31: error: use of undeclared identifier 'CXL_REGLOC_RBI_COMPONENT'
           rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
                                        ^
>> drivers/cxl/core/pci.c:55:8: error: implicit declaration of function 'cxl_regmap_to_base' [-Werror,-Wimplicit-function-declaration]
                                      cxl_regmap_to_base(pdev, &map));
                                      ^
>> drivers/cxl/core/pci.c:76:5: warning: no previous prototype for function 'devm_cxl_port_enumerate_dports' [-Wmissing-prototypes]
   int devm_cxl_port_enumerate_dports(struct device *host, struct cxl_port *port)
       ^
   drivers/cxl/core/pci.c:76:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int devm_cxl_port_enumerate_dports(struct device *host, struct cxl_port *port)
   ^
   static 
   1 warning and 2 errors generated.


vim +/CXL_REGLOC_RBI_COMPONENT +48 drivers/cxl/core/pci.c

    24	
    25	static int match_add_dports(struct pci_dev *pdev, void *data)
    26	{
    27		struct cxl_walk_context *ctx = data;
    28		struct cxl_port *port = ctx->port;
    29		struct device *host = ctx->host;
    30		struct pci_bus *bus = ctx->bus;
    31		int type = pci_pcie_type(pdev);
    32		struct cxl_register_map map;
    33		int match_type = ctx->type;
    34		struct cxl_dport *dport;
    35		u32 lnkcap, port_num;
    36		int rc;
    37	
    38		if (pdev->bus != bus)
    39			return 0;
    40		if (!pci_is_pcie(pdev))
    41			return 0;
    42		if (type != match_type)
    43			return 0;
    44		if (pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCAP,
    45					  &lnkcap) != PCIBIOS_SUCCESSFUL)
    46			return 0;
    47	
  > 48		rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
    49		if (rc)
    50			dev_dbg(&port->dev, "failed to find component registers\n");
    51	
    52		port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
    53		cxl_device_lock(&port->dev);
    54		dport = devm_cxl_add_dport(host, port, &pdev->dev, port_num,
  > 55					   cxl_regmap_to_base(pdev, &map));
    56		cxl_device_unlock(&port->dev);
    57		if (IS_ERR(dport)) {
    58			ctx->error = PTR_ERR(dport);
    59			return PTR_ERR(dport);
    60		}
    61		ctx->count++;
    62	
    63		dev_dbg(&port->dev, "add dport%d: %s\n", port_num, dev_name(&pdev->dev));
    64	
    65		return 0;
    66	}
    67	
    68	/**
    69	 * devm_cxl_port_enumerate_dports - enumerate downstream ports of the upstream port
    70	 * @host: devm context
    71	 * @port: cxl_port whose ->uport is the upstream of dports to be enumerated
    72	 *
    73	 * Returns a positive number of dports enumerated or a negative error
    74	 * code.
    75	 */
  > 76	int devm_cxl_port_enumerate_dports(struct device *host, struct cxl_port *port)

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
