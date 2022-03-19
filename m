Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409294DE982
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 18:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242724AbiCSRYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 13:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbiCSRYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 13:24:00 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADA138DB4
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 10:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647710549; x=1679246549;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FgdLANoOm6JRYmQUeu2du7UYS69qPbqawhiszw7q6KA=;
  b=dgsNAVcOvxCs9uluaUaaxC3SBHDyeeTOOoAiaO6RD8tj0c00+Va7kttv
   vKTjiv+HgMdp8yXgJOlXXtuA+KNQU8KZhcGPvEHyKl4U6Y+VdJEgdAqSr
   NB1/1HfRXU9BW8X8utxqA/oHoJyWRnVny5bpya7s8pbsn/cTQtaLzTtaD
   zH/drmFphlEJkHgRF/cNc24N3lVTuqbTKidVY9Z8oZ+xxMq6PTqkUJ9mZ
   bLhUmX+XRVSYSdkv5soiVnBzURfE1uGBWF4tJgTAfbs2wFWjKihfltB2W
   4Kg9nUSqF3HqTNZcHf11NgZIKCC8uTQM7qEJ3rHQdktpcPCMhGXvDVKt8
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10291"; a="237259110"
X-IronPort-AV: E=Sophos;i="5.90,194,1643702400"; 
   d="scan'208";a="237259110"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 10:22:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,194,1643702400"; 
   d="scan'208";a="517823725"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 19 Mar 2022 10:22:27 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nVcmY-000G9q-BR; Sat, 19 Mar 2022 17:22:26 +0000
Date:   Sun, 20 Mar 2022 01:21:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: arch/powerpc/include/asm/kvm_ppc.h:978:1: sparse: sparse: incorrect
 type in assignment (different base types)
Message-ID: <202203200152.tnHtopvO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   34e047aa16c0123bbae8e2f6df33e5ecc1f56601
commit: d991bb1c8da842a2a0b9dc83b1005e655783f861 include/linux/compiler-gcc.h: sparse can do constant folding of __builtin_bswap*()
date:   11 months ago
config: powerpc64-randconfig-s031-20220319 (https://download.01.org/0day-ci/archive/20220320/202203200152.tnHtopvO-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/kvm/

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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
