Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833E450C36E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbiDVWde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbiDVWcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:32:48 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF59C2BEE86
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 14:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650662771; x=1682198771;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QfNomZr+Hbt7a22Y7Ges48xOi81Xmv+RlfRmG33O10M=;
  b=FmnsBBFqvRVC6hl51VgC+SMfrdtx6NEtvWfRXuFYFFZBlXJqs27pBEqS
   I80566DgXz7NMbbApOttA1Ax4og5nGWHFEmiQclYhR0AoZFDxSc0T7h5c
   Qz1WV8GZRFYTJgEqpSR9Y05hHoksm+37G5XhB3DbzaI3QgBsApkz/c6lZ
   f9rR82gB1XzVc1J/cwL+u1hbFsWeo5VFCM7p6iVl9SO0wM10CMAsoVM1N
   IH9PTAknVglnzb24GYCXEQYIRaOsEkUEYITeEF9wF4uSVpBqDJyRMKf+y
   I4QljEFstpy3/ddEX/sbaVMpG44a9+tHDv86wm2y3zUzdgK1X48ePtp6d
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="245341890"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="245341890"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 12:48:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="648759700"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Apr 2022 12:48:09 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhzGB-000AX4-Ru;
        Fri, 22 Apr 2022 19:48:07 +0000
Date:   Sat, 23 Apr 2022 03:47:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matteo Croce <mcroce@microsoft.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>
Subject: [esmil:visionfive 4/54] mm/kasan/shadow.c:42:7: warning: no previous
 prototype for 'memset'
Message-ID: <202204230354.4aerM2gz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/esmil/linux visionfive
head:   68fe13e37af4c8331cdd40841353c9725cb65925
commit: 20157c7f08403f9a7cbaef427717ce571387416c [4/54] riscv: optimized memset
config: riscv-randconfig-c003-20220422 (https://download.01.org/0day-ci/archive/20220423/202204230354.4aerM2gz-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/esmil/linux/commit/20157c7f08403f9a7cbaef427717ce571387416c
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout 20157c7f08403f9a7cbaef427717ce571387416c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash mm/kasan/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> mm/kasan/shadow.c:42:7: warning: no previous prototype for 'memset' [-Wmissing-prototypes]
      42 | void *memset(void *addr, int c, size_t len)
         |       ^~~~~~
   mm/kasan/shadow.c:63:7: warning: no previous prototype for 'memcpy' [-Wmissing-prototypes]
      63 | void *memcpy(void *dest, const void *src, size_t len)
         |       ^~~~~~


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
