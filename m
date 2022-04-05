Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6291F4F2273
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 07:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiDEFLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 01:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiDEFLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 01:11:46 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F28C4BFFA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 22:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649135389; x=1680671389;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uml1BPu3EYtTMbgd2WGuq3w4iq6M/GD0ogJulQUKtjY=;
  b=ZP0qHd79JRN91YvDv3Wfjyexi9psZUHHZoy+BVJw790DhkuFEL/4tN78
   PMljlbyOhYX8j11rlRLSdglB4KwoWmz7AYr0iLUG8x4H+dg9ICM5iOwUM
   x8QDe4GPAdEfSeC8fJwdwgH/Aa8LSTO9la8ZzLcZRPwhuR/lyZzjnWxRR
   idWvL+kdCTJVwRB7jeWyrkyz4fImEAyGbI4nwccP9sXmqQa1UeKasqYqR
   677rv+lzVZ3I5xXP7wcjthWawBmzO63WwJ9jY1fcj1uHvdE4DnUfBMGHT
   T2Ct/tJmSFuyk3AM09tRW7ZVrXfOoAeKjFKLIPztgAX8O+w7bQoNlVmeH
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="240602591"
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="240602591"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 22:09:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="721909358"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 04 Apr 2022 22:09:45 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbbRo-0002eh-L6;
        Tue, 05 Apr 2022 05:09:44 +0000
Date:   Tue, 5 Apr 2022 13:09:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 8/40]
 fs/netfs/misc.c:18:46: warning: format specifies type 'unsigned long' but
 the argument has type 'size_t' (aka 'unsigned int')
Message-ID: <202204051354.4g0Q01jJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-maple
head:   674eea41fc70a740ff83ec590f9833f805852464
commit: cae8dd85733f703374474ed433b8263263d4fa7f [8/40] netfs: Provide invalidatepage and releasepage calls
config: i386-randconfig-a015 (https://download.01.org/0day-ci/archive/20220405/202204051354.4g0Q01jJ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c4a1b07d0979e7ff20d7d541af666d822d66b566)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/cae8dd85733f703374474ed433b8263263d4fa7f
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout cae8dd85733f703374474ed433b8263263d4fa7f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/netfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/netfs/misc.c:18:46: warning: format specifies type 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
           _enter("{%lx},%lx,%lx", folio_index(folio), offset, length);
                         ~~~                           ^~~~~~
                         %zx
   fs/netfs/internal.h:164:65: note: expanded from macro '_enter'
   #define _enter(FMT, ...) no_printk("==> %s("FMT")", __func__, ##__VA_ARGS__)
                                               ~~~                 ^~~~~~~~~~~
   include/linux/printk.h:132:17: note: expanded from macro 'no_printk'
                   printk(fmt, ##__VA_ARGS__);             \
                          ~~~    ^~~~~~~~~~~
   include/linux/printk.h:446:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:418:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   fs/netfs/misc.c:18:54: warning: format specifies type 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
           _enter("{%lx},%lx,%lx", folio_index(folio), offset, length);
                             ~~~                               ^~~~~~
                             %zx
   fs/netfs/internal.h:164:65: note: expanded from macro '_enter'
   #define _enter(FMT, ...) no_printk("==> %s("FMT")", __func__, ##__VA_ARGS__)
                                               ~~~                 ^~~~~~~~~~~
   include/linux/printk.h:132:17: note: expanded from macro 'no_printk'
                   printk(fmt, ##__VA_ARGS__);             \
                          ~~~    ^~~~~~~~~~~
   include/linux/printk.h:446:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:418:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   2 warnings generated.


vim +18 fs/netfs/misc.c

    10	
    11	/*
    12	 * Invalidate part or all of a folio
    13	 * - release a folio and clean up its private data if offset is 0 (indicating
    14	 *   the entire folio)
    15	 */
    16	void netfs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
    17	{
  > 18		_enter("{%lx},%lx,%lx", folio_index(folio), offset, length);
    19	
    20		folio_wait_fscache(folio);
    21	}
    22	EXPORT_SYMBOL(netfs_invalidate_folio);
    23	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
