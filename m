Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6BE496CC8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 16:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233937AbiAVPPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 10:15:45 -0500
Received: from mga06.intel.com ([134.134.136.31]:2295 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230022AbiAVPPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 10:15:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642864545; x=1674400545;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Y64DV0fpvypyUXq8xjG5o5VCjdZ5CkiIjSBGB0PigBY=;
  b=OVA8AElMHVwsin/MBqxi5+VLRUgwXuSuUwQOQZLoOUGqaVqTIobEa0+9
   NpQdWNhKKWeM016KGQlJdLc4ag+vx9p1eQK5bI2BUsVAIAice4U/F8IR9
   q1NKzcOX+SLwGOgEuOs3lLmAbNdAvEIQa7C9whPF/2W0iyjqiHn/ufiWD
   VRK5uIcKesYFrKJx2Dj59u5Cdqg22tK8aJCx98pH14yMbaIcD2/07jZUZ
   uXTjrFUuRXOfrnQe2/5aKBxKqi08jYQkyzM0klU7l+wd1QkSzHy7YorKj
   4aY3ryJmB59T7tEjy4JwxIhUuS1ZbDn9WUmI69xhLYW7QNc8/+fFjdNL/
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10234"; a="306545541"
X-IronPort-AV: E=Sophos;i="5.88,308,1635231600"; 
   d="scan'208";a="306545541"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2022 07:15:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,308,1635231600"; 
   d="scan'208";a="478565276"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 22 Jan 2022 07:15:42 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nBI7B-000GWz-7Y; Sat, 22 Jan 2022 15:15:41 +0000
Date:   Sat, 22 Jan 2022 23:15:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [cxl:preview 34/53] drivers/cxl/cxl.h:285:17: warning: declaration
 of 'struct pci_bus' will not be visible outside of this function
Message-ID: <202201222345.9wJm6Bcm-lkp@intel.com>
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
config: riscv-randconfig-r042-20220122 (https://download.01.org/0day-ci/archive/20220122/202201222345.9wJm6Bcm-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 7b3d30728816403d1fd73cc5082e9fb761262bce)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?id=2b7a34a480122fb652df99554f6d59c5d9f3ef24
        git remote add cxl https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git
        git fetch --no-tags cxl preview
        git checkout 2b7a34a480122fb652df99554f6d59c5d9f3ef24
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/cxl/core/pmem.c:6:
   In file included from drivers/cxl/cxlmem.h:7:
>> drivers/cxl/cxl.h:285:17: warning: declaration of 'struct pci_bus' will not be visible outside of this function [-Wvisibility]
                                 struct pci_bus *bus);
                                        ^
   1 warning generated.


vim +285 drivers/cxl/cxl.h

24be641caabe25 Ben Widawsky 2021-12-01  281  
42c377a63d21df Dan Williams 2022-01-05  282  bool is_cxl_port(struct device *dev);
4812be97c015bd Dan Williams 2021-06-09  283  struct cxl_port *to_cxl_port(struct device *dev);
7237f27228ec66 Dan Williams 2022-01-18  284  int devm_cxl_register_pci_bus(struct device *host, struct device *uport,
7237f27228ec66 Dan Williams 2022-01-18 @285  			      struct pci_bus *bus);
7237f27228ec66 Dan Williams 2022-01-18  286  struct pci_bus *cxl_port_to_pci_bus(struct cxl_port *port);
4812be97c015bd Dan Williams 2021-06-09  287  struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
4812be97c015bd Dan Williams 2021-06-09  288  				   resource_size_t component_reg_phys,
4812be97c015bd Dan Williams 2021-06-09  289  				   struct cxl_port *parent_port);
3c39e157b25e0c Dan Williams 2022-01-18  290  struct cxl_port *find_cxl_root(struct device *dev);
2b7a34a480122f Dan Williams 2022-01-18  291  struct cxl_dport *devm_cxl_add_dport(struct device *host, struct cxl_port *port,
2b7a34a480122f Dan Williams 2022-01-18  292  				     struct device *dport, int port_id,
2b7a34a480122f Dan Williams 2022-01-18  293  				     resource_size_t component_reg_phys);
40ba17afdfabb0 Dan Williams 2021-06-09  294  struct cxl_decoder *to_cxl_decoder(struct device *dev);
8fdcb1704f61a8 Dan Williams 2021-06-15  295  bool is_root_decoder(struct device *dev);
42c377a63d21df Dan Williams 2022-01-05  296  bool is_cxl_decoder(struct device *dev);
24be641caabe25 Ben Widawsky 2021-12-01  297  struct cxl_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
24be641caabe25 Ben Widawsky 2021-12-01  298  					   unsigned int nr_targets);
24be641caabe25 Ben Widawsky 2021-12-01  299  struct cxl_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
24be641caabe25 Ben Widawsky 2021-12-01  300  					     unsigned int nr_targets);
48667f676189ec Dan Williams 2021-09-21  301  int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map);
48667f676189ec Dan Williams 2021-09-21  302  int cxl_decoder_autoremove(struct device *host, struct cxl_decoder *cxld);
40ba17afdfabb0 Dan Williams 2021-06-09  303  

:::::: The code at line 285 was first introduced by commit
:::::: 7237f27228ec660f73924f38e553e1d2b2ff65c4 cxl/port: Introduce cxl_port_to_pci_bus()

:::::: TO: Dan Williams <dan.j.williams@intel.com>
:::::: CC: Dan Williams <dan.j.williams@intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
