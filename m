Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499FB50C53B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbiDVXq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 19:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiDVXqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 19:46:23 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703ABDAA26
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 16:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650671008; x=1682207008;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dDU4iKhGOx8XIlt8ACnIqfCyaHJ/NN89i4SEVVCvsQc=;
  b=CHtl2Z04Hik8BBYg4kfo/92ECnuZqSrPbTQoHAoMXQBYaU6FkmgZzJcp
   vvH4+hbVKG79gAeerWUxBhyTUGx1+ch1RiMOxNQFXV7oXrwlEBtrJiD8Y
   NfK43dRvVFC0yb7Gah9vZUVn0m9Iy9uJ5bF7cBt8cXWZljb7BU+g8YYbg
   QnvsyWeEisWJ5Q376ydj5Rn2G/Fwp42ifUFWhJiUrcM+9eLFLPumDWCkH
   CVg/FfXLfQKrM4WznKZYoUmSVImwi3mmkllTQU/Xh8evSi/OmYxz8WU3+
   RRdIOXfATlIMf+5j1nHLWSF7STwUZYJX9y2N+hd/sK9OBmYTYdgu5jI19
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="252145974"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="252145974"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 16:43:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="728738665"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 22 Apr 2022 16:43:26 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ni2vt-000Afr-SM;
        Fri, 22 Apr 2022 23:43:25 +0000
Date:   Sat, 23 Apr 2022 07:42:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 35/44]
 fs/netfs/buffered_write.c:28:26: warning: comparison of distinct pointer
 types ('typeof (((1UL) << (12)) - offset) *' (aka 'unsigned long *') and
 'typeof (size) *' (aka 'unsigned int *'))
Message-ID: <202204230702.idwNNJoq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-maple
head:   931e50676c6598d0eda1954ead465519ff91874d
commit: f343507aeda88b2f1a528a659b8fadaa9b6b0f79 [35/44] netfs: Implement buffered writes through netfs_file_write_iter()
config: riscv-randconfig-r042-20220422 (https://download.01.org/0day-ci/archive/20220423/202204230702.idwNNJoq-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5bd87350a5ae429baf8f373cb226a57b62f87280)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/f343507aeda88b2f1a528a659b8fadaa9b6b0f79
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout f343507aeda88b2f1a528a659b8fadaa9b6b0f79
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash fs/netfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/netfs/buffered_write.c:28:26: warning: comparison of distinct pointer types ('typeof (((1UL) << (12)) - offset) *' (aka 'unsigned long *') and 'typeof (size) *' (aka 'unsigned int *')) [-Wcompare-distinct-pointer-types]
                   unsigned int psize   = min(PAGE_SIZE - offset, size);
                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:45:19: note: expanded from macro 'min'
   #define min(x, y)       __careful_cmp(x, y, <)
                           ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: expanded from macro '__careful_cmp'
           __builtin_choose_expr(__safe_cmp(x, y), \
                                 ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:26:4: note: expanded from macro '__safe_cmp'
                   (__typecheck(x, y) && __no_side_effects(x, y))
                    ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:20:28: note: expanded from macro '__typecheck'
           (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                      ~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~
   fs/netfs/buffered_write.c:94:18: warning: comparison of distinct pointer types ('typeof (target->from) *' (aka 'unsigned long long *') and 'typeof (folio_pos(folio) + offset) *' (aka 'long long *')) [-Wcompare-distinct-pointer-types]
           target->from  = min(target->from, folio_pos(folio) + offset);
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:45:19: note: expanded from macro 'min'
   #define min(x, y)       __careful_cmp(x, y, <)
                           ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: expanded from macro '__careful_cmp'
           __builtin_choose_expr(__safe_cmp(x, y), \
                                 ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:26:4: note: expanded from macro '__safe_cmp'
                   (__typecheck(x, y) && __no_side_effects(x, y))
                    ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:20:28: note: expanded from macro '__typecheck'
           (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                      ~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~
   fs/netfs/buffered_write.c:95:18: warning: comparison of distinct pointer types ('typeof (target->to) *' (aka 'unsigned long long *') and 'typeof (folio_pos(folio) + offset + len) *' (aka 'long long *')) [-Wcompare-distinct-pointer-types]
           target->to    = max(target->to,   folio_pos(folio) + offset + len);
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:52:19: note: expanded from macro 'max'
   #define max(x, y)       __careful_cmp(x, y, >)
                           ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: expanded from macro '__careful_cmp'
           __builtin_choose_expr(__safe_cmp(x, y), \
                                 ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:26:4: note: expanded from macro '__safe_cmp'
                   (__typecheck(x, y) && __no_side_effects(x, y))
                    ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:20:28: note: expanded from macro '__typecheck'
           (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                      ~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~
   fs/netfs/buffered_write.c:254:36: warning: format specifies type 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
           _enter("e=%llx o=%lx l=%lx", end, offset, len);
                            ~~~              ^~~~~~
                            %zx
   fs/netfs/internal.h:270:65: note: expanded from macro '_enter'
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
   fs/netfs/buffered_write.c:254:44: warning: format specifies type 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
           _enter("e=%llx o=%lx l=%lx", end, offset, len);
                                  ~~~                ^~~
                                  %zx
   fs/netfs/internal.h:270:65: note: expanded from macro '_enter'
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
   5 warnings generated.


vim +28 fs/netfs/buffered_write.c

    18	
    19	static size_t copy_folio_from_iter_atomic(struct folio *folio,
    20						  unsigned int offset, size_t size,
    21						  struct iov_iter *i)
    22	{
    23		size_t copied = 0, n;
    24	
    25		do {
    26			unsigned int index   = offset / PAGE_SIZE;
    27			unsigned int poffset = offset % PAGE_SIZE;
  > 28			unsigned int psize   = min(PAGE_SIZE - offset, size);
    29	
    30			n = copy_page_from_iter_atomic(folio_file_page(folio, index),
    31						       poffset, psize, i);
    32			copied += n;
    33			if (n < psize)
    34				break;
    35			size -= n;
    36		} while (size);
    37		return copied;
    38	}
    39	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
