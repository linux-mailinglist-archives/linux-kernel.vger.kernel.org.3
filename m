Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0EB471C74
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 20:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbhLLTFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 14:05:30 -0500
Received: from mga02.intel.com ([134.134.136.20]:35230 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231902AbhLLTF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 14:05:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639335929; x=1670871929;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TTMbivIx6+EEqvo4fLhm7KnkaJz+VcWj2lijC/6p20w=;
  b=H5CiudL20H7t1FTNVK1ToMDD20uWhrZNIy73HZT6jCA/O1J1mucJfkmM
   eUsmpMm6lDPMnyTUBMQj/gyX3rlaABLg4agvh+EoSVI6M/5mNUhZ9TAih
   1FrScMG27l2waPgTJnrsSMg+k88EdOa5Oq/Sd2RPVBThfPinfKYMRX0ai
   tvUNSJwgx8Suf7WBUGT6TtptYuZKtLCJqmwl0++1GHMgIw8NouABOnROi
   bB7KvmjlbIxi2MF0E5jb12uUPfDlCZlwK3hbWp1NpPi52zvN9Zr6ETm9E
   CFDnDffZFpBHEza9ZlWoZHOOlfdjj6gwBsi8EFUnYe+5omU7wVEVHcX+2
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10195"; a="225898386"
X-IronPort-AV: E=Sophos;i="5.88,200,1635231600"; 
   d="scan'208";a="225898386"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2021 11:05:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,200,1635231600"; 
   d="scan'208";a="754016121"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 12 Dec 2021 11:05:27 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mwUA2-0005ug-Hc; Sun, 12 Dec 2021 19:05:26 +0000
Date:   Mon, 13 Dec 2021 03:05:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Haiyue Wang <haiyue.wang@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: drivers/net/ethernet/intel/iavf/iavf_fdir.c:340:5: warning: format
 specifies type 'unsigned short' but the argument has type 'int'
Message-ID: <202112130255.AGgZbDIE-lkp@intel.com>
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
head:   a763d5a5abd65797aec3dd1bf01fe2ccbec32967
commit: 527691bf0682d7ddcca77fc17dabd2fa090572ff iavf: Support IPv4 Flow Director filters
date:   9 months ago
config: riscv-randconfig-r014-20211212 (https://download.01.org/0day-ci/archive/20211213/202112130255.AGgZbDIE-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 097a1cb1d5ebb3a0ec4bcaed8ba3ff6a8e33c00a)
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
