Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C77B347F5BD
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 08:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbhLZH5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 02:57:40 -0500
Received: from mga14.intel.com ([192.55.52.115]:58883 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231391AbhLZH5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 02:57:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640505457; x=1672041457;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7UbGYVOSE8MHNmUljL2c070I51qeY+M0ffN1fUVhsRE=;
  b=LWeBfHjTyo88xBYaz0VUHL5TuInKXMdalRt/QXrYRJqCSWU4e9AqGRHf
   F0P7+D/YuXHFWYhxWWdVxwcsS/umv6T8BCGR/ryRXl2PAB5qhxNzKBfl3
   R3n+NRBe8yHi+cYbiR5FSwRhLTPw72NP7CKXVcKYuAj6LqCSNrASY9c/b
   xgXiKvdLCjLc1m39y3iTXgMk13BQ2snJPyBeSn6kRGhCj19JKb8p+vQOj
   ZqdgTBDMoXNdvpU7H2r0Unk1JoHD/FLJbLai/sVdmZi5dJogfoqUU1t7V
   ucgmvFEAf376F9JfMubYvYjgY8JeuymV+jJEgo0yjI5b0kJfOc3Qyq02s
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10208"; a="241311145"
X-IronPort-AV: E=Sophos;i="5.88,236,1635231600"; 
   d="scan'208";a="241311145"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2021 23:57:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,236,1635231600"; 
   d="scan'208";a="608785303"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Dec 2021 23:57:35 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n1OPP-0005DF-5w; Sun, 26 Dec 2021 07:57:35 +0000
Date:   Sun, 26 Dec 2021 15:56:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: arch/powerpc/include/asm/kvm_ppc.h:978:1: sparse: sparse: incorrect
 type in assignment (different base types)
Message-ID: <202112261319.PcKYcgDi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e2ae0d4a6b0ba461542f0fd0ba0b828658013e9f
commit: d991bb1c8da842a2a0b9dc83b1005e655783f861 include/linux/compiler-gcc.h: sparse can do constant folding of __builtin_bswap*()
date:   8 months ago
config: powerpc64-randconfig-s032-20211226 (https://download.01.org/0day-ci/archive/20211226/202112261319.PcKYcgDi-lkp@intel.com/config)
compiler: powerpc64le-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d991bb1c8da842a2a0b9dc83b1005e655783f861
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d991bb1c8da842a2a0b9dc83b1005e655783f861
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/kvm/ drivers/misc/ drivers/pinctrl/nuvoton/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   arch/powerpc/include/asm/kvm_ppc.h:977:1: sparse:     expected unsigned int [usertype] int_pending
   arch/powerpc/include/asm/kvm_ppc.h:977:1: sparse:     got restricted __le32 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] dar @@     got restricted __be64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse:     expected unsigned long long [usertype] dar
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse:     got restricted __be64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] dar @@     got restricted __le64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse:     expected unsigned long long [usertype] dar
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse:     got restricted __le64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:976:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] dsisr @@     got restricted __be32 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:976:1: sparse:     expected unsigned int [usertype] dsisr
   arch/powerpc/include/asm/kvm_ppc.h:976:1: sparse:     got restricted __be32 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:976:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] dsisr @@     got restricted __le32 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:976:1: sparse:     expected unsigned int [usertype] dsisr
   arch/powerpc/include/asm/kvm_ppc.h:976:1: sparse:     got restricted __le32 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:959:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:959:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:968:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:968:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:968:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:968:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:968:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:968:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:968:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:968:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:977:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] int_pending @@     got restricted __be32 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:977:1: sparse:     expected unsigned int [usertype] int_pending
   arch/powerpc/include/asm/kvm_ppc.h:977:1: sparse:     got restricted __be32 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:977:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] int_pending @@     got restricted __le32 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:977:1: sparse:     expected unsigned int [usertype] int_pending
   arch/powerpc/include/asm/kvm_ppc.h:977:1: sparse:     got restricted __le32 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:977:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] int_pending @@     got restricted __be32 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:977:1: sparse:     expected unsigned int [usertype] int_pending
   arch/powerpc/include/asm/kvm_ppc.h:977:1: sparse:     got restricted __be32 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:977:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] int_pending @@     got restricted __le32 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:977:1: sparse:     expected unsigned int [usertype] int_pending
   arch/powerpc/include/asm/kvm_ppc.h:977:1: sparse:     got restricted __le32 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:968:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:968:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:968:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:968:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:968:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:968:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:968:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:968:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:965:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:965:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:960:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:960:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:961:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:961:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:962:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:962:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:963:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:963:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:978:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:978:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:979:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:979:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:980:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:980:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:981:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:981:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] srr0 @@     got restricted __be64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse:     expected unsigned long long [usertype] srr0
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse:     got restricted __be64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] srr0 @@     got restricted __le64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse:     expected unsigned long long [usertype] srr0
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse:     got restricted __le64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:965:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] srr1 @@     got restricted __be64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:965:1: sparse:     expected unsigned long long [usertype] srr1
   arch/powerpc/include/asm/kvm_ppc.h:965:1: sparse:     got restricted __be64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:965:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] srr1 @@     got restricted __le64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:965:1: sparse:     expected unsigned long long [usertype] srr1
   arch/powerpc/include/asm/kvm_ppc.h:965:1: sparse:     got restricted __le64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:960:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sprg0 @@     got restricted __be64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:960:1: sparse:     expected unsigned long long [usertype] sprg0
   arch/powerpc/include/asm/kvm_ppc.h:960:1: sparse:     got restricted __be64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:960:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sprg0 @@     got restricted __le64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:960:1: sparse:     expected unsigned long long [usertype] sprg0
   arch/powerpc/include/asm/kvm_ppc.h:960:1: sparse:     got restricted __le64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:961:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sprg1 @@     got restricted __be64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:961:1: sparse:     expected unsigned long long [usertype] sprg1
   arch/powerpc/include/asm/kvm_ppc.h:961:1: sparse:     got restricted __be64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:961:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sprg1 @@     got restricted __le64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:961:1: sparse:     expected unsigned long long [usertype] sprg1
   arch/powerpc/include/asm/kvm_ppc.h:961:1: sparse:     got restricted __le64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:962:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sprg2 @@     got restricted __be64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:962:1: sparse:     expected unsigned long long [usertype] sprg2
   arch/powerpc/include/asm/kvm_ppc.h:962:1: sparse:     got restricted __be64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:962:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sprg2 @@     got restricted __le64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:962:1: sparse:     expected unsigned long long [usertype] sprg2
   arch/powerpc/include/asm/kvm_ppc.h:962:1: sparse:     got restricted __le64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:963:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sprg3 @@     got restricted __be64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:963:1: sparse:     expected unsigned long long [usertype] sprg3
   arch/powerpc/include/asm/kvm_ppc.h:963:1: sparse:     got restricted __be64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:963:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sprg3 @@     got restricted __le64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:963:1: sparse:     expected unsigned long long [usertype] sprg3
   arch/powerpc/include/asm/kvm_ppc.h:963:1: sparse:     got restricted __le64 [usertype]
>> arch/powerpc/include/asm/kvm_ppc.h:978:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sprg4 @@     got restricted __be64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:978:1: sparse:     expected unsigned long long [usertype] sprg4
   arch/powerpc/include/asm/kvm_ppc.h:978:1: sparse:     got restricted __be64 [usertype]
>> arch/powerpc/include/asm/kvm_ppc.h:978:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sprg4 @@     got restricted __le64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:978:1: sparse:     expected unsigned long long [usertype] sprg4
   arch/powerpc/include/asm/kvm_ppc.h:978:1: sparse:     got restricted __le64 [usertype]
>> arch/powerpc/include/asm/kvm_ppc.h:979:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sprg5 @@     got restricted __be64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:979:1: sparse:     expected unsigned long long [usertype] sprg5
   arch/powerpc/include/asm/kvm_ppc.h:979:1: sparse:     got restricted __be64 [usertype]
>> arch/powerpc/include/asm/kvm_ppc.h:979:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sprg5 @@     got restricted __le64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:979:1: sparse:     expected unsigned long long [usertype] sprg5
   arch/powerpc/include/asm/kvm_ppc.h:979:1: sparse:     got restricted __le64 [usertype]
>> arch/powerpc/include/asm/kvm_ppc.h:980:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sprg6 @@     got restricted __be64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:980:1: sparse:     expected unsigned long long [usertype] sprg6
   arch/powerpc/include/asm/kvm_ppc.h:980:1: sparse:     got restricted __be64 [usertype]
>> arch/powerpc/include/asm/kvm_ppc.h:980:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sprg6 @@     got restricted __le64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:980:1: sparse:     expected unsigned long long [usertype] sprg6
   arch/powerpc/include/asm/kvm_ppc.h:980:1: sparse:     got restricted __le64 [usertype]
>> arch/powerpc/include/asm/kvm_ppc.h:981:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sprg7 @@     got restricted __be64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:981:1: sparse:     expected unsigned long long [usertype] sprg7
   arch/powerpc/include/asm/kvm_ppc.h:981:1: sparse:     got restricted __be64 [usertype]
>> arch/powerpc/include/asm/kvm_ppc.h:981:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sprg7 @@     got restricted __le64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:981:1: sparse:     expected unsigned long long [usertype] sprg7
   arch/powerpc/include/asm/kvm_ppc.h:981:1: sparse:     got restricted __le64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:976:1: sparse: sparse: cast to restricted __be32
   arch/powerpc/include/asm/kvm_ppc.h:976:1: sparse: sparse: cast to restricted __le32
   arch/powerpc/include/asm/kvm_ppc.h:976:1: sparse: sparse: cast to restricted __be32
   arch/powerpc/include/asm/kvm_ppc.h:976:1: sparse: sparse: cast to restricted __le32
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] dar @@     got restricted __be64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse:     expected unsigned long long [usertype] dar
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse:     got restricted __be64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] dar @@     got restricted __le64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse:     expected unsigned long long [usertype] dar
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse:     got restricted __le64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:976:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] dsisr @@     got restricted __be32 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:976:1: sparse:     expected unsigned int [usertype] dsisr
   arch/powerpc/include/asm/kvm_ppc.h:976:1: sparse:     got restricted __be32 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:976:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] dsisr @@     got restricted __le32 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:976:1: sparse:     expected unsigned int [usertype] dsisr
   arch/powerpc/include/asm/kvm_ppc.h:976:1: sparse:     got restricted __le32 [usertype]

vim +978 arch/powerpc/include/asm/kvm_ppc.h

1dc0c5b88cae1c Bharat Bhushan 2014-07-17  958  
5deb8e7ad8ac7e Alexander Graf 2014-04-24  959  SHARED_WRAPPER(critical, 64)
1dc0c5b88cae1c Bharat Bhushan 2014-07-17  960  SHARED_SPRNG_WRAPPER(sprg0, 64, SPRN_GSPRG0)
1dc0c5b88cae1c Bharat Bhushan 2014-07-17  961  SHARED_SPRNG_WRAPPER(sprg1, 64, SPRN_GSPRG1)
1dc0c5b88cae1c Bharat Bhushan 2014-07-17  962  SHARED_SPRNG_WRAPPER(sprg2, 64, SPRN_GSPRG2)
1dc0c5b88cae1c Bharat Bhushan 2014-07-17  963  SHARED_SPRNG_WRAPPER(sprg3, 64, SPRN_GSPRG3)
1dc0c5b88cae1c Bharat Bhushan 2014-07-17  964  SHARED_SPRNG_WRAPPER(srr0, 64, SPRN_GSRR0)
1dc0c5b88cae1c Bharat Bhushan 2014-07-17  965  SHARED_SPRNG_WRAPPER(srr1, 64, SPRN_GSRR1)
1dc0c5b88cae1c Bharat Bhushan 2014-07-17  966  SHARED_SPRNG_WRAPPER(dar, 64, SPRN_GDEAR)
dc168549d9a0fb Bharat Bhushan 2014-07-17  967  SHARED_SPRNG_WRAPPER(esr, 64, SPRN_GESR)
5deb8e7ad8ac7e Alexander Graf 2014-04-24  968  SHARED_WRAPPER_GET(msr, 64)
5deb8e7ad8ac7e Alexander Graf 2014-04-24  969  static inline void kvmppc_set_msr_fast(struct kvm_vcpu *vcpu, u64 val)
5deb8e7ad8ac7e Alexander Graf 2014-04-24  970  {
5deb8e7ad8ac7e Alexander Graf 2014-04-24  971  	if (kvmppc_shared_big_endian(vcpu))
5deb8e7ad8ac7e Alexander Graf 2014-04-24  972  	       vcpu->arch.shared->msr = cpu_to_be64(val);
5deb8e7ad8ac7e Alexander Graf 2014-04-24  973  	else
5deb8e7ad8ac7e Alexander Graf 2014-04-24  974  	       vcpu->arch.shared->msr = cpu_to_le64(val);
5deb8e7ad8ac7e Alexander Graf 2014-04-24  975  }
5deb8e7ad8ac7e Alexander Graf 2014-04-24  976  SHARED_WRAPPER(dsisr, 32)
5deb8e7ad8ac7e Alexander Graf 2014-04-24  977  SHARED_WRAPPER(int_pending, 32)
5deb8e7ad8ac7e Alexander Graf 2014-04-24 @978  SHARED_WRAPPER(sprg4, 64)
5deb8e7ad8ac7e Alexander Graf 2014-04-24 @979  SHARED_WRAPPER(sprg5, 64)
5deb8e7ad8ac7e Alexander Graf 2014-04-24 @980  SHARED_WRAPPER(sprg6, 64)
5deb8e7ad8ac7e Alexander Graf 2014-04-24 @981  SHARED_WRAPPER(sprg7, 64)
5deb8e7ad8ac7e Alexander Graf 2014-04-24  982  

:::::: The code at line 978 was first introduced by commit
:::::: 5deb8e7ad8ac7e3fcdfa042acff617f461b361c2 KVM: PPC: Make shared struct aka magic page guest endian

:::::: TO: Alexander Graf <agraf@suse.de>
:::::: CC: Alexander Graf <agraf@suse.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
