Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D01BE49BC18
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 20:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiAYT3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 14:29:23 -0500
Received: from mga03.intel.com ([134.134.136.65]:11326 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229950AbiAYT3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 14:29:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643138958; x=1674674958;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hQmnd2z0xZ1yNKAyq7oRxRm6ON7kmbBDck/k3cU4e44=;
  b=kAAakVFDdQeo7s3JHUtAvnnnmNn/jQ4sH+6Qm2Jh3+SxkYnv4oSOaFmv
   g+CfsENUiEoes0Vsd6xb2zDxWo6z36Zl2tQWx5XoIuOhWEq7gJoKG2GmY
   an3cIty+j06VSorKshCDoe+hGZvO9TxMi5RHK7nocWNR2AfivZdf+kRf+
   DBs9acGbCVwCyiwtW88FKUV7vwSdpgfc3OiqZ8Jyl3JBHNDDCY3+AgeO8
   D0QazkgGwMoMGyku3fX8pcoZ2K6CSIa/Vb68fBDcuq9SU2Q91Gkzvb5zl
   eIzqnzwv2RIgRnhPgNfrm4w6gIa0NCepDV9YtTiQgjSZrn1v+BX9rzz5n
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="246339983"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="246339983"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 11:29:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="563159521"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 25 Jan 2022 11:29:17 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCRVE-000KNA-QX; Tue, 25 Jan 2022 19:29:16 +0000
Date:   Wed, 26 Jan 2022 03:28:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        James Morse <james.morse@arm.com>
Subject: [morse:mpam/snapshot/v5.16 88/137] include/linux/cacheinfo.h:114:24:
 warning: conversion from 'long long unsigned int' to 'long unsigned int'
 changes value from '18446744073709551615' to '4294967295'
Message-ID: <202201260308.f359R4GZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/snapshot/v5.16
head:   364c1c42b229912132e1615c2ce15be7154e2156
commit: 626a68b7eb02b0a0bb7faaa4b91371c2f3d550d0 [88/137] cacheinfo: Allow for >32-bit cache 'id'
config: arc-randconfig-r043-20220124 (https://download.01.org/0day-ci/archive/20220126/202201260308.f359R4GZ-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?id=626a68b7eb02b0a0bb7faaa4b91371c2f3d550d0
        git remote add morse https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git
        git fetch --no-tags morse mpam/snapshot/v5.16
        git checkout 626a68b7eb02b0a0bb7faaa4b91371c2f3d550d0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/base/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/base/cacheinfo.c:12:
   include/linux/cacheinfo.h: In function 'get_cpu_cacheinfo_id':
>> include/linux/cacheinfo.h:114:24: warning: conversion from 'long long unsigned int' to 'long unsigned int' changes value from '18446744073709551615' to '4294967295' [-Woverflow]
     114 |                 return ~0ULL;
         |                        ^
   include/linux/cacheinfo.h:120:32: warning: conversion from 'long long unsigned int' to 'long unsigned int' changes value from '18446744073709551615' to '4294967295' [-Woverflow]
     120 |                         return ~0ULL;
         |                                ^
   include/linux/cacheinfo.h:124:16: warning: conversion from 'long long unsigned int' to 'long unsigned int' changes value from '18446744073709551615' to '4294967295' [-Woverflow]
     124 |         return ~0ULL;
         |                ^


vim +114 include/linux/cacheinfo.h

   103	
   104	/*
   105	 * Get the id of the cache associated with @cpu at level @level.
   106	 * cpuhp lock must be held.
   107	 */
   108	static inline unsigned long get_cpu_cacheinfo_id(int cpu, int level)
   109	{
   110		struct cpu_cacheinfo *ci = get_cpu_cacheinfo(cpu);
   111		int i;
   112	
   113		if (!ci->info_list)
 > 114			return ~0ULL;
   115	
   116		for (i = 0; i < ci->num_leaves; i++) {
   117			if (ci->info_list[i].level == level) {
   118				if (ci->info_list[i].attributes & CACHE_ID)
   119					return ci->info_list[i].id;
   120				return ~0ULL;
   121			}
   122		}
   123	
   124		return ~0ULL;
   125	}
   126	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
