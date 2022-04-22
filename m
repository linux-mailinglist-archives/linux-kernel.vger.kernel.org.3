Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD5A50C3A6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbiDVWfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233266AbiDVWeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:34:31 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD7524A107
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 14:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650662834; x=1682198834;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yvEmm3q5zs9POqKdsIu+eEbpwdiEBwUZG5UoQU3is80=;
  b=Z7y3+V8yjuF/NYZZIVQnLz9w9ULXN7QcakQOWEdwcYZI9ueqjMW8FOcC
   d5ud8A8Wy9w/keJO5oSuXkKYZFkyFQHi7/NrUucDh9Wxo6TJ2JYmoltcT
   XkfK/EuKBg1vZ6eJMnsIwvkexlDRJyn/j1/h9CUCkCgAw4Ifi/VrfhFWF
   erjEH9DFhTR0xpjAKLgcI+x04oFvgeVWBR4CdxF+FuBdy27rT0Tp8A7sJ
   bRYwXl3CYYetzwV34Z74eYkllTgDzEYmJSJBesZ+6XXzZ8gxfIjUlupxE
   QuV/Sq6BpNNOgHzMStetJMQ1JKiTfEzUYHuoE7p7uuzb17+g+PVp04yNV
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="246685903"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="246685903"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 13:39:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="511729153"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 22 Apr 2022 13:39:12 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ni03c-000AZO-08;
        Fri, 22 Apr 2022 20:39:12 +0000
Date:   Sat, 23 Apr 2022 04:38:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matteo Croce <mcroce@microsoft.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>
Subject: [esmil:visionfive 4/54] mm/kasan/shadow.c:42:7: warning: no previous
 prototype for function 'memset'
Message-ID: <202204230424.eOU8iNAQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/esmil/linux visionfive
head:   68fe13e37af4c8331cdd40841353c9725cb65925
commit: 20157c7f08403f9a7cbaef427717ce571387416c [4/54] riscv: optimized memset
config: riscv-randconfig-c006-20220422 (https://download.01.org/0day-ci/archive/20220423/202204230424.eOU8iNAQ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5bd87350a5ae429baf8f373cb226a57b62f87280)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/esmil/linux/commit/20157c7f08403f9a7cbaef427717ce571387416c
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout 20157c7f08403f9a7cbaef427717ce571387416c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
