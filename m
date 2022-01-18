Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB52492FC6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 21:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349385AbiARUz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 15:55:56 -0500
Received: from mga12.intel.com ([192.55.52.136]:55240 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245609AbiARUzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 15:55:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642539355; x=1674075355;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=c0Wx0qMDMQrNOCbtVuALSnZvEEoaR+sAHxwWQ9xljOY=;
  b=PyYVt85rkSQ/wLabSKTDrSk0yw6Rotjbe5x7qbIWjKMOqn6g6gO8jMTx
   etdd11VaJxnvMy77uWjNAWmyNrM74vuph6fB2wah86HFA0bdPf4y7KyAT
   VAGGpUEkup60GIqPS9fMYCBvVs2xi07rnPl19P/EYFwjlbcQDOYfkTiRG
   tkQkV27iycZB4WOAIP7shFLYebuvGOV2FuNhVhdfwiAEdnbvpQpBoipi+
   NgSFvFKHQogYuJP7OdB/jTa6qQYy8mBdS1itc4YdkGHYucTecNpagPFtj
   J5paC7B4fjzWLrznIQcxQAP7RGajFXeb+l5b43LX92Gy7M3kKAChDqeXt
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="224890633"
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="224890633"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 12:55:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="474893151"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 18 Jan 2022 12:55:07 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9vVT-000Cx3-9D; Tue, 18 Jan 2022 20:55:07 +0000
Date:   Wed, 19 Jan 2022 04:54:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matteo Croce <mcroce@microsoft.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>
Subject: [esmil:visionfive-5.16.y 22/80] mm/kasan/shadow.c:42:7: warning: no
 previous prototype for function 'memset'
Message-ID: <202201190447.MTj18zPA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/esmil/linux visionfive-5.16.y
head:   eeeb46a916e77aecbe1699537a5592746f3130f6
commit: 6348ed9f5269d38acf552123e96766aa2eb0fd7e [22/80] riscv: optimized memset
config: riscv-randconfig-c006-20220118 (https://download.01.org/0day-ci/archive/20220119/202201190447.MTj18zPA-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project c10cbb243cafc0cf42c3e922cb29183279444432)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/esmil/linux/commit/6348ed9f5269d38acf552123e96766aa2eb0fd7e
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive-5.16.y
        git checkout 6348ed9f5269d38acf552123e96766aa2eb0fd7e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash mm/kasan/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> mm/kasan/shadow.c:42:7: warning: no previous prototype for function 'memset' [-Wmissing-prototypes]
   void *memset(void *addr, int c, size_t len)
         ^
   mm/kasan/shadow.c:42:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void *memset(void *addr, int c, size_t len)
   ^
   static 
   mm/kasan/shadow.c:63:7: warning: no previous prototype for function 'memcpy' [-Wmissing-prototypes]
   void *memcpy(void *dest, const void *src, size_t len)
         ^
   mm/kasan/shadow.c:63:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void *memcpy(void *dest, const void *src, size_t len)
   ^
   static 
   2 warnings generated.


vim +/memset +42 mm/kasan/shadow.c

bb359dbcb70085 Andrey Konovalov 2020-12-22  40  
bb359dbcb70085 Andrey Konovalov 2020-12-22  41  #undef memset
bb359dbcb70085 Andrey Konovalov 2020-12-22 @42  void *memset(void *addr, int c, size_t len)
bb359dbcb70085 Andrey Konovalov 2020-12-22  43  {
f00748bfa0246c Andrey Konovalov 2021-02-24  44  	if (!kasan_check_range((unsigned long)addr, len, true, _RET_IP_))
bb359dbcb70085 Andrey Konovalov 2020-12-22  45  		return NULL;
bb359dbcb70085 Andrey Konovalov 2020-12-22  46  
bb359dbcb70085 Andrey Konovalov 2020-12-22  47  	return __memset(addr, c, len);
bb359dbcb70085 Andrey Konovalov 2020-12-22  48  }
bb359dbcb70085 Andrey Konovalov 2020-12-22  49  

:::::: The code at line 42 was first introduced by commit
:::::: bb359dbcb70085a63e8bdbf14837a900750f0cf7 kasan: split out shadow.c from common.c

:::::: TO: Andrey Konovalov <andreyknvl@google.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
