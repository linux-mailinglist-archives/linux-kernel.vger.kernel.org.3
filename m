Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2F247F4CB
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 01:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbhLZAH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 19:07:28 -0500
Received: from mga11.intel.com ([192.55.52.93]:13741 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231449AbhLZAH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 19:07:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640477248; x=1672013248;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WfFaV8hfeowLndpeEI4lkbZoSACOT0NWb7ffCjiD9FY=;
  b=SpIgijcZGApSL/w5SDfXuMHvMkZN0LJ1XTt8tG8DRwvODbE1/Ft0gHrI
   bpew8nobKAy3ori/bZhfdjbnHRy6y9nJpF6MssUpDN5mfgOCtye2+ZJfq
   jcpASTnbwIfSwO+UTBb9bAg2b5WdSnFcz7DQYgR4FKtRZjYabMIQsdpZW
   iUBAXndY37FRyabxvZbezVDTifVwM5ZMjy0vkIj1paMClHuKB7mvG7BXC
   1UW6Xt2MdC/7CSgkB+9/AuQ0shXFGSl4aikU6LBL7kAP/2wYyGN1uUldv
   ilP0J3sWTkadTnDzXFT59jrkvWATG9IiMvJ2UNCjkQ2yYmRMu8LkYXkmE
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10208"; a="238611451"
X-IronPort-AV: E=Sophos;i="5.88,236,1635231600"; 
   d="scan'208";a="238611451"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2021 16:07:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,236,1635231600"; 
   d="scan'208";a="618036687"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 25 Dec 2021 16:07:26 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n1H4P-0004s9-BS; Sun, 26 Dec 2021 00:07:25 +0000
Date:   Sun, 26 Dec 2021 08:07:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Haiyue Wang <haiyue.wang@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: drivers/net/ethernet/intel/iavf/iavf_fdir.c:340:5: warning: format
 specifies type 'unsigned short' but the argument has type 'int'
Message-ID: <202112260757.hcK6HH5M-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Haiyue,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e2ae0d4a6b0ba461542f0fd0ba0b828658013e9f
commit: 527691bf0682d7ddcca77fc17dabd2fa090572ff iavf: Support IPv4 Flow Director filters
date:   9 months ago
config: riscv-randconfig-r023-20211226 (https://download.01.org/0day-ci/archive/20211226/202112260757.hcK6HH5M-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project a9e8b1ee7fd44b53c555a7823ae8fd1a8209c520)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=527691bf0682d7ddcca77fc17dabd2fa090572ff
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 527691bf0682d7ddcca77fc17dabd2fa090572ff
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/net/ethernet/intel/iavf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/intel/iavf/iavf_fdir.c:340:5: warning: format specifies type 'unsigned short' but the argument has type 'int' [-Wformat]
                            ntohs(fltr->ip_data.dst_port),
                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:118:33: note: expanded from macro 'dev_info'
           _dev_info(dev, dev_fmt(fmt), ##__VA_ARGS__)
                                  ~~~     ^~~~~~~~~~~
   include/linux/byteorder/generic.h:142:18: note: expanded from macro 'ntohs'
   #define ntohs(x) ___ntohs(x)
                    ^~~~~~~~~~~
   include/linux/byteorder/generic.h:137:21: note: expanded from macro '___ntohs'
   #define ___ntohs(x) __be16_to_cpu(x)
                       ^~~~~~~~~~~~~~~~
   include/uapi/linux/byteorder/little_endian.h:42:26: note: expanded from macro '__be16_to_cpu'
   #define __be16_to_cpu(x) __swab16((__force __u16)(__be16)(x))
                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/uapi/linux/swab.h:105:2: note: expanded from macro '__swab16'
           (__builtin_constant_p((__u16)(x)) ?     \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/iavf/iavf_fdir.c:341:5: warning: format specifies type 'unsigned short' but the argument has type 'int' [-Wformat]
                            ntohs(fltr->ip_data.src_port));
                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:118:33: note: expanded from macro 'dev_info'
           _dev_info(dev, dev_fmt(fmt), ##__VA_ARGS__)
                                  ~~~     ^~~~~~~~~~~
   include/linux/byteorder/generic.h:142:18: note: expanded from macro 'ntohs'
   #define ntohs(x) ___ntohs(x)
                    ^~~~~~~~~~~
   include/linux/byteorder/generic.h:137:21: note: expanded from macro '___ntohs'
   #define ___ntohs(x) __be16_to_cpu(x)
                       ^~~~~~~~~~~~~~~~
   include/uapi/linux/byteorder/little_endian.h:42:26: note: expanded from macro '__be16_to_cpu'
   #define __be16_to_cpu(x) __swab16((__force __u16)(__be16)(x))
                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/uapi/linux/swab.h:105:2: note: expanded from macro '__swab16'
           (__builtin_constant_p((__u16)(x)) ?     \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   2 warnings generated.


vim +340 drivers/net/ethernet/intel/iavf/iavf_fdir.c

   316	
   317	/**
   318	 * iavf_print_fdir_fltr
   319	 * @adapter: adapter structure
   320	 * @fltr: Flow Director filter to print
   321	 *
   322	 * Print the Flow Director filter
   323	 **/
   324	void iavf_print_fdir_fltr(struct iavf_adapter *adapter, struct iavf_fdir_fltr *fltr)
   325	{
   326		const char *proto = iavf_fdir_flow_proto_name(fltr->flow_type);
   327	
   328		if (!proto)
   329			return;
   330	
   331		switch (fltr->flow_type) {
   332		case IAVF_FDIR_FLOW_IPV4_TCP:
   333		case IAVF_FDIR_FLOW_IPV4_UDP:
   334		case IAVF_FDIR_FLOW_IPV4_SCTP:
   335			dev_info(&adapter->pdev->dev, "Rule ID: %u dst_ip: %pI4 src_ip %pI4 %s: dst_port %hu src_port %hu\n",
   336				 fltr->loc,
   337				 &fltr->ip_data.v4_addrs.dst_ip,
   338				 &fltr->ip_data.v4_addrs.src_ip,
   339				 proto,
 > 340				 ntohs(fltr->ip_data.dst_port),
   341				 ntohs(fltr->ip_data.src_port));
   342			break;
   343		case IAVF_FDIR_FLOW_IPV4_AH:
   344		case IAVF_FDIR_FLOW_IPV4_ESP:
   345			dev_info(&adapter->pdev->dev, "Rule ID: %u dst_ip: %pI4 src_ip %pI4 %s: SPI %u\n",
   346				 fltr->loc,
   347				 &fltr->ip_data.v4_addrs.dst_ip,
   348				 &fltr->ip_data.v4_addrs.src_ip,
   349				 proto,
   350				 ntohl(fltr->ip_data.spi));
   351			break;
   352		case IAVF_FDIR_FLOW_IPV4_OTHER:
   353			dev_info(&adapter->pdev->dev, "Rule ID: %u dst_ip: %pI4 src_ip %pI4 proto: %u L4_bytes: 0x%x\n",
   354				 fltr->loc,
   355				 &fltr->ip_data.v4_addrs.dst_ip,
   356				 &fltr->ip_data.v4_addrs.src_ip,
   357				 fltr->ip_data.proto,
   358				 ntohl(fltr->ip_data.l4_header));
   359			break;
   360		default:
   361			break;
   362		}
   363	}
   364	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
