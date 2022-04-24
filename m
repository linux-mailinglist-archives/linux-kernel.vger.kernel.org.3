Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7166B50D196
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 14:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiDXMLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 08:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiDXMLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 08:11:40 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4338825E9B
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 05:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650802120; x=1682338120;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ssx/1jaoRTts/axIrhdEeTUJlNCVXWRfEWxOCQgcOeE=;
  b=MZpi2VnaNvY3k1PO8OVohKrpWt48rSWiBcDzXsO6s/4Uur1MT5QibO5U
   wPGACF7lCzWfkqGBlFPm1yS8MQ85GaxTt8ycKBVBSBp1v7Elc/62yPzWS
   3Fk+ov+9SQw1BDOD6PKDxYNI01PDZ/fpElJfNKtaZpsLZfICJHSbjJ0fV
   1/oW++bE1UXeWS8or/pj90iNZoXPdzNAoa+DwmgAhYXYE2FVzu8N2vkuL
   7VFG8CitX4soEjbhqj9QDMVyG4jAB1jpl0f5qvnzk2xs9vkZp7qHFsY39
   0R9RVCpUAfhZs0e0BnxrODZ93YeJWKzI1FTq7Hg5mnXa/PgC2qpv1UpVX
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10326"; a="351485505"
X-IronPort-AV: E=Sophos;i="5.90,286,1643702400"; 
   d="scan'208";a="351485505"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2022 05:08:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,286,1643702400"; 
   d="scan'208";a="675473093"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 24 Apr 2022 05:08:38 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nib2b-0001Q5-LD;
        Sun, 24 Apr 2022 12:08:37 +0000
Date:   Sun, 24 Apr 2022 20:08:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/powerpc/platforms/powernv/opal-fadump.c:683:60: sparse: sparse:
 incorrect type in argument 2 (different base types)
Message-ID: <202204241902.m4kglRy4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   22da5264abf497a10a4ed629f07f4ba28a7ed5eb
commit: d936f8182e1bd18f5e9e6c5e8d8b69261200ca96 powerpc/powernv: Fix type of opal_mpipl_query_tag() addr argument
date:   1 year ago
config: powerpc64-randconfig-s032-20220424 (https://download.01.org/0day-ci/archive/20220424/202204241902.m4kglRy4-lkp@intel.com/config)
compiler: powerpc64le-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d936f8182e1bd18f5e9e6c5e8d8b69261200ca96
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d936f8182e1bd18f5e9e6c5e8d8b69261200ca96
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/platforms/powernv/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   arch/powerpc/platforms/powernv/opal-fadump.c:104:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] boot_mem_dest_addr @@     got restricted __be64 const [usertype] dest @@
   arch/powerpc/platforms/powernv/opal-fadump.c:104:41: sparse:     expected unsigned long long [usertype] boot_mem_dest_addr
   arch/powerpc/platforms/powernv/opal-fadump.c:104:41: sparse:     got restricted __be64 const [usertype] dest
   arch/powerpc/platforms/powernv/opal-fadump.c:130:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long base @@     got restricted __be64 const [usertype] src @@
   arch/powerpc/platforms/powernv/opal-fadump.c:130:22: sparse:     expected unsigned long base
   arch/powerpc/platforms/powernv/opal-fadump.c:130:22: sparse:     got restricted __be64 const [usertype] src
   arch/powerpc/platforms/powernv/opal-fadump.c:131:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long size @@     got restricted __be64 const [usertype] size @@
   arch/powerpc/platforms/powernv/opal-fadump.c:131:22: sparse:     expected unsigned long size
   arch/powerpc/platforms/powernv/opal-fadump.c:131:22: sparse:     got restricted __be64 const [usertype] size
   arch/powerpc/platforms/powernv/opal-fadump.c:146:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long reserve_dump_area_start @@     got restricted __be64 const [usertype] dest @@
   arch/powerpc/platforms/powernv/opal-fadump.c:146:46: sparse:     expected unsigned long reserve_dump_area_start
   arch/powerpc/platforms/powernv/opal-fadump.c:146:46: sparse:     got restricted __be64 const [usertype] dest
   arch/powerpc/platforms/powernv/opal-fadump.c:196:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be64 [usertype] src @@     got unsigned long long @@
   arch/powerpc/platforms/powernv/opal-fadump.c:196:41: sparse:     expected restricted __be64 [usertype] src
   arch/powerpc/platforms/powernv/opal-fadump.c:196:41: sparse:     got unsigned long long
   arch/powerpc/platforms/powernv/opal-fadump.c:197:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be64 [usertype] dest @@     got unsigned long long [usertype] addr @@
   arch/powerpc/platforms/powernv/opal-fadump.c:197:41: sparse:     expected restricted __be64 [usertype] dest
   arch/powerpc/platforms/powernv/opal-fadump.c:197:41: sparse:     got unsigned long long [usertype] addr
   arch/powerpc/platforms/powernv/opal-fadump.c:198:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be64 [usertype] size @@     got unsigned long long @@
   arch/powerpc/platforms/powernv/opal-fadump.c:198:41: sparse:     expected restricted __be64 [usertype] size
   arch/powerpc/platforms/powernv/opal-fadump.c:198:41: sparse:     got unsigned long long
   arch/powerpc/platforms/powernv/opal-fadump.c:208:53: sparse: sparse: restricted __be64 degrades to integer
   arch/powerpc/platforms/powernv/opal-fadump.c:276:56: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned long long [usertype] src @@     got restricted __be64 [usertype] src @@
   arch/powerpc/platforms/powernv/opal-fadump.c:276:56: sparse:     expected unsigned long long [usertype] src
   arch/powerpc/platforms/powernv/opal-fadump.c:276:56: sparse:     got restricted __be64 [usertype] src
   arch/powerpc/platforms/powernv/opal-fadump.c:277:56: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned long long [usertype] dest @@     got restricted __be64 [usertype] dest @@
   arch/powerpc/platforms/powernv/opal-fadump.c:277:56: sparse:     expected unsigned long long [usertype] dest
   arch/powerpc/platforms/powernv/opal-fadump.c:277:56: sparse:     got restricted __be64 [usertype] dest
   arch/powerpc/platforms/powernv/opal-fadump.c:278:56: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected unsigned long long [usertype] size @@     got restricted __be64 [usertype] size @@
   arch/powerpc/platforms/powernv/opal-fadump.c:278:56: sparse:     expected unsigned long long [usertype] size
   arch/powerpc/platforms/powernv/opal-fadump.c:278:56: sparse:     got restricted __be64 [usertype] size
   arch/powerpc/platforms/powernv/opal-fadump.c:573:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] dumped_bytes @@     got restricted __be64 const [usertype] size @@
   arch/powerpc/platforms/powernv/opal-fadump.c:573:38: sparse:     expected unsigned long long [usertype] dumped_bytes
   arch/powerpc/platforms/powernv/opal-fadump.c:573:38: sparse:     got restricted __be64 const [usertype] size
>> arch/powerpc/platforms/powernv/opal-fadump.c:683:60: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __be64 [usertype] *addr @@     got unsigned long long * @@
   arch/powerpc/platforms/powernv/opal-fadump.c:683:60: sparse:     expected restricted __be64 [usertype] *addr
   arch/powerpc/platforms/powernv/opal-fadump.c:683:60: sparse:     got unsigned long long *
   arch/powerpc/platforms/powernv/opal-fadump.c:689:16: sparse: sparse: cast to restricted __be64
   arch/powerpc/platforms/powernv/opal-fadump.c:689:16: sparse: sparse: cast to restricted __be64
   arch/powerpc/platforms/powernv/opal-fadump.c:689:16: sparse: sparse: cast to restricted __be64
   arch/powerpc/platforms/powernv/opal-fadump.c:689:16: sparse: sparse: cast to restricted __be64
   arch/powerpc/platforms/powernv/opal-fadump.c:689:16: sparse: sparse: cast to restricted __be64
   arch/powerpc/platforms/powernv/opal-fadump.c:689:16: sparse: sparse: cast to restricted __be64
   arch/powerpc/platforms/powernv/opal-fadump.c:689:16: sparse: sparse: cast to restricted __be64
   arch/powerpc/platforms/powernv/opal-fadump.c:689:16: sparse: sparse: cast to restricted __be64
   arch/powerpc/platforms/powernv/opal-fadump.c:689:16: sparse: sparse: cast to restricted __be64
   arch/powerpc/platforms/powernv/opal-fadump.c:689:16: sparse: sparse: cast to restricted __be64
   arch/powerpc/platforms/powernv/opal-fadump.c:705:57: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __be64 [usertype] *addr @@     got unsigned long long * @@
   arch/powerpc/platforms/powernv/opal-fadump.c:705:57: sparse:     expected restricted __be64 [usertype] *addr
   arch/powerpc/platforms/powernv/opal-fadump.c:705:57: sparse:     got unsigned long long *
   arch/powerpc/platforms/powernv/opal-fadump.c:707:24: sparse: sparse: cast to restricted __be64
   arch/powerpc/platforms/powernv/opal-fadump.c:707:24: sparse: sparse: cast to restricted __be64
   arch/powerpc/platforms/powernv/opal-fadump.c:707:24: sparse: sparse: cast to restricted __be64
   arch/powerpc/platforms/powernv/opal-fadump.c:707:24: sparse: sparse: cast to restricted __be64
   arch/powerpc/platforms/powernv/opal-fadump.c:707:24: sparse: sparse: cast to restricted __be64
   arch/powerpc/platforms/powernv/opal-fadump.c:707:24: sparse: sparse: cast to restricted __be64
   arch/powerpc/platforms/powernv/opal-fadump.c:707:24: sparse: sparse: cast to restricted __be64
   arch/powerpc/platforms/powernv/opal-fadump.c:707:24: sparse: sparse: cast to restricted __be64
   arch/powerpc/platforms/powernv/opal-fadump.c:707:24: sparse: sparse: cast to restricted __be64
   arch/powerpc/platforms/powernv/opal-fadump.c:707:24: sparse: sparse: cast to restricted __be64
   arch/powerpc/platforms/powernv/opal-fadump.c: note: in included file:
   arch/powerpc/platforms/powernv/opal-fadump.h:138:33: sparse: sparse: restricted __be64 degrades to integer

vim +683 arch/powerpc/platforms/powernv/opal-fadump.c

41df5928721ff4 Hari Bathini     2019-09-11  622  
41df5928721ff4 Hari Bathini     2019-09-11  623  void __init opal_fadump_dt_scan(struct fw_dump *fadump_conf, u64 node)
41df5928721ff4 Hari Bathini     2019-09-11  624  {
2a1b06dd3a17ac Hari Bathini     2019-09-11  625  	const __be32 *prop;
41df5928721ff4 Hari Bathini     2019-09-11  626  	unsigned long dn;
2a1b06dd3a17ac Hari Bathini     2019-09-11  627  	u64 addr = 0;
7b1b3b48250acb Hari Bathini     2019-09-11  628  	int i, len;
2a1b06dd3a17ac Hari Bathini     2019-09-11  629  	s64 ret;
2a1b06dd3a17ac Hari Bathini     2019-09-11  630  
41df5928721ff4 Hari Bathini     2019-09-11  631  	/*
41df5928721ff4 Hari Bathini     2019-09-11  632  	 * Check if Firmware-Assisted Dump is supported. if yes, check
41df5928721ff4 Hari Bathini     2019-09-11  633  	 * if dump has been initiated on last reboot.
41df5928721ff4 Hari Bathini     2019-09-11  634  	 */
41df5928721ff4 Hari Bathini     2019-09-11  635  	dn = of_get_flat_dt_subnode_by_name(node, "dump");
41df5928721ff4 Hari Bathini     2019-09-11  636  	if (dn == -FDT_ERR_NOTFOUND) {
41df5928721ff4 Hari Bathini     2019-09-11  637  		pr_debug("FADump support is missing!\n");
41df5928721ff4 Hari Bathini     2019-09-11  638  		return;
41df5928721ff4 Hari Bathini     2019-09-11  639  	}
41df5928721ff4 Hari Bathini     2019-09-11  640  
41df5928721ff4 Hari Bathini     2019-09-11  641  	if (!of_flat_dt_is_compatible(dn, "ibm,opal-dump")) {
41df5928721ff4 Hari Bathini     2019-09-11  642  		pr_err("Support missing for this f/w version!\n");
41df5928721ff4 Hari Bathini     2019-09-11  643  		return;
41df5928721ff4 Hari Bathini     2019-09-11  644  	}
41df5928721ff4 Hari Bathini     2019-09-11  645  
7b1b3b48250acb Hari Bathini     2019-09-11  646  	prop = of_get_flat_dt_prop(dn, "fw-load-area", &len);
7b1b3b48250acb Hari Bathini     2019-09-11  647  	if (prop) {
7b1b3b48250acb Hari Bathini     2019-09-11  648  		/*
7b1b3b48250acb Hari Bathini     2019-09-11  649  		 * Each f/w load area is an (address,size) pair,
7b1b3b48250acb Hari Bathini     2019-09-11  650  		 * 2 cells each, totalling 4 cells per range.
7b1b3b48250acb Hari Bathini     2019-09-11  651  		 */
7b1b3b48250acb Hari Bathini     2019-09-11  652  		for (i = 0; i < len / (sizeof(*prop) * 4); i++) {
7b1b3b48250acb Hari Bathini     2019-09-11  653  			u64 base, end;
7b1b3b48250acb Hari Bathini     2019-09-11  654  
7b1b3b48250acb Hari Bathini     2019-09-11  655  			base = of_read_number(prop + (i * 4) + 0, 2);
7b1b3b48250acb Hari Bathini     2019-09-11  656  			end = base;
7b1b3b48250acb Hari Bathini     2019-09-11  657  			end += of_read_number(prop + (i * 4) + 2, 2);
7b1b3b48250acb Hari Bathini     2019-09-11  658  			if (end > OPAL_FADUMP_MIN_BOOT_MEM) {
7b1b3b48250acb Hari Bathini     2019-09-11  659  				pr_err("F/W load area: 0x%llx-0x%llx\n",
7b1b3b48250acb Hari Bathini     2019-09-11  660  				       base, end);
7b1b3b48250acb Hari Bathini     2019-09-11  661  				pr_err("F/W version not supported!\n");
7b1b3b48250acb Hari Bathini     2019-09-11  662  				return;
7b1b3b48250acb Hari Bathini     2019-09-11  663  			}
7b1b3b48250acb Hari Bathini     2019-09-11  664  		}
7b1b3b48250acb Hari Bathini     2019-09-11  665  	}
7b1b3b48250acb Hari Bathini     2019-09-11  666  
41df5928721ff4 Hari Bathini     2019-09-11  667  	fadump_conf->ops		= &opal_fadump_ops;
41df5928721ff4 Hari Bathini     2019-09-11  668  	fadump_conf->fadump_supported	= 1;
2a1b06dd3a17ac Hari Bathini     2019-09-11  669  
7dee93a9a8808b Hari Bathini     2019-09-11  670  	/*
7dee93a9a8808b Hari Bathini     2019-09-11  671  	 * Firmware supports 32-bit field for size. Align it to PAGE_SIZE
7dee93a9a8808b Hari Bathini     2019-09-11  672  	 * and request firmware to copy multiple kernel boot memory regions.
7dee93a9a8808b Hari Bathini     2019-09-11  673  	 */
e96d904ede6756 Christophe Leroy 2020-04-20  674  	fadump_conf->max_copy_size = ALIGN_DOWN(U32_MAX, PAGE_SIZE);
7dee93a9a8808b Hari Bathini     2019-09-11  675  
2a1b06dd3a17ac Hari Bathini     2019-09-11  676  	/*
2a1b06dd3a17ac Hari Bathini     2019-09-11  677  	 * Check if dump has been initiated on last reboot.
2a1b06dd3a17ac Hari Bathini     2019-09-11  678  	 */
2a1b06dd3a17ac Hari Bathini     2019-09-11  679  	prop = of_get_flat_dt_prop(dn, "mpipl-boot", NULL);
2a1b06dd3a17ac Hari Bathini     2019-09-11  680  	if (!prop)
2a1b06dd3a17ac Hari Bathini     2019-09-11  681  		return;
2a1b06dd3a17ac Hari Bathini     2019-09-11  682  
2a1b06dd3a17ac Hari Bathini     2019-09-11 @683  	ret = opal_mpipl_query_tag(OPAL_MPIPL_TAG_KERNEL, &addr);

:::::: The code at line 683 was first introduced by commit
:::::: 2a1b06dd3a17ac278494da3c15cac84684346d22 powerpc/fadump: process the crashdump by exporting it as /proc/vmcore

:::::: TO: Hari Bathini <hbathini@linux.ibm.com>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
