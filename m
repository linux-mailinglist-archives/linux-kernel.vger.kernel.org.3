Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE0BD49BBF7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 20:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbiAYTTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 14:19:00 -0500
Received: from mga03.intel.com ([134.134.136.65]:10485 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229828AbiAYTSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 14:18:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643138299; x=1674674299;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=evJxF1XGCQmBvOWRGkG7AGve71m4zL3Stp7FwQgwURE=;
  b=Ivl3FYgXXLFxVAicbGO8sl4LYQW4ueEfZzMeWwFx1K4kzQRcNCzUzZYL
   j7Xy8ehWFz9Zks/zhJybuexi27LplkcKaK3bZMxw3qWnsj4urp5CQRE+K
   41BMP2YI08kbNkRXL/asahRpfS5fsrR2c5pjhoi2vMVke4ok+B2QVI1ns
   oHdd6Qv020USk1Cddylru2Q/JeWR/G+GfZTcMmdFPncGSsQtk7bgAfFjq
   sIzQ1Z9GHjL6UAEqbTuCldgtI7nXUtOBLl83T21RGZBvjvstbYdMtFc4z
   nmdJ+rzt1sNTDizvw8LMVFUu6ZlMw1x2uFEhSvBWAnSn2kJ5fYHp1qXBu
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="246338181"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="246338181"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 11:18:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="477228170"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 25 Jan 2022 11:18:16 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCRKZ-000KLv-Rk; Tue, 25 Jan 2022 19:18:15 +0000
Date:   Wed, 26 Jan 2022 03:17:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>
Subject: [morse:mpam/snapshot/v5.16 88/137] include/linux/cacheinfo.h:114:10:
 warning: implicit conversion from 'unsigned long long' to 'unsigned long'
 changes value from 18446744073709551615 to 4294967295
Message-ID: <202201260326.obpo9ntU-lkp@intel.com>
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
config: arm-shannon_defconfig (https://download.01.org/0day-ci/archive/20220126/202201260326.obpo9ntU-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 997e128e2a78f5a5434fc75997441ae1ee76f8a4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?id=626a68b7eb02b0a0bb7faaa4b91371c2f3d550d0
        git remote add morse https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git
        git fetch --no-tags morse mpam/snapshot/v5.16
        git checkout 626a68b7eb02b0a0bb7faaa4b91371c2f3d550d0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/base/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/base/cacheinfo.c:12:
>> include/linux/cacheinfo.h:114:10: warning: implicit conversion from 'unsigned long long' to 'unsigned long' changes value from 18446744073709551615 to 4294967295 [-Wconstant-conversion]
                   return ~0ULL;
                   ~~~~~~ ^~~~~
   include/linux/cacheinfo.h:120:11: warning: implicit conversion from 'unsigned long long' to 'unsigned long' changes value from 18446744073709551615 to 4294967295 [-Wconstant-conversion]
                           return ~0ULL;
                           ~~~~~~ ^~~~~
   include/linux/cacheinfo.h:124:9: warning: implicit conversion from 'unsigned long long' to 'unsigned long' changes value from 18446744073709551615 to 4294967295 [-Wconstant-conversion]
           return ~0ULL;
           ~~~~~~ ^~~~~
   3 warnings generated.


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
