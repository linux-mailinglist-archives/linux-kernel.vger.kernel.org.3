Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B7B49335D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 04:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351205AbiASDLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 22:11:22 -0500
Received: from mga01.intel.com ([192.55.52.88]:52516 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242118AbiASDLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 22:11:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642561877; x=1674097877;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lgJIsceIi8P73zV5GUIZ5gix6UKZFSUmYT/SR1iLMx8=;
  b=NbqTFF0FL/UGqdTlvDCaZanPHmP4SZXGfpYVoDoxPtNu9D/d6c4ZtGB3
   Abmh/6aDQiVgzhGv/vAkWTex5oia81wl41vEMQ7A1CBBLxrDHBMQJpn5M
   lG9RFtD0StN4KMz+crEx6YeNUUIJMNA1Z5csAFCqKJABHr8bGHfPRX/MO
   hutQOEkvaU9ybrKsZuSNj/Rpi8f2kXlys+IpFOa+BIBDhLvJiHMjXJJJG
   38WLlNlMIabbUTe5rIdLOa2Xta0JSWMk21sWaEuTTNeqoe7aehZMR2L28
   rMJtl3pXHcJk8HXKhobnZuIWJsBNLAllOyviX3yKLjsuqL8S1nGfWaSDg
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="269358045"
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="269358045"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 19:11:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="625729681"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 18 Jan 2022 19:11:15 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nA1NS-000DCC-NH; Wed, 19 Jan 2022 03:11:14 +0000
Date:   Wed, 19 Jan 2022 11:11:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matteo Croce <mcroce@microsoft.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>
Subject: [esmil:visionfive 21/80] mm/kasan/shadow.c:42:7: warning: no
 previous prototype for function 'memset'
Message-ID: <202201191137.T7TQVMwU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/esmil/linux visionfive
head:   e46c3a7e373e6faa03399f1a41c29cf7546c37cb
commit: 55f013c0bc3e224cf34271c3cc11f7443b11553f [21/80] riscv: optimized memset
config: riscv-randconfig-r042-20220118 (https://download.01.org/0day-ci/archive/20220119/202201191137.T7TQVMwU-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project f7b7138a62648f4019c55e4671682af1f851f295)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/esmil/linux/commit/55f013c0bc3e224cf34271c3cc11f7443b11553f
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout 55f013c0bc3e224cf34271c3cc11f7443b11553f
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
