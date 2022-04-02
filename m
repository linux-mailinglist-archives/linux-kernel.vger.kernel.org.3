Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677A84F03E5
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 16:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356187AbiDBOWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 10:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236168AbiDBOWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 10:22:45 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B594012E14C
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 07:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648909252; x=1680445252;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=obwFUIj1u3uPG92qT+9O+3nfTusEjv2IsYIrU7GTBYs=;
  b=FHulytIgIYa6jVgEAziT/RNVbaNlSekPCUVD8Ec5ELJh3OHgegy+QC8b
   6G65tk8hTIlFDSp+0OWaUW2nmeeUyG/sX//H/yDJEEaGbwCdBX2GCsZEw
   +fd0sWbDQ6wPrD/WXMK/0GyFDu4Vub9n2LpfYwGep4ATw8LqlIjUcRUKp
   6HmdWhb9m42jbo66aN41iV8ExlW7H8qrlI6j1sjJLsoj3R8ZnoFF0P7e+
   5vsDpD9J1/bcwyi9G7ifoy4ipGf24a+WbbK03yC8ySx5VJ3P59h8c9TK1
   0VQjq2mrUhgX/HETCRjcNGPKp8rMdOANmYbAu05FSJ2hgTlxyQ620Bxu2
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="346742992"
X-IronPort-AV: E=Sophos;i="5.90,230,1643702400"; 
   d="scan'208";a="346742992"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2022 07:20:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,230,1643702400"; 
   d="scan'208";a="523089037"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 02 Apr 2022 07:20:50 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1naecU-0000C9-71;
        Sat, 02 Apr 2022 14:20:50 +0000
Date:   Sat, 2 Apr 2022 22:20:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/powerpc/platforms/ps3/gelic_udbg.c:147:9: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <202204022213.GILj0AGc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   88e6c0207623874922712e162e25d9dafd39661e
commit: f68f2ff91512c199ec24883001245912afc17873 fortify: Detect struct member overflows in memcpy() at compile-time
date:   7 weeks ago
config: powerpc64-randconfig-s032-20220402 (https://download.01.org/0day-ci/archive/20220402/202204022213.GILj0AGc-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f68f2ff91512c199ec24883001245912afc17873
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f68f2ff91512c199ec24883001245912afc17873
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/platforms/ps3/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   arch/powerpc/platforms/ps3/gelic_udbg.c:127:53: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void *start @@     got struct debug_block [noderef] __iomem * @@
   arch/powerpc/platforms/ps3/gelic_udbg.c:127:53: sparse:     expected void *start
   arch/powerpc/platforms/ps3/gelic_udbg.c:127:53: sparse:     got struct debug_block [noderef] __iomem *
   arch/powerpc/platforms/ps3/gelic_udbg.c:130:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *p @@     got struct debug_block [noderef] __iomem * @@
   arch/powerpc/platforms/ps3/gelic_udbg.c:130:17: sparse:     expected void *p
   arch/powerpc/platforms/ps3/gelic_udbg.c:130:17: sparse:     got struct debug_block [noderef] __iomem *
   arch/powerpc/platforms/ps3/gelic_udbg.c:132:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 static [addressable] [noderef] [toplevel] [usertype] __iomem buf_addr @@     got unsigned long long @@
   arch/powerpc/platforms/ps3/gelic_udbg.c:132:28: sparse:     expected restricted __be32 static [addressable] [noderef] [toplevel] [usertype] __iomem buf_addr
   arch/powerpc/platforms/ps3/gelic_udbg.c:132:28: sparse:     got unsigned long long
   arch/powerpc/platforms/ps3/gelic_udbg.c:144:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/powerpc/platforms/ps3/gelic_udbg.c:144:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ethhdr [noderef] __iomem *static [toplevel] h_eth @@     got struct ethhdr * @@
   arch/powerpc/platforms/ps3/gelic_udbg.c:144:15: sparse:     expected struct ethhdr [noderef] __iomem *static [toplevel] h_eth
   arch/powerpc/platforms/ps3/gelic_udbg.c:144:15: sparse:     got struct ethhdr *
   arch/powerpc/platforms/ps3/gelic_udbg.c:146:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned char [usertype] *addr @@     got unsigned char [noderef] __iomem * @@
   arch/powerpc/platforms/ps3/gelic_udbg.c:146:28: sparse:     expected unsigned char [usertype] *addr
   arch/powerpc/platforms/ps3/gelic_udbg.c:146:28: sparse:     got unsigned char [noderef] __iomem *
>> arch/powerpc/platforms/ps3/gelic_udbg.c:147:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] __iomem ( * )[6] @@
   arch/powerpc/platforms/ps3/gelic_udbg.c:147:9: sparse:     expected void const *
   arch/powerpc/platforms/ps3/gelic_udbg.c:147:9: sparse:     got unsigned char [noderef] __iomem ( * )[6]
>> arch/powerpc/platforms/ps3/gelic_udbg.c:147:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] __iomem ( * )[6] @@
   arch/powerpc/platforms/ps3/gelic_udbg.c:147:9: sparse:     expected void const *
   arch/powerpc/platforms/ps3/gelic_udbg.c:147:9: sparse:     got unsigned char [noderef] __iomem ( * )[6]
>> arch/powerpc/platforms/ps3/gelic_udbg.c:147:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got unsigned char [noderef] __iomem ( * )[6] @@
   arch/powerpc/platforms/ps3/gelic_udbg.c:147:9: sparse:     expected void *
   arch/powerpc/platforms/ps3/gelic_udbg.c:147:9: sparse:     got unsigned char [noderef] __iomem ( * )[6]
   arch/powerpc/platforms/ps3/gelic_udbg.c:156:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [noderef] [usertype] __iomem h_proto @@     got int @@
   arch/powerpc/platforms/ps3/gelic_udbg.c:156:31: sparse:     expected restricted __be16 [noderef] [usertype] __iomem h_proto
   arch/powerpc/platforms/ps3/gelic_udbg.c:156:31: sparse:     got int
   arch/powerpc/platforms/ps3/gelic_udbg.c:159:27: sparse: sparse: cast removes address space '__iomem' of expression
   arch/powerpc/platforms/ps3/gelic_udbg.c:159:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct vlan_hdr [noderef] __iomem *static [toplevel] h_vlan @@     got struct vlan_hdr * @@
   arch/powerpc/platforms/ps3/gelic_udbg.c:159:24: sparse:     expected struct vlan_hdr [noderef] __iomem *static [toplevel] h_vlan
   arch/powerpc/platforms/ps3/gelic_udbg.c:159:24: sparse:     got struct vlan_hdr *
   arch/powerpc/platforms/ps3/gelic_udbg.c:160:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [noderef] [usertype] __iomem h_vlan_TCI @@     got unsigned long long [addressable] [usertype] vlan_id @@
   arch/powerpc/platforms/ps3/gelic_udbg.c:160:36: sparse:     expected restricted __be16 [noderef] [usertype] __iomem h_vlan_TCI
   arch/powerpc/platforms/ps3/gelic_udbg.c:160:36: sparse:     got unsigned long long [addressable] [usertype] vlan_id
   arch/powerpc/platforms/ps3/gelic_udbg.c:161:51: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [noderef] [usertype] __iomem h_vlan_encapsulated_proto @@     got int @@
   arch/powerpc/platforms/ps3/gelic_udbg.c:161:51: sparse:     expected restricted __be16 [noderef] [usertype] __iomem h_vlan_encapsulated_proto
   arch/powerpc/platforms/ps3/gelic_udbg.c:161:51: sparse:     got int
   arch/powerpc/platforms/ps3/gelic_udbg.c:162:25: sparse: sparse: cast removes address space '__iomem' of expression
   arch/powerpc/platforms/ps3/gelic_udbg.c:162:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct iphdr [noderef] __iomem *static [toplevel] h_ip @@     got struct iphdr * @@
   arch/powerpc/platforms/ps3/gelic_udbg.c:162:22: sparse:     expected struct iphdr [noderef] __iomem *static [toplevel] h_ip
   arch/powerpc/platforms/ps3/gelic_udbg.c:162:22: sparse:     got struct iphdr *
   arch/powerpc/platforms/ps3/gelic_udbg.c:164:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [noderef] [usertype] __iomem h_proto @@     got int @@
   arch/powerpc/platforms/ps3/gelic_udbg.c:164:31: sparse:     expected restricted __be16 [noderef] [usertype] __iomem h_proto
   arch/powerpc/platforms/ps3/gelic_udbg.c:164:31: sparse:     got int
   arch/powerpc/platforms/ps3/gelic_udbg.c:165:25: sparse: sparse: cast removes address space '__iomem' of expression
   arch/powerpc/platforms/ps3/gelic_udbg.c:165:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct iphdr [noderef] __iomem *static [toplevel] h_ip @@     got struct iphdr * @@
   arch/powerpc/platforms/ps3/gelic_udbg.c:165:22: sparse:     expected struct iphdr [noderef] __iomem *static [toplevel] h_ip
   arch/powerpc/platforms/ps3/gelic_udbg.c:165:22: sparse:     got struct iphdr *
   arch/powerpc/platforms/ps3/gelic_udbg.c:174:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [noderef] [usertype] __iomem daddr @@     got unsigned int @@
   arch/powerpc/platforms/ps3/gelic_udbg.c:174:21: sparse:     expected restricted __be32 [noderef] [usertype] __iomem daddr
   arch/powerpc/platforms/ps3/gelic_udbg.c:174:21: sparse:     got unsigned int
   arch/powerpc/platforms/ps3/gelic_udbg.c:177:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/powerpc/platforms/ps3/gelic_udbg.c:177:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct udphdr [noderef] __iomem *static [toplevel] h_udp @@     got struct udphdr * @@
   arch/powerpc/platforms/ps3/gelic_udbg.c:177:15: sparse:     expected struct udphdr [noderef] __iomem *static [toplevel] h_udp
   arch/powerpc/platforms/ps3/gelic_udbg.c:177:15: sparse:     got struct udphdr *
   arch/powerpc/platforms/ps3/gelic_udbg.c:178:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [noderef] [usertype] __iomem source @@     got int @@
   arch/powerpc/platforms/ps3/gelic_udbg.c:178:23: sparse:     expected restricted __be16 [noderef] [usertype] __iomem source
   arch/powerpc/platforms/ps3/gelic_udbg.c:178:23: sparse:     got int
   arch/powerpc/platforms/ps3/gelic_udbg.c:179:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [noderef] [usertype] __iomem dest @@     got int @@
   arch/powerpc/platforms/ps3/gelic_udbg.c:179:21: sparse:     expected restricted __be16 [noderef] [usertype] __iomem dest
   arch/powerpc/platforms/ps3/gelic_udbg.c:179:21: sparse:     got int
   arch/powerpc/platforms/ps3/gelic_udbg.c:181:25: sparse: sparse: cast removes address space '__iomem' of expression
   arch/powerpc/platforms/ps3/gelic_udbg.c:181:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __iomem *static [toplevel] pmsg @@     got char * @@
   arch/powerpc/platforms/ps3/gelic_udbg.c:181:22: sparse:     expected char [noderef] __iomem *static [toplevel] pmsg
   arch/powerpc/platforms/ps3/gelic_udbg.c:181:22: sparse:     got char *
   arch/powerpc/platforms/ps3/gelic_udbg.c:198:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 static [addressable] [noderef] [toplevel] [usertype] __iomem buf_size @@     got int @@
   arch/powerpc/platforms/ps3/gelic_udbg.c:198:28: sparse:     expected restricted __be32 static [addressable] [noderef] [toplevel] [usertype] __iomem buf_size
   arch/powerpc/platforms/ps3/gelic_udbg.c:198:28: sparse:     got int
   arch/powerpc/platforms/ps3/gelic_udbg.c:199:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [noderef] [usertype] __iomem tot_len @@     got unsigned long @@
   arch/powerpc/platforms/ps3/gelic_udbg.c:199:23: sparse:     expected restricted __be16 [noderef] [usertype] __iomem tot_len
   arch/powerpc/platforms/ps3/gelic_udbg.c:199:23: sparse:     got unsigned long
   arch/powerpc/platforms/ps3/gelic_udbg.c:201:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [noderef] [usertype] __iomem len @@     got unsigned long @@
   arch/powerpc/platforms/ps3/gelic_udbg.c:201:20: sparse:     expected restricted __be16 [noderef] [usertype] __iomem len
   arch/powerpc/platforms/ps3/gelic_udbg.c:201:20: sparse:     got unsigned long
   arch/powerpc/platforms/ps3/gelic_udbg.c:205:14: sparse: sparse: cast removes address space '__iomem' of expression
   arch/powerpc/platforms/ps3/gelic_udbg.c:208:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __sum16 [noderef] [usertype] __iomem check @@     got unsigned int @@
   arch/powerpc/platforms/ps3/gelic_udbg.c:208:21: sparse:     expected restricted __sum16 [noderef] [usertype] __iomem check
   arch/powerpc/platforms/ps3/gelic_udbg.c:208:21: sparse:     got unsigned int
   arch/powerpc/platforms/ps3/gelic_udbg.c:210:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 static [addressable] [noderef] [toplevel] [usertype] __iomem dmac_cmd_status @@     got unsigned int @@
   arch/powerpc/platforms/ps3/gelic_udbg.c:210:35: sparse:     expected restricted __be32 static [addressable] [noderef] [toplevel] [usertype] __iomem dmac_cmd_status
   arch/powerpc/platforms/ps3/gelic_udbg.c:210:35: sparse:     got unsigned int
   arch/powerpc/platforms/ps3/gelic_udbg.c:219:26: sparse: sparse: restricted __be32 degrades to integer
   arch/powerpc/platforms/ps3/gelic_udbg.c:169:9: sparse: sparse: dereference of noderef expression
   arch/powerpc/platforms/ps3/gelic_udbg.c:170:9: sparse: sparse: dereference of noderef expression
   arch/powerpc/platforms/ps3/gelic_udbg.c:171:9: sparse: sparse: dereference of noderef expression
   arch/powerpc/platforms/ps3/gelic_udbg.c:172:9: sparse: sparse: dereference of noderef expression
   arch/powerpc/platforms/ps3/gelic_udbg.c:173:9: sparse: sparse: dereference of noderef expression
   arch/powerpc/platforms/ps3/gelic_udbg.c:203:9: sparse: sparse: dereference of noderef expression
   arch/powerpc/platforms/ps3/gelic_udbg.c:212:9: sparse: sparse: dereference of noderef expression
   arch/powerpc/platforms/ps3/gelic_udbg.c:213:9: sparse: sparse: dereference of noderef expression
   arch/powerpc/platforms/ps3/gelic_udbg.c:219:17: sparse: sparse: dereference of noderef expression
   arch/powerpc/platforms/ps3/gelic_udbg.c:226:15: sparse: sparse: dereference of noderef expression

vim +147 arch/powerpc/platforms/ps3/gelic_udbg.c

c26afe9e8591f3 Hector Martin  2011-08-31  115  
f1ba9b9474a9e3 Nick Child     2021-12-16  116  static void __init gelic_debug_init(void)
c26afe9e8591f3 Hector Martin  2011-08-31  117  {
c26afe9e8591f3 Hector Martin  2011-08-31  118  	s64 result;
c26afe9e8591f3 Hector Martin  2011-08-31  119  	u64 v2;
c26afe9e8591f3 Hector Martin  2011-08-31  120  	u64 mac;
c26afe9e8591f3 Hector Martin  2011-08-31  121  	u64 vlan_id;
c26afe9e8591f3 Hector Martin  2011-08-31  122  
c26afe9e8591f3 Hector Martin  2011-08-31  123  	result = lv1_open_device(GELIC_BUS_ID, GELIC_DEVICE_ID, 0);
c26afe9e8591f3 Hector Martin  2011-08-31  124  	if (result)
c26afe9e8591f3 Hector Martin  2011-08-31  125  		lv1_panic(0);
c26afe9e8591f3 Hector Martin  2011-08-31  126  
c26afe9e8591f3 Hector Martin  2011-08-31  127  	map_dma_mem(GELIC_BUS_ID, GELIC_DEVICE_ID, &dbg, sizeof(dbg),
c26afe9e8591f3 Hector Martin  2011-08-31  128  		    &bus_addr);
c26afe9e8591f3 Hector Martin  2011-08-31  129  
c26afe9e8591f3 Hector Martin  2011-08-31  130  	memset(&dbg, 0, sizeof(dbg));
c26afe9e8591f3 Hector Martin  2011-08-31  131  
c26afe9e8591f3 Hector Martin  2011-08-31 @132  	dbg.descr.buf_addr = bus_addr + offsetof(struct debug_block, pkt);
c26afe9e8591f3 Hector Martin  2011-08-31  133  
c26afe9e8591f3 Hector Martin  2011-08-31  134  	wmb();
c26afe9e8591f3 Hector Martin  2011-08-31  135  
c26afe9e8591f3 Hector Martin  2011-08-31  136  	result = lv1_net_control(GELIC_BUS_ID, GELIC_DEVICE_ID,
c26afe9e8591f3 Hector Martin  2011-08-31  137  				 GELIC_LV1_GET_MAC_ADDRESS, 0, 0, 0,
c26afe9e8591f3 Hector Martin  2011-08-31  138  				 &mac, &v2);
c26afe9e8591f3 Hector Martin  2011-08-31  139  	if (result)
c26afe9e8591f3 Hector Martin  2011-08-31  140  		lv1_panic(0);
c26afe9e8591f3 Hector Martin  2011-08-31  141  
c26afe9e8591f3 Hector Martin  2011-08-31  142  	mac <<= 16;
c26afe9e8591f3 Hector Martin  2011-08-31  143  
c26afe9e8591f3 Hector Martin  2011-08-31  144  	h_eth = (struct ethhdr *)dbg.pkt;
c26afe9e8591f3 Hector Martin  2011-08-31  145  
497abcf6afe2d8 Luis Henriques 2016-02-08 @146  	eth_broadcast_addr(h_eth->h_dest);
497abcf6afe2d8 Luis Henriques 2016-02-08 @147  	memcpy(&h_eth->h_source, &mac, ETH_ALEN);
c26afe9e8591f3 Hector Martin  2011-08-31  148  
c26afe9e8591f3 Hector Martin  2011-08-31  149  	header_size = sizeof(struct ethhdr);
c26afe9e8591f3 Hector Martin  2011-08-31  150  
c26afe9e8591f3 Hector Martin  2011-08-31  151  	result = lv1_net_control(GELIC_BUS_ID, GELIC_DEVICE_ID,
c26afe9e8591f3 Hector Martin  2011-08-31  152  				 GELIC_LV1_GET_VLAN_ID,
c26afe9e8591f3 Hector Martin  2011-08-31  153  				 GELIC_LV1_VLAN_TX_ETHERNET_0, 0, 0,
c26afe9e8591f3 Hector Martin  2011-08-31  154  				 &vlan_id, &v2);
c26afe9e8591f3 Hector Martin  2011-08-31  155  	if (!result) {
497abcf6afe2d8 Luis Henriques 2016-02-08  156  		h_eth->h_proto= ETH_P_8021Q;
c26afe9e8591f3 Hector Martin  2011-08-31  157  
e9aaa6d1abcffc Luis Henriques 2016-02-08  158  		header_size += sizeof(struct vlan_hdr);
e9aaa6d1abcffc Luis Henriques 2016-02-08  159  		h_vlan = (struct vlan_hdr *)(h_eth + 1);
e9aaa6d1abcffc Luis Henriques 2016-02-08  160  		h_vlan->h_vlan_TCI = vlan_id;
e9aaa6d1abcffc Luis Henriques 2016-02-08  161  		h_vlan->h_vlan_encapsulated_proto = ETH_P_IP;
c26afe9e8591f3 Hector Martin  2011-08-31  162  		h_ip = (struct iphdr *)(h_vlan + 1);
c26afe9e8591f3 Hector Martin  2011-08-31  163  	} else {
497abcf6afe2d8 Luis Henriques 2016-02-08  164  		h_eth->h_proto= 0x0800;
c26afe9e8591f3 Hector Martin  2011-08-31  165  		h_ip = (struct iphdr *)(h_eth + 1);
c26afe9e8591f3 Hector Martin  2011-08-31  166  	}
c26afe9e8591f3 Hector Martin  2011-08-31  167  
c26afe9e8591f3 Hector Martin  2011-08-31  168  	header_size += sizeof(struct iphdr);
0336c8cd4d6123 Luis Henriques 2016-02-08  169  	h_ip->version = 4;
0336c8cd4d6123 Luis Henriques 2016-02-08  170  	h_ip->ihl = 5;
c26afe9e8591f3 Hector Martin  2011-08-31  171  	h_ip->ttl = 10;
0336c8cd4d6123 Luis Henriques 2016-02-08  172  	h_ip->protocol = 0x11;
0336c8cd4d6123 Luis Henriques 2016-02-08  173  	h_ip->saddr = 0x00000000;
0336c8cd4d6123 Luis Henriques 2016-02-08  174  	h_ip->daddr = 0xffffffff;
c26afe9e8591f3 Hector Martin  2011-08-31  175  
c26afe9e8591f3 Hector Martin  2011-08-31  176  	header_size += sizeof(struct udphdr);
c26afe9e8591f3 Hector Martin  2011-08-31  177  	h_udp = (struct udphdr *)(h_ip + 1);
95442c64de7a6d Luis Henriques 2016-02-08  178  	h_udp->source = GELIC_DEBUG_PORT;
c26afe9e8591f3 Hector Martin  2011-08-31  179  	h_udp->dest = GELIC_DEBUG_PORT;
c26afe9e8591f3 Hector Martin  2011-08-31  180  
c26afe9e8591f3 Hector Martin  2011-08-31  181  	pmsgc = pmsg = (char *)(h_udp + 1);
c26afe9e8591f3 Hector Martin  2011-08-31  182  }
c26afe9e8591f3 Hector Martin  2011-08-31  183  

:::::: The code at line 147 was first introduced by commit
:::::: 497abcf6afe2d85f047fbf137388dbb63d2528f9 powerpc/ps3: gelic_udbg: use struct ethhdr from <linux/if_ether.h>

:::::: TO: Luis Henriques <luis.henriques@canonical.com>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
