Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF4F4BCF99
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 16:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244246AbiBTPxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 10:53:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235340AbiBTPxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 10:53:06 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2B03C71B
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645372363; x=1676908363;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Sn0IN7eD4MeYFPnGg+WT3aJjbbzBWznoYkOdLU2ahzI=;
  b=gNCelN5N5n3ArJnE1D1ixVtrX9NCOjdWKh3Eke1yb4xSe60qb64q8ikl
   YdNOcDF/jx+qUSRkShQeugXPC5V4PYFoajEB7AjJpVKIL/x2RahM4xdXN
   6qW2nnJCwZl6GCDYTgc07892WJG2eX4EFkLkK7+w+aaGWmtdKiYHTxm3u
   slyhQJ+N1aFgqPwff1zweYBVVKXMdhoQ47tjhnJ3aAcxp0vLkuF0bgNks
   DwlOBWOvSkgYmuh3DXctnGX93DQTWwDZY/Gbv7zcmZcwuXlENsHvzAHcv
   FBFNrhKU2V3WGorSviccBJD6B4m5DVW0kY8oSlMOyMIRsh3fVTao8VlAY
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="248964987"
X-IronPort-AV: E=Sophos;i="5.88,383,1635231600"; 
   d="scan'208";a="248964987"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 07:52:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,383,1635231600"; 
   d="scan'208";a="778468978"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 20 Feb 2022 07:52:41 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLoVt-0000Qn-8q; Sun, 20 Feb 2022 15:52:41 +0000
Date:   Sun, 20 Feb 2022 23:52:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/powerpc/platforms/powernv/opal-core.c:476:58: sparse: sparse:
 incorrect type in argument 2 (different base types)
Message-ID: <202202202338.FLQ4w2vm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4f12b742eb2b3a850ac8be7dc4ed52976fc6cb0b
commit: d936f8182e1bd18f5e9e6c5e8d8b69261200ca96 powerpc/powernv: Fix type of opal_mpipl_query_tag() addr argument
date:   10 months ago
config: powerpc64-randconfig-s032-20220220 (https://download.01.org/0day-ci/archive/20220220/202202202338.FLQ4w2vm-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d936f8182e1bd18f5e9e6c5e8d8b69261200ca96
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d936f8182e1bd18f5e9e6c5e8d8b69261200ca96
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/platforms/powernv/ drivers/gpu/drm/amd/display/amdgpu_dm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   arch/powerpc/platforms/powernv/opal-core.c:99:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] n_namesz @@     got restricted __be32 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:99:24: sparse:     expected unsigned int [usertype] n_namesz
   arch/powerpc/platforms/powernv/opal-core.c:99:24: sparse:     got restricted __be32 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:100:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] n_descsz @@     got restricted __be32 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:100:24: sparse:     expected unsigned int [usertype] n_descsz
   arch/powerpc/platforms/powernv/opal-core.c:100:24: sparse:     got restricted __be32 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:101:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] n_type @@     got restricted __be32 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:101:24: sparse:     expected unsigned int [usertype] n_type
   arch/powerpc/platforms/powernv/opal-core.c:101:24: sparse:     got restricted __be32 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:122:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected int [usertype] pr_pid @@     got restricted __be32 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:122:34: sparse:     expected int [usertype] pr_pid
   arch/powerpc/platforms/powernv/opal-core.c:122:34: sparse:     got restricted __be32 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:123:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected int [usertype] pr_ppid @@     got restricted __be32 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:123:34: sparse:     expected int [usertype] pr_ppid
   arch/powerpc/platforms/powernv/opal-core.c:123:34: sparse:     got restricted __be32 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:133:44: sparse: sparse: incorrect type in assignment (different base types) @@     expected short pr_cursig @@     got restricted __be16 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:133:44: sparse:     expected short pr_cursig
   arch/powerpc/platforms/powernv/opal-core.c:133:44: sparse:     got restricted __be16 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:146:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] @@     got restricted __be64 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:146:21: sparse:     expected unsigned long long [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:146:21: sparse:     got restricted __be64 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:147:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] @@     got restricted __be64 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:147:21: sparse:     expected unsigned long long [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:147:21: sparse:     got restricted __be64 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:150:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] @@     got restricted __be64 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:150:21: sparse:     expected unsigned long long [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:150:21: sparse:     got restricted __be64 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:277:17: sparse: sparse: cast to restricted __be64
   arch/powerpc/platforms/powernv/opal-core.c:277:17: sparse: sparse: cast to restricted __be64
   arch/powerpc/platforms/powernv/opal-core.c:363:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] e_type @@     got restricted __be16 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:363:21: sparse:     expected unsigned short [usertype] e_type
   arch/powerpc/platforms/powernv/opal-core.c:363:21: sparse:     got restricted __be16 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:364:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] e_machine @@     got restricted __be16 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:364:24: sparse:     expected unsigned short [usertype] e_machine
   arch/powerpc/platforms/powernv/opal-core.c:364:24: sparse:     got restricted __be16 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:365:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] e_version @@     got restricted __be32 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:365:24: sparse:     expected unsigned int [usertype] e_version
   arch/powerpc/platforms/powernv/opal-core.c:365:24: sparse:     got restricted __be32 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:367:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] e_phoff @@     got restricted __be64 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:367:22: sparse:     expected unsigned long long [usertype] e_phoff
   arch/powerpc/platforms/powernv/opal-core.c:367:22: sparse:     got restricted __be64 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:371:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] e_ehsize @@     got restricted __be16 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:371:23: sparse:     expected unsigned short [usertype] e_ehsize
   arch/powerpc/platforms/powernv/opal-core.c:371:23: sparse:     got restricted __be16 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:372:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] e_phentsize @@     got restricted __be16 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:372:26: sparse:     expected unsigned short [usertype] e_phentsize
   arch/powerpc/platforms/powernv/opal-core.c:372:26: sparse:     got restricted __be16 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:380:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] p_type @@     got restricted __be32 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:380:25: sparse:     expected unsigned int [usertype] p_type
   arch/powerpc/platforms/powernv/opal-core.c:380:25: sparse:     got restricted __be32 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:384:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] p_offset @@     got restricted __be64 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:384:25: sparse:     expected unsigned long long [usertype] p_offset
   arch/powerpc/platforms/powernv/opal-core.c:384:25: sparse:     got restricted __be64 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:385:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] p_memsz @@     got restricted __be64 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:385:41: sparse:     expected unsigned long long [usertype] p_memsz
   arch/powerpc/platforms/powernv/opal-core.c:385:41: sparse:     got restricted __be64 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:394:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] p_type @@     got restricted __be32 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:394:33: sparse:     expected unsigned int [usertype] p_type
   arch/powerpc/platforms/powernv/opal-core.c:394:33: sparse:     got restricted __be32 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:395:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] p_flags @@     got restricted __be32 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:395:33: sparse:     expected unsigned int [usertype] p_flags
   arch/powerpc/platforms/powernv/opal-core.c:395:33: sparse:     got restricted __be32 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:406:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] p_paddr @@     got restricted __be64 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:406:33: sparse:     expected unsigned long long [usertype] p_paddr
   arch/powerpc/platforms/powernv/opal-core.c:406:33: sparse:     got restricted __be64 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:407:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] p_vaddr @@     got restricted __be64 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:407:33: sparse:     expected unsigned long long [usertype] p_vaddr
   arch/powerpc/platforms/powernv/opal-core.c:407:33: sparse:     got restricted __be64 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:408:50: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] p_memsz @@     got restricted __be64 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:408:50: sparse:     expected unsigned long long [usertype] p_memsz
   arch/powerpc/platforms/powernv/opal-core.c:408:50: sparse:     got restricted __be64 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:410:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] p_offset @@     got restricted __be64 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:410:33: sparse:     expected unsigned long long [usertype] p_offset
   arch/powerpc/platforms/powernv/opal-core.c:410:33: sparse:     got restricted __be64 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:417:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] e_phnum @@     got restricted __be16 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:417:22: sparse:     expected unsigned short [usertype] e_phnum
   arch/powerpc/platforms/powernv/opal-core.c:417:22: sparse:     got restricted __be16 [usertype]
>> arch/powerpc/platforms/powernv/opal-core.c:476:58: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __be64 [usertype] *addr @@     got unsigned long long * @@
   arch/powerpc/platforms/powernv/opal-core.c:476:58: sparse:     expected restricted __be64 [usertype] *addr
   arch/powerpc/platforms/powernv/opal-core.c:476:58: sparse:     got unsigned long long *
   arch/powerpc/platforms/powernv/opal-core.c:482:16: sparse: sparse: cast to restricted __be64
   arch/powerpc/platforms/powernv/opal-core.c:487:57: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __be64 [usertype] *addr @@     got unsigned long long * @@
   arch/powerpc/platforms/powernv/opal-core.c:487:57: sparse:     expected restricted __be64 [usertype] *addr
   arch/powerpc/platforms/powernv/opal-core.c:487:57: sparse:     got unsigned long long *
   arch/powerpc/platforms/powernv/opal-core.c:493:16: sparse: sparse: cast to restricted __be64
   arch/powerpc/platforms/powernv/opal-core.c: note: in included file:
   arch/powerpc/platforms/powernv/opal-fadump.h:138:33: sparse: sparse: restricted __be64 degrades to integer
--
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
   arch/powerpc/platforms/powernv/opal-fadump.c:705:57: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __be64 [usertype] *addr @@     got unsigned long long * @@
   arch/powerpc/platforms/powernv/opal-fadump.c:705:57: sparse:     expected restricted __be64 [usertype] *addr
   arch/powerpc/platforms/powernv/opal-fadump.c:705:57: sparse:     got unsigned long long *
   arch/powerpc/platforms/powernv/opal-fadump.c:707:24: sparse: sparse: cast to restricted __be64
   arch/powerpc/platforms/powernv/opal-fadump.c: note: in included file:
   arch/powerpc/platforms/powernv/opal-fadump.h:138:33: sparse: sparse: restricted __be64 degrades to integer

vim +476 arch/powerpc/platforms/powernv/opal-core.c

6f713d18144ce8 Hari Bathini  2019-09-11  298  
6f713d18144ce8 Hari Bathini  2019-09-11  299  static int __init create_opalcore(void)
6f713d18144ce8 Hari Bathini  2019-09-11  300  {
6f713d18144ce8 Hari Bathini  2019-09-11  301  	u64 opal_boot_entry, opal_base_addr, paddr;
6f713d18144ce8 Hari Bathini  2019-09-11  302  	u32 hdr_size, cpu_notes_size, count;
6f713d18144ce8 Hari Bathini  2019-09-11  303  	struct device_node *dn;
6f713d18144ce8 Hari Bathini  2019-09-11  304  	struct opalcore *new;
6f713d18144ce8 Hari Bathini  2019-09-11  305  	loff_t opalcore_off;
6f713d18144ce8 Hari Bathini  2019-09-11  306  	struct page *page;
6f713d18144ce8 Hari Bathini  2019-09-11  307  	Elf64_Phdr *phdr;
6f713d18144ce8 Hari Bathini  2019-09-11  308  	Elf64_Ehdr *elf;
6f713d18144ce8 Hari Bathini  2019-09-11  309  	int i, ret;
6f713d18144ce8 Hari Bathini  2019-09-11  310  	char *bufp;
6f713d18144ce8 Hari Bathini  2019-09-11  311  
6f713d18144ce8 Hari Bathini  2019-09-11  312  	/* Get size of header & CPU notes for OPAL core */
6f713d18144ce8 Hari Bathini  2019-09-11  313  	hdr_size = (sizeof(Elf64_Ehdr) +
6f713d18144ce8 Hari Bathini  2019-09-11  314  		    ((oc_conf->ptload_cnt + 1) * sizeof(Elf64_Phdr)));
6f713d18144ce8 Hari Bathini  2019-09-11  315  	cpu_notes_size = ((oc_conf->num_cpus * (CRASH_CORE_NOTE_HEAD_BYTES +
6f713d18144ce8 Hari Bathini  2019-09-11  316  			  CRASH_CORE_NOTE_NAME_BYTES +
6f713d18144ce8 Hari Bathini  2019-09-11  317  			  CRASH_CORE_NOTE_DESC_BYTES)) +
6f713d18144ce8 Hari Bathini  2019-09-11  318  			  (CRASH_CORE_NOTE_HEAD_BYTES +
6f713d18144ce8 Hari Bathini  2019-09-11  319  			  CRASH_CORE_NOTE_NAME_BYTES + AUXV_DESC_SZ));
6f713d18144ce8 Hari Bathini  2019-09-11  320  
6f713d18144ce8 Hari Bathini  2019-09-11  321  	/* Allocate buffer to setup OPAL core */
6f713d18144ce8 Hari Bathini  2019-09-11  322  	oc_conf->opalcorebuf_sz = PAGE_ALIGN(hdr_size + cpu_notes_size);
6f713d18144ce8 Hari Bathini  2019-09-11  323  	oc_conf->opalcorebuf = alloc_pages_exact(oc_conf->opalcorebuf_sz,
6f713d18144ce8 Hari Bathini  2019-09-11  324  						 GFP_KERNEL | __GFP_ZERO);
6f713d18144ce8 Hari Bathini  2019-09-11  325  	if (!oc_conf->opalcorebuf) {
6f713d18144ce8 Hari Bathini  2019-09-11  326  		pr_err("Not enough memory to setup OPAL core (size: %lu)\n",
6f713d18144ce8 Hari Bathini  2019-09-11  327  		       oc_conf->opalcorebuf_sz);
6f713d18144ce8 Hari Bathini  2019-09-11  328  		oc_conf->opalcorebuf_sz = 0;
6f713d18144ce8 Hari Bathini  2019-09-11  329  		return -ENOMEM;
6f713d18144ce8 Hari Bathini  2019-09-11  330  	}
6f713d18144ce8 Hari Bathini  2019-09-11  331  	count = oc_conf->opalcorebuf_sz / PAGE_SIZE;
6f713d18144ce8 Hari Bathini  2019-09-11  332  	page = virt_to_page(oc_conf->opalcorebuf);
6f713d18144ce8 Hari Bathini  2019-09-11  333  	for (i = 0; i < count; i++)
6f713d18144ce8 Hari Bathini  2019-09-11  334  		mark_page_reserved(page + i);
6f713d18144ce8 Hari Bathini  2019-09-11  335  
6f713d18144ce8 Hari Bathini  2019-09-11  336  	pr_debug("opalcorebuf = 0x%llx\n", (u64)oc_conf->opalcorebuf);
6f713d18144ce8 Hari Bathini  2019-09-11  337  
6f713d18144ce8 Hari Bathini  2019-09-11  338  	/* Read OPAL related device-tree entries */
6f713d18144ce8 Hari Bathini  2019-09-11  339  	dn = of_find_node_by_name(NULL, "ibm,opal");
6f713d18144ce8 Hari Bathini  2019-09-11  340  	if (dn) {
6f713d18144ce8 Hari Bathini  2019-09-11  341  		ret = of_property_read_u64(dn, "opal-base-address",
6f713d18144ce8 Hari Bathini  2019-09-11  342  					   &opal_base_addr);
6f713d18144ce8 Hari Bathini  2019-09-11  343  		pr_debug("opal-base-address: %llx\n", opal_base_addr);
6f713d18144ce8 Hari Bathini  2019-09-11  344  		ret |= of_property_read_u64(dn, "opal-boot-address",
6f713d18144ce8 Hari Bathini  2019-09-11  345  					    &opal_boot_entry);
6f713d18144ce8 Hari Bathini  2019-09-11  346  		pr_debug("opal-boot-address: %llx\n", opal_boot_entry);
6f713d18144ce8 Hari Bathini  2019-09-11  347  	}
6f713d18144ce8 Hari Bathini  2019-09-11  348  	if (!dn || ret)
6f713d18144ce8 Hari Bathini  2019-09-11  349  		pr_warn("WARNING: Failed to read OPAL base & entry values\n");
6f713d18144ce8 Hari Bathini  2019-09-11  350  
6f713d18144ce8 Hari Bathini  2019-09-11  351  	/* Use count to keep track of the program headers */
6f713d18144ce8 Hari Bathini  2019-09-11  352  	count = 0;
6f713d18144ce8 Hari Bathini  2019-09-11  353  
6f713d18144ce8 Hari Bathini  2019-09-11  354  	bufp = oc_conf->opalcorebuf;
6f713d18144ce8 Hari Bathini  2019-09-11  355  	elf = (Elf64_Ehdr *)bufp;
6f713d18144ce8 Hari Bathini  2019-09-11  356  	bufp += sizeof(Elf64_Ehdr);
6f713d18144ce8 Hari Bathini  2019-09-11  357  	memcpy(elf->e_ident, ELFMAG, SELFMAG);
6f713d18144ce8 Hari Bathini  2019-09-11  358  	elf->e_ident[EI_CLASS] = ELF_CLASS;
6f713d18144ce8 Hari Bathini  2019-09-11  359  	elf->e_ident[EI_DATA] = ELFDATA2MSB;
6f713d18144ce8 Hari Bathini  2019-09-11  360  	elf->e_ident[EI_VERSION] = EV_CURRENT;
6f713d18144ce8 Hari Bathini  2019-09-11  361  	elf->e_ident[EI_OSABI] = ELF_OSABI;
6f713d18144ce8 Hari Bathini  2019-09-11  362  	memset(elf->e_ident+EI_PAD, 0, EI_NIDENT-EI_PAD);
6f713d18144ce8 Hari Bathini  2019-09-11  363  	elf->e_type = cpu_to_be16(ET_CORE);
6f713d18144ce8 Hari Bathini  2019-09-11  364  	elf->e_machine = cpu_to_be16(ELF_ARCH);
6f713d18144ce8 Hari Bathini  2019-09-11  365  	elf->e_version = cpu_to_be32(EV_CURRENT);
6f713d18144ce8 Hari Bathini  2019-09-11  366  	elf->e_entry = 0;
6f713d18144ce8 Hari Bathini  2019-09-11  367  	elf->e_phoff = cpu_to_be64(sizeof(Elf64_Ehdr));
6f713d18144ce8 Hari Bathini  2019-09-11  368  	elf->e_shoff = 0;
6f713d18144ce8 Hari Bathini  2019-09-11  369  	elf->e_flags = 0;
6f713d18144ce8 Hari Bathini  2019-09-11  370  
6f713d18144ce8 Hari Bathini  2019-09-11  371  	elf->e_ehsize = cpu_to_be16(sizeof(Elf64_Ehdr));
6f713d18144ce8 Hari Bathini  2019-09-11  372  	elf->e_phentsize = cpu_to_be16(sizeof(Elf64_Phdr));
6f713d18144ce8 Hari Bathini  2019-09-11  373  	elf->e_phnum = 0;
6f713d18144ce8 Hari Bathini  2019-09-11  374  	elf->e_shentsize = 0;
6f713d18144ce8 Hari Bathini  2019-09-11  375  	elf->e_shnum = 0;
6f713d18144ce8 Hari Bathini  2019-09-11  376  	elf->e_shstrndx = 0;
6f713d18144ce8 Hari Bathini  2019-09-11  377  
6f713d18144ce8 Hari Bathini  2019-09-11  378  	phdr = (Elf64_Phdr *)bufp;
6f713d18144ce8 Hari Bathini  2019-09-11  379  	bufp += sizeof(Elf64_Phdr);
6f713d18144ce8 Hari Bathini  2019-09-11  380  	phdr->p_type	= cpu_to_be32(PT_NOTE);
6f713d18144ce8 Hari Bathini  2019-09-11  381  	phdr->p_flags	= 0;
6f713d18144ce8 Hari Bathini  2019-09-11  382  	phdr->p_align	= 0;
6f713d18144ce8 Hari Bathini  2019-09-11  383  	phdr->p_paddr	= phdr->p_vaddr = 0;
6f713d18144ce8 Hari Bathini  2019-09-11  384  	phdr->p_offset	= cpu_to_be64(hdr_size);
6f713d18144ce8 Hari Bathini  2019-09-11  385  	phdr->p_filesz	= phdr->p_memsz = cpu_to_be64(cpu_notes_size);
6f713d18144ce8 Hari Bathini  2019-09-11  386  	count++;
6f713d18144ce8 Hari Bathini  2019-09-11  387  
6f713d18144ce8 Hari Bathini  2019-09-11  388  	opalcore_off = oc_conf->opalcorebuf_sz;
6f713d18144ce8 Hari Bathini  2019-09-11  389  	oc_conf->ptload_phdr  = (Elf64_Phdr *)bufp;
6f713d18144ce8 Hari Bathini  2019-09-11  390  	paddr = 0;
6f713d18144ce8 Hari Bathini  2019-09-11  391  	for (i = 0; i < oc_conf->ptload_cnt; i++) {
6f713d18144ce8 Hari Bathini  2019-09-11  392  		phdr = (Elf64_Phdr *)bufp;
6f713d18144ce8 Hari Bathini  2019-09-11  393  		bufp += sizeof(Elf64_Phdr);
6f713d18144ce8 Hari Bathini  2019-09-11  394  		phdr->p_type	= cpu_to_be32(PT_LOAD);
6f713d18144ce8 Hari Bathini  2019-09-11  395  		phdr->p_flags	= cpu_to_be32(PF_R|PF_W|PF_X);
6f713d18144ce8 Hari Bathini  2019-09-11  396  		phdr->p_align	= 0;
6f713d18144ce8 Hari Bathini  2019-09-11  397  
6f713d18144ce8 Hari Bathini  2019-09-11  398  		new = get_new_element();
6f713d18144ce8 Hari Bathini  2019-09-11  399  		if (!new)
6f713d18144ce8 Hari Bathini  2019-09-11  400  			return -ENOMEM;
6f713d18144ce8 Hari Bathini  2019-09-11  401  		new->paddr  = oc_conf->ptload_addr[i];
6f713d18144ce8 Hari Bathini  2019-09-11  402  		new->size   = oc_conf->ptload_size[i];
6f713d18144ce8 Hari Bathini  2019-09-11  403  		new->offset = opalcore_off;
6f713d18144ce8 Hari Bathini  2019-09-11  404  		list_add_tail(&new->list, &opalcore_list);
6f713d18144ce8 Hari Bathini  2019-09-11  405  
6f713d18144ce8 Hari Bathini  2019-09-11  406  		phdr->p_paddr	= cpu_to_be64(paddr);
6f713d18144ce8 Hari Bathini  2019-09-11  407  		phdr->p_vaddr	= cpu_to_be64(opal_base_addr + paddr);
6f713d18144ce8 Hari Bathini  2019-09-11 @408  		phdr->p_filesz	= phdr->p_memsz  =
6f713d18144ce8 Hari Bathini  2019-09-11  409  			cpu_to_be64(oc_conf->ptload_size[i]);
6f713d18144ce8 Hari Bathini  2019-09-11  410  		phdr->p_offset	= cpu_to_be64(opalcore_off);
6f713d18144ce8 Hari Bathini  2019-09-11  411  
6f713d18144ce8 Hari Bathini  2019-09-11  412  		count++;
6f713d18144ce8 Hari Bathini  2019-09-11  413  		opalcore_off += oc_conf->ptload_size[i];
6f713d18144ce8 Hari Bathini  2019-09-11  414  		paddr += oc_conf->ptload_size[i];
6f713d18144ce8 Hari Bathini  2019-09-11  415  	}
6f713d18144ce8 Hari Bathini  2019-09-11  416  
6f713d18144ce8 Hari Bathini  2019-09-11  417  	elf->e_phnum = cpu_to_be16(count);
6f713d18144ce8 Hari Bathini  2019-09-11  418  
6f713d18144ce8 Hari Bathini  2019-09-11  419  	bufp = (char *)opalcore_append_cpu_notes((Elf64_Word *)bufp);
6f713d18144ce8 Hari Bathini  2019-09-11  420  	bufp = (char *)auxv_to_elf64_notes((Elf64_Word *)bufp, opal_boot_entry);
6f713d18144ce8 Hari Bathini  2019-09-11  421  
6f713d18144ce8 Hari Bathini  2019-09-11  422  	oc_conf->opalcore_size = opalcore_off;
6f713d18144ce8 Hari Bathini  2019-09-11  423  	return 0;
6f713d18144ce8 Hari Bathini  2019-09-11  424  }
6f713d18144ce8 Hari Bathini  2019-09-11  425  
6f713d18144ce8 Hari Bathini  2019-09-11  426  static void opalcore_cleanup(void)
6f713d18144ce8 Hari Bathini  2019-09-11  427  {
6f713d18144ce8 Hari Bathini  2019-09-11  428  	if (oc_conf == NULL)
6f713d18144ce8 Hari Bathini  2019-09-11  429  		return;
6f713d18144ce8 Hari Bathini  2019-09-11  430  
6f713d18144ce8 Hari Bathini  2019-09-11  431  	/* Remove OPAL core sysfs file */
8852c07a881b0a Sourabh Jain  2019-12-11  432  	sysfs_remove_bin_file(mpipl_kobj, &opal_core_attr);
6f713d18144ce8 Hari Bathini  2019-09-11  433  	oc_conf->ptload_phdr = NULL;
6f713d18144ce8 Hari Bathini  2019-09-11  434  	oc_conf->ptload_cnt = 0;
6f713d18144ce8 Hari Bathini  2019-09-11  435  
6f713d18144ce8 Hari Bathini  2019-09-11  436  	/* free the buffer used for setting up OPAL core */
6f713d18144ce8 Hari Bathini  2019-09-11  437  	if (oc_conf->opalcorebuf) {
6f713d18144ce8 Hari Bathini  2019-09-11  438  		void *end = (void *)((u64)oc_conf->opalcorebuf +
6f713d18144ce8 Hari Bathini  2019-09-11  439  				     oc_conf->opalcorebuf_sz);
6f713d18144ce8 Hari Bathini  2019-09-11  440  
6f713d18144ce8 Hari Bathini  2019-09-11  441  		free_reserved_area(oc_conf->opalcorebuf, end, -1, NULL);
6f713d18144ce8 Hari Bathini  2019-09-11  442  		oc_conf->opalcorebuf = NULL;
6f713d18144ce8 Hari Bathini  2019-09-11  443  		oc_conf->opalcorebuf_sz = 0;
6f713d18144ce8 Hari Bathini  2019-09-11  444  	}
6f713d18144ce8 Hari Bathini  2019-09-11  445  
6f713d18144ce8 Hari Bathini  2019-09-11  446  	kfree(oc_conf);
6f713d18144ce8 Hari Bathini  2019-09-11  447  	oc_conf = NULL;
6f713d18144ce8 Hari Bathini  2019-09-11  448  }
6f713d18144ce8 Hari Bathini  2019-09-11  449  __exitcall(opalcore_cleanup);
6f713d18144ce8 Hari Bathini  2019-09-11  450  
6f713d18144ce8 Hari Bathini  2019-09-11  451  static void __init opalcore_config_init(void)
6f713d18144ce8 Hari Bathini  2019-09-11  452  {
6f713d18144ce8 Hari Bathini  2019-09-11  453  	u32 idx, cpu_data_version;
6f713d18144ce8 Hari Bathini  2019-09-11  454  	struct device_node *np;
6f713d18144ce8 Hari Bathini  2019-09-11  455  	const __be32 *prop;
6f713d18144ce8 Hari Bathini  2019-09-11  456  	u64 addr = 0;
6f713d18144ce8 Hari Bathini  2019-09-11  457  	int i, ret;
6f713d18144ce8 Hari Bathini  2019-09-11  458  
6f713d18144ce8 Hari Bathini  2019-09-11  459  	np = of_find_node_by_path("/ibm,opal/dump");
6f713d18144ce8 Hari Bathini  2019-09-11  460  	if (np == NULL)
6f713d18144ce8 Hari Bathini  2019-09-11  461  		return;
6f713d18144ce8 Hari Bathini  2019-09-11  462  
6f713d18144ce8 Hari Bathini  2019-09-11  463  	if (!of_device_is_compatible(np, "ibm,opal-dump")) {
6f713d18144ce8 Hari Bathini  2019-09-11  464  		pr_warn("Support missing for this f/w version!\n");
6f713d18144ce8 Hari Bathini  2019-09-11  465  		return;
6f713d18144ce8 Hari Bathini  2019-09-11  466  	}
6f713d18144ce8 Hari Bathini  2019-09-11  467  
6f713d18144ce8 Hari Bathini  2019-09-11  468  	/* Check if dump has been initiated on last reboot */
6f713d18144ce8 Hari Bathini  2019-09-11  469  	prop = of_get_property(np, "mpipl-boot", NULL);
6f713d18144ce8 Hari Bathini  2019-09-11  470  	if (!prop) {
6f713d18144ce8 Hari Bathini  2019-09-11  471  		of_node_put(np);
6f713d18144ce8 Hari Bathini  2019-09-11  472  		return;
6f713d18144ce8 Hari Bathini  2019-09-11  473  	}
6f713d18144ce8 Hari Bathini  2019-09-11  474  
6f713d18144ce8 Hari Bathini  2019-09-11  475  	/* Get OPAL metadata */
6f713d18144ce8 Hari Bathini  2019-09-11 @476  	ret = opal_mpipl_query_tag(OPAL_MPIPL_TAG_OPAL, &addr);
6f713d18144ce8 Hari Bathini  2019-09-11  477  	if ((ret != OPAL_SUCCESS) || !addr) {
6f713d18144ce8 Hari Bathini  2019-09-11  478  		pr_err("Failed to get OPAL metadata (%d)\n", ret);
6f713d18144ce8 Hari Bathini  2019-09-11  479  		goto error_out;
6f713d18144ce8 Hari Bathini  2019-09-11  480  	}
6f713d18144ce8 Hari Bathini  2019-09-11  481  
6f713d18144ce8 Hari Bathini  2019-09-11  482  	addr = be64_to_cpu(addr);
6f713d18144ce8 Hari Bathini  2019-09-11  483  	pr_debug("OPAL metadata addr: %llx\n", addr);
6f713d18144ce8 Hari Bathini  2019-09-11  484  	opalc_metadata = __va(addr);
6f713d18144ce8 Hari Bathini  2019-09-11  485  
6f713d18144ce8 Hari Bathini  2019-09-11  486  	/* Get OPAL CPU metadata */
6f713d18144ce8 Hari Bathini  2019-09-11  487  	ret = opal_mpipl_query_tag(OPAL_MPIPL_TAG_CPU, &addr);
6f713d18144ce8 Hari Bathini  2019-09-11  488  	if ((ret != OPAL_SUCCESS) || !addr) {
6f713d18144ce8 Hari Bathini  2019-09-11  489  		pr_err("Failed to get OPAL CPU metadata (%d)\n", ret);
6f713d18144ce8 Hari Bathini  2019-09-11  490  		goto error_out;
6f713d18144ce8 Hari Bathini  2019-09-11  491  	}
6f713d18144ce8 Hari Bathini  2019-09-11  492  
6f713d18144ce8 Hari Bathini  2019-09-11  493  	addr = be64_to_cpu(addr);
6f713d18144ce8 Hari Bathini  2019-09-11  494  	pr_debug("CPU metadata addr: %llx\n", addr);
6f713d18144ce8 Hari Bathini  2019-09-11  495  	opalc_cpu_metadata = __va(addr);
6f713d18144ce8 Hari Bathini  2019-09-11  496  
6f713d18144ce8 Hari Bathini  2019-09-11  497  	/* Allocate memory for config buffer */
6f713d18144ce8 Hari Bathini  2019-09-11  498  	oc_conf = kzalloc(sizeof(struct opalcore_config), GFP_KERNEL);
6f713d18144ce8 Hari Bathini  2019-09-11  499  	if (oc_conf == NULL)
6f713d18144ce8 Hari Bathini  2019-09-11  500  		goto error_out;
6f713d18144ce8 Hari Bathini  2019-09-11  501  
6f713d18144ce8 Hari Bathini  2019-09-11  502  	/* Parse OPAL metadata */
6f713d18144ce8 Hari Bathini  2019-09-11  503  	if (opalc_metadata->version != OPAL_MPIPL_VERSION) {
6f713d18144ce8 Hari Bathini  2019-09-11  504  		pr_warn("Supported OPAL metadata version: %u, found: %u!\n",
6f713d18144ce8 Hari Bathini  2019-09-11  505  			OPAL_MPIPL_VERSION, opalc_metadata->version);
6f713d18144ce8 Hari Bathini  2019-09-11  506  		pr_warn("WARNING: F/W using newer OPAL metadata format!!\n");
6f713d18144ce8 Hari Bathini  2019-09-11  507  	}
6f713d18144ce8 Hari Bathini  2019-09-11  508  
6f713d18144ce8 Hari Bathini  2019-09-11  509  	oc_conf->ptload_cnt = 0;
6f713d18144ce8 Hari Bathini  2019-09-11  510  	idx = be32_to_cpu(opalc_metadata->region_cnt);
6f713d18144ce8 Hari Bathini  2019-09-11  511  	if (idx > MAX_PT_LOAD_CNT) {
6f713d18144ce8 Hari Bathini  2019-09-11  512  		pr_warn("WARNING: OPAL regions count (%d) adjusted to limit (%d)",
8ec5cb12cd957e Qinglang Miao 2020-09-16  513  			idx, MAX_PT_LOAD_CNT);
6f713d18144ce8 Hari Bathini  2019-09-11  514  		idx = MAX_PT_LOAD_CNT;
6f713d18144ce8 Hari Bathini  2019-09-11  515  	}
6f713d18144ce8 Hari Bathini  2019-09-11  516  	for (i = 0; i < idx; i++) {
6f713d18144ce8 Hari Bathini  2019-09-11  517  		oc_conf->ptload_addr[oc_conf->ptload_cnt] =
6f713d18144ce8 Hari Bathini  2019-09-11  518  				be64_to_cpu(opalc_metadata->region[i].dest);
6f713d18144ce8 Hari Bathini  2019-09-11  519  		oc_conf->ptload_size[oc_conf->ptload_cnt++] =
6f713d18144ce8 Hari Bathini  2019-09-11  520  				be64_to_cpu(opalc_metadata->region[i].size);
6f713d18144ce8 Hari Bathini  2019-09-11  521  	}
6f713d18144ce8 Hari Bathini  2019-09-11  522  	oc_conf->ptload_cnt = i;
6f713d18144ce8 Hari Bathini  2019-09-11  523  	oc_conf->crashing_cpu = be32_to_cpu(opalc_metadata->crashing_pir);
6f713d18144ce8 Hari Bathini  2019-09-11  524  
6f713d18144ce8 Hari Bathini  2019-09-11  525  	if (!oc_conf->ptload_cnt) {
6f713d18144ce8 Hari Bathini  2019-09-11  526  		pr_err("OPAL memory regions not found\n");
6f713d18144ce8 Hari Bathini  2019-09-11  527  		goto error_out;
6f713d18144ce8 Hari Bathini  2019-09-11  528  	}
6f713d18144ce8 Hari Bathini  2019-09-11  529  
6f713d18144ce8 Hari Bathini  2019-09-11  530  	/* Parse OPAL CPU metadata */
6f713d18144ce8 Hari Bathini  2019-09-11  531  	cpu_data_version = be32_to_cpu(opalc_cpu_metadata->cpu_data_version);
6f713d18144ce8 Hari Bathini  2019-09-11  532  	if (cpu_data_version != HDAT_FADUMP_CPU_DATA_VER) {
6f713d18144ce8 Hari Bathini  2019-09-11  533  		pr_warn("Supported CPU data version: %u, found: %u!\n",
6f713d18144ce8 Hari Bathini  2019-09-11  534  			HDAT_FADUMP_CPU_DATA_VER, cpu_data_version);
6f713d18144ce8 Hari Bathini  2019-09-11  535  		pr_warn("WARNING: F/W using newer CPU state data format!!\n");
6f713d18144ce8 Hari Bathini  2019-09-11  536  	}
6f713d18144ce8 Hari Bathini  2019-09-11  537  
6f713d18144ce8 Hari Bathini  2019-09-11  538  	addr = be64_to_cpu(opalc_cpu_metadata->region[0].dest);
6f713d18144ce8 Hari Bathini  2019-09-11  539  	if (!addr) {
6f713d18144ce8 Hari Bathini  2019-09-11  540  		pr_err("CPU state data not found!\n");
6f713d18144ce8 Hari Bathini  2019-09-11  541  		goto error_out;
6f713d18144ce8 Hari Bathini  2019-09-11  542  	}
6f713d18144ce8 Hari Bathini  2019-09-11  543  	oc_conf->cpu_state_destination_vaddr = (u64)__va(addr);
6f713d18144ce8 Hari Bathini  2019-09-11  544  
6f713d18144ce8 Hari Bathini  2019-09-11  545  	oc_conf->cpu_state_data_size =
6f713d18144ce8 Hari Bathini  2019-09-11  546  			be64_to_cpu(opalc_cpu_metadata->region[0].size);
6f713d18144ce8 Hari Bathini  2019-09-11  547  	oc_conf->cpu_state_entry_size =
6f713d18144ce8 Hari Bathini  2019-09-11  548  			be32_to_cpu(opalc_cpu_metadata->cpu_data_size);
6f713d18144ce8 Hari Bathini  2019-09-11  549  
6f713d18144ce8 Hari Bathini  2019-09-11  550  	if ((oc_conf->cpu_state_entry_size == 0) ||
6f713d18144ce8 Hari Bathini  2019-09-11  551  	    (oc_conf->cpu_state_entry_size > oc_conf->cpu_state_data_size)) {
6f713d18144ce8 Hari Bathini  2019-09-11  552  		pr_err("CPU state data is invalid.\n");
6f713d18144ce8 Hari Bathini  2019-09-11  553  		goto error_out;
6f713d18144ce8 Hari Bathini  2019-09-11  554  	}
6f713d18144ce8 Hari Bathini  2019-09-11  555  	oc_conf->num_cpus = (oc_conf->cpu_state_data_size /
6f713d18144ce8 Hari Bathini  2019-09-11  556  			     oc_conf->cpu_state_entry_size);
6f713d18144ce8 Hari Bathini  2019-09-11  557  
6f713d18144ce8 Hari Bathini  2019-09-11  558  	of_node_put(np);
6f713d18144ce8 Hari Bathini  2019-09-11  559  	return;
6f713d18144ce8 Hari Bathini  2019-09-11  560  
6f713d18144ce8 Hari Bathini  2019-09-11  561  error_out:
6f713d18144ce8 Hari Bathini  2019-09-11  562  	pr_err("Could not export /sys/firmware/opal/core\n");
6f713d18144ce8 Hari Bathini  2019-09-11  563  	opalcore_cleanup();
6f713d18144ce8 Hari Bathini  2019-09-11  564  	of_node_put(np);
6f713d18144ce8 Hari Bathini  2019-09-11  565  }
6f713d18144ce8 Hari Bathini  2019-09-11  566  

:::::: The code at line 476 was first introduced by commit
:::::: 6f713d18144ce86c9f01cdf64222d6339e26129e powerpc/opalcore: export /sys/firmware/opal/core for analysing opal crashes

:::::: TO: Hari Bathini <hbathini@linux.vnet.ibm.com>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
